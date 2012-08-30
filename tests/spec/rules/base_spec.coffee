PuzzleGrid = require('../../../assets/js/puzzle_grid')
BaseRules = require('../../../assets/js/rules/base')

describe 'rules base class', ->
  beforeEach ->
    @grid = new PuzzleGrid(9, 9)
    @rules = new BaseRules()

  it 'should call the validateInitial function when assigned to a grid', ->
    spyOn(@rules, 'initialValidate')
    @grid.setRules(@rules)
    expect(@rules.initialValidate).toHaveBeenCalledWith(@grid)

