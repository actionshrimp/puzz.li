PuzzleGrid = require('/bundle.js').PuzzleGrid
PuzzleGridUI = require('/bundle.js').PuzzleGridUI
PuzzleGridRenderer = require('/bundle.js').PuzzleGridRenderer
SudokuRules = require('/bundle.js').SudokuRules

grid = new PuzzleGrid(9, 9, SudokuRules)
ui = new PuzzleGridUI(grid)
renderer = new PuzzleGridRenderer(grid, ui)
renderer.onRender((html) ->
  $grid = $('<div/>').html(html)
  $('.puzzle-grid-cell', $grid).wrap("<div class='puzzle-grid-cell-border'/>")
  $('#puzzle').html($grid)
)

$(document).keydown((e) ->
  if (e.keyCode == 37)
    ui.left()
    return
  if (e.keyCode == 38)
    ui.up()
    return
  if (e.keyCode == 39)
    ui.right()
    return
  if (e.keyCode == 40)
    ui.down()
    return

  coords = ui.getCurrent()
  grid.setCell(coords[0], coords[1], String.fromCharCode(e.keyCode))
  ui.next()
)

$(document).ready(->
  renderer.render()
)
