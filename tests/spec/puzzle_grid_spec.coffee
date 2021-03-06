BaseRules = require('../../assets/js/rules/base')
PuzzleGrid = require('../../assets/js/puzzle_grid')

class ExampleRules extends BaseRules
  validateGridState: (grid) ->
    if grid.getCell(0, 0) == 'Illegal'
      throw 'InvalidGridException'

describe 'puzzle grid', ->

  beforeEach ->
    @grid = new PuzzleGrid(10, 10)

  it 'should let you set values for cells within range', ->
    @grid.setCell(0, 1, 'Legal')
    @grid.setCell(1, 0, 'Also legal')

    expect(@grid.getCell(0, 1)).toEqual('Legal')
    expect(@grid.getCell(1, 0)).toEqual('Also legal')

  it 'should thrown an InvalidCellException if the cell is out of range', ->
    expect(=> @grid.setCell(10, 0, 'Out of range')).toThrow('InvalidCellException')
    expect(=> @grid.setCell(0, 10, 'Out of range')).toThrow('InvalidCellException')

  it 'should broadcast to registered value listeners when a cell is updated', ->
    spy = jasmine.createSpy('updateListener')
    @grid.onUpdate(spy)
    @grid.setCell(3, 3, 'A value')

    expect(spy).toHaveBeenCalledWith(3, 3, 'A value')

  describe 'when rules are in place', ->

    beforeEach ->
      rules = new ExampleRules()
      @grid.setRules(rules)

    it 'should take the value if the rules allow it', ->
      @grid.setCell(0, 0, 'Legal')
      expect(@grid.getCell(0, 0)).toEqual('Legal')

    it 'should throw an InvalidGridException if the rules do not allow it', ->
      expect(=> @grid.setCell(0, 0, 'Illegal')).toThrow('InvalidGridException')
