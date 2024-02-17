module.exports = {
    methods: {
        /**
         * Converts hex to rgba.
         */
        hex2rgba(hex, alpha = 1) {
            if (alpha > 1 || alpha < 0) {
                throw new Error('alpha is not correct!');
            }
            const red = parseInt(hex.slice(1, 3), 16);
            const green = parseInt(hex.slice(3, 5), 16);
            const blue = parseInt(hex.slice(5, 7), 16);
            return `rgba(${red}, ${green}, ${blue}, ${alpha})`;
        },
    },
}
