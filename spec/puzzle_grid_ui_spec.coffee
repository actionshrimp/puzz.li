PuzzleGridUI = require('../assets/javascripts/puzzle_grid_ui')
PuzzleGrid = require('../assets/javascripts/puzzle_grid')

describe 'puzzle grid UI', ->

  beforeEach ->
    @grid = new PuzzleGrid(3, 3)
    @ui = new PuzzleGridUI(@grid)

  it 'should default the current square to the top left corner', ->
    expect(@ui.getCurrent()).toEqual([0, 0])

  it 'should allow the current square to be set', ->
    @ui.setCurrent(3, 3)
    expect(@ui.getCurrent()).toEqual([3, 3])
