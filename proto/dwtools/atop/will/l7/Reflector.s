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

  reflector.src = fileProvider.recordFilter();
  reflector.dst = fileProvider.recordFilter();

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

  reflector.src = reflector.src || {};

  if( reflector.src )
  {
    reflector.src.hubFileProvider = fileProvider;
    if( reflector.src.basePath )
    reflector.src.basePath = path.s.normalize( reflector.src.basePath );
    // reflector.src.basePath = path.s.normalize( path.s.join( module.dirPath, reflector.src.basePath ) );
    if( !reflector.src.formed )
    reflector.src._formAssociations();
  }

  reflector.dst = reflector.dst || {};

  if( reflector.dst )
  {
    reflector.dst.hubFileProvider = fileProvider;

    if( reflector.dst.basePath )
    reflector.dst.basePath = path.s.normalize( reflector.dst.basePath );
    // reflector.dst.basePath = path.s.normalize( path.s.join( module.dirPath, reflector.dst.basePath ) );
    if( !reflector.dst.formed )
    reflector.dst._formAssociations();
  }

  // if( reflector.filePath )
  // reflector.filePath = path.pathMapExtend( null, reflector.filePath, true );
  // if( reflector.src.basePath )
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

  // if( reflector.src.basePath )
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

  // if( reflector.src.basePath )
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

  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  reflector.copy( extend );
  reflector.criterionInherit( reflector2.criterion );

  reflector.src.and( reflector2.src ).pathsInherit( reflector2.src );
  reflector.dst.and( reflector2.dst ).pathsInherit( reflector2.dst );

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
  reflector.src.basePathSimplify();
  reflector.dst.basePathSimplify();
  reflector.sureRelativeOrGlobal();

  _.assert( path.isAbsolute( reflector.src.prefixPath ) );

  /* end */

  // if( reflector.nickName === 'reflector::reflect.submodules' )
  // debugger;

  // if( reflector.src.basePath )
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
      // debugger;
      // _.assert( _.strIs( dst ), 'not tested' );
      // if( !module.strIsResolved( dst ) )
      dst = reflector.resolve
      ({
        selector : dst,
        visited : o.visited,
        current : reflector,
        prefixlessAction : 'resolved',
      });
    }

    // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
    // debugger;

    if( !module.strIsResolved( r ) )
    {

      let resolved = reflector.resolve
      ({
        selector : r,
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
  // stemPath : 1,
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

function relative()
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

  prefixPath = reflector.src.prefixPath;

  if( prefixPath )
  {
    _.assert( path.isAbsolute( reflector.src.prefixPath ) );
    if( reflector.src.basePath )
    reflector.src.basePath = path.filter( reflector.src.basePath, relative );
    if( reflector.src.filePath )
    reflector.src.filePath = path.filter( reflector.src.filePath, relative );
    if( reflector.src.filePath )
    reflector.src.filePath = path.filter( reflector.src.filePath, relative );
  }

  prefixPath = reflector.dst.prefixPath;

  if( prefixPath )
  {
    _.assert( path.isAbsolute( reflector.dst.prefixPath ) );
    if( reflector.dst.basePath )
    reflector.dst.basePath = path.filter( reflector.dst.basePath, relative );
    if( reflector.dst.filePath )
    reflector.dst.filePath = path.filter( reflector.dst.filePath, relative );
    if( reflector.dst.filePath )
    reflector.dst.filePath = path.filter( reflector.dst.filePath, relative );
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

  // if( reflector.src.filePath )
  // reflector.src.filePath = resolve( reflector.src.filePath, resolve );
  if( reflector.src.basePath )
  reflector.src.basePath = path.filter( reflector.src.basePath, resolve );
  if( reflector.src.prefixPath )
  reflector.src.prefixPath = resolve( reflector.src.prefixPath );
  if( reflector.src.prefixPath || o.addingSrcPrefix )
  reflector.src.prefixPath = path.resolve( module.inPath, reflector.src.prefixPath || '.' );

  if( reflector.dst.filePath )
  reflector.dst.filePath = resolve( reflector.dst.filePath, resolve );
  if( reflector.dst.basePath )
  reflector.dst.basePath = path.filter( reflector.dst.basePath, resolve );
  if( reflector.dst.prefixPath )
  reflector.dst.prefixPath = resolve( reflector.dst.prefixPath );

  // if( reflector.dst.prefixPath || o.addingDstPrefix )
  // reflector.dst.prefixPath = path.resolve( module.inPath, reflector.dst.prefixPath || '.' );
  // else if( reflector.dst.filePath )
  // reflector.dst.prefixPath = path.common( reflector.dst.filePath );

  // if( reflector.dst.prefixPath )
  // reflector.dst.prefixPath = path.resolve( module.inPath, reflector.dst.prefixPath || '.' );
  // else

  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  if( reflector.dst.filePath && !reflector.dst.prefixPath )
  reflector.dst.pathsRelativePrefix();

  // if( reflector.dst.filePath && !reflector.dst.prefixPath )
  // {
  //   reflector.dst.prefixPath = path.common( reflector.dst.filePath );
  //   reflector.dst.filePath = path.s.relative( reflector.dst.prefixPath, reflector.dst.filePath );
  //   if( reflector.dst.basePath )
  //   reflector.dst.basePath = path.s.relative( reflector.dst.prefixPath, reflector.dst.basePath );
  // }

  if( reflector.dst.prefixPath )
  reflector.dst.prefixPath = path.resolve( module.inPath, reflector.dst.prefixPath || '.' );

  _.assert( reflector.dst.prefixPath === null || path.s.allAreAbsolute( reflector.dst.prefixPath ) );

  // if( reflector.absoluteName === 'module::super / module::MultipleExports / reflector::exportedFiles.export.' )
  // debugger;
  // if( reflector.absoluteName === 'module::super / reflector::reflect.submodules.' )
  // debugger;

  /* */

  function resolve( src )
  {
    return path.filter( src, ( filePath ) =>
    {
      if( filePath === 'submodule::*/path::in*=1' )
      debugger;
      if( _.strIs( filePath ) )
      return reflector.resolve({ prefixlessAction : 'resolved', selector : filePath });
      else
      return filePath;
    });
    //return reflector.resolve({ prefixlessAction : 'resolved', selector : src });
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
  reflector.src.filePath = _.entityShallowClone( src );
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
