const { FlatCompat } = require("@eslint/eslintrc");
const js = require("@eslint/js");
const typescriptEslint = require("@typescript-eslint/eslint-plugin");

const compat = new FlatCompat({
    baseDirectory: __dirname,
    recommendedConfig: js.configs.recommended,
    allConfig: js.configs.all
});

module.exports = [
    ...compat.extends("@react-native"),
    {
        plugins: { "@typescript-eslint": typescriptEslint },
        rules: {
            "@typescript-eslint/no-unused-vars": "warn",
        },
    },
];
