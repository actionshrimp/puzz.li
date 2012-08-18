router = require('../../routes.js')

describe 'routes', ->

  beforeEach ->
    routes = []

    @app =
      get: (route, handler) ->
        routes[route] = handler

      handleRoute: (route, req, res) ->
        routes[route](req, res)

    @res =
      render: (view, options) ->
        @viewName = view
        @options = options

    router(@app)

  #Not sure about these tests, they don't seem to actually test much at the minute
  it 'should render the index view', ->
    @app.handleRoute('/', null, @res)
    expect(@res.viewName).toEqual('index')

  it 'should render the sudoku puzzle view', ->
    @app.handleRoute('/puzzles/sudoku', null, @res)
    expect(@res.viewName).toEqual('puzzles/sudoku')
