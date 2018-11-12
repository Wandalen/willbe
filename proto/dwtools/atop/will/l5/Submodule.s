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
  let inf = submodule.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = submodule;

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
  let inf = submodule.inf;
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

  submodule.loadedModule.willFilesLoad({ isInFile : 0 });

  submodule.loadedModule.ready.doThen( ( err, arg ) =>
  {
    if( err )
    throw _.err( 'Failed open', submodule.nickName, 'at', submodule.loadedModule.dirPath, '\n', err );
    if( !submodule.loadedModule.isOpened() )
    throw _.err( 'Failed open', submodule.nickName, 'at', submodule.loadedModule.dirPath, '\n' );
    return arg;
  });

  return submodule.loadedModule.ready;
}

//

function infoExport()
{
  let submodule = this;
  let module = submodule.module;
  let inf = submodule.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = Parent.prototype.infoExport.call( submodule );

  if( submodule.loadedModule )
  {
    let module2 = submodule.loadedModule;

    debugger;

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
