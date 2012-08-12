PuzzleGridUI = require('../assets/javascripts/puzzle_grid_ui')
PuzzleGrid = require('../assets/javascripts/puzzle_grid')

describe 'puzzle grid UI', ->

  beforeEach ->
    @grid = new PuzzleGrid(3, 3)
    @ui = new PuzzleGridUI(@grid)

  it 'should default the current square to the top left corner', ->
    expect(@ui.getCurrent()).toEqual([0, 0])

  it 'should allow the current square to be set', ->
    @ui.setCurrent(2, 2)
    expect(@ui.getCurrent()).toEqual([2, 2])

  it 'should not allow the current square to be outside the underlying grid', ->
    expect(=> @ui.setCurrent(3, 3)).toThrow('InvalidCurrentSquareException')

  describe 'the next function', ->
    it 'should move to the righthand entry in a row if there is one', ->
      expect(@ui.getCurrent()).toEqual([0, 0])
      @ui.next()
      expect(@ui.getCurrent()).toEqual([1, 0])
      @ui.next()
      expect(@ui.getCurrent()).toEqual([2, 0])

    it 'should wrap around to the next row if at the end of a row', ->
      @ui.setCurrent(2, 0)
      @ui.next()
      expect(@ui.getCurrent()).toEqual([0, 1])
