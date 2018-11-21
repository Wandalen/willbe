( function _Submodule_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Inheritable;
let Self = function wWillSubmodule( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Submodule';

// --
// inter
// --

function OptionsFrom( o )
{
  _.assert( arguments.length === 1 );
  if( _.strIs( o ) || _.arrayIs( o ) )
  return { path : o }
  return o;
}

//

function form3()
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = submodule;

  if( submodule.formed >= 3 )
  return result;

  _.assert( arguments.length === 0 );
  _.assert( submodule.formed === 2 );
  _.assert( _.strIs( submodule.path ), 'not tested' );
  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );

  /* begin */

  if( !module.supermodule )
  result = submodule._load();

  /* end */

  submodule.formed = 3;
  return result;
}

//

function _load()
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( submodule.formed === 2 );
  _.assert( _.strIs( submodule.path ), 'not tested' );

  _.sure( _.strIs( submodule.path ) || _.arrayIs( submodule.path ), 'Path resource should have "path" field' );

  /* */

  submodule.loadedModule = will.Module
  ({
    will : will,
    alias : submodule.name,
    dirPath : path.join( module.dirPath, submodule.path ),
    supermodule : module,
  }).form();

  submodule.loadedModule.willFilesFind({ isInFile : 0 });
  submodule.loadedModule.willFilesOpen();
  submodule.loadedModule.resourcesForm();

  submodule.loadedModule.willFilesFindReady.doThen( ( err, arg ) =>
  {
    if( err )
    throw _.errAttend( 'Failed to open submodule', submodule.nickName, 'at', submodule.loadedModule.dirPath, '\n', err );
    return arg;
  });

  submodule.loadedModule.ready.doThen( ( err, arg ) =>
  {
    if( err )
    {
      if( will.verbosity >= 3 )
      logger.error( ' ! ' + submodule.nickName + ' was not opened' );
      if( will.verbosity >= 5 )
      _.errLogOnce( err );
    }
    return arg || null;
  });

  /* */

  return submodule.loadedModule.ready;
}

// //
//
// function downloadRequired()
// {
//   let submodule = this;
//   let module = submodule.module;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//
//   let fileProvider2 = fileProvider.providerForPath( module.dirPath );
//   if( fileProvider2.limitedImplementation )
//   return true;
//
//   return false;
// }
//
// //
//
// function download()
// {
//   let submodule = this;
//   let module = submodule.module;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//
//   _.assert( module.formed === 0 );
//   _.assert( _.strDefined( module.dirPath ) );
//   _.assert( _.strDefined( module.alias ) );
//   _.assert( !!module.supermodule );
//
//   module.remotePath = module.dirPath;
//
//   let fileProvider2 = fileProvider.providerForPath( module.dirPath );
//   let submodulesDir = module.supermodule.submodulesCloneDirGet();
//   let localPath = fileProvider2.pathIsolateGlobalAndLocal( module.remotePath )[ 1 ];
//
//   module.clonePath = path.resolve( submodulesDir, module.alias );
//   module.dirPath = path.resolve( module.clonePath, localPath );
//
//   let o2 =
//   {
//     reflectMap : { [ module.remotePath ] : module.clonePath },
//   }
//
//   return will.Predefined.filesReflect.call( fileProvider, o2 );
// }

//

function infoExport()
{
  let submodule = this;
  let module = submodule.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = Parent.prototype.infoExport.call( submodule );

  if( submodule.loadedModule )
  {
    let module2 = submodule.loadedModule;
    let tab = '  ';
    result += tab + 'Exported builds : ' + _.toStr( _.mapKeys( module2.exportedMap ) );
  }

  return result;
}

// --
// relations
// --

let Composes =
{

  path : null,
  description : null,
  criterion : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
  name : null,
}

let Associates =
{
  loadedModule : null,
}

let Restricts =
{
}

let Statics =
{
  OptionsFrom : OptionsFrom,
  MapName : 'submoduleMap',
  PoolName : 'submodule',
}

let Forbids =
{
}

// --
// declare
// --

let Proto =
{

  // inter

  OptionsFrom : OptionsFrom,
  form3 : form3,

  _load : _load,

  // downloadRequired : downloadRequired,
  // download : download,

  infoExport : infoExport,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
