#Abstract rules base class
class BaseRules
  #Initial validation at rule construction stage, for checking
  #the grid dimensions are appropriate for the rules class
  initialValidate: (grid) ->

  #Main validate method called by the grid when values are changed
  validateGridState: (grid) ->

module.exports = BaseRules
