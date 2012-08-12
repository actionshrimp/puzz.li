class PuzzleGrid
  constructor: (@cols, @rows, rules) ->
    @data = {}
    if rules?
      @setRules(rules)

  #Set the rules with a rules builder function 
  #(which returns rules after initial validation)
  setRules: (rulesBuilder) ->
    @rules = rulesBuilder(@)

  key: (col, row) -> "#{col}:#{row}"

  getCell: (col, row) =>
    return @data[@key(col, row)]

  #Get cell value using transposed coordinates
  getCellT: (row, col) =>
    return @data[@key(col, row)]
    
  setCell: (col, row, value) ->
    if !@cellExists(col, row)
      throw 'InvalidCellException'

    key = @key(row, col)
    prev = @getCell(row, col)

    @data[key] = value
    if (!@gridIsValid())
      @data[key] = prev
      throw 'InvalidGridException'

  cellExists: (col, row) ->
    if (col >= 0 and col < @cols) and (row >= 0 and row < @rows)
      return true
    return false

  gridIsValid: () ->
    if @rules?
      return @rules(@)
    else
      return true

module.exports = PuzzleGrid
