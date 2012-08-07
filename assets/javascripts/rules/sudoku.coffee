rules = (grid) ->
  return colsAreValid(grid)

colsAreValid = (grid) ->
  for col in [0...grid.cols]

    found = []

    for row in [0...grid.rows]
      value = grid.getCell(row, col)

      if value in found
        console.log("row: #{row}, col: #{col}, value: #{value}")
        return false
      else
        if value?
          found.push(value)

  return true

module.exports = rules
