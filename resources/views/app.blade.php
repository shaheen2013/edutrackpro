<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" class="dark">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">

        <title>{{ config('app.name', 'Laravel') }}</title>

        <!-- CSRF Token -->
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <meta name="base-url" content="{{URL::to('/')}}" />

        <script>
            window.laravel = {
                csrfToken: '{{ csrf_token() }}',
                baseurl: '{{URL::to("/")}}',
                appName:'{{ config('app.name') }}'
            }
        </script>

        <link href="{{ mix('build/css/app.css') }}" rel="stylesheet">
    </head>
    <body>
        <div id="app"></div>

        <script src="{{ mix('build/js/app.js') }}"></script>
    </body>
</html>
