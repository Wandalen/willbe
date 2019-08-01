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
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'PathResource';

// --
// inter
// --

function ResouceDataFrom( o )
{
  _.assert( arguments.length === 1 );
  if( _.strIs( o ) || _.arrayIs( o ) )
  return { path : o }
  return _.mapExtend( null, o );
}

// //
//
// function MakeFor_body( o )
// {
//   let Cls = this;
//   let willf = o.willf;
//   let module = o.module;
//   let will = willf.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//
//   _.assert( arguments.length === 1 );
//
//   let result = Parent.MakeFor.body.apply( Cls, arguments );
//
//   // if( result.criterion.predefined && !path.isEmpty( result.path ) && result.name !== 'in' )
//   // {
//   //   debugger;
//   //   result.path = path.join( module.inPath, result.path );
//   // }
//
//   return result;
// }
//
// _.routineExtend( MakeFor_body, Parent.MakeFor.body );
//
// let MakeFor = _.routineFromPreAndBody( Parent.MakeFor.pre, MakeFor_body );

//

function OnInstanceExists( o )
{
  let module = o.instance.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.routineOptions( OnInstanceExists, arguments );

  o.resource.criterion = o.resource.criterion || Object.create( null );
  _.mapSupplement( o.resource.criterion, o.instance.criterion );
  o.resource.exportable = o.instance.exportable;
  o.resource.importable = o.instance.importable;
  o.resource.writable = o.instance.writable;
  if( !o.resource.path )
  o.resource.path = o.instance.path;

  o.Rewriting = 1;

  if( o.instance.path !== null )
  if( o.resource.name === 'local' && o.IsOutFile )
  o.resource.importable = false;

  // debugger;
  // // if( o.instance.path !== null )
  // if( o.resource.name === 'module.willfiles' )
  // debugger;

  if( o.instance.path !== null )
  if( o.resource.name === 'module.willfiles' )
  o.resource.importable = false;

  if( o.instance.path !== null )
  if( o.resource.name === 'module.dir' )
  o.resource.importable = false;

}

OnInstanceExists.defaults = Object.create( Parent.MakeForEachCriterion.defaults );
OnInstanceExists.defaults.instance = null;

//

function init( o )
{
  let resource = this;

  Parent.prototype.init.apply( resource, arguments );

  return resource;
}

//

function unform()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;

  _.assert( module[ resource.MapName ][ resource.name ] === resource );

  Parent.prototype.unform.apply( resource, arguments )

  if( !resource.original )
  {
    _.assert( module[ resource.MapName ][ resource.name ] === undefined );
    delete module.pathMap[ resource.name ];
  }

  return resource;
}

// //
//
// function copy( o )
// {
//   let resource = this;
//   _.assert( _.objectIs( o ) );
//   _.assert( arguments.length === 1 );
//
//
//
//   let result = Parent.prototype.copy.call( resource, o );
//
//   let module = o.module !== undefined ? o.module : resource.module;
//   if( o.unformedResource )
//   resource.unformedResource = o.unformedResource.cloneExtending({ original : resource, module : module });
//
//   return result;
// }

//

function form1()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;

  if( resource.formed && resource === module[ resource.MapName ][ resource.name ] )
  return resource;

  if( !resource.original )
  _.sure( !module[ resource.MapName ][ resource.name ], () => 'Module ' + module.dirPath + ' already has ' + resource.nickName );

  Parent.prototype.form1.apply( resource, arguments )

  if( !resource.original )
  {
    _.assert( module[ resource.MapName ][ resource.name ] === resource );
    module.pathMap[ resource.name ] = resource.path;
  }

  return resource;
}

//

function form2()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( resource.formed === 1 );

  if( _.arrayIs( resource.path ) )
  resource.path = _.arrayFlattenOnce( resource.path );

  return Parent.prototype.form2.call( resource );
}

//

function form3()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( resource.formed === 2 );

  if( resource.writable && !resource.criterion.predefined )
  {

    _.sure( _.strIs( resource.path ) || _.arrayIs( resource.path ), 'Path resource should have "path" field' );
    _.assert
    (
      _.all( resource.path, ( p ) => path.isRelative( p ) || path.isGlobal( p ) ),
      () => resource.nickName + ' should not have absolute paths, but have ' + _.toStr( resource.path )
    );

  }

  if( resource.path )
  {
    let filePath = _.arrayAs( resource.path );
    filePath.forEach( ( p ) =>
    {
      // _.sure( !path.isGlobal( p ) || path.isAbsolute( p ), 'Global paths should be absolute, but ' + p + ' is not absolute' );
    });
  }

  resource.formed = 3;
  return resource;
}

//

function _pathSet( src )
{
  let resource = this;
  let module = resource.module;

  _.assert( src === null || _.strIs( src ) || _.arrayLike( src ) );

  if( _.arrayLike( src ) )
  src = _.arraySlice( src );

  // if( resource.name === 'module.original.willfiles' && src )
  // debugger;

  if( module && resource.name && !resource.original && src )
  if( resource.name !== 'in' )
  if( resource.criterion.predefined && !resource.writable )
  {
    // _.assert( !!module.pathResourceMap.in ); // xxx
    let fileProvider = module.will.fileProvider;
    let path = fileProvider.path;
    src = path.s.join( module.inPath, src );
  }

  if( module && resource.name && !resource.original )
  {
    _.assert( resource.path === null || _.entityIdentical( module.pathMap[ resource.name ], resource.path ) );
    delete module.pathMap[ resource.name ];
  }

  resource[ pathSymbol ] = src;

  if( module && resource.name && !resource.original )
  {
    _.assert( module.pathMap[ resource.name ] === undefined );
    module.pathMap[ resource.name ] = resource.path;
  }

}

//

function dataExport()
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  let result = Parent.prototype.dataExport.apply( resource, arguments );

  if( result )
  {

    if( result.path && path.s.anyAreAbsolute( result.path ) )
    {
      result.path = _.filter( result.path, ( p ) =>
      {
        let protocols = path.parse( p ).protocols;
        if( !protocols.length )
        return path.relative( module.inPath, p );
        return p;
      });
    }

  }

  return result;
}

dataExport.defaults = Object.create( Parent.prototype.dataExport.defaults );

// --
// etc
// --

function pathsRebase( o )
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let Resolver = will.Resolver;

  o = _.routineOptions( pathsRebase, arguments );
  _.assert( path.isAbsolute( o.inPath ) );
  _.assert( path.isAbsolute( o.exInPath ) );

  if( !o.relative )
  o.relative = path.relative( o.inPath, o.exInPath );

  if( o.inPath === o.exInPath )
  {
    debugger;
    return resource;
  }

  /* */

  if( resource.name === 'in' )
  return resource;
  if( resource.name === 'module.dir' )
  return resource;

  resource.path = path.filterInplace( resource.path, ( filePath ) =>
  {
    return resource.pathRebase
    ({
      filePath : filePath,
      exInPath : o.exInPath,
      inPath : o.inPath,
    });
  });

  return resource;
}

pathsRebase.defaults =
{
  resource : null,
  relative : null,
  inPath : null,
  exInPath : null,
}

// --
// relations
// --

let pathSymbol = Symbol.for( 'path' );

let Composes =
{

  path : _.define.field({ ini : null, order : 1 }),
  // path : null,
  // description : null,
  // criterion : null,
  // inherit : _.define.own([]),

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
  ResouceDataFrom,
  // MakeFor,
  OnInstanceExists,
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

let Extend =
{

  // inter

  ResouceDataFrom,
  // MakeFor,
  OnInstanceExists,

  init,
  unform,
  // copy,

  form1,
  form2,
  form3,

  dataExport,

  // etc

  pathsRebase,

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
  extend : Extend,
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
