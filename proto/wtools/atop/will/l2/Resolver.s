( function _Resolver_s_()
{

'use strict';

const _ = _global_.wTools;
// let Parent = _.resolver;
const Parent = _.resolver2.Looker;
_.assert( !!_.resolver2.resolveQualified );
_.assert( !!_.resolver2.Looker.resolveQualified );
_.assert( !!_.resolver2.composite );
// const Self = Object.create( _.resolver2 );
_.will.Resolver = Object.create( _.resolver2 );;

// --
// relation
// --

let Defaults = _.mapExtend( null, Parent.resolveQualified.body.defaults );

Defaults.currentThis = null;
Defaults.currentContext = null;
Defaults.baseModule = null;
Defaults.criterion = null;
Defaults.pathResolving = 'in';
Defaults.pathNativizing = 0;
Defaults.pathUnwrapping = 1;
Defaults.strictCriterion = 0;
Defaults.currentExcluding = 1;
Defaults.hasPath = null;
Defaults.selectorIsPath = 0;

// --
// handler
// --

function _onSelectorReplicate( o )
{
  let it = this;
  let rop = it.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let selector = o.selector;

  let result = Parent._onSelectorReplicate.call( it, o );

  if( resolver._selectorIs( selector ) )
  return result;

  if( result === undefined && o.counter > 0 )
  return;

  if( rop.prefixlessAction === 'default' && !it.composite )
  {
    return selector;
  }
  else if( rop.prefixlessAction === 'resolved' || rop.prefixlessAction === 'default' )
  {
    if( rop.pathResolving )
    if( rop.defaultResourceKind === 'path' || rop.selectorIsPath )
    if( _.strIs( selector ) || _.arrayIs( selector ) )
    if( !resolver.selectorIs( selector ) )
    if( !it.composite )
    {
      selector = new _.will.PathResource({ module : rop.baseModule, name : null, phantom : 1, path : selector });
      selector.form1();
      debugger; /* yyy */
      it.src = selector;
    }
  }

  return result;
}

//

function _onSelectorDown()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let rop = it.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;

  // debugger; /* yyy */

  if( it.continue && _.arrayIs( it.dst ) && it.src.composite === _.resolver2.composite )
  {

    for( let d = 0 ; d < it.dst.length ; d++ )
    {
      if( it.dst[ d ] && it.dst[ d ] instanceof _.will.PathResource )
      it.dst[ d ] = it.dst[ d ].path;
      if( _.errIs( it.dst[ d ] ) )
      throw it.dst[ d ];
    }

    it.dst = _.strJoin( it.dst );

    if( rop.defaultResourceKind === 'path' || rop.selectorIsPath )
    {
      it.dst = new _.will.PathResource({ module : rop.baseModule, name : null, phantom : 1, path : it.dst });
      it.dst.form1();
    }

    it.src.composite = null;

  }

  if( !it.dstWritingDown )
  return end();

  resolver._pathPerform.call( it );

  return end();

  function end()
  {
    return Parent._onSelectorDown.call( it );
  }

}

//

function _onUpBegin()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;

  resolver._statusPreUpdate.call( it );
  resolver._globCriterionFilter.call( it );

  if( !it.dstWritingDown )
  return;

  /*
  _resourceMapSelect, _statusPostUpdate should go after _queryParse
  */

  resolver._queryParse.call( it );
  resolver._resourceMapSelect.call( it );
  resolver._statusPostUpdate.call( it );

}

//

function _onUpEnd()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;

  if( !it.dstWritingDown )
  return;

  resolver._exportedWriteThrough.call( it );
  resolver._currentExclude.call( it );

  if( !it.dstWritingDown )
  return;

  resolver._pathsCompositeResolve.call( it );

}

//

function _onDownEnd()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;

  if( !it.dstWritingDown )
  return;

  resolver._pathPerform.call( it );

  return Parent._onDownEnd.call( it );
}

//

function _onQuantitativeFail( err )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let dst = it.dst;

  if( _.mapIs( dst ) )
  dst = _.mapVals( dst );

  if( _.arrayIs( dst ) )
  {

    /* is string */

    let isString = 1;
    if( dst.every( ( e ) => _.strIs( e ) ) )
    isString = 1;
    else
    dst = dst.map( ( e ) =>
    {
      if( _.strIs( e ) )
      return e;
      if( _.strIs( e.qualifiedName ) )
      return e.qualifiedName;
      isString = 0
    });

    if( rop.criterion )
    err = _.err( err, '\nCriterions :\n', _.entity.exportString( rop.criterion, { wrap : 0, levels : 4, stringWrapper : '', multiline : 1 } ) );

    /* found */

    if( isString )
    if( dst.length )
    err = _.err( err, '\n', 'Found : ' + dst.join( ', ' ) );
    else
    err = _.err( err, '\n', 'Found nothing' );

    /* information about outdated status of the module */

    if( rit.currentModule.peerModuleIsOutdated )
    if
    (
         ( it.parsedSelector && it.parsedSelector.kind === 'exported' )
      || ( it.down && it.down.parsedSelector && it.down.parsedSelector.kind === 'module' )
      || ( it.down && it.down.parsedSelector && it.down.parsedSelector.kind === 'submodule' )
    )
    {
      let willfile = rit.currentModule.willfilesArray[ 0 ];
      let storagePath = willfile ? willfile.storagePath : '';
      if( willfile )
      err = _.err
      (
        err,
        `\n${ rit.currentModule.decoratedAbsoluteName } loaded from `
        + `${ willfile.storageWillfile.openedModule.decoratedAbsoluteName } is outdated!`,
        `\nPlease re-export ${ _.ct.format( storagePath, 'path' ) } first.`
      );
      else
      err = _.err
      (
        err,
        `\n${ rit.currentModule.decoratedAbsoluteName } is outdated!`,
        `\nPlease re-export it first.`
      );
    }

    /* bried */

    err = _.errBrief( err );
  }

  throw err;
}

// --
//
// --

function _statusPreUpdate()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let will = rop.baseModule.will;

  // debugger; /* yyy */
  if( !it.src )
  return;

  _.assert( !_.mapOwn( it.src, 'composite' ) );

  if( it.down && it.down.src && it.down.src instanceof _.will.ModulesRelation )
  {
    _.assert( it.src instanceof _.will.Module )
    let valid = it.src.isValid();
    if( !valid )
    throw _.errBrief
    (
      `Cant select in non-valid submodules.`,
      `\n ${it.src.absoluteName} is not opened or invalid`
    );
  }

  if( it.src instanceof _.will.Module )
  {
    // debugger; /* xxx : should selector iteration have individual currentModule? */
    rit.currentModule = it.src;
    // it.currentModule = it.src;
  }
  else if( it.src instanceof _.will.ModulesRelation )
  {
    _.sure( !!it.src.opener, `${it.src.decoratedAbsoluteName} is not formed` );
    _.sure( !it.selector || !!it.src.opener.openedModule, `${it.src.decoratedAbsoluteName} is not opened` );

    let opener = it.src.opener;
    let module2;

    if( opener.isOut )
    module2 = opener.openedModule;
    else
    module2 = opener.peerModule;

    if( !module2 ) /* yyy */
    module2 = opener.openedModule;

    if( !module2 )
    {
      if( it.selector !== undefined )
      throw _.err( `Out-willfile of ${it.src.decoratedAbsoluteName} is not opened or does not exist` );
      else
      module2 = rit.currentModule;
      // module2 = it.currentModule;
    }

    rit.currentModule = module2;
    // it.currentModule = module2;
  }
  else if( it.src instanceof _.will.Exported )
  {
    it.exported = it.src;
  }

}

//

function _statusPostUpdate()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let will = rop.baseModule.will;

  if( rop.selectorIsPath )
  it.selectorIsPath = 1;

  if( it.parsedSelector )
  {
    let kind = it.parsedSelector.kind;

    if( kind === 'path' && rop.hasPath === null )
    rop.hasPath = true;

    if( kind === 'path' )
    it.selectorIsPath = 1;

  }

}

//

function _globCriterionFilter()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let will = rop.baseModule.will;

  if( it.down && it.down.isGlob )
  if( rop.criterion && it.src && it.src.criterionSattisfy )
  {

    let s = rop.strictCriterion ? it.src.criterionSattisfyStrict( rop.criterion ) : it.src.criterionSattisfy( rop.criterion );

    if( !s )
    {
      it.continue = false;
      it.dstWritingDown = false;
    }

  }

}

//

function _resourceMapSelect()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( it.selector === undefined || it.selector === null )
  return;

  let kind = it.parsedSelector.kind;

  if( kind === '' || kind === null )
  {
  }
  else if( kind === 'f' )
  {

    it.isFunction = it.selector;
    if( it.selector === 'strings.join' )
    {
      resolver._functionStringsJoinUp.call( it );
    }
    else if( it.selector === 'os' )
    {
      resolver._functionOsGetUp.call( it );
    }
    else if( it.selector === 'this' )
    {
      resolver._functionThisUp.call( it );
    }
    else _.sure( 0, 'Unknown function', it.parsedSelector.full );

  }
  else
  {

    // debugger;
    it.src = rit.currentModule.resourceMapsForKind( kind ); /* zzz : write result of selection to dst, never to src */

    if( _.strIs( kind ) && path.isGlob( kind ) )
    {
      it.selectorArray.splice( it.absoluteLevel, 1, '*', it.selector );
      it.selector = it.selectorArray[ it.absoluteLevel ];
      _.assert( it.selector !== undefined );
      it.iterationSelectorChanged();
    }

    if( !it.src )
    {
      debugger;
      throw _.ErrorLooking( 'No resource map', _.strQuote( it.parsedSelector.full ) );
    }

    it.iterable = null;
    it.srcChanged();
  }

}

//

function _exportedWriteThrough()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;

  if( it.down && it.parsedSelector && it.parsedSelector.kind === 'exported' )
  {
    let dstWriteDownOriginal = it.dstWriteDown;
    it.dstWriteDown = function writeThrough( eit )
    {
      let r = dstWriteDownOriginal.apply( this, arguments );
      return r;
    }
  }

}

//

function _currentExclude()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;

  // debugger; /* yyy */
  if( rop.currentExcluding )
  if( it.src === rop.currentContext && it.down )
  it.dstWritingDown = false;

}

//

function _select( visited )
{
  let it = this;

  _.assert( !_.property.own( it, 'criterion' ) );

  let it2 = Parent._select.apply( this, arguments );

  _.assert( it2 !== it );
  // _.assert( it2.criterion === undefined ); /* xxx : uncomment */
  _.assert( it._onUpBegin === Self._onUpBegin );
  _.assert( it.onUpBegin === Self._onUpBegin );
  _.assert( it2._onUpBegin === Self._onUpBegin );
  _.assert( it2.onUpBegin === Self._onUpBegin );

  return it2;
}

//

function resolveContextPrepare( o )
{
  let resolver = this;
  _.assert( !!o.baseModule );
  let will = o.baseModule.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.routineOptions( resolveContextPrepare, arguments );

  if( !o.currentThis )
  {
    if( !o.force )
    return o.currentThis;
    debugger;
    o.currentThis = o.currentContext;
  }

  if( o.currentThis instanceof _.will.Reflector )
  {
    let currentThis = Object.create( null );
    currentThis.src = [];
    currentThis.dst = [];
    let o2 = o.currentThis.optionsForFindGroupExport();
    o2.outputFormat = 'absolute';
    let found = fileProvider.filesFindGroups( o2 );
    currentThis.filesGrouped = found.filesGrouped;
    for( let dst in found.filesGrouped )
    {
      currentThis.dst.push( hardDrive.path.nativize( dst ) );
      currentThis.src.push( hardDrive.path.s.nativize( found.filesGrouped[ dst ] ).join( ' ' ) );
    }
    o.currentThis = currentThis;
  }

  if( _.mapIs( o.currentThis ) )
  {
  }
  else if( o.currentThis instanceof _.will.Resource )
  {
    o.currentThis = o.currentThis.exportStructure();
  }
  else _.assert( 0 );

  return o.currentThis;
}

resolveContextPrepare.defaults =
{
  currentThis : null,
  currentContext : null,
  baseModule : null,
  force : 0,
}

// --
// path
// --

function _pathPerform()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;

  if( !it.dstWritingDown )
  return;

  if( rop.pathResolving || it.isFunction )
  resolver._pathsResolve.call( it );

  resolver._pathsNormalize.call( it );

  if( rop.pathNativizing || it.isFunction )
  resolver._pathsNativize.call( it );

  resolver._pathsUnwrap.call( it );

}

//

function _pathsTransform( onPath, onStr )
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let resource = it.dst;
  let transform = rop.preservingIteration ? wrapTransform : elementTransform;

  it.dst = transform( it.dst );

  /* */

  function wrapTransform( resource )
  {
    if( _.prototype.isPrototypeFor( _.Looker, resource ) )
    {
      resource.dst = elementTransform( resource.dst );
    }
    return elementTransform( resource );
  }

  /* */

  function elementTransform( resource )
  {
    if( !resource )
    return resource;
    if( _.strIs( resource ) && onStr )
    return onStr.call( it, resource );
    if( resource instanceof _.will.PathResource )
    return resourceTransform( resource );
    if( _.arrayIs( resource ) || _.mapIs( resource ) )
    return resourcesTransform( resource );
    return resource;
  }

  /* */

  function resourcesTransform( resources )
  {
    resources = _.map_( null, resources, ( resource ) => transform( resource ) );
    return resources;
  }

  /* */

  function resourceTransform( resource )
  {
    resource = resource.cloneDerivative();
    _.assert( resource.path === null || _.arrayIs( resource.path ) || _.strIs( resource.path ) );
    return onPath.call( it, resource.path, resource );
    return resource;
  }

  /* */

}

//

function _pathsNormalize()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let resource = it.dst;

  resolver._pathsTransform.call( it, ( filePath, resource ) =>
  {
    resource.path = resolver._pathNormalize.call( it, filePath, resource )
    return resource;
  });

}

//

function _pathNormalize( filePath, resource )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = rit.currentModule;
  let path = will.fileProvider.providersWithProtocolMap.file.path;
  let result = filePath;

  if( filePath === null || filePath === '' )
  return result;

  _.assert( _.strIs( result ) || _.strsAreAll( result ) );

  if( _.arrayIs( filePath ) )
  {
    return filePath.map( ( e ) => normalize( e ) );
  }
  else
  {
    return normalize( filePath );
  }

  function normalize( filePath )
  {
    return path.undot( filePath );
  }

}

//

function _pathsNativize()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let resource = it.dst;

  if( !rop.pathNativizing )
  return;

  resolver._pathsTransform.call( it, handleResource, handleStr );

  function handleResource( filePath, resource )
  {
    resource.path = resolver._pathNativize.call( it, filePath, resource )
    return resource;
  }

  function handleStr( str )
  {
    return str;
  }

}

//

function _pathNativize( filePath, resource )
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = rit.currentModule;
  let path = will.fileProvider.providersWithProtocolMap.file.path;
  let result = filePath;

  if( filePath === null || filePath === '' )
  return result;

  _.assert( _.strIs( result ) || _.strsAreAll( result ) );

  if( _.arrayIs( filePath ) )
  {
    return filePath.map( ( e ) => nativize( e ) );
  }
  else
  {
    return nativize( filePath );
  }

  function nativize( filePath )
  {
    if( path.isGlobal( filePath ) )
    return filePath
    else
    return path.nativize( filePath );
  }

}

//

function _pathCompositeResolve( /* currentModule, currentResource, filePath, resolving */ )
{
  let currentModule = arguments[ 0 ];
  let currentResource = arguments[ 1 ];
  let filePath = arguments[ 2 ];
  let resolving = arguments[ 3 ];

  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let result = filePath;

  _.assert( _.strIs( result ) || _.strsAreAll( result ) );
  _.assert( arguments.length === 4 );

  if( resolver.selectorIsComposite( result ) )
  {

    result = currentModule.pathResolve
    ({
      selector : result,
      visited : _.arrayFlatten( null, [ rop.visited, result ] ),
      pathResolving : resolving ? rop.pathResolving : 0,
      currentContext : currentResource,
      pathNativizing : rop.pathNativizing,
      missingAction : rop.missingAction,
    });

  }

  return result;
}

//

function _pathsCompositeResolve()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = rit.currentModule;
  let resource = it.dst;

  if( resource instanceof _.will.Reflector )
  {
    if( resolver.selectorIsComposite( resource.src.prefixPath ) || resolver.selectorIsComposite( resource.dst.prefixPath ) )
    {
      resource = it.dst = resource.cloneDerivative();
      if( resource.src.prefixPath )
      resource.src.prefixPath = _pathCompositeResolve.call( it, currentModule, resource, resource.src.prefixPath, 'in' );
      if( resource.dst.prefixPath )
      resource.dst.prefixPath = _pathCompositeResolve.call( it, currentModule, resource, resource.dst.prefixPath, 'in' );
    }
  }

  if( resource instanceof _.will.PathResource )
  {
    if( resolver.selectorIsComposite( resource.path ) )
    {
      resource = it.dst = resource.cloneDerivative();
      resource.path = _pathCompositeResolve.call( it, currentModule, resource, resource.path, 'in' );
    }
  }

}

//

function _pathResolve( filePath, resource )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions; /* yyy */
  // let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration;
  _.assert( !!rop );
  _.assert( rit.Looker === rit.ResolverReplicator );
  _.assert( rop === rit.iterator );
  _.assert( rit.baseModule !== undefined );
  // _.assert( rit.baseModule === undefined );
  _.assert( rit.currentModule !== undefined );
  _.assert( rop.baseModule !== undefined );
  _.assert( rop.currentModule !== undefined );
  // _.assert( rop.currentModule === undefined );
  _.assert( rit.currentModule !== undefined );
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = rit.currentModule || rop.baseModule;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let resourceName = resource.name;
  let result = filePath;

  if( _.mapIs( filePath ) )
  debugger;

  if( filePath === null || filePath === '' )
  return result;

  _.assert( rit.composite !== undefined );
  _.assert( !!currentModule );

  if( _.arrayIs( filePath ) )
  filePath = _.arrayFlattenOnce( filePath );

  if( _.errIs( filePath ) )
  {
    if( rop.missingAction === 'error' )
    return filePath;
    else
    throw filePath;
  }
  else if( _.arrayIs( filePath ) )
  for( let f = 0 ; f < filePath.length ; f++ )
  if( _.errIs( filePath[ f ] ) )
  {
    if( rop.missingAction === 'error' )
    return filePath[ f ];
    else
    throw filePath[ f ];
  }

  _.assert( _.strIs( filePath ) || _.strsAreAll( filePath ) );

  if( rit.composite )
  if( rit.compositeRoot !== rit )
  if( rit.compositeRoot === rit.down )
  {
    if( rit.key !== 0 )
    return result;
  }

  currentModule = resource.module;

  let prefixPath = '.';
  if( rop.pathResolving === 'in' )
  {
    if( resourceName !== 'in' )
    prefixPath = currentModule.inPath || '.';
    else
    prefixPath = currentModule.dirPath;
  }
  else if( rop.pathResolving === 'out' )
  {
    if( resourceName !== 'out' )
    prefixPath = currentModule.outPath || '.';
    else
    prefixPath = currentModule.dirPath;
  }

  if( resolver.selectorIs( prefixPath ) )
  prefixPath = currentModule.pathResolve({ selector : prefixPath, currentContext : it.dst });
  if( resolver.selectorIs( result ) )
  result = currentModule.pathResolve({ selector : result, currentContext : it.dst });

  result = path.s.join( prefixPath, result );

  return result;
}

//

function _pathsResolve()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = rit.currentModule;
  let resource = it.dst;

  resolver._pathsTransform.call( it, ( filePath, resource ) =>
  {
    resource.path = resolver._pathResolve.call( it, filePath, resource )
    return resource;
  });

}

//

function _pathsUnwrap()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = rit.currentModule;

  resolver._pathsTransform.call( it, unwrap );

  function unwrap( filePath, resource )
  {
    let result = resource;

    if( !rop.pathUnwrapping && !resource.phantom )
    return result;

    result = result.path;

    if( resource.phantom )
    {
      if( resource.original )
      resource.original.finit();
      resource.finit();
    }

    return result;
  }

}

// --
// function
// --

function _functionOsGetUp()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let will = rop.baseModule.will;
  let Os = require( 'os' );
  let os = 'posix';

  if( Os.platform() === 'win32' )
  os = 'windows';
  else if( Os.platform() === 'darwin' )
  os = 'osx';

  debugger; /* yyy */
  it.isFunction = it.selector;
  it.src = os;
  it.dst = os;
  it.selector = undefined;
  it.iterable = null;
  it.iterationSelectorChanged();
  it.srcChanged();
}

//

function _functionThisUp()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentThis = rop.currentThis;

  if( currentThis === null )
  currentThis = resolver.resolveContextPrepare
  ({
    baseModule : rop.baseModule,
    currentThis,
    currentContext : rop.currentContext,
    force : 1,
  });

  it.isFunction = it.selector;
  debugger; /* yyy */
  it.src = [ currentThis ]; /* zzz : write result of selection to dst, never to src? */
  it.selector = 0;
  it.iterable = null;
  it.iterationSelectorChanged();
  it.srcChanged();
}

//

function _functionStringsJoinDown()
{
  let it = this;
  let rop = it.resolveExtraOptions ? it.resolveExtraOptions : it.replicateIteration.resolveExtraOptions;
  let resolver = rop.Resolver;

  // debugger; /* yyy */
  if( !_.arrayIs( it.src ) || !it.src[ functionSymbol ] )
  return;

  return Parent._functionStringsJoinDown.call( it );
}

// --
// err
// --

function errResolving( o )
{
  let resolver = this;
  let module = o.rop.baseModule;
  _.assertRoutineOptions( errResolving, arguments );
  _.assert( arguments.length === 1 );
  if( o.rop.currentContext && o.rop.currentContext.qualifiedName )
  return _.err( o.err, '\nFailed to resolve', _.color.strFormat( _.entity.exportStringShort( o.selector ), 'path' ), 'for', o.rop.currentContext.decoratedAbsoluteName );
  else
  return _.err( o.err, '\nFailed to resolve', _.color.strFormat( _.entity.exportStringShort( o.selector ), 'path' ), 'in', module.decoratedAbsoluteName );
}

errResolving.defaults =
{
  selector : null,
  rop : null,
  err : null,
}

// --
// resolve
// --

function resolve_head( routine, args )
{
  return Self.head( routine, args );
}

//

function resolve_body( it )
{
  it.perform();
  return it.result;
}

var defaults = resolve_body.defaults = Defaults

let resolve = _.routineUnite( resolve_head, resolve_body );
let resolveMaybe = _.routineUnite( resolve_head, resolve_body );

var defaults = resolveMaybe.defaults;
defaults.missingAction = 'undefine';

//

function head( routine, args )
{
  _.assert( arguments.length === 2 );
  let o = Self.optionsFromArguments( args );
  if( _.routineIs( routine ) )
  o.Looker = o.Looker || routine.defaults.Looker || Self;
  else
  o.Looker = o.Looker || routine.Looker || Self;
  if( _.routineIs( routine ) ) /* zzz : remove "if" later */
  _.routineOptionsPreservingUndefines( routine, o );
  else
  _.routineOptionsPreservingUndefines( null, o, routine );
  o.Looker.optionsForm( routine, o );
  o.optionsForSelect = o.Looker.optionsForSelectFrom( o );
  let it = o.Looker.optionsToIteration( o );
  return it;
}

//

function perform()
{
  let it = this;
  // let resolver = this; /* xxx */
  let module = it.baseModule;
  let will = module.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let currentContext = it.currentContext = it.currentContext || module;

  // debugger; /* yyy */
  // _.assert( it.src instanceof _.will.Module );
  // _.assert( _.strIs( it.src ) || _.vectorIs( it.src ) );
  _.assert( it.srcForSelect instanceof _.will.Module );

  it.iterator.currentThis = it.resolveContextPrepare
  ({
    currentThis : it.currentThis,
    currentContext : it.currentContext,
    baseModule : it.baseModule,
  });
  _.assert( !_.property.own( it, 'currentThis' ) );

  /* */

  // let resolver = this;
  // let module = it.baseModule;
  // let will = module.will;
  // let currentContext = it.currentContext;
  let result;

  _.assert( it.iterationProper( it ) );
  if( !( it.currentContext instanceof _.will.AbstractModule ) )
  if( it.iterator.criterion === null && it.currentContext && it.currentContext.criterion )
  it.iterator.criterion = it.currentContext.criterion;

  _.assert( it.criterion === null || _.mapIs( it.criterion ) );
  _.assert( it.baseModule instanceof _.will.AbstractModule );
  _.assert( !_.property.own( it, 'criterion' ) );

  /* */

  // let iterator = Object.create( null );
  // let iterationPreserve = Object.create( null );
  // iterationPreserve.exported = null;
  // iterationPreserve.currentModule = it.baseModule;
  // // iterationPreserve.currentModule = null;
  // iterationPreserve.selectorIsPath = 0;
  // it.Looker = _.looker.define({ iterationPreserve, iterator, parent : it.Looker || _.Resolver, name : 'ResolverWillbe' }); /* yyy : use predefined Looker */
  // it.Looker = ResolverWillbe;

  _.assert( it.Looker === ResolverWillbe );
  _.assert( it.Looker.Iteration.currentModule !== undefined );
  _.assert( it.Looker.IterationPreserve.currentModule !== undefined );

  /* */

  // return Parent.resolveQualified.body.call( resolver, it );

  Parent.perform.apply( this, arguments );

  return it;
}

//

function optionsForm( routine, o )
{
  if( o.Resolver === null || o.Resolver === undefined )
  o.Resolver = Self;

  /* qqq : convert to template-string please in all files */
  _.assert( _.longHas( [ null, 0, false, 'in', 'out' ], o.pathResolving ), () => 'Unknown value of option path resolving ' + o.pathResolving );
  _.assert( !o.defaultResourceKind || !_.path.isGlob( o.defaultResourceKind ), () => 'Expects non glob {-defaultResourceKind-}, but got ' + _.strQuote( o.defaultResourceKind ) );
  _.assert( o.baseModule !== undefined );

  /* yyy */
  if( o.src === null )
  o.src = o.baseModule;

  Parent.optionsForm.call( this, routine, o );

  // Parent.resolveQualified.head.call( resolver, routine, args );

  return o;
}

//

function optionsToIteration( o )
{
  let it = Parent.optionsToIteration.call( this, o );
  _.assert( !!Self.ResolverSelector );
  _.assert( it.ResolverSelector === Self.ResolverSelector );
  _.assert( it.Looker.ResolverSelector === Self.ResolverSelector );
  // _.assert( it.Looker.ResolverSelector.currentThis === null );
  return it;
}

// --
// wraps
// --

let resolveRaw = _.routineUnite( resolve_head, resolve_body );

var defaults = resolveRaw.defaults;
defaults.pathResolving = 0;
defaults.pathNativizing = 0;
defaults.pathUnwrapping = 0;
defaults.singleUnwrapping = 0;
defaults.mapValsUnwrapping = 0;
defaults.mapFlattening = 0;
defaults.arrayWrapping = 0;
defaults.arrayFlattening = 0;
defaults.missingAction = 'undefine';

/*
missingAction should be 'undefine'
alternatively adjust call from finit of class Exported
*/

//

let pathResolve = _.routineUnite( resolve_head, resolve_body );

var defaults = pathResolve.defaults;
defaults.pathResolving = 'in';
defaults.prefixlessAction = 'resolved';
defaults.arrayFlattening = 1;
defaults.selectorIsPath = 1;
defaults.mapValsUnwrapping = 1;

defaults.defaultResourceKind = 'path'; /* yyy */
_.assert( pathResolve.defaults.defaultResourceKind === 'path' );

//

function pathOrReflectorResolve_head( routine, args )
{
  let o = args[ 0 ];
  let module = o.baseModule;
  let will = module.will;
  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.aux.is( o ) );
  _.routineOptions( routine, o );
  return o;
}

function pathOrReflectorResolve_body( o )
{
  let resolver = this;
  let module = o.baseModule;
  let will = module.will;
  let resource;

  _.assert( _.aux.is( o ) );
  _.assertRoutineOptions( pathOrReflectorResolve_body, arguments );
  _.assert( !resolver.selectorIs( o.selector ) );
  _.assert( o.pathResolving === 'in' );
  _.assert( !o.pathUnwrapping );

  let o2 = _.mapExtend( null, o );
  o2.missingAction = 'undefine';
  o2.selector = 'reflector::' + o.selector;
  resource = module.reflectorResolve( o2 );

  if( resource )
  return resource;

  let o3 = _.mapExtend( null, o );
  o3.missingAction = 'undefine';
  o3.selector = 'path::' + o.selector;
  resource = module.reflectorResolve( o3 );

  return resource;
}

var defaults = pathOrReflectorResolve_body.defaults = Object.create( resolve_body.defaults );

defaults.pathResolving = 'in';
defaults.missingAction = 'undefine';
defaults.pathUnwrapping = 0;

let pathOrReflectorResolve = _.routineUnite( pathOrReflectorResolve_head, pathOrReflectorResolve_body );

//

function filesFromResource_head( routine, args )
{
  let resolver = this;
  let o =_.routineOptions( routine, args );

  let prefixlessAction = o.prefixlessAction;
  if( prefixlessAction === 'pathOrReflector' )
  o.prefixlessAction = 'resolved';

  resolve_head.call( resolver, routine, [ o ] );

  if( prefixlessAction === 'pathOrReflector' )
  o.prefixlessAction = prefixlessAction;

  return o;
}

function filesFromResource_body( o )
{
  let module = o.baseModule;
  let will = module.will;
  let result = [];
  let fileProvider = will.fileProvider
  let path = fileProvider.path;
  let resources;

  if( o.prefixlessAction === 'pathOrReflector' )
  {
    let o2 = _.mapOnly( o, module.resolve.defaults );
    o2.prefixlessAction = 'default';
    o2.missingAction = 'undefine';
    o2.defaultResourceKind = 'path';
    resources = module.resolve( o2 );
    if( !resources )
    {
      let o2 = _.mapOnly( o, module.resolve.defaults );
      o2.prefixlessAction = 'default';
      o2.missingAction = 'undefine';
      o2.defaultResourceKind = 'reflector';
      resources = module.resolve( o2 );
    }

    if( resources === undefined )
    {
      let err = _.err( `No path::${o.selector}, neither reflecotr::${o.selector} exists` );
      if( o.missingAction === 'throw' )
      throw err;
      else if( o.missingAction === 'error' )
      return err;
      else
      return undefined;
    }

  }
  else
  {
    let o2 = _.mapOnly( o, module.resolve.defaults );
    resources = module.resolve( o2 );
  }

  if( _.arrayIs( resources ) )
  resources.forEach( ( resource ) => resourceHandle( resource ) );
  else
  resourceHandle( resources );

  return result;

  function resourceHandle( resource )
  {

    if( resource === null )
    {
    }
    else if( resource instanceof _.will.Reflector )
    {
      let o2 = resource.optionsForFindExport();
      let files = filesFind( o2 );
      filesAdd( files );
    }
    else if( _.strIs( resource ) || _.arrayIs( resource ) || _.mapIs( resource ) )
    {
      if( o.globOnly )
      if( _.strIs( resource ) )
      _.sure( path.isGlob( resource ), `${resource} is not glob. Only glob allowed` );
      let o2 = Object.create( null );
      o2.filter = Object.create( null );
      o2.filter.filePath = resource;
      let files = filesFind( o2 );
      filesAdd( files );
    }
    else _.assert( 0, 'Unknown type of resource ' + _.entity.strType( resource ) );

  }

  function filesFind( o2 )
  {
    o2.outputFormat = 'absolute';
    o2.mode = 'distinct';
    if( o.withDirs !== null )
    o2.withDirs = o.withDirs;
    if( o.withTerminals !== null )
    o2.withTerminals = o.withTerminals;
    if( o.withStem !== null )
    o2.withStem = o.withStem;
    let files = fileProvider.filesFind( o2 );
    return files;
  }

  function filesAdd( files )
  {
    _.arrayAppendArrayOnce( result, files );
  }

}

var defaults = filesFromResource_body.defaults = Object.create( resolve.defaults );
defaults.selector = null;
defaults.prefixlessAction = 'resolved';
defaults.currentContext = null;
defaults.pathResolving = 'in';
defaults.pathNativizing = 0;
defaults.selectorIsPath = 1;
defaults.pathUnwrapping = 1;

defaults.globOnly = 0;
defaults.withDirs = null;
defaults.withTerminals = null;
defaults.withStem = null;

let filesFromResource = _.routineUnite( filesFromResource_head, filesFromResource_body );

//

function reflectorResolve_head( routine, args )
{
  let o = args[ 0 ];
  let module = o.baseModule;
  let will = module.will;
  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.aux.is( o ) );

  o.pathResolving = 'in';

  let it = resolve_head.call( this, routine, [ o ] );

  return it;
}

function reflectorResolve_body( o )
{
  let module = o.baseModule;
  let will = module.will;

  // let o2 = _.mapExtend( null, o );
  // o2.pathResolving = 'in';
  // let reflector = module.resolve( o2 );
  /* yyy */

  _.assert( _.looker.iterationIs( o ) );
  _.assert( o.pathResolving === 'in' );

  // debugger;
  let reflector = module.resolve.body.call( module, o );
  // debugger;

  /*
    `pathResolving` should be `in` for proper resolving of external resources
  */

  if( o.missingAction === 'undefine' && reflector === undefined )
  return reflector;
  else if( o.missingAction === 'error' && _.errIs( reflector ) )
  return reflector;

  if( reflector instanceof _.will.Reflector )
  {
    _.sure( reflector instanceof _.will.Reflector, () => 'Reflector ' + o.selector + ' was not found' + _.entity.strType( reflector ) );
    reflector.form();
    _.assert( reflector.formed === 3, () => reflector.qualifiedName + ' is not formed' );
  }

  return reflector;
}

var defaults = reflectorResolve_body.defaults = Object.create( resolve.defaults );
defaults.selector = null;
defaults.defaultResourceKind = 'reflector';
defaults.prefixlessAction = 'default';
defaults.currentContext = null;
defaults.pathResolving = 'in';

let reflectorResolve = _.routineUnite( reflectorResolve_head, reflectorResolve_body );
// let reflectorResolve = _.routineUnite( resolve_head, reflectorResolve_body );

//

function submodulesResolve_body( o )
{
  let module = o.baseModule;
  let will = module.will;

  let result = module.resolve( o );

  return result;
}

var defaults = submodulesResolve_body.defaults = Object.create( resolve.defaults );
defaults.selector = null;
defaults.prefixlessAction = 'default';
defaults.defaultResourceKind = 'submodule';

let submodulesResolve = _.routineUnite( resolve.head, submodulesResolve_body );

//

function _iterator_functor()
{

  _.assert( !!_.resolver2.ResolverExtraSelector );
  let ResolverWillbeSelector = _.looker.define
  ({
    name : 'ResolverWillbeSelector',
    parent : _.resolver2.ResolverExtraSelector,
    defaults :
    {

      defaultResourceKind : null,
      prefixlessAction : null,
      singleUnwrapping : null,
      mapValsUnwrapping : null,
      mapFlattening : null,
      arrayWrapping : null,
      arrayFlattening : null,
      Resolver : null,

      // currentThis : null,
      // currentContext : null,
      // baseModule : null,
      // criterion : null,
      // pathResolving : null,
      // pathNativizing : null,
      // pathUnwrapping : null,
      // strictCriterion : null,
      // currentExcluding : null,
      // hasPath : null,
      // selectorIsPath : null,

      ... Defaults,
    },
    looker :
    {
      ... Common,
    },
  });

  /* */

  _.assert( !!_.resolver2.ResolverExtra );
  _.assert( _.resolver2.ResolverExtra.Iterator.resolveExtraOptions !== undefined );

  let ResolverWillbeReplicator = _.looker.define
  ({
    name : 'ResolverWillbeReplicator',
    parent : _.resolver2.ResolverExtra,
    defaults : Defaults, /* xxx */
    looker :
    {
      ... Common,

      resolve,
      resolveMaybe,
      head,
      perform,
      performMaking : resolve,
      optionsForm,
      optionsToIteration,

      // ResolverWillbeSelector : ResolverWillbeSelector,
      // ResolverSelector : ResolverWillbeSelector,
    },
    iterationPreserve :
    {
      exported : null,
      currentModule : null,
      selectorIsPath : 0,
    },
  });

  /* */

  _.assert( ResolverWillbeReplicator.Iterator.resolveExtraOptions !== undefined );
  // _.assert( ResolverWillbeReplicator.Looker.ResolverSelector === ResolverWillbeSelector );
  _.assert( ResolverWillbeReplicator.Looker === ResolverWillbeReplicator );

  ResolverWillbeReplicator.ResolverSelector = ResolverWillbeSelector;
  ResolverWillbeReplicator.ResolverReplicator = ResolverWillbeReplicator;
  ResolverWillbeSelector.ResolverSelector = ResolverWillbeSelector;
  ResolverWillbeSelector.ResolverReplicator = ResolverWillbeReplicator;

  // ResolverWillbeSelector.Looker.ResolverWillbeSelector = ResolverWillbeSelector;
  // ResolverWillbeSelector.Looker.ResolverExtraSelector = ResolverWillbeSelector;
  // ResolverWillbeSelector.Looker.ResolverSelector = ResolverWillbeSelector;
  // ResolverWillbeSelector.Looker.ResolverWillbe = ResolverWillbe;
  // ResolverWillbeSelector.Looker.ResolverExtra = ResolverWillbe; debugger;
  //
  // ResolverWillbe.Looker.ResolverWillbeSelector = ResolverWillbeSelector;
  // ResolverWillbe.Looker.ResolverSelector = ResolverWillbeSelector;
  // ResolverWillbe.Looker.ResolverWillbe = ResolverWillbe;
  // debugger;
  // ResolverWillbe.Looker.ResolverExtra = ResolverWillbe;

  // ResolverExtraReplicator.ResolverSelector = ResolverExtraSelector;
  // ResolverExtraReplicator.ResolverExtraSelector = ResolverExtraSelector;
  // ResolverExtraReplicator.ResolverExtra = ResolverExtraReplicator;
  // ResolverExtraReplicator.ResolverExtraReplicator = ResolverExtraReplicator;
  //
  // ResolverExtraSelector.ResolverSelector = ResolverExtraSelector;
  // ResolverExtraSelector.ResolverExtraSelector = ResolverExtraSelector;
  // ResolverExtraSelector.ResolverExtra = ResolverExtraReplicator;
  // ResolverExtraSelector.ResolverExtraReplicator = ResolverExtraReplicator;

  return ResolverWillbeReplicator;
}

// --
// declare
// --

let functionSymbol = Symbol.for( 'function' );
let Common =
{

  name : 'wWillResolver',
  shortName : 'Resolver',

  // handler

  _onSelectorReplicate,
  _onSelectorDown,
  _onUpBegin,
  _onUpEnd,
  _onDownEnd,
  _onQuantitativeFail,

  onSelectorReplicate : _onSelectorReplicate,
  onSelectorDown : _onSelectorDown,
  onUpBegin : _onUpBegin,
  onUpEnd : _onUpEnd,
  onDownEnd : _onDownEnd,
  onQuantitativeFail : _onQuantitativeFail,

  // etc

  _statusPreUpdate,
  _statusPostUpdate,
  _globCriterionFilter,
  _resourceMapSelect,

  _exportedWriteThrough,
  _currentExclude,
  _select,
  resolveContextPrepare,

  // path

  _pathPerform,
  _pathsTransform,
  _pathsNormalize,
  _pathNormalize,
  _pathsNativize,
  _pathNativize,
  _pathCompositeResolve,
  _pathsCompositeResolve,
  _pathResolve,
  _pathsResolve,
  _pathsUnwrap,

  // function

  _functionOsGetUp,
  _functionThisUp,
  _functionStringsJoinDown,

  // err

  errResolving,

  // wraps

  resolveRaw,
  pathResolve,
  pathOrReflectorResolve,
  filesFromResource,
  reflectorResolve,
  submodulesResolve,

}

//

const ResolverWillbe = _iterator_functor();
const Self = ResolverWillbe;

let Extension =
{

  ... _.resolver2,
  ... Common,

  Looker : ResolverWillbe,
  ResolverExtra : ResolverWillbe,
  ResolverWillbe,

  resolve,
  resolveMaybe,

}

_.mapExtend( _.will.Resolver, Extension );

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
