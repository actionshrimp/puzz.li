request = require('supertest')
http = require('http')
app = require('../../')

describe 'the server', ->

  server = null
  response = null
  error = null

  storeResponse = (err, res) ->
    response = res
    error = err

  responseReturned = ->
    return response?

  makeRequest = (url) =>
    request(server).get(url).end(storeResponse)

  beforeEach ->
    server = http.createServer(app)
    server.listen(0)
    response = null
    error = null

  afterEach ->
    server.close()

  it 'should load the index page', ->
    runs(->
      makeRequest('/'))

    waitsFor(->
      responseReturned()
    "response to be returned", 750)

    runs(->
      expect(response.status).toEqual(200))

  it 'should load the sudoku page', ->
    runs(->
      makeRequest('/puzzles/sudoku'))

    waitsFor(->
      responseReturned()
    "response to be returned", 750)

    runs(->
      expect(response.status).toEqual(200))
