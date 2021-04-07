( function _Reflector_s_()
{

'use strict';

/**
 * @classdesc Class wWillReflector provides interface for forming and handling reflector resources.
 * @class wWillReflector
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = _.will.Resource;
const Self = wWillReflector;
function wWillReflector( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Reflector';

// --
// inter
// --

function ResouceStructureFrom( o )
{
  let result = Parent.prototype.ResouceStructureFrom.apply( this, arguments );
  delete result.step;
  return result;
}

//

function MakeFor_body( o )
{
  let Cls = this;
  let willf = o.willf;
  let module = o.module;
  let will = willf.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );

  Parent.MakeFor.body.apply( Cls, arguments );

  // let o3 = Object.create( null );
  // o3.resource = Object.create( null );
  // o3.resource.criterion = _.mapExtend( null, o.resource.criterion || {} );
  // o3.resource.shell = o.resource.shell;
  // o3.Importing = 1;
  // o3.module = module;
  // o3.willf = willf;
  // o3.name = o.name;
  //
  // if( o.resource.step )
  // {
  //   if( !_.mapIs( o.resource.step ) )
  //   o.resource.step = { inherit : o.resource.step }
  //   _.mapExtend( o3.resource, o.resource.step );
  // }
  //
  // if( o.resource.shell )
  // {
  //
  //   o3.resource.forEachDst = 'reflector::' + o.name + '*';
  //   if( !o3.resource.inherit )
  //   o3.resource.inherit = 'shell.run';
  //
  //   _.will.Step.MakeFor( o3 );
  //
  // }
  // else if( !module.stepMap[ o.name ] )
  // {
  //
  //   // o3.resource.filePath = 'reflector::' + o.name + '*';
  //   o3.resource.filePath = 'reflector::' + o.name;
  //   if( !o3.resource.inherit )
  //   o3.resource.inherit = 'files.reflect';
  //   o3.Optional = 1;
  //
  //   _.will.Step.MakeFor( o3 );
  //
  // }

}

_.routineExtend( MakeFor_body, Parent.MakeFor.body );

let MakeFor = _.routine.uniteCloning_( Parent.MakeFor.head, MakeFor_body );

//

function MakeSingle( o )
{
  let Cls = this;
  let willf = o.resource.willf;
  let module = o.resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  o = _.routineOptions( MakeSingle, arguments );

  let result = Parent.MakeSingle.apply( Cls, arguments );

  if( _.boolLikeFalse( o.resource.exportable ) )
  return result;

  let o3 = Object.create( null );
  o3.resource = Object.create( null );
  o3.resource.criterion = _.mapExtend( null, o.resource.criterion || {} );
  // if( o.resource.shell ) /* Dmytro : temporary fix, need to investigate the behaviour of reflectors which produce shell commands */
  o3.resource.shell = o.resource.shell;
  o3.resource.module = module;
  o3.resource.willf = willf;
  o3.resource.name = o.resource.name;

  o3.Importing = 1;
  // o3.module = module;
  // o3.willf = willf;
  // o3.name = o.name;

  if( o.resource.step )
  {
    // debugger;
    if( !_.mapIs( o.resource.step ) )
    o.resource.step = { inherit : o.resource.step }
    _.mapExtend( o3.resource, o.resource.step );
  }

  if( o.resource.shell )
  {
    // debugger;
    // o3.resource.forEachDst = 'reflector::' + o.resource.name + '*';
    o3.resource.forEachDst = 'reflector::' + o.resource.name;
    if( !o3.resource.inherit )
    o3.resource.inherit = 'shell.run';

    _.will.Step.MakeSingle( o3 );
  }
  else if( !module.stepMap[ o.resource.name ] )
  {
    // debugger;
    // o3.resource.filePath = 'reflector::' + o.resource.name + '*';
    o3.resource.filePath = 'reflector::' + o.resource.name;
    if( !o3.resource.inherit )
    o3.resource.inherit = 'files.reflect';
    o3.Optional = 1;

    _.will.Step.MakeSingle( o3 );
  }

  return result;
}

MakeSingle.defaults =
{
  ... Parent.MakeSingle.defaults,
}

//

function init( o )
{
  let reflector = this;

  _.assert( o && o.module );

  let module = o.module;
  let will = module.will;
  let fileProvider = will.fileProvider;

  reflector.src = fileProvider.recordFilter();
  reflector.dst = fileProvider.recordFilter();

  let result = Parent.prototype.init.apply( reflector, arguments );

  reflector.src.pairWithDst( reflector.dst );
  reflector.src.pairRefineLight();

  return result;
}

//

function cloneDerivative()
{
  let reflector = this;
  let reflector2 = Parent.prototype.cloneDerivative.apply( reflector, arguments );

  if( reflector.src.dst === reflector.dst )
  {
    _.assert( reflector2.src.dst === reflector2.dst );
    _.assert( reflector2.src === reflector2.dst.src );
    _.assert( reflector2.src.filePath === reflector2.dst.filePath );
    if( _.mapIs( reflector.dst.filePath ) )
    if( reflector.dst.filePath === reflector.src.filePath )
    reflector2.dst.filePath = reflector2.src.filePath;
  }

  return reflector2;
}

//

function form1()
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( reflector.formed >= 1 )
  return reflector;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !reflector.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !willf || !!willf.formed );
  _.assert( _.strDefined( reflector.name ) );

  /* begin */

  // if( reflector.name === "exported.files.proto.export" )
  // debugger;

  reflector.src = reflector.src || Object.create( null );
  if( reflector.src )
  {
    reflector.src.system = fileProvider;
    if( !reflector.src.formed )
    reflector.src._formAssociations();
  }

  reflector.dst = reflector.dst || Object.create( null );
  if( reflector.dst )
  {
    reflector.dst.system = fileProvider;
    if( !reflector.dst.formed )
    reflector.dst._formAssociations();
  }

  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.src === reflector.dst.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  /* end */

  Parent.prototype.form1.call( reflector );

  return reflector;
}

//

function form2( o )
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( reflector.formed >= 2 )
  return reflector;

  _.assert( reflector.formed === 1 );
  o = _.routineOptions( form2, arguments );

  if( !reflector.unformedResource && !reflector.criterion.generated )
  {

    if( reflector.original )
    {
      if( !reflector.original.unformedResource )
      reflector.original.unformedResource = reflector.original.cloneDerivative();
      reflector.unformedResource = reflector.original.unformedResource;
    }
    else
    {
      reflector.unformedResource = reflector.cloneDerivative();
    }

  }

  reflector.selectorsNormalize();

  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.src === reflector.dst.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  if( reflector.src.hasAnyPath() )
  {
    reflector.src.prefixPath = _.filter_( null, reflector.src.prefixPath, ( prefixPath ) =>
    {
      if( _.will.resolver.Resolver.selectorIs( prefixPath ) )
      return prefixPath;
      return path.s.join( module.inPath, prefixPath || '.' )
    });
  }

  // if( reflector.name === 'reflect.submodules' )
  // debugger;
  // if( reflector.absoluteName === "module::a / module::submodule2 / reflector::exported.files.export" )
  // debugger;

  // if( reflector.name === 'reflect.proto2' )
  // debugger;

  let result = Parent.prototype.form2.apply( reflector, arguments );

  // if( reflector.name === 'reflect.proto2' )
  // debugger;

  if( reflector.mandatory === null )
  reflector.mandatory = 1;
  if( reflector.dstRewritingOnlyPreserving === null )
  reflector.dstRewritingOnlyPreserving = 1;
  if( reflector.linking === null )
  reflector.linking = 'hardLinkMaybe';

  _.assert( _.boolLike( reflector.mandatory ) );
  _.assert( _.boolLike( reflector.dstRewritingOnlyPreserving ) );
  _.assert( _.strIs( reflector.linking ) );

  // mandatory : null,
  // dstRewritingOnlyPreserving : null,
  // linking : null,

  return result;
}

form2.defaults =
{
  visited : null,
}

//

function form3()
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( reflector.formed === 3 )
  return reflector;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( reflector.formed === 2 );

  /* begin */

  reflector.pathsResolve();
  if( reflector.src.hasAnyPath() )
  reflector.src.prefixPath = path.s.join( module.inPath, reflector.src.prefixPath || '.' );

  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.src === reflector.dst.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  reflector.prefixesApply();
  reflector.prefixesRelative();

  reflector.src.basePath = reflector.src.basePathSimplest();
  reflector.dst.basePath = reflector.dst.basePathSimplest();
  reflector.sureRelativeOrGlobal();

  _.assert
  (
    reflector.src.prefixPath === null || path.s.allAreAbsolute( reflector.src.prefixPath ),
    () => 'Formed reflector should have absolute prefix or none, but source of ' + reflector.absoluteName + ' has ' + _.entity.exportStringShallow( reflector.src.prefixPath )
  );
  _.assert
  (
    reflector.dst.prefixPath === null || path.s.allAreAbsolute( reflector.dst.prefixPath ),
    () => 'Formed reflector should have absolute prefix or none, but destination of ' + reflector.absoluteName + ' has ' + _.entity.exportStringShallow( reflector.src.prefixPath )
  );

  /* end */

  reflector.formed = 3;
  return reflector;
}

//

function _inheritMultiple( o )
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( reflector.formed === 1 );
  _.assert( _.arrayIs( reflector.inherit ) );
  _.assert( reflector._accumulator === null );
  _.routineOptions( _inheritMultiple, arguments );

  reflector._accumulator = new _.will.Reflector({ module, original : reflector, name : reflector.name });
  reflector._accumulator.src.pairWithDst( reflector._accumulator.dst );
  reflector._accumulator.src.pairRefineLight();

  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.src === reflector.dst.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  reflector._inheritPrefixes({ visited : o.visited });

  reflector.prefixesResolve();

  reflector._inheritPathMap({ visited : o.visited });

  Parent.prototype._inheritMultiple.call( reflector, o );

  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.src === reflector.dst.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  reflector.pathsResolve();

  reflector.prefixesApply();

  reflector._accumulator.prefixesApply();

  if( reflector.id === 56 )
  debugger;
  reflector.src.and( reflector._accumulator.src ).pathsSupplementJoining( reflector._accumulator.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  reflector.dst.and( reflector._accumulator.dst ).pathsSupplementJoining( reflector._accumulator.dst );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  return reflector;
}

_inheritMultiple.defaults =
{
  ancestors : null,
  visited : null,
  extending : 0,
  isDst : 0,
}

//

function _inheritSingle( o )
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let reflector2 = o.ancestor;

  _.assertRoutineOptions( _inheritSingle, arguments );
  _.assert( arguments.length === 1 );
  _.assert( reflector.formed === 1 );
  _.assert( reflector2 instanceof reflector.constructor, () => 'Expects reflector, but got', _.entity.strType( reflector2 ) );
  _.assert( !!reflector2.formed );
  _.assert( reflector.src instanceof _.FileRecordFilter );
  _.assert( reflector.dst instanceof _.FileRecordFilter );
  _.assert( reflector2.src instanceof _.FileRecordFilter );
  _.assert( reflector2.dst instanceof _.FileRecordFilter );
  // _.assert( _.entityIdentical( reflector.src.filePath, reflector.filePath ) );
  // _.assert( _.entityIdentical( reflector2.src.filePath, reflector2.filePath ) );
  _.assert( _.path.map.identical( reflector.src.filePath, reflector.filePath ) );
  _.assert( _.path.map.identical( reflector2.src.filePath, reflector2.filePath ) );
  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.dst.src === reflector.src );
  _.assert( !!reflector._accumulator );

  if( reflector2.formed < 3 )
  {
    _.sure( !_.longHas( o.visited, reflector2.name ), () => 'Cyclic dependency ' + reflector.qualifiedName + ' of ' + reflector2.qualifiedName );
    if( reflector2.formed < 2 )
    {
      reflector2.form2({ visited : o.visited });
    }
    reflector2.form3();
  }

  _.assert( reflector2.formed === 3 );

  let only = _.mapOnlyNulls( reflector );
  only = _.mapOnly_( null, reflector, reflector.Composes );
  let extend = _.mapOnly_( null, reflector2, only );

  delete extend.src;
  delete extend.dst;
  delete extend.criterion;
  delete extend.filePath;
  delete extend.inherit;

  // if( reflector.name === 'reflect.proto2' )
  // debugger;

  // reflector.copy( extend );

  for( let k in extend )
  if( reflector[ k ] === null && extend[ k ] !== null )
  reflector[ k ] = extend[ k ];

  // if( reflector.name === 'reflect.proto2' )
  // debugger;

  reflector.criterionInherit( reflector2.criterion );

  reflector2 = reflector2.cloneDerivative();

  if( reflector2.src.hasAnyPath() )
  reflector2.src.prefixPath = path.join( reflector2.module.inPath, reflector2.src.prefixPath || '.' );
  if( reflector2.dst.hasAnyPath() )
  reflector2.dst.prefixPath = path.join( reflector2.module.inPath, reflector2.dst.prefixPath || '.' );

  reflector2.pathsResolve();

  if( reflector2.src.prefixPath && reflector2.src.filePath )
  {
    reflector2.src.prefixesApply();
  }
  if( reflector2.dst.prefixPath && reflector2.dst.filePath )
  {
    reflector2.dst.prefixesApply();
  }

  /* */

  // if( reflector.name === 'reflect.not.test.only.js.v1' )
  // debugger;

  if( o.extending )
  {

    reflector.src.pairRefineLight();

    reflector.src.and( reflector2.src ).pathsExtend( reflector2.src );
    _.assert( reflector.src.filePath === reflector.dst.filePath );
    reflector.dst.and( reflector2.dst ).pathsExtend( reflector2.dst );
    _.assert( reflector.src.filePath === reflector.dst.filePath );

  }
  else
  {

    reflector._accumulator.src.pairRefineLight();
    reflector._accumulator.src.and( reflector2.src ).pathsExtend( reflector2.src );
    _.assert( reflector._accumulator.src.filePath === reflector._accumulator.dst.filePath );
    reflector._accumulator.dst.and( reflector2.dst ).pathsExtend( reflector2.dst );
    _.assert( reflector._accumulator.src.filePath === reflector._accumulator.dst.filePath );

  }

  // if( reflector.name === 'reflect.not.test.only.js.v1' )
  // debugger;

}

_inheritSingle.defaults =
{
  ancestor : null,
  visited : null,
  extending : 0,
  isDst : 0,
}

//

function _inheritPathMap( o )
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( _inheritPathMap, arguments );
  _.assert( reflector.filePath === null || _.mapIs( reflector.filePath ) )

  if( reflector.filePath === null )
  return;

  let pathMap = _.mapExtend( null, reflector.filePath );
  _.mapDelete( reflector.filePath );

  reflector._inheritPathMapAct1
  ({
    pathMap,
    visited : o.visited,
  });

}

_inheritPathMap.defaults =
{
  visited : null,
}

//

function _inheritPathMapAct1( o )
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( _inheritPathMapAct1, arguments );
  _.assert( o.pathMap === null || _.mapIs( o.pathMap ) )

  if( o.pathMap === null )
  return;

  for( let src in o.pathMap )
  {
    let dst = o.pathMap[ src ];

    // if( _.will.resolver.Resolver.selectorIs( src ) )
    if( _.will.resolver.Resolver.selectorIs( src ) || _.will.resolver.Resolver.selectorIs( dst ) )
    {
      reflector._inheritPathMapAct2
      ({
        dst,
        src,
        visited : o.visited,
      });
    }
    else
    {
      set( dst, src );
    }

  }

  function set( dst, src )
  {
    reflector.filePath = reflector.filePath || Object.create( null );
    _.assert( path.isElement( dst ), () => 'Expects destination path, got ' + _.entity.strType( dst ) );
    _.assert( path.isElement( src ), () => 'Expects source path, got ' + _.entity.strType( src ) );
    let resolvedSrc = src ? path.normalize( src ) : src;
    _.assert( _.mapIs( reflector.filePath ) );
    _.assert
    (
      reflector.filePath[ resolvedSrc ] === undefined || reflector.filePath[ resolvedSrc ] === dst,
      () => 'Source path ' + resolvedSrc + ' already has value\n'
      + _.strQuote( reflector.filePath[ resolvedSrc ] ) + ' <> '
      + _.strQuote( dst )
    );

    // if( reflector.qualifiedName === "reflector::exported.export" )
    // debugger;

    if( resolvedSrc === '' )
    path.mapExtend( reflector.filePath, { '' : dst } );
    else
    path.mapExtend( reflector.filePath, resolvedSrc, dst );
  }

}

_inheritPathMapAct1.defaults =
{
  pathMap : null,
  visited : null,
}

//

function _inheritPathMapAct2( o )
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( _inheritPathMapAct2, arguments );

  // if( reflector.name === 'reflect.submodules.debug' )
  // debugger;

  let resolvedSrc = o.src;
  if( _.will.resolver.Resolver.selectorIs( resolvedSrc ) )
  resolvedSrc = module.pathResolve
  ({
    selector : resolvedSrc,
    visited : o.visited,
    currentContext : reflector,
    pathResolving : 'in', /* yyy */
  });

  let resolvedDst = o.dst;
  if( _.will.resolver.Resolver.selectorIs( resolvedDst ) )
  resolvedDst = module.pathResolve
  ({
    selector : resolvedDst,
    visited : o.visited,
    currentContext : reflector,
    pathUnwrapping : 1,
    pathResolving : 'in', /* yyy */
  });

  if
  (
    !_.errIs( resolvedSrc ) && !_.strIs( resolvedSrc ) && !_.arrayIs( resolvedSrc )
    && !( resolvedSrc instanceof _.will.Reflector )
  )
  {
    debugger;
    resolvedSrc = _.err( 'Source of path map was resolved to unexpected type', _.entity.strType( resolvedSrc ) );
  }
  if( _.errIs( resolvedSrc ) )
  {
    debugger;
    throw _.err( resolvedSrc, '\nFailed to form', reflector.qualifiedName );
  }
  if( _.errIs( resolvedDst ) )
  {
    debugger;
    throw _.err( resolvedDst, '\nFailed to form', reflector.qualifiedName );
  }

  if( resolvedSrc && resolvedSrc instanceof _.will.Reflector )
  {
    resolvedSrc = resolvedSrc.cloneDerivative();
    resolvedSrc.form(); /* xxx : implement assert against recrusion */
  }

  if( resolvedDst && resolvedDst instanceof _.will.Reflector )
  {
    resolvedDst = resolvedDst.cloneDerivative();
    resolvedDst.form(); /* xxx : implement assert against recrusion */
  }

  return reflector._inheritPathMapAct3
  ({
    dst : resolvedDst,
    src : resolvedSrc,
  });
}

_inheritPathMapAct2.defaults =
{
  src : null,
  dst : null,
  visited : null,
}

//

function _inheritPathMapAct3( o )
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( _inheritPathMapAct3, arguments );

  let withDst = false;
  if( o.dst instanceof Self )
  {
    o.dst = o.dst.cloneDerivative();
    o.dst.prefixesApply( 1 );
    o.dst = o.dst.dst.filePathDstArrayNonBoolGet();
    withDst = true;
  }
  else
  {
    o.dst = path.mapsPair( o.dst, null );
    o.dst = path.filterInplace( o.dst, ( p, it ) =>
    {
      if( it.side === 'src' )
      return '';
      return p;
    });
  }

  if( o.src instanceof _.will.Reflector )
  {
    o.src = o.src.cloneDerivative();
    _.assert( !!o.src.original );
    o.src.prefixesApply( 1 );
    o.src = o.src.src.filePathSrcArrayNonBoolGet();
  }

  _.assert( o.dst === null || _.strIs( o.dst ) || _.arrayIs( o.dst ) || _.mapIs( o.dst ) );
  _.assert( o.src === null || _.strIs( o.src ) || _.arrayIs( o.src ) || _.mapIs( o.src ) );

  // if( reflector.name === 'reflect.submodules' )
  // debugger;

  o.src = reflector.pathAbsolute( o.src, 1 );
  o.dst = reflector.pathAbsolute( o.dst, 0 );

  // o.src = reflector.pathRelative( o.src );
  // o.dst = reflector.pathRelative( o.dst );

  // o.src = path.filterPairsInplace( o.src, ( it ) =>
  // {
  //   if( it.src && path.isAbsolute( it.src ) && !path.isGlobal( it.src ) )
  //   it.src = path.relative( module.inPath, it.src );
  //   if( it.dst && path.isAbsolute( it.dst ) && !path.isGlobal( it.dst ) )
  //   it.dst = path.relative( module.inPath, it.dst );
  //   return { [ it.src ] : it.dst };
  // });
  //
  // o.dst = path.filterPairsInplace( o.dst, ( it ) =>
  // {
  //   if( it.src && path.isAbsolute( it.src ) && !path.isGlobal( it.src ) )
  //   it.src = path.relative( module.inPath, it.src );
  //   if( it.dst && path.isAbsolute( it.dst ) && !path.isGlobal( it.dst ) )
  //   it.dst = path.relative( module.inPath, it.dst );
  //   return { [ it.src ] : it.dst };
  // });

  let pathMap3 = path.mapsPair( o.dst, o.src );

  for( let src in pathMap3 )
  {
    let dst = pathMap3[ src ];
    _.assert( !_.will.resolver.Resolver.selectorIs( src ) );
    _.assert( !_.will.resolver.Resolver.selectorIs( dst ) );
    set( dst, src );
  }

  function set( dst, src )
  {
    reflector.filePath = reflector.filePath || Object.create( null );
    _.assert( path.isElement( dst ), () => 'Expects destination path, got ' + _.entity.strType( dst ) );
    _.assert( path.isElement( src ), () => 'Expects source path, got ' + _.entity.strType( src ) );
    let resolvedSrc = src ? path.normalize( src ) : src;
    _.assert( _.mapIs( reflector.filePath ) );
    _.assert
    (
      reflector.filePath[ resolvedSrc ] === undefined || reflector.filePath[ resolvedSrc ] === dst,
      () => 'Source path ' + resolvedSrc + ' already has value\n'
      + _.strQuote( reflector.filePath[ resolvedSrc ] ) + ' <> '
      + _.strQuote( dst )
    );
    if( resolvedSrc === '' )
    path.mapExtend( reflector.filePath, { '' : dst } );
    else
    path.mapExtend( reflector.filePath, resolvedSrc, dst );
  }

}

_inheritPathMapAct3.defaults =
{
  src : null,
  dst : null,
}

//

function _inheritPrefixes( o )
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( _inheritPathMap, arguments );
  _.assert( reflector.src.prefixPath === null || _.strIs( reflector.src.prefixPath ) || _.arrayIs( reflector.src.prefixPath ) );
  _.assert( reflector.dst.prefixPath === null || _.strIs( reflector.dst.prefixPath ) || _.arrayIs( reflector.dst.prefixPath ) );

  /* */

  let isEmpty = path.isEmpty( reflector.src.filePath );
  if( !isEmpty )
  if( _.mapIs( reflector.src.filePath ) && _.mapsAreIdentical( reflector.src.filePath, { '.' : '.' } ) )
  isEmpty = true;

  /* */

  // if( reflector.name === "reflect.files2" )
  // debugger;
  // if( reflector.name === 'reflect.files2' )
  // debugger;

  let srcPrefixPath = reflector.src.prefixPath;
  reflector.src.prefixPath = null;
  let dstPrefixPath = reflector.dst.prefixPath;
  reflector.dst.prefixPath = null;

  if( srcPrefixPath )
  {
    // let prefixPath = reflector.src.prefixPath; debugger;
    // reflector.src.prefixPath = null;
    reflector.src.prefixPath = path.filterInplace( srcPrefixPath, ( prefixPath ) =>
    {
      // debugger;
      if( _.will.resolver.Resolver.selectorIs( prefixPath ) )
      return inherit( prefixPath, 0 );
      return prefixPath;
    });
  }
  else
  {
    reflector.src.prefixPath = srcPrefixPath;
  }

  if( dstPrefixPath )
  {
    // let prefixPath = reflector.dst.prefixPath; debugger;
    // reflector.dst.prefixPath = null;
    reflector.dst.prefixPath = path.filterInplace( dstPrefixPath, ( prefixPath ) =>
    {
      // debugger;
      if( _.will.resolver.Resolver.selectorIs( prefixPath ) )
      return inherit( prefixPath, 1 );
      return prefixPath;
    });
  }
  else
  {
    reflector.dst.prefixPath = dstPrefixPath;
  }

  // if( reflector.name === "reflect.files2" )
  // debugger;

  // if( reflector.dst.prefixPath )
  // reflector.dst.prefixPath = path.filterInplace( reflector.dst.prefixPath, ( prefixPath ) =>
  // {
  //   if( _.will.resolver.Resolver.selectorIs( prefixPath ) )
  //   return inherit( prefixPath, 1 );
  //   return prefixPath;
  // });

  if( reflector.src.prefixPath === '' )
  reflector.src.prefixPath = null;

  if( reflector.dst.prefixPath === '' )
  reflector.dst.prefixPath = null;

  function inherit( prefixPath, isDst )
  {

    // if( reflector.name === 'reflect.submodules.debug' )
    // debugger;

    let resolvedPrefixPath = module.pathResolve
    ({
      selector : prefixPath,
      visited : o.visited,
      currentContext : reflector,
      pathResolving : 'in', /* yyy */
    });

    if( !( resolvedPrefixPath instanceof Self ) )
    return prefixPath;

    resolvedPrefixPath = resolvedPrefixPath.cloneDerivative();
    resolvedPrefixPath.form();

    if( isEmpty )
    {
      reflector.src.filePath = null;
      isEmpty = false;
    }

    reflector._inheritPathMapAct3
    ({
      dst : isDst ? resolvedPrefixPath : null,
      src : !isDst ? resolvedPrefixPath : null,
    });

  }

  if( reflector.name === 'reflect.files2' )
  debugger;

}

_inheritPrefixes.defaults =
{
  visited : null,
}

// --
// etc
// --

function sureRelativeOrGlobal( o )
{
  let reflector = this;

  o = _.routineOptions( sureRelativeOrGlobal, arguments );
  _.assert( reflector.src instanceof _.FileRecordFilter );
  _.assert( reflector.dst instanceof _.FileRecordFilter );
  _.assert( reflector.src.filePath === reflector.filePath );

  try
  {
    reflector.src.sureRelativeOrGlobal( o );
  }
  catch( err )
  {
    throw _.err( err, '\nSource filter is ill-formed' );
  }

  try
  {
    reflector.dst.sureRelativeOrGlobal( o );
  }
  catch( err )
  {
    throw _.err( err, '\nDestination filter is ill-formed' );
  }

  return true;
}

sureRelativeOrGlobal.defaults =
{
  fixes : 0,
  basePath : 1,
  filePath : 1,
}

//

function isRelativeOrGlobal( o )
{
  let reflector = this;

  o = _.routineOptions( isRelativeOrGlobal, arguments );

  _.assert( reflector.src instanceof _.FileRecordFilter );
  _.assert( reflector.dst instanceof _.FileRecordFilter );
  _.assert( reflector.src.filePath === reflector.filePath );

  if( !reflector.src.isRelativeOrGlobal( o ) )
  return false;

  if( !reflector.dst.isRelativeOrGlobal( o ) )
  return false;

  return true;
}

isRelativeOrGlobal.defaults =
{
  fixes : 0,
  basePath : 1,
  filePath : 1,
}

//

function prefixesRelative( prefixPath )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( reflector.src.postfixPath === null, 'not implemented' );
  _.assert( reflector.dst.postfixPath === null, 'not implemented' );
  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.src === reflector.dst.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  let srcPrefixPath = prefixPath || reflector.src.prefixPath || reflector.src.prefixPathFromFilePath({ usingBools : 0 });
  if( srcPrefixPath )
  reflector.src.prefixesRelative( srcPrefixPath );

  let dstPrefixPath = prefixPath || reflector.dst.prefixPath || reflector.dst.prefixPathFromFilePath({ usingBools : 0 });
  if( dstPrefixPath )
  reflector.dst.prefixesRelative( dstPrefixPath );

}

//

function prefixesApply( force )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let prefixPath;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( reflector.src.postfixPath === null, 'not implemented' );
  _.assert( reflector.dst.postfixPath === null, 'not implemented' );

  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.src === reflector.dst.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  if( force || !reflector.src.filePathDstHasAllBools() )
  reflector.src.prefixesApply();
  if( force || !reflector.dst.filePathDstHasAllBools() )
  reflector.dst.prefixesApply();

}

//

function prefixesResolve()
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( reflector.src.prefixPath && _.will.resolver.Resolver.selectorIs( reflector.src.prefixPath ) )
  reflector.src.prefixPath = resolve( reflector.src.prefixPath );

  if( reflector.dst.prefixPath && _.will.resolver.Resolver.selectorIs( reflector.dst.prefixPath ) )
  reflector.dst.prefixPath = resolve( reflector.dst.prefixPath );

  function resolve( filePath )
  {

    let r = module.pathResolve
    ({
      selector : filePath,
      currentContext : reflector,
      // pathResolving : 'in', /* yyy */
      // pathResolving : false,
      // pathResolving : pathResolving || false,
      pathResolving : 'in'
    });

    _.assert( r === null || _.strIs( r ) || _.arrayIs( r ) || _.mapIs( r ) );

    return r;
  }

}

//

function pathRelative( filePath )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  // let srcRelativePath = reflector.src.prefixPath || module.inPath;
  // let dstRelativePath = reflector.dst.prefixPath || module.inPath;

  _.assert( !_.will.resolver.Resolver.selectorIs( filePath ) )
  _.assert( filePath === null || _.strIs( filePath ) || _.arrayIs( filePath ) || _.mapIs( filePath ) );
  _.assert( filePath === null || _.strIs( filePath ) || _.arrayIs( filePath ) || _.mapIs( filePath ) );

  filePath = path.filterPairsInplace( filePath, ( it ) =>
  {
    if( it.src && !_.boolLike( it.src ) && path.isAbsolute( it.src ) && !path.isGlobal( it.src ) )
    it.src = path.relative( module.inPath, it.src );
    if( it.dst && !_.boolLike( it.dst ) && path.isAbsolute( it.dst ) && !path.isGlobal( it.dst ) )
    it.dst = path.relative( module.inPath, it.dst );
    return { [ it.src ] : it.dst };
  });

  return filePath;
}

//

function pathAbsolute( filePath, isSrc )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let srcRelativePath = reflector.src.prefixPath || module.inPath;
  let dstRelativePath = reflector.dst.prefixPath || module.inPath;

  _.assert( !_.will.resolver.Resolver.selectorIs( srcRelativePath ) );
  _.assert( !_.will.resolver.Resolver.selectorIs( dstRelativePath ) );
  _.assert( !_.will.resolver.Resolver.selectorIs( filePath ) );
  _.assert( filePath === null || _.strIs( filePath ) || _.arrayIs( filePath ) || _.mapIs( filePath ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  filePath = path._filterPairsInplace
  ({
    filePath,
    onEach,
    isSrc,
  });

  return filePath;

  function onEach( it )
  {
    let result = Object.create( null );
    if( it.src && !_.boolLike( it.src ) && !path.isAbsolute( it.src ) && !path.isGlobal( it.src ) )
    it.src = path.s.join( srcRelativePath, it.src );
    if( it.dst && !_.boolLike( it.dst ) && !path.isAbsolute( it.dst ) && !path.isGlobal( it.dst ) )
    it.dst = path.s.join( dstRelativePath, it.dst );
    return it;
  }
}

//

function pathsResolve( o )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( reflector.src.isPaired( reflector.dst ) );

  o = _.routineOptions( pathsResolve, arguments );

  let paired = false;
  if( reflector.src.dst === reflector.dst && reflector.src.filePath === reflector.dst.filePath )
  paired = true;
  _.assert( paired );

  // if( reflector.name === "reflect.submodules.debug" )
  // debugger;

  // if( _.mapIs( reflector.src.filePath ) )
  // reflector.src.filePathNullizeMaybe();

  /* yyy */
  if( !reflector.src.prefixPath )
  if( reflector.src.filePath )
  if( path.s.anyAreAbsolute( reflector.src.filePath ) )
  reflector.src.prefixPath = reflector.src.prefixPathFromFilePath({ usingBools : 0 });
  /* yyy */

  // if( reflector.name === "reflect.submodules.debug" )
  // debugger;

  /* prefix path */

  if( reflector.src.prefixPath || reflector.src.hasAnyPath() )
  filterPrefixResolve( reflector.src );
  // reflector.src.prefixPath = singleSideResolve( reflector.src.prefixPath || '.', 1 );
  if( reflector.dst.prefixPath )
  filterPrefixResolve( reflector.dst );
  // reflector.dst.prefixPath = singleSideResolve( reflector.dst.prefixPath || '.', 0 );

  /* */

  if( reflector.src.basePath )
  reflector.src.basePath = basePathResolve( reflector.src.basePath, 1 );
  if( reflector.src.filePath )
  {

    // let r = mapResolve( reflector.src.filePath, 1 );
    // let r = mapResolve( reflector.src.filePath, 0 );
    let r = mapResolve( reflector.src.filePath );

    reflector.src.filePath = null;

    if( r instanceof _.FileRecordFilter )
    {
      reflector.src.pathsSupplementJoining( r );
    }
    else if( r instanceof _.will.Reflector )
    {
    }
    else
    {
      _.assert( _.path.isElement( r ) );
      reflector.src.filePath = r;
    }
  }

  // if( reflector.src.prefixPath || reflector.src.hasAnyPath() )
  // reflector.src.prefixPath = resolve( reflector.src.prefixPath || '.', 1 );
  // // reflector.src.prefixPath = resolve( reflector.src.prefixPath || '.', 'in' );
  // // if( reflector.src.prefixPath || reflector.src.hasAnyPath() )
  // // reflector.src.prefixPath = path.s.join( reflector.module.inPath, reflector.src.prefixPath || '.' );

  // if( !paired )
  // if( reflector.dst.filePath )
  // {
  //   _.assert( paired );
  //   let r = resolve( reflector.dst.filePath, 1, 'dst' );
  //   reflector.dst.filePath = null;
  //   if( r instanceof _.FileRecordFilter )
  //   {
  //     debugger;
  //     reflector.dst.pathsSupplementJoining( r );
  //   }
  //   else
  //   {
  //     reflector.dst.filePath = r;
  //   }
  // }

  if( reflector.dst.basePath )
  reflector.dst.basePath = basePathResolve( reflector.dst.basePath, 0 );
  let dstHasDst = path.mapDstFromDst( reflector.dst.filePath ).filter( ( e ) => _.strIs( e ) && e ).length > 0;
  // if( reflector.dst.prefixPath || dstHasDst )
  // reflector.dst.prefixPath = resolve( reflector.dst.prefixPath || '.', 1 );
  // // reflector.dst.prefixPath = resolve( reflector.dst.prefixPath || '.', 'in' );
  // // if( reflector.dst.prefixPath || dstHasDst )
  // // reflector.dst.prefixPath = path.s.join( reflector.module.inPath, reflector.dst.prefixPath || '.' );
  if( !reflector.dst.prefixPath && dstHasDst )
  {
    // _.assert( 0, 'not tested' );
    // reflector.dst.prefixPath = singleSideResolve( reflector.dst.prefixPath || '.', 0 );
    filterPrefixResolve( reflector.dst );
  }

  if( paired )
  reflector.dst.filePath = reflector.src.filePath;

  if( reflector.src.prefixPath === '' )
  reflector.src.prefixPath = null;
  if( reflector.dst.prefixPath === '' )
  reflector.dst.prefixPath = null;

  _.assert( reflector.src.prefixPath === null || path.s.allAreAbsolute( reflector.src.prefixPath ) );
  _.assert( reflector.dst.prefixPath === null || path.s.allAreAbsolute( reflector.dst.prefixPath ) );

  // if( reflector.name === "reflect.submodules.debug" )
  // debugger;

  /* */

  function filterPrefixResolve( filter )
  {
    // filterPrefixResolve( reflector.dst );
    let prefixPath = filter.prefixPath;
    filter.prefixPath = null;
    if( filter.dst )
    filter.prefixPath = singleSideResolve( prefixPath || '.', 1 );
    else
    filter.prefixPath = singleSideResolve( prefixPath || '.', 0 );
  }

  /* */

  function basePathResolve( src, isSrc )
  {
    let relativePath, relativePathNormalized;

    if( isSrc )
    {
      relativePath = reflector.src.prefixPath ? reflector.src.prefixPath : module.inPath;
      relativePathNormalized = reflector.src.prefixPath ? path.fromGlob( reflector.src.prefixPath ) : module.inPath;
    }
    else
    {
      relativePath = reflector.dst.prefixPath ? reflector.dst.prefixPath : module.inPath;
      relativePathNormalized = reflector.dst.prefixPath ? path.fromGlob( reflector.dst.prefixPath ) : module.inPath;
    }

    return path.filterPairsInplace( src, ( it ) =>
    {

      _.assert( it.src === null || _.strIs( it.src ) );
      _.assert( it.dst === null || _.strIs( it.dst ) );

      it.src = pathResolve( it.src );
      it.dst = pathResolve( it.dst );

      _.assert( it.src === null || _.strIs( it.src ) || _.arrayIs( it.src ) );
      _.assert( it.dst === null || _.strIs( it.dst ) || _.arrayIs( it.dst ) );

      return end( it );
    });

    function end( it )
    {
      if( it.src && !_.boolLike( it.src ) && !path.isAbsolute( it.src ) && !path.isGlobal( it.src ) )
      it.src = path.s.join( relativePathNormalized, it.src );

      if( it.dst && !_.boolLike( it.dst ) && !path.isAbsolute( it.dst ) && !path.isGlobal( it.dst ) )
      it.dst = path.s.join( relativePath, it.dst );

      return it;
    }
  }

  /* */

  function singleSideResolve( src, isSrc )
  {

    return path.filterPairsInplace( src, ( it ) =>
    {

      _.assert( it.src === null || _.strIs( it.src ) );
      _.assert( it.dst === null || _.strIs( it.dst ) );

      it.src = pathResolve( it.src );
      it.dst = pathResolve( it.dst );

      _.assert( it.src === null || _.strIs( it.src ) || _.arrayIs( it.src ) );
      _.assert( it.dst === null || _.strIs( it.dst ) || _.arrayIs( it.dst ) );

      return end( it );
    });

    function end( it )
    {
      it.src = reflector.pathAbsolute( it.src, isSrc );
      it.dst = reflector.pathAbsolute( it.dst, isSrc );
      return it;
    }
  }

  /* */

  function mapResolve( src )
  {

    return path.filterPairsInplace( src, ( it ) =>
    {

      _.assert( it.src === null || _.strIs( it.src ) );
      _.assert( it.dst === null || _.strIs( it.dst ) || _.boolLike( it.dst ) );

      it.src = pathResolve( it.src );
      it.dst = pathResolve( it.dst );

      _.assert( it.src === null || _.strIs( it.src ) || _.arrayIs( it.src ) );
      _.assert( it.dst === null || _.strIs( it.dst ) || _.arrayIs( it.dst ) || _.boolLike( it.dst ) );

      return end( it );
    });

    function end( it )
    {
      return reflector.pathAbsolute({ [ it.src ] : it.dst });
    }
  }

  /* */

  function pathResolve( filePath )
  {
    if( _.will.resolver.Resolver.selectorIs( filePath ) )
    filePath = module.pathResolve
    ({
      selector : filePath,
      currentContext : reflector,
      pathResolving : 'in'
    });
    return filePath;
  }

  // // function resolve( src, pathResolving, side )
  // function resolve( src, absolute, side )
  // {
  //
  //   return path.filterInplace( src, ( filePath, it ) =>
  //   {
  //     if( _.instanceIs( filePath ) )
  //     return filePath;
  //     if( _.boolIs( filePath ) )
  //     return filePath;
  //
  //     // if( !_.will.resolver.Resolver.selectorIs( filePath ) && !pathResolving )
  //     // return filePath;
  //
  //     // if( reflector.name === 'reflect.submodules.debug' )
  //     // debugger;
  //
  //     // if( reflector.name === "reflect.submodules" )
  //     // {
  //     //   debugger;
  //     //   // _global_.debugger = 1;
  //     // }
  //
  //     let r = filePath;
  //     if( _.will.resolver.Resolver.selectorIs( filePath ) )
  //     r = module.pathResolve
  //     ({
  //       selector : r,
  //       currentContext : reflector,
  //       // pathResolving : 'in', /* yyy */
  //       // pathResolving : false,
  //       // pathResolving : pathResolving || false,
  //       pathResolving : 'in'
  //     });
  //
  //     _.assert( r === null || _.strIs( r ) || _.arrayIs( r ) || _.mapIs( r ) );
  //
  //     // if( r && r instanceof _.will.PathResource )
  //     // {
  //     //   _.assert( 0, 'not expected' );
  //     // }
  //     //
  //     // if( r instanceof _.will.Reflector )
  //     // {
  //     //   r = r.cloneDerivative();
  //     //   r.form();
  //     //   _.assert( !!r.original );
  //     //
  //     //   if( side )
  //     //   {
  //     //     _.assert( 0 );
  //     //     if( side === 'src' )
  //     //     return end( r.src );
  //     //     else
  //     //     return end( r.dst );
  //     //   }
  //     //
  //     //   _.assert( 0 );
  //     //   return filePath;
  //     // }
  //
  //     return end( r );
  //   });
  //
  //   function end( r )
  //   {
  //     // r = reflector.pathRelative( r, module.inPath );
  //     // if( absolute )
  //     r = reflector.pathAbsolute( r );
  //     return r;
  //   }
  // }

}

pathsResolve.defaults =
{
}

//

function selectorsNormalize( o )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routineOptions( selectorsNormalize, arguments );

  let paired = false;
  if( reflector.src.dst === reflector.dst && reflector.src.filePath === reflector.dst.filePath )
  paired = true;

  if( reflector.src.basePath )
  reflector.src.basePath = resolve( reflector.src.basePath );
  if( reflector.src.filePath )
  reflector.src.filePath = resolve( reflector.src.filePath );
  if( reflector.src.prefixPath )
  reflector.src.prefixPath = resolve( reflector.src.prefixPath );
  if( reflector.src.postfixPath )
  reflector.src.postfixPath = resolve( reflector.src.postfixPath );

  if( reflector.dst.basePath )
  reflector.dst.basePath = resolve( reflector.dst.basePath );
  if( reflector.dst.filePath )
  reflector.dst.filePath = resolve( reflector.dst.filePath );
  if( reflector.dst.prefixPath )
  reflector.dst.prefixPath = resolve( reflector.dst.prefixPath );
  if( reflector.dst.postfixPath )
  reflector.dst.postfixPath = resolve( reflector.dst.postfixPath );

  /* */

  function resolve( src )
  {

    return path.filterInplace( src, ( filePath ) =>
    {
      if( _.instanceIs( filePath ) )
      return filePath;
      if( _.boolIs( filePath ) )
      return filePath;
      if( !_.will.resolver.Resolver.selectorIs( filePath ) )
      return filePath;
      return _.will.resolver.Resolver.selectorNormalize( filePath );
    });

  }

}

selectorsNormalize.defaults =
{
}

//

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
  {
    debugger;
    return resource;
  }

  /* */

  if( resource.criterion.predefined )
  return resource;

  if( resource.src.hasAnyPath() )
  resource.src.prefixPath = path.filterInplace( resource.src.prefixPath || null, ( filePath ) =>
  {
    if( filePath === null )
    return o.relative;
    return resource.pathRebase
    ({
      filePath,
      exInPath : o.exInPath,
      inPath : o.inPath,
    });
  });

  if( resource.dst.hasAnyPath() )
  resource.dst.prefixPath = path.filterInplace( resource.dst.prefixPath || null, ( filePath ) =>
  {
    if( filePath === null )
    return o.relative;
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

function optionsForFindExport( o )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  reflector.form();

  o = _.routineOptions( optionsForFindExport, arguments );
  _.assert( reflector.dst === null || !reflector.dst.hasFiltering() );
  _.assert( !o.resolving );

  if( reflector.src )
  result.filter = reflector.src.clone();
  result.filter = result.filter || Object.create( null );
  result.filter.recursive = reflector.src.recursive === null ? 2 : reflector.src.recursive;
  result.filter.prefixPath = path.s.resolve( module.inPath, result.filter.prefixPath || '.' );
  result.mandatory = reflector.mandatory;

  return result;
}

optionsForFindExport.defaults =
{
  resolving : 0,
}

//

function optionsForFindGroupExport( o )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  reflector.form();

  o = _.routineOptions( optionsForFindGroupExport, arguments );
  _.assert( !o.resolving );

  result.mandatory = reflector.mandatory;

  if( reflector.src )
  result.src = reflector.src.clone();
  result.src = result.src || Object.create( null );
  result.src.prefixPath = path.s.resolve( module.inPath, result.src.prefixPath || '.' );
  result.src.recursive = reflector.src.recursive === null ? 2 : reflector.src.recursive;

  if( reflector.dst )
  result.dst = reflector.dst.clone();
  result.dst = result.dst || Object.create( null );
  result.dst.prefixPath = path.s.resolve( module.inPath, result.dst.prefixPath || '.' );

  return result;
}

optionsForFindGroupExport.defaults =
{
  resolving : 0,
}

//

function optionsForReflectExport( o )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  reflector.form();

  o = _.routineOptions( optionsForReflectExport, arguments );
  _.assert( !o.resolving );

  result.mandatory = reflector.mandatory;
  result.dstRewritingOnlyPreserving = reflector.dstRewritingOnlyPreserving;
  result.linking = reflector.linking;
  result.breakingDstHardLink = reflector.breakingDstHardLink;

  /* */

  if( reflector.src )
  result.src = reflector.src.clone();
  result.src = result.src || Object.create( null );
  result.src.prefixPath = path.s.resolve( module.inPath, result.src.prefixPath || '.' );
  result.src.recursive = reflector.src.recursive === null ? 2 : reflector.src.recursive;

  if( reflector.dst )
  result.dst = reflector.dst.clone();
  result.dst = result.dst || Object.create( null );
  result.dst.prefixPath = path.s.resolve( module.inPath, result.dst.prefixPath || '.' );

  /* */

  return result;
}

optionsForReflectExport.defaults =
{
  resolving : 0,
}

//

function exportStructure()
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let o = _.routineOptions( exportStructure, arguments );

  _.assert( reflector.src instanceof _.FileRecordFilter );

  let result = Parent.prototype.exportStructure.apply( this, arguments );

  if( result === undefined )
  return result;

  /* if request to get unformed resource then result is already normalized */

  if( !o.formed )
  if( reflector.unformedResource )
  return result;

  delete result.filePath;

  if( result.dst )
  if
  (
    _.mapIs( reflector.src.filePath )
    || ( _.strIs( reflector.src.filePath ) && _.will.resolver.Resolver.selectorIs( reflector.src.filePath ) )
  )
  // if( _.entityIdentical( reflector.src.filePath, reflector.dst.filePath ) )
  if( _.path.map.identical( reflector.src.filePath, reflector.dst.filePath ) )
  delete result.dst.filePath;

  if( _.mapIs( result.dst ) && _.entityLengthOf( result.dst ) === 0 )
  delete result.dst;

  if( result.src && result.src.prefixPath )
  result.src.prefixPath = path.filterInplace( result.src.prefixPath, ( prefixPath ) =>
  {
    if( path.isAbsolute( prefixPath ) )
    if( path.hasLocally( prefixPath ) )
    return path.relative( module.inPath, prefixPath );
    return prefixPath;
  });

  if( result.dst && result.dst.prefixPath )
  result.dst.prefixPath = path.filterInplace( result.dst.prefixPath, ( prefixPath ) =>
  {
    if( path.isAbsolute( prefixPath ) )
    if( path.hasLocally( prefixPath ) )
    return path.relative( module.inPath, prefixPath );
    return prefixPath;
  });

  /* */

  if( o.strict )
  if( Config.debug )
  {
    if( result.src && result.src.filePath )
    path.filter( result.src.filePath, check );
    if( result.src && result.src.basePath )
    path.filter( result.src.basePath, check );
    if( result.src && result.src.postfixPath )
    path.filter( result.src.postfixPath, check );
    if( result.dst && result.dst.basePath )
    path.filter( result.dst.basePath, check );
  }

  return result;

  function check( filePath )
  {
    if( !filePath )
    return;
    if( _.boolLike( filePath ) )
    return;
    _.assert( path.isRelative( filePath ) || path.isGlobal( filePath ), () => filePath, 'is not relative, neither global' );
  }

}

exportStructure.defaults = Object.create( _.will.Resource.prototype.exportStructure.defaults );

//

function filePathGet()
{
  let reflector = this;
  if( !reflector.src )
  return null;
  return reflector.src.filePath;
}

//

function filePathSet( src )
{
  let reflector = this;
  if( !reflector.src && src === null )
  return src;
  _.assert( _.objectIs( reflector.src ), 'Reflector should have src to set filePath' );
  reflector.src.filePath = reflector.dst.filePath = _.entity.make( src );
  return reflector.src.filePath;
}

//

function recursiveGet()
{
  let reflector = this;
  if( !reflector.src )
  return null;
  return reflector.src.recursive;
}

//

function recursiveSet( src )
{
  let reflector = this;
  if( !reflector.src && src === null )
  return src;
  _.assert( _.objectIs( reflector.src ), 'Reflector should have src to set filePath' );
  reflector.src.recursive = src;
  return reflector.src.recursive;
}

// --
// relations
// --

let Composes =
{

  shell : null,
  filePath : null, /* xxx : remove? */
  src : null,
  dst : null,

  recursive : null,
  mandatory : null,
  dstRewritingOnlyPreserving : null,
  linking : null,
  breakingDstHardLink : null

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
  _accumulator : null,
}

let Statics =
{
  KindName : 'reflector',
  MapName : 'reflectorMap',
  ResouceStructureFrom,
  MakeFor,
  MakeSingle,
}

let Forbids =
{
  filter : 'filter',
  parameter : 'parameter',
  reflectMap : 'reflectMap',
  srcFilter : 'srcFilter',
  dstFilter : 'dstFilter',
}

let Accessors =
{
  filePath : { set : filePathSet, get : filePathGet },
  recursive : { set : recursiveSet, get : recursiveGet },
  src : { set : _.accessor.setter.copyable({ name : 'src', maker : _.routineJoin( _.FileRecordFilter, _.FileRecordFilter.Clone ) }) },
  dst : { set : _.accessor.setter.copyable({ name : 'dst', maker : _.routineJoin( _.FileRecordFilter, _.FileRecordFilter.Clone ) }) },
}

_.assert( _.routineIs( _.FileRecordFilter ) );

// --
// declare
// --

let Extension =
{

  // inter

  MakeFor,
  MakeSingle,
  ResouceStructureFrom,
  init,
  cloneDerivative,
  form1,
  form2,
  form3,

  _inheritMultiple,
  _inheritSingle,
  _inheritPathMap,
  _inheritPathMapAct1,
  _inheritPathMapAct2,
  _inheritPathMapAct3,
  _inheritPrefixes,

  // path

  sureRelativeOrGlobal,
  isRelativeOrGlobal,
  prefixesRelative,
  prefixesApply,
  prefixesResolve,
  pathRelative,
  pathAbsolute,
  pathsResolve,
  pathsRebase,
  selectorsNormalize,

  // exporter

  optionsForFindExport,
  optionsForFindGroupExport,
  optionsForReflectExport,
  exportStructure,

  // accessor

  filePathGet,
  filePathSet,
  recursiveGet,
  recursiveSet,

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
