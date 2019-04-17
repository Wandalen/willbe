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

  // if( o && o.module )
  // {
  //   let instance = o.module[ Self.MapName ][ o.name ];
  //   if( instance && instance.criterion && instance.criterion.predefined )
  //   {
  //     debugger;
  //     return instance;
  //   }
  // }

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
  let single = 1;

  if( o.criterion )
  o.criterion = Cls.CriterionMapResolve( module, o.criterion );

  if( o.criterion )
  o.criterion = Cls.CriterionNormalize( o.criterion );

  if( o.criterion && _.mapKeys( o.criterion ).length > 0 )
  {
    let samples = _.eachSample({ sets : o.criterion });
    if( samples.length > 1 )
    for( let index = 0 ; index < samples.length ; index++ )
    {
      let criterion = samples[ index ];
      let o2 = _.mapExtend( null, o );
      let postfix = Cls.CriterionPostfixFor( samples, criterion );

      o2.criterion = criterion;
      o2.name = o.name + '.' + postfix;

      single = 0;

      if( o2.Optional )
      if( module[ Cls.MapName ][ o2.name ] )
      continue;

      delete o2.Optional;
      result.push( make( o2 ) );
      counter += 1;
    }
  }

  if( single )
  {
    delete o.Optional;
    result = [ make( o ) ];
  }

  return result;

  /* */

  function make( o )
  {
    try
    {

      let instance = o.module[ Cls.MapName ][ o.name ];
      if( instance && instance.criterion && instance.criterion.predefined )
      {
        instance.finit();
      }

      return Cls( o ).form1();
    }
    catch( err )
    {
      throw _.err( 'Error forming', Cls.KindName + '::' + o.name, '\n', err );
    }
  }

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
  let resource = this;
  if( resource.formed )
  resource.unform();
  resource.module = null;
  return _.Copyable.prototype.finit.apply( resource, arguments );
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

function cloneDerivative()
{
  let resource = this;
  let resource2 = resource.clone();

  _.assert( arguments.length === 0 );

  resource2.module = resource.module;
  resource2.willf = resource.willf;
  resource2.original = resource.original || resource;
  resource2.formed = resource.formed;

  return resource2;
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

  if( !resource.original )
  {
    _.assert( module[ resource.MapName ][ resource.name ] === resource );
    if( willf )
    _.assert( willf[ resource.MapName ][ resource.name ] === resource );
  }

  /* begin */

  if( !resource.original )
  {
    delete module[ resource.MapName ][ resource.name ];
    if( willf )
    delete willf[ resource.MapName ][ resource.name ];
  }

  /* end */

  resource.formed = 0;
  return resource;
}

//

function form()
{
  _.assert( !!this.module );

  let resource = this;
  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

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

  _.assert( !!resource.module );

  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !resource.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !willf || !!willf.formed );
  _.assert( _.strDefined( resource.name ) );

  if( !resource.original )
  {
    _.sure( !module[ resource.MapName ][ resource.name ], () => 'Module ' + module.dirPath + ' already has ' + resource.nickName );
    _.assert( !willf || !willf[ resource.MapName ][ resource.name ] );
  }

  /* begin */

  resource.criterion = resource.criterion || Object.create( null );

  for( let c in resource.criterion )
  {
    if( _.arrayIs( resource.criterion[ c ] ) && resource.criterion[ c ].length === 1 )
    resource.criterion[ c ] = resource.criterion[ c ][ 0 ];
  }

  if( !resource.original )
  {
    module[ resource.MapName ][ resource.name ] = resource;
    if( willf )
    willf[ resource.MapName ][ resource.name ] = resource;
  }

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

  _.assert( _.mapIs( resource.criterion ) );
  resource.criterionValidate();

  resource.formed = 2;
  return resource;
}

//

function _inheritForm( o )
{
  let resource = this;
  let module = resource.module;
  let original = resource.original;

  if( resource.inherited === 1 )
  return resource;

  _.assert( arguments.length === 1 );
  _.assert( resource.formed === 1 );
  _.assert( resource.inherited === 0 );
  _.assert( _.arrayIs( resource.inherit ) );
  _.assert( o.ancestors === undefined );
  _.arrayAppendOnceStrictly( o.visited, resource );

  resource.inherited = 1;

  /* begin */

  o.ancestors = resource.inherit;
  resource._inheritMultiple( o );

  /* end */

  _.arrayRemoveElementOnceStrictly( o.visited, resource );
  _.assert( original === resource.original );
  _.assert( resource.inherited === 1 );
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

  // o.ancestors.map( ( ancestor ) =>
  for( let a = o.ancestors.length-1 ; a >= 0 ; a-- )
  {
    let ancestor = o.ancestors[ a ];

    _.assert( _.strIs( resource.KindName ) );
    _.assert( _.strIs( ancestor ) );

    let ancestors = module.resolve
    ({
      selector : ancestor,
      defaultResourceName : resource.KindName,
      prefixlessAction : 'default',
      visited : o.visited,
      currentContext : resource,
      mapFlattening : 1,
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

  }

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
    _.sure( _.strIs( crit ) || _.numberIs( crit ), () => 'Criterion ' + c + ' of ' + resource.nickName + ' should be number or string, but is ' + _.strType( crit ) );
  }

}

//

function criterionSattisfy( criterion2 )
{
  let resource = this;
  let criterion1 = resource.criterion;

  _.assert( criterion1 === null || _.mapIs( criterion1 ) );
  _.assert( criterion2 === null || _.mapIs( criterion2 ) );
  _.assert( arguments.length === 1 );

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

function criterionSattisfyStrict( criterion2 )
{
  let resource = this;
  let criterion1 = resource.criterion;

  _.assert( criterion1 === null || _.mapIs( criterion1 ) );
  _.assert( criterion2 === null || _.mapIs( criterion2 ) );
  _.assert( arguments.length === 1 );

  if( criterion1 === null )
  return true;
  if( criterion2 === null )
  return true;

  for( let c in criterion2 )
  {

    if( criterion1[ c ] === undefined && !criterion2[ c ] )
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

  _.mapSupplement( criterion1, _.mapBut( criterion2, { default : null, predefined : null } ) )

  return criterion1;
}

//

function criterionVariable( criterionMaps, criterion )
{
  let resource = this;

  if( !criterion )
  criterion = resource.criterion;

  return resource.CriterionVariable( criterionMaps, criterion );
}

//

function CriterionVariable( criterionMaps, criterion )
{

  criterionMaps = _.arrayAs( criterionMaps );
  criterionMaps = criterionMaps.map( ( e ) => _.mapIs( e ) ? e : e.criterion );

  if( Config.debug )
  _.assert( _.all( criterionMaps, ( criterion ) => _.mapIs( criterion ) ) );
  _.assert( arguments.length === 2 );

  _.arrayAppendOnce( criterionMaps, criterion );

  let all = _.mapExtend( null, criterionMaps[ 0 ] );
  all = this.CriterionNormalize( all );

  for( let i = 1 ; i < criterionMaps.length ; i++ )
  {
    let criterion2 = criterionMaps[ i ];

    for( let c in all )
    if( criterion2[ c ] === undefined || this.CriterionValueNormalize( criterion2[ c ] ) !== all[ c ] )
    delete all[ c ];

  }

  let result = _.mapBut( criterion, all );

  return result;
}

//

function CriterionPostfixFor( criterionMaps, criterionMap )
{

  _.assert( arguments.length === 2 );

  let variableCriterionMap = this.CriterionVariable( criterionMaps, criterionMap );
  let postfix = [];
  for( let c in variableCriterionMap )
  {
    let value = variableCriterionMap[ c ];
    _.assert( value === this.CriterionValueNormalize( value ) );
    if( value === 0 )
    {}
    else if( value === 1 )
    postfix.push( c );
    else if( value > 1 )
    postfix.push( c + value );
    else if( _.strIs( value ) )
    postfix.push( value );
    else _.assert( 0 );
  }

  let result = ( postfix.length ? postfix.join( '.' ) : '' );

  return result;
}

//

function CriterionMapResolve( module, criterionMap )
{

  _.assert( arguments.length === 2 );
  _.assert( _.mapIs( criterionMap ) );

  let criterionMap2 = Object.create( null );

  for( let c in criterionMap )
  {
    let value = criterionMap[ c ];

    let c2 = module.resolve
    ({
      selector : c,
      prefixlessAction : 'resolved',
    });

    let value2 = value;
    if( _.strIs( value ) || _.arrayIs( value ) )
    {
      value2 = module.resolve
      ({
        selector : value,
        prefixlessAction : 'resolved',
      });
    }

    delete criterionMap[ c ];
    criterionMap2[ c2 ] = value2;

  }

  _.mapExtend( criterionMap, criterionMap2 );

  return criterionMap;
}

//

function CriterionNormalize( criterionMap )
{

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( criterionMap ) );

  for( let c in criterionMap )
  {
    let value = criterionMap[ c ];
    if( _.arrayIs( value ) )
    criterionMap[ c ] = value.map( ( e ) => CriterionValueNormalize( e ) )
    else
    criterionMap[ c ] = CriterionValueNormalize( value );
  }

  return criterionMap;
}

//

function CriterionValueNormalize( criterionValue )
{
  _.assert( arguments.length === 1 );
  _.assert( _.numberIsInt( criterionValue ) || _.boolIs( criterionValue ) || _.strIs( criterionValue ) );
  if( !_.boolIs( criterionValue ) )
  return criterionValue;
  return criterionValue === true ? 1 : 0;
}

// --
// export
// --

function infoExport()
{
  let resource = this;
  let result = '';
  let fields = resource.dataExport();

  result += _.color.strFormat( resource.nickName, 'entity' ) + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1, stringWrapper : '' } );

  return result;
}

//

function dataExport()
{
  let resource = this;
  let o = _.routineOptions( dataExport, arguments );

  if( !o.copyingPredefined )
  if( resource.criterion && resource.criterion.predefined )
  return;

  // if( !resource.writable )
  // debugger;
  if( !o.copyingNonWritable && !resource.writable )
  return;
  // if( !resource.writable )
  // debugger;

  let o2 = _.mapExtend( null, o );
  delete o2.copyingNonWritable;
  delete o2.copyingPredefined;
  let fields = resource.cloneData( o2 );

  delete fields.name;
  return fields;
}

dataExport.defaults =
{
  compact : 1,
  copyingAggregates : 0,
  copyingNonWritable : 1,
  copyingPredefined : 1,
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

function nickNameGet()
{
  let resource = this;
  return resource.refName;
}

//

function decoratedNickNameGet()
{
  let module = this;
  let result = module.nickName;
  return _.color.strFormat( result, 'entity' );
}

//

function _refNameGet()
{
  let resource = this;
  return resource.KindName + '::' + resource.name;
}

//

function absoluteNameGet()
{
  let resource = this;
  let module = resource.module;
  return module.absoluteName + ' / ' + resource.nickName;
}

//

function decoratedAbsoluteNameGet()
{
  let resource = this;
  let result = resource.absoluteName;
  return _.color.strFormat( result, 'entity' );
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
  _.assert( o.currentContext === null || o.currentContext === resource )

  o.currentContext = resource;

  let resolved = module.resolve.body.call( module, o );

  return resolved;
}

var defaults = resolve_body.defaults = Object.create( _.Will.Module.prototype.resolve.defaults );
defaults.prefixlessAction = 'default';

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
  _.assert( _.strIs( o.selector ) );
  _.assertRoutineOptions( inPathResolve_body, arguments );

  if( o.prefixlessAction !== 'default' )
  o.defaultResourceName = null;

  let result = resource.resolve( o );

  return result;
}

var defaults = inPathResolve_body.defaults = Object.create( resolve.defaults );
defaults.defaultResourceName = 'path';
defaults.prefixlessAction = 'default';
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
  _.assert( o.currentContext === null || o.currentContext === resource )

  o.currentContext = resource;

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
  writable : 1,
}

let Associates =
{
}

let Medials =
{
  willf : null,
  module : null,
  original : null,
}

let Restricts =
{
  willf : null,
  module : null,
  original : null,
  formed : 0,
  inherited : 0,
}

let Statics =
{

  MakeForEachCriterion,
  OptionsFrom,
  CriterionVariable,
  CriterionPostfixFor,
  CriterionMapResolve,
  CriterionNormalize,
  CriterionValueNormalize,

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
  nickName : { getter : nickNameGet, readOnly : 1 },
  decoratedNickName : { getter : decoratedNickNameGet, readOnly : 1 },
  refName : { getter : _refNameGet, readOnly : 1 },
  absoluteName : { getter : absoluteNameGet, readOnly : 1 },
  decoratedAbsoluteName : { getter : decoratedAbsoluteNameGet, readOnly : 1 },
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
  cloneDerivative,

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
  criterionSattisfyStrict,
  criterionInherit,
  criterionVariable,
  CriterionVariable,
  CriterionPostfixFor,
  CriterionNormalize,
  CriterionValueNormalize,

  // export

  infoExport,
  dataExport,
  compactField,

  // accessor

  nickNameGet,
  decoratedNickNameGet,
  _refNameGet,
  absoluteNameGet,
  decoratedAbsoluteNameGet,

  // resolver

  resolve,
  inPathResolve,
  reflectorResolve,

  // relation

  Composes,
  Aggregates,
  Associates,
  Medials,
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

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
