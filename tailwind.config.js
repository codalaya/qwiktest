const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
    purge: [
        './vendor/laravel/jetstream/**/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
        './resources/js/**/*.vue',
    ],
    darkMode: 'class',
    theme: {
        extend: {
            colors: {
                primary: "var(--primary-color)",
                secondary: "var(--secondary-color)",
                'qt-primary': '#38b355',
                'qt-secondary': '#4f4d91',
                'qt-lite': '#7cc9c1',
                'qt-option': '#63d0f2',
            },
            fontFamily: {
                sans: ['Inter', ...defaultTheme.fontFamily.sans],
            },
        },
    },

    variants: {
        flex: ['responsive', 'direction'],
        flexDirection: ['responsive', 'direction'],
        justifyContent: ['responsive', 'direction'],
        textAlign: ['responsive', 'direction'],
        float: ['responsive', 'direction'],
        margin: ['responsive', 'direction'],
        padding: ['responsive', 'direction'],
        transformOrigin: ['responsive', 'direction'],
        position: ['responsive', 'direction'],
        inset: ['responsive', 'direction'],
        space: ['responsive', 'direction'],
        translate: ['responsive', 'direction'],
        borderWidth: ['responsive', 'direction'],
        borderRadius: ['responsive', 'direction'],
        scale: ['group-hover'],
        extend: {
            opacity: ['disabled']
        },
    },

    plugins: [require('@tailwindcss/forms'), require('@tailwindcss/typography'), require('@tailwindcss/line-clamp'), require('@tailwindcss/aspect-ratio'), require('tailwindcss-dir')()],
};
