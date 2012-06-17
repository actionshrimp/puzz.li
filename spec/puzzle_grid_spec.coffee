PuzzleGrid = require('../assets/javascripts/puzzle_grid')

exampleRules = (row, col, value) ->
  if row == 0
    return true
  else
    return false

describe 'puzzle grid', ->

  beforeEach ->
    @grid = new PuzzleGrid 10, 10

  it 'should let you set values for cells', ->
    @grid.cell(0, 0, 'A value')
    expect(@grid.cell(0, 0)).toEqual('A value')

    @grid.cell(1, 1, 'Another value')
    expect(@grid.cell(1, 1)).toEqual('Another value')

  describe 'when rules are in place', ->

    beforeEach ->
      @grid.setRules(exampleRules)

    it 'should take the value if the rules allow it', ->
      @grid.cell(0, 0, 'An allowed position')
      expect(@grid.cell(0, 0)).toEqual('An allowed position')

    it 'should throw an InvalidEntryException if the rules do not allow it', ->
      expect(=> @grid.cell(1, 0, 'An illegal position')).toThrow('InvalidEntryException')
