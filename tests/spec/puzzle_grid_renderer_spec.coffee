window = require('jsdom').jsdom().createWindow()
$ = require('jquery')

PuzzleGrid = require('../../assets/javascripts/puzzle_grid')
PuzzleGridUI = require('../../assets/javascripts/puzzle_grid_ui')
PuzzleGridRenderer = require('../../assets/javascripts/puzzle_grid_renderer')

describe 'puzzle grid renderer', ->

  beforeEach ->
    @size = 3
    @grid = new PuzzleGrid(@size, @size)
    @ui = new PuzzleGridUI(@grid)
    @renderer = new PuzzleGridRenderer(@grid, @ui)

    @renderedGrid = $(@renderer.buffer)

    @renderer.onRender((buffer) =>
      @renderedGrid = $(buffer))

  it 'should have as many cells in its buffer as there are in the underlying grid', ->
    allCells = $('.puzzle-grid-cell', @renderedGrid)
    expect(allCells.length).toEqual(@size * @size)

  it 'should have as many rows in its buffer as there are in the underlying grid', ->
    allRows = $('.puzzle-grid-row', @renderedGrid)
    expect(allRows.length).toEqual(@size)

  it 'should give the actual grid the right class', ->
    expect(@renderedGrid.hasClass('puzzle-grid')).toBeTruthy()

  it 'should render values inside cells', ->
    value = 5
    @grid.setCell(0, 0, value)
    firstCell = $('.puzzle-grid-cell', @renderedGrid).first()

    expect($('.puzzle-grid-cell-value', firstCell).html()).toEqual("" + value)

  it 'should notify subscribers about a render event', ->
    spy = jasmine.createSpy('renderListener')
    @renderer.onRender(spy)
    @renderer.render()

    expect(spy).toHaveBeenCalledWith(@renderer.buffer)

  it 'should highlight the currently selected square in the UI class', ->
    @ui.setCurrent(2, 2)
    $row = $('.puzzle-grid-row', @renderedGrid).eq(2)
    $cell = $('.puzzle-grid-cell', $row).eq(2)

    expect($cell.hasClass('puzzle-grid-selected-cell')).toBeTruthy()
