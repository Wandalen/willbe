( function _Reflector_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Inheritable;
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

  reflector.srcFilter = fileProvider.recordFilter();
  reflector.dstFilter = fileProvider.recordFilter();

  return Parent.prototype.init.apply( reflector, arguments );
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
  _.assert( module.formed >= 2 );
  _.assert( !willf || !!willf.formed );
  _.assert( _.strDefined( reflector.name ) );

  /* begin */

  module[ reflector.MapName ][ reflector.name ] = reflector;
  if( willf )
  willf[ reflector.MapName ][ reflector.name ] = reflector;

  reflector.srcFilter = reflector.srcFilter || {};

  if( reflector.srcFilter )
  {
    reflector.srcFilter.hubFileProvider = fileProvider;
    if( reflector.srcFilter.basePath )
    reflector.srcFilter.basePath = path.s.normalize( reflector.srcFilter.basePath );
    // reflector.srcFilter.basePath = path.s.normalize( path.s.join( module.dirPath, reflector.srcFilter.basePath ) );
    if( !reflector.srcFilter.formed )
    reflector.srcFilter._formComponents();
  }

  reflector.dstFilter = reflector.dstFilter || {};

  if( reflector.dstFilter )
  {
    reflector.dstFilter.hubFileProvider = fileProvider;

    if( reflector.dstFilter.basePath )
    reflector.dstFilter.basePath = path.s.normalize( reflector.dstFilter.basePath );
    // reflector.dstFilter.basePath = path.s.normalize( path.s.join( module.dirPath, reflector.dstFilter.basePath ) );
    if( !reflector.dstFilter.formed )
    reflector.dstFilter._formComponents();
  }

  if( reflector.filePath )
  {
    reflector.filePath = path.globMapExtend( null, reflector.filePath, true );
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

  // console.log( reflector.absoluteName, 'form2' );
  // if( module.nickName === 'Module::encore.wtools.base' && !reflector.criterion.predefined ) debugger;

  /* filters */

  reflector.pathsResolve();

  let result = Parent.prototype.form2.apply( reflector, arguments );

  // if( module.nickName === 'Module::encore.wtools.base' && !reflector.criterion.predefined ) debugger;

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

  /* begin */

  Parent.prototype._inheritMultiple.call( reflector, o );

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

  _.assert( reflector.srcFilter instanceof _.FileRecordFilter );
  _.assert( reflector.dstFilter instanceof _.FileRecordFilter );
  _.assert( reflector2.srcFilter instanceof _.FileRecordFilter );
  _.assert( reflector2.dstFilter instanceof _.FileRecordFilter );
  _.assert( _.entityIdentical( reflector.srcFilter.inFilePath, reflector.filePath ) );
  _.assert( _.entityIdentical( reflector2.srcFilter.inFilePath, reflector2.filePath ) );

  // debugger;

  if( reflector2.formed < 2 )
  {
    _.sure( !_.arrayHas( o.visited, reflector2.name ), () => 'Cyclic dependency ' + reflector.nickName + ' of ' + reflector2.nickName );
    reflector2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( reflector2, _.mapNulls( reflector ) );

  delete extend.srcFilter;
  delete extend.dstFilter;
  delete extend.criterion;
  delete extend.filePath;

  reflector.copy( extend );
  reflector.criterionInherit( reflector2.criterion );

  // if( reflector.absoluteName === 'Module::encore.wtools.base / reflector::reflect.submodules' )
  // debugger;

  reflector.srcFilter.and( reflector2.srcFilter ).pathsInherit( reflector2.srcFilter );

  if( _.mapIs( reflector.filePath ) )
  {
    // reflector.dstFilter.inFilePath = _.longRemoveDuplicates( _.mapVals( reflector.filePath ) );
    // reflector.dstFilter.inFilePath = reflector.dstFilter.inFilePath.filter( ( e ) => e === false ? false : true )
  }

  // logger.log( '_inheritSingle', reflector.nickName, '<-', reflector2.nickName );
  if( reflector.nickName === 'reflector::reflect.submodules' )
  debugger;

  reflector.dstFilter.and( reflector2.dstFilter ).pathsInherit( reflector2.dstFilter );

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

  // console.log( reflector.absoluteName, 'form3' );
  // if( module.nickName === 'Module::encore.wtools.base' && !reflector.criterion.predefined ) debugger;

  /* begin */

  // if( module.nickName === 'Module::encore.wtools.base' && !reflector.criterion.predefined ) debugger;
  reflector.pathsResolve({ addingPrefix : 1 });
  // if( module.nickName === 'Module::encore.wtools.base' && !reflector.criterion.predefined ) debugger;
  reflector.relative();
  // if( module.nickName === 'Module::encore.wtools.base' && !reflector.criterion.predefined ) debugger;
  reflector.sureRelativeOrGlobal();

  /* end */

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

    if( !_.boolIs( dst ) )
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

    if( !module.strIsResolved( r ) )
    {

      let resolved = reflector.resolve
      ({
        query : r,
        visited : o.visited,
        current : reflector,
        mapVals : 1,
        unwrappingSingle : 1,
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
        path.globMapExtend( map, resolved.filePath, dst );
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
  _.assert( reflector.srcFilter instanceof _.FileRecordFilter );
  _.assert( reflector.dstFilter instanceof _.FileRecordFilter );
  _.assert( reflector.srcFilter.inFilePath === reflector.filePath );

  try
  {
    reflector.srcFilter.sureRelativeOrGlobal( o );
  }
  catch( err )
  {
    throw _.err( 'Source filter is ill-formed\n', err );
  }

  try
  {
    reflector.dstFilter.sureRelativeOrGlobal( o );
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
  stemPath : 1,
  filePath : 1,
}

//

function isRelativeOrGlobal( o )
{
  let reflector = this;

  o = _.routineOptions( isRelativeOrGlobal, arguments );

  _.assert( reflector.srcFilter instanceof _.FileRecordFilter );
  _.assert( reflector.dstFilter instanceof _.FileRecordFilter );
  _.assert( reflector.srcFilter.inFilePath === reflector.filePath );

  if( !reflector.srcFilter.isRelativeOrGlobal( o ) )
  return false;

  if( !reflector.dstFilter.isRelativeOrGlobal( o ) )
  return false;

  return true;
}

isRelativeOrGlobal.defaults =
{
  fixes : 0,
  basePath : 1,
  stemPath : 1,
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
  _.assert( reflector.srcFilter.postfixPath === null, 'not implemented' );
  _.assert( reflector.dstFilter.postfixPath === null, 'not implemented' );
  _.assert( path.isAbsolute( reflector.srcFilter.prefixPath ) );
  _.assert( path.isAbsolute( reflector.dstFilter.prefixPath ) );

  prefixPath = reflector.srcFilter.prefixPath;
  if( reflector.srcFilter.basePath )
  reflector.srcFilter.basePath = path.filter( reflector.srcFilter.basePath, relative );
  if( reflector.srcFilter.inFilePath )
  reflector.srcFilter.inFilePath = path.filter( reflector.srcFilter.inFilePath, relative );
  if( reflector.srcFilter.stemPath )
  reflector.srcFilter.stemPath = path.filter( reflector.srcFilter.stemPath, relative );

  prefixPath = reflector.dstFilter.prefixPath;
  if( reflector.dstFilter.basePath )
  reflector.dstFilter.basePath = path.filter( reflector.dstFilter.basePath, relative );
  if( reflector.dstFilter.inFilePath )
  reflector.dstFilter.inFilePath = path.filter( reflector.dstFilter.inFilePath, relative );
  if( reflector.dstFilter.stemPath )
  reflector.dstFilter.stemPath = path.filter( reflector.dstFilter.stemPath, relative );

  /* */

  function relative( filePath )
  {
    // if( _.strIs( filePath ) && path.isAbsolute( filePath ) )
    // debugger;
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

  if( reflector.srcFilter.basePath )
  reflector.srcFilter.basePath = path.filter( reflector.srcFilter.basePath, resolve );
  if( reflector.srcFilter.prefixPath )
  reflector.srcFilter.prefixPath = resolve( reflector.srcFilter.prefixPath );
  if( reflector.srcFilter.prefixPath || o.addingPrefix )
  reflector.srcFilter.prefixPath = path.resolve( module.inPath, reflector.srcFilter.prefixPath || '.' );

  if( reflector.dstFilter.basePath )
  reflector.dstFilter.basePath = path.filter( reflector.dstFilter.basePath, resolve );
  if( reflector.dstFilter.prefixPath )
  reflector.dstFilter.prefixPath = resolve( reflector.dstFilter.prefixPath );
  if( reflector.dstFilter.prefixPath || o.addingPrefix )
  reflector.dstFilter.prefixPath = path.resolve( module.inPath, reflector.dstFilter.prefixPath || '.' );

  /* */

  function resolve( src )
  {
    return reflector.resolve({ prefixlessAction : 'resolved', query : src });
  }

}

pathsResolve.defaults =
{
  addingPrefix : 0,
}

//

function optionsReflectExport( o )
{
  let reflector = this;
  let module = reflector.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = Object.create( null );

  o = _.routineOptions( optionsReflectExport, arguments );

  result.reflectMap = reflector.filePath;
  result.recursive = reflector.recursive === null ? 2 : reflector.recursive;
  if( result.recursive === 1 )
  result.recursive = '1';
  if( result.recursive === 2 )
  result.recursive = '2';

  /* */

  if( reflector.srcFilter )
  result.srcFilter = reflector.srcFilter.clone();
  result.srcFilter = result.srcFilter || Object.create( null );
  result.srcFilter.prefixPath = path.resolve( module.dirPath, result.srcFilter.prefixPath || '.' );
  if( o.resolving )
  if( result.srcFilter.basePath )
  result.srcFilter.basePath = path.resolve( module.dirPath, result.srcFilter.basePath );

  if( reflector.dstFilter )
  result.dstFilter = reflector.dstFilter.clone();
  result.dstFilter = result.dstFilter || Object.create( null );
  result.dstFilter.prefixPath = path.resolve( module.dirPath, result.dstFilter.prefixPath || '.' );
  if( o.resolving )
  if( result.dstFilter.basePath )
  result.dstFilter.basePath = path.resolve( module.dirPath, result.dstFilter.basePath );

  // result.dstFilter = result.dstFilter || Object.create( null );
  // result.dstFilter.prefixPath = path.resolve( module.dirPath, result.dstFilter.prefixPath || '.' );
  // // result.dstFilter.basePath = path.resolve( module.dirPath, result.dstFilter.basePath || '.' );

  return result;
}

optionsReflectExport.defaults =
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
  let result = Parent.prototype.dataExport.apply( this, arguments );

  if( result.srcFilter && result.srcFilter.prefixPath && path.isAbsolute( result.srcFilter.prefixPath ) )
  result.srcFilter.prefixPath = path.relative( module.inPath, result.srcFilter.prefixPath );

  if( result.dstFilter && result.dstFilter.prefixPath && path.isAbsolute( result.dstFilter.prefixPath ) )
  result.dstFilter.prefixPath = path.relative( module.inPath, result.dstFilter.prefixPath );

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
  if( !reflector.srcFilter )
  return null;
  return reflector.srcFilter.inFilePath;
}

//

function filePathSet( src )
{
  let reflector = this;
  if( !reflector.srcFilter && src === null )
  return src;
  _.assert( _.objectIs( reflector.srcFilter ), 'Reflector should have srcFilter to set filePath' );
  reflector.srcFilter.inFilePath = _.entityShallowClone( src );
  return reflector.srcFilter.inFilePath;
}

// --
// relations
// --

let Composes =
{

  description : null,
  recursive : null,
  filePath : null,
  srcFilter : null,
  dstFilter : null,
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
  PoolName : 'reflector',
  MapName : 'reflectorMap',
}

let Forbids =
{
  inherited : 'inherited',
  filter : 'filter',
  parameter : 'parameter',
  reflectMap : 'reflectMap',
}

let Accessors =
{
  filePath : { setter : filePathSet, getter : filePathGet },
  srcFilter : { setter : _.accessor.setter.copyable({ name : 'srcFilter', maker : _.routineJoin( _.FileRecordFilter, _.FileRecordFilter.Clone ) }) },
  dstFilter : { setter : _.accessor.setter.copyable({ name : 'dstFilter', maker : _.routineJoin( _.FileRecordFilter, _.FileRecordFilter.Clone ) }) },
}

_.assert( _.routineIs( _.FileRecordFilter ) );

// --
// declare
// --

let Proto =
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

  optionsReflectExport,
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
