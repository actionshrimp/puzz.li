window = require('jsdom').jsdom().createWindow()
$ = require('jquery')

PuzzleGrid = require('../../assets/js/puzzle_grid')
PuzzleGridUI = require('../../assets/js/puzzle_grid_ui')
PuzzleGridRenderer = require('../../assets/js/puzzle_grid_renderer')

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
    $allCells = $('.puzzle-grid-cell', @renderedGrid)
    expect($allCells.length).toEqual(@size * @size)

  it 'should give the actual grid the right class', ->
    expect(@renderedGrid.hasClass('puzzle-grid')).toBeTruthy()

  it 'should render values inside cells', ->
    value = 5
    @grid.setCell(0, 0, value)
    firstCell = $('.puzzle-grid-cell', @renderedGrid).first()

    expect($('.puzzle-grid-cell-value', firstCell).html()).toEqual("" + value)

    value2 = 3; row = 1; col = 2
    @grid.setCell(col, row, value2)
    pos = @size * row + col
    $cell = $('.puzzle-grid-cell', @renderedGrid).eq(pos)

    expect($('.puzzle-grid-cell-value', $cell).html()).toEqual("" + value2)

  it 'should render the null cell for a cell with no value', ->
    row = 2; col = 1
    pos = @size * row + col
    $cell = $('.puzzle-grid-cell', @renderedGrid).eq(pos)

    expect($('.puzzle-grid-cell-null', $cell).length).toEqual(1)

  it 'should notify subscribers about a render event', ->
    spy = jasmine.createSpy('renderListener')
    @renderer.onRender(spy)
    @renderer.render()

    expect(spy).toHaveBeenCalledWith(@renderer.buffer)

  it 'should highlight the currently selected square in the UI class', ->
    @ui.setCurrent(2, 1)
    $row = $('.puzzle-grid-row', @renderedGrid).eq(1)
    $cell = $('.puzzle-grid-cell', $row).eq(2)

    expect($cell.hasClass('puzzle-grid-selected')).toBeTruthy()
