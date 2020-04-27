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

    'ModuleForTesting1.s' :
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
      require( 'wModuleForTesting1' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  module[ 'exports' ] = _global_.wModuleForTesting1;

}
`
  }

},

'.im.will.yml' : //
`

submodule :

  wModuleForTesting1 :
    path : npm:///wModuleForTesting1
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
  - wModuleForTesting1
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
  <title>
   wModuleForTesting1 unit test
  </title>
  <script src="./node_modules/wModuleForTesting1/proto/Base.s">
  </script>
  <script src="./Sample1.js">
  </script>
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

'.gitattributes' : //
`
*.s linguist-language=JavaScript
*.ss linguist-language=JavaScript
*.js linguist-language=JavaScript
`,

'.gitignore' : //
`
.*
-*
*.log
*.db
*.sh
*.bat
*.tmp
*.special
*.out
build
builder
html.build.coffee
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
    "proto/dwtools/ModuleForTesting1.s"
  ],
  "scripts" :
  {
    "test" : "wtest .run proto",
    "docgen" : "wdocgen .build proto"
  },
  "repository" :
  {
    "type" : "git",
    "url" : "https ://github.com/{{about/user}}/{{package/name}}.git"
  },
  "bugs" :
  {
    "url" : "https ://github.com/{{about/user}}/{{package/name}}/issues"
  },
  "dependencies" :
  {
    "wModuleForTesting1" : ""
  },
  "devDependencies" :
  {
    "wTesting" : "",
    "{{package/lowName}}" : "file:."
  },
  "keywords" :
  [
    "wModuleForTesting1"
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
