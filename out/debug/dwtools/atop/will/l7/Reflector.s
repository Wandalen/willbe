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
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Reflector';

// --
// inter
// --

function init( o )
{
  let reflector = this;

  _.assert( o && o.module );

  // if( o.src && o.src.basePath )
  // debugger;

  let module = o.module;
  let will = module.will;
  let fileProvider = will.fileProvider;

  reflector.src = fileProvider.recordFilter();
  reflector.dst = fileProvider.recordFilter();

  let result = Parent.prototype.init.apply( reflector, arguments );

  return result;
}

//

function cloneDerivative()
{
  let reflector = this;
  let reflector2 = Parent.prototype.cloneDerivative.apply( reflector, arguments );

  if( reflector.src.dstFilter === reflector.dst )
  reflector2.src.pairWithDst( reflector2.dst );

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

  module[ reflector.MapName ][ reflector.name ] = reflector;
  if( willf )
  willf[ reflector.MapName ][ reflector.name ] = reflector;

  reflector.src = reflector.src || {};
  if( reflector.src )
  {
    reflector.src.hubFileProvider = fileProvider;
    if( !reflector.src.formed )
    reflector.src._formAssociations();
  }

  reflector.dst = reflector.dst || {};
  if( reflector.dst )
  {
    reflector.dst.hubFileProvider = fileProvider;
    if( !reflector.dst.formed )
    reflector.dst._formAssociations();
  }

  /* end */

  reflector.formed = 1;
  return reflector;
}

//

function form2()
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  reflector.src.pairWithDst( reflector.dst );

  if( reflector.src.filePath !== reflector.dst.filePath )
  if( !reflector.dst.filePath || _.mapIs( reflector.dst.filePath ) )
  reflector.src.pairRefineLight();

  let result = Parent.prototype.form2.apply( reflector, arguments );
  return result;
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

  _.assert( arguments.length === 0 );
  _.assert( reflector.formed === 2 );

  /* begin */

  // if( reflector.nickName === "reflector::exportedFiles.export." )
  // debugger;

  reflector.pathsResolve();
  if( reflector.src.hasAnyPath() )
  reflector.src.prefixPath = path.join( module.inPath, reflector.src.prefixPath || '.' );
  reflector.src.pairWithDst( reflector.dst );
  reflector.src.pairRefine();

  reflector.prefixesApply();
  reflector.prefixesRelative();

  reflector.src.basePathSimplify();
  reflector.dst.basePathSimplify();
  reflector.sureRelativeOrGlobal();

  _.assert( reflector.src.prefixPath === null || path.isAbsolute( reflector.src.prefixPath ) );
  _.assert( reflector.dst.prefixPath === null || path.isAbsolute( reflector.dst.prefixPath ) );

  // if( reflector.nickName === "reflector::exportedFiles.export." )
  // debugger;

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
  _.routineOptions( _inheritMultiple, arguments );

  Parent.prototype._inheritMultiple.call( reflector, o );

  if( reflector.filePath )
  reflector._reflectMapForm({ visited : o.visited });

  return reflector;
}

_inheritMultiple.defaults=
{
  ancestors : null,
  visited : null,
  defaultDst : true,
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

  if( reflector2.formed < 2 )
  {
    _.sure( !_.arrayHas( o.visited, reflector2.name ), () => 'Cyclic dependency ' + reflector.nickName + ' of ' + reflector2.nickName );
    reflector2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( reflector2, _.mapNulls( reflector ) );

  delete extend.src;
  delete extend.dst;
  delete extend.criterion;
  delete extend.filePath;
  delete extend.original;

  reflector.copy( extend );
  reflector.criterionInherit( reflector2.criterion );

  if( reflector.nickName === "reflector::reflect.submodules" )
  debugger;

  reflector.src.and( reflector2.src ).pathsInherit( reflector2.src );

  if( reflector.src.filePath !== reflector.dst.filePath )
  if( !reflector.dst.filePath || _.mapIs( reflector.dst.filePath ) )
  reflector.src.pairRefineLight();

  reflector.dst.and( reflector2.dst ).pathsInherit( reflector2.dst );

  if( reflector.src.filePath !== reflector.dst.filePath )
  if( !reflector.dst.filePath || _.mapIs( reflector.dst.filePath ) )
  reflector.src.pairRefineLight();

  if( reflector.nickName === "reflector::reflect.submodules" )
  debugger;

}

_inheritSingle.defaults=
{
  ancestor : null,
  visited : null,
  defaultDst : true,
}

//

function _reflectMapForm( o )
{
  let reflector = this;
  let module = reflector.module;
  let willf = reflector.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( _reflectMapForm, arguments );

  // if( reflector.nickName === "reflector::exportedFiles.export." )
  // debugger;

  let pathMap = reflector.filePath;
  for( let src in pathMap )
  {
    let dst = pathMap[ src ];

    // if( !_.boolLike( dst ) && dst !== null )
    // // if( module.selectorIs( dst ) )
    // {
    //   if( !module.selectorIs( dst ) )
    //   debugger;
    //   dst = module.pathResolve
    //   ({
    //     selector : dst,
    //     visited : o.visited,
    //     current : reflector,
    //     // prefixlessAction : 'resolved',
    //   });
    // }

    if( module.selectorIs( src ) )
    {

      let resolvedSrc = module.pathResolve
      ({
        selector : src,
        visited : o.visited,
        current : reflector,
        // mapValsUnwrapping : 1,
        // singleUnwrapping : 1,
        // flattening : 1,
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

      if( _.arrayIs( resolvedSrc ) )
      {
        resolvedSrc = path.s.normalize( resolvedSrc );

        delete pathMap[ src ];
        for( let p = 0 ; p < resolvedSrc.length ; p++ )
        {
          let rpath = resolvedSrc[ p ];
          _.assert( _.strIs( rpath ) );

          if( path.isAbsolute( rpath ) && !path.isGlobal( rpath ) )
          debugger;
          // if( path.isAbsolute( rpath ) && !path.isGlobal( rpath ) )
          // rpath = path.s.relative( module.inPath, rpath );

          pathMap[ rpath ] = dst;
        }
      }
      else if( _.strIs( resolvedSrc ) )
      {
        resolvedSrc = path.normalize( resolvedSrc );

        // if( path.isAbsolute( resolvedSrc ) && !path.isGlobal( resolvedSrc ) )
        // resolvedSrc = path.s.relative( module.inPath, resolvedSrc );

        delete pathMap[ src ];
        pathMap[ resolvedSrc ] = dst;
      }
      else if( resolvedSrc instanceof will.Reflector )
      {
        delete pathMap[ src ];
        debugger;
        reflector._inheritSingle({ visited : o.visited, ancestor : resolvedSrc, defaultDst : dst });
        _.sure( !!resolvedSrc.filePath );
        path.pathMapExtend( pathMap, resolvedSrc.filePath, dst );
      }

    }

  }

  // if( reflector.nickName === "reflector::exportedFiles.export." )
  // debugger;

}

_reflectMapForm.defaults =
{
  visited : null,
}

//

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

function prefixesRelative()
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let prefixPath;

  _.assert( arguments.length === 0 );
  _.assert( reflector.src.postfixPath === null, 'not implemented' );
  _.assert( reflector.dst.postfixPath === null, 'not implemented' );

  reflector.src.pairWithDst( reflector.dst );
  reflector.src.prefixesRelative();
  reflector.dst.prefixesRelative();

}

//

function prefixesApply()
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let prefixPath;

  _.assert( arguments.length === 0 );
  _.assert( reflector.src.postfixPath === null, 'not implemented' );
  _.assert( reflector.dst.postfixPath === null, 'not implemented' );

  reflector.src.pairWithDst( reflector.dst );
  reflector.src.prefixesApply();
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

  o = _.routineOptions( pathsResolve, arguments );

  if( _.mapIs( reflector.src.filePath ) )
  reflector.src.filePathNullizeMaybe();

  if( reflector.src.basePath )
  reflector.src.basePath = resolve( reflector.src.basePath );
  if( reflector.src.filePath )
  reflector.src.filePath = resolve( reflector.src.filePath );
  if( reflector.src.prefixPath || reflector.src.hasAnyPath() )
  reflector.src.prefixPath = resolve( reflector.src.prefixPath || '.', 'in' );
  if( reflector.src.prefixPath || reflector.src.hasAnyPath() )
  reflector.src.prefixPath = path.join( reflector.module.inPath, reflector.src.prefixPath || '.' );

  if( reflector.dst.filePath )
  reflector.dst.filePath = resolve( reflector.dst.filePath );
  if( reflector.dst.basePath )
  reflector.dst.basePath = resolve( reflector.dst.basePath );
  let dstHasDst = path.pathMapDstFromDst( reflector.dst.filePath ).filter( ( e ) => _.strIs( e ) ).length > 0;
  if( reflector.dst.prefixPath || dstHasDst )
  reflector.dst.prefixPath = resolve( reflector.dst.prefixPath || '.', 'in' );
  if( reflector.dst.prefixPath || dstHasDst )
  reflector.dst.prefixPath = path.join( reflector.module.inPath, reflector.dst.prefixPath || '.' );

  _.assert( reflector.src.prefixPath === null || path.s.allAreAbsolute( reflector.src.prefixPath ) );
  _.assert( reflector.dst.prefixPath === null || path.s.allAreAbsolute( reflector.dst.prefixPath ) );

  /* */

  function resolve( src, pathResolving )
  {

    return path.refilter( src, ( filePath ) =>
    {
      if( _.instanceIs( filePath ) )
      return filePath;
      if( _.boolIs( filePath ) )
      return filePath;
      if( !module.selectorIs( filePath ) && !pathResolving )
      return filePath;
      return module.pathResolve
      ({
        selector : filePath,
        current : reflector,
        pathResolving : /*pathResolving ||*/ 'in',
      });
    });

  }

}

pathsResolve.defaults =
{
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

  o = _.routineOptions( optionsForFindExport, arguments );
  _.assert( reflector.dst === null || !reflector.dst.hasFiltering() );

  result.recursive = reflector.recursive === null ? 2 : reflector.recursive;

  if( reflector.src )
  result.filter = reflector.src.clone();
  result.filter = result.filter || Object.create( null );
  result.filter.prefixPath = path.resolve( module.inPath, result.filter.prefixPath || '.' );
  if( o.resolving )
  if( result.filter.basePath )
  result.filter.basePath = path.resolve( module.inPath, result.filter.basePath );

  return result;
}

optionsForFindExport.defaults =
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

  o = _.routineOptions( optionsForReflectExport, arguments );
  _.assert( !o.resolving );

  result.recursive = reflector.recursive === null ? 2 : reflector.recursive;

  /* */

  if( reflector.src )
  result.srcFilter = reflector.src.clone();
  result.srcFilter = result.srcFilter || Object.create( null );
  result.srcFilter.prefixPath = path.resolve( module.inPath, result.srcFilter.prefixPath || '.' );
  if( o.resolving )
  if( result.srcFilter.basePath )
  result.srcFilter.basePath = path.resolve( module.inPath, result.srcFilter.basePath );

  if( reflector.dst )
  result.dstFilter = reflector.dst.clone();
  result.dstFilter = result.dstFilter || Object.create( null );
  result.dstFilter.prefixPath = path.resolve( module.inPath, result.dstFilter.prefixPath || '.' );
  if( o.resolving )
  if( result.dstFilter.basePath )
  result.dstFilter.basePath = path.resolve( module.inPath, result.dstFilter.basePath );

  /* */

  return result;
}

optionsForReflectExport.defaults =
{
  resolving : 0,
}

//

function infoExport()
{
  let reflector = this;
  let result = '';
  let fields = reflector.dataExport();

  _.assert( reflector.formed > 0 );

  result += reflector.nickName;
  result += '\n' + _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } );
  result += '\n';

  return result;
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

  _.assert( reflector.src instanceof _.FileRecordFilter );

  let result = Parent.prototype.dataExport.apply( this, arguments );

  delete result.filePath;

  if( result.dst )
  if( _.mapIs( reflector.src.filePath ) )
  if( _.entityIdentical( reflector.src.filePath, reflector.dst.filePath ) )
  delete result.dst.filePath;

  if( _.mapIs( result.dst ) && _.entityLength( result.dst ) === 0 )
  delete result.dst;

  if( result.src && result.src.prefixPath && path.isAbsolute( result.src.prefixPath ) )
  result.src.prefixPath = path.relative( module.inPath, result.src.prefixPath );

  if( result.dst && result.dst.prefixPath && path.isAbsolute( result.dst.prefixPath ) )
  result.dst.prefixPath = path.relative( module.inPath, result.dst.prefixPath );

  return result;
}

dataExport.defaults =
{
  compact : 1,
  copyingAggregates : 0,
}

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

// --
// relations
// --

let Composes =
{

  description : null,
  recursive : null,
  filePath : null,
  src : null,
  dst : null,
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
  KindName : 'reflector',
  MapName : 'reflectorMap',
}

let Forbids =
{
  inherited : 'inherited',
  filter : 'filter',
  parameter : 'parameter',
  reflectMap : 'reflectMap',
  srcFilter : 'srcFilter',
  dstFilter : 'dstFilter',
}

let Accessors =
{
  filePath : { setter : filePathSet, getter : filePathGet },
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

  init,
  cloneDerivative,
  form1,
  form2,
  form3,

  _inheritMultiple,
  _inheritSingle,
  _reflectMapForm,

  sureRelativeOrGlobal,
  isRelativeOrGlobal,
  prefixesRelative,
  prefixesApply,
  pathsResolve,

  // exporter

  optionsForFindExport,
  optionsForReflectExport,
  infoExport,
  dataExport,

  // accessor

  filePathGet,
  filePathSet,

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

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
