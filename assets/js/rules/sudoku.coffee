BaseRules = require('./base')

class SudokuRules extends BaseRules
  isSquare: () ->
    return (@grid.rows == @grid.cols)

  hasSubSquares: () ->
    return (Math.round(Math.sqrt(@grid.rows)) == Math.sqrt(@grid.rows))
  validateInitial: () ->
    if !(@isSquare() and @hasSubSquares())
      throw 'InvalidGridException'

  validateGridValues: () ->
    return (
      @colsAreValid() and
      @rowsAreValid() and
      @allSubSquaresAreValid()
    )

  #Check no number occurs twice in a column
  colsAreValid: () ->
    return @lineIsValid(@grid.cols, @grid.rows, @grid.getCell)

  #Check no number occurs twice in a row
  rowsAreValid: () ->
    return @lineIsValid(@grid.rows, @grid.cols, @grid.getCellT)

  #Check a particular straight line in the grid is valid
  lineIsValid: (outerScan, innerScan, valueGetter) ->
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
  allSubSquaresAreValid: () ->
    subSquareSize = Math.sqrt(@grid.rows)

    for x in [0...subSquareSize]
      startRow = x*subSquareSize

      for y in [0...subSquareSize]
        startCol = y*subSquareSize

        if !@subSquareIsValid(startRow, startCol, subSquareSize)
          return false

    return true

  #Check no number occurs twice in a particular subsquare
  subSquareIsValid: (startRow, startCol, squareSize) ->
    found = []

    for row in [startRow...(startRow+squareSize)]
      for col in [startCol...(startCol+squareSize)]

        value = @grid.getCell(row, col)

        if value in found
          return false
        else
          if value?
            found.push(value)

    return true

module.exports = SudokuRules
