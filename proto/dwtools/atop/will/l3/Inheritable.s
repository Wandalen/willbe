( function _Inheritable_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillInheritable( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Inheritable';

// --
// inter
// --

//

function MakeFroEachCriterion( o )
{
  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) );
  _.assert( _.objectIs( o.module ) );
  _.assert( _.strDefined( o.name ) );

  let result = [];
  let module = o.module;
  let will = module.will;

  let samples = _.eachSample( o.criterion, function( criterion, index )
  {
    let o2 = _.mapExtend( null, o );
    o2.criterion = criterion;
    o2.name = o.name + '.' + index;
    result.push( will.Reflector( o2 ).form1() );
  })

  _.assert( samples.length >= 1 );

  return result;
}

function finit()
{
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let inheritable = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( inheritable );
  Object.preventExtensions( inheritable );

  if( o )
  inheritable.copy( o );

}

//

function unform()
{
  let inheritable = this;
  let module = inheritable.module;
  let inf = inheritable.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( inheritable.formed );
  _.assert( module[ inheritable.MapName ][ inheritable.name ] === inheritable );
  if( inf )
  _.assert( inf[ inheritable.MapName ][ inheritable.name ] === inheritable );

  /* begin */

  delete module[ inheritable.MapName ][ inheritable.name ];
  if( inf )
  delete inf[ inheritable.MapName ][ inheritable.name ];

  /* end */

  inheritable.formed = 0;
  return inheritable;
}

//

function form()
{
  let inheritable = this;
  let module = inheritable.module;
  let inf = inheritable.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  inheritable.form1();
  inheritable.form2();
  inheritable.form3();

  return inheritable;
}

//

function form1()
{
  let inheritable = this;
  let module = inheritable.module;
  let inf = inheritable.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.sure( !module[ inheritable.MapName ][ inheritable.name ], () => 'Module ' + module.dirPath + ' already has ' + inheritable.nickName );
  _.assert( !inf || !inf[ inheritable.MapName ][ inheritable.name ] );

  _.assert( arguments.length === 0 );
  _.assert( !inheritable.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !!module.formed );
  _.assert( !inf || !!inf.formed );
  _.assert( _.strDefined( inheritable.name ) );

  /* begin */

  module[ inheritable.MapName ][ inheritable.name ] = inheritable;
  if( inf )
  inf[ inheritable.MapName ][ inheritable.name ] = inheritable;

  /* end */

  inheritable.formed = 1;
  return inheritable;
}

//

function form2()
{
  let inheritable = this;
  _.assert( arguments.length === 0 );
  _.assert( inheritable.formed === 1 );

  /* begin */

  inheritable._inheritForm({ visited : [] })

  /* end */

  inheritable.formed = 2;
  return inheritable;
}

//

function _inheritForm( o )
{
  let inheritable = this;
  let module = inheritable.module;
  let inf = inheritable.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( inheritable.formed === 1 );
  _.assert( _.arrayIs( inheritable.inherit ) );
  _.assertRoutineOptions( _inheritForm, arguments );

  /* begin */

  _.arrayAppendOnceStrictly( o.visited, inheritable.name );

  inheritable.inherit.map( ( ancestorName ) =>
  {
    inheritable._inheritFrom({ visited : o.visited, ancestorName : ancestorName });
  });

  /* end */

  inheritable.formed = 2;
  return inheritable;
}

_inheritForm.defaults=
{
  visited : null,
}

//
//
// function _inheritFrom( o )
// {
//   let inheritable = this;
//   let module = inheritable.module;
//   let inf = inheritable.inf;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//
//   _.assert( _.strIs( o.ancestorName ) );
//   _.assert( arguments.length === 1 );
//   _.assert( inheritable.formed === 1 );
//   _.assertRoutineOptions( _inheritFrom, arguments );
//
//   let inheritable2 = module[ inheritable.MapName ][ o.ancestorName ];
//   _.sure( _.objectIs( inheritable2 ), () => inheritable.constructor.shortName + ' ' + _.strQuote( o.ancestorName ) + ' does not exist' );
//   _.assert( !!inheritable2.formed );
//
//   if( inheritable2.formed !== 2 )
//   {
//     _.sure( !_.arrayHas( o.visited, inheritable2.name ), () => 'Cyclic dependency inheritable ' + _.strQuote( inheritable.name ) + ' of ' + _.strQuote( inheritable2.name ) );
//     inheritable2._inheritForm({ visited : o.visited });
//   }
//
//   let extend = _.mapOnly( inheritable2, _.mapNulls( inheritable ) );
//   delete extend.criterion;
//   inheritable.copy( extend );
//
//   if( inheritable2.criterion )
//   inheritable.criterion = _.mapSupplement( inheritable.criterion || null, inheritable2.criterion );
//
// }
//
// _inheritFrom.defaults=
// {
//   ancestorName : null,
//   visited : null,
// }

//

function form3()
{
  let inheritable = this;
  let module = inheritable.module;
  let inf = inheritable.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( inheritable.formed === 2 );

  /* begin */

  /* end */

  inheritable.formed = 3;
  return inheritable;
}

//

function infoExport()
{
  let inheritable = this;
  let result = '';
  let fields = inheritable.dataExport();

  result += inheritable.constructor.shortName + ' ' + inheritable.name + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } ) + '\n';

  return result;
}

//

// function dataExport()
// {
//   let inheritable = this;
//   let fields = _.mapOnlyComplementing( inheritable, inheritable.Composes );
//   fields = _.mapButNulls( fields );
//   delete fields.name;
//   return fields;
// }

function dataExport()
{
  let inheritable = this;
  let fields = inheritable.cloneData({ compact : 1, copyingAggregates : 0 });
  delete fields.name;
  return fields;
}

//

function compactField( it )
{
  let inheritable = this;

  if( it.dst === null )
  return;

  if( _.arrayIs( it.dst ) && !it.dst.length )
  return;

  if( _.mapIs( it.dst ) && !_.mapKeys( it.dst ).length )
  return;

  return it.dst;
}

//

function _nickNameGet()
{
  let inheritable = this;
  return '{ ' + inheritable.constructor.shortName + ' ' + _.strQuote( inheritable.name ) + ' }';
}

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
  module : null,
  inf : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
  MakeFroEachCriterion : MakeFroEachCriterion,
  MapName : null,
}

let Forbids =
{
}

let Accessors =
{
  nickName : 'nickName',
}

// --
// declare
// --

let Proto =
{

  // inter

  MakeFroEachCriterion : MakeFroEachCriterion,

  finit : finit,
  init : init,

  unform : unform,
  form : form,
  form1 : form1,
  form2 : form2,
  _inheritForm : _inheritForm,
  _inheritFrom : null,
  form3 : form3,

  infoExport : infoExport,
  dataExport : dataExport,
  compactField : compactField,

  _nickNameGet : _nickNameGet,

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
  withMixin : 1,
  withClass : 1,
});

// _.Copyable.mixin( Self );

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
