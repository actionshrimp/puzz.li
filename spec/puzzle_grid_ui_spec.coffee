PuzzleGridUI = require('../assets/javascripts/puzzle_grid_ui')
PuzzleGrid = require('../assets/javascripts/puzzle_grid')

describe 'puzzle grid UI', ->

  beforeEach ->
    @grid = new PuzzleGrid(3, 3)
    @ui = new PuzzleGridUI(@grid)

  it 'should default the current square to the top left corner', ->
    expect(@ui.current()).toEqual([0, 0])
