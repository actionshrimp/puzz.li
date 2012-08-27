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

  it 'should have as many rows in its buffer as there are in the underlying grid', ->
    grid = $(@renderer.buffer)

    allRows = $('.puzzle-grid-row', grid)
    expect(allRows.length).toEqual(@size)

  it 'should give the actual grid the right class', ->
    grid = $(@renderer.buffer)
    expect(grid.hasClass('puzzle-grid')).toBeTruthy()

  it 'should render values inside cells', ->
    value = 5

    @grid.setCell(0, 0, value)
    grid = $(@renderer.buffer)

    firstCell = $('.puzzle-grid-cell', grid).first()

    expect($('.puzzle-grid-cell-value', firstCell).html()).toEqual("" + value)
