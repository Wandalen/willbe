( function _Reflector_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Resource;
let Self = function wWillReflector( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Reflector';

// --
// inter
// --

function ResouceDataFrom( o )
{
  let result = Parent.prototype.ResouceDataFrom.apply( this, arguments );
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

  let o3 = Object.create( null );
  o3.resource = Object.create( null );
  o3.resource.criterion = _.mapExtend( null, o.resource.criterion || {} );
  o3.resource.shell = o.resource.shell;
  o3.Importing = 1;
  o3.module = module;
  o3.willf = willf;
  o3.name = o.name;

  if( o.resource.step )
  {
    if( !_.mapIs( o.resource.step ) )
    o.resource.step = { inherit : o.resource.step }
    _.mapExtend( o3.resource, o.resource.step );
  }

  if( o.resource.shell )
  {

    o3.resource.forEachDst = 'reflector::' + o.name + '*';
    if( !o3.resource.inherit )
    o3.resource.inherit = 'shell.run';

    _.Will.Step.MakeFor( o3 );

  }
  else if( !module.stepMap[ o.name ] )
  {

    o3.resource.reflector = 'reflector::' + o.name + '*';
    if( !o3.resource.inherit )
    o3.resource.inherit = 'files.reflect';
    o3.Optional = 1;

    _.Will.Step.MakeFor( o3 );

  }

}

_.routineExtend( MakeFor_body, Parent.MakeFor.body );

let MakeFor = _.routineFromPreAndBody( Parent.MakeFor.pre, MakeFor_body );

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

  _.assert( arguments.length === 0 );
  _.assert( !reflector.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !willf || !!willf.formed );
  _.assert( _.strDefined( reflector.name ) );

  /* begin */

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

  if( !reflector.unformedResource && !reflector.generated )
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

  // if( reflector.nickName === 'reflector::exported.export' )
  // debugger;

  if( reflector.src.hasAnyPath() ) // yyy
  {
    reflector.src.prefixPath = _.filter( reflector.src.prefixPath, ( prefixPath ) =>
    {
      if( will.Resolver.selectorIs( prefixPath ) )
      return prefixPath;
      return path.s.join( module.inPath, prefixPath || '.' )
    });
  }

  let result = Parent.prototype.form2.apply( reflector, arguments );
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

  // if( reflector.nickName === 'reflector::exported.export' )
  // debugger;

  _.assert( arguments.length === 0 );
  _.assert( reflector.formed === 2 );

  /* begin */

  // if( reflector.nickName === 'reflector::exported.export' )
  // debugger;

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
    () => 'Formed reflector should have absolute prefix or none, but source of ' + reflector.absoluteName + ' has ' + _.toStrShort( reflector.src.prefixPath )
  );
  _.assert
  (
    reflector.dst.prefixPath === null || path.s.allAreAbsolute( reflector.dst.prefixPath ),
    () => 'Formed reflector should have absolute prefix or none, but destination of ' + reflector.absoluteName + ' has ' + _.toStrShort( reflector.src.prefixPath )
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

  reflector._accumulator = new will.Reflector({ module : module, original : reflector, name : reflector.name });
  reflector._accumulator.src.pairWithDst( reflector._accumulator.dst );
  reflector._accumulator.src.pairRefineLight();

  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.src === reflector.dst.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  reflector._inheritPrefixes({ visited : o.visited });
  reflector._inheritPathMap({ visited : o.visited });

  Parent.prototype._inheritMultiple.call( reflector, o );

  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.src === reflector.dst.src );
  _.assert( reflector.src.filePath === reflector.dst.filePath );

  reflector.pathsResolve();

  reflector.prefixesApply();
  reflector._accumulator.prefixesApply();

  // if( reflector.nickName === 'reflector::exported.export' )
  // debugger;

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
  _.assert( reflector2 instanceof reflector.constructor, () => 'Expects reflector, but got', _.strType( reflector2 ) );
  _.assert( !!reflector2.formed );
  _.assert( reflector.src instanceof _.FileRecordFilter );
  _.assert( reflector.dst instanceof _.FileRecordFilter );
  _.assert( reflector2.src instanceof _.FileRecordFilter );
  _.assert( reflector2.dst instanceof _.FileRecordFilter );
  _.assert( _.entityIdentical( reflector.src.filePath, reflector.filePath ) );
  _.assert( _.entityIdentical( reflector2.src.filePath, reflector2.filePath ) );
  _.assert( reflector.src.dst === reflector.dst );
  _.assert( reflector.dst.src === reflector.src );
  _.assert( !!reflector._accumulator );

  if( reflector2.formed < 3 )
  {
    _.sure( !_.arrayHas( o.visited, reflector2.name ), () => 'Cyclic dependency ' + reflector.nickName + ' of ' + reflector2.nickName );
    if( reflector2.formed < 2 )
    {
      reflector2.form2({ visited : o.visited });
    }
    reflector2.form3();
  }

  _.assert( reflector2.formed === 3 );

  let only = _.mapNulls( reflector );
  only = _.mapOnly( reflector, reflector.Composes );
  let extend = _.mapOnly( reflector2, only );

  delete extend.src;
  delete extend.dst;
  delete extend.criterion;
  delete extend.filePath;
  delete extend.inherit;

  reflector.copy( extend );
  reflector.criterionInherit( reflector2.criterion );

  reflector2 = reflector2.cloneDerivative();
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

  // if( reflector.nickName === 'reflector::reflect.submodules.variant3' )
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
    pathMap : pathMap,
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

    // if( will.Resolver.selectorIs( src ) )
    if( will.Resolver.selectorIs( src ) || will.Resolver.selectorIs( dst ) )
    {
      reflector._inheritPathMapAct2
      ({
        dst : dst,
        src : src,
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
    _.assert( path.isElement( dst ), () => 'Expects destination path, got ' + _.strType( dst ) );
    _.assert( path.isElement( src ), () => 'Expects source path, got ' + _.strType( src ) );
    let resolvedSrc = src ? path.normalize( src ) : src;
    _.assert( _.mapIs( reflector.filePath ) );
    _.assert
    (
      reflector.filePath[ resolvedSrc ] === undefined || reflector.filePath[ resolvedSrc ] === dst,
      () => 'Source path ' + resolvedSrc + ' already has value\n' +
            _.strQuote( reflector.filePath[ resolvedSrc ] ) + ' <> ' +
            _.strQuote( dst )
    );
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

  let resolvedSrc = module.pathResolve
  ({
    selector : o.src,
    visited : o.visited,
    currentContext : reflector,
  });
  let resolvedDst = module.pathResolve
  ({
    selector : o.dst,
    visited : o.visited,
    currentContext : reflector,
    pathUnwrapping : 1,
  });

  if( !_.errIs( resolvedSrc ) && !_.strIs( resolvedSrc ) && !_.arrayIs( resolvedSrc ) && !( resolvedSrc instanceof will.Reflector ) )
  {
    debugger;
    resolvedSrc = _.err( 'Source of path map was resolved to unexpected type', _.strType( resolvedSrc ) );
  }
  if( _.errIs( resolvedSrc ) )
  {
    debugger;
    throw _.err( 'Failed to form', reflector.nickName, '\n', resolvedSrc );
  }
  if( _.errIs( resolvedDst ) )
  {
    debugger;
    throw _.err( 'Failed to form', reflector.nickName, '\n', resolvedDst );
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

  if( o.src instanceof will.Reflector )
  {
    o.src = o.src.cloneDerivative();
    _.assert( !!o.src.original );
    o.src.prefixesApply( 1 );
    o.src = o.src.src.filePathSrcArrayNonBoolGet();
  }

  _.assert( o.dst === null || _.strIs( o.dst ) || _.arrayIs( o.dst ) || _.mapIs( o.dst ) );
  _.assert( o.src === null || _.strIs( o.src ) || _.arrayIs( o.src ) || _.mapIs( o.src ) );

  let pathMap3 = path.mapsPair( o.dst, o.src );

  for( let src in pathMap3 )
  {
    let dst = pathMap3[ src ];
    _.assert( !will.Resolver.selectorIs( src ) );
    _.assert( !will.Resolver.selectorIs( dst ) );
    set( dst, src );
  }

  function set( dst, src )
  {
    reflector.filePath = reflector.filePath || Object.create( null );
    _.assert( path.isElement( dst ), () => 'Expects destination path, got ' + _.strType( dst ) );
    _.assert( path.isElement( src ), () => 'Expects source path, got ' + _.strType( src ) );
    let resolvedSrc = src ? path.normalize( src ) : src;
    _.assert( _.mapIs( reflector.filePath ) );
    _.assert
    (
      reflector.filePath[ resolvedSrc ] === undefined || reflector.filePath[ resolvedSrc ] === dst,
      () => 'Source path ' + resolvedSrc + ' already has value\n' +
            _.strQuote( reflector.filePath[ resolvedSrc ] ) + ' <> ' +
            _.strQuote( dst )
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

  if( reflector.src.prefixPath )
  reflector.src.prefixPath = path.filterInplace( reflector.src.prefixPath, ( prefixPath ) =>
  {
    if( will.Resolver.selectorIs( prefixPath ) )
    return inherit( prefixPath, 0 );
    return prefixPath;
  });

  if( reflector.dst.prefixPath )
  reflector.dst.prefixPath = path.filterInplace( reflector.dst.prefixPath, ( prefixPath ) =>
  {
    if( will.Resolver.selectorIs( prefixPath ) )
    return inherit( prefixPath, 1 );
    return prefixPath;
  });

  if( reflector.src.prefixPath === '' )
  reflector.src.prefixPath = null;

  if( reflector.dst.prefixPath === '' )
  reflector.dst.prefixPath = null;

  function inherit( prefixPath, isDst )
  {

    let resolvedPrefixPath = module.pathResolve
    ({
      selector : prefixPath,
      visited : o.visited,
      currentContext : reflector,
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
    throw _.err( 'Source filter is ill-formed\n', err );
  }

  try
  {
    reflector.dst.sureRelativeOrGlobal( o );
  }
  catch( err )
  {
    throw _.err( 'Destination filter is ill-formed\n', err );
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

  if( _.mapIs( reflector.src.filePath ) )
  reflector.src.filePathNullizeMaybe();

  // if( reflector.nickName === "reflector::reflect.files2" )
  // debugger;

  /* yyy */
  if( !reflector.src.prefixPath )
  if( reflector.src.filePath )
  if( path.s.anyAreAbsolute( reflector.src.filePath ) )
  reflector.src.prefixPath = reflector.src.prefixPathFromFilePath({ usingBools : 0 });
  /* yyy */

  if( reflector.src.basePath )
  reflector.src.basePath = resolve( reflector.src.basePath );
  if( reflector.src.filePath )
  {

    // let r = resolve( reflector.src.filePath, 1, 'src' ); // yyy
    let r = resolve( reflector.src.filePath, 1 );

    reflector.src.filePath = null;

    if( r instanceof _.FileRecordFilter )
    {
      reflector.src.pathsSupplementJoining( r );
    }
    else if( r instanceof will.Reflector )
    {
    }
    else
    {
      _.assert( _.path.isElement( r ) );
      reflector.src.filePath = r;
    }
  }

  // if( reflector.src.prefixPath || reflector.src.hasAnyPath() ) // yyy
  // {
  //   reflector.src.prefixPath = _.filter( reflector.src.prefixPath, ( prefixPath ) =>
  //   {
  //     if( will.Resolver.selectorIs( prefixPath ) )
  //     return prefixPath;
  //     let r = reflector.src.prefixPath = resolve( prefixPath || '.', 'in' );
  //     r = path.s.join( reflector.module.inPath, r || '.' );
  //     return r;
  //   });
  // }

  if( reflector.src.prefixPath || reflector.src.hasAnyPath() )
  reflector.src.prefixPath = resolve( reflector.src.prefixPath || '.', 'in' );
  if( reflector.src.prefixPath || reflector.src.hasAnyPath() )
  reflector.src.prefixPath = path.s.join( reflector.module.inPath, reflector.src.prefixPath || '.' );

  if( !paired )
  if( reflector.dst.filePath )
  {
    let r = resolve( reflector.dst.filePath, 1, 'dst' );
    reflector.dst.filePath = null;
    if( r instanceof _.FileRecordFilter )
    {
      debugger;
      reflector.dst.pathsSupplementJoining( r );
    }
    else
    {
      reflector.dst.filePath = r;
    }
  }

  if( reflector.dst.basePath )
  reflector.dst.basePath = resolve( reflector.dst.basePath );
  let dstHasDst = path.mapDstFromDst( reflector.dst.filePath ).filter( ( e ) => _.strIs( e ) && e ).length > 0;
  if( reflector.dst.prefixPath || dstHasDst )
  reflector.dst.prefixPath = resolve( reflector.dst.prefixPath || '.', 'in' );
  if( reflector.dst.prefixPath || dstHasDst )
  reflector.dst.prefixPath = path.s.join( reflector.module.inPath, reflector.dst.prefixPath || '.' );

  if( paired )
  reflector.dst.filePath = reflector.src.filePath;

  _.assert( reflector.src.prefixPath === null || path.s.allAreAbsolute( reflector.src.prefixPath ) );
  _.assert( reflector.dst.prefixPath === null || path.s.allAreAbsolute( reflector.dst.prefixPath ) );

  /* */

  function resolve( src, pathResolving, side )
  {

    return path.filterInplace( src, ( filePath, it ) =>
    {
      if( _.instanceIs( filePath ) )
      return filePath;
      if( _.boolIs( filePath ) )
      return filePath;
      if( !will.Resolver.selectorIs( filePath ) && !pathResolving )
      return filePath;

      let r = module.pathResolve
      ({
        selector : filePath,
        currentContext : reflector,
        pathResolving : 'in',
      });

      if( r instanceof will.Reflector )
      {
        r = r.cloneDerivative();
        r.form();
        _.assert( !!r.original );

        if( side )
        {
          if( side === 'src' )
          return r.src;
          else
          return r.dst;
        }

        return filePath;
      }

      return r;
    });

  }

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
      if( !will.Resolver.selectorIs( filePath ) )
      return filePath;
      return will.Resolver.selectorNormalize( filePath );
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

  if( resource.criterion.predefined )
  return resource;

  if( resource.src.hasAnyPath() )
  resource.src.prefixPath = path.filterInplace( resource.src.prefixPath || null, ( filePath ) =>
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
  resource.dst.prefixPath = path.filterInplace( resource.dst.prefixPath || null, ( filePath ) =>
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

function dataExport()
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let o = _.routineOptions( dataExport, arguments );

  _.assert( reflector.src instanceof _.FileRecordFilter );

  let result = Parent.prototype.dataExport.apply( this, arguments );

  if( result === undefined )
  return result;

  /* if request to get unformed resource then result is already normalized */

  if( !o.formed )
  if( reflector.unformedResource )
  return result;

  delete result.filePath;

  if( result.dst )
  if( _.mapIs( reflector.src.filePath ) || ( _.strIs( reflector.src.filePath ) && will.Resolver.selectorIs( reflector.src.filePath ) ) )
  if( _.entityIdentical( reflector.src.filePath, reflector.dst.filePath ) )
  delete result.dst.filePath;

  if( _.mapIs( result.dst ) && _.entityLength( result.dst ) === 0 )
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

dataExport.defaults = Object.create( _.Will.Resource.prototype.dataExport.defaults );

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
  reflector.src.filePath = reflector.dst.filePath = _.entityShallowClone( src );
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
  filePath : null,
  src : null,
  dst : null,

  recursive : null,
  mandatory : 1,

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
  ResouceDataFrom,
  MakeFor,
}

let Forbids =
{
  filter : 'filter',
  parameter : 'parameter',
  reflectMap : 'reflectMap',
  srcFilter : 'srcFilter',
  dstFilter : 'dstFilter',
  // recursive : 'recursive',
}

let Accessors =
{
  filePath : { setter : filePathSet, getter : filePathGet },
  recursive : { setter : recursiveSet, getter : recursiveGet },
  src : { setter : _.accessor.setter.copyable({ name : 'src', maker : _.routineJoin( _.FileRecordFilter, _.FileRecordFilter.Clone ) }) },
  dst : { setter : _.accessor.setter.copyable({ name : 'dst', maker : _.routineJoin( _.FileRecordFilter, _.FileRecordFilter.Clone ) }) },
}

_.assert( _.routineIs( _.FileRecordFilter ) );

// --
// declare
// --

let Extend =
{

  // inter

  ResouceDataFrom,
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
  pathsResolve,
  pathsRebase,
  selectorsNormalize,

  // exporter

  optionsForFindExport,
  optionsForFindGroupExport,
  optionsForReflectExport,
  dataExport,

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
