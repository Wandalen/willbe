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

//

function authorRecordParse( test )
{
  test.case = 'empty map';
  var src = {};
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, {} );
  test.true( got === src );

  test.case = 'map with valid fields';
  var src = { name : 'name', email : 'email' };
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, { name : 'name', email : 'email' } );
  test.true( got === src );

  test.case = 'map with invalid fields';
  var src = { unknown : 'unknown', wrong : 'wrong' };
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, { unknown : 'unknown', wrong : 'wrong' } );
  test.true( got === src );

  /* */

  test.case = 'empty string';
  var src = '';
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, { name : '' } );

  test.case = 'string with valid name';
  var src = 'name';
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, { name : 'name' } );

  test.case = 'string with invalid name';
  var src = 'name <';
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, { name : 'name <' } );

  test.case = 'string with name and email';
  var src = 'name <email>';
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, { name : 'name', email : 'email' } );

  test.case = 'string with name and url';
  var src = 'name (url)';
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, { name : 'name', url : 'url' } );

  test.case = 'string with name and url';
  var src = 'name (url)';
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, { name : 'name', url : 'url' } );

  test.case = 'string with name, email and url';
  var src = 'name <email> (url)';
  var got = _.will.transform.authorRecordParse( src );
  test.identical( got, { name : 'name', email : 'email', url : 'url' } );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordParse() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordParse( { name : 'name' }, { email : 'email' } ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordParse([ 'name', 'email' ]) );
}

//

function authorRecordStr( test )
{
  test.case = 'empty string';
  var src = '';
  var got = _.will.transform.authorRecordStr( src );
  test.identical( got, '' );

  test.case = 'string with valid format';
  var src = 'name <email> (url)';
  var got = _.will.transform.authorRecordStr( src );
  test.identical( got, 'name <email> (url)' );

  test.case = 'string with invalid format';
  var src = 'name <email url)';
  var got = _.will.transform.authorRecordStr( src );
  test.identical( got, 'name <email url)' );

  /* */

  test.case = 'map with only name';
  var src = { name : 'name' };
  var got = _.will.transform.authorRecordStr( src );
  test.identical( got, 'name' );

  test.case = 'map with name and email';
  var src = { name : 'name', email : 'email' };
  var got = _.will.transform.authorRecordStr( src );
  test.identical( got, 'name <email>' );

  test.case = 'map with name and url';
  var src = { name : 'name', url : 'url' };
  var got = _.will.transform.authorRecordStr( src );
  test.identical( got, 'name (url)' );

  test.case = 'map with name, email and url';
  var src = { name : 'name', email: 'email', url : 'url' };
  var got = _.will.transform.authorRecordStr( src );
  test.identical( got, 'name <email> (url)' );

  test.case = 'map with invalid name';
  var src = { name : 'name <' };
  var got = _.will.transform.authorRecordStr( src );
  test.identical( got, 'name <' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordStr() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordStr( 'name', 'email' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordStr([ 'name <email>' ]) );

  test.case = 'src map has unknown fields';
  test.shouldThrowErrorSync( () => _.will.transform.authorRecordStr({ name : 'name', unknown : 'unknown' }) );
}

//

function submodulesSwitch( test )
{
  test.case = 'empty map, enabled - 0';
  var src = {};
  var got = _.will.transform.submodulesSwitch( src, 0 );
  test.identical( got, {} );
  test.true( got === src );

  test.case = 'empty map, enabled - 1';
  var src = {};
  var got = _.will.transform.submodulesSwitch( src, 1 );
  test.identical( got, {} );
  test.true( got === src );

  /* */

  test.case = 'map with only string submodules, enabled - 0';
  var src =
  {
    Module1 : '/local/Module/',
    Module2 : 'git+https:///github.com/user/Remote.git',
  };
  var got = _.will.transform.submodulesSwitch( src, 0 );
  var exp =
  {
    Module1 : { path : '/local/Module/', enabled : 0 },
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 0 },
  };
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'map with only string submodules, enabled - 1';
  var src =
  {
    Module1 : '/local/Module/',
    Module2 : 'git+https:///github.com/user/Remote.git',
  };
  var got = _.will.transform.submodulesSwitch( src, 1 );
  var exp =
  {
    Module1 : { path : '/local/Module/', enabled : 1 },
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 1 },
  };
  test.identical( got, exp );
  test.true( got === src );

  /* */

  test.case = 'map with only map submodules, enabled - 0';
  var src =
  {
    Module1 : { path : '/local/Module/', enabled : 1, criterion : { default : 1 } },
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 0 },
  };
  var got = _.will.transform.submodulesSwitch( src, 0 );
  var exp =
  {
    Module1 : { path : '/local/Module/', enabled : 0, criterion : { default : 1 } },
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 0 },
  };
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'map with only string submodules, enabled - 1';
  var src =
  {
    Module1 : { path : '/local/Module/', enabled : 1, criterion : { default : 1 } },
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 0 },
  };
  var got = _.will.transform.submodulesSwitch( src, 1 );
  var exp =
  {
    Module1 : { path : '/local/Module/', enabled : 1, criterion : { default : 1 } },
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 1 },
  };
  test.identical( got, exp );
  test.true( got === src );

  /* */

  test.case = 'map with mixed submodules, enabled - 0';
  var src =
  {
    Module1 : '/local/Module/',
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 0 },
  };
  var got = _.will.transform.submodulesSwitch( src, 0 );
  var exp =
  {
    Module1 : { path : '/local/Module/', enabled : 0 },
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 0 },
  };
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'map with only string submodules, enabled - 1';
  var src =
  {
    Module1 : '/local/Module/',
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 0 },
  };
  var got = _.will.transform.submodulesSwitch( src, 1 );
  var exp =
  {
    Module1 : { path : '/local/Module/', enabled : 1 },
    Module2 : { path : 'git+https:///github.com/user/Remote.git', enabled : 1 },
  };
  test.identical( got, exp );
  test.true( got === src );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.submodulesSwitch() );

  test.case = 'not enough arguments';
  test.shouldThrowErrorSync( () => _.will.transform.submodulesSwitch( {} ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.transform.submodulesSwitch( {}, 0, 'extra' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.will.transform.submodulesSwitch( [], 0 ) );

  test.case = 'wrong type of enabled';
  test.shouldThrowErrorSync( () => _.will.transform.submodulesSwitch( {}, [] ) );
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
  },

  tests :
  {

    submodulesSwitch,

    authorRecordParse,
    authorRecordStr,
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
