class PuzzleGridUI
  constructor: (@grid) ->
    @curRow = 0
    @curCol = 0

  getCurrent: ->
    return [@curRow, @curCol]

  setCurrent: (row, col) ->
    if (
      row >= 0 and row < @grid.rows and
      col >= 0 and col < @grid.cols
    )
      @curRow = row
      @curCol = col
    else
      throw 'InvalidCurrentSquareException'

  next: ->
    @curRow += 1
    return [1, 0]

module.exports = PuzzleGridUI
