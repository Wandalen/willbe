( function _Transform_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../node_modules/Tools' );

  _.include( 'wTesting' );

  require( '../will/include/Mid.s' );
}

let _global = _global_;
let _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let context = this;

  context.suiteTempPath = _.path.tempOpen( _.path.join( __dirname, '../..'  ), 'willbe' );
  context.assetsOriginalPath = _.path.join( __dirname, '_asset' );
  context.repoDirPath = _.path.join( context.assetsOriginalPath, '-repo' );

  let reposDownload = require( './ReposDownload.s' );
  return reposDownload().then( () =>
  {
    _.assert( _.fileProvider.isDir( _.path.join( context.repoDirPath, 'ModuleForTesting1' ) ) );
    return null;
  });
}

//

function onSuiteEnd()
{
  let context = this;
  _.assert( _.strHas( context.suiteTempPath, '/willbe-' ) )
  _.path.tempClose( context.suiteTempPath );
}

//

function assetFor( test, name )
{
  let context = this;

  if( !name )
  name = test.name;

  let a = test.assetFor( name );

  a.will = new _.Will;

  a.find = a.fileProvider.filesFinder
  ({
    withTerminals : 1,
    withDirs : 1,
    withStem : 1,
    allowingMissed : 1,
    maskPreset : 0,
    outputFormat : 'relative',
    filter :
    {
      recursive : 2,
      maskAll :
      {
        excludeAny : [ /(^|\/)\.git($|\/)/, /(^|\/)\+/ ],
      },
      maskTransientAll :
      {
        excludeAny : [ /(^|\/)\.git($|\/)/, /(^|\/)\+/ ],
      },
    },
  });


  a.findNoModules = a.fileProvider.filesFinder
  ({
    withTerminals : 1,
    withDirs : 1,
    withStem : 1,
    allowingMissed : 1,
    maskPreset : 0,
    outputFormat : 'relative',
    filter :
    {
      recursive : 2,
      maskAll :
      {
        excludeAny : [ /(^|\/)\.git($|\/)/, /(^|\/)\+/, /(^|\/)\.module\/.*/ ],
      },
      maskTransientAll :
      {
        excludeAny : [ /(^|\/)\.git($|\/)/, /(^|\/)\+/, /(^|\/)\.module\/.*/ ],
      },
    },
  });

  a.reflect = function reflect()
  {
    a.fileProvider.filesDelete( a.routinePath );
    a.fileProvider.filesReflect({ reflectMap : { [ a.originalAssetPath ] : a.routinePath } });
    try
    {
      a.fileProvider.filesReflect({ reflectMap : { [ context.repoDirPath ] : a.abs( context.suiteTempPath, '_repo' ) } });
    }
    catch( err )
    {
      _.errAttend( err );
      _.Consequence().take( null )
      .delay( 3000 )
      .deasync();
      a.fileProvider.filesDelete( a.abs( context.suiteTempPath, '_repo' ) );
      a.fileProvider.filesReflect({ reflectMap : { [ context.repoDirPath ] : a.abs( context.suiteTempPath, '_repo' ) } });
    }
  }

  _.assert( a.fileProvider.isDir( a.originalAssetPath ) );

  return a;
}

// --
// tests
// --

function authorRecordNormalize( test )
{
  test.case = 'string with only name';
  var src = 'name';
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name' );

  test.case = 'string with only name, two parts, symbols';
  var src = 'name #name';
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name #name' );

  test.case = 'string with name and email';
  var src = 'name <user@domain.com>';
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name <user@domain.com>' );

  test.case = 'string with name and url';
  var src = 'name (https://github.com/user)';
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name (https://github.com/user)' );

  test.case = 'string with name, email and url';
  var src = 'name <user@domain.com> (https://github.com/user)';
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name <user@domain.com> (https://github.com/user)' );

  /* */

  test.case = 'map with only name';
  var src = { name : 'name' };
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name' );

  test.case = 'map with only name, two parts, symbols';
  var src = { name : 'name #name' };
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name #name' );

  test.case = 'map with name and email';
  var src = { name : 'name', email : 'user@domain.com' };
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name <user@domain.com>' );

  test.case = 'map with name and url';
  var src = { name : 'name', url : 'https://github.com/user' };
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name (https://github.com/user)' );

  test.case = 'string with name, email and url';
  var src = { name : 'name', email : 'user@domain.com', url : 'https://github.com/user' };
  var got = _.will.transform.authorRecordNormalize( src );
  test.identical( got, 'name <user@domain.com> (https://github.com/user)' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordNormalize() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordNormalize( 'name', 'user@domain.com' ) );

  test.case = 'src is empty string';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordNormalize( '' ) );

  test.case = 'src has broken email or url';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordNormalize( 'name <user@domain.com' ) );
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordNormalize( 'name user@domain.com>' ) );
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordNormalize( 'name <>user@domain.com' ) );
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordNormalize( 'name (https://github.com/user' ) );
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordNormalize( 'name https://github.com/user)' ) );
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordNormalize( 'name ()https://github.com/user' ) );
}

// --
// declare
// --

let Self =
{

  name : 'Tools.Willbe.Transform',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,
  routineTimeOut : 30000,

  context :
  {
    suiteTempPath : null,
    assetsOriginalPath : null,
    appJsPath : null,
    repoDirPath : null,
    assetFor,
  },

  tests :
  {

    authorRecordNormalize,

  }

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
