Backbone = require('backbone')

class CarModel extends Backbone.Model

  defaults:
    name: ''
    model: ''

  initialize: ->
    console.log 'Car model initialized:', @attributes

  getFullName: ->
    "#{@get('name')} #{@get('model')}"

module.exports = CarModel