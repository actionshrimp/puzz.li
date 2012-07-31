class PuzzleGrid
  constructor: (@rows, @cols, @rules) ->
    @data = {}

  setRules: (rules) ->
    @rules = rules

  key: (row, col) -> '#{row}:#{col}'

  getCell: (row, col) ->
    return @data[@key(row, col)]
    
  setCell: (row, col, value) ->
    if !@cellExists(row, col)
      throw 'InvalidCellException'

    key = @key(row, col)
    prev = @getCell(row, col)

    @data[key] = value
    if (!@gridIsValid())
      @data[key] = prev
      throw 'InvalidGridException'

  cellExists: (row, col) ->
    if (row >= 0 and row < @rows) and (col >= 0 and col < @cols)
      return true
    return false

  gridIsValid: () ->
    if @rules?
      return @rules(@)
    else
      return true

module.exports = PuzzleGrid
