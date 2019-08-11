( function _AbstractModule_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillAbstractModule( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractModule';

// --
// inter
// --

function finit()
{
  let module = this;
  return _.Copyable.prototype.finit.apply( module, arguments );
}

//

function init()
{
  let module = this;
  _.workpiece.initFields( module );
  Object.preventExtensions( module );
  _.Will.ResourceCounter += 1;
  module.id = _.Will.ResourceCounter;
}

// --
// path
// --

function WillfilePathIs( filePath )
{
  let fname = _.path.fullName( filePath );
  let r = /\.will\.\w+/;
  if( _.strHas( fname, r ) )
  return true;
  return false;
}

//

function DirPathFromFilePaths( filePaths )
{
  let module = this;

  filePaths = _.arrayAs( filePaths );

  _.assert( _.strsAreAll( filePaths ) );
  _.assert( arguments.length === 1 );

  filePaths = filePaths.map( ( filePath ) =>
  {
    filePath = _.path.normalize( filePath );

    let r1 = /(.*)(?:\.will(?:\.|$))[^\/]*$/;
    let parsed1 = r1.exec( filePath );
    if( parsed1 )
    filePath = parsed1[ 1 ];

    let r2 = /(.*)(?:\.(?:im|ex)(?:\.|$))[^\/]*$/;
    let parsed2 = r2.exec( filePath );
    if( parsed2 )
    filePath = parsed2[ 1 ];

    // if( parsed1 || parsed2 )
    // if( _.strEnds( filePath, '/' ) )
    // filePath = filePath + '.';

    return filePath;
  });

  let filePath = _.strCommonLeft.apply( _, _.arrayAs( filePaths ) );
  _.assert( filePath.length > 0 );
  return filePath;
}

//

function prefixPathForRole( role, isOut )
{
  let module = this;
  let result = module.prefixPathForRoleMaybe( role, isOut );

  _.assert( arguments.length === 2 );
  _.sure( _.strIs( result ), 'Unknown role', _.strQuote( role ) );

  return result;
}

//

function prefixPathForRoleMaybe( role, isOut )
{
  let module = this;
  let result = '';

  _.assert( arguments.length === 2 );

  if( role === 'import' )
  result += '.im';
  else if( role === 'export' )
  result += '.ex';
  else if( role === 'single' )
  result += '';
  else return null;

  result += isOut ? '.out' : '';
  result += '.will';

  return result;
}

//

function CloneDirPathFor( inPath )
{
  _.assert( arguments.length === 1 );
  return _.path.join( inPath, '.module' );
}

//

function OutfilePathFor( outPath, name )
{
  _.assert( arguments.length === 2 );
  _.assert( _.path.isAbsolute( outPath ), 'Expects absolute path outPath' );
  _.assert( _.strDefined( name ), 'Module should have name, declare about::name' );
  name = _.strJoinPath( [ name, '.out.will.yml' ], '.' );
  return _.path.join( outPath, name );
}

//

function CommonPathFor( willfilesPath )
{
  return _.Will.CommonPathFor.apply( _.Will, arguments );
}

// --
// name
// --

function nickNameGet()
{
  let module = this;
  let name = module.name;
  return 'module' + '::' + name;
}

//

function decoratedNickNameGet()
{
  let module = this;
  let result = module.nickName;
  return _.color.strFormat( result, 'entity' );
}

//

function decoratedAbsoluteNameGet()
{
  let module = this;
  let result = module.absoluteName;
  return _.color.strFormat( result, 'entity' );
}

// --
// relations
// --

let functionSymbol = Symbol.for( 'function' );
let aliasNameSymbol = Symbol.for( 'aliasName' );
let dirPathSymbol = Symbol.for( 'dirPath' );

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
  will : null,
}

let Medials =
{
}

let Restricts =
{

  id : null,
  userArray : _.define.own([]),

}

let Statics =
{

  WillfilePathIs,
  DirPathFromFilePaths,
  CommonPathFor,
  CloneDirPathFor,
  OutfilePathFor,

}

let Forbids =
{

  exportMap : 'exportMap',
  exported : 'exported',
  export : 'export',
  downloaded : 'downloaded',
  formReady : 'formReady',
  filePath : 'filePath',
  errors : 'errors',
  associatedSubmodule : 'associatedSubmodule',
  execution : 'execution',
  allModuleMap : 'allModuleMap',
  opener : 'opener',
  Counter : 'Counter',
  moduleWithPathMap : 'moduleWithPathMap',

}

let Accessors =
{

  nickName : { getter : nickNameGet, combining : 'rewrite', readOnly : 1 },
  decoratedNickName : { getter : decoratedNickNameGet, combining : 'rewrite', readOnly : 1 },
  decoratedAbsoluteName : { getter : decoratedAbsoluteNameGet, readOnly : 1 },

}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,

  // path

  WillfilePathIs,
  DirPathFromFilePaths,
  prefixPathForRole,
  prefixPathForRoleMaybe,

  CommonPathFor,
  CloneDirPathFor,
  OutfilePathFor,

  // name

  nickNameGet,
  decoratedNickNameGet,
  decoratedAbsoluteNameGet,

  // relation

  Composes,
  Aggregates,
  Associates,
  Medials,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
