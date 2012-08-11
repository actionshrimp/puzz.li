PuzzleGrid = require('../../assets/javascripts/puzzle_grid')
SudokuRules = require('../../assets/javascripts/rules/sudoku')
size = 9

describe 'sudoku rules', ->

  beforeEach ->
    @grid = new PuzzleGrid(size, size)
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
