class PuzzleGridUI
  constructor: (@grid) ->
    @curRow = 0
    @curCol = 0

  getCurrent: ->
    return [@curCol, @curRow]

  setCurrent: (col, row) ->
    if (
      col >= 0 and col < @grid.cols and
      row >= 0 and row < @grid.rows
    )
      @curCol = col
      @curRow = row
    else
      throw 'InvalidCurrentSquareException'

  next: ->
    newCol = @curCol
    newRow = @curRow

    newCol += 1

    if newCol >= @grid.cols
      newCol = 0
      newRow += 1

    if newRow >= @grid.rows
      newRow = 0
      
    @setCurrent(newCol, newRow)

  right: ->
    newCol = @curCol + 1
    if newCol < @grid.cols
      @setCurrent(newCol, @curRow)

module.exports = PuzzleGridUI
