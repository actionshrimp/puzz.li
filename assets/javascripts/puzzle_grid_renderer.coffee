class PuzzleGridRenderer
  constructor: (@grid) ->
    @renderListeners = []
    @grid.registerUpdateListener(@render)
    @render()

  renderCellValue: (col, row) =>
    return "<div class='puzzle-grid-cell-value'>#{@grid.getCell(col, row)}</div>"

  renderCell: (col, row) =>
    return "<div class='puzzle-grid-cell'>#{@renderCellValue(col, row)}</div>"

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
    return @buffer

module.exports = PuzzleGridRenderer
