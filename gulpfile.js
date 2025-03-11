const gulp = require('gulp');
const coffee = require('gulp-coffee');
const concat = require('gulp-concat');
const browserify = require('browserify');
const source = require('vinyl-source-stream');
const fs = require('fs');  // Node's built-in file system module
const handlebars = require('gulp-handlebars');
const rename = require('gulp-rename');
const browserSync = require('browser-sync').create();

// Define file paths
const paths = {
    coffee: {
        src: 'src/coffee/**/*.coffee',
        dest: 'dist/js'
    },
    templates: {
        src: 'src/templates/**/*.hbs',
        dest: 'dist/js'
    },
    html: {
        src: 'src/index.html',
        dest: 'dist'
    },
    vendor: {
        src: [
            'node_modules/jquery/dist/jquery.min.js',
            'node_modules/underscore/underscore-min.js',
            'node_modules/backbone/backbone-min.js',
            'node_modules/handlebars/dist/handlebars.min.js'
        ],
        dest: 'dist/js'
    }
};

// Clean the dist directory
function clean(cb) {
    // Simple approach - check if directory exists first
    if (fs.existsSync('./dist')) {
        try {
            fs.rmSync('./dist', {recursive: true, force: true});
        } catch (err) {
            console.error('Error while deleting ./dist:', err);
        }
    }
    // Create dist directory
    fs.mkdirSync('./dist', {recursive: true});
    cb(); // Call the callback to signal task completion
}

// Process CoffeeScript files with Browserify
function processCoffee() {
    return browserify({
        entries: ['src/coffee/app.coffee'],
        extensions: ['.coffee'],
        transform: ['coffeeify']
    })
        .bundle()
        .pipe(source('app.js'))
        .pipe(gulp.dest(paths.coffee.dest))
        .pipe(browserSync.stream());
}

// Process Handlebars templates
function processTemplates() {
    return gulp.src(paths.templates.src)
        .pipe(handlebars({
            handlebars: require('handlebars')
        }))
        .pipe(rename({
            extname: '.js'
        }))
        .pipe(gulp.dest(paths.templates.dest))
        .pipe(browserSync.stream());
}

// Copy HTML files
function copyHtml() {
    return gulp.src(paths.html.src)
        .pipe(gulp.dest(paths.html.dest))
        .pipe(browserSync.stream());
}

// Copy vendor files
function copyVendor() {
    return gulp.src(paths.vendor.src)
        .pipe(concat('vendor.js'))
        .pipe(gulp.dest(paths.vendor.dest));
}

// Watch files for changes
function watch() {
    browserSync.init({
        server: {
            baseDir: './dist'
        }
    });

    gulp.watch(paths.coffee.src, processCoffee);
    gulp.watch(paths.templates.src, processTemplates);
    gulp.watch(paths.html.src, copyHtml);
}

// Define build tasks
const build = gulp.series(
    clean,
    gulp.parallel(processCoffee, processTemplates, copyHtml, copyVendor)
);

// Export tasks
exports.clean = clean;
exports.build = build;
exports.watch = watch;
exports.default = build;