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
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.formed );
  _.assert( !inf || !!inf.formed );
  _.assert( _.strDefined( reflector.name ) );

  /* begin */

  module[ reflector.MapName ][ reflector.name ] = reflector;
  if( inf )
  inf[ reflector.MapName ][ reflector.name ] = reflector;

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

function _inheritMultiple( o )
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
  _.routineOptions( _inheritMultiple, arguments );

  /* begin */

  // _.arrayAppendOnceStrictly( o.visited, reflector.name );
  //
  // reflector.inherit.map( ( ancestorName ) =>
  // {
  //   reflector._inheritSingle({ visited : o.visited, ancestorName : ancestorName, defaultDst : true });
  // });

  // let o2 = _.mapOnly( o, Parent.prototype._inheritMultiple.defaults );
  Parent.prototype._inheritMultiple.call( reflector, o );

  if( reflector.reflectMap )
  {
    reflector._reflectMapForm({ visited : o.visited });
  }

  /* end */

  // reflector.formed = 2;
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
  let inf = reflector.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( o.ancestorName instanceof reflector.constructor );
  _.assert( arguments.length === 1 );
  _.assert( reflector.formed === 1 );
  _.routineOptions( _inheritSingle, arguments );

  let reflector2 = o.ancestorName;

  // let reflector2 = module[ reflector.MapName ][ o.ancestorName ];
  // let reflector2 = module.strResolve({ subject : o.ancestorName, must : 1, defaultType : 'reflector' });
  //
  // if( reflector2.length === 1 )
  // {
  //   reflector2 = reflector2[ 0 ]
  // }
  // else
  // {
  //   for( let a = 0 ; a < reflector2.length ; a++ )
  //   {
  //     let o2 = _.mapExtend( null, o );
  //     o2.ancestorName = reflector2[ a ];
  //     reflector_inheritFrom( o2 );
  //   }
  // }

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

_inheritSingle.defaults=
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

  // if( reflector.name === 'grab.release' )
  // debugger;

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
        reflector._inheritSingle({ visited : o.visited, ancestorName : resolved.name, defaultDst : dst });
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
  criterion : null,
  parameter : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
  name : null,
  predefined : 0,
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  TypeName : 'reflector',
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

  _inheritMultiple : _inheritMultiple,
  _inheritSingle : _inheritSingle,

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
