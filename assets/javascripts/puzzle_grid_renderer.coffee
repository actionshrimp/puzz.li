class PuzzleGridRenderer
  constructor: (@grid) ->
    @buffer = ""
    @grid.registerUpdateListener(@render)
    @render()

  renderCellValue: (col, row) ->
    return "<div class='puzzle-grid-cell-value'>#{@grid.getCell(col, row)}</div>"

  renderCell: (col, row) ->
    return "<div class='puzzle-grid-cell'>#{@renderCellValue(col, row)}</div>"

  renderRow: (cells) ->
    return "<div class='puzzle-grid-row'>#{cells}</div>"

  renderGrid: (rows) ->
    return "<div class='puzzle-grid'>#{rows}</div>"

  render: =>
    rows = ""
    for y in [0...@grid.rows]
      cells = ""

      for x in [0...@grid.cols]
        cells += @renderCell(x, y)

      rows += @renderRow(cells)

    @buffer = @renderGrid(rows)
    return @buffer

module.exports = PuzzleGridRenderer
