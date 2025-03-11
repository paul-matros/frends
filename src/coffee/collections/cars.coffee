Backbone = require('backbone')
CarModel = require('../models/car')


class CarsCollection extends Backbone.Collection

  model: CarModel

# Initialize method
  initialize: ->
    console.log 'Cars collection initialized'

    # Listen to changes in the collection
    @on 'add', @onCarAdded

# Event handlers
  onCarAdded: (car) ->
    console.log "Car added: #{car.getFullName()}"

module.exports = CarsCollection