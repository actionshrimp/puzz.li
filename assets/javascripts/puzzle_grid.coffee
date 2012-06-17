class PuzzleGrid
  constructor: (@rows, @cols, @rules) ->
    @data = {}

  cell: (row, col, value) ->
    key = '#{row}:#{col}'

    if value?
      @validateAgainstRules(row, col, value)
      @data[key] = value
    else
      return @data[key]

  setRules: (rules) ->
    @rules = rules

  validateAgainstRules: (row, col, value) ->
    if @rules?
      if @rules(row, col, value)
        return true
      else
        throw 'InvalidEntryException'

module.exports = PuzzleGrid
