( function _FileProvider_Extract_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  require( './aFileProvider.test.s' );
}

//

var _ = _global_.wTools;
var Parent = wTests[ 'Tools.mid.files.fileProvider.Abstract' ];

_.assert( !!Parent );

//

// var filesTree =
// {
//   'folder.abc' :
//   {
//     'test1.js' : "test\n.gitignore\n.travis.yml\nMakefile\nexample.js\n",
//     'test2' : "var concatMap = require('concat-map');\nvar balanced = require('balanced-match');",
//     'folder2.x' :
//     {
//       'test1.txt' : "var concatMap = require('concat-map');\nvar balanced = require('balanced-match');",
//     }
//   },
//   'test_dir' :
//   {
//     'test3.js' : 'test\n.gitignore\n.travis.yml\nMakefile\nexample.js\n',
//   },
//   'file1' : 'Excepteur sint occaecat cupidatat non proident',
//   'file' : 'abc',
//   // 'linkToFile' : [{ hardLink : '/file' }],
//   // 'linkToUnknown' : [{ hardLink : '/unknown' }],
//   // 'linkToDir' : [{ hardLink : '/test_dir' }],
//   'softLinkToFile' : [{ softLink : '/file' }],
//   'softLinkToUnknown' : [{ softLink : '/unknown' }],
//   'softLinkToDir' : [{ softLink : '/test_dir' }],
// }

//

function onSuiteBegin( test )
{
  let context = this;
  Parent.onSuiteBegin.apply( this, arguments );
  context.provider = _.FileProvider.Extract({ usingExtraStat : 1, protocols : [ 'current', 'second' ] });
  context.system = _.FileProvider.System({ providers : [ context.provider ] });
  let path = context.provider.path;
  context.suitePath = path.pathDirTempOpen( 'FilesFind' );
  context.globalFromPreferred = function globalFromPreferred( path ){ return path };
}

//

function onSuiteEnd()
{
  let context = this;
  let path = this.provider.path;
  // _.assert( _.mapKeys( context.provider.filesTree ).length === 1 ); // qqq : uncomment it, please
  return Parent.onSuiteEnd.apply( this, arguments );
}

//

function pathFor( filePath )
{
  let self = this;
  return self.provider.path.normalize('/' + filePath );
}

// --
// tests
// --

function copy( test )
{

  test.case = 'default';

  var extract1 = new _.FileProvider.Extract();
  var extract2 = new _.FileProvider.Extract({});
  test.is( extract1.filesTree !== extract2.filesTree );

  test.case = 'from map with constructor';

  var op = { filesTree : {} }
  var extract1 = new _.FileProvider.Extract( op );
  var extract2 = new _.FileProvider.Extract( op );
  test.is( op.filesTree === extract1.filesTree );
  test.is( extract1.filesTree === extract2.filesTree );

  test.case = 'from map with copy';

  var op = { filesTree : {} }
  var extract1 = new _.FileProvider.Extract( op );
  var extract2 = new _.FileProvider.Extract();
  extract2.copy( op );
  test.is( op.filesTree === extract1.filesTree );
  test.is( extract1.filesTree === extract2.filesTree );

  /* !!! fix that */

  // test.case = 'from another instance with constructor';
  //
  // var op = { filesTree : {} }
  // var extract1 = new _.FileProvider.Extract( op );
  // var extract2 = new _.FileProvider.Extract( extract1 );
  // test.is( op.filesTree === extract1.filesTree );
  // test.is( extract1.filesTree !== extract2.filesTree );
  //
  // test.case = 'from another instance with copy';
  //
  // var op = { filesTree : {} }
  // var extract1 = new _.FileProvider.Extract( op );
  // var extract2 = new _.FileProvider.Extract();
  // extract2.copy( extract1 );
  // test.is( op.filesTree === extract1.filesTree );
  // test.is( extract1.filesTree !== extract2.filesTree );
  //
  // test.case = 'from another instance with clone';
  //
  // var op = { filesTree : {} }
  // var extract1 = new _.FileProvider.Extract( op );
  // var extract2 = extract1.clone();
  // extract2.copy( extract1 );
  // test.is( op.filesTree === extract1.filesTree );
  // test.is( extract1.filesTree !== extract2.filesTree );

}

// --
// declare
// --

var Proto =
{

  name : 'Tools.mid.files.fileProvider.Extract',
  silencing : 1,
  abstract : 0,
  enabled : 1,
  routineTimeOut : 30000,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    // filesTree,
    provider : _.FileProvider.Extract( { usingExtraStat : 1 } ),
    globalFromPreferred : null,
    pathFor,
    testFile : '/file1'
  },

  tests :
  {

    copy,

  },

}

//

var Self = new wTestSuite( Proto ).inherit( Parent );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
