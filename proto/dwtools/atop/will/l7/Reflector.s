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

  if( reflector.srcFilter )
  {
    reflector.srcFilter.hubFileProvider = fileProvider;

    if( reflector.srcFilter.basePath )
    reflector.srcFilter.basePath = path.s.normalize( reflector.srcFilter.basePath );
    // reflector.srcFilter.basePath = path.s.normalize( path.s.join( module.dirPath, reflector.srcFilter.basePath ) );

    if( !reflector.srcFilter.formed )
    reflector.srcFilter._formComponents();
  }

  if( reflector.reflectMap )
  {
    reflector.reflectMap = path.globMapExtend( null, reflector.reflectMap, true );
  }

  /* end */

  reflector.formed = 1;
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

  /* begin */

  // if( reflector.name === 'download' )
  // debugger;

  Parent.prototype._inheritMultiple.call( reflector, o );

  if( reflector.reflectMap )
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
  defaultDst : null,
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

  // debugger;

  // _.routineOptions( _inheritSingle, arguments );
  _.assertRoutineOptions( _inheritSingle, arguments );
  _.assert( arguments.length === 1 );
  _.assert( reflector.formed === 1 );
  _.assert( reflector2 instanceof reflector.constructor, () => 'Expects reflector, but got', _.strTypeOf( reflector2 ) );
  _.assert( !!reflector2.formed );

  // debugger;

  if( reflector2.formed < 2 )
  {
    _.sure( !_.arrayHas( o.visited, reflector2.name ), () => 'Cyclic dependency ' + reflector.nickName + ' of ' + reflector2.nickName );
    reflector2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( reflector2, _.mapNulls( reflector ) );
  delete extend.srcFilter;
  delete extend.criterion;

  if( extend.reflectMap )
  {
    reflector.reflectMap = path.globMapExtend( reflector.reflectMap, extend.reflectMap, o.defaultDst );
  }

  reflector.copy( extend );
  reflector.criterionInherit( reflector2.criterion );

  if( reflector2.srcFilter )
  {
    if( reflector.srcFilter )
    reflector.srcFilter.and( reflector2.srcFilter ).pathsExtend( reflector2.srcFilter );
    else
    reflector.srcFilter = reflector2.srcFilter.clone();
  }

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

  /* begin */

  for( let src in reflector.reflectMap )
  {
    let dst = reflector.reflectMap[ src ];

    _.assert
    (
      _.all( src, ( p ) => path.isRelative( p ) || path.isGlobal( p ) ),
      () => 'Expects relative or global path, but ' + reflector.nickName + ' has ' + src
    );

    _.assert
    (
      // _.boolIs( dst ) || path.s.allAreRelative( dst ),
      _.all( dst, ( p ) => _.boolIs( p ) || path.isRelative( p ) || path.isGlobal( p ) ),
      () => 'Expects bool, relative or global path, but ' + reflector.nickName + ' has ' + dst
    );

  }

  if( reflector.srcFilter )
  {
    let p;
    p = reflector.srcFilter.prefixPath;
    _.assert
    (
      p === null || path.s.allAreRelative( p ),
      () => 'Expects relative paths, but ' + reflector.nickName + ' has prefixPath ' + _.toStr( p )
    );
    p = reflector.srcFilter.postfixPath;
    _.assert
    (
      p === null || path.s.allAreRelative( p ),
      () => 'Expects relative paths, but ' + reflector.nickName + ' has postfixPath ' + _.toStr( p )
    );
    p = reflector.srcFilter.basePath;
    if( _.mapIs( p ) )
    p = _.mapVals( reflector.srcFilter.basePath );
    _.assert
    (
      p === null || path.s.allAreRelative( p ),
      () => 'Expects relative paths, but ' + reflector.nickName + ' has basePath ' + _.toStr( p )
    );
    p = reflector.srcFilter.stemPath;
    _.assert
    (
      p === null || path.s.allAreRelative( p ),
      () => 'Expects relative paths, but ' + reflector.nickName + ' has stemPath ' + _.toStr( p )
    );
  }

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

  let map = reflector.reflectMap;
  for( let r in map )
  {
    let dst = map[ r ];

    // if( !_.boolIs( dst ) )
    if( !_.boolIs( dst ) )
    {
      _.assert( _.strIs( dst ), 'not tested' );
      if( !module.strIsResolved( dst ) )
      dst = module.resolve
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

      let resolved = module.resolve
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
        reflector._inheritSingle({ visited : o.visited, ancestor : resolved.name, defaultDst : dst });
        _.sure( !!resolved.reflectMap );
        path.globMapExtend( map, resolved.reflectMap, dst );
      }

    }
  }

}

_reflectMapForm.defaults =
{
  visited : null,
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

  if( reflector.srcFilter )
  result.srcFilter = reflector.srcFilter.clone();
  result.reflectMap = reflector.reflectMap;

  result.srcFilter = result.srcFilter || Object.create( null );
  result.srcFilter.prefixPath = path.resolve( module.dirPath, result.srcFilter.prefixPath || '.' );
  // result.srcFilter.basePath = path.resolve( module.dirPath, result.srcFilter.basePath || '.' );

  if( o.resolving )
  if( result.srcFilter.basePath )
  result.srcFilter.basePath = path.resolve( module.dirPath, result.srcFilter.basePath );

  result.dstFilter = result.dstFilter || Object.create( null );
  result.dstFilter.prefixPath = path.resolve( module.dirPath, result.dstFilter.prefixPath || '.' );
  // result.dstFilter.basePath = path.resolve( module.dirPath, result.dstFilter.basePath || '.' );

  debugger;
  result.recursive = reflector.recursive === null ? true : !!reflector.recursive;

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

  let srcFilter;

  result += reflector.nickName;
  result += '\n' + _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } );

  if( srcFilter )
  result += '\n' + _.strIndentation( 'srcFilter : ' + srcFilter, '  ' );

  result += '\n';

  return result;
}

// --
// relations
// --

let Composes =
{

  description : null,
  reflectMap : null,
  recursive : null,
  srcFilter : null,
  criterion : null,

  // parameter : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
  name : null,
  // predefined : 0,
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
  filePath : 'filePath',
  filter : 'filter',
  parameter : 'parameter',
}

let Accessors =
{
  srcFilter : { setter : _.accessor.setter.copyable({ name : 'srcFilter', maker : _.routineJoin( _.FileRecordFilter, _.FileRecordFilter.Clone ) }) },
  // inherit : { setter : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
}

_.assert( _.routineIs( _.FileRecordFilter ) );

// --
// declare
// --

let Proto =
{

  // inter

  form1 : form1,

  _inheritMultiple : _inheritMultiple,
  _inheritSingle : _inheritSingle,

  form3 : form3,

  _reflectMapForm : _reflectMapForm,

  optionsReflectExport : optionsReflectExport,

  infoExport : infoExport,
  // dataExport : dataExport,
  // resolvedExport : resolvedExport,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

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
