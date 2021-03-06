class PuzzleGridUI
  constructor: (@grid) ->
    @curY = 0
    @curX = 0
    @currentUpdateListeners = []

  getCurrent: ->
    return [@curX, @curY]

  setCurrent: (x, y) ->
    if (
      x >= 0 and x < @grid.cols and
      y >= 0 and y < @grid.rows
    )
      @curX = x
      @curY = y

      @broadcastCurrentUpdate(@curX, @curY)
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
    try
      @setCurrent(@curX + 1, @curY)

  left: ->
    try
      @setCurrent(@curX - 1, @curY)

  down: ->
    try
      @setCurrent(@curX, @curY + 1)

  up: ->
    try
      @setCurrent(@curX, @curY - 1)

  onCurrentUpdate: (listener) =>
    @currentUpdateListeners.push(listener)

  broadcastCurrentUpdate: (x, y) =>
    for listener in @currentUpdateListeners
      listener(x, y)

module.exports = PuzzleGridUI
