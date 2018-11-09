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

function MakeForEachCriterion( o )
{
  let Cls = this;

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) );
  _.assert( _.objectIs( o.module ) );
  _.assert( _.strDefined( o.name ) );

  let result = [];
  let module = o.module;
  let will = module.will;
  let done = 0;

  // debugger;

  if( o.criterion && _.mapKeys( o.criterion ).length > 0 )
  {
    // let samples = _.eachSample( o.criterion , function( criterion, index )
    let samples = _.eachSample({ sets : o.criterion });
    if( samples.length > 1 )
    for( let index = 0 ; index < samples.length ; index++ )
    {
      let criterion = samples[ index ];
      let o2 = _.mapExtend( null, o );
      o2.criterion = criterion;
      o2.name = o.name + '.' + index;
      result.push( Cls( o2 ).form1() );
      done += 1;
    }
  }

  if( !done )
  result = [ Cls( o ).form1() ];

  _.assert( result.length >= 1 );

  return result;
}

//

function OptionsFrom( o )
{
  _.assert( arguments.length === 1 );
  return o;
}

//

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

  if( inheritable.criterion )
  for( let c in inheritable.criterion )
  {
    let crit = inheritable.criterion[ c ];
    _.assert( _.primitiveIs( crit ), () => 'Criterion ' + c + ' of ' + inheritable.nickName + ' should be primitive, but is ' + _.strTypeOf( crit ) );
  }

  inheritable.formed = 2;
  return inheritable;
}

//

function _inheritForm( o )
{
  let inheritable = this;
  let module = inheritable.module;

  _.assert( arguments.length === 1 );
  _.assert( inheritable.formed === 1 );
  _.assert( _.arrayIs( inheritable.inherit ) );
  _.assert( o.ancestors === undefined );

  _.arrayAppendOnceStrictly( o.visited, inheritable );

  /* begin */

  o.ancestors = inheritable.inherit;
  inheritable._inheritMultiple( o );

  /* end */

  _.arrayRemoveElementOnceStrictly( o.visited, inheritable );

  inheritable.formed = 2;
  return inheritable;
}

//

function _inheritMultiple( o )
{
  let inheritable = this;
  let module = inheritable.module;
  let inf = inheritable.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  /* begin */

  o.ancestors.map( ( ancestor ) =>
  {

    _.assert( _.strIs( inheritable.PoolName ) );
    _.assert( _.strIs( ancestor ) );

    // if( ancestor === 'reflect' )
    // debugger;

    let ancestors = module.strResolve
    ({
      query : ancestor,
      // must : 1,
      defaultPool : inheritable.PoolName,
      visited : o.visited,
      current : inheritable,
    });
    // debugger;

    if( _.mapIs( ancestors ) )
    ancestors = _.mapVals( ancestors );

    if( ancestors.length === 1 )
    ancestors = ancestors[ 0 ];

    _.assert( _.arrayIs( ancestors ) || ancestors instanceof inheritable.constructor );

    if( ancestors instanceof inheritable.constructor )
    {
      let o2 = _.mapExtend( null, o );
      delete o2.ancestors;
      o2.ancestor = ancestors;
      inheritable._inheritSingle( o2 );
    }
    else if( ancestors.length === 1 )
    {
      let o2 = _.mapExtend( null, o );
      delete o2.ancestors;
      o2.ancestor = ancestors[ 0 ];
      inheritable._inheritSingle( o2 );
    }
    else
    {
      for( let a = 0 ; a < ancestors.length ; a++ )
      {
        let o2 = _.mapExtend( null, o );
        delete o2.ancestors;
        o2.ancestor = ancestors[ a ];
        inheritable._inheritSingle( o2 );
      }
    }

  });

  /* end */

  return inheritable;
}

_inheritMultiple.defaults =
{
  ancestors : null,
  visited : null,
}

//
//
// function _inheritSingle( o )
// {
//   let inheritable = this;
//   let module = inheritable.module;
//   let inf = inheritable.inf;
//   let will = module.will;
//   let fileProvider = will.fileProvider;
//   let path = fileProvider.path;
//   let logger = will.logger;
//
//   _.assert( _.strIs( o.ancestor ) );
//   _.assert( arguments.length === 1 );
//   _.assert( inheritable.formed === 1 );
//   _.assertRoutineOptions( _inheritSingle, arguments );
//
//   let inheritable2 = module[ inheritable.MapName ][ o.ancestor ];
//   _.sure( _.objectIs( inheritable2 ), () => inheritable.constructor.shortName + ' ' + _.strQuote( o.ancestor ) + ' does not exist' );
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
// _inheritSingle.defaults=
// {
//   ancestor : null,
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

function criterionSattisfy( criterion2 )
{
  let inheritable = this;
  let criterion1 = inheritable.criterion;

  if( criterion1 === null )
  return true;

  for( let c in criterion2 )
  {
    if( criterion1[ c ] === undefined )
    continue;
    if( criterion1[ c ] !== criterion2[ c ] )
    return false;
  }

  return true;
}

//

function infoExport()
{
  let inheritable = this;
  let result = '';
  let fields = inheritable.dataExport();

  result += inheritable.constructor.shortName + ' ' + inheritable.name + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1, stringWrapper : '' } ) + '\n';

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
  MakeForEachCriterion : MakeForEachCriterion,
  OptionsFrom : OptionsFrom,

  MapName : null,
  PoolName : null,
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

  MakeForEachCriterion : MakeForEachCriterion,
  OptionsFrom : OptionsFrom,

  finit : finit,
  init : init,

  unform : unform,
  form : form,
  form1 : form1,
  form2 : form2,

  _inheritForm : _inheritForm,
  _inheritMultiple : _inheritMultiple,

  form3 : form3,

  criterionSattisfy : criterionSattisfy,

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
