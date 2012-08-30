BaseRules = require('./base')

class SudokuRules extends BaseRules
  constructor: (@allowedValues) ->

  initialValidate: (grid) ->
    if !(@isSquare(grid) and @hasSubSquares(grid))
      throw 'InvalidGridException'

  isSquare: (grid) ->
    return (grid.rows == grid.cols)

  hasSubSquares: (grid) ->
    return (Math.round(Math.sqrt(grid.rows)) == Math.sqrt(grid.rows))

  validateGridState: (grid) ->
    @validateValues(grid)
    @validateCols(grid)
    @validateRows(grid)
    @validateSubSquares(grid)

  validateValues: (grid) ->
    for x in [0...grid.cols]
      for y in [0...grid.rows]
        value = grid.getCell(x, y)
        if value?
          if !@allowedValues.test(value)
            throw 'InvalidValueException'

  #Check no number occurs twice in a column
  validateCols: (grid) ->
    try
      @validateLine(grid.cols, grid.rows, grid.getCell)
    catch e
      throw 'InvalidColumnException'

  #Check no number occurs twice in a row
  validateRows: (grid) ->
    try
      @validateLine(grid.rows, grid.cols, grid.getCellT)
    catch e
      throw 'InvalidRowException'

  #Check a particular straight line in the grid is valid
  validateLine: (outerScan, innerScan, valueGetter) ->
    for u in [0...outerScan]
      found = []

      for v in [0...innerScan]
        value = valueGetter(u, v)

        #Confirm value doesn't exist already in this line
        if value in found
          throw 'InvalidLineException'
        else
          if value?
            found.push(value)

  #Check no number occurs twice in all subsquares,
  #by checking all subsquares individually
  validateSubSquares: (grid) ->
    subSquareSize = Math.sqrt(grid.rows)

    for x in [0...subSquareSize]
      startRow = x*subSquareSize

      for y in [0...subSquareSize]
        startCol = y*subSquareSize

        if not @subSquareIsValid(grid, startRow, startCol, subSquareSize)
          throw 'InvalidSubSquareException'

  #Check no number occurs twice in a particular subsquare
  subSquareIsValid: (grid, startRow, startCol, squareSize) ->
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

module.exports = SudokuRules
