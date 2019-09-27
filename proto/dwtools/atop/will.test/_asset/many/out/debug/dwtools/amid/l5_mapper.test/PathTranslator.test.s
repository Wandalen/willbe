( function _PathTranslator_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../l5_mapper/PathTranslator.s' );

}

var _ = wTools;

// --
// tests
// --

function simple( test )
{
  var rooter = new wPathTranslator();
  rooter.realRootPath = '/a';

  test.case = 'realFor relative'; /* */

  var expected = '/a/x';
  var got = rooter.realFor( 'x' );
  test.identical( got,expected );

  test.case = 'realFor absolute'; /* */

  var expected = '/a/x';
  var got = rooter.realFor( '/x' );
  test.identical( got,expected );

  test.case = 'realFor relative root'; /* */

  var expected = '/a';
  var got = rooter.realFor( '.' );
  test.identical( got,expected );

  test.case = 'realFor absolute root'; /* */

  var expected = '/a';
  var got = rooter.realFor( '/' );
  test.identical( got,expected );

  test.case = 'virtualFor relative'; /* */

  var expected = '/x';
  var got = rooter.virtualFor( 'x' );
  test.identical( got,expected );

  test.case = 'virtualFor absolute'; /* */

  var expected = '/x';
  var got = rooter.virtualFor( '/a/x' );
  test.identical( got,expected );

  test.case = 'virtualFor absolute and redundant slashes'; /* */

  var expected = '/x';
  var got = rooter.virtualFor( '/a/x/' );
  test.identical( got,expected );

  test.case = 'virtualFor relative absolute'; /* */

  var expected = '/';
  var got = rooter.virtualFor( '.' );
  test.identical( got,expected );

}

//

function currentDir( test )
{
  var rooter = new wPathTranslator();

  test.identical( rooter.realCurrentDirPath,'/' );
  test.identical( rooter.virtualCurrentDirPath,'/' );

  rooter.realRootPath = '/a';

  test.identical( rooter.realCurrentDirPath,'/a' );
  test.identical( rooter.virtualCurrentDirPath,'/' );

  rooter.realCurrentDirPath = '/a/b/c';
  test.identical( rooter.realCurrentDirPath,'/a/b/c' );
  test.identical( rooter.virtualCurrentDirPath,'/b/c' );

  rooter.virtualCurrentDirPath = '/b';
  test.identical( rooter.realCurrentDirPath,'/a/b' );
  test.identical( rooter.virtualCurrentDirPath,'/b' );

  test.case = 'realFor relative'; /* */

  var expected = '/a/b/x';
  var got = rooter.realFor( 'x' );
  test.identical( got,expected );

  test.case = 'realFor absolute'; /* */

  var expected = '/a/x';
  var got = rooter.realFor( '/x' );
  test.identical( got,expected );

  test.case = 'realFor relative root'; /* */

  var expected = '/a/b';
  var got = rooter.realFor( '.' );
  test.identical( got,expected );

  test.case = 'realFor absolute root'; /* */

  var expected = '/a';
  var got = rooter.realFor( '/' );
  test.identical( got,expected );

  test.case = 'virtualFor relative'; /* */

  var expected = '/b/x';
  var got = rooter.virtualFor( 'x' );
  test.identical( got,expected );

  test.case = 'virtualFor absolute'; /* */

  var expected = '/b/x';
  var got = rooter.virtualFor( '/a/b/x' );
  test.identical( got,expected );

  test.case = 'virtualFor absolute and redundant slashes'; /* */

  var expected = '/b/x';
  var got = rooter.virtualFor( '/a/b/x/' );
  test.identical( got,expected );

  test.case = 'virtualFor relative absolute'; /* */

  var expected = '/b';
  debugger;
  var got = rooter.virtualFor( '.' );
  test.identical( got,expected );

  test.case = 'change realRootPath'; /* */

  var rooter = new wPathTranslator({ realRootPath : '/a' });
  test.identical( rooter.realCurrentDirPath,'/a' );
  test.identical( rooter.virtualCurrentDirPath,'/' );

  rooter.realRootPath = '/a/b/c';
  test.identical( rooter.realCurrentDirPath,'/a/b/c' );
  test.identical( rooter.virtualCurrentDirPath,'/' );

  test.case = 'change realRootPath sinking'; /* */

  var rooter = new wPathTranslator({ realRootPath : '/a' });
  rooter.realCurrentDirPath = '/a/b/c';
  test.identical( rooter.realCurrentDirPath,'/a/b/c' );
  test.identical( rooter.virtualCurrentDirPath,'/b/c' );

  rooter.realRootPath = '/a/b';
  test.identical( rooter.realCurrentDirPath,'/a/b/c' );
  test.identical( rooter.virtualCurrentDirPath,'/c' );

  rooter.realRootPath = '/a/b/c';
  test.identical( rooter.realCurrentDirPath,'/a/b/c' );
  test.identical( rooter.virtualCurrentDirPath,'/' );

  debugger;
  rooter.realRootPath = '/a/b/c/d';
  test.identical( rooter.realCurrentDirPath,'/a/b/c/d' );
  test.identical( rooter.virtualCurrentDirPath,'/' );

  test.case = 'change realCurrentDirPath relative'; /* */

  var rooter = new wPathTranslator({ realRootPath : '/a' });
  rooter.realCurrentDirPath = 'b/c';
  test.identical( rooter.realCurrentDirPath,'/a/b/c' );
  test.identical( rooter.virtualCurrentDirPath,'/b/c' );

}

//

function make( test )
{

  test.case = 'make with realCurrentDirPath'; /* */

  var rooter = new wPathTranslator({ realCurrentDirPath : _.path.refine( __dirname ) });
  test.identical( rooter.realCurrentDirPath,_.path.refine( __dirname ) );
  test.identical( rooter.virtualCurrentDirPath,_.path.refine( __dirname ) );

}

// --
// declare
// --

var Self =
{

  name : 'Tools.mid.PathTranslator',
  // verbosity : 7,

  context :
  {
  },

  tests :
  {

    simple : simple,
    currentDir : currentDir,
    make : make,
  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
