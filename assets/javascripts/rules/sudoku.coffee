rules = (grid) ->
  return (
    colsAreValid(grid) and
    rowsAreValid(grid) and
    allSubSquaresAreValid(grid))

#Check no number occurs twice in a row
rowsAreValid = (grid) ->
  return lineIsValid(grid.rows, grid.cols, grid.getCell)

#Check no number occurs twice in a column
colsAreValid = (grid) ->
  return lineIsValid(grid.cols, grid.rows, grid.getCellT)

#Check a particular straight line in the grid is valid
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

#Check no number occurs twice in all subsquares,
#by checking all subsquares individually
allSubSquaresAreValid = (grid) ->
  subSquareSize = Math.sqrt(grid.rows)

  for x in [0...subSquareSize]
    startRow = x*subSquareSize

    for y in [0...subSquareSize]
      startCol = y*subSquareSize

      if !subSquareIsValid(grid, startRow, startCol, subSquareSize)
        return false

  return true

#Check no number occurs twice in a particular subsquare
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

#Return sudoku rules if the grid is a valid size for sudoku
rulesBuilder = (grid) ->

  if !(isSquare(grid) and hasSubSquares(grid))
    throw 'InvalidGridException'

  return rules

isSquare = (grid) ->
  return (grid.rows == grid.cols)

hasSubSquares = (grid) ->
  return (Math.round(Math.sqrt(grid.rows)) == Math.sqrt(grid.rows))

module.exports = rulesBuilder
