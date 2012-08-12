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
    newRow = @curRow
    newCol = @curCol

    newRow += 1

    if newRow >= @grid.rows
      newRow = 0
      newCol += 1

    if newCol >= @grid.cols
      newCol = 0
      
    @setCurrent(newRow, newCol)

module.exports = PuzzleGridUI
