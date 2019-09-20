( function _StarterLegacy_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../starter/IncludeTop.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
//
// --

function trivial( test )
{
  var srcPath = _.path.resolve( __dirname, '../../..' );
  var tempPath = _.path.join( srcPath, 'tmp.tmp' );
  var initScriptPath = _.path.join( tempPath, 'Init.s' );
  var indexHtmlPath = _.path.join( tempPath, 'Index.html' );

  var indexHtmlSource =
  `<html>
    <head>
      <script src="./Test.raw.filesmap.s" type="text/javascript"></script>
      <script src="./Test.raw.starter.config.s" type="text/javascript"></script>
      <script src="./StarterInit.run.s" type="text/javascript"></script>
      <script src="./StarterStart.run.s" type="text/javascript"></script>
    </head>
  </html>`
  ;
  var initScriptSource = `console.log( 'Init script' )`;

  /*  */

  _.fileProvider.filesDelete( tempPath );
  _.fileProvider.fileWrite( indexHtmlPath, indexHtmlSource );
  _.fileProvider.fileWrite( initScriptPath, initScriptSource );

  /*
    ... grab all required files into tmp/dwtools dir ...
  */

  try
  {

    var starterMaker = new _.StarterMaker
    ({
      appName : 'Test',
      inPath : '/',
      outPath : '/',
      toolsPath : '/dwtools',
      initScriptPath : '/tmp.tmp/Init.s',
      offline : 1,
      verbosity : 5,
      logger : new _.Logger({ output : logger }),
    });

    starterMaker.fileProviderForm();
    starterMaker.fromHardDriveRead({ srcPath : _.uri.join( 'file:///', srcPath ) });

    starterMaker.form();

    starterMaker.starterMake();
    starterMaker.filesMapMake();
    starterMaker.toHardDriveWrite({ dstPath : _.uri.join( 'file:///', tempPath ) });

  }
  catch( err )
  {
    test.exceptionReport({ err : err });
  }


  var files = _.fileProvider.dirRead( tempPath );
  var expected =
  [
    'Index.html',
    'Init.s',
    'StarterInit.run.s',
    'StarterPreloadEnd.run.s',
    'StarterStart.run.s',
    'Test.raw.filesmap.s',
    'Test.raw.starter.config.s'
  ];
  test.identical( files, expected )

  _.fileProvider.filesDelete( tempPath );
}

trivial.timeOut = 60000;

// --
//
// --

var Self =
{

  name : 'Tools.mid.StarterLegacy',
  silencing : 1,
  enabled : 1,

  tests :
  {
    trivial,
  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
