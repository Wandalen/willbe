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

  /* filters */

  reflector.srcFilter = reflector.srcFilter || {};
  if( reflector.srcFilter.basePath )
  reflector.srcFilter.basePath = reflector.resolve({ prefixlessAction : 'resolved', query : reflector.srcFilter.basePath });
  if( reflector.srcFilter.prefixPath )
  reflector.srcFilter.prefixPath = reflector.resolve({ prefixlessAction : 'resolved', query : reflector.srcFilter.prefixPath });
  if( reflector.srcFilter.prefixPath )
  reflector.srcFilter.prefixPath = path.resolve( module.inPath, reflector.srcFilter.prefixPath || '.' );

  reflector.dstFilter = reflector.dstFilter || {};
  if( reflector.dstFilter.basePath )
  reflector.dstFilter.basePath = reflector.resolve({ prefixlessAction : 'resolved', query : reflector.dstFilter.basePath });
  if( reflector.dstFilter.prefixPath )
  reflector.dstFilter.prefixPath = reflector.resolve({ prefixlessAction : 'resolved', query : reflector.dstFilter.prefixPath });
  if( reflector.dstFilter.prefixPath )
  reflector.dstFilter.prefixPath = path.resolve( module.inPath, reflector.dstFilter.prefixPath || '.' );

  return Parent.prototype.form2.apply( reflector, arguments );
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

  // if( reflector.name === 'download' )
  // debugger;

  Parent.prototype._inheritMultiple.call( reflector, o );

  if( reflector.filePath )
  {
    reflector._reflectMapForm({ visited : o.visited });
  }

  // if( reflector.name === 'download' )
  // debugger;

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

  // _.routineOptions( _inheritSingle, arguments );
  _.assertRoutineOptions( _inheritSingle, arguments );
  _.assert( arguments.length === 1 );
  _.assert( reflector.formed === 1 );
  _.assert( reflector2 instanceof reflector.constructor, () => 'Expects reflector, but got', _.strTypeOf( reflector2 ) );
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

  // if( reflector2.filePath )
  // {
  //   _.assert( reflector.filePath === null || __.mapIs( reflector.filePath ), 'not tested' );
  //   reflector.filePath = path.globMapExtend( reflector.filePath, reflector2.filePath, o.defaultDst );
  // }

  reflector.copy( extend );
  reflector.criterionInherit( reflector2.criterion );

  // if( reflector.nickName === 'reflector::reflect.submodules' )
  // debugger;

  // let srcFilter2 = reflector2.srcFilter;
  // srcFilter2 = fileProvider.recordFilter( srcFilter2 );

  // if( reflector2.filePath )
  // srcFilter2.inFilePath = reflector2.filePath;

  // if( reflector.srcFilter )

  reflector.srcFilter.and( reflector2.srcFilter ).pathsInherit( reflector2.srcFilter );

  // else
  // reflector.srcFilter = reflector2.srcFilter.clone();

  // if( reflector2.dstFilter )
  // {
  //   if( reflector.dstFilter )

  if( _.mapIs( reflector.filePath ) )
  {
    reflector.dstFilter.inFilePath = _.mapVals( reflector.filePath );
  }

  reflector.dstFilter.and( reflector2.dstFilter ).pathsInherit( reflector2.dstFilter );

  //   else
  //   reflector.dstFilter = reflector2.dstFilter.clone();
  // }
  // if( reflector.nickName === 'reflector::reflect.submodules' )
  // debugger;

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

  // if( reflector.nickName === 'reflector::reflect.submodules' )
  // debugger;

  /* filters */

  reflector.srcFilter = reflector.srcFilter || {};
  if( reflector.srcFilter.basePath )
  reflector.srcFilter.basePath = reflector.resolve({ prefixlessAction : 'resolved', query : reflector.srcFilter.basePath });
  if( reflector.srcFilter.prefixPath )
  reflector.srcFilter.prefixPath = reflector.resolve({ prefixlessAction : 'resolved', query : reflector.srcFilter.prefixPath });
  reflector.srcFilter.prefixPath = path.resolve( module.inPath, reflector.srcFilter.prefixPath || '.' );

  reflector.dstFilter = reflector.dstFilter || {};
  if( reflector.dstFilter.basePath )
  reflector.dstFilter.basePath = reflector.resolve({ prefixlessAction : 'resolved', query : reflector.dstFilter.basePath });
  if( reflector.dstFilter.prefixPath )
  reflector.dstFilter.prefixPath = reflector.resolve({ prefixlessAction : 'resolved', query : reflector.dstFilter.prefixPath });
  reflector.dstFilter.prefixPath = path.resolve( module.inPath, reflector.dstFilter.prefixPath || '.' );

  /* */

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

  // if( reflector.name === 'grab.release' )
  // debugger;

  // if( reflector.nickName === 'reflector::reflect.submodules' )
  // debugger;

  let map = reflector.filePath;
  for( let r in map )
  {
    let dst = map[ r ];

    // if( !_.boolIs( dst ) )
    if( !_.boolIs( dst ) )
    {
      _.assert( _.strIs( dst ), 'not tested' );
      if( !module.strIsResolved( dst ) )
      dst = reflector.resolve
      ({
        query : dst,
        // must : 1,
        // defaultPool : reflector.PoolName,
        visited : o.visited,
        current : reflector,
      });
      // debugger;
    }

    if( !module.strIsResolved( r ) )
    {
      // if( r === 'submodule::*/exported::*=1/path::exportedDir*=1' )
      // debugger;

      let resolved = reflector.resolve
      ({
        query : r,
        visited : o.visited,
        current : reflector,
        mapVals : 1,
        unwrappingSingle : 1,
        flattening : 1,
      });

      // if( r === 'submodule::*/exported::*=1/path::exportedDir*=1' )
      // debugger;

      if( !_.errIs( resolved ) && !_.strIs( resolved ) && !_.arrayIs( resolved ) && !( resolved instanceof will.Reflector ) )
      resolved = _.err( 'Source of reflects map was resolved to unexpected type', _.strTypeOf( resolved ) );
      if( _.errIs( resolved ) )
      throw _.err( 'Failed to form ', reflector.nickName, '\n', resolved );

      if( _.arrayIs( resolved ) )
      {
        // debugger;
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

        // if( path.isAbsolute( resolved ) && !path.isGlobal( resolved ) )
        // debugger;
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

  if( !reflector.srcFilter.sureRelativeOrGlobal( o ) )
  return false;

  if( !reflector.dstFilter.sureRelativeOrGlobal( o ) )
  return false;

  return true;

  // _.assert( reflector.filePath === null || _.mapIs( reflector.filePath ), 'not impelemented' );
  //
  // if( o.filePath && reflector.filePath )
  // for( let src in reflector.filePath )
  // {
  //   let dst = reflector.filePath[ src ];
  //
  //   _.assert
  //   (
  //     _.all( src, ( p ) => path.isRelative( p ) || path.isGlobal( p ) ),
  //     () => 'Expects relative or global path, but ' + reflector.nickName + ' has ' + src
  //   );
  //
  //   _.assert
  //   (
  //     // _.boolIs( dst ) || path.s.allAreRelative( dst ),
  //     _.all( dst, ( p ) => _.boolIs( p ) || path.isRelative( p ) || path.isGlobal( p ) ),
  //     () => 'Expects bool, relative or global path, but ' + reflector.nickName + ' has ' + dst
  //   );
  //
  // }
  //
  // if( reflector.srcFilter )
  // reflector.srcFilter.sureRelativeOrGlobal( o );
  //
  // if( reflector.dstFilter )
  // reflector.dstFilter.sureRelativeOrGlobal( o );

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

  // _.assert( reflector.filePath === null || _.mapIs( reflector.filePath ), 'not impelemented' );
  _.assert( reflector.srcFilter instanceof _.FileRecordFilter );
  _.assert( reflector.dstFilter instanceof _.FileRecordFilter );
  _.assert( reflector.srcFilter.inFilePath === reflector.filePath );

  // if( reflector.filePath )
  // reflector.srcFilter.inFilePath = reflector.filePath;

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

  xxx

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

  _.assert( !!reflector.formed );

  // let srcFilter;

  result += reflector.nickName;
  result += '\n' + _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } );

  // if( srcFilter )
  // result += '\n' + _.strIndentation( 'srcFilter : ' + srcFilter, '  ' );

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
