# Simple Car Display Client

This is a simple client application that connects to a REST service to display a user and their cars.

## My Commentary

Although I specialize in backend Java development with some experience in Angular and Vue.js I had a great time working
on this
task and enjoyed exploring different technologies.

If I had more time:

* I would likely refactor and separate the scripts
  into more files, but I’m unsure about the conventions in CoffeeScript for structuring this.
* incorporate more Backbone.js, as per task description ;)

but overall I’m happy with how it turned out given the time constraints

## Technologies Used

- HTML & jQuery for the UI
- ~~Backbone.js for MVC structure~~
- CoffeeScript for JavaScript compilation
- Handlebars.js for templating
- PHP for the REST service (stub)
- Gulp as the task runner
- npm as the package manager

## Prerequisites

- Node.js and npm
- PHP

## Installation

1. Clone this repository or extract the files to your preferred location
2. Install required global packages:
   ```
   npm install -g gulp-cli coffee-script
   ```
3. Install project dependencies:
   ```
   npm install
   ```

## Running the Application

1. Build the project:
   ```
   gulp build
   ```

2. Start the server:
   ```
   php -S localhost:8000 -t ./
   ```

3. Open your browser and navigate to:
   ```
   http://localhost:8000/dist/index.html
   ```

4. Click the "Get Cars" button to fetch and display John's cars.