@extends('store.layout')

@section('title', $category['headline'] ?: $category['name'])

@section('content')
    <x-category-hero :category="$category" :price="$least_price"/>

    <!--Features-->
    @if($homePageSettings->enable_features)
        <x-features/>
    @endif

    <!--Pricing-->
    @include('components.pricing')

    <!--Testimonials-->
    @if($homePageSettings->enable_testimonials)
        <x-testimonials/>
    @endif

    <!--CTA-->
    @if($homePageSettings->enable_cta)
        <x-cta/>
    @endif
@endsection
