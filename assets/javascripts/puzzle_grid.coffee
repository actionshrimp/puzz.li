class PuzzleGrid
  constructor: (@rows, @cols, rules) ->
    @data = {}
    if rules?
      @setRules(rules)

  #Set the rules with a rules builder function 
  #(which returns rules after initial validation)
  setRules: (rulesBuilder) ->
    @rules = rulesBuilder(@)

  key: (row, col) -> "#{row}:#{col}"

  getCell: (row, col) =>
    return @data[@key(row, col)]

  #Get cell value using transposed coordinates
  getCellT: (col, row) =>
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
