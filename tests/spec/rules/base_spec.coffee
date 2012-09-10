PuzzleGrid = require('../../../assets/js/puzzle_grid')
BaseRules = require('../../../assets/js/rules/base')

describe 'rules base class', ->
  beforeEach ->
    @rules = new BaseRules()

  it 'should call the validateInitial function when assigned to a grid', ->
    spyOn(@rules, 'initialValidate')
    @grid = new PuzzleGrid(9, 9, @rules)
    expect(@rules.initialValidate).toHaveBeenCalledWith(@grid)
