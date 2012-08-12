BaseRules = require('../assets/javascripts/rules/base')
PuzzleGrid = require('../assets/javascripts/puzzle_grid')

class ExampleRules extends BaseRules
  validateGridValues: () ->
    if @grid.getCell(0, 0) == 'Legal'
      return true
    else
      return false

describe 'puzzle grid', ->

  beforeEach ->
    @grid = new PuzzleGrid 10, 10

  it 'should let you set values for cells within range', ->
    @grid.setCell(0, 0, 'Legal')
    @grid.setCell(1, 1, 'Also legal')

    expect(@grid.getCell(0, 0)).toEqual('Legal')
    expect(@grid.getCell(1, 1)).toEqual('Also legal')

  it 'should thrown an InvalidCellException if the cell is out of range', ->
    expect(=> @grid.setCell(10, 0, 'Out of range')).toThrow('InvalidCellException')
    expect(=> @grid.setCell(0, 10, 'Out of range')).toThrow('InvalidCellException')

  describe 'when rules are in place', ->

    beforeEach ->
      @grid.setRules(ExampleRules)

    it 'should take the value if the rules allow it', ->
      @grid.setCell(0, 0, 'Legal')
      expect(@grid.getCell(0, 0)).toEqual('Legal')

    it 'should throw an InvalidGridException if the rules do not allow it', ->
      expect(=> @grid.setCell(0, 0, 'Illegal')).toThrow('InvalidGridException')

    it 'should allow invalid rule values if skipRulesValidation is set to true', ->
      expect(=> @grid.setCell(0, 0, 'Illegal', true)).not.toThrow()
