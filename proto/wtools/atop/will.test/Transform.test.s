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

  context.suiteTempPath = _.path.tempOpen( _.path.join( __dirname, '../..' ), 'willbe' );
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
  var src = { name : 'name', email : 'email', url : 'url' };
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

function interpreterParse( test )
{
  test.case = 'src - empty map';
  var got = _.will.transform.interpreterParse( {} );
  test.identical( got, {} );

  test.case = 'src - map';
  var got = _.will.transform.interpreterParse({ some : 1 });
  test.identical( got, { some : 1 } );

  /* */

  test.case = 'src - string, interpreter with version';
  var got = _.will.transform.interpreterParse( 'njs = 10.0.0' );
  test.identical( got, { njs : '= 10.0.0' } );

  test.case = 'src - string, interpreter with not valid version';
  var got = _.will.transform.interpreterParse( 'njs invalid' );
  test.identical( got, { njs : 'invalid' } );

  test.case = 'src - string, interpreter with not valid version with several spaces';
  var got = _.will.transform.interpreterParse( 'njs v10.0.0 - v12.0.0' );
  test.identical( got, { njs : 'v10.0.0 - v12.0.0' } );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.interpreterParse() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.transform.interpreterParse( 'njs >= 10.0.0', 'njs >= 10.0.0' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.will.transform.interpreterParse([ 'njs >= 10.0.0' ]) );

  test.case = 'empty string';
  test.shouldThrowErrorSync( () => _.will.transform.interpreterParse( '' ) );

  test.case = 'string without space';
  test.shouldThrowErrorSync( () => _.will.transform.interpreterParse( 'njs' ) );
}

//

function interpreterNormalize( test )
{
  test.case = 'not njs interpreter - string without version prefix';
  var got = _.will.transform.interpreterNormalize( 'npm 6.0.0' );
  test.identical( got, 'npm = 6.0.0' );

  test.case = 'not njs interpreter - string';
  var got = _.will.transform.interpreterNormalize( 'npm >= 6.0.0' );
  test.identical( got, 'npm >= 6.0.0' );

  test.case = 'njs interpreter - string without version prefix';
  var got = _.will.transform.interpreterNormalize( 'node 14.0.0' );
  test.identical( got, 'njs = 14.0.0' );

  test.case = 'njs interpreter - string';
  var got = _.will.transform.interpreterNormalize( 'node >= 12.0.0' );
  test.identical( got, 'njs >= 12.0.0' );

  /* */

  test.case = 'not njs interpreter - string without version prefix';
  var got = _.will.transform.interpreterNormalize({ npm : '6.0.0' });
  test.identical( got, 'npm = 6.0.0' );

  test.case = 'not njs interpreter - string';
  var got = _.will.transform.interpreterNormalize({ npm : '>= 6.0.0' });
  test.identical( got, 'npm >= 6.0.0' );

  test.case = 'njs interpreter - string without version prefix';
  var got = _.will.transform.interpreterNormalize({ node : '14.0.0' });
  test.identical( got, 'njs = 14.0.0' );

  test.case = 'njs interpreter - string';
  var got = _.will.transform.interpreterNormalize({ node : '>= 12.0.0' });
  test.identical( got, 'njs >= 12.0.0' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.interpreterNormalize() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.transform.interpreterNormalize( 'njs >= 10.0.0', 'njs >= 10.0.0' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.will.transform.interpreterNormalize([ 'njs >= 10.0.0' ]) );

  test.case = 'wrong format of src';
  test.shouldThrowErrorSync( () => _.will.transform.interpreterNormalize( '' ) );
}

//

function engineNormalize( test )
{
  test.case = 'not njs interpreter - string without version prefix';
  var got = _.will.transform.engineNormalize( 'npm 6.0.0' );
  test.identical( got, 'npm = 6.0.0' );

  test.case = 'not njs interpreter - string';
  var got = _.will.transform.engineNormalize( 'npm >= 6.0.0' );
  test.identical( got, 'npm >= 6.0.0' );

  test.case = 'njs interpreter - string without version prefix, not required format';
  var got = _.will.transform.engineNormalize( 'njs 14.0.0' );
  test.identical( got, 'node = 14.0.0' );

  test.case = 'njs interpreter - string, not required format';
  var got = _.will.transform.engineNormalize( 'njs >= 12.0.0' );
  test.identical( got, 'node >= 12.0.0' );

  test.case = 'njs interpreter - string without version prefix, required format';
  var got = _.will.transform.engineNormalize( 'node 14.0.0' );
  test.identical( got, 'node = 14.0.0' );

  test.case = 'njs interpreter - string, required format';
  var got = _.will.transform.engineNormalize( 'node >= 12.0.0' );
  test.identical( got, 'node >= 12.0.0' );

  /* */

  test.case = 'not njs interpreter - string without version prefix';
  var got = _.will.transform.engineNormalize({ npm : '6.0.0' });
  test.identical( got, 'npm = 6.0.0' );

  test.case = 'not njs interpreter - string';
  var got = _.will.transform.engineNormalize({ npm : '>= 6.0.0' });
  test.identical( got, 'npm >= 6.0.0' );

  test.case = 'njs interpreter - string without version prefix, not required format';
  var got = _.will.transform.engineNormalize({ njs : '14.0.0' });
  test.identical( got, 'node = 14.0.0' );

  test.case = 'njs interpreter - string, not required format';
  var got = _.will.transform.engineNormalize({ njs : '>= 12.0.0' });
  test.identical( got, 'node >= 12.0.0' );

  test.case = 'njs interpreter - string without version prefix, required format';
  var got = _.will.transform.engineNormalize({ node : '14.0.0' });
  test.identical( got, 'node = 14.0.0' );

  test.case = 'njs interpreter - string, required format';
  var got = _.will.transform.engineNormalize({ node : '>= 12.0.0' });
  test.identical( got, 'node >= 12.0.0' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.engineNormalize() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.transform.engineNormalize( 'njs >= 10.0.0', 'njs >= 10.0.0' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.will.transform.engineNormalize([ 'njs >= 10.0.0' ]) );

  test.case = 'wrong format of src';
  test.shouldThrowErrorSync( () => _.will.transform.engineNormalize( '' ) );
}

//

function submoduleMake( test )
{
  test.case = 'o.path - empty string';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : '' });
  var exp = { path : 'npm:///wTools', enabled : 1 };
  test.identical( got, exp );

  test.case = 'o.path - version';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : '0.0.1' });
  var exp = { path : 'npm:///wTools!0.0.1', enabled : 1 };
  test.identical( got, exp );

  test.case = 'o.path - version with range';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : '>= 0.0.1' });
  var exp = { path : 'npm:///wTools!>= 0.0.1', enabled : 1 };
  test.identical( got, exp );

  test.case = 'o.path - tag';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : 'alpha' });
  var exp = { path : 'npm:///wTools!alpha', enabled : 1 };
  test.identical( got, exp );

  /* */

  test.case = 'o.path - url, not git';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : 'https://domain.com/wTools.tar.gz' });
  var exp = { path : 'https://domain.com/wTools.tar.gz', enabled : 1 };
  test.identical( got, exp );

  /* */

  test.case = 'o.path - git path, short form for github.com';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : 'Wandalen/wTools' });
  var exp = { path : 'git+https:///github.com/Wandalen/wTools', enabled : 1 };
  test.identical( got, exp );

  test.case = 'o.path - git path, short form for github.com with version';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : 'Wandalen/wTools.git#0.0.1' });
  var exp = { path : 'git+https:///github.com/Wandalen/wTools.git!0.0.1', enabled : 1 };
  test.identical( got, exp );

  test.case = 'o.path - git path, protocol - https';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : 'https://github.com/Wandalen/wTools.git' });
  var exp = { path : 'git+https:///github.com/Wandalen/wTools.git', enabled : 1 };
  test.identical( got, exp );

  test.case = 'o.path - git path, protocol - https with version';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : 'https://github.com/Wandalen/wTools.git#0.0.1' });
  var exp = { path : 'git+https:///github.com/Wandalen/wTools.git!0.0.1', enabled : 1 };
  test.identical( got, exp );

  test.case = 'o.path - git path, protocol - git+ssh';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : 'git+ssh://git@github.com/Wandalen/wTools.git' });
  var exp = { path : 'git+ssh:///git@github.com/Wandalen/wTools.git', enabled : 1 };
  test.identical( got, exp );

  test.case = 'o.path - git path, protocol - git+ssh with version';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : 'git+ssh://git@github.com/Wandalen/wTools.git#0.0.1' });
  var exp = { path : 'git+ssh:///git@github.com/Wandalen/wTools.git!0.0.1', enabled : 1 };
  test.identical( got, exp );

  /* */

  test.case = 'o.path - empty string, criterions - null';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : '', criterions : null });
  var exp = { path : 'npm:///wTools', enabled : 1 };
  test.identical( got, exp );

  test.case = 'o.path - empty string, criterions - string';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : '', criterions : 'debug' });
  var exp = { path : 'npm:///wTools', enabled : 1, criterion : { debug : 1 } };
  test.identical( got, exp );

  test.case = 'o.path - empty string, criterions - string';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : '', criterions : 'debug' });
  var exp = { path : 'npm:///wTools', enabled : 1, criterion : { debug : 1 } };
  test.identical( got, exp );

  test.case = 'o.path - empty string, criterions - empty array';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : '', criterions : [] });
  var exp = { path : 'npm:///wTools', enabled : 1, criterion : {} };
  test.identical( got, exp );

  test.case = 'o.path - empty string, criterions - array with single element';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : '', criterions : [ 'debug' ] });
  var exp = { path : 'npm:///wTools', enabled : 1, criterion : { debug : 1 } };
  test.identical( got, exp );

  test.case = 'o.path - empty string, criterions - array with several elements';
  var got = _.will.transform.submoduleMake({ name : 'wTools', path : '', criterions : [ 'debug', 'development' ] });
  var exp = { path : 'npm:///wTools', enabled : 1, criterion : { debug : 1, development : 1 } };
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.submoduleMake() );

  test.case = 'without arguments';
  var o = { name : 'wTools', path : '' };
  test.shouldThrowErrorSync( () => _.will.transform.submoduleMake( o, o ) );

  test.case = 'wrong type of options map';
  var o = { name : 'wTools', path : '' };
  test.shouldThrowErrorSync( () => _.will.transform.submoduleMake([ o ]) );

  test.case = 'o.name is not defined string';
  var o = { name : '', path : '' };
  test.shouldThrowErrorSync( () => _.will.transform.submoduleMake( o ) );

  test.case = 'wrong type of o.path';
  var o = { name : 'wTools', path : [ '' ] };
  test.shouldThrowErrorSync( () => _.will.transform.submoduleMake( o ) );

  test.case = 'wrong type of o.criterions';
  var o = { name : 'wTools', path : '', criterions : { wrong : 1 } };
  test.shouldThrowErrorSync( () => _.will.transform.submoduleMake( o ) );
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

//

function npmFromWillfile( test )
{
  test.case = 'o.config - empty';
  var src = { config : {} };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = {};
  test.identical( got, exp );

  test.case = 'map with only name';
  var src = { config : { about : { name : 'wTools' } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { name : 'wTools' };
  test.identical( got, exp );

  test.case = 'map with only version';
  var src = { config : { about : { version : '0.0.1' } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { version : '0.0.1' };
  test.identical( got, exp );

  test.case = 'map with only enabled';
  var src = { config : { about : { enabled : 0 } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { enabled : 0 };
  test.identical( got, exp );

  test.case = 'map with only description';
  var src = { config : { about : { description : 'test module' } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { description : 'test module' };
  test.identical( got, exp );

  test.case = 'map with only keywords';
  var src = { config : { about : { keywords : [ 'test', 'module' ] } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { keywords : [ 'test', 'module' ] };
  test.identical( got, exp );

  test.case = 'map with only license';
  var src = { config : { about : { license : 'MIT' } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { license : 'MIT' };
  test.identical( got, exp );

  test.case = 'map with only author - string';
  var src = { config : { about : { author : 'author <author@domain.com> (https://site.com)' } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { author : 'author <author@domain.com> (https://site.com)' };
  test.identical( got, exp );

  test.case = 'map with only author - map with name and email';
  var src = { config : { about : { author : { name : 'author', email : 'author@domain.com' } } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { author : 'author <author@domain.com>' };
  test.identical( got, exp );

  test.case = 'map with only author - map with name and email and url';
  var src = { config : { about : { author : { name : 'author', email : 'author@domain.com', url : 'https://site.com' } } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { author : 'author <author@domain.com> (https://site.com)' };
  test.identical( got, exp );

  test.case = 'map with only contributors - different';
  var src =
  {
    config :
    {
      about :
      {
        contributors :
        [
          'author1 <author1@domain.com>',
          { name : 'author2', email : 'author2@domain.com' },
          { name : 'author3', email : 'author3@domain.com', url : 'https://site.com' },
        ],
      }
    },
  };
  var got = _.will.transform.npmFromWillfile( src );
  var exp =
  {
    contributors :
    [
      'author1 <author1@domain.com>',
      'author2 <author2@domain.com>',
      'author3 <author3@domain.com> (https://site.com)',
    ]
  };
  test.identical( got, exp );

  test.case = 'map with only scripts';
  var src = { config : { about : { 'npm.scripts' : { script1 : 'script1', script2 : 'script2' } } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { scripts : { script1 : 'script1', script2 : 'script2' } };
  test.identical( got, exp );

  test.case = 'map with only interpreters';
  var src = { config : { about : { interpreters : [ 'njs =10.0.0', 'chromium =67.0.0' ] } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { 'npm.engines' : { node : '10.0.0', chromium : '67.0.0' }, 'engine' : 'node = 10.0.0' };
  test.identical( got, exp );

  test.case = 'map with only repository';
  var src = { config : { path : { repository : 'git+https:///github.com/Wandalen/wTools.git' } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { repository : 'https://github.com/Wandalen/wTools.git' };
  test.identical( got, exp );

  test.case = 'map with only bugtracker';
  var src = { config : { path : { bugtracker : 'https:///github.com/Wandalen/wTools/issues' } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { bugs : 'https://github.com/Wandalen/wTools/issues' };
  test.identical( got, exp );

  test.case = 'map with only entry - string';
  var src = { config : { path : { entry : 'proto/file' } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { main : 'proto/file' };
  test.identical( got, exp );

  test.case = 'map with only entry - map';
  var src = { config : { path : { entry : { path : 'proto/file', criterion : { debug : [ 0, 1 ] } } } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { main : 'proto/file' };
  test.identical( got, exp );

  test.case = 'map with only files';
  var src = { config : { path : { 'npm.files' : [ 'proto/file', 'proto/some', 'out' ] } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { files : [ 'proto/file', 'proto/some', 'out' ] };
  test.identical( got, exp );

  test.case = 'map with only dependencies - different';
  var src =
  {
    config :
    {
      submodule :
      {
        'wTools' : { path : 'npm:///wTools', enabled : 1 },
        'next' : { path : 'npm:///next!0.0.1', enabled : 1 },
        '@module/core' : { path : 'npm:///@module/core!0.0.1', enabled : 1 },
        'https' : { path : 'https://domain/https.tar.gz', enabled : 1 },
        'git' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1 },
        'disabled' : { path : 'git+https:///github.com/user/disabled', enabled : 0 },
        'hd' : { path : 'hd://./user/hd', enabled : 1 },
      }
    }
  };
  var got = _.will.transform.npmFromWillfile( src );
  var exp =
  {
    dependencies :
    {
      'wTools' : '',
      'next' : '0.0.1',
      '@module/core' : '0.0.1',
      'https' : 'https://domain/https.tar.gz',
      'git' : 'https://github.com/user/repo.git#0.0.1',
      'hd' : 'file:./user/hd',
    },
  };
  test.identical( got, exp );

  test.case = 'map with only dependencies - disabled, o.withDisabledSubmodules - 1';
  var src =
  {
    config :
    {
      submodule : { disabled : { path : 'git+https:///github.com/user/disabled', enabled : 0 } }
    },
    withDisabledSubmodules : 1,
  };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { dependencies : { disabled : 'https://github.com/user/disabled' } };
  test.identical( got, exp );

  test.case = 'map with only development dependencies - different';
  var src =
  {
    config :
    {
      submodule :
      {
        'wTools' : { path : 'npm:///wTools', enabled : 1, criterion : { development : 1 } },
        'next' : { path : 'npm:///next!0.0.1', enabled : 1, criterion : { development : 1 } },
        '@module/core' : { path : 'npm:///@module/core!0.0.1', enabled : 1, criterion : { development : 1 } },
        'https' : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { development : 1 } },
        'git' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { development : 1 } },
        'disabled' : { path : 'git+https:///github.com/user/disabled', enabled : 0, criterion : { development : 1 } },
        'hd' : { path : 'hd://./user/hd', enabled : 1, criterion : { development : 1 } },
      }
    }
  };
  var got = _.will.transform.npmFromWillfile( src );
  var exp =
  {
    devDependencies :
    {
      'wTools' : '',
      'next' : '0.0.1',
      '@module/core' : '0.0.1',
      'https' : 'https://domain/https.tar.gz',
      'git' : 'https://github.com/user/repo.git#0.0.1',
      'hd' : 'file:./user/hd',
    },
  };
  test.identical( got, exp );

  test.case = 'map with only development dependencies - disabled, o.withDisabledSubmodules - 1';
  var src =
  {
    config :
    {
      submodule : { disabled : { path : 'git+https:///github.com/user/disabled', enabled : 0, criterion : { development : 1 } } }
    },
    withDisabledSubmodules : 1,
  };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { devDependencies : { disabled : 'https://github.com/user/disabled' } };
  test.identical( got, exp );

  test.case = 'map with only optional dependencies - different';
  var src =
  {
    config :
    {
      submodule :
      {
        'wTools' : { path : 'npm:///wTools', enabled : 1, criterion : { optional : 1 } },
        'next' : { path : 'npm:///next!0.0.1', enabled : 1, criterion : { optional : 1 } },
        '@module/core' : { path : 'npm:///@module/core!0.0.1', enabled : 1, criterion : { optional : 1 } },
        'https' : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { optional : 1 } },
        'git' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { optional : 1 } },
        'disabled' : { path : 'git+https:///github.com/user/disabled', enabled : 0, criterion : { optional : 1 } },
        'hd' : { path : 'hd://./user/hd', enabled : 1, criterion : { optional : 1 } },
      }
    }
  };
  var got = _.will.transform.npmFromWillfile( src );
  var exp =
  {
    optionalDependencies :
    {
      'wTools' : '',
      'next' : '0.0.1',
      '@module/core' : '0.0.1',
      'https' : 'https://domain/https.tar.gz',
      'git' : 'https://github.com/user/repo.git#0.0.1',
      'hd' : 'file:./user/hd',
    },
  };
  test.identical( got, exp );

  test.case = 'map with only development dependencies - disabled, o.withDisabledSubmodules - 1';
  var src =
  {
    config :
    {
      submodule : { disabled : { path : 'git+https:///github.com/user/disabled', enabled : 0, criterion : { optional : 1 } } }
    },
    withDisabledSubmodules : 1,
  };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { optionalDependencies : { disabled : 'https://github.com/user/disabled' } };
  test.identical( got, exp );

  test.case = 'map with only non standard options - different';
  var src = { config : { about : { 'npm.map' : { map : '' }, 'npm.array' : [ 'array' ], 'npm.string' : 'string' } } };
  var got = _.will.transform.npmFromWillfile( src );
  var exp = { map : { map : '' }, array : [ 'array' ], string : 'string' };
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.npmFromWillfile() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.transform.npmFromWillfile( { config : {} }, { config : {} } ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.will.transform.npmFromWillfile( 'wrong' ) );

  test.case = 'wrong type of o.config';
  test.shouldThrowErrorSync( () => _.will.transform.npmFromWillfile({ config : [] }) );
}

//

function npmFromWillfileWithComplexConfig( test )
{

  test.case = 'complex willfile';
  var src =
  {
    config :
    {
      about :
      {
        'name' : 'wTools',
        'version' : '0.0.1',
        'enabled' : 0,
        'npm.name' : 'wTools',
        'description' : 'test module',
        'keywords' : [ 'test', 'module' ],
        'license' : 'MIT',
        'author' : { name : 'author', email : 'author@domain.com' },
        'contributors' : [ 'author1 <author1@domain.com>', { name : 'author2', email : 'author2@domain.com' } ],
        'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
        'interpreters' : [ 'njs =10.0.0', 'chromium >=67.0.0' ],
        'npm.map' : { map : '' },
        'npm.array' : [ 'array' ],
        'npm.string' : 'string',
      },
      path :
      {
        'entry' : 'proto/file',
        'npm.files' : [ 'proto/file', 'proto/some', 'out' ],
        'repository' : 'git+https:///github.com/Wandalen/wTools.git',
        'bugtracker' : 'https:///github.com/Wandalen/wTools/issues',
        'origins' : [ 'git+https:///github.com/Wandalen/wTools.git', 'npm:///wTools' ],
      },
      submodule :
      {
        'wTools' : { path : 'npm:///wTools', enabled : 1 },
        'next' : { path : 'npm:///next!0.0.1', enabled : 1 },
        'https' : { path : 'https://domain/https.tar.gz', enabled : 1 },
        'git' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1 },
        'disabled' : { path : 'git+https:///github.com/user/disabled', enabled : 0 },
        'hd' : { path : 'hd://./user/hd', enabled : 1 },

        'wToolsd' : { path : 'npm:///wToolsd', enabled : 1, criterion : { development : 1 } },
        'nextd' : { path : 'npm:///nextd!0.0.1', enabled : 1, criterion : { development : 1 } },
        'httpsd' : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { development : 1 } },
        'gitd' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { development : 1 } },
        'disabledd' : { path : 'git+https:///github.com/user/disabledd', enabled : 0, criterion : { development : 1 } },
        'hdd' : { path : 'hd://./user/hd', enabled : 1, criterion : { development : 1 } },

        'wToolso' : { path : 'npm:///wToolso', enabled : 1, criterion : { optional : 1 } },
        'nexto' : { path : 'npm:///nexto!0.0.1', enabled : 1, criterion : { optional : 1 } },
        'httpso' : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { optional : 1 } },
        'gito' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { optional : 1 } },
        'disabledo' : { path : 'git+https:///github.com/user/disabledo', enabled : 0, criterion : { optional : 1 } },
        'hdo' : { path : 'hd://./user/hd', enabled : 1, criterion : { optional : 1 } },
      }
    },
  };
  var got = _.will.transform.npmFromWillfile( src );
  var exp =
  {
    'name' : 'wTools',
    'version' : '0.0.1',
    'enabled' : 0,
    'description' : 'test module',
    'keywords' : [ 'test', 'module' ],
    'license' : 'MIT',
    'author' : 'author <author@domain.com>',
    'contributors' : [ 'author1 <author1@domain.com>', 'author2 <author2@domain.com>' ],
    'scripts' : { script1 : 'script1', script2 : 'script2' },
    'engine' : 'node = 10.0.0',
    'npm.engines' : { node : '10.0.0', chromium : '>=67.0.0' },
    'repository' : 'https://github.com/Wandalen/wTools.git',
    'bugs' : 'https://github.com/Wandalen/wTools/issues',
    'main' : 'proto/file',
    'files' : [ 'proto/file', 'proto/some', 'out' ],
    'dependencies' :
    {
      wTools : '',
      next : '0.0.1',
      https : 'https://domain/https.tar.gz',
      git : 'https://github.com/user/repo.git#0.0.1',
      hd : 'file:./user/hd',
    },
    'devDependencies' :
    {
      wToolsd : '',
      nextd : '0.0.1',
      httpsd : 'https://domain/https.tar.gz',
      gitd : 'https://github.com/user/repo.git#0.0.1',
      hdd : 'file:./user/hd',
    },
    'optionalDependencies' :
    {
      wToolso : '',
      nexto : '0.0.1',
      httpso : 'https://domain/https.tar.gz',
      gito : 'https://github.com/user/repo.git#0.0.1',
      hdo : 'file:./user/hd',
    },
    'map' : { map : '' },
    'array' : [ 'array' ],
    'string' : 'string',
  };
  test.identical( got, exp );
}

//

function willfileFromNpm( test )
{
  test.case = 'o.config - empty';
  var src = { config : {} };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = {};
  test.identical( got, exp );

  test.case = 'map with only name';
  var src = { config : { name : 'wTools' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp =
  {
    about : { 'name' : 'wTools', 'npm.name' : 'wTools' },
    path : { origins : [ 'npm:///wTools' ] },
  };
  test.identical( got, exp );

  test.case = 'map with only version';
  var src = { config : { version : '0.0.1' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { version : '0.0.1' } };
  test.identical( got, exp );

  test.case = 'map with only enabled';
  var src = { config : { enabled : 0 } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { enabled : 0 } };
  test.identical( got, exp );

  test.case = 'map with only description';
  var src = { config : { description : 'test module' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { description : 'test module' } };
  test.identical( got, exp );

  test.case = 'map with only keywords';
  var src = { config : { keywords : [ 'test', 'module' ] } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { keywords : [ 'test', 'module' ] } };
  test.identical( got, exp );

  test.case = 'map with only license';
  var src = { config : { license : 'MIT' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { license : 'MIT' } };
  test.identical( got, exp );

  test.case = 'map with only author - string';
  var src = { config : { author : 'author <author@domain.com> (https://site.com)' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { author : 'author <author@domain.com> (https://site.com)' } };
  test.identical( got, exp );

  test.case = 'map with only author - map with name and email';
  var src = { config : { author : { name : 'author', email : 'author@domain.com' } } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { author : 'author <author@domain.com>' } };
  test.identical( got, exp );

  test.case = 'map with only author - map with name and email and url';
  var src = { config : { author : { name : 'author', email : 'author@domain.com', url : 'https://site.com' } } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { author : 'author <author@domain.com> (https://site.com)' } };
  test.identical( got, exp );

  test.case = 'map with only contributors - different';
  var src =
  {
    config :
    {
      contributors :
      [
        'author1 <author1@domain.com>',
        { name : 'author2', email : 'author2@domain.com' },
        { name : 'author3', email : 'author3@domain.com', url : 'https://site.com' },
      ]
    },
  };
  var got = _.will.transform.willfileFromNpm( src );
  var exp =
  {
    about :
    {
      contributors :
      [
        'author1 <author1@domain.com>',
        'author2 <author2@domain.com>',
        'author3 <author3@domain.com> (https://site.com)',
      ],
    }
  };
  test.identical( got, exp );

  test.case = 'map with only scripts';
  var src = { config : { scripts : { script1 : 'script1', script2 : 'script2' } } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { 'npm.scripts' : { script1 : 'script1', script2 : 'script2' } } };
  test.identical( got, exp );

  test.case = 'map with only engine';
  var src = { config : { engine : 'node 10.0.0' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { interpreters : [ 'njs = 10.0.0' ] } };
  test.identical( got, exp );

  test.case = 'map with only engines';
  var src = { config : { engines : { node : '10.0.0', chromium : '67.0.0' } } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { interpreters : [ 'njs = 10.0.0', 'chromium = 67.0.0' ] } };
  test.identical( got, exp );

  test.case = 'map with only npm.engines';
  var src = { config : { 'npm.engines' : { node : '10.0.0', chromium : '67.0.0' } } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { interpreters : [ 'njs = 10.0.0', 'chromium = 67.0.0' ] } };
  test.identical( got, exp );

  test.case = 'map with only repository - string';
  var src = { config : { repository : 'https://github.com/Wandalen/wTools.git' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp =
  {
    path :
    {
      repository : 'git+https:///github.com/Wandalen/wTools.git',
      origins : [ 'git+https:///github.com/Wandalen/wTools.git' ],
    }
  };
  test.identical( got, exp );

  test.case = 'map with only repository - map';
  var src = { config : { repository : { type : 'git', url : 'https://github.com/Wandalen/wTools.git' } } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp =
  {
    path :
    {
      repository : 'git+https:///github.com/Wandalen/wTools.git',
      origins : [ 'git+https:///github.com/Wandalen/wTools.git' ],
    }
  };
  test.identical( got, exp );

  test.case = 'map with only bugs - string';
  var src = { config : { bugs : 'https://github.com/Wandalen/wTools/issues' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { path : { bugtracker : 'https:///github.com/Wandalen/wTools/issues' } };
  test.identical( got, exp );

  test.case = 'map with only bugs - map';
  var src = { config : { bugs : { type : 'git', url : 'https://github.com/Wandalen/wTools/issues' } } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { path : { bugtracker : 'https:///github.com/Wandalen/wTools/issues' } };
  test.identical( got, exp );

  test.case = 'map with only main';
  var src = { config : { main : 'proto/file' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { path : { entry : 'proto/file' } };
  test.identical( got, exp );

  test.case = 'map with only files';
  var src = { config : { files : [ 'proto/file', 'proto/some', 'out' ] } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { path : { 'npm.files' : [ 'proto/file', 'proto/some', 'out' ] } };
  test.identical( got, exp );

  test.case = 'map with only dependencies - different';
  var src =
  {
    config :
    {
      dependencies :
      {
        wTools : '',
        next : '0.0.1',
        https : 'https://domain/https.tar.gz',
        git : 'https://github.com/user/repo.git#0.0.1',
        gitshort : 'user/git-short',
        hd : 'file:./user/hd',
      },
    }
  };
  var got = _.will.transform.willfileFromNpm( src );
  var exp =
  {
    submodule :
    {
      wTools : { path : 'npm:///wTools', enabled : 1 },
      next : { path : 'npm:///next!0.0.1', enabled : 1 },
      https : { path : 'https://domain/https.tar.gz', enabled : 1 },
      git : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1 },
      gitshort : { path : 'git+https:///github.com/user/git-short', enabled : 1 },
      hd : { path : 'hd://./user/hd', enabled : 1 },
    }
  };
  test.identical( got, exp );

  test.case = 'map with only development dependencies - different';
  var src =
  {
    config :
    {
      devDependencies :
      {
        wTools : '',
        next : '0.0.1',
        https : 'https://domain/https.tar.gz',
        git : 'https://github.com/user/repo.git#0.0.1',
        gitshort : 'user/git-short',
        hd : 'file:./user/hd',
      },
    }
  };
  var got = _.will.transform.willfileFromNpm( src );
  var exp =
  {
    submodule :
    {
      wTools : { path : 'npm:///wTools', enabled : 1, criterion : { development : 1 } },
      next : { path : 'npm:///next!0.0.1', enabled : 1, criterion : { development : 1 } },
      https : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { development : 1 } },
      git : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { development : 1 } },
      gitshort : { path : 'git+https:///github.com/user/git-short', enabled : 1, criterion : { development : 1 } },
      hd : { path : 'hd://./user/hd', enabled : 1, criterion : { development : 1 } },
    }
  };
  test.identical( got, exp );

  test.case = 'map with only optional dependencies - different';
  var src =
  {
    config :
    {
      optionalDependencies :
      {
        wTools : '',
        next : '0.0.1',
        https : 'https://domain/https.tar.gz',
        git : 'https://github.com/user/repo.git#0.0.1',
        gitshort : 'user/git-short',
        hd : 'file:./user/hd',
      },
    }
  };
  var got = _.will.transform.willfileFromNpm( src );
  var exp =
  {
    submodule :
    {
      wTools : { path : 'npm:///wTools', enabled : 1, criterion : { optional : 1 } },
      next : { path : 'npm:///next!0.0.1', enabled : 1, criterion : { optional : 1 } },
      https : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { optional : 1 } },
      git : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { optional : 1 } },
      gitshort : { path : 'git+https:///github.com/user/git-short', enabled : 1, criterion : { optional : 1 } },
      hd : { path : 'hd://./user/hd', enabled : 1, criterion : { optional : 1 } },
    }
  };
  test.identical( got, exp );

  test.case = 'map with only non standard options - different';
  var src = { config : { map : { map : '' }, array : [ 'array' ], string : 'string' } };
  var got = _.will.transform.willfileFromNpm( src );
  var exp = { about : { 'npm.map' : { map : '' }, 'npm.array' : [ 'array' ], 'npm.string' : 'string' } };
  test.identical( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.willfileFromNpm() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.will.transform.willfileFromNpm( { config : {} }, { config : {} } ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.will.transform.willfileFromNpm( 'wrong' ) );

  test.case = 'wrong type of o.config';
  test.shouldThrowErrorSync( () => _.will.transform.willfileFromNpm({ config : [] }) );
}

//

function willfileFromNpmWithComplexConfig( test )
{

  test.case = 'complex json config';
  var src =
  {
    config :
    {
      name : 'wTools',
      version : '0.0.1',
      enabled : 0,
      description : 'test module',
      keywords : [ 'test', 'module' ],
      license : 'MIT',
      author : { name : 'author', email : 'author@domain.com' },
      contributors : [ 'author1 <author1@domain.com>', { name : 'author2', email : 'author2@domain.com' } ],
      scripts : { script1 : 'script1', script2 : 'script2' },
      engines : { node : '10.0.0', chromium : '67.0.0' },
      repository : 'https://github.com/Wandalen/wTools.git',
      bugs : 'https://github.com/Wandalen/wTools/issues',
      main : 'proto/file',
      files : [ 'proto/file', 'proto/some', 'out' ],
      dependencies :
      {
        wTools : '',
        next : '0.0.1',
        https : 'https://domain/https.tar.gz',
        git : 'https://github.com/user/repo.git#0.0.1',
        gitshort : 'user/git-short',
        hd : 'file:./user/hd',
      },
      devDependencies :
      {
        wToolsd : '',
        nextd : '0.0.1',
        httpsd : 'https://domain/https.tar.gz',
        gitd : 'https://github.com/user/repo.git#0.0.1',
        gitshortd : 'user/git-short',
        hdd : 'file:./user/hd',
      },
      optionalDependencies :
      {
        wToolso : '',
        nexto : '0.0.1',
        httpso : 'https://domain/https.tar.gz',
        gito : 'https://github.com/user/repo.git#0.0.1',
        gitshorto : 'user/git-short',
        hdo : 'file:./user/hd',
      },
      map : { map : '' },
      array : [ 'array' ],
      string : 'string',
    },
  };
  var got = _.will.transform.willfileFromNpm( src );
  var exp =
  {
    about :
    {
      'name' : 'wTools',
      'version' : '0.0.1',
      'enabled' : 0,
      'npm.name' : 'wTools',
      'description' : 'test module',
      'keywords' : [ 'test', 'module' ],
      'license' : 'MIT',
      'author' : 'author <author@domain.com>',
      'contributors' : [ 'author1 <author1@domain.com>', 'author2 <author2@domain.com>' ],
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'interpreters' : [ 'njs = 10.0.0', 'chromium = 67.0.0' ],
      'npm.map' : { map : '' },
      'npm.array' : [ 'array' ],
      'npm.string' : 'string',
    },
    path :
    {
      'entry' : 'proto/file',
      'npm.files' : [ 'proto/file', 'proto/some', 'out' ],
      'repository' : 'git+https:///github.com/Wandalen/wTools.git',
      'bugtracker' : 'https:///github.com/Wandalen/wTools/issues',
      'origins' : [ 'git+https:///github.com/Wandalen/wTools.git', 'npm:///wTools' ],
    },
    submodule :
    {
      'wTools' : { path : 'npm:///wTools', enabled : 1 },
      'next' : { path : 'npm:///next!0.0.1', enabled : 1 },
      'https' : { path : 'https://domain/https.tar.gz', enabled : 1 },
      'git' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1 },
      'gitshort' : { path : 'git+https:///github.com/user/git-short', enabled : 1 },
      'hd' : { path : 'hd://./user/hd', enabled : 1 },

      'wToolsd' : { path : 'npm:///wToolsd', enabled : 1, criterion : { development : 1 } },
      'nextd' : { path : 'npm:///nextd!0.0.1', enabled : 1, criterion : { development : 1 } },
      'httpsd' : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { development : 1 } },
      'gitd' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { development : 1 } },
      'gitshortd' : { path : 'git+https:///github.com/user/git-short', enabled : 1, criterion : { development : 1 } },
      'hdd' : { path : 'hd://./user/hd', enabled : 1, criterion : { development : 1 } },

      'wToolso' : { path : 'npm:///wToolso', enabled : 1, criterion : { optional : 1 } },
      'nexto' : { path : 'npm:///nexto!0.0.1', enabled : 1, criterion : { optional : 1 } },
      'httpso' : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { optional : 1 } },
      'gito' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { optional : 1 } },
      'gitshorto' : { path : 'git+https:///github.com/user/git-short', enabled : 1, criterion : { optional : 1 } },
      'hdo' : { path : 'hd://./user/hd', enabled : 1, criterion : { optional : 1 } },
    }
  };
  test.identical( got, exp );
}

//

function npmAndWillfileDoubleConvertion( test )
{
  test.case = 'willfile -> package -> willfile';
  var src =
  {
    config :
    {
      about :
      {
        'name' : 'wTools',
        'version' : '0.0.1',
        'enabled' : 0,
        'npm.name' : 'wTools',
        'description' : 'test module',
        'keywords' : [ 'test', 'module' ],
        'license' : 'MIT',
        'author' : 'author <author@domain.com>',
        'contributors' : [ 'author1 <author1@domain.com>', 'author2 <author2@domain.com>' ],
        'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
        'interpreters' : [ 'njs = 10.0.0', 'chromium >= 67.0.0' ],
        'npm.map' : { map : '' },
        'npm.array' : [ 'array' ],
        'npm.string' : 'string',
      },
      path :
      {
        'entry' : 'proto/file',
        'npm.files' : [ 'proto/file', 'proto/some', 'out' ],
        'repository' : 'git+https:///github.com/Wandalen/wTools.git',
        'bugtracker' : 'https:///github.com/Wandalen/wTools/issues',
        'origins' : [ 'git+https:///github.com/Wandalen/wTools.git', 'npm:///wTools' ],
      },
      submodule :
      {
        'wTools' : { path : 'npm:///wTools', enabled : 1 },
        'next' : { path : 'npm:///next!0.0.1', enabled : 1 },
        'https' : { path : 'https://domain/https.tar.gz', enabled : 1 },
        'git' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1 },
        'disabled' : { path : 'git+https:///github.com/user/disabled', enabled : 0 },
        'hd' : { path : 'hd://./user/hd', enabled : 1 },

        'wToolsd' : { path : 'npm:///wToolsd', enabled : 1, criterion : { development : 1 } },
        'nextd' : { path : 'npm:///nextd!0.0.1', enabled : 1, criterion : { development : 1 } },
        'httpsd' : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { development : 1 } },
        'gitd' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { development : 1 } },
        'disabledd' : { path : 'git+https:///github.com/user/disabledd', enabled : 0, criterion : { development : 1 } },
        'hdd' : { path : 'hd://./user/hd', enabled : 1, criterion : { development : 1 } },

        'wToolso' : { path : 'npm:///wToolso', enabled : 1, criterion : { optional : 1 } },
        'nexto' : { path : 'npm:///nexto!0.0.1', enabled : 1, criterion : { optional : 1 } },
        'httpso' : { path : 'https://domain/https.tar.gz', enabled : 1, criterion : { optional : 1 } },
        'gito' : { path : 'git+https:///github.com/user/repo.git!0.0.1', enabled : 1, criterion : { optional : 1 } },
        'disabledo' : { path : 'git+https:///github.com/user/disabledo', enabled : 0, criterion : { optional : 1 } },
        'hdo' : { path : 'hd://./user/hd', enabled : 1, criterion : { optional : 1 } },
      }
    },
  };
  var converted = _.will.transform.npmFromWillfile( src );
  var got = _.will.transform.willfileFromNpm({ config : converted });
  test.identical( _.props.keys( got ), [ 'about', 'path', 'submodule' ] );
  test.identical( got.about, src.config.about );
  test.identical( got.path, src.config.path );
  test.identical( got.submodule, _.mapBut_( null, src.config.submodule, [ 'disabled', 'disabledd', 'disabledo' ] ) );
  test.true( got !== src.config );
  test.true( got.about !== src.config.about );
  test.true( got.path !== src.config.path );
  test.true( got.submodule !== src.config.submodule );

  /* */

  test.case = 'package -> willfile -> package';
  var src =
  {
    config :
    {
      'name' : 'wTools',
      'version' : '0.0.1',
      'enabled' : 0,
      'description' : 'test module',
      'keywords' : [ 'test', 'module' ],
      'license' : 'MIT',
      'author' : 'author <author@domain.com>',
      'contributors' : [ 'author1 <author1@domain.com>', 'author2 <author2@domain.com>' ],
      'scripts' : { script1 : 'script1', script2 : 'script2' },
      'npm.engines' : { node : '10.0.0', chromium : '67.0.0' },
      'engine' : 'node = 10.0.0',
      'repository' : 'https://github.com/Wandalen/wTools.git',
      'bugs' : 'https://github.com/Wandalen/wTools/issues',
      'main' : 'proto/file',
      'files' : [ 'proto/file', 'proto/some', 'out' ],
      'dependencies' :
      {
        wTools : '',
        next : '0.0.1',
        https : 'https://domain/https.tar.gz',
        git : 'https://github.com/user/repo.git#0.0.1',
        hd : 'file:./user/hd',
      },
      'devDependencies' :
      {
        wToolsd : '',
        nextd : '0.0.1',
        httpsd : 'https://domain/https.tar.gz',
        gitd : 'https://github.com/user/repo.git#0.0.1',
        hdd : 'file:./user/hd',
      },
      'optionalDependencies' :
      {
        wToolso : '',
        nexto : '0.0.1',
        httpso : 'https://domain/https.tar.gz',
        gito : 'https://github.com/user/repo.git#0.0.1',
        hdo : 'file:./user/hd',
      },
      'map' : { map : '' },
      'array' : [ 'array' ],
      'string' : 'string',
    },
  };
  var converted = _.will.transform.willfileFromNpm( src );
  var got = _.will.transform.npmFromWillfile({ config : converted });
  test.identical( got, src.config );
  test.true( got !== src.config );
}

//

function willfilesMerge( test )
{
  test.open( 'merge all sections' );

  test.case = 'dst - empty, src - empty, onSection - extend';
  var dst = {};
  var src = {};
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp = {};
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - filled, src - empty, onSection - extend';
  var dst = { about : { enabled : 1 }, path : { in : '.' }, submodule : { test : 'hd://./local' } };
  var src = {};
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp = { about : { enabled : 1 }, path : { in : '.' }, submodule : { test : 'hd://./local' } };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty, src - filled, onSection - extend';
  var dst = {};
  var src = { about : { enabled : 1 }, path : { in : '.' }, submodule : { test : 'hd://./local' } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp = { about : { enabled : 1 }, path : { in : '.' }, submodule : { test : 'hd://./local' } };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - filled, src - filled, different fields in sections, onSection - extend';
  var dst = { about : { name : 'test' }, path : { out : './out' }, step : { export : { export : 'path::in' } } };
  var src = { about : { enabled : 1 }, path : { in : '.' }, submodule : { test : 'hd://./local' } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp =
  {
    about : { name : 'test', enabled : 1 },
    path : { in : '.', out : './out' },
    submodule : { test : 'hd://./local' },
    step : { export : { export : 'path::in' } }
  };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - filled, src - filled, different fields in sections, onSection - supplement';
  var dst = { about : { name : 'test' }, path : { out : './out' }, step : { export : { export : 'path::in' } } };
  var src = { about : { enabled : 1 }, path : { in : '.' }, submodule : { test : 'hd://./local' } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.supplement.bind( _.map ) });
  var exp =
  {
    about : { name : 'test', enabled : 1 },
    path : { in : '.', out : './out' },
    submodule : { test : 'hd://./local' },
    step : { export : { export : 'path::in' } }
  };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - filled, src - filled, same fields in sections, onSection - extend';
  var dst = { about : { enabled : 1 }, path : { in : '.' }, submodule : { test : 'hd://./local' } };
  var src = { about : { enabled : 0 }, path : { in : './in' }, submodule : { test : 'hd://./test' } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp = { about : { enabled : 0 }, path : { in : './in' }, submodule : { test : 'hd://./test' } };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - filled, src - filled, different fields in sections, onSection - supplement';
  var dst = { about : { enabled : 1 }, path : { in : '.' }, submodule : { test : 'hd://./local' } };
  var src = { about : { enabled : 0 }, path : { in : './in' }, submodule : { test : 'hd://./test' } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.supplement.bind( _.map ) });
  var exp = { about : { enabled : 1 }, path : { in : '.' }, submodule : { test : 'hd://./local' } };
  test.identical( got, exp );
  test.true( got === dst );

  test.close( 'merge all sections' );

  /* - */

  test.open( 'merge fields of section about' );

  test.case = 'same fields with primitive values, onSection - extend';
  var dst = { about : { 'name' : 'test', 'enabled' : 1, 'description' : 'test', 'npm.string' : 'string' } };
  var src = { about : { 'name' : 'second', 'enabled' : 0, 'description' : 'second', 'npm.string' : 'str' } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp = { about : { 'name' : 'second', 'enabled' : 0, 'description' : 'second', 'npm.string' : 'str' } };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'same fields with primitive values, onSection - supplement';
  var dst = { about : { 'name' : 'test', 'enabled' : 1, 'description' : 'test', 'npm.string' : 'string' } };
  var src = { about : { 'name' : 'second', 'enabled' : 0, 'description' : 'second', 'npm.string' : 'str' } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.supplement.bind( _.map ) });
  var exp = { about : { 'name' : 'test', 'enabled' : 1, 'description' : 'test', 'npm.string' : 'string' } };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'same fields with array values, not contributors, not interpreters, onSection - extend';
  var dst = { about : { 'keywords' : [ 'one', 'two' ], 'npm.array' : [ 'one', 'two' ] } };
  var src = { about : { 'keywords' : [ 'one', 'three' ], 'npm.array' : [ 'one', 'three' ] } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp = { about : { 'keywords' : [ 'one', 'two', 'three' ], 'npm.array' : [ 'one', 'three' ] } };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'same fields with array values, not contributors, not interpreters, onSection - supplement';
  var dst = { about : { 'keywords' : [ 'one', 'two' ], 'npm.array' : [ 'one', 'two' ] } };
  var src = { about : { 'keywords' : [ 'one', 'three' ], 'npm.array' : [ 'one', 'three' ] } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.supplement.bind( _.map ) });
  var exp = { about : { 'keywords' : [ 'one', 'two', 'three' ], 'npm.array' : [ 'one', 'two' ] } };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'same fields with map values, onSection - extend';
  var dst =
  {
    about :
    {
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'npm.map' : { key1 : 'value1', key2 : 'value2' },
    }
  };
  var src =
  {
    about :
    {
      'npm.scripts' : { script1 : 'srcscript1', script3 : 'script3' },
      'npm.map' : { key1 : 'srcvalue1', key3 : 'value3' },
    }
  };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp =
  {
    about :
    {
      'npm.scripts' : { script1 : 'srcscript1', script2 : 'script2', script3 : 'script3' },
      'npm.map' : { key1 : 'srcvalue1', key3 : 'value3' },
    }
  };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'same fields with map values, onSection - supplement';
  var dst =
  {
    about :
    {
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'npm.map' : { key1 : 'value1', key2 : 'value2' },
    }
  };
  var src =
  {
    about :
    {
      'npm.scripts' : { script1 : 'srcscript1', script3 : 'script3' },
      'npm.map' : { key1 : 'srcvalue1', key3 : 'value3' },
    }
  };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.supplement.bind( _.map ) });
  var exp =
  {
    about :
    {
      'npm.scripts' : { script1 : 'script1', script2 : 'script2', script3 : 'script3' },
      'npm.map' : { key1 : 'value1', key2 : 'value2' },
    }
  };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'autor fields with different values, onSection - extend';
  var dst = { about : { author : 'author <author@domain.com>' } };
  var src = { about : { author : { name : 'author2', email : 'author2@domain.com', url : 'https://site.com' } } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp = { about : { author : 'author2 <author2@domain.com> (https://site.com)' } };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'autor fields with different values, onSection - supplement';
  var dst = { about : { author : 'author <author@domain.com>' } };
  var src = { about : { author : { name : 'author2', email : 'author2@domain.com', url : 'https://site.com' } } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.supplement.bind( _.map ) });
  var exp = { about : { author : 'author <author@domain.com>' } };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'contributors fields with different values, onSection - extend';
  var dst =
  {
    about :
    {
      contributors :
      [
        'author <wrong@email>',
        { name : 'author2', email : 'author2@domain.com' },
        { name : 'author3', email : 'author3@domain.com' }
      ]
    }
  };
  var src =
  {
    about :
    {
      contributors :
      [
        { name : 'author', email : 'author@domain.com', url : 'https://site.com' },
        'author2 <author2@domain.com> (https://site2.com)',
        { name : 'author3', email : 'author3@domain.com' },
        { name : 'author4', email : 'author4@domain.com' },
      ]
    }
  };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp =
  {
    about :
    {
      contributors :
      [
        'author <author@domain.com> (https://site.com)',
        'author2 <author2@domain.com> (https://site2.com)',
        'author3 <author3@domain.com>',
        'author4 <author4@domain.com>',
      ]
    }
  };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'contributors fields with different values, onSection - supplement';
  var dst =
  {
    about :
    {
      contributors :
      [
        'author <wrong@email>',
        { name : 'author2', email : 'author2@domain.com' },
        { name : 'author3', email : 'author3@domain.com' }
      ]
    }
  };
  var src =
  {
    about :
    {
      contributors :
      [
        { name : 'author', email : 'author@domain.com', url : 'https://site.com' },
        'author2 <author2@domain.com> (https://site2.com)',
        { name : 'author3', email : 'author3@domain.com' },
        { name : 'author4', email : 'author4@domain.com' },
      ]
    }
  };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.supplement.bind( _.map ) });
  var exp =
  {
    about :
    {
      contributors :
      [
        'author <wrong@email> (https://site.com)',
        'author2 <author2@domain.com> (https://site2.com)',
        'author3 <author3@domain.com>',
        'author4 <author4@domain.com>',
      ]
    }
  };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'interpreters fields with different values, onSection - extend';
  var dst = { about : { interpreters : [ 'njs = 10.0.0', 'chromium >= 67.0.0' ] } };
  var src = { about : { interpreters : [ 'njs >= 12.0.0', 'chromium = 75.0.0', 'filefox > 67.0.0' ] } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.extend.bind( _.map ) });
  var exp = { about : { interpreters : [ 'njs >= 12.0.0', 'chromium = 75.0.0', 'filefox > 67.0.0' ] } };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'interpreters fields with different values, onSection - supplement';
  var dst = { about : { interpreters : [ 'njs = 10.0.0', 'chromium >= 67.0.0' ] } };
  var src = { about : { interpreters : [ 'njs >= 12.0.0', 'chromium = 75.0.0', 'filefox > 67.0.0' ] } };
  var got = _.will.transform.willfilesMerge({ dst, src, onSection : _.map.supplement.bind( _.map ) });
  var exp = { about : { interpreters : [ 'njs = 10.0.0', 'chromium >= 67.0.0', 'filefox > 67.0.0' ] } };
  test.identical( got, exp );
  test.true( got === dst );

  test.close( 'merge fields of section about' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.will.transform.willfilesMerge() );

  test.case = 'extra arguments';
  var o = { src : { path : {} }, dst : { path : {} }, onSection : _.map.extend.bind( _.map ) };
  test.shouldThrowErrorSync( () => _.will.transform.willfilesMerge( o, o ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.will.transform.willfilesMerge( 'wrong' ) );

  test.case = 'wrong type of o.src';
  var o = { src : 'wrong', dst : { path : {} }, onSection : _.map.extend.bind( _.map ) };
  test.shouldThrowErrorSync( () => _.will.transform.willfilesMerge( o ) );

  test.case = 'wrong type of o.dst';
  var o = { src : { path : {} }, dst : 'wrong', onSection : _.map.extend.bind( _.map ) };
  test.shouldThrowErrorSync( () => _.will.transform.willfilesMerge( o ) );

  test.case = 'wrong type of o.onSection';
  var o = { src : { path : {} }, dst : { path : {} }, onSection : 'wrong' };
  test.shouldThrowErrorSync( () => _.will.transform.willfilesMerge( o ) );

  test.case = 'o.src contains extra section';
  var o = { src : { extra : {} }, dst : { path : {} }, onSection : _.map.extend.bind( _.map ) };
  test.shouldThrowErrorSync( () => _.will.transform.willfilesMerge( o ) );

  test.case = 'o.dst contains extra section';
  var o = { src : { path : {} }, dst : { extra : {} }, onSection : _.map.extend.bind( _.map ) };
  test.shouldThrowErrorSync( () => _.will.transform.willfilesMerge( o ) );
}

//

function willfilesMergeCheckOptions( test )
{
  test.case = 'dst - empty, src - full, sections options set to 1';
  var dst = {};
  var src =
  {
    about : { name : 'test' },
    build : { all : { criterion : { default : 1, debug : 1 }, steps : [ 'submodules.download' ] } },
    path : { in : '.' },
    reflector : { 'reflect.trivial' : { criterion : { debug : 1 }, src : 'path:in', dst : 'path:out' } },
    step : { 'shell.echo' : { shell : 'echo one' } },
    submodule : { test : 'hd://./local' },
  };
  var got = _.will.transform.willfilesMerge
  ({
    dst,
    src,
    onSection : _.map.supplement.bind( _.map ),
    about : 1,
    build : 1,
    path : 1,
    reflector : 1,
    step : 1,
    submodule : 1,
  });
  var exp =
  {
    about : { name : 'test' },
    build : { all : { criterion : { default : 1, debug : 1 }, steps : [ 'submodules.download' ] } },
    path : { in : '.' },
    reflector : { 'reflect.trivial' : { criterion : { debug : 1 }, src : 'path:in', dst : 'path:out' } },
    step : { 'shell.echo' : { shell : 'echo one' } },
    submodule : { test : 'hd://./local' },
  };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty, src - full, sections options set to 0';
  var dst = {};
  var src =
  {
    about : { name : 'test' },
    build : { all : { criterion : { default : 1, debug : 1 }, steps : [ 'submodules.download' ] } },
    path : { in : '.' },
    reflector : { 'reflect.trivial' : { criterion : { debug : 1 }, src : 'path:in', dst : 'path:out' } },
    step : { 'shell.echo' : { shell : 'echo one' } },
    submodule : { test : 'hd://./local' },
  };
  var got = _.will.transform.willfilesMerge
  ({
    dst,
    src,
    onSection : _.map.supplement.bind( _.map ),
    about : 0,
    build : 0,
    path : 0,
    reflector : 0,
    step : 0,
    submodule : 0,
  });
  var exp = {};
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - full, src - empty, sections options set to 1';
  var dst =
  {
    about : { name : 'test' },
    build : { all : { criterion : { default : 1, debug : 1 }, steps : [ 'submodules.download' ] } },
    path : { in : '.' },
    reflector : { 'reflect.trivial' : { criterion : { debug : 1 }, src : 'path:in', dst : 'path:out' } },
    step : { 'shell.echo' : { shell : 'echo one' } },
    submodule : { test : 'hd://./local' },
  };
  var src = {};
  var got = _.will.transform.willfilesMerge
  ({
    dst,
    src,
    onSection : _.map.supplement.bind( _.map ),
    about : 1,
    build : 1,
    path : 1,
    reflector : 1,
    step : 1,
    submodule : 1,
  });
  var exp =
  {
    about : { name : 'test' },
    build : { all : { criterion : { default : 1, debug : 1 }, steps : [ 'submodules.download' ] } },
    path : { in : '.' },
    reflector : { 'reflect.trivial' : { criterion : { debug : 1 }, src : 'path:in', dst : 'path:out' } },
    step : { 'shell.echo' : { shell : 'echo one' } },
    submodule : { test : 'hd://./local' },
  };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - full, src - empty, sections options set to 0';
  var dst =
  {
    about : { name : 'test' },
    build : { all : { criterion : { default : 1, debug : 1 }, steps : [ 'submodules.download' ] } },
    path : { in : '.' },
    reflector : { 'reflect.trivial' : { criterion : { debug : 1 }, src : 'path:in', dst : 'path:out' } },
    step : { 'shell.echo' : { shell : 'echo one' } },
    submodule : { test : 'hd://./local' },
  };
  var src = {};
  var got = _.will.transform.willfilesMerge
  ({
    dst,
    src,
    onSection : _.map.supplement.bind( _.map ),
    about : 0,
    build : 0,
    path : 0,
    reflector : 0,
    step : 0,
    submodule : 0,
  });
  var exp =
  {
    about : { name : 'test' },
    build : { all : { criterion : { default : 1, debug : 1 }, steps : [ 'submodules.download' ] } },
    path : { in : '.' },
    reflector : { 'reflect.trivial' : { criterion : { debug : 1 }, src : 'path:in', dst : 'path:out' } },
    step : { 'shell.echo' : { shell : 'echo one' } },
    submodule : { test : 'hd://./local' },
  };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty, src - full section about, options for section about - 1';
  var dst_ = {};
  var src_ =
  {
    about :
    {
      'name' : 'wTools',
      'version' : '0.0.1',
      'enabled' : 0,
      'npm.name' : 'wTools',
      'description' : 'test module',
      'keywords' : [ 'test', 'module' ],
      'license' : 'MIT',
      'author' : { name : 'author', email : 'author@domain.com' },
      'contributors' : [ 'author1 <author1@domain.com>', { name : 'author2', email : 'author2@domain.com' } ],
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'interpreters' : [ 'njs =10.0.0', 'chromium >=67.0.0' ],
    },
  };
  var got = _.will.transform.willfilesMerge
  ({
    'dst' : dst_,
    'src' : src_,
    'onSection' : _.map.supplement.bind( _.map ),
    'name' : 1,
    'version' : 1,
    'author' : 1,
    'enabled' : 1,
    'description' : 1,
    'contributors' : 1,
    'interpreters' : 1,
    'license' : 1,
    'keywords' : 1,
    'npm.name' : 1,
    'npm.scripts' : 1,
  });
  var exp =
  {
    about :
    {
      'name' : 'wTools',
      'version' : '0.0.1',
      'enabled' : 0,
      'npm.name' : 'wTools',
      'description' : 'test module',
      'keywords' : [ 'test', 'module' ],
      'license' : 'MIT',
      'author' : 'author <author@domain.com>',
      'contributors' : [ 'author1 <author1@domain.com>', 'author2 <author2@domain.com>' ],
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'interpreters' : [ 'njs =10.0.0', 'chromium >=67.0.0' ],
    },
  };
  test.identical( got, exp );
  test.true( got === dst_ );

  test.case = 'dst - empty, src - full section about, options for section about - 1';
  var dst_ = {};
  var src_ =
  {
    about :
    {
      'name' : 'wTools',
      'version' : '0.0.1',
      'enabled' : 0,
      'npm.name' : 'wTools',
      'description' : 'test module',
      'keywords' : [ 'test', 'module' ],
      'license' : 'MIT',
      'author' : { name : 'author', email : 'author@domain.com' },
      'contributors' : [ 'author1 <author1@domain.com>', { name : 'author2', email : 'author2@domain.com' } ],
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'interpreters' : [ 'njs =10.0.0', 'chromium >=67.0.0' ],
    },
  };
  var got = _.will.transform.willfilesMerge
  ({
    'dst' : dst_,
    'src' : src_,
    'onSection' : _.map.supplement.bind( _.map ),
    'name' : 0,
    'version' : 0,
    'author' : 0,
    'enabled' : 0,
    'description' : 0,
    'contributors' : 0,
    'interpreters' : 0,
    'license' : 0,
    'keywords' : 0,
    'npm.name' : 0,
    'npm.scripts' : 0,
  });
  var exp = {};
  test.identical( got, exp );
  test.true( got === dst_ );

  test.case = 'dst - full section about, src - empty, options for section about - 1';
  var dst_ =
  {
    about :
    {
      'name' : 'wTools',
      'version' : '0.0.1',
      'enabled' : 0,
      'npm.name' : 'wTools',
      'description' : 'test module',
      'keywords' : [ 'test', 'module' ],
      'license' : 'MIT',
      'author' : { name : 'author', email : 'author@domain.com' },
      'contributors' : [ 'author1 <author1@domain.com>', { name : 'author2', email : 'author2@domain.com' } ],
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'interpreters' : [ 'njs =10.0.0', 'chromium >=67.0.0' ],
    },
  }
  var src_ = {};
  var got = _.will.transform.willfilesMerge
  ({
    'dst' : dst_,
    'src' : src_,
    'onSection' : _.map.supplement.bind( _.map ),
    'name' : 1,
    'version' : 1,
    'author' : 1,
    'enabled' : 1,
    'description' : 1,
    'contributors' : 1,
    'interpreters' : 1,
    'license' : 1,
    'keywords' : 1,
    'npm.name' : 1,
    'npm.scripts' : 1,
  });
  var exp =
  {
    about :
    {
      'name' : 'wTools',
      'version' : '0.0.1',
      'enabled' : 0,
      'npm.name' : 'wTools',
      'description' : 'test module',
      'keywords' : [ 'test', 'module' ],
      'license' : 'MIT',
      'author' : { name : 'author', email : 'author@domain.com' },
      'contributors' : [ 'author1 <author1@domain.com>', { name : 'author2', email : 'author2@domain.com' } ],
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'interpreters' : [ 'njs =10.0.0', 'chromium >=67.0.0' ],
    },
  };
  test.identical( got, exp );
  test.true( got === dst_ );

  test.case = 'dst - full section about, src - empty, options for section about - 0';
  var dst_ =
  {
    about :
    {
      'name' : 'wTools',
      'version' : '0.0.1',
      'enabled' : 0,
      'npm.name' : 'wTools',
      'description' : 'test module',
      'keywords' : [ 'test', 'module' ],
      'license' : 'MIT',
      'author' : { name : 'author', email : 'author@domain.com' },
      'contributors' : [ 'author1 <author1@domain.com>', { name : 'author2', email : 'author2@domain.com' } ],
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'interpreters' : [ 'njs =10.0.0', 'chromium >=67.0.0' ],
    },
  }
  var src_ = {};
  var got = _.will.transform.willfilesMerge
  ({
    'dst' : dst_,
    'src' : src_,
    'onSection' : _.map.supplement.bind( _.map ),
    'name' : 0,
    'version' : 0,
    'author' : 0,
    'enabled' : 0,
    'description' : 0,
    'contributors' : 0,
    'interpreters' : 0,
    'license' : 0,
    'keywords' : 0,
    'npm.name' : 0,
    'npm.scripts' : 0,
  });
  var exp =
  {
    about :
    {
      'name' : 'wTools',
      'version' : '0.0.1',
      'enabled' : 0,
      'npm.name' : 'wTools',
      'description' : 'test module',
      'keywords' : [ 'test', 'module' ],
      'license' : 'MIT',
      'author' : { name : 'author', email : 'author@domain.com' },
      'contributors' : [ 'author1 <author1@domain.com>', { name : 'author2', email : 'author2@domain.com' } ],
      'npm.scripts' : { script1 : 'script1', script2 : 'script2' },
      'interpreters' : [ 'njs =10.0.0', 'chromium >=67.0.0' ],
    },
  };
  test.identical( got, exp );
  test.true( got === dst_ );
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

    authorRecordParse,
    authorRecordStr,
    authorRecordNormalize,

    interpreterParse,
    interpreterNormalize,
    engineNormalize,

    submoduleMake,
    submodulesSwitch,

    npmFromWillfile,
    npmFromWillfileWithComplexConfig,
    willfileFromNpm,
    willfileFromNpmWithComplexConfig,
    npmAndWillfileDoubleConvertion,

    willfilesMerge,
    willfilesMergeCheckOptions,

  },

}

// --
// export
// --

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
