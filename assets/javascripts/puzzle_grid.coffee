class PuzzleGrid
  constructor: (@rows, @cols, @rules) ->
    @data = {}

  key: (row, col) -> '#{row}:#{col}'

  getCell: (row, col) ->
    return @data[@key(row,col)]
    
  setCell: (row, col, value) ->
    key = @key(row, col)
    prev = @getCell(row, col)

    @data[key] = value
    if (!@gridIsValid())
      @data[key] = prev
      throw 'InvalidGridException'

  setRules: (rules) ->
    @rules = rules

  gridIsValid: () ->
    isValid = true

    if @rules?
      isValid = @rules(@)

    return isValid

module.exports = PuzzleGrid
