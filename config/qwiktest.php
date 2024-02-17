<?php


return [
   /*
   |--------------------------------------------------------------------------
   | App Info
   |--------------------------------------------------------------------------
   |
   */

    'installed' => env('APP_INSTALLED', false),

    'version' => env('APP_VERSION', null),

   /*
   |--------------------------------------------------------------------------
   | Question Matching Pair Salts
   |--------------------------------------------------------------------------
   |
   */

    'default_font' => env('DEFAULT_FONT', "Inter"),

    'default_font_url' => env('DEFAULT_FONT_URL', "https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap"),

    /*
   |--------------------------------------------------------------------------
   | Supported Payment Processors
   |--------------------------------------------------------------------------
   |
   */

    'payment_processors' => [
        'razorpay' => [
            'name' => 'Razorpay',
            'description' => 'Credit/Debit Cards, Net Banking, UPI',
        ],
        'bank' => [
            'name' => 'Bank',
            'description' => 'Bank transfer'
        ]
    ],

   /*
   |--------------------------------------------------------------------------
   | Question Matching Pair Salts
   |--------------------------------------------------------------------------
   |
   */

    'matching_option_salt' => "gRPXyMML3JZ4gbX3",

    'matching_pair_salt' => "AVZZn02uV1ppQhcE",

   /*
   |--------------------------------------------------------------------------
   | Question Ordering Pair Salts
   |--------------------------------------------------------------------------
   |
   */

    'ordering_option_salt' => "EejYoTj4as3RQtUm",

   /*
   |--------------------------------------------------------------------------
   | Enable Demo Mode (Don't edit)
   |--------------------------------------------------------------------------
   |
   */

    'demo_mode' => env('APP_DEMO', false),
];
