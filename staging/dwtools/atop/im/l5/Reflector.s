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
  let inf = reflector.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !reflector.formed );

  _.assert( !!will );
  _.assert( !!module );
  _.assert( !!inf );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.formed );
  _.assert( !!inf.formed );
  _.assert( _.strDefined( reflector.name ) );

  /* begin */

  module.reflectorMap[ reflector.name ] = reflector;
  inf.reflectorMap[ reflector.name ] = reflector;

  if( reflector.srcFilter )
  {
    reflector.srcFilter.hubFileProvider = fileProvider;

    if( reflector.srcFilter.basePath )
    reflector.srcFilter.basePath = path.s.normalize( reflector.srcFilter.basePath );
    // reflector.srcFilter.basePath = path.s.normalize( path.s.join( module.dirPath, reflector.srcFilter.basePath ) );

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

function _inheritForm( o )
{
  let reflector = this;
  let module = reflector.module;
  let inf = reflector.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( reflector.formed === 1 );
  _.assert( _.arrayIs( reflector.inherit ) );
  _.assertRoutineOptions( _inheritForm, arguments );

  /* begin */

  _.arrayAppendOnceStrictly( o.visited, reflector.name );

  reflector.inherit.map( ( ancestorName ) =>
  {
    reflector._inheritFrom({ visited : o.visited, ancestorName : ancestorName, defaultDst : true });
  });

  if( reflector.reflectMap )
  {
    reflector._reflectMapForm({ visited : o.visited });
  }

  /* end */

  reflector.formed = 2;
  return reflector;
}

_inheritForm.defaults=
{
  visited : null,
}

//

function _inheritFrom( o )
{
  let reflector = this;
  let module = reflector.module;
  let inf = reflector.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.strIs( o.ancestorName ) );
  _.assert( arguments.length === 1 );
  _.assert( reflector.formed === 1 );
  _.assertRoutineOptions( _inheritFrom, arguments );

  let reflector2 = module.reflectorMap[ o.ancestorName ];
  _.sure( _.objectIs( reflector2 ), () => 'Reflector ' + _.strQuote( o.ancestorName ) + ' does not exist' );
  _.assert( !!reflector2.formed );

  if( reflector2.formed < 2 )
  {
    _.sure( !_.arrayHas( o.visited, reflector2.name ), () => 'Cyclic dependency reflector ' + _.strQuote( reflector.name ) + ' of ' + _.strQuote( reflector2.name ) );
    reflector2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( reflector2, _.mapNulls( reflector ) );
  delete extend.srcFilter;

  if( extend.reflectMap )
  {
    reflector.reflectMap = path.globMapExtend( reflector.reflectMap, extend.reflectMap, o.defaultDst );
  }

  reflector.copy( extend );

  if( reflector2.srcFilter )
  {
    if( reflector.srcFilter )
    reflector.srcFilter.and( reflector2.srcFilter ).pathsExtend( reflector2.srcFilter );
    else
    reflector.srcFilter = reflector2.srcFilter.clone();
  }

}

_inheritFrom.defaults=
{
  ancestorName : null,
  visited : null,
  defaultDst : true,
}

//

function form3()
{
  let reflector = this;
  let module = reflector.module;
  let inf = reflector.inf;
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
    _.assert( path.s.allAreRelative( src ), () => 'Expects relative path, but relfector ' + reflector.name + ' has ' + src );
    _.assert( _.boolIs( dst ) || path.s.allAreRelative( dst ), () => 'Expects bool or relative path, but relfector ' + reflector.name + ' has ' + dst );
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
  let inf = reflector.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assertRoutineOptions( _reflectMapForm, arguments );

  if( reflector.name === 'grab.release' )
  debugger;

  let map = reflector.reflectMap;
  for( let r in map )
  {
    let dst = map[ r ];

    // if( !_.boolIs( dst ) )
    // dst = module.pathResolve( module.strResolve( dst ) );

    if( !_.boolIs( dst ) )
    dst = module.strResolve( dst );

    if( module.strGetPrefix( r ) )
    {
      let resolved = module.strResolveMaybe( r );
      if( !_.errIs( resolved ) && !_.strIs( resolved ) && !( resolved instanceof will.Reflector ) )
      resolved = _.err( 'Source of reflects map was resolved to unexpected type', _.strTypeOf( resolved ) );
      if( _.errIs( resolved ) )
      throw _.err( 'Failed to form reflector', reflector.name, '\n', resolved );
      if( _.strIs( resolved ) )
      {
        delete map[ r ];
        map[ resolved ] = dst;
      }
      else if( resolved instanceof will.Reflector )
      {
        delete map[ r ];
        reflector._inheritFrom({ visited : o.visited, ancestorName : resolved.name, defaultDst : dst });
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

  // if( fields.srcFilter && _.routineIs( fields.srcFilter.toStr ) )
  // {
  //   srcFilter = fields.srcFilter.toStr();
  //   delete fields.srcFilter;
  // }
  // else
  // {
  //   debugger;
  //   fields.srcFilter = fields.srcFilter ? reflector.srcFilter.hasMask() : fields.srcFilter;
  // }

  result += 'Reflector ' + reflector.name;
  result += '\n' + _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } );

  if( srcFilter )
  result += '\n' + _.strIndentation( 'srcFilter : ' + srcFilter, '  ' );

  result += '\n';

  return result;
}

//

function dataExport()
{
  let reflector = this;
  let fields = Parent.prototype.dataExport.call( reflector );
  return fields;
}

//

function resolvedExport()
{
  let reflector = this;
xxx
  return fields;
}

// --
// relations
// --

let Composes =
{

  description : null,
  reflectMap : null,
  srcFilter : null,
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
  MapName : 'reflectorMap',
}

let Forbids =
{
  inherited : 'inherited',
  filePath : 'filePath',
  filter : 'filter',
}

let Accessors =
{
  srcFilter : { setter : _.accessor.setter.copyable({ name : 'srcFilter', maker : _.FileRecordFilter }) },
  inherit : { setter : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
}

_.assert( _.routineIs( _.FileRecordFilter ) );

// --
// declare
// --

let Proto =
{

  // inter

  form1 : form1,

  _inheritForm : _inheritForm,
  _inheritFrom : _inheritFrom,
  form3 : form3,

  _reflectMapForm : _reflectMapForm,

  optionsReflectExport : optionsReflectExport,

  infoExport : infoExport,
  dataExport : dataExport,
  resolvedExport : resolvedExport,

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
