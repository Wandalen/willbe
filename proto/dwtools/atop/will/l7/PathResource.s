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

  return resource;
}

//

function unform()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;

  _.assert( module[ resource.MapName ][ resource.name ] === resource );
  if( willf )
  _.assert( willf[ resource.MapName ][ resource.name ] === resource );

  Parent.prototype.unform.apply( resource, arguments )

  delete module[ resource.MapName ][ resource.name ];
  if( willf )
  delete willf[ resource.MapName ][ resource.name ];

  delete module.pathMap[ resource.name ];
  if( willf )
  delete willf.pathMap[ resource.name ];

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

  _.sure( !module[ resource.MapName ][ resource.name ], () => 'Module ' + module.dirPath + ' already has ' + resource.nickName );
  _.assert( !willf || !willf[ resource.MapName ][ resource.name ] );

  Parent.prototype.form1.apply( resource, arguments )

  module[ resource.MapName ][ resource.name ] = resource;
  if( willf )
  willf[ resource.MapName ][ resource.name ] = resource;

  module.pathMap[ resource.name ] = resource.path;
  if( willf )
  willf.pathMap[ resource.name ] = resource.path;

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

  // if( resource.id === 140 )
  // debugger;

  if( _.arrayLike( src ) )
  src = _.arraySlice( src );

  if( module && resource.name && !resource.original )
  {
    _.assert( module.pathMap[ resource.name ] === resource.path || resource.path === null );
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

  debugger

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

  resource.path = path.pathMapFilterInplace( resource.path, ( filePath ) =>
  {
    return resource.pathRebase
    ({
      filePath : filePath,
      exInPath : o.exInPath,
      inPath : o.inPath,
    });
  });

/*
  if( resource.criterion.predefined )
  return resource;

  if( resource.src.hasAnyPath() )
  resource.src.prefixPath = path.pathMapFilterInplace( resource.src.prefixPath || null, ( filePath ) =>
  {
    if( filePath === null )
    return o.relative;
    return resource.pathRebase
    ({
      filePath : filePath,
      exInPath : o.exInPath,
      inPath : o.inPath,
    });
  });

  if( resource.dst.hasAnyPath() )
  debugger;
  if( resource.dst.hasAnyPath() )
  resource.dst.prefixPath = path.pathMapFilterInplace( resource.dst.prefixPath || null, ( filePath ) =>
  {
    if( filePath === null )
    return o.relative;
    return resource.pathRebase
    ({
      filePath : filePath,
      exInPath : o.exInPath,
      inPath : o.inPath,
    });
  });
*/

  return resource;

  /* */

  // function replace( filePath )
  // {
  //   if( filePath )
  //   if( path.isRelative( filePath ) )
  //   {
  //     if( Resolver.selectorIs( filePath ) )
  //     {
  //       let filePath2 = Resolver.selectorNormalize( filePath );
  //       if( _.strBegins( filePath2, '{' ) )
  //       return filePath;
  //       filePath = filePath2;
  //     }
  //     return path.relative( o.inPath, path.join( o.exInPath, filePath ) );
  //   }
  //   return filePath;
  // }

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

let Extend =
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
