PuzzleGrid = require('/bundle.js').PuzzleGrid
PuzzleGridUI = require('/bundle.js').PuzzleGridUI
PuzzleGridRenderer = require('/bundle.js').PuzzleGridRenderer
SudokuRules = require('/bundle.js').SudokuRules

$(document).ready(->
  grid = new PuzzleGrid(9, 9, SudokuRules)
  ui = new PuzzleGridUI(grid)
  renderer = new PuzzleGridRenderer(grid, ui)
  renderer.onRender((html) ->
    $('#puzzle').html(html)
  )

  renderer.render()
)
