class PuzzleGrid
  constructor: (@cols, @rows) ->
    @data = {}
    @updateListeners = []

  setRules: (rules) =>
    rules.initialValidate(@)
    @rules = rules

  key: (col, row) -> "#{col}:#{row}"

  getCell: (col, row) =>
    return @data[@key(col, row)]

  #Get cell value using transposed coordinates
  getCellT: (row, col) =>
    return @data[@key(col, row)]
    
  setCell: (col, row, value) ->

    if !@cellExists(col, row)
      throw 'InvalidCellException'

    key = @key(col, row)
    prev = @getCell(col, row)

    @data[key] = value

    try
      @validateGrid()
    catch e
      @data[key] = prev
      throw e

    @broadcastUpdate(col, row, value)

  cellExists: (col, row) ->
    if (col >= 0 and col < @cols) and (row >= 0 and row < @rows)
      return true
    return false

  validateGrid: () =>
    if @rules?
      @rules.validateGridState(@)

  onUpdate: (listener) ->
    @updateListeners.push(listener)

  broadcastUpdate: (col, row, value) ->
    for listener in @updateListeners
      listener(col, row, value)


module.exports = PuzzleGrid
