( function _Exported_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Inheritable;
let Self = function wWillExported( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Exported';

// --
// inter
// --

// function _inheritSingle( o )
// {
//   let exported = this;
//   let module = exported.module;
//   let inf = exported.inf;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//
//   if( _.strIs( o.ancestor ) )
//   o.ancestor = module[ module.MapName ][ o.ancestor ];
//
//   let exported2 = o.ancestor;
//
//   _.assert( !!exported2.formed );
//   _.assert( o.ancestor instanceof module.constructor, () => 'Expects ' + module.constructor.shortName + ' but got ' + _.strTypeOf( o.ancestor ) );
//   _.assert( arguments.length === 1 );
//   _.assert( exported.formed === 1 );
//   _.assertRoutineOptions( _inheritSingle, arguments );
//   _.assert( !!exported2.formed );
//
//   if( exported2.formed !== 2 )
//   {
//     _.sure( !_.arrayHas( o.visited, exported2.name ), () => 'Cyclic dependency exported ' + _.strQuote( exported.name ) + ' of ' + _.strQuote( exported2.name ) );
//     exported2._inheritForm({ visited : o.visited });
//   }
//
//   let extend = _.mapOnly( exported2, _.mapNulls( exported ) );
//   delete extend.criterion;
//   exported.copy( extend );
//
//   exported.criterionInherit( exported2.criterion );
//
//   // if( exported2.criterion )
//   // exported.criterion = _.mapSupplement( exported.criterion || null, exported2.criterion );
//
// }
//
// _inheritSingle.defaults=
// {
//   exportedName : null,
//   visited : null,
// }

//
//
// function infoExport()
// {
//   let exported = this;
//   let result = '';
//   let fields = exported.dataExport();
//
//   if( Object.keys( fields ).length === 0 )
//   return result;
//
//   result += exported.constructor.shortName + '\n';
//   result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } ) + '\n';
//   result += '\n';
//
//   return result;
// }
//
// //
//
// function dataExport()
// {
//   let exported = this;
//   let fields = exported.cloneData({ compact : 1, copyingAggregates : 0 });
//   return fields;
// }

// --
// relations
// --

let Composes =
{

  description : null,
  criterion : null,

  formatVersion : null,
  version : null,
  files : null,

  inherit : _.define.own([]),

}

let Aggregates =
{
  name : null,
}

let Associates =
{
  module : null,
}

let Restricts =
{
}

let Statics =
{
  // formed : 0,
  MapName : 'exportedMap',
  PoolName : 'exported',
}

let Forbids =
{
}

let Accessors =
{
  // inherit : { setter : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
}

// --
// declare
// --

let Proto =
{

  // inter

  // finit : finit,
  // init : init,
  //
  // infoExport : infoExport,
  // dataExport : dataExport,

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
