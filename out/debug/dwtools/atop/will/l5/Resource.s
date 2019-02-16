( function _Resource_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillResource( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Resource';

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

      // if( o.name === 'export' ) // xxx
      // debugger;

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
  let resource = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( resource );
  Object.preventExtensions( resource );

  if( o )
  resource.copy( o );

  return resource;
}

//

function copy( o )
{
  let resource = this;
  _.assert( _.objectIs( o ) );
  _.assert( arguments.length === 1 );

  if( o.name !== undefined )
  resource.name = o.name;

  return _.Copyable.prototype.copy.call( resource, o );
}

//

function unform()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( resource.formed );
  _.assert( module[ resource.MapName ][ resource.name ] === resource );
  if( willf )
  _.assert( willf[ resource.MapName ][ resource.name ] === resource );

  /* begin */

  delete module[ resource.MapName ][ resource.name ];
  if( willf )
  delete willf[ resource.MapName ][ resource.name ];

  /* end */

  resource.formed = 0;
  return resource;
}

//

function form()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  // if( resource.absoluteName === 'module::withSubmodules / module::Tools / reflector::exportedFiles.0' )
  // debugger;

  if( resource.formed === 0 )
  resource.form1();
  if( resource.formed === 1 )
  resource.form2();
  if( resource.formed === 2 )
  resource.form3();

  _.assert( resource.formed === 3 );

  return resource;
}

//

function form1()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.sure( !module[ resource.MapName ][ resource.name ], () => 'Module ' + module.dirPath + ' already has ' + resource.nickName );
  _.assert( !willf || !willf[ resource.MapName ][ resource.name ] );
  _.assert( arguments.length === 0 );
  _.assert( !resource.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( module.preformed >= 2 );
  _.assert( !willf || !!willf.formed );
  _.assert( _.strDefined( resource.name ) );

  /* begin */

  module[ resource.MapName ][ resource.name ] = resource;
  if( willf )
  willf[ resource.MapName ][ resource.name ] = resource;

  /* end */

  resource.formed = 1;
  return resource;
}

//

function form2()
{
  let resource = this;
  let module = resource.module;

  if( resource.formed >= 2 )
  return resource;

  _.assert( arguments.length === 0 );
  _.assert( resource.formed === 1 );

  /* begin */

  resource._inheritForm({ visited : [] })

  /* end */

  resource.criterionValidate();

  resource.formed = 2;
  return resource;
}

//

function _inheritForm( o )
{
  let resource = this;
  let module = resource.module;

  _.assert( arguments.length === 1 );
  _.assert( resource.formed === 1 );
  _.assert( _.arrayIs( resource.inherit ) );
  _.assert( o.ancestors === undefined );

  _.arrayAppendOnceStrictly( o.visited, resource );

  /* begin */

  o.ancestors = resource.inherit;
  resource._inheritMultiple( o );

  /* end */

  _.arrayRemoveElementOnceStrictly( o.visited, resource );

  return resource;
}

//

function _inheritMultiple( o )
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  /* begin */

  o.ancestors.map( ( ancestor ) =>
  {

    _.assert( _.strIs( resource.KindName ) );
    _.assert( _.strIs( ancestor ) );

    // if( resource.nickName === 'reflector::reflect.submodules' )
    // debugger;
    let ancestors = module.resolve
    ({
      query : ancestor,
      defaultPool : resource.KindName,
      visited : o.visited,
      current : resource,
      flattening : 1,
    });

    if( _.mapIs( ancestors ) )
    ancestors = _.mapVals( ancestors );

    if( ancestors.length === 1 )
    ancestors = ancestors[ 0 ];

    _.assert( _.arrayIs( ancestors ) || ancestors instanceof resource.constructor );

    if( ancestors instanceof resource.constructor )
    {
      let o2 = _.mapExtend( null, o );
      delete o2.ancestors;
      o2.ancestor = ancestors;
      resource._inheritSingle( o2 );
    }
    else if( ancestors.length === 1 )
    {
      let o2 = _.mapExtend( null, o );
      delete o2.ancestors;
      o2.ancestor = ancestors[ 0 ];
      resource._inheritSingle( o2 );
    }
    else
    {
      for( let a = 0 ; a < ancestors.length ; a++ )
      {
        let o2 = _.mapExtend( null, o );
        delete o2.ancestors;
        o2.ancestor = ancestors[ a ];
        resource._inheritSingle( o2 );
      }
    }

  });

  /* end */

  return resource;
}

_inheritMultiple.defaults =
{
  ancestors : null,
  visited : null,
}

//

function _inheritSingle( o )
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( _.strIs( o.ancestor ) )
  o.ancestor = module[ module.MapName ][ o.ancestor ];

  let resource2 = o.ancestor;

  _.assert( !!resource2.formed );
  _.assert( o.ancestor instanceof resource.constructor, () => 'Expects ' + resource.constructor.shortName + ' but got ' + _.strType( o.ancestor ) );
  _.assert( arguments.length === 1 );
  _.assert( resource.formed === 1 );
  _.assert( !!resource2.formed );
  _.assertRoutineOptions( _inheritSingle, arguments );

  if( resource2.formed < 2 )
  {
    _.sure( !_.arrayHas( o.visited, resource2.name ), () => 'Cyclic dependency ' + resource.nickName + ' of ' + resource2.nickName );
    resource2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( resource2, _.mapNulls( resource.dataExport({ compact : 0, copyingAggregates : 1 }) ) );
  delete extend.criterion;
  resource.copy( extend );
  resource.criterionInherit( resource2.criterion );

}

_inheritSingle.defaults=
{
  ancestor : null,
  visited : null,
}

//

function form3()
{
  let resource = this;
  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( resource.formed === 2 );

  /* begin */

  /* end */

  resource.formed = 3;
  return resource;
}

// --
// criterion
// --

function criterionValidate()
{
  let resource = this;

  if( resource.criterion )
  for( let c in resource.criterion )
  {
    let crit = resource.criterion[ c ];
    _.sure( _.primitiveIs( crit ), () => 'Criterion ' + c + ' of ' + resource.nickName + ' should be primitive, but is ' + _.strType( crit ) );
  }

}

//

function criterionSattisfy( criterion2 )
{
  let resource = this;
  let criterion1 = resource.criterion;

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
  let resource = this;
  let criterion1 = resource.criterion;

  _.assert( criterion2 === null || _.mapIs( criterion2 ) );
  _.assert( arguments.length === 1 );

  if( criterion2 === null )
  return criterion1

  criterion1 = resource.criterion = resource.criterion || Object.create( null );

  _.mapSupplement( criterion1, _.mapBut( criterion1, { default : null, predefined : null } ) )

  return criterion1;
}

//

function criterionVariable( criterions, criterion )
{
  let resource = this;

  if( !criterion )
  criterion = resource.criterion;

  return resource.CriterionVariable( criterions, criterion );
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
  let resource = this;
  let result = '';
  let fields = resource.dataExport();

  result += resource.nickName + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1, stringWrapper : '' } ) + '\n';

  return result;
}

//

function dataExport()
{
  let resource = this;

  let o = _.routineOptions( dataExport, arguments );

  let fields = resource.cloneData( o );

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
  let resource = this;
  let module = resource.module;

  if( it.src instanceof Self )
  {
    // debugger;
    _.assert( resource instanceof _.Will.Exported, 'not tested' );
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
  let resource = this;
  return resource.refName;
  // return '→ ' + resource.constructor.shortName + ' ' + _.strQuote( resource.name ) + ' ←';
}

//

function _refNameGet()
{
  let resource = this;
  return resource.KindName + '::' + resource.name;
}

//

function _absoluteNameGet()
{
  let resource = this;
  let module = resource.module;
  return module.absoluteName + ' / ' + resource.nickName;
}

// --
// resolver
// --

function resolve_body( o )
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.assert( o.current === null || o.current === resource )

  o.current = resource;

  let resolved = module.resolve.body.call( module, o );

  return resolved;
}

resolve_body.defaults = Object.create( _.Will.Module.prototype.resolve.defaults );

let resolve = _.routineFromPreAndBody( _.Will.Module.prototype.resolve.pre, resolve_body );

//

function inPathResolve_body( o )
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.query ) );
  _.assertRoutineOptions( inPathResolve_body, arguments );

  let result = resource.resolve( o );

  return result;
}

var defaults = inPathResolve_body.defaults = Object.create( resolve.defaults );
defaults.defaultPool = 'path';
defaults.prefixlessAction = 'throw';
defaults.pathResolving = 'in';

let inPathResolve = _.routineFromPreAndBody( resolve.pre, inPathResolve_body );

//

function reflectorResolve_body( o )
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.assert( o.current === null || o.current === resource )

  o.current = resource;

  let resolved = module.reflectorResolve.body.call( module, o );

  return resolved;
}

reflectorResolve_body.defaults = Object.create( _.Will.Module.prototype.reflectorResolve.defaults );

let reflectorResolve = _.routineFromPreAndBody( _.Will.Module.prototype.reflectorResolve.pre, reflectorResolve_body );

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
  KindName : null,
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
  inPathResolve,
  reflectorResolve,

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
