<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{{ $success ? 'Migration Successful' : 'Migrate Application' }}</title>
    <link rel="stylesheet" href="{{ asset('css/store.css') }}">
</head>
<body class="font-sans">
<div class="text-center py-48 px-4 lg:py-20 pb-32 md:py-32 flex flex-col items-center justify-center">
    <h1 class="lg:text-4xl md:text-3xl text-xl font-bold text-gray-800 py-4 md:py-8">{{ $success ? 'Migration Successful' : 'Migrate Application' }}</h1>
    <p class="text-base text-gray-600 py-2 ">
        {{ $message }}
    </p>
    <div class="my-4 md:my-8 w-full">
        @if($success)
        <a href="{{ route('login') }}" class="text-center text-base font-medium text-white p-4 md:w-auto w-full bg-green-700 border rounded-md hover:bg-green-800">Login to Fix Updates</a>
        @else
        <a href="{{ route('run_migrations') }}" class="text-center text-base font-medium text-white p-4 md:w-auto w-full bg-red-700 border rounded-md hover:bg-red-800">Migrate Now</a>
        @endif
    </div>
</div>
</body>
</html>
