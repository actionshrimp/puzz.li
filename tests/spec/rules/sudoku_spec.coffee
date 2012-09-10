PuzzleGrid = require('../../../assets/js/puzzle_grid')
SudokuRules = require('../../../assets/js/rules/sudoku')

describe 'sudoku rules', ->

  it 'should only accept equal sided grids', ->
    rules = new SudokuRules(/.*/)
    expect(-> new PuzzleGrid(9, 4, rules)).toThrow('InvalidGridException')

  it 'should only accept grids where the sides are a square number', ->
    squareNumbers = [1, 4, 9]
    for size in [1..10]
      rules = new SudokuRules(/.*/)
      if (size not in squareNumbers)
        expect(-> new PuzzleGrid(size, size, rules)).toThrow('InvalidGridException')
      else
        new PuzzleGrid(size, size, rules)

  describe 'when the grid is a valid shape', ->
    beforeEach ->
      @allowedValues = /[1-9]/
      @rules = new SudokuRules(@allowedValues)
      @grid = new PuzzleGrid(9, 9, @rules)

    it 'should only allow predefined values', ->
      #Check the values regex actually works as expected first
      expect(@allowedValues.test('0')).toBeFalsy()
      expect(@allowedValues.test('1')).toBeTruthy()
      expect(@allowedValues.test('9')).toBeTruthy()
      expect(@allowedValues.test('A')).toBeFalsy()

      expect(=> @grid.setCell(0, 0, 0)).toThrow('InvalidValueException')
      expect(=> @grid.setCell(0, 0, 'A')).toThrow('InvalidValueException')
      expect(=> @grid.setCell(0, 0, 1)).not.toThrow('InvalidValueException')
      expect(=> @grid.setCell(0, 0, 9)).not.toThrow('InvalidValueException')
      expect(=> @grid.setCell(0, 0, '9')).not.toThrow('InvalidValueException')

      #Check the same values are 

    it 'should only allow one of each number in each column', ->
      expect(=> @grid.setCell(0, 0, 1)).not.toThrow()
      #Check it fails as part of the setCell call
      expect(=> @grid.setCell(0, 1, 1)).toThrow('InvalidColumnException')

      #Same again for a separate column
      expect(=> @grid.setCell(8, 8, 2)).not.toThrow()
      expect(=> @grid.setCell(8, 7, 2)).toThrow('InvalidColumnException')

    it 'should only allow one of each number in each row', ->
      expect(=> @grid.setCell(0, 0, 1)).not.toThrow()
      #Check it fails as part of the setCell call
      expect(=> @grid.setCell(1, 0, 1)).toThrow('InvalidRowException')

      #Same again for a separate row
      expect(=> @grid.setCell(3, 5, 2)).not.toThrow()
      expect(=> @grid.setCell(4, 5, 2)).toThrow('InvalidRowException')

    it 'should only allow one of each number in each sub-square', ->
      @grid.setCell(0, 0, 1)
      expect(=> @grid.setCell(1, 1, 1)).toThrow('InvalidSubSquareException')

      @grid.setCell(3, 3, 9)
      expect(=> @grid.setCell(5, 4, 9)).toThrow('InvalidSubSquareException')
