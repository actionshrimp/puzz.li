window = require('jsdom').jsdom().createWindow()
$ = require('jquery')

PuzzleGrid = require('../../assets/js/puzzle_grid')
PuzzleGridUI = require('../../assets/js/puzzle_grid_ui')
PuzzleGridRenderer = require('../../assets/js/puzzle_grid_renderer')

selectRenderedCell = (grid, col, row) ->
  $(".puzzle-grid-cell.puzzle-grid-row-#{row}.puzzle-grid-col-#{col}", grid)

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

  it 'should create the correct number of columns', ->
    colClasses = []

    $allCells = $('.puzzle-grid-cell', @renderedGrid)

    for cell in $allCells
      classes = $(cell).attr('class').split(' ')
      for c in classes
        if (/^puzzle-grid-col-/.test(c)) and (c not in colClasses)
          colClasses.push(c)

  it 'should create the correct number of rows', ->
    rowClasses = []

    $allCells = $('.puzzle-grid-cell', @renderedGrid)

    for cell in $allCells
      classes = $(cell).attr('class').split(' ')
      for c in classes
        if (/^puzzle-grid-row-/.test(c)) and (c not in rowClasses)
          rowClasses.push(c)

    expect(rowClasses.length).toEqual(@size)

  it 'should render values inside cells', ->
    value = 5
    @grid.setCell(0, 0, value)
    firstCell = $('.puzzle-grid-cell', @renderedGrid).first()

    expect($('.puzzle-grid-cell-value', firstCell).html()).toEqual("" + value)

    value2 = 3; row = 1; col = 2
    @grid.setCell(col, row, value2)
    $cell = selectRenderedCell(@renderedGrid, col, row)

    expect($('.puzzle-grid-cell-value', $cell).html()).toEqual("" + value2)

  it 'should render the null cell for a cell with no value', ->
    row = 2; col = 1
    $cell = selectRenderedCell(@renderedGrid, col, row)

    expect($('.puzzle-grid-cell-null', $cell).length).toEqual(1)

  it 'should notify subscribers about a render event', ->
    spy = jasmine.createSpy('renderListener')
    @renderer.onRender(spy)
    @renderer.render()

    expect(spy).toHaveBeenCalledWith(@renderer.buffer)

  it 'should highlight the currently selected square in the UI class', ->
    col = 2; row = 1
    @ui.setCurrent(col, row)
    $cell = selectRenderedCell(@renderedGrid, col, row)

    expect($cell.hasClass('puzzle-grid-selected')).toBeTruthy()
