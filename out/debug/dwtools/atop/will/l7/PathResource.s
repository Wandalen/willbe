( function _PathResource_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

let _ = wTools;
let Parent = _.Will.Resource;
let Self = function wWillPathResource( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'PathResource';

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

function OnInstanceExists( instance, options )
{
  let module = instance.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  options.criterion = options.criterion || Object.create( null );
  _.mapSupplement( options.criterion, instance.criterion );
  options.exportable = instance.exportable;
  options.importable = instance.importable;
  options.writable = instance.writable;
  if( !options.path )
  options.path = instance.path;

  options.Rewriting = 1;

  if( instance.path !== null )
  if( options.name === 'local' && options.IsOutFile )
  options.importable = false;

}

//

function init( o )
{
  let resource = this;

  Parent.prototype.init.apply( resource, arguments );

  // if( resource.module && resource.module instanceof _.Will.OpenerModule )
  // resource.module = resource.module.openedModule;
  // _.assert( resource.module === null || resource.module instanceof _.Will.OpenedModule );

  return resource;
}

//

function unform()
{
  let pathResource = this;
  let module = pathResource.module;
  let willf = pathResource.willf;

  _.assert( module[ pathResource.MapName ][ pathResource.name ] === pathResource );
  if( willf )
  _.assert( willf[ pathResource.MapName ][ pathResource.name ] === pathResource );

  Parent.prototype.unform.apply( pathResource, arguments )

  delete module[ pathResource.MapName ][ pathResource.name ];
  if( willf )
  delete willf[ pathResource.MapName ][ pathResource.name ];

  delete module.pathMap[ pathResource.name ];
  if( willf )
  delete willf.pathMap[ pathResource.name ];

  return pathResource;
}

//

function form1()
{
  let pathResource = this;
  let module = pathResource.module;
  let willf = pathResource.willf;

  if( pathResource.formed && pathResource === module[ pathResource.MapName ][ pathResource.name ] )
  return pathResource;

  _.sure( !module[ pathResource.MapName ][ pathResource.name ], () => 'Module ' + module.dirPath + ' already has ' + pathResource.nickName );
  _.assert( !willf || !willf[ pathResource.MapName ][ pathResource.name ] );

  Parent.prototype.form1.apply( pathResource, arguments )

  module[ pathResource.MapName ][ pathResource.name ] = pathResource;
  if( willf )
  willf[ pathResource.MapName ][ pathResource.name ] = pathResource;

  module.pathMap[ pathResource.name ] = pathResource.path;
  if( willf )
  willf.pathMap[ pathResource.name ] = pathResource.path;

  return pathResource;
}

//

function form2()
{
  let pathResource = this;
  let module = pathResource.module;
  let willf = pathResource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( pathResource.formed === 1 );

  if( _.arrayIs( pathResource.path ) )
  pathResource.path = _.arrayFlattenOnce( pathResource.path );

  return Parent.prototype.form2.call( pathResource );
}

//

function form3()
{
  let pathResource = this;
  let module = pathResource.module;
  let willf = pathResource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( pathResource.formed === 2 );

  if( pathResource.writable && !pathResource.criterion.predefined )
  {

    _.sure( _.strIs( pathResource.path ) || _.arrayIs( pathResource.path ), 'Path resource should have "path" field' );
    _.assert
    (
      _.all( pathResource.path, ( p ) => path.isRelative( p ) || path.isGlobal( p ) ),
      () => pathResource.nickName + ' should not have absolute paths, but have ' + _.toStr( pathResource.path )
    );

  }

  if( pathResource.path )
  {
    let filePath = _.arrayAs( pathResource.path );
    filePath.forEach( ( p ) =>
    {
      // _.sure( !path.isGlobal( p ) || path.isAbsolute( p ), 'Global paths should be absolute, but ' + p + ' is not absolute' );
    });
  }

  pathResource.formed = 3;
  return pathResource;
}

//

function _pathSet( src )
{
  let pathResource = this;
  let module = pathResource.module;

  _.assert( src === null || _.strIs( src ) || _.arrayLike( src ) );

  if( _.arrayLike( src ) )
  src = _.arraySlice( src );

  if( module && pathResource.name && !pathResource.original )
  {
    _.assert( module.pathMap[ pathResource.name ] === pathResource.path || pathResource.path === null );
    delete module.pathMap[ pathResource.name ];
  }

  pathResource[ pathSymbol ] = src;

  if( module && pathResource.name && !pathResource.original )
  {
    _.assert( module.pathMap[ pathResource.name ] === undefined );
    module.pathMap[ pathResource.name ] = pathResource.path;
  }

}

//

function dataExport()
{
  let pathResource = this;
  let module = pathResource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  let result = Parent.prototype.dataExport.apply( pathResource, arguments );

  if( result )
  {

    // debugger;

    // if( pathResource.nickName === 'path::remote' )
    // debugger;
    // if( result.path && path.s.anyAreAbsolute( result.path ) )
    // debugger;

    // if( result.path && path.s.anyAreAbsolute( result.path ) && path.s.noneAreGlobal( result.path ) )
    if( result.path && path.s.anyAreAbsolute( result.path ) )
    {
      // debugger;
      result.path = _.filter( result.path, ( p ) =>
      {
        let protocols = path.parse( p ).protocols;
        // debugger;
        // if( _.arrayHasNone( protocols, [ 'http', 'https', 'ssh' ] ) )
        if( !protocols.length )
        return path.relative( module.inPath, p );
        return p;
      });
      // debugger;
    }

  }

  return result;
}

dataExport.defaults = Object.create( Parent.prototype.dataExport.defaults );

// --
// relations
// --

let pathSymbol = Symbol.for( 'path' );

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
}

let Restricts =
{
}

let Statics =
{
  OptionsFrom : OptionsFrom,
  OnInstanceExists : OnInstanceExists,
  MapName : 'pathResourceMap',
  KindName : 'path',
}

let Forbids =
{
}

let Accessors =
{

  path : { setter : _pathSet },

}

// --
// declare
// --

let Proto =
{

  // inter

  OptionsFrom,
  OnInstanceExists,

  init,
  unform,
  form1,
  form2,
  form3,

  dataExport,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

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
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
