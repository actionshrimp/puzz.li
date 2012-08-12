PuzzleGrid = require('../../assets/javascripts/puzzle_grid')
SudokuRules = require('../../assets/javascripts/rules/sudoku')

describe 'sudoku rules builder', ->
  it 'should only accept equal sided grids', ->
    grid = new PuzzleGrid(9, 4)
    expect(=> grid.setRules(SudokuRules)).toThrow('InvalidGridException')

  it 'should only accept grids where the sides are a square number', ->
    for size in [1...30]
      grid = new PuzzleGrid(size, size)
      if (size != 1 and size != 4 and size != 9 and size != 16 and size != 25)
        expect(=> grid.setRules(SudokuRules)).toThrow('InvalidGridException')
      else
        grid.setRules(SudokuRules)

describe 'sudoku rules', ->

  beforeEach ->
    @grid = new PuzzleGrid(9, 9)
    @grid.setRules(SudokuRules)

  it 'should only allow one of each number in each column', ->
    @grid.setCell(0, 0, 1)
    expect(=> @grid.setCell(1, 0, 1)).toThrow('InvalidGridException')

    @grid.setCell(3, 8, 2)
    expect(=> @grid.setCell(7, 8, 2)).toThrow('InvalidGridException')

  it 'should only allow one of each number in each row', ->
    @grid.setCell(0, 0, 1)
    expect(=> @grid.setCell(0, 1, 1)).toThrow('InvalidGridException')

    @grid.setCell(3, 5, 2)
    expect(=> @grid.setCell(3, 6, 2)).toThrow('InvalidGridException')

  it 'should only allow one of each number in each sub-square', ->
    @grid.setCell(0, 0, 1)
    expect(=> @grid.setCell(1, 1, 1)).toThrow('InvalidGridException')

    @grid.setCell(3, 3, 9)
    expect(=> @grid.setCell(5, 4, 9)).toThrow('InvalidGridException')
