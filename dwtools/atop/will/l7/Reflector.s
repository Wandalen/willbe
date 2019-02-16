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

  let module = o.module;
  let will = module.will;
  let fileProvider = will.fileProvider;

  reflector./*srcFilter*/src = fileProvider.recordFilter();
  reflector./*dstFilter*/dst = fileProvider.recordFilter();

  // if( reflector.nickName === 'reflector::reflect.submodules' )
  // debugger;

  let result = Parent.prototype.init.apply( reflector, arguments );

  // if( reflector.nickName === 'reflector::reflect.submodules' )
  // debugger;

  return result;
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
  _.assert( module.preformed >= 2 );
  _.assert( !willf || !!willf.formed );
  _.assert( _.strDefined( reflector.name ) );

  // if( reflector.absoluteName === 'module::super / module::MultipleExports / reflector::exportedFiles.export.' )
  // debugger;
  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  /* begin */

  module[ reflector.MapName ][ reflector.name ] = reflector;
  if( willf )
  willf[ reflector.MapName ][ reflector.name ] = reflector;

  reflector./*srcFilter*/src = reflector./*srcFilter*/src || {};

  if( reflector./*srcFilter*/src )
  {
    reflector./*srcFilter*/src.hubFileProvider = fileProvider;
    if( reflector./*srcFilter*/src.basePath )
    reflector./*srcFilter*/src.basePath = path.s.normalize( reflector./*srcFilter*/src.basePath );
    // reflector./*srcFilter*/src.basePath = path.s.normalize( path.s.join( module.dirPath, reflector./*srcFilter*/src.basePath ) );
    if( !reflector./*srcFilter*/src.formed )
    reflector./*srcFilter*/src._formAssociations();
  }

  reflector./*dstFilter*/dst = reflector./*dstFilter*/dst || {};

  if( reflector./*dstFilter*/dst )
  {
    reflector./*dstFilter*/dst.hubFileProvider = fileProvider;

    if( reflector./*dstFilter*/dst.basePath )
    reflector./*dstFilter*/dst.basePath = path.s.normalize( reflector./*dstFilter*/dst.basePath );
    // reflector./*dstFilter*/dst.basePath = path.s.normalize( path.s.join( module.dirPath, reflector./*dstFilter*/dst.basePath ) );
    if( !reflector./*dstFilter*/dst.formed )
    reflector./*dstFilter*/dst._formAssociations();
  }

  // if( reflector.filePath )
  // reflector.filePath = path.pathMapExtend( null, reflector.filePath, true );
  // if( reflector./*srcFilter*/src.basePath )
  // debugger;

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

  // if( reflector./*srcFilter*/src.basePath )
  // debugger;
  // if( reflector.absoluteName === 'module::super / module::MultipleExports / reflector::exportedFiles.export.' )
  // debugger;
  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  /* filters */

  if( reflector.filePath )
  reflector.filePath = path.pathMapExtend( null, reflector.filePath, true );

  reflector.pathsResolve();

  let result = Parent.prototype.form2.apply( reflector, arguments );

  // if( reflector.absoluteName === 'module::super / module::MultipleExports / reflector::exportedFiles.export.' )
  // debugger;
  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  // if( reflector./*srcFilter*/src.basePath )
  // debugger;

  return result;
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

  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  /* begin */

  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  Parent.prototype._inheritMultiple.call( reflector, o );

  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  if( reflector.filePath )
  {
    reflector._reflectMapForm({ visited : o.visited });
  }

  /* end */

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

  _.assert( reflector./*srcFilter*/src instanceof _.FileRecordFilter );
  _.assert( reflector./*dstFilter*/dst instanceof _.FileRecordFilter );
  _.assert( reflector2./*srcFilter*/src instanceof _.FileRecordFilter );
  _.assert( reflector2./*dstFilter*/dst instanceof _.FileRecordFilter );
  _.assert( _.entityIdentical( reflector./*srcFilter*/src.filePath, reflector.filePath ) );
  _.assert( _.entityIdentical( reflector2./*srcFilter*/src.filePath, reflector2.filePath ) );

  if( reflector2.formed < 2 )
  {
    _.sure( !_.arrayHas( o.visited, reflector2.name ), () => 'Cyclic dependency ' + reflector.nickName + ' of ' + reflector2.nickName );
    reflector2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( reflector2, _.mapNulls( reflector ) );

  delete extend./*srcFilter*/src;
  delete extend./*dstFilter*/dst;
  delete extend.criterion;
  delete extend.filePath;

  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  reflector.copy( extend );
  reflector.criterionInherit( reflector2.criterion );

  reflector./*srcFilter*/src.and( reflector2./*srcFilter*/src ).pathsInherit( reflector2./*srcFilter*/src );
  reflector./*dstFilter*/dst.and( reflector2./*dstFilter*/dst ).pathsInherit( reflector2./*dstFilter*/dst );

}

_inheritSingle.defaults=
{
  ancestor : null,
  visited : null,
  defaultDst : true,
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

  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;
  // debugger;

  /* begin */

  reflector.pathsResolve({ addingSrcPrefix : 1 });
  reflector.relative();
  reflector./*srcFilter*/src.basePathSimplify();
  reflector./*dstFilter*/dst.basePathSimplify();
  reflector.sureRelativeOrGlobal();

  _.assert( path.isAbsolute( reflector./*srcFilter*/src.prefixPath ) );

  /* end */

  // if( reflector.nickName === 'reflector::reflect.submodules' )
  // debugger;

  // if( reflector./*srcFilter*/src.basePath )
  // debugger;

  reflector.formed = 3;
  return reflector;
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

  let map = reflector.filePath;
  for( let r in map )
  {
    let dst = map[ r ];

    // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
    // debugger;

    if( !_.boolLike( dst ) )
    {
      _.assert( _.strIs( dst ), 'not tested' );
      if( !module.strIsResolved( dst ) )
      dst = reflector.resolve
      ({
        query : dst,
        visited : o.visited,
        current : reflector,
      });
    }

    // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
    // debugger;

    if( !module.strIsResolved( r ) )
    {

      let resolved = reflector.resolve
      ({
        query : r,
        visited : o.visited,
        current : reflector,
        mapValsUnwrapping : 1,
        singleUnwrapping : 1,
        flattening : 1,
      });

      if( !_.errIs( resolved ) && !_.strIs( resolved ) && !_.arrayIs( resolved ) && !( resolved instanceof will.Reflector ) )
      resolved = _.err( 'Source of reflects map was resolved to unexpected type', _.strType( resolved ) );
      if( _.errIs( resolved ) )
      throw _.err( 'Failed to form ', reflector.nickName, '\n', resolved );

      if( _.arrayIs( resolved ) )
      {
        resolved = path.s.normalize( resolved );

        delete map[ r ];
        for( let p = 0 ; p < resolved.length ; p++ )
        {
          let rpath = resolved[ p ];
          _.assert( _.strIs( rpath ) );

          if( path.isAbsolute( rpath ) && !path.isGlobal( rpath ) )
          debugger;
          if( path.isAbsolute( rpath ) && !path.isGlobal( rpath ) )
          rpath = path.s.relative( module.dirPath, rpath );

          map[ rpath ] = dst;
        }
      }
      else if( _.strIs( resolved ) )
      {
        resolved = path.normalize( resolved );

        if( path.isAbsolute( resolved ) && !path.isGlobal( resolved ) )
        resolved = path.s.relative( module.dirPath, resolved );

        delete map[ r ];
        map[ resolved ] = dst;
      }
      else if( resolved instanceof will.Reflector )
      {
        delete map[ r ];
        debugger;
        reflector._inheritSingle({ visited : o.visited, ancestor : resolved, defaultDst : dst });
        _.sure( !!resolved.filePath );
        path.pathMapExtend( map, resolved.filePath, dst );
      }

    }
  }

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
  _.assert( reflector./*srcFilter*/src instanceof _.FileRecordFilter );
  _.assert( reflector./*dstFilter*/dst instanceof _.FileRecordFilter );
  _.assert( reflector./*srcFilter*/src.filePath === reflector.filePath );

  try
  {
    reflector./*srcFilter*/src.sureRelativeOrGlobal( o );
  }
  catch( err )
  {
    throw _.err( 'Source filter is ill-formed\n', err );
  }

  try
  {
    reflector./*dstFilter*/dst.sureRelativeOrGlobal( o );
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
  // stemPath : 1,
  filePath : 1,
}

//

function isRelativeOrGlobal( o )
{
  let reflector = this;

  o = _.routineOptions( isRelativeOrGlobal, arguments );

  _.assert( reflector./*srcFilter*/src instanceof _.FileRecordFilter );
  _.assert( reflector./*dstFilter*/dst instanceof _.FileRecordFilter );
  _.assert( reflector./*srcFilter*/src.filePath === reflector.filePath );

  if( !reflector./*srcFilter*/src.isRelativeOrGlobal( o ) )
  return false;

  if( !reflector./*dstFilter*/dst.isRelativeOrGlobal( o ) )
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

function relative()
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let prefixPath;

  _.assert( arguments.length === 0 );
  _.assert( reflector./*srcFilter*/src.postfixPath === null, 'not implemented' );
  _.assert( reflector./*dstFilter*/dst.postfixPath === null, 'not implemented' );

  prefixPath = reflector./*srcFilter*/src.prefixPath;

  if( prefixPath )
  {
    _.assert( path.isAbsolute( reflector./*srcFilter*/src.prefixPath ) );
    if( reflector./*srcFilter*/src.basePath )
    reflector./*srcFilter*/src.basePath = path.filter( reflector./*srcFilter*/src.basePath, relative );
    if( reflector./*srcFilter*/src.filePath )
    reflector./*srcFilter*/src.filePath = path.filter( reflector./*srcFilter*/src.filePath, relative );
    if( reflector./*srcFilter*/src.filePath )
    reflector./*srcFilter*/src.filePath = path.filter( reflector./*srcFilter*/src.filePath, relative );
  }

  prefixPath = reflector./*dstFilter*/dst.prefixPath;

  if( prefixPath )
  {
    _.assert( path.isAbsolute( reflector./*dstFilter*/dst.prefixPath ) );
    if( reflector./*dstFilter*/dst.basePath )
    reflector./*dstFilter*/dst.basePath = path.filter( reflector./*dstFilter*/dst.basePath, relative );
    if( reflector./*dstFilter*/dst.filePath )
    reflector./*dstFilter*/dst.filePath = path.filter( reflector./*dstFilter*/dst.filePath, relative );
    if( reflector./*dstFilter*/dst.filePath )
    reflector./*dstFilter*/dst.filePath = path.filter( reflector./*dstFilter*/dst.filePath, relative );
  }

  /* */

  function relative( filePath )
  {
    if( _.strIs( filePath ) && path.isAbsolute( filePath ) )
    return path.relative( prefixPath, filePath );
    else
    return filePath;
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

  o = _.routineOptions( pathsResolve, arguments );

  // _.assert( !!o.addingSrcPrefix );
  _.assert( !o.addingDstPrefix );

  // if( reflector.absoluteName === 'module::super / module::MultipleExports / reflector::exportedFiles.export.' )
  // debugger;

  // if( reflector./*srcFilter*/src.filePath )
  // reflector./*srcFilter*/src.filePath = resolve( reflector./*srcFilter*/src.filePath, resolve );
  if( reflector./*srcFilter*/src.basePath )
  reflector./*srcFilter*/src.basePath = path.filter( reflector./*srcFilter*/src.basePath, resolve );
  if( reflector./*srcFilter*/src.prefixPath )
  reflector./*srcFilter*/src.prefixPath = resolve( reflector./*srcFilter*/src.prefixPath );
  if( reflector./*srcFilter*/src.prefixPath || o.addingSrcPrefix )
  reflector./*srcFilter*/src.prefixPath = path.resolve( module.inPath, reflector./*srcFilter*/src.prefixPath || '.' );

  if( reflector./*dstFilter*/dst.filePath )
  reflector./*dstFilter*/dst.filePath = resolve( reflector./*dstFilter*/dst.filePath, resolve );
  if( reflector./*dstFilter*/dst.basePath )
  reflector./*dstFilter*/dst.basePath = path.filter( reflector./*dstFilter*/dst.basePath, resolve );
  if( reflector./*dstFilter*/dst.prefixPath )
  reflector./*dstFilter*/dst.prefixPath = resolve( reflector./*dstFilter*/dst.prefixPath );

  // if( reflector./*dstFilter*/dst.prefixPath || o.addingDstPrefix )
  // reflector./*dstFilter*/dst.prefixPath = path.resolve( module.inPath, reflector./*dstFilter*/dst.prefixPath || '.' );
  // else if( reflector./*dstFilter*/dst.filePath )
  // reflector./*dstFilter*/dst.prefixPath = path.common( reflector./*dstFilter*/dst.filePath );

  // if( reflector./*dstFilter*/dst.prefixPath )
  // reflector./*dstFilter*/dst.prefixPath = path.resolve( module.inPath, reflector./*dstFilter*/dst.prefixPath || '.' );
  // else

  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  if( reflector./*dstFilter*/dst.filePath && !reflector./*dstFilter*/dst.prefixPath )
  reflector./*dstFilter*/dst.pathsRelativePrefix();

  // if( reflector./*dstFilter*/dst.filePath && !reflector./*dstFilter*/dst.prefixPath )
  // {
  //   reflector./*dstFilter*/dst.prefixPath = path.common( reflector./*dstFilter*/dst.filePath );
  //   reflector./*dstFilter*/dst.filePath = path.s.relative( reflector./*dstFilter*/dst.prefixPath, reflector./*dstFilter*/dst.filePath );
  //   if( reflector./*dstFilter*/dst.basePath )
  //   reflector./*dstFilter*/dst.basePath = path.s.relative( reflector./*dstFilter*/dst.prefixPath, reflector./*dstFilter*/dst.basePath );
  // }

  if( reflector./*dstFilter*/dst.prefixPath )
  reflector./*dstFilter*/dst.prefixPath = path.resolve( module.inPath, reflector./*dstFilter*/dst.prefixPath || '.' );

  _.assert( reflector./*dstFilter*/dst.prefixPath === null || path.s.allAreAbsolute( reflector./*dstFilter*/dst.prefixPath ) );

  // if( reflector.absoluteName === 'module::super / module::MultipleExports / reflector::exportedFiles.export.' )
  // debugger;
  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  /* */

  function resolve( src )
  {
    return path.filter( src, ( filePath ) => _.strIs( filePath ) ? reflector.resolve({ prefixlessAction : 'resolved', query : filePath }) : filePath );
    //return reflector.resolve({ prefixlessAction : 'resolved', query : src });
  }

}

pathsResolve.defaults =
{
  addingSrcPrefix : 0,
  addingDstPrefix : 0,
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
  _.assert( reflector./*dstFilter*/dst === null || !reflector./*dstFilter*/dst.hasFiltering() );

  result.recursive = reflector.recursive === null ? 2 : reflector.recursive;

  if( reflector./*srcFilter*/src )
  result.filter = reflector./*srcFilter*/src.clone();
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

  if( reflector./*srcFilter*/src )
  result.srcFilter = reflector./*srcFilter*/src.clone();
  result.srcFilter = result.srcFilter || Object.create( null );
  result.srcFilter.prefixPath = path.resolve( module.inPath, result.srcFilter.prefixPath || '.' );
  if( o.resolving )
  if( result.srcFilter.basePath )
  result.srcFilter.basePath = path.resolve( module.inPath, result.srcFilter.basePath );

  if( reflector./*dstFilter*/dst )
  result.dstFilter = reflector./*dstFilter*/dst.clone();
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

  _.assert( reflector./*srcFilter*/src instanceof _.FileRecordFilter );

  let result = Parent.prototype.dataExport.apply( this, arguments );
  delete result.filePath;

  if( result./*srcFilter*/src && result./*srcFilter*/src.prefixPath && path.isAbsolute( result./*srcFilter*/src.prefixPath ) )
  result./*srcFilter*/src.prefixPath = path.relative( module.inPath, result./*srcFilter*/src.prefixPath );

  if( result./*dstFilter*/dst && result./*dstFilter*/dst.prefixPath && path.isAbsolute( result./*dstFilter*/dst.prefixPath ) )
  result./*dstFilter*/dst.prefixPath = path.relative( module.inPath, result./*dstFilter*/dst.prefixPath );

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
  if( !reflector./*srcFilter*/src )
  return null;
  return reflector./*srcFilter*/src.filePath;
}

//

function filePathSet( src )
{
  let reflector = this;
  if( !reflector./*srcFilter*/src && src === null )
  return src;
  _.assert( _.objectIs( reflector./*srcFilter*/src ), 'Reflector should have /*srcFilter*/src to set filePath' );
  reflector./*srcFilter*/src.filePath = _.entityShallowClone( src );
  return reflector./*srcFilter*/src.filePath;
}

// --
// relations
// --

let Composes =
{

  description : null,
  recursive : null,
  filePath : null,
  /*srcFilter*/src : null,
  /*dstFilter*/dst : null,
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
  /*srcFilter*/src : { setter : _.accessor.setter.copyable({ name : 'src', maker : _.routineJoin( _.FileRecordFilter, _.FileRecordFilter.Clone ) }) },
  /*dstFilter*/dst : { setter : _.accessor.setter.copyable({ name : 'dst', maker : _.routineJoin( _.FileRecordFilter, _.FileRecordFilter.Clone ) }) },
}

_.assert( _.routineIs( _.FileRecordFilter ) );

// --
// declare
// --

let Extend =
{

  // inter

  init,
  form1,
  form2,

  _inheritMultiple,
  _inheritSingle,

  form3,

  _reflectMapForm,

  sureRelativeOrGlobal,
  isRelativeOrGlobal,
  relative,
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
