rules = (grid) ->
  return (colsAreValid(grid) and rowsAreValid(grid))

colsAreValid = (grid) ->
  for col in [0...grid.cols]

    found = []

    for row in [0...grid.rows]
      value = grid.getCell(row, col)

      if value in found
        return false
      else
        if value?
          found.push(value)

  return true

rowsAreValid = (grid) ->
  for row in [0...grid.rows]

    found = []

    for col in [0...grid.cols]
      value = grid.getCell(row, col)

      if value in found
        return false
      else
        if value?
          found.push(value)

  return true

module.exports = rules
