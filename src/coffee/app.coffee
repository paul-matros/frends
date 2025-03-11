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

    # Bind the click event to the button
    $('#get-cars').on 'click', @fetchCars

# Method to fetch cars from the REST service
  fetchCars: =>
    console.log 'Fetching cars...'

    # Make AJAX request to our PHP REST service
    $.ajax
      url: '/server/api.php'
      method: 'GET'
      dataType: 'json'
      success: (data) =>
# Update the collection with the fetched data
        @carsCollection.reset(data.cars)


      error: (xhr, status, error) =>
        console.error 'Error fetching cars:', error
        $('#car-display').html('<p>Error fetching data. Please try again.</p>')

# Create and start the application
app = new App()

# Export the app for potential reuse
module.exports = app