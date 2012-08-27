class PuzzleGridRenderer
  constructor: (@grid) ->
    @buffer = ""
    @render()

  renderCell: (col, row) ->
    return "<div class='puzzle-grid-cell'/>"

  renderRow: (cells) ->
    return "<div class='puzzle-grid-row'>#{cells}</div>"

  renderGrid: (rows) ->
    return "<div class='puzzle-grid'>#{rows}</div>"

  render: ->
    cells = ""

    for y in [0...@grid.rows]
      for x in [0...@grid.cols]
        cells += @renderCell(x, y)

    @buffer = @renderGrid(cells)
    return @buffer

module.exports = PuzzleGridRenderer
