( function _PathResource_s_()
{

'use strict';

/**
 * @classdesc Class wWillPathResource provides interface for forming path resources.
 * @class wWillPathResource
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = _.will.Resource;
const Self = wWillPathResource;
function wWillPathResource( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'PathResource';

// --
// inter
// --

function ResouceStructureFrom( o )
{
  _.assert( arguments.length === 1 );
  if( _.strIs( o ) || _.arrayIs( o ) )
  return { path : o }
  return _.mapExtend( null, o );
}

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

  _.assert( _.boolLike( o.instance.importableFromIn ) );
  if( !o.instance.importableFromIn )
  _.mapSupplement( o.resource.criterion, o.instance.criterion );

  o.resource.exportable = o.instance.exportable;
  o.resource.importableFromIn = o.instance.importableFromIn;
  o.resource.importableFromOut = o.instance.importableFromOut;
  o.resource.writable = o.instance.writable;
  if( !o.resource.path )
  o.resource.path = o.instance.path;

  o.Rewriting = 1;
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

  // if( resource.original )
  // _.assert( module[ resource.MapName ][ resource.name ] === resource.original );
  // else
  // _.assert( module[ resource.MapName ][ resource.name ] === resource );

  Parent.prototype.unform.apply( resource, arguments )

  if( !resource.original )
  {
    _.assert( module[ resource.MapName ][ resource.name ] === undefined );
    delete module.pathMap[ resource.name ];
  }

  return resource;
}

//

function form1()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;

  if( resource.formed && resource === module[ resource.MapName ][ resource.name ] )
  return resource;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( resource.formed === 0 );

  if( !resource.original )
  _.sure( !module[ resource.MapName ][ resource.name ], () => 'Module ' + module.dirPath + ' already has ' + resource.qualifiedName );

  Parent.prototype.form1.apply( resource, arguments )

  // if( !resource.original )
  // {
  //   if( resource.original )
  //   _.assert( module[ resource.MapName ][ resource.name ] === resource.original );
  //   else
  //   _.assert( module[ resource.MapName ][ resource.name ] === resource );
  //   module.pathMap[ resource.name ] = resource.path;
  // }

  if( !resource.original && !resource.phantom )
  {
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

  if( resource.formed >= 2 )
  return resource;

  _.assert( arguments.length === 0, 'Expects no arguments' );
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

  if( resource.formed >= 3 )
  return resource;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( resource.formed === 2 );

  if( resource.writable && !resource.criterion.predefined )
  {

    _.sure( _.strIs( resource.path ) || _.arrayIs( resource.path ), 'Path resource should have "path" field' );
    _.assert
    (
      _.all( resource.path, ( p ) => path.isRelative( p ) || path.isGlobal( p ) ),
      () => resource.qualifiedName + ' should not have absolute paths, but have ' + _.entity.exportString( resource.path )
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

// --
// exporter
// --

function exportStructure()
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let o = _.routineOptions( exportStructure, arguments );

  let result = Parent.prototype.exportStructure.apply( resource, [ o ] );

  if( !result )
  return result;

  if( o.exportModule && !o.exportModule.isOut )
  if( result.path === null || result.path === undefined )
  {
    return;
  }

  if( o.exportModule && !o.exportModule.isOut )
  if( result.path === '.' )
  {
    return;
  }

  if( result.path && path.s.anyAreAbsolute( result.path ) )
  {
    result.path = _.filter_( null, result.path, ( p ) =>
    {
      let protocols = path.parseFull( p ).protocols;
      if( !protocols.length )
      return path.relative( module.inPath, p );
      return p;
    });
  }

  return result;
}

exportStructure.defaults = Object.create( Parent.prototype.exportStructure.defaults );

//

function compactField( it )
{
  let resource = this;
  let module = resource.module;

  if( it.dst === '' )
  return;

  return Parent.prototype.compactField.call( resource, it );
}

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
  // let Resolver = _.will.resolver;

  o = _.routineOptions( pathsRebase, arguments );
  _.assert( path.isAbsolute( o.inPath ) );
  _.assert( path.isAbsolute( o.exInPath ) );

  if( !o.relative )
  o.relative = path.relative( o.inPath, o.exInPath );

  if( o.inPath === o.exInPath )
  return resource;

  /* */

  if( resource.name === 'in' )
  return resource;
  if( resource.name === 'module.dir' )
  return resource;

  resource.path = path.filterInplace( resource.path, ( filePath ) =>
  {
    return resource.pathRebase
    ({
      filePath,
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

//

function _pathSet( src )
{
  let resource = this;
  let module = resource.module;
  let ex = resource.path;

  _.assert( src === null || _.strIs( src ) || _.arrayLike( src ) );

  if( _.arrayLike( src ) )
  src = _.arraySlice( src );

  if( src === '' )
  {
    src = null;
  }
  if( src !== null )
  {
    src = _.uri.s.undot( src );
  }

  if( module && resource.name && !resource.original && src )
  if( resource.name !== 'in' )
  if( resource.criterion.predefined && !resource.writable )
  {
    let will = module.will;
    let fileProvider = will.fileProvider;
    let path = fileProvider.path;
    src = path.s.join( module.inPath, src );
  }

  if( module && resource.name && !resource.original )
  {
    // _.assert( resource.path === null || _.entityIdentical( module.pathMap[ resource.name ], resource.path ) );
    _.assert( resource.path === null || _.path.map.identical( module.pathMap[ resource.name ], resource.path ) );
    delete module.pathMap[ resource.name ];
  }

  resource[ pathSymbol ] = src;

  if( module && resource.name && !resource.original && !resource.phantom )
  {
    _.assert( module.pathMap[ resource.name ] === undefined );
    module.pathMap[ resource.name ] = resource.path;
  }

  if( module && !resource.original && !resource.phantom )
  {
    module._pathResourceChanged
    ({
      name : resource.name,
      ex,
      val : src
    });
  }

  // if( module )
  // module.will._pathChanged
  // ({
  //   object : module,
  //   propName : resource.name,
  //   val : src,
  //   ex,
  //   kind : 'resource.set',
  // });

}

// --
// relations
// --

let pathSymbol = Symbol.for( 'path' );

let Composes =
{

  path : _.define.prop( null, { order : 1 } ),

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
  ResouceMapFrom : ResouceStructureFrom,
  ResouceStructureFrom,
  OnInstanceExists,
  MapName : 'pathResourceMap',
  KindName : 'path',
}

let Forbids =
{
}

let Accessors =
{

  path : { set : _pathSet },

}

// --
// declare
// --

let Extension =
{

  // inter

  ResouceMapFrom : ResouceStructureFrom,
  ResouceStructureFrom,
  OnInstanceExists,

  init,
  unform,

  form1,
  form2,
  form3,

  // exporter

  exportStructure,
  compactField,

  // etc

  pathsRebase,
  _pathSet,

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
  extend : Extension,
});

_.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();
