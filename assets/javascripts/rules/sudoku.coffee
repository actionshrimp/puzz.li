rules = (grid) ->
  subSquareSize = Math.sqrt(grid.rows)

  return (
    colsAreValid(grid) and
    rowsAreValid(grid) and
    allSubSquaresAreValid(grid, subSquareSize))

rowsAreValid = (grid) ->
  return lineIsValid(grid.rows, grid.cols, grid.getCell)

colsAreValid = (grid) ->
  return lineIsValid(grid.cols, grid.rows, grid.getCellT)

lineIsValid = (outerScan, innerScan, valueGetter) ->
  for u in [0...outerScan]
    found = []

    for v in [0...innerScan]
      value = valueGetter(u, v)

      if value in found
        return false
      else
        if value?
          found.push(value)

  return true

allSubSquaresAreValid = (grid, subSquareSize) ->
  for x in [0...subSquareSize]
    startRow = x*subSquareSize

    for y in [0...subSquareSize]
      startCol = y*subSquareSize

      if !subSquareIsValid(grid, startRow, startCol, subSquareSize)
        return false

  return true

subSquareIsValid = (grid, startRow, startCol, squareSize) ->
  found = []

  for row in [startRow...(startRow+squareSize)]
    for col in [startCol...(startCol+squareSize)]

      value = grid.getCell(row, col)

      if value in found
        return false
      else
        if value?
          found.push(value)

  return true

rulesBuilder = (grid) ->
  if (
    (grid.rows == grid.cols) and
    (Math.round(Math.sqrt(grid.rows)) == Math.sqrt(grid.rows))
  )
    return rules
  else
    throw 'InvalidGridException'

module.exports = rulesBuilder
