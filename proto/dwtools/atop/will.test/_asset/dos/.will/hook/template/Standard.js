var Self =
{

// 'builder' : [{ softLink : '../../../app/builder', absolute : 0 }],
// 'builder' : [{ softLink : '/c/pro/web/Port/app/builder', absolute : 1 }],

'proto' :
{

  dwtools :
  {

    abase : {},
    amid : {},
    atop : {},

    'Tools.s' :
`
if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = './Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  module[ 'exports' ] = _global_.wTools;

}
`
  }

},

'.im.will.yml' : //
`

submodule :

  wTools :
    path : npm:///wTools
    enabled : 0 # submodule

path :

  in : '.'
  out : 'out'
  temp : 'path::out'
  proto : './proto'
  export : '{path::proto}/**'
  doc : './doc'

  out.raw.debug :
    path : '{path::out}/debug'
    criterion :
      debug : debug
      raw : raw
      content : prime
  out.compiled.debug :
    path : '{path::out}/compiled.debug'
    criterion :
      debug : debug
      raw : compiled
      content : prime
  out.raw.release :
    path : '{path::out}/raw.release'
    criterion :
      debug : release
      raw : raw
      content : prime
  out.compiled.release :
    path : '{path::out}/release'
    criterion :
      debug : release
      raw : compiled
      content : prime

  entry.proto.no.tests :
    path : proto/dwtools/___
    criterion :
      tests : 'no.tests'
  entry.proto.only.tests :
    path : proto/**/*.test.*
    criterion :
      tests : 'only.tests'

  entry.out.raw.debug :
    path : '{path::out.*=1}/source/dwtools/___'
    criterion :
      debug : [ debug, release ]
      raw : raw
      content : prime
  entry.out.compiled.debug :
    path : '{path::out.*=}/source/Index.s'
    criterion :
      debug : [ debug, release ]
      raw : compiled
      content : prime

reflector :

  reflect.proto :
    inherit : predefined.*
    criterion :
      tests : 'no.tests'
      debug : [ debug, release ]
      raw : [ raw, compiled ]
      content : prime
    filePath :
      path::proto : '{path::out.*=1}/source'

  transpile.proto.raw :
    inherit : predefined.*
    step :
      inherit : files.transpile
      entry : path::entry.proto.no.tests
    criterion :
      raw : raw
      debug : release
      content : prime
    filePath :
      path::proto : '{path::out.raw.release}'

  transpile.proto.no.tests.compiled :
    inherit : predefined.*
    step :
      inherit : files.transpile
      entry : path::entry.proto.*=1
    criterion :
      tests : 'no.tests'
      raw : compiled
      debug : [ debug, release ]
      content : prime
    filePath :
      '**.test*' : 0
      '**.test/**' : 0
      path::proto : '{path::out.*=1}/Main.s'

  transpile.proto.only.tests.compiled :
    inherit : predefined.*
    step :
      inherit : files.transpile
      entry : path::entry.proto.*=1
      external.before : '{path::out.*=1}/Main.s'
    criterion :
      tests : 'only.tests'
      raw : compiled
      debug : [ debug, release ]
      content : prime
    filePath :
      '**.test*' : 1
      path::proto : '{path::out.*=1}/Tests.test.s'

step :

  npm.generate :
    inherit : npm.generate
    entryPath : path::entry.out.*=1
    packagePath : '{path::out.*=1}/package.json'
    filesPath : '{path::out.*=1}/source/**'
    criterion :
      debug : [ debug, release ]
      raw : [ raw, compiled ]

  clean.out :
    inherit : files.delete
    filePath : '{path::out.*=1}/source'
    criterion :
      debug : [ debug, release ]
      raw : [ raw, compiled ]
      tests : [ 'no.tests', 'only.tests' ]
      content : [ 'prime', 'npm' ]

  clean.out.npm :
    inherit : files.delete
    filePath : path::out.*=1
    criterion :
      debug : debug
      raw : compiled
      tests : no.tests
      content : npm

  tst.proto :
    shell : 'tst {path::proto}'
    criterion :
      content : proto

  tst.debug :
    shell : 'tst {path::out.*=1}'
    criterion :
      content : prime
      debug : debug

  tst.release :
    shell : 'tst {path::out.*=1}'
    criterion :
      content : prime
      debug : release

build :

  debug :
    criterion :
      default : 1
      debug : debug
      raw : raw
      content : prime
    steps :
      - step::clean.out*=2
      - reflect.proto.*=1

  compiled.debug :
    criterion :
      debug : debug
      raw : compiled
      content : prime
    steps :
      - step::clean.out*=2
      - transpile.proto.no.tests*=1
      - transpile.proto.only.tests*=1

  raw.release :
    criterion :
      debug : release
      raw : raw
      content : prime
    steps :
      - step::clean.out*=2
      - transpile.proto.raw

  release :
    criterion :
      debug : release
      raw : compiled
      content : prime
    steps :
      - step::clean.out*=2
      - transpile.proto.no.tests*=1
      - transpile.proto.only.tests*=1

  npm :
    criterion :
      debug : debug
      raw : raw
      content : npm
    steps :
      - npm.generate.*=1
      # - npm.generate

  all :
    steps :
      - build::debug
      - build::compiled.debug
      - build::raw.release
      - build::release
      - build::npm

`,

'.ex.will.yml' : //
`

about :

  name : '{{package/name}}'
  description : '___'
  version : '0.4.0'
  enabled : 1
  interpreters :
  - njs >= 8.0.0
  - chrome >= 60.0.0
  - firefox >= 60.0.0
  keywords :
  - tools
  - wTools
  license : MIT
  author : '{{about/full.name}} <{{about/email}}>'
  contributors :
  - '{{about/full.name}} <{{about/email}}>'
  npm.name : '{{package/lowName}}'
  npm.scripts :
    test : 'wtest .run proto/**'
    docgen : 'wdocgen .build proto'

path :

  repository : git+https:///github.com/{{about/user}}/{{package/name}}.git
  origins :
   - git+https:///github.com/{{about/user}}/{{package/name}}.git
   - npm:///{{package/name}}
  bugtracker : https:///github.com/{{about/user}}/{{package/name}}/issues

step :

  proto.export :
    inherit : module.export
    export : path::export
    tar : 0
    criterion :
      content : 'proto'

  doc.export :
    inherit : module.export
    export : path::doc
    tar : 0
    criterion :
      content : 'doc'

  npm.export :
    inherit : module.export
    export : out.npm
    tar : 0
    criterion :
      content : 'npm'

  npm.publish :
    shell : npm publish

build :

  proto.export :
    criterion :
      content : 'proto'
      export : 1
    steps :
      # - build::debug.raw
      - step::proto.export

  doc.export :
    criterion :
      content : 'doc'
      export : 1
    steps :
      # - build::debug.raw
      - step::doc.export

  npm.export :
    criterion :
      content : 'npm'
      export : 1
    steps :
      # - build::debug.raw
      # - step::npm.export
      - step::npm.publish

  export :

    criterion :
      default : 1
      export : 1
    steps :
      # - build::npm
      - build::proto.export
      # - build::doc.export

`,

'sample' : //
{

'Sample.js' : //
`
let _ = require( '{{package/lowName}}' );

/**/

___

`,

'Sample.html' : //
`
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8" />
  <title></title>
  <script src="./node_modules/wTools/proto/Base.s"></script>
  <script src="./Sample1.js"></script>
 </head>
 <body>
 </body>
</html>

`,

},

'.travis.yml' : //
`
sudo: false
language: node_js
os:
  - linux
  - osx
  - windows
node_js:
  - '9'
  - '10'
  - '12'
  - 'node'
script:
  - npm test
cache:
  npm: false

`,

// 'appveyor.yml' : //
// `
//
//
// # image:
// #   - Visual Studio 2017
// #   - Ubuntu1804
//
// platform: x64
//
// environment:
//   matrix:
//     - APPVEYOR_BUILD_WORKER_IMAGE: Ubuntu1804
//       nodejs_version: 8
//     - APPVEYOR_BUILD_WORKER_IMAGE: Ubuntu1804
//       nodejs_version: 9
//     - APPVEYOR_BUILD_WORKER_IMAGE: Ubuntu1804
//       nodejs_version: lts/*
//
//     - APPVEYOR_BUILD_WORKER_IMAGE: Visual Studio 2017
//       nodejs_version: 8
//     - APPVEYOR_BUILD_WORKER_IMAGE: Visual Studio 2017
//       nodejs_version: 9
//     - APPVEYOR_BUILD_WORKER_IMAGE: Visual Studio 2017
//       nodejs_version: LTS
//
// build: off
//
// install:
//  - ps: $env:package_version = (Get-Content -Raw -Path package.json | ConvertFrom-Json).version
//  - ps: Update-AppveyorBuild -Version "$env:package_version.$env:APPVEYOR_BUILD_NUMBER"
//  - cmd: powershell -command "Install-Product node $env:nodejs_version"
//  - sh: nvm install $nodejs_version
//  - npm install
//
// test_script:
//   - node --version
//   - npm test
//
// `,

'.eslintrc.yml' : //
`
env :
  browser : true
  commonjs : true
  es6 : true
  node : true
extends :
  - 'eslint:recommended'
# plugins :
  # - 'for-wtools'
  # - 'optimize-regex'
  # - 'unicorn'
globals :
  Atomics : readonly
  SharedArrayBuffer : readonly
parserOptions :
  ecmaVersion : 2020
rules :
  accessor-pairs : error
  array-bracket-newline :
    - error
    - multiline : true
  array-bracket-spacing :
    - error
    - always
  array-callback-return : off
  array-element-newline : off
  arrow-body-style : off
  no-prototype-builtins : error
  arrow-parens : error
  arrow-spacing :
    - error
    - after : true
      before : true
  block-scoped-var : error
  block-spacing :
    - error
    - always
  callback-return : error
  camelcase : off
  capitalized-comments : off
  class-methods-use-this : error
  comma-dangle :
    - error
    - only-multiline
    -
      arrays : only-multiline
      objects : only-multiline
      imports : never
      exports : never
      functions : never
  comma-spacing :
    - error
    -
      # before : true
      after : true
  comma-style : off
  computed-property-spacing :
    - error
    - always
  consistent-return : off
  default-case : error
  default-param-last : error
  dot-location :
    - error
    - property
  dot-notation : off
  eol-last : error
  eqeqeq : error
  no-unexpected-multiline : off
  func-name-matching : off
  func-names : off
  func-style :
    - error
    - declaration
    - allowArrowFunctions : true
  function-paren-newline :
    - error
    - consistent
  generator-star-spacing : error
  no-useless-escape : off
  global-require : off
  grouped-accessor-pairs : error
  guard-for-in : off
  handle-callback-err : error
  id-blacklist : error
  id-length : off
  id-match : error
  implicit-arrow-linebreak :
    - error
    - beside
  indent :
    - error
    - 2
    -
      outerIIFEBody : 0
      MemberExpression : 0
      ignoredNodes : [ "IfStatement.body", "WhileStatement.body", "ForStatement.body" ]
  indent-legacy : off
  init-declarations : off
  key-spacing :
    - error
    -
      beforeColon : true
      afterColon : true
      mode : minimum
  keyword-spacing :
    - error
    -
      before : false
      after : false
      overrides :
        return : { 'after' : true }
        let : { 'after' : true }
        const : { 'after' : true }
        var : { 'after' : true }
  line-comment-position : off
  linebreak-style :
    - error
    - unix
  lines-around-comment : off
  lines-around-directive : error
  lines-between-class-members : off
  max-classes-per-file : off
  max-lines : off
  max-lines-per-function : off
  max-params :
    - error
    - max : 3
  max-len :
    - error
    -
      code : 130
      comments : 130
      ignoreUrls : true
      ignoreStrings : true
      ignoreRegExpLiterals : true
  multiline-comment-style : off
  multiline-ternary :
    - error
    - never
  new-parens : off
  newline-after-var : off
  newline-before-return : off
  newline-per-chained-call : error
  no-alert : error
  no-array-constructor : off
  no-await-in-loop : error
  no-bitwise : off
  no-buffer-constructor : error
  no-caller : error
  no-catch-shadow : off
  no-confusing-arrow : off
  no-console : off
  no-constructor-return : error
  no-continue : off
  no-empty : off
  no-div-regex : error
  no-dupe-else-if : error
  no-duplicate-imports : error
  no-else-return : off
  no-empty-function : off
  no-eq-null : error
  no-eval : error
  no-extend-native : error
  no-extra-bind : error
  no-extra-label : error
  no-extra-parens :
    - off
  no-floating-decimal : error
  no-implicit-coercion :
    - error
    -
      allow :
        - '!!'
        - '+'
  no-implicit-globals : error
  no-implied-eval : error
  no-import-assign : error
  no-inline-comments : off
  no-invalid-this : off
  no-iterator : error
  no-label-var : error
  no-labels : error
  no-lone-blocks : error
  no-lonely-if : off
  no-loop-func : error
  no-magic-numbers : off
  no-mixed-operators : off
  no-mixed-requires : error
  no-multi-assign : off
  no-multi-spaces :
    - error
    -
      ignoreEOLComments : true
      exceptions :
        Property : true
        VariableDeclarator : true
        ImportDeclaration : true

  no-multi-str : error
  no-multiple-empty-lines : error
  no-native-reassign : error
  no-negated-condition : off
  no-negated-in-lhs : error
  no-nested-ternary : error
  no-new : error
  no-new-func : error
  no-new-object : error
  no-new-require : error
  no-new-wrappers : error
  no-octal-escape : error
  no-param-reassign : off
  no-path-concat : off
  no-plusplus : off
  no-process-env : error
  no-process-exit : error
  no-proto : error
  no-restricted-globals : error
  no-restricted-imports : error
  no-restricted-modules : error
  no-restricted-properties : error
  no-restricted-syntax : error
  no-return-assign : off
  no-return-await : error
  no-script-url : error
  no-self-compare : error
  no-sequences : error
  no-setter-return : error
  no-shadow : off
  no-shadow-restricted-names : error
  no-spaced-func : off
  no-sync : off
  no-tabs : error
  no-ternary : off
  no-throw-literal : error
  no-trailing-spaces : error
  no-undef-init : off
  no-undefined : off
  no-underscore-dangle : off
  no-unmodified-loop-condition : error
  no-unneeded-ternary : error
  no-unused-expressions : off
  no-extra-semi : off
  no-use-before-define : off
  no-useless-call : off
  no-useless-computed-key : error
  no-useless-concat : off
  no-useless-constructor : error
  no-useless-rename : error
  no-useless-return : off
  no-var : off
  no-redeclare : off
  no-void : error
  no-warning-comments : off
  no-self-assign : off
  no-whitespace-before-property : error
  nonblock-statement-body-position :
    - error
    - any
  object-property-newline :
    - error
    -
      allowAllPropertiesOnSameLine : true
  object-shorthand :
    - error
    - properties
  one-var :
    - error
    -
      initialized : never
      uninitialized : consecutive
  one-var-declaration-per-line : error
  operator-assignment : off
  operator-linebreak :
    - error
    - before
    -
      overrides :
        '=' : 'after'
        '+=' : 'after'
        '-=' : 'after'
        '*=' : 'after'
        '/=' : 'after'
  padded-blocks : off
  padding-line-between-statements : error
  prefer-arrow-callback : off
  prefer-const : off
  prefer-destructuring : off
  prefer-exponentiation-operator : off
  prefer-numeric-literals : error
  prefer-object-spread : error
  prefer-promise-reject-errors : error
  prefer-reflect : off
  prefer-regex-literals : error
  prefer-rest-params : off
  prefer-spread : off
  prefer-template : off
  quote-props :
    - error
    - consistent
  quotes :
    - error
    - single
    - allowTemplateLiterals : true
  radix : off
  require-atomic-updates : error
  require-await : off
  require-unicode-regexp : off
  rest-spread-spacing :
    - error
    - always
  semi : off
  semi-spacing : off
  semi-style :
    - error
    - last
  sort-imports : error
  sort-keys : off
  sort-vars : off
  space-before-blocks : off
  space-before-function-paren : off
  space-infix-ops : off
  space-unary-ops : off
  spaced-comment : off
  strict : off
  switch-colon-spacing :
    - error
    -
      before : true
      after : true
  symbol-description : error
  template-curly-spacing : off
  template-tag-spacing : off
  unicode-bom :
    - error
    - never
  vars-on-top : off
  wrap-regex : off
  yield-star-spacing : error
  no-undef : off
  no-debugger : off
  new-cap : off
  no-mixed-spaces-and-tabs : error

  # curly

  curly : off
  object-curly-newline :
    - error
  object-curly-spacing :
    - error
    - always
  brace-style :
    - error
    - allman
    - allowSingleLine : true
  space-in-parens :
    - error
    - always
    - exceptions : [ 'empty' ]
    # - exceptions : [ 'empty', '{}' ]
    # - exceptions : [ 'empty', '{}', '[]' ]
  space-in-brackets : off

  # # plugins
  #
  # # optimize-regex/optimize-regex : warn
  # unicorn/better-regex : warn
  # unicorn/no-unsafe-regex : warn
  # unicorn/no-unused-properties : warn
  # unicorn/no-nested-ternary : error
  #
  # for-wtools/filename :
  #   - warn
  # # for-wtools/space-in-parens :
  # #   - error
  # #   - always
  # #   - exceptions : [ 'empty' ]
  # #   # - exceptions : [ 'empty', '{}' ]
  # #   # - exceptions : [ 'empty', '{}', '[]' ]

  # warn

  no-template-curly-in-string : warn
  no-unreachable : warn
  no-constant-condition : warn
  no-unused-vars :
    - warn
    - args : 'none'

  # play with this later

  func-call-spacing : off
    # - error
    # - never
    # - allowNewlines : true
  consistent-this : off
  prefer-named-capture-group : off
  valid-jsdoc : error
  require-jsdoc : off
  max-statements-per-line : off
  max-statements :
    - error
    - max : 100
  complexity :
    - error
    - max : 100
  max-nested-callbacks :
    - error
    - max : 5
  max-depth :
    - error
    - max : 5
`,

'.gitattributes' : //
`
*.s linguist-language=JavaScript
*.ss linguist-language=JavaScript
*.js linguist-language=JavaScript
`,

'.gitignore' : //
`
./_
.*
-*
*.log
*.db
*.tmp
*.out
node_modules
package-lock.json
`,

'LICENSE' : //
`
Copyright (c) 2013-2020 {{about/full.name}}

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
`,

'was.package.json' : //
`
{
  "name" : "{{package/lowName}}",
  "version" : "0.3.0",
  "description" : "___",
  "author" : "{{about/full.name}} <{{about/email}}>",
  "license" : "MIT",
  "main" : "proto/dwtools/___",
  "files" :
  [
    "proto/dwtools/___",
    "proto/dwtools/Tools.s"
  ],
  "scripts" :
  {
    "test" : "wtest .run proto",
    "docgen" : "wdocgen .build proto"
  },
  "repository" :
  {
    "type" : "git",
    "url" : "https://github.com/{{about/user}}/{{package/name}}.git"
  },
  "bugs" :
  {
    "url" : "https://github.com/{{about/user}}/{{package/name}}/issues"
  },
  "dependencies" :
  {
    "wTools" : ""
  },
  "devDependencies" :
  {
    "wTesting" : "",
    "{{package/lowName}}" : "file:."
  },
  "keywords" :
  [
    "wTools"
  ]
}
`,

'README.md' : //
`
# {{package/name}} -- Experimental! [![Build Status](https://travis-ci.org/{{about/user}}/{{package/name}}.svg?branch=master)](https://travis-ci.org/{{about/user}}/{{package/name}})

___

## Try out
\`\`\`
npm install
node sample/Sample.js
\`\`\`

`,

}

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
