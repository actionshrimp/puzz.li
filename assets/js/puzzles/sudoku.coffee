PuzzleGrid = require('/bundle.js').PuzzleGrid
PuzzleGridUI = require('/bundle.js').PuzzleGridUI
PuzzleGridRenderer = require('/bundle.js').PuzzleGridRenderer
SudokuRules = require('/bundle.js').SudokuRules

rules = new SudokuRules(/[1-9]/)
grid = new PuzzleGrid(9, 9, rules)
ui = new PuzzleGridUI(grid)
renderer = new PuzzleGridRenderer(grid, ui)

renderer.onRender((html) ->
  $grid = $('<div/>').html(html)
  $('.puzzle-grid-cell', $grid).wrap("<div class='puzzle-grid-cell-border'/>")
  $('#puzzle').html($grid)
)

$(document).keydown((e) ->
  if $('#key-catcher').is(':focus')
    if (e.keyCode == 37)
      ui.left()
    if (e.keyCode == 38)
      ui.up()
    if (e.keyCode == 39)
      ui.right()
    if (e.keyCode == 40)
      ui.down()

    e.preventDefault()

  return
)

$('#key-catcher').keydown((e) ->
  value = String.fromCharCode(e.keyCode)
  coords = ui.getCurrent()
  x = coords[0]
  y = coords[1]

  if value == ' '
    grid.setCell(x, y, null)
  else
    grid.setCell(x, y, value)

  ui.next()
)

$(document).ready(->
  renderer.render()
)
