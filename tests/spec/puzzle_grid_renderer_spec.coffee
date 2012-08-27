window = require('jsdom').jsdom().createWindow()
$ = require('jquery')

PuzzleGrid = require('../../assets/javascripts/puzzle_grid')
PuzzleGridRenderer = require('../../assets/javascripts/puzzle_grid_renderer')

describe 'puzzle grid renderer', ->

  beforeEach ->
    @size = 3
    @grid = new PuzzleGrid(@size, @size)
    @renderer = new PuzzleGridRenderer(@grid)

  it 'should have as many cells in its buffer as there are in the underlying grid', ->

    grid = $(@renderer.buffer)

    allCells = $('.puzzle-grid-cell', grid)
    expect(allCells.length).toEqual(@size * @size)
