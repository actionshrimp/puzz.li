class PuzzleGrid
  constructor: (@cols, @rows, rules) ->
    @data = {}
    @updateListeners = []
    if rules?
      @setRules(rules)

  #Instantiate the rules with a rules constructor
  #(which returns a rules object after initial validation)
  setRules: (rules) ->
    @rules = new rules(@)

  key: (col, row) -> "#{col}:#{row}"

  getCell: (col, row) =>
    return @data[@key(col, row)]

  #Get cell value using transposed coordinates
  getCellT: (row, col) =>
    return @data[@key(col, row)]
    
  setCell: (col, row, value, performRulesValidation) ->

    if !@cellExists(col, row)
      throw 'InvalidCellException'

    if not performRulesValidation?
      performRulesValidation = true

    key = @key(row, col)
    prev = @getCell(row, col)

    @data[key] = value

    if (performRulesValidation and !@gridIsValid())
      @data[key] = prev
      throw 'InvalidGridException'

    @broadcastUpdate(col, row, value)

  cellExists: (col, row) ->
    if (col >= 0 and col < @cols) and (row >= 0 and row < @rows)
      return true
    return false

  gridIsValid: () ->
    if @rules?
      return @rules.validateGridValues()
    else
      return true

  registerUpdateListener: (listener) ->
    @updateListeners.push(listener)

  broadcastUpdate: (col, row, value) ->
    for listener in @updateListeners
      listener(col, row, value)


module.exports = PuzzleGrid
