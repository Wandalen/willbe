( function _Resource_s_()
{

'use strict';

/**
 * @classdesc Class wWillResource provides common interface for forming, handling different kinds of resources.
 * @class wWillResource
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = null;
const Self = wWillResource;
function wWillResource( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Resource';

// --
// inter
// --

function MakeFor_head( routine, args )
{
  let o = args[ 0 ];

  _.routine.options_( routine, o );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( arguments.length === 2 );

  return o;
}

function MakeFor_body( o )
{
  let Cls = this;

  _.routine.assertOptions( MakeFor_body, arguments );

  if( !o.resource )
  return;

  _.assert( _.constructorIs( Cls ) );
  _.assert( arguments.length === 1 );
  _.assert( !!o.resource );
  _.assert( !!o.willf );
  _.assert( !!o.module );

  let o2 = Object.create( null );

  o2.Optional = o.Optional;
  o2.Rewriting = o.Rewriting;
  o2.Importing = o.Importing;
  o2.IsOut = o.IsOut;

  // if( Cls.ResouceDataFrom )
  // o2.resource = Cls.ResouceDataFrom( o.resource );
  // else
  // o2.resource = _.props.extend( null, o.resource );
  o2.resource = Cls.ResouceMapFrom( o.resource );

  _.assert( o.resource !== o2.resource );

  o2.resource.willf = o.willf;
  o2.resource.module = o.module;
  o2.resource.name = o.name;

  if( o2.Importing === null )
  o2.Importing = 1;
  if( o2.IsOut === null )
  o2.IsOut = o.willf.isOut;

  _.assert( _.boolLike( o2.Importing ) );
  _.assert( _.boolLike( o2.IsOut ) );

  Cls.MakeForEachCriterion( o2 );

}

MakeFor_body.defaults =
{

  module : null,
  willf : null,
  resource : null,
  name : null,

  Optional : null,
  Rewriting : null,
  Importing : null,
  IsOut : null,

}

let MakeFor = _.routine.uniteCloning_replaceByUnite( MakeFor_head, MakeFor_body );

//

function MakeForEachCriterion( o )
{
  let Cls = this;
  let args = arguments;
  let result = [];
  let module = o.resource.module;
  let will = module.will;

  try
  {
    return safe();
  }
  catch( err )
  {
    throw _.err( err, '\nCant form', Cls.KindName + '::' + o.resource.name );
  }

  /* */

  function safe()
  {
    let counter = 0;
    let isSingle = true;

    o = _.routine.options_( MakeForEachCriterion, args );
    _.assert( args.length === 1 );
    _.assert( _.mapIs( o ) );
    _.assert( _.mapIs( o.resource ) );
    _.assert( _.object.isBasic( o.resource.module ) );
    _.assert( _.strDefined( o.resource.name ) );

    if( o.resource.criterion )
    o.resource.criterion = Cls.CriterionMapResolve( module, o.resource.criterion );

    if( o.resource.criterion )
    o.resource.criterion = Cls.CriterionNormalize( o.resource.criterion );

    if( o.resource.criterion && _.props.keys( o.resource.criterion ).length > 0 )
    {
      let samples = _.permutation.eachSample({ sets : o.resource.criterion });
      if( samples.length > 1 )
      for( let index = 0 ; index < samples.length ; index++ )
      {
        let criterion = samples[ index ];
        let o2 = _.props.extend( null, o );
        o2.resource = _.props.extend( null, o.resource );
        let postfix = Cls.CriterionPostfixFor( samples, criterion );

        o2.resource.criterion = criterion;
        o2.resource.name = o.resource.name + '.' + postfix;

        isSingle = false;

        if( o2.Optional )
        if( module[ Cls.MapName ][ o2.resource.name ] )
        continue;

        let r = Cls.MakeSingle( o2 );
        result.push( r );
        counter += 1;
      }
    }

    if( isSingle )
    {
      let r = Cls.MakeSingle( o );
      if( r )
      result.push( r );
      // single( o );
      counter += 1;
    }

    return result;
  }

}

MakeForEachCriterion.defaults =
{
  Optional : null,
  Rewriting : null,
  Importing : null,
  IsOut : null,
  resource : null,
}

//

function MakeSingle( o )
{
  let Cls = this;
  let module = o.resource.module;
  let will = module.will;

  o = _.routine.options_( MakeSingle, arguments );

  try
  {

    _.assert( o.resource.module instanceof _.will.Module );
    _.assert( !!o.resource.module[ Cls.MapName ] );
    let instance = o.resource.module[ Cls.MapName ][ o.resource.name ];
    if( instance )
    {
      _.sure( !!Cls.OnInstanceExists, 'Instance ' + Cls.KindName + '::' + o.resource.name + ' already exists' );
      o.instance = instance;
      Cls.OnInstanceExists( o );
    }

    let optional = !!o.Optional;
    let rewriting = !!o.Rewriting;
    let importing = !!o.Importing;
    let isOut = !!o.IsOut;

    if( !isOut && importing && o.resource.name === 'local' && Cls.KindName === 'path' )
    {
      throw _.err( 'Willfile should have no path::local' );
    }

    if( o.resource.importableFromIn !== undefined && !o.resource.importableFromIn )
    if( importing && !isOut )
    {
      return;
    }

    if( o.resource.importableFromOut !== undefined && !o.resource.importableFromOut )
    if( importing && isOut )
    {
      if( !instance.importableFromPeer )
      return;

      let peerModule = o.resource.module.peerModule;
      if( peerModule )
      {
        let resource = peerModule.resourceGet( instance.KindName, instance.name );
        if( resource.path === null )
        return;
        o.resource = resource.cloneData()
        o.resource.module = module;
      }
    }

    if( instance && rewriting )
    instance.finit();

    let resource = Cls.ResouceStructureFrom( o.resource );
    _.assert( o.resource !== resource );
    let r = Cls( resource ).form1();
    // result.push( r );
    return r;
  }
  catch( err )
  {
    let error = err;
    let criterion = '';
    if( o.resource.criterion )
    criterion += '\nCriterions\n' + _.entity.exportString( o.resource.criterion );
    if( err.message && _.strHas( err.message, 'Options map for' ) )
    error = _.errBrief( err );
    throw _.err( error, `\nFailed to make resource ${Cls.KindName}::${o.resource.name}`, criterion );
  }

}

MakeSingle.defaults =
{
  ... MakeForEachCriterion.defaults,
}

//

function ResouceMapFrom( o )
{
  _.assert( arguments.length === 1 );
  return _.props.extend( null, o );
}

//

function ResouceStructureFrom( o )
{
  _.assert( arguments.length === 1 );
  return _.props.extend( null, o );
}

//

function finit()
{
  let resource = this;
  _.assert( !_.workpiece.isFinited( resource ) );
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

  _.Will.ResourceCounter += 1;
  resource.id = _.Will.ResourceCounter;
  resource.criterion = Object.create( null );

  _.workpiece.initFields( resource );
  Object.preventExtensions( resource );

  if( o )
  resource.copy( o );

  return resource;
}

//

function copy( o )
{
  let resource = this;
  _.assert( _.object.isBasic( o ) );
  _.assert( arguments.length === 1 );

  if( o.name !== undefined )
  resource.name = o.name;

  if( _.mapIs( o ) )
  if( o.module !== undefined )
  resource.module = o.module;

  let result = _.Copyable.prototype.copy.call( resource, o );

  // let module = o.module !== undefined ? o.module : resource.module;
  let module = o.module === undefined ? resource.module : o.module;
  if( o.unformedResource )
  resource.unformedResource = o.unformedResource.cloneExtending({ original : resource, module });

  return result;
}

//

function cloneDerivative()
{
  let resource = this;

  if( resource.original )
  return resource;

  let resource2 = resource.clone();

  _.assert( arguments.length === 0, 'Expects no arguments' );

  resource2.module = resource.module;
  resource2.willf = resource.willf;
  resource2.original = resource.original || resource;
  resource2.formed = resource.formed;
  resource2.unformedResource = resource.unformedResource;

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
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( resource.formed !== 0 );

  if( resource.original && !resource.phantom )
  _.assert( module[ resource.MapName ][ resource.name ] === resource.original );
  else if( !resource.phantom )
  _.assert( module[ resource.MapName ][ resource.name ] === resource );

  /* begin */

  if( !resource.original && !resource.phantom )
  {
    delete module[ resource.MapName ][ resource.name ];
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
  let logger = will.transaction.logger;

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
  _.assert( !!resource.module.will );

  let module = resource.module;
  let willf = resource.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( !resource.formed );
  _.assert( !!will );
  _.assert( !!module );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !willf || !!willf.formed );
  _.assert( resource.phantom || _.strDefined( resource.name ) );

  if( !resource.original )
  {
    _.sure( !module[ resource.MapName ][ resource.name ], () => 'Module ' + module.dirPath + ' already has ' + resource.qualifiedName );
  }

  /* begin */

  resource.criterion = resource.criterion || Object.create( null );

  for( let c in resource.criterion )
  {
    if( _.arrayIs( resource.criterion[ c ] ) && resource.criterion[ c ].length === 1 )
    resource.criterion[ c ] = resource.criterion[ c ][ 0 ];
  }

  if( resource.original )
  _.assert( module[ resource.MapName ][ resource.name ] === resource.original );
  else if( !resource.phantom )
  _.assert
  (
    module[ resource.MapName ][ resource.name ] === undefined || module[ resource.MapName ][ resource.name ] === resource
  );

  if( !resource.original && !resource.phantom )
  {
    module[ resource.MapName ][ resource.name ] = resource;
  }

  /* end */

  resource.formed = 1;
  return resource;
}

//

function form2( o )
{
  let resource = this;
  let module = resource.module;
  o = o || Object.create( null );

  if( resource.formed >= 2 )
  return resource;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( resource.formed === 1 );

  /* begin */

  o.visited = o.visited || [];
  resource._inheritForm( o )
  // resource._inheritForm({ visited : [] })

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
  let logger = will.transaction.logger;

  /* begin */

  for( let a = o.ancestors.length-1 ; a >= 0 ; a-- )
  {
    let ancestor = o.ancestors[ a ];

    _.assert( _.strIs( resource.KindName ) );
    _.assert( _.strIs( ancestor ) );

    let ancestors = module.resolve
    ({
      selector : ancestor,
      defaultResourceKind : resource.KindName,
      prefixlessAction : 'default',
      visited : o.visited,
      currentContext : resource,
      mapFlattening : 1,
    });

    if( _.mapIs( ancestors ) )
    ancestors = _.props.vals( ancestors );

    if( ancestors.length === 1 )
    ancestors = ancestors[ 0 ];

    _.assert( _.arrayIs( ancestors ) || ancestors instanceof resource.constructor );

    if( ancestors instanceof resource.constructor )
    {
      let o2 = _.props.extend( null, o );
      delete o2.ancestors;
      o2.ancestor = ancestors;
      resource._inheritSingle( o2 );
    }
    else if( ancestors.length === 1 )
    {
      let o2 = _.props.extend( null, o );
      delete o2.ancestors;
      o2.ancestor = ancestors[ 0 ];
      resource._inheritSingle( o2 );
    }
    else
    {
      for( let a = 0 ; a < ancestors.length ; a++ )
      {
        let o2 = _.props.extend( null, o );
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
  let logger = will.transaction.logger;

  if( _.strIs( o.ancestor ) )
  o.ancestor = module[ module.MapName ][ o.ancestor ];

  let resource2 = o.ancestor;

  _.assert( !!resource2.formed );
  _.assert( o.ancestor instanceof resource.constructor, () => 'Expects ' + resource.constructor.shortName + ' but got ' + _.entity.strType( o.ancestor ) );
  _.assert( arguments.length === 1 );
  _.assert( resource.formed === 1 );
  _.assert( !!resource2.formed );
  _.routine.assertOptions( _inheritSingle, arguments );

  if( resource2.formed < 2 )
  {
    _.sure( !_.longHas( o.visited, resource2.name ), () => 'Cyclic dependency ' + resource.qualifiedName + ' of ' + resource2.qualifiedName );
    resource2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly_( null, resource2, _.mapOnlyNulls( resource.exportStructure({ compact : 0, copyingAggregates : 1 }) ) );
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
  let logger = will.transaction.logger;

  _.assert( arguments.length === 0, 'Expects no arguments' );
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
    _.sure( _.strIs( crit ) || _.numberIs( crit ), () => 'Criterion ' + c + ' of ' + resource.qualifiedName + ' should be number or string, but is ' + _.entity.strType( crit ) );
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

    if( criterion1[ c ] === 0 || criterion1[ c ] === false )
    if( criterion2[ c ] === 0 || criterion2[ c ] === false )
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

    if( criterion1[ c ] === 0 || criterion1[ c ] === false )
    if( criterion2[ c ] === 0 || criterion2[ c ] === false )
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

  _.props.supplement( criterion1, _.mapBut_( null, criterion2, { default : null, predefined : null } ) )

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

  criterionMaps = _.array.as( criterionMaps );
  criterionMaps = criterionMaps.map( ( e ) => _.mapIs( e ) ? e : e.criterion );

  if( Config.debug )
  _.assert( _.all( criterionMaps, ( criterion ) => _.mapIs( criterion ) ) );
  _.assert( arguments.length === 2 );

  _.arrayAppendOnce( criterionMaps, criterion );

  let all = _.props.extend( null, criterionMaps[ 0 ] );
  all = this.CriterionNormalize( all );

  for( let i = 1 ; i < criterionMaps.length ; i++ )
  {
    let criterion2 = criterionMaps[ i ];

    for( let c in all )
    if( criterion2[ c ] === undefined || this.CriterionValueNormalize( criterion2[ c ] ) !== all[ c ] )
    delete all[ c ];

  }

  let result = _.mapBut_( null, criterion, all );

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

  _.props.extend( criterionMap, criterionMap2 );

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
  _.assert( _.intIs( criterionValue ) || _.boolIs( criterionValue ) || _.strIs( criterionValue ) );
  if( !_.boolIs( criterionValue ) )
  return criterionValue;
  return criterionValue === true ? 1 : 0;
}

// --
// export
// --

function _exportString( o )
{
  let resource = this;
  let result = '';
  o = _.routine.options_( _exportString, arguments );

  result += resource.decoratedAbsoluteName + '\n';
  result += _.entity.exportString( o.fields, { wrap : 0, levels : 4, stringWrapper : '', multiline : 1 } );

  return result;
}

var defaults = _exportString.defaults = Object.create( null );
defaults.fields = 1;

//

function exportString()
{
  let resource = this;
  let o = _.routine.options_( exportString, arguments );

  let fields = resource.exportStructure( o );
  let result = resource._exportString({ fields });

  return result;
}

var defaults = exportString.defaults = Object.create( _.will.Module.prototype.exportStructure.defaults );
defaults.copyingNonExportable = 1;
defaults.formed = 1;
defaults.strict = 0;

//

function exportStructure()
{
  let resource = this;
  let o = _.routine.options_( exportStructure, arguments );

  if( !o.formed )
  if( resource.unformedResource )
  return resource.unformedResource.exportStructure.call( resource.unformedResource, o );

  if( !o.copyingNonExportable )
  if( !resource.exportable )
  return;

  if( !o.copyingPredefined )
  if( resource.criterion && resource.criterion.predefined )
  return;

  if( !o.copyingNonWritable && !resource.writable )
  return;

  if( o.willf )
  if( resource.willf && o.willf !== resource.willf )
  {
    _.assert( 0, 'not tested' );
    return;
  }

  if( o.exportModule && !o.exportModule.isOut )
  if( !resource.importableFromIn )
  {
    return;
  }

  let o2 = _.mapOnly_( null, o, resource.cloneData.defaults );
  let fields = resource.cloneData( o2 );

  delete fields.name;
  return fields;
}

exportStructure.defaults = Object.create( _.will.Module.prototype.exportStructure.defaults );

//

function extraExport()
{
  let resource = this;
  let o = _.routine.options_( extraExport, arguments );

  o.dst = o.dst || Object.create( null );

  o.dst.writable = resource.writable;
  o.dst.exportable = resource.exportable;
  o.dst.importableFromIn = resource.importableFromIn;
  o.dst.importableFromOut = resource.importableFromOut;

  return o.dst;
}

extraExport.defaults =
{
  dst : null,
}

//

function compactField( it )
{
  let resource = this;
  let module = resource.module;

  if( it.src instanceof Self )
  {
    _.assert( resource instanceof _.will.Exported, 'not tested' );
    it.dst = it.src.qualifiedName;
    return it.dst;
  }

  if( it.dst === null )
  return;

  if( _.arrayIs( it.dst ) && !it.dst.length )
  return;

  if( _.mapIs( it.dst ) && !_.props.keys( it.dst ).length )
  return;

  return it.dst;
}

// --
// accessor
// --

function qualifiedNameGet()
{
  let resource = this;
  return resource.refName;
}

//

function decoratedQualifiedNameGet()
{
  let module = this;
  let result = module.qualifiedName;
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

  return ( module ? module.absoluteName : '...' ) + ' / ' + resource.qualifiedName;
}

//

function decoratedAbsoluteNameGet()
{
  let resource = this;
  let result = resource.absoluteName;
  return _.color.strFormat( result, 'entity' );
}

//

function shortNameArrayGet()
{
  let resource = this;
  let module = resource.module;
  let result = module.shortNameArrayGet();
  result.push( resource.name );
  return result;
}

//

function willfSet( src )
{
  let resource = this;
  resource[ willfSymbol ] = src;
  return src;
}

//

function moduleSet( src )
{
  let resource = this;

  if( src && src instanceof _.will.ModuleOpener )
  src = src.openedModule;

  resource[ moduleSymbol ] = src;

  _.assert( resource.module === null || resource.module instanceof _.will.Module );

  return src;
}

//

function toModuleForResolver()
{
  let resource = this;
  _.assert( arguments.length === 0 );
  _.assert( resource.module === null || resource.module instanceof _.will.Module );
  return resource.module;
}

// --
// resolver
// --

function resolve_head( routine, args )
{
  let resource = this;
  let module = resource.module;
  let o = args[ 0 ];
  if( !_.mapIs( o ) )
  o = { selector : o }
  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.aux.is( o ) );
  _.assert( o.currentContext === undefined || o.currentContext === null || o.currentContext === resource );
  o.currentContext = resource;
  let it = module.resolve.head.call( module, routine, [ o ] );
  return it;
}

function resolve_body( o )
{
  let resource = this;
  let module = resource.module;
  _.assert( !!module );
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  // _.assert( o.currentContext === null || o.currentContext === resource );
  _.assert( o.currentContext === resource )

  // o.currentContext = resource;

  let resolved = module.resolve.body.call( module, o );

  return resolved;
}

var defaults = resolve_body.defaults = Object.create( _.will.Module.prototype.resolve.defaults );
defaults.prefixlessAction = 'default';
defaults.Seeker = defaults;

// let resolve = _.routine.uniteCloning_replaceByUnite( resolve_head, resolve_body );
let resolve = _.routine.uniteReplacing( resolve_head, resolve_body );

//

function inPathResolve_head( routine, args )
{
  let resource = this;
  let o = args[ 0 ];
  if( !_.mapIs( o ) )
  o = { selector : o }

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.aux.is( o ) );
  _.assert( _.strIs( o.selector ) || _.strsAreAll( o.selector ) );

  if( o.prefixlessAction !== 'default' )
  o.defaultResourceKind = null;

  let it = resource.resolve.head.call( resource, routine, [ o ] );
  _.assert( _.looker.iterationIs( it ) );
  return it;
}

//

function inPathResolve_body( o )
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.assert( _.looker.iterationIs( o ) );
  // _.assert( _.strIs( o.selector ) || _.strsAreAll( o.selector ) );
  // // _.routine.assertOptions( inPathResolve_body, arguments );
  //
  // if( o.prefixlessAction !== 'default' )
  // o.defaultResourceKind = null;

  // let result = resource.resolve( o );
  let result = resource.resolve.body.call( resource, o );

  return result;
}

// var defaults = inPathResolve_body.defaults = Object.create( resolve.defaults );
// defaults.defaultResourceKind = 'path';
// defaults.prefixlessAction = 'default';
// defaults.pathResolving = 'in';
//
// let inPathResolve = _.routine.uniteCloning_replaceByUnite( inPathResolve_head, inPathResolve_body );
// // let inPathResolve = _.routine.uniteCloning_replaceByUnite( resolve.head, inPathResolve_body );

// var defaults = inPathResolve_body.defaults = Object.create( resolve.defaults );
// defaults.defaultResourceKind = 'path';
// defaults.prefixlessAction = 'default';
// defaults.pathResolving = 'in';
// let inPathResolve = _.routine.uniteCloning_replaceByUnite( inPathResolve_head, inPathResolve_body );

_.assert( _.prototype.has( resolve.defaults, resolve.defaults.OriginalSeeker ) );
_.routine.extendInheriting( inPathResolve_body, { defaults : resolve.defaults } );
_.assert( inPathResolve_body.defaults !== resolve.defaults );
var defaults = inPathResolve_body.defaults;
defaults.defaultResourceKind = 'path';
defaults.prefixlessAction = 'default';
defaults.pathResolving = 'in';
defaults.Seeker = defaults;
// let inPathResolve = _.routine.uniteCloning_replaceByUnite({ head : inPathResolve_head, body : inPathResolve_body, strategy : 'replacing' });
let inPathResolve = _.routine.uniteReplacing( inPathResolve_head, inPathResolve_body );
_.assert( inPathResolve.defaults === inPathResolve.body.defaults );
_.assert( _.prototype.has( inPathResolve.defaults, inPathResolve.defaults.OriginalSeeker ) );

//

function reflectorResolve_head( routine, args )
{
  let resource = this;
  let o = args[ 0 ];

  if( !_.mapIs( o ) )
  o = { selector : o }

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.aux.is( o ) );
  _.assert( o.currentContext === undefined || o.currentContext === null || o.currentContext === resource )

  o.currentContext = resource;

  if( o.prefixlessAction !== 'default' )
  o.defaultResourceKind = null;

  let it = resource.resolve.head.call( resource, routine, [ o ] );
  _.assert( _.looker.iterationIs( it ) );
  return it;
}

function reflectorResolve_body( o )
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.assert( _.looker.iterationIs( o ) );;
  // _.assert( o.currentContext === null || o.currentContext === resource )
  // o.currentContext = resource;

  let resolved = module.reflectorResolve.body.call( module, o );

  return resolved;
}

// reflectorResolve_body.defaults = Object.create( _.will.Module.prototype.reflectorResolve.defaults );
// let reflectorResolve = _.routine.uniteCloning_replaceByUnite( reflectorResolve_head, reflectorResolve_body );
// // let reflectorResolve = _.routine.uniteCloning_replaceByUnite( resolve.head, reflectorResolve_body );

reflectorResolve_body.defaults = _.will.Module.prototype.reflectorResolve.defaults;
let reflectorResolve = _.routine.uniteReplacing( resolve.head, reflectorResolve_body );
_.assert( reflectorResolve.defaults === reflectorResolve.defaults.Seeker );
// let reflectorResolve = _.routine.uniteCloning_replaceByUnite({ head : resolve.head, body : reflectorResolve_body, strategy : 'replacing' });

// --
// etc
// --

function pathRebase( o )
{
  let resource = this;
  let module = resource.module;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  // let Resolver = _.will.resolver;

  o = _.routine.options_( pathRebase, arguments );

  if( o.filePath )
  if( path.isRelative( o.filePath ) )
  {
    if( _.will.resolver.Resolver.selectorIs( o.filePath ) )
    {
      let filePath2 = _.will.resolver.Resolver.selectorNormalize( o.filePath );
      if( _.strBegins( filePath2, '{' ) )
      return o.filePath;
      o.filePath = filePath2;
    }
    return path.relative( o.inPath, path.join( o.exInPath, o.filePath ) );
  }

  return o.filePath;
}

pathRebase.defaults =
{
  filePath : null,
  exInPath : null,
  inPath : null,
}

// --
// relations
// --

let willfSymbol = Symbol.for( 'willf' );
let moduleSymbol = Symbol.for( 'module' );

let Composes =
{

  description : null,
  criterion : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
  writable : 1,
  exportable : 1,
  importableFromIn : 1,
  importableFromOut : 1,
  importableFromPeer : 0,
  // generated : 0,
  phantom : false,
}

let Associates =
{
  willf : null,
  module : null,
  original : null,
}

let Medials =
{
}

let Restricts =
{
  id : null,
  formed : 0,
  inherited : 0,
  unformedResource : null,
}

let Statics =
{

  MakeFor,
  MakeForEachCriterion,
  MakeSingle,
  ResouceMapFrom,
  ResouceStructureFrom,

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
  importable : 'importable',
  generated : 'generated',
}

let Accessors =
{
  willf : { set : willfSet },
  qualifiedName : { get : qualifiedNameGet, writable : 0 },
  decoratedQualifiedName : { get : decoratedQualifiedNameGet, writable : 0 },
  refName : { get : _refNameGet, writable : 0 },
  absoluteName : { get : absoluteNameGet, writable : 0 },
  decoratedAbsoluteName : { get : decoratedAbsoluteNameGet, writable : 0 },
  inherit : { set : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
  module : {},
  // resolverModule : { get : toModuleForResolver, set : 0 },
}

// --
// declare
// --

let Extension =
{

  // inter

  MakeFor,
  MakeForEachCriterion,
  MakeSingle,
  ResouceMapFrom,
  ResouceStructureFrom,

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

  _exportString,
  exportString,
  exportStructure,
  extraExport,
  compactField,

  // accessor

  qualifiedNameGet,
  decoratedQualifiedNameGet,
  _refNameGet,
  absoluteNameGet,
  decoratedAbsoluteNameGet,
  shortNameArrayGet,
  willfSet,
  moduleSet,
  toModuleForResolver,

  // resolver

  resolve,
  inPathResolve,
  reflectorResolve,

  // etc

  pathRebase,

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
  extend : Extension,
  withMixin : 1,
  withClass : 1,
});

_.will[ Self.shortName ] = Self;

})();
