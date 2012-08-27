class PuzzleGridRenderer
  constructor: (@grid, @ui) ->
    @renderListeners = []
    @grid.onUpdate(@render)
    @ui.onCurrentUpdate(@render)
    @render()

  renderCellValue: (col, row) =>
    if @grid.getCell(col, row)?
      return "<div class='puzzle-grid-cell-value'>#{@grid.getCell(col, row)}</div>"
    else
      return "<div class='puzzle-grid-cell-null'/>"

  renderCell: (col, row) =>
    classes = 'puzzle-grid-cell'
    if ((@ui.getCurrent()[0] == col) and (@ui.getCurrent()[1] == row))
      classes += ' puzzle-grid-selected-cell'
    return "<div class='#{classes}'>#{@renderCellValue(col, row)}</div>"

  renderRow: (row) =>
    rowOut = "<div class='puzzle-grid-row'>"
    for col in [0...@grid.cols]
      rowOut += @renderCell(col, row)

    rowOut += "</div>"

    return rowOut

  renderGrid: () =>
    gridOut = "<div class='puzzle-grid'>"
    for row in [0...@grid.rows]
      gridOut += @renderRow(row)
    
    gridOut += "</div>"

    return gridOut

  render: =>
    @buffer = @renderGrid()
    @broadcastRender(@buffer)
    return @buffer

  onRender: (listener) =>
    @renderListeners.push(listener)

  broadcastRender: (buffer) =>
    for listener in @renderListeners
      listener(buffer)

module.exports = PuzzleGridRenderer
