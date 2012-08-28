PuzzleGridUI = require('../../assets/js/puzzle_grid_ui')
PuzzleGrid = require('../../assets/js/puzzle_grid')

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

    it 'should wrap around to the start if at the end of a row in the last row', ->
      @ui.setCurrent(2, 2)
      @ui.next()
      expect(@ui.getCurrent()).toEqual([0, 0])

  it 'should go right up to the edge of the grid', ->
    @ui.right()
    expect(@ui.getCurrent()).toEqual([1, 0])

    @ui.right()
    expect(@ui.getCurrent()).toEqual([2, 0])

    @ui.right()
    expect(@ui.getCurrent()).toEqual([2, 0])

  it 'should go left up to the edge of the grid', ->
    @ui.setCurrent(2, 1)

    @ui.left()
    expect(@ui.getCurrent()).toEqual([1, 1])

    @ui.left()
    expect(@ui.getCurrent()).toEqual([0, 1])
    
    @ui.left()
    expect(@ui.getCurrent()).toEqual([0, 1])

  it 'should go down up to the edge of the grid', ->
    @ui.down()
    expect(@ui.getCurrent()).toEqual([0, 1])

    @ui.down()
    expect(@ui.getCurrent()).toEqual([0, 2])

    @ui.down()
    expect(@ui.getCurrent()).toEqual([0, 2])

  it 'should go up up to the edge of the grid', ->
    @ui.setCurrent(2, 2)

    @ui.up()
    expect(@ui.getCurrent()).toEqual([2, 1])

    @ui.up()
    expect(@ui.getCurrent()).toEqual([2, 0])

    @ui.up()
    expect(@ui.getCurrent()).toEqual([2, 0])

  it 'should notify subscribers when the selected square changes', ->
    spy = jasmine.createSpy('currentUpdateListener')
    @ui.onCurrentUpdate(spy)
    @ui.setCurrent(2, 1)
    
    expect(spy).toHaveBeenCalledWith(2, 1)

