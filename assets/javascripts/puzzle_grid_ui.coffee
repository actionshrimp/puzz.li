class PuzzleGridUI
  constructor: (@grid) ->
    @current = [0, 0]

  getCurrent: () ->
    return @current

  setCurrent: (row, col) ->
    @current = [row, col]

module.exports = PuzzleGridUI
