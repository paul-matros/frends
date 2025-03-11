CarModel = require('./models/car')
CarsCollection = require('./collections/cars')

class App
  constructor: ->
# Initialize the app when the DOM is ready
    $(document).ready =>
      @initialize()

  initialize: ->
    console.log 'Application initialized'

    # Create a new collection for cars
    @carsCollection = new CarsCollection()


# Create and start the application
app = new App()

# Export the app for potential reuse
module.exports = app