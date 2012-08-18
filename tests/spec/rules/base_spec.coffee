PuzzleGrid = require('../../../assets/javascripts/puzzle_grid')
BaseRules = require('../../../assets/javascripts/rules/base')

describe 'rules base class', ->
  beforeEach ->
    @grid = new PuzzleGrid(9, 9)

  it 'should call the validateInitial function when constructed', ->
    spyOn(BaseRules.prototype, 'validateInitial')
    rules = new BaseRules(@grid)
    expect(BaseRules.prototype.validateInitial).toHaveBeenCalled()

