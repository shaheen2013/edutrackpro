const mix = require('laravel-mix');
const path = require('path');
const tailwindcss = require('tailwindcss');

mix.js('resources/js/app.js', 'public/build/js')
    .sass('resources/sass/app.scss', 'public/build/css')
    .webpackConfig({
        resolve: {
            alias: {
                '@': path.resolve(__dirname, 'resources/js'),
            },
            extensions: ['.js', '.vue', '.json'],
        },
    })
    .options({
        postCss: [tailwindcss('./tailwind.config.js')],
    }).vue();
