PuzzleGrid = require('../assets/javascripts/puzzle_grid')

exampleRules = (grid) ->
  if grid.getCell(0, 0) == 'Legal'
    return true
  else
    return false

describe 'puzzle grid', ->

  beforeEach ->
    @grid = new PuzzleGrid 10, 10

  it 'should let you set values for cells', ->
    @grid.setCell(0, 0, 'A value')
    expect(@grid.getCell(0, 0)).toEqual('A value')

    @grid.setCell(1, 1, 'Another value')
    expect(@grid.getCell(1, 1)).toEqual('Another value')

  describe 'when rules are in place', ->

    beforeEach ->
      @grid.setRules(exampleRules)

    it 'should take the value if the rules allow it', ->
      @grid.setCell(0, 0, 'Legal')
      expect(@grid.getCell(0, 0)).toEqual('Legal')

    it 'should throw an InvalidGridException if the rules do not allow it', ->
      expect(=> @grid.setCell(0, 0, 'Illegal')).toThrow('InvalidGridException')
