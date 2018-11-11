( function _Submodule_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = _.Will.Inheritable;
let Self = function wWillSubmodule( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Submodule';

// --
// inter
// --

// function finit()
// {
//   if( this.formed )
//   this.unform();
//   return _.Copyable.prototype.finit.apply( this, arguments );
// }
//
// //
//
// function init( o )
// {
//   let self = this;
//
//   _.assert( arguments.length === 0 || arguments.length === 1 );
//
//   _.instanceInit( self );
//   Object.preventExtensions( self );
//
//   if( o )
//   self.copy( o );
//
// }
//
// //
//
// function unform()
// {
//   let submodule = this;
//
//   _.assert( arguments.length === 0 );
//   _.assert( !!submodule.formed );
//
//   /* begin */
//
//   // _.arrayRemoveElementOnceStrictly( module.inFileArray, submodule );
//
//   /* end */
//
//   submodule.formed = 0;
//   return submodule;
// }
//
// //
//
// function form()
// {
//   let self = this;
//
//   _.assert( arguments.length === 0 );
//   _.assert( !self.formed );
//
//   /* begin */
//
//   /* end */
//
//   self.formed = 1;
//   return self;
// }

// --
// relations
// --

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
  // formed : 0,
}

let Statics =
{
  MapName : 'submoduleMap',
  PoolName : 'submodule',
}

let Forbids =
{
}

// --
// declare
// --

let Proto =
{

  // inter

  // finit : finit,
  // init : init,
  // unform : unform,
  // form : form,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,

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
