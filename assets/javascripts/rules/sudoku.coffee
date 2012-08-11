rules = (grid) ->
  return (colsAreValid(grid) and rowsAreValid(grid))

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

module.exports = rules
