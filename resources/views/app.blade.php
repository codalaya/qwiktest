<!DOCTYPE html>
<html dir="{{ app(\App\Settings\LocalizationSettings::class)->default_direction }}"
    lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'QwikTest') }}</title>
    <meta name="description" content="{{ app(\App\Settings\SiteSettings::class)->seo_description }}">
    <link rel="icon" href="{{ url('storage/' . app(\App\Settings\SiteSettings::class)->favicon_path) }}">

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="{{ config('qwiktest.default_font_url') }}">

    <!-- Styles -->
    <link rel="stylesheet" href="{{ asset('vendor/primeicons/primeicons.css') }}">
    <link rel="stylesheet" href="{{ asset('vendor/nprogress/nprogress.css') }}">
    <link rel="stylesheet" href="{{ asset('vendor/katex/katex.min.css') }}">
    <link rel="stylesheet" href="{{ mix('css/app.css') }}">
    <style>
        :root {
            /* Custom Theme Configuration */
            --custom-font: "{{ config('qwiktest.default_font') }}";
            --primary-color: {{ '#' . app(\App\Settings\ThemeSettings::class)->primary_color }};
            --secondary-color: {{ '#' . app(\App\Settings\ThemeSettings::class)->secondary_color }};
        }
    </style>

    <!-- Scripts -->
    @routes
    <script>
        window.CKEditorURL = "{{ asset('vendor/ckeditor/ckeditor.js') }}";
    </script>
    <script src="{{ asset('vendor/katex/katex.min.js') }}"></script>
    <script src="{{ asset('vendor/katex/contrib/auto-render.min.js') }}"></script>
    <script src="{{ asset('js/manifest.js') }}" defer></script>
    <script src="{{ asset('js/vendor-vue.js') }}" defer></script>
    <script src="{{ asset('js/vendor.js') }}" defer></script>
    <script src="{{ mix('js/app.js') }}"></script>
</head>

<body class="font-sans antialiased bg-gray-100 dark:bg-gray-900">
    @inertia

    {{-- @env('local')
    <script src="http://localhost:8080/js/bundle.js"></script>
    @endenv --}}
</body>

</html>
