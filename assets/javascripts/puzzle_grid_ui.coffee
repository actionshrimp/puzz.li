class PuzzleGridUI
  constructor: (@grid) ->
    @current = [0, 0]

  getCurrent: () ->
    return @current

  setCurrent: (row, col) ->
    if (row >= 0 and row < @grid.rows and col >= 0 and col < @grid.cols)
      @current = [row, col]
    else
      throw 'InvalidCurrentSquareException'

module.exports = PuzzleGridUI
