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
  let counter = 0;

  if( o.criterion && _.mapKeys( o.criterion ).length > 0 )
  {
    let samples = _.eachSample({ sets : o.criterion });
    if( samples.length > 1 )
    for( let index = 0 ; index < samples.length ; index++ )
    {
      let criterion = samples[ index ];
      let o2 = _.mapExtend( null, o );

      let vcriterion = Cls.CriterionVariable( samples, criterion );

      let postfix = [];
      for( let c in vcriterion )
      if( vcriterion[ c ] )
      postfix.push( c );

      if( o.name === 'export' ) // xxx
      debugger;

      o2.criterion = criterion;
      o2.name = o.name + '.' + ( postfix.length ? postfix.join( '.' ) : '' );

      // o2.name = o.name + '.' + index;
      result.push( Cls( o2 ).form1() );
      counter += 1;
    }
  }

  if( !counter )
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

function copy( o )
{
  let inheritable = this;
  _.assert( _.objectIs( o ) );
  _.assert( arguments.length === 1 );

  if( o.name !== undefined )
  inheritable.name = o.name;

  return _.Copyable.prototype.copy.call( inheritable, o );
}

//

function unform()
{
  let inheritable = this;
  let module = inheritable.module;
  let willf = inheritable.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( inheritable.formed );
  _.assert( module[ inheritable.MapName ][ inheritable.name ] === inheritable );
  if( willf )
  _.assert( willf[ inheritable.MapName ][ inheritable.name ] === inheritable );

  /* begin */

  delete module[ inheritable.MapName ][ inheritable.name ];
  if( willf )
  delete willf[ inheritable.MapName ][ inheritable.name ];

  /* end */

  inheritable.formed = 0;
  return inheritable;
}

//

function form()
{
  let inheritable = this;
  let module = inheritable.module;
  let willf = inheritable.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  // if( inheritable.absoluteName === 'module::withSubmodules / module::Tools / reflector::exportedFiles.0' )
  // debugger;

  if( inheritable.formed === 0 )
  inheritable.form1();
  if( inheritable.formed === 1 )
  inheritable.form2();
  if( inheritable.formed === 2 )
  inheritable.form3();

  _.assert( inheritable.formed === 3 );

  return inheritable;
}

//

function form1()
{
  let inheritable = this;
  let module = inheritable.module;
  let willf = inheritable.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.sure( !module[ inheritable.MapName ][ inheritable.name ], () => 'Module ' + module.dirPath + ' already has ' + inheritable.nickName );
  _.assert( !willf || !willf[ inheritable.MapName ][ inheritable.name ] );
  _.assert( arguments.length === 0 );
  _.assert( !inheritable.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( module.formed >= 2 );
  _.assert( !willf || !!willf.formed );
  _.assert( _.strDefined( inheritable.name ) );

  /* begin */

  module[ inheritable.MapName ][ inheritable.name ] = inheritable;
  if( willf )
  willf[ inheritable.MapName ][ inheritable.name ] = inheritable;

  /* end */

  inheritable.formed = 1;
  return inheritable;
}

//

function form2()
{
  let inheritable = this;
  let module = inheritable.module;

  if( inheritable.formed >= 2 )
  return inheritable;

  _.assert( arguments.length === 0 );
  _.assert( inheritable.formed === 1 );

  /* begin */

  inheritable._inheritForm({ visited : [] })

  /* end */

  inheritable.criterionValidate();

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

  return inheritable;
}

//

function _inheritMultiple( o )
{
  let inheritable = this;
  let module = inheritable.module;
  let willf = inheritable.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  /* begin */

  o.ancestors.map( ( ancestor ) =>
  {

    _.assert( _.strIs( inheritable.PoolName ) );
    _.assert( _.strIs( ancestor ) );

    // if( inheritable.nickName === 'reflector::reflect.submodules' )
    // debugger;
    let ancestors = module.resolve
    ({
      query : ancestor,
      defaultPool : inheritable.PoolName,
      visited : o.visited,
      current : inheritable,
      flattening : 1,
    });

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

function _inheritSingle( o )
{
  let inheritable = this;
  let module = inheritable.module;
  let willf = inheritable.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( _.strIs( o.ancestor ) )
  o.ancestor = module[ module.MapName ][ o.ancestor ];

  let inheritable2 = o.ancestor;

  _.assert( !!inheritable2.formed );
  _.assert( o.ancestor instanceof inheritable.constructor, () => 'Expects ' + inheritable.constructor.shortName + ' but got ' + _.strType( o.ancestor ) );
  _.assert( arguments.length === 1 );
  _.assert( inheritable.formed === 1 );
  _.assert( !!inheritable2.formed );
  _.assertRoutineOptions( _inheritSingle, arguments );

  if( inheritable2.formed < 2 )
  {
    _.sure( !_.arrayHas( o.visited, inheritable2.name ), () => 'Cyclic dependency ' + inheritable.nickName + ' of ' + inheritable2.nickName );
    inheritable2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( inheritable2, _.mapNulls( inheritable.dataExport({ compact : 0, copyingAggregates : 1 }) ) );
  delete extend.criterion;
  inheritable.copy( extend );
  inheritable.criterionInherit( inheritable2.criterion );

}

_inheritSingle.defaults=
{
  ancestor : null,
  visited : null,
}

//

function form3()
{
  let inheritable = this;
  let module = inheritable.module;
  let willf = inheritable.willf;
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

// --
// criterion
// --

function criterionValidate()
{
  let inheritable = this;

  if( inheritable.criterion )
  for( let c in inheritable.criterion )
  {
    let crit = inheritable.criterion[ c ];
    _.sure( _.primitiveIs( crit ), () => 'Criterion ' + c + ' of ' + inheritable.nickName + ' should be primitive, but is ' + _.strType( crit ) );
  }

}

//

function criterionSattisfy( criterion2 )
{
  let inheritable = this;
  let criterion1 = inheritable.criterion;

  _.assert( criterion2 === null || _.mapIs( criterion2 ) );
  _.assert( arguments.length === 1 );

  if( criterion2 === null )
  debugger;

  if( criterion1 === null )
  return true;
  if( criterion2 === null )
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

function criterionInherit( criterion2 )
{
  let inheritable = this;
  let criterion1 = inheritable.criterion;

  _.assert( criterion2 === null || _.mapIs( criterion2 ) );
  _.assert( arguments.length === 1 );

  if( criterion2 === null )
  return criterion1

  criterion1 = inheritable.criterion = inheritable.criterion || Object.create( null );

  _.mapSupplement( criterion1, _.mapBut( criterion1, { default : null, predefined : null } ) )

  return criterion1;
}

//

function criterionVariable( criterions, criterion )
{
  let inheritable = this;

  if( !criterion )
  criterion = inheritable.criterion;

  return inheritable.CriterionVariable( criterions, criterion );
}

//

function CriterionVariable( criterions, criterion )
{

  criterions = _.arrayAs( criterions );
  criterions = criterions.map( ( e ) => _.mapIs( e ) ? e : e.criterion );

  if( Config.debug )
  _.assert( _.all( criterions, ( criterion ) => _.mapIs( criterion ) ) );
  _.assert( arguments.length === 2 );

  _.arrayAppendOnce( criterions, criterion );

  // let any = _.mapExtend( null, criterions[ 0 ] );
  let all = _.mapExtend( null, criterions[ 0 ] );

  for( let i = 1 ; i < criterions.length ; i++ )
  {
    let criterion2 = criterions[ i ];

    // _.mapExtend( any, criterion2 );

    for( let c in all )
    if( criterion2[ c ] != all[ c ] )
    delete all[ c ];

  }

  let result = _.mapBut( criterion, all );

  return result;
}
// --
// export
// --

function infoExport()
{
  let inheritable = this;
  let result = '';
  let fields = inheritable.dataExport();

  result += inheritable.nickName + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1, stringWrapper : '' } ) + '\n';

  return result;
}

//

function dataExport()
{
  let inheritable = this;

  let o = _.routineOptions( dataExport, arguments );

  let fields = inheritable.cloneData( o );

  delete fields.name;
  return fields;
}

dataExport.defaults =
{
  compact : 1,
  copyingAggregates : 0,
}

//

function compactField( it )
{
  let inheritable = this;
  let module = inheritable.module;
  let will = module.will;

  if( it.src instanceof Self )
  {
    debugger;
    _.assert( inheritable instanceof will.Exported, 'not tested' );
    it.dst = it.src.nickName;
    return it.dst;
  }

  if( it.dst === null )
  return;

  if( _.arrayIs( it.dst ) && !it.dst.length )
  return;

  if( _.mapIs( it.dst ) && !_.mapKeys( it.dst ).length )
  return;

  // if( _.objectIs( it.src ) && !_.mapIs( it.src ) )
  // debugger;

  return it.dst;
}

// --
// accessor
// --

function _nickNameGet()
{
  let inheritable = this;
  return inheritable.refName;
  // return '→ ' + inheritable.constructor.shortName + ' ' + _.strQuote( inheritable.name ) + ' ←';
}

//

function _refNameGet()
{
  let inheritable = this;
  return inheritable.PoolName + '::' + inheritable.name;
}

//

function _absoluteNameGet()
{
  let inheritable = this;
  let module = inheritable.module;
  return module.absoluteName + ' / ' + inheritable.nickName;
}

// --
// resolver
// --

function resolve_body( o )
{
  let inheritable = this;
  let module = inheritable.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.assert( o.current === null || o.current === inheritable )

  o.current = inheritable;

  let resolved = module.resolve.body.call( module, o );

  return resolved;
}

resolve_body.defaults = Object.create( _.Will.Module.prototype.resolve.defaults );

let resolve = _.routineFromPreAndBody( _.Will.Module.prototype.resolve.pre, resolve_body );

//

function inPathResolve_body( o )
{
  let inheritable = this;
  let module = inheritable.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.query ) );
  _.assertRoutineOptions( inPathResolve_body, arguments );

  let result = inheritable.resolve( o );

  // ({
  //   query : o.query,
  //   defaultPool : 'path',
  //   prefixlessAction : 'throw',
  //   // prefixlessAction : 'resolved',
  //   resolvingPath : 'in',
  // });

  return result;
}

var defaults = inPathResolve_body.defaults = Object.create( resolve.defaults );

defaults.defaultPool = 'path';
defaults.prefixlessAction = 'throw';
defaults.resolvingPath = 'in';

let inPathResolve = _.routineFromPreAndBody( resolve.pre, inPathResolve_body );

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
  willf : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
  MakeForEachCriterion,
  OptionsFrom,
  CriterionVariable,

  MapName : null,
  PoolName : null,
}

let Forbids =
{
  default : 'default',
  predefined : 'predefined',
}

let Accessors =
{
  nickName : { getter : _nickNameGet, readOnly : 1 },
  refName : { getter : _refNameGet, readOnly : 1 },
  absoluteName : { getter : _absoluteNameGet, readOnly : 1 },
  inherit : { setter : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
}

// --
// declare
// --

let Proto =
{

  // inter

  MakeForEachCriterion,
  OptionsFrom,

  finit,
  init,
  copy,

  unform,
  form,
  form1,
  form2,

  _inheritForm,
  _inheritMultiple,
  _inheritSingle,

  form3,

  // criterion

  criterionValidate,
  criterionSattisfy,
  criterionInherit,
  criterionVariable,
  CriterionVariable,

  // export

  infoExport,
  dataExport,
  compactField,

  // accessor

  _nickNameGet,
  _refNameGet,
  _absoluteNameGet,

  // resolver

  resolve,
  // resolve : resolve,
  // inPathResolve : _.routineVectorize_functor( _inPathResolve ),

  inPathResolve,
  // _inPathResolve : _inPathResolve,
  // inPathResolve : _.routineVectorize_functor( _inPathResolve ),

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
  withMixin : 1,
  withClass : 1,
});

// _.Copyable.mixin( Self );

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
