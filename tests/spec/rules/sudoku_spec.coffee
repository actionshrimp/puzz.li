PuzzleGrid = require('../../../assets/js/puzzle_grid')
SudokuRules = require('../../../assets/js/rules/sudoku')

describe 'sudoku rules builder', ->
  it 'should only accept equal sided grids', ->
    grid = new PuzzleGrid(9, 4)
    expect(=> grid.setRules(SudokuRules)).toThrow('InvalidGridException')

  it 'should only accept grids where the sides are a square number', ->
    squareNumbers = [1, 4, 9]
    for size in [1..10]
      grid = new PuzzleGrid(size, size)
      if (size not in squareNumbers)
        expect(=> grid.setRules(SudokuRules)).toThrow('InvalidGridException')
      else
        grid.setRules(SudokuRules)

describe 'sudoku rules', ->

  beforeEach ->
    @grid = new PuzzleGrid(9, 9)
    @grid.setRules(SudokuRules)

  it 'should only allow one of each number in each column', ->
    expect(=> @grid.setCell(0, 0, 1)).not.toThrow()

    #Check column validator specifically fails 'manually'
    @grid.setCell(0, 1, 1, false)
    expect(@grid.rules.colsAreValid()).toBeFalsy()
    @grid.setCell(0, 1, null)

    #Check it fails as part of the setCell call
    expect(=> @grid.setCell(0, 1, 1)).toThrow('InvalidGridException')

    #Same again for a separate column
    expect(=> @grid.setCell(8, 8, 2)).not.toThrow()
    expect(=> @grid.setCell(8, 7, 2)).toThrow('InvalidGridException')

  it 'should only allow one of each number in each row', ->
    expect(=> @grid.setCell(0, 0, 1)).not.toThrow()

    #Check row validator specifically fails 'manually'
    @grid.setCell(1, 0, 1, false)
    expect(@grid.rules.rowsAreValid()).toBeFalsy()
    @grid.setCell(1, 0, null)

    #Check it fails as part of the setCell call
    expect(=> @grid.setCell(1, 0, 1)).toThrow('InvalidGridException')

    #Same again for a separate row
    @grid.setCell(3, 5, 2)
    expect(=> @grid.setCell(4, 5, 2)).toThrow('InvalidGridException')

  it 'should only allow one of each number in each sub-square', ->
    @grid.setCell(0, 0, 1)
    expect(=> @grid.setCell(1, 1, 1)).toThrow('InvalidGridException')

    @grid.setCell(3, 3, 9)
    expect(=> @grid.setCell(5, 4, 9)).toThrow('InvalidGridException')
