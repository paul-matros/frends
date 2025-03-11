CarModel = require('./models/car')
CarsCollection = require('./collections/cars')

class App
  constructor: ->
# Initialize the app when the DOM is ready
    $(document).ready =>
      @initialize()

  initialize: ->
    console.log 'Application initialized'

    @initializeEventListeners()

  initializeEventListeners: ->
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

# Render the view with the data
        @renderCars(data)
      error: (xhr, status, error) =>
        console.error 'Error fetching cars:', error
        $('#car-display').html('<p>Error fetching data. Please try again.</p>')

# Method to render the cars to the view
  renderCars: (data) =>
    console.log 'Rendering cars:', data

    # Check if we have data and cars
    if data and data.name and data.cars and data.cars.length > 0
      console.log("1")
      # Prepare the context for the template
      context =
        name: data.name
        cars: data.cars
        carCount: data.cars.length
      console.log("2")
      console.log("Handlebars available:", typeof Handlebars != 'undefined')
      console.log("Handlebars.templates:", Handlebars.templates)
      console.log("Looking for template:", 'cars')
      # Use Handlebars to compile the template
      # Note: The template is pre-compiled by Gulp and available as 'Handlebars.templates.cars'
      template = Handlebars.templates['cars']
      console.log("3")
      renderedHtml = template(context)

      # Update the DOM with the rendered HTML
      $('#car-display').html(renderedHtml)
    else
# Handle the case where no cars are found
      $('#car-display').html('<p>No cars found for this user.</p>')
# Create and start the application
app = new App()

# Export the app for potential reuse
module.exports = app