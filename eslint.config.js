const js = require('@eslint/js')
const typescriptEslint = require('@typescript-eslint/eslint-plugin')
const tsParser = require('@typescript-eslint/parser')
const globals = require('globals')
const simpleImportSort = require('eslint-plugin-simple-import-sort')
const prettierRecommended = require('eslint-plugin-prettier/recommended')

module.exports = [
  {
    ignores: [
      '**/node_modules/**',
      'lib/**',
      'sample/**',
      // Codegen spec files have strict type requirements (Object vs object, semicolons)
      // dictated by React Native's codegen — do not lint or auto-fix these.
      'src/fabric/**',
    ],
  },
  js.configs.recommended,
  prettierRecommended,
  // Prettier formatting is advisory — existing files with different style won't block CI.
  { rules: { 'prettier/prettier': 'warn' } },
  // CommonJS config/script files
  {
    files: ['**/*.js', '**/*.jsx'],
    languageOptions: {
      globals: {
        ...globals.commonjs,
        ...globals.node,
      },
    },
  },
  // TypeScript source files
  {
    files: ['**/*.ts', '**/*.tsx'],
    languageOptions: {
      parser: tsParser,
      parserOptions: {
        ecmaVersion: 'latest',
        sourceType: 'module',
      },
    },
    plugins: {
      '@typescript-eslint': typescriptEslint,
      'simple-import-sort': simpleImportSort,
    },
    rules: {
      ...typescriptEslint.configs.recommended.rules,
      // Wrapper types (String/Number/Boolean/Object) exist in pre-existing model files;
      // downgrade so existing code doesn't block CI.
      '@typescript-eslint/no-wrapper-object-types': 'warn',
      'import/order': 'off',
      // Warn rather than error so pre-existing unsorted imports don't block CI.
      'simple-import-sort/exports': 'warn',
      'simple-import-sort/imports': 'warn',
      'sort-imports': 'off',
    },
  },
  // Test files — add jest globals and relax any-type rules used in mocks
  {
    files: [
      '**/__tests__/**/*.ts',
      '**/__tests__/**/*.tsx',
      '**/*.test.ts',
      '**/*.test.tsx',
    ],
    languageOptions: {
      globals: {
        ...globals.jest,
      },
    },
    rules: {
      '@typescript-eslint/no-explicit-any': 'off',
    },
  },
]
