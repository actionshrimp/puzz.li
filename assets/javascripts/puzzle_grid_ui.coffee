class PuzzleGridUI
  constructor: (@grid) ->
    @curY = 0
    @curX = 0

  getCurrent: ->
    return [@curX, @curY]

  setCurrent: (x, y) ->
    if (
      x >= 0 and x < @grid.cols and
      y >= 0 and y < @grid.rows
    )
      @curX = x
      @curY = y
    else
      throw 'InvalidCurrentSquareException'

  next: ->
    newX = @curX
    newY = @curY

    newX += 1

    if newX >= @grid.cols
      newX = 0
      newY += 1

    if newY >= @grid.rows
      newY = 0
      
    @setCurrent(newX, newY)

  right: ->
    newX = @curX + 1
    if newX < @grid.cols
      @setCurrent(newX, @curY)

  left: ->
    newX = @curX - 1
    if newX >= 0
      @setCurrent(newX, @curY)

module.exports = PuzzleGridUI
