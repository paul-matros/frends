class App
  constructor: ->
    $(document).ready =>
      @initialize()

  initialize: ->
    console.log 'Application initialized'

    # Initialize event listeners
    @initializeEventListeners()

  initializeEventListeners: ->
    $('#get-cars').on 'click', @fetchCars

  fetchCars: =>
    console.log 'Fetching cars...'

    @fetchCarsFromApi()

  fetchCarsFromApi: ->
    $.ajax
      url: '/server/api.php'
      method: 'GET'
      dataType: 'json'
      success: @handleFetchSuccess
      error: @handleFetchError

  handleFetchSuccess: (data) =>
    @renderCars(data)

  handleFetchError: (xhr, status, error) =>
    console.error 'Error fetching cars:', error
    @renderErrorMessage()

  renderErrorMessage: ->
    $('#car-display').html('<p>Error fetching data. Please try again.</p>')

  renderCars: (data) =>
    console.log 'Rendering cars:', data

    if @validateCompleteData(data)
      @renderCarList(data)
    else
      @renderNoCarsMessage()

  validateCompleteData: (data) ->
    return data && data.name && data.cars && data.cars.length > 0

  renderCarList: (data) ->
    context = @buildTemplateContext(data)
    renderedHtml = @renderHtmlFromTemplate('cars', context)

    # Update the DOM with the rendered HTML
    $('#car-display').html(renderedHtml)

  buildTemplateContext: (data) ->
    return {
      name: data.name
      cars: data.cars
      carCount: data.cars.length
    }

  renderHtmlFromTemplate: (templateName, context) ->
    template = Handlebars.templates[templateName]
    return template(context)

  renderNoCarsMessage: ->
    $('#car-display').html('<p>No cars found for this user.</p>')

# Create and start the application
app = new App()

# Export the app for potential reuse
module.exports = app