#Abstract rules base class
class BaseRules
  constructor: (@grid) ->
    @validateInitial()

  #Initial validation at rule construction stage, for checking
  #the grid dimensions are appropriate for the rules class
  validateInitial: () ->

  #Main validate method called by the grid when values are changed
  validateGridValues: () ->

module.exports = BaseRules
