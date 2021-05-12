( function _Resolver_s_()
{

'use strict';

const _ = _global_.wTools;
const Parent = _.resolverAdv.Looker;
_.assert( !!_.resolverAdv.resolve );
_.assert( !_.resolverAdv.Looker.resolve );
_.assert( !!_.resolverAdv.Looker.exec );
_.assert( !!_.resolverAdv.compositeSymbol );
_.will.resolver = Object.create( _.resolverAdv );


// --
// relation
// --

let Prime = Object.create( null )

Prime.src = undefined;

Prime.currentThis = null;
Prime.currentContext = null;
Prime.baseModule = null;
Prime.criterion = null;
Prime.pathResolving = 'in';
Prime.pathNativizing = 0;
Prime.pathUnwrapping = 1;
Prime.strictCriterion = 0;
Prime.currentExcluding = 1;
Prime.hasPath = null;
Prime.selectorIsPath = 0;

Prime.onSelectorReplicate = _onSelectorReplicate;
Prime.onSelectorDown = _onSelectorDown;
Prime.onUpBegin = _onUpBegin;
Prime.onUpEnd = _onUpEnd;
Prime.onDownEnd = _onDownEnd;
Prime.onQuantitativeFail = _onQuantitativeFail;

// --
// handler
// --

function _onSelectorReplicate( o )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
  let selector = o.selector;

  let result = Parent._onSelectorReplicate.call( it, o );

  if( it._selectorIs( selector ) )
  return result;

  if( result === undefined && o.counter > 0 )
  return;

  if( rit.prefixlessAction === 'default' && !it.composite )
  {
    return selector;
  }
  else if( rit.prefixlessAction === 'resolved' || rit.prefixlessAction === 'default' )
  {
    if( rit.pathResolving )
    if( rit.defaultResourceKind === 'path' || rit.selectorIsPath )
    if( _.strIs( selector ) || _.arrayIs( selector ) )
    if( !it.selectorIs( selector ) )
    if( !it.composite )
    {
      selector = new _.will.PathResource({ module : rit.baseModule, name : null, phantom : 1, path : selector });
      selector.form1();
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
  let will = rit.baseModule.will;

  if( it.continue && _.arrayIs( it.dst ) && it.src.composite === _.resolverAdv.compositeSymbol )
  {

    for( let d = 0 ; d < it.dst.length ; d++ )
    {
      if( it.dst[ d ] && it.dst[ d ] instanceof _.will.PathResource )
      it.dst[ d ] = it.dst[ d ].path;
      if( _.errIs( it.dst[ d ] ) )
      throw it.dst[ d ];
    }

    it.dst = _.strJoin( it.dst );

    if( rit.defaultResourceKind === 'path' || rit.selectorIsPath )
    {
      it.dst = new _.will.PathResource({ module : rit.baseModule, name : null, phantom : 1, path : it.dst });
      it.dst.form1();
    }

    it.src.composite = null;

  }

  if( !it.dstWritingDown )
  return end();

  it._pathPerform();

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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;

  it._statusPreUpdate();
  it._globCriterionFilter();

  if( !it.dstWritingDown )
  return;

  /*
  _resourceMapSelect, _statusPostUpdate should go after _queryParse
  */

  it._queryParse();
  it._resourceMapSelect();
  it._statusPostUpdate();

}

//

function _onUpEnd()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;

  if( !it.dstWritingDown )
  return;

  it._exportedWriteThrough();
  it._currentExclude();

  if( !it.dstWritingDown )
  return;

  it._pathsCompositeResolve();

}

//

function _onDownEnd()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;

  if( !it.dstWritingDown )
  return;

  it._pathPerform();

  return Parent._onDownEnd.call( it );
}

//

function _onQuantitativeFail( err )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let dst = it.dst;
  let currentModule = it.currentModule || rit.currentModule;

  _.assert( rit !== it );

  if( _.mapIs( dst ) )
  dst = _.props.vals( dst );

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

    if( rit.criterion )
    err = _.err( err, '\nCriterions :\n', _.entity.exportString( rit.criterion, { wrap : 0, levels : 4, stringWrapper : '', multiline : 1 } ) );

    /* found */

    if( isString )
    if( dst.length )
    err = _.err( err, '\n', 'Found : ' + dst.join( ', ' ) );
    else
    err = _.err( err, '\n', 'Found nothing' );

    /* information about outdated status of the module */

    if( currentModule.peerModuleIsOutdated )
    if
    (
         ( it.parsedSelector && it.parsedSelector.kind === 'exported' )
      || ( it.down && it.down.parsedSelector && it.down.parsedSelector.kind === 'module' )
      || ( it.down && it.down.parsedSelector && it.down.parsedSelector.kind === 'submodule' )
    )
    {
      let willfile = currentModule.willfilesArray[ 0 ];
      let storagePath = willfile ? willfile.storagePath : '';
      if( willfile )
      err = _.err
      (
        err,
        `\n${ currentModule.decoratedAbsoluteName } loaded from `
        + `${ willfile.storageWillfile.openedModule.decoratedAbsoluteName } is outdated!`,
        `\nPlease re-export ${ _.ct.format( storagePath, 'path' ) } first.`
      );
      else
      err = _.err
      (
        err,
        `\n${ currentModule.decoratedAbsoluteName } is outdated!`,
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
  let will = rit.baseModule.will;

  if( !it.src )
  return;

  _.assert( it !== rit );
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
    // debugger;
    it.currentModule = it.src;
    // rit.currentModule = it.src;
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

    if( !module2 )
    module2 = opener.openedModule;

    if( !module2 )
    {
      if( it.selector !== undefined )
      throw _.err( `Out-willfile of ${it.src.decoratedAbsoluteName} is not opened or does not exist` );
      else
      module2 = it.currentModule;
      // module2 = rit.currentModule;
    }

    it.currentModule = module2;
    // rit.currentModule = module2;
  }
  else if( it.src instanceof _.will.Exported )
  {
    // debugger;
    it.exported = it.src;
  }

}

//

function _statusPostUpdate()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;

  if( rit.selectorIsPath )
  it.selectorIsPath = 1;

  if( it.parsedSelector )
  {
    let kind = it.parsedSelector.kind;

    if( kind === 'path' && rit.hasPath === null )
    rit.hasPath = true;

    if( kind === 'path' )
    it.selectorIsPath = 1;

  }

}

//

function _globCriterionFilter()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;

  if( it.down && it.down.selectorType === 'glob' )
  if( rit.criterion && it.src && it.src.criterionSattisfy )
  {

    let s = rit.strictCriterion ? it.src.criterionSattisfyStrict( rit.criterion ) : it.src.criterionSattisfy( rit.criterion );

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
  let will = rit.baseModule.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let currentModule = it.currentModule || rit.currentModule;

  _.assert( rit !== it );

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
      it._functionStringsJoinUp();
    }
    else if( it.selector === 'os' )
    {
      it._functionOsGetUp();
    }
    else if( it.selector === 'this' )
    {
      it._functionThisUp();
    }
    else _.sure( 0, 'Unknown function', it.parsedSelector.full );

  }
  else
  {

    it.src = currentModule.resourceMapsForKind( kind ); /* zzz : write result of selection to dst, never to src */

    if( _.strIs( kind ) && path.isGlob( kind ) )
    {
      // debugger; // xxx
      it.selectorArray.splice( it.absoluteLevel, 1, '*', it.selector );
      it.selector = it.selectorArray[ it.absoluteLevel ];
      _.assert( it.selector !== undefined );

      // it.iterationSelectorChanged();
      it.selectorType = null;
      // it.iterable = null;
      it.iterationSelectorChanged();
      // it.srcChanged();

    }

    if( !it.src )
    {
      debugger;
      throw _.looker.LookingError( 'No resource map', _.strQuote( it.parsedSelector.full ) );
    }

    it.iterable = null;
    it.srcChanged();
  }

}

//

function _exportedWriteThrough()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;

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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;

  if( rit.currentExcluding )
  if( it.src === rit.currentContext && it.down )
  it.dstWritingDown = false;

}

//

function _selectOptionsMake()
{
  let it = this;

  _.assert( arguments.length === 0 );

  let op = Parent._selectOptionsMake.call( it );

  op.currentModule = it.currentModule;

  return op;
}

//

function _select( visited )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;

  _.assert( !_.props.own( it, 'criterion' ) );

  let it2 = Parent._select.apply( this, arguments );

  _.assert( it2 !== it );
  _.assert( it2.criterion === undefined );
  _.assert( it._onUpBegin === Self._onUpBegin );
  _.assert( it.onUpBegin === Self._onUpBegin );
  _.assert( it2._onUpBegin === Self._onUpBegin );
  _.assert( it2.onUpBegin === Self._onUpBegin );

  return it2;
}

//

function сontextPrepare( o )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  _.assert( !!o.baseModule );
  let will = o.baseModule.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.routine.options( сontextPrepare, arguments );

  if( !o.currentThis )
  {
    if( !o.force )
    {
      _.assert( o.currentThis !== undefined );
      return o.currentThis;
    }
    _.assert( o.currentContext !== undefined );
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

  _.assert( o.currentThis !== undefined );
  return o.currentThis;
}

сontextPrepare.defaults =
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;

  if( !it.dstWritingDown )
  return;

  if( rit.pathResolving || it.isFunction )
  it._pathsResolve();

  it._pathsNormalize();

  if( rit.pathNativizing || it.isFunction )
  it._pathsNativize();

  it._pathsUnwrap();

}

//

function _pathsTransform( onPath, onStr )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
  let resource = it.dst;
  let transform = it.preservingIteration ? wrapTransform : elementTransform;

  it.dst = transform( it.dst );

  /* */

  function wrapTransform( resource )
  {
    if( _.looker.iterationIs( resource ) )
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
    resources = _.container.map_( null, resources, ( resource ) => transform( resource ) );
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
  let resource = it.dst;

  it._pathsTransform( ( filePath, resource ) =>
  {
    resource.path = it._pathNormalize( filePath, resource )
    return resource;
  });

}

//

function _pathNormalize( filePath, resource )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
  let resource = it.dst;

  if( !rit.pathNativizing )
  return;

  it._pathsTransform( handleResource, handleStr );

  function handleResource( filePath, resource )
  {
    resource.path = it._pathNativize( filePath, resource )
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
  let result = filePath;

  _.assert( _.strIs( result ) || _.strsAreAll( result ) );
  _.assert( arguments.length === 4 );

  if( it.selectorIsComposite( result ) )
  {

    /* xxx : use currentResource.module instead of currentModule? */
    // if( result.length === 2 )
    // debugger;
    result = currentModule.pathResolve
    ({
      selector : result,
      visited : _.arrayFlatten( null, [ rit.visited, result ] ),
      pathResolving : resolving ? rit.pathResolving : 0,
      currentContext : currentResource,
      pathNativizing : rit.pathNativizing,
      missingAction : rit.missingAction,
    });

  }

  return result;
}

//

function _pathsCompositeResolve()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
  let currentModule = it.currentModule || rit.currentModule;
  let resource = it.dst;

  _.assert( it !== rit );

  if( resource instanceof _.will.Reflector )
  {
    if( it.selectorIsComposite( resource.src.prefixPath ) || it.selectorIsComposite( resource.dst.prefixPath ) )
    {
      resource = it.dst = resource.cloneDerivative();
      if( resource.src.prefixPath )
      resource.src.prefixPath = it._pathCompositeResolve( currentModule, resource, resource.src.prefixPath, 'in' );
      if( resource.dst.prefixPath )
      resource.dst.prefixPath = it._pathCompositeResolve( currentModule, resource, resource.dst.prefixPath, 'in' );
    }
  }

  if( resource instanceof _.will.PathResource )
  {
    if( it.selectorIsComposite( resource.path ) )
    {
      resource = it.dst = resource.cloneDerivative();
      resource.path = it._pathCompositeResolve( currentModule, resource, resource.path, 'in' );
    }
  }

}

//

function _pathResolve( filePath, resource )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  _.assert( rit.OriginalLooker === rit.Replicator );
  _.assert( _.prototype.has( rit.Looker, rit.Replicator ) );
  _.assert( rit.baseModule !== undefined );
  _.assert( rit.currentModule !== undefined );
  _.assert( rit.baseModule !== undefined );
  _.assert( rit.currentModule !== undefined );
  _.assert( rit.currentModule !== undefined );
  let will = rit.baseModule.will;
  let currentModule = it.currentModule || rit.currentModule || rit.baseModule;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let resourceName = resource.name;
  let result = filePath;

  if( rit.currentModule )
  debugger;
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
    if( rit.missingAction === 'error' )
    return filePath;
    else
    throw filePath;
  }
  else if( _.arrayIs( filePath ) )
  for( let f = 0 ; f < filePath.length ; f++ )
  if( _.errIs( filePath[ f ] ) )
  {
    if( rit.missingAction === 'error' )
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

  currentModule = resource.module; /* xxx */

  let prefixPath = '.';
  if( rit.pathResolving === 'in' )
  {
    if( resourceName !== 'in' )
    prefixPath = currentModule.inPath || '.';
    else
    prefixPath = currentModule.dirPath;
  }
  else if( rit.pathResolving === 'out' )
  {
    if( resourceName !== 'out' )
    prefixPath = currentModule.outPath || '.';
    else
    prefixPath = currentModule.dirPath;
  }

  if( it.selectorIs( prefixPath ) )
  {
    debugger; /* xxx : not tested? */
  }
  if( it.selectorIs( prefixPath ) )
  prefixPath = currentModule.pathResolve({ selector : prefixPath, currentContext : it.dst });
  if( it.selectorIs( result ) )
  result = currentModule.pathResolve({ selector : result, currentContext : it.dst });

  result = path.s.join( prefixPath, result );

  return result;
}

//

function _pathResolveAct( o )
{
  _.assert( arguments.length === 1 );
  _.routine.options( _pathResolveAct, o );

  if( !o.currentModule && o.currentContext && o.currentContext.toModuleForResolver && o.currentContext.toModuleForResolver() )
  o.currentModule = o.currentContext.toModuleForResolver();
  if( !o.resourceName && o.currentContext )
  o.resourceName = o.currentContext instanceof _.will.Resource ? o.currentContext.name : null;

  let will = o.currentModule.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  let result = o.filePath;
  if( o.filePath === null || o.filePath === '' )
  return result;

  if( _.arrayIs( o.filePath ) )
  o.filePath = _.arrayFlattenOnce( o.filePath );

  _.assert( _.strIs( o.filePath ) || _.strsAreAll( o.filePath ) );

  let prefixPath = '.';
  if( o.pathResolving === 'in' )
  {
    if( o.resourceName !== 'in' )
    prefixPath = o.currentModule.inPath || '.';
    else
    prefixPath = o.currentModule.dirPath;
  }
  else if( o.pathResolving === 'out' )
  {
    if( o.resourceName !== 'out' )
    prefixPath = o.currentModule.outPath || '.';
    else
    prefixPath = o.currentModule.dirPath;
  }
  else _.assert( 0 );

  if( Self.selectorIs( prefixPath ) )
  prefixPath = o.currentModule.pathResolve({ selector : prefixPath, currentContext : o.currentContext });
  if( Self.selectorIs( result ) )
  result = o.currentModule.pathResolve({ selector : result, currentContext : o.currentContext });

  result = path.s.join( prefixPath, result );

  return result;
}

_pathResolveAct.defaults =
{
  filePath : null,
  currentModule : null,
  currentContext : null,
  resourceName : null,
  pathResolving : null,
}

//

function _pathsResolve()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
  let currentModule = it.currentModule || rit.currentModule;
  let resource = it.dst;

  it._pathsTransform( ( filePath, resource ) =>
  {
    resource.path = it._pathResolve( filePath, resource )
    return resource;
  });

}

//

function _pathsUnwrap()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;

  it._pathsTransform( unwrap );

  function unwrap( filePath, resource )
  {
    let result = resource;

    if( !rit.pathUnwrapping && !resource.phantom )
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
  let Os = require( 'os' );
  let os = 'posix';

  if( Os.platform() === 'win32' )
  os = 'windows';
  else if( Os.platform() === 'darwin' )
  os = 'osx';

  it.isFunction = it.selector;
  it.src = os;
  it.dst = os;
  it.selector = undefined;
  it.selectorType = null;
  it.iterable = null;
  it.iterationSelectorChanged();
  it.srcChanged();
}

//

function _functionThisUp()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let will = rit.baseModule.will;
  let currentThis = rit.currentThis;

  _.assert( currentThis !== undefined );

  if( currentThis === null )
  currentThis = it.сontextPrepare
  ({
    baseModule : rit.baseModule,
    currentThis,
    currentContext : rit.currentContext,
    force : 1,
  });

  it.isFunction = it.selector;
  // it.src = [ currentThis ];
  // it.selector = 0;
  it.src = currentThis;
  it.selector = '.';
  it.selectorType = null;
  it.iterable = null;
  it.iterationSelectorChanged();
  it.srcChanged();
}

//

function _functionStringsJoinDown()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;

  if( !_.arrayIs( it.src ) || !it.src[ functionSymbol ] )
  return;

  return Parent._functionStringsJoinDown.call( it );
}

// --
// err
// --

function errResolvingMake( o )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  let module = rit.baseModule;
  _.routine.assertOptions( errResolvingMake, arguments );
  _.assert( arguments.length === 1 );

  if( o.err && o.err.ResolvingError )
  {
    debugger;
    return o.err;
  }

  if( rit.currentContext && rit.currentContext.qualifiedName )
  o.err = it.errMake( o.err, '\nFailed to resolve', _.ct.format( _.entity.exportStringDiagnosticShallow( o.selector ), 'path' ), 'for', rit.currentContext.decoratedAbsoluteName );
  else
  o.err = it.errMake( o.err, '\nFailed to resolve', _.ct.format( _.entity.exportStringDiagnosticShallow( o.selector ), 'path' ), 'in', module.decoratedAbsoluteName );

  // if( rit.currentContext && rit.currentContext.qualifiedName )
  // o.err = _.err( o.err, '\nFailed to resolve', _.color.strFormat( _.entity.exportStringDiagnosticShallow( o.selector ), 'path' ), 'for', rit.currentContext.decoratedAbsoluteName );
  // else
  // o.err = _.err( o.err, '\nFailed to resolve', _.color.strFormat( _.entity.exportStringDiagnosticShallow( o.selector ), 'path' ), 'in', module.decoratedAbsoluteName );

  _.error.concealedSet( o.err, { ResolvingError : true } );
  debugger;

  return o.err;
}

errResolvingMake.defaults =
{
  selector : null,
  err : null,
}

// --
// resolve
// --

function resolve_head( routine, args )
{
  return routine.defaults.head( routine, args );
}

//

function resolve_body( it )
{
  it.perform();
  return it.result;
}

//

function performBegin()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;

  Parent.performBegin.apply( it, arguments );

  let module = it.baseModule;
  let will = module.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let currentContext = it.currentContext = it.currentContext || module;

  _.assert( it.srcForSelect instanceof _.will.Module );

  it.iterator.currentThis = it.сontextPrepare
  ({
    currentThis : it.currentThis,
    currentContext : it.currentContext,
    baseModule : it.baseModule,
    force : 0,
  });
  _.assert( !_.props.own( it, 'currentThis' ) );

  _.assert( it.iterationProper( it ) );
  if( !( it.currentContext instanceof _.will.AbstractModule2 ) )
  if( it.iterator.criterion === null && it.currentContext && it.currentContext.criterion )
  it.iterator.criterion = it.currentContext.criterion;

  _.assert( it.criterion === null || _.mapIs( it.criterion ) );
  _.assert( it.baseModule instanceof _.will.AbstractModule2 );
  _.assert( !_.props.own( it, 'criterion' ) );
  _.assert( it.OriginalLooker === ResolverWillbe );
  _.assert( _.prototype.has( it.Looker, ResolverWillbe ) );
  _.assert( it.Looker.Iteration.currentModule !== undefined );
  _.assert( it.Looker.IterationPreserve.currentModule !== undefined );

  return it;
}

//

function optionsToIteration( iterator, o )
{
  let it = Parent.optionsToIteration.call( this, iterator, o );

  if( !Config.debug )
  return it;

  _.assert( arguments.length === 2 );
  _.assert( !!Self.Selector );
  _.assert( it.Selector === Self.Selector );
  _.assert( it.Looker.Selector === Self.Selector );
  _.assert( it.currentThis !== undefined );
  _.assert( it.currentContext !== undefined );
  _.assert( it.criterion !== undefined );
  _.assert( _.boolLike( it.pathNativizing ) );
  _.assert( _.boolLike( it.pathUnwrapping ) );
  _.assert( _.boolLike( it.strictCriterion ) );
  _.assert( _.boolLike( it.currentExcluding ) );
  _.assert( it.hasPath !== undefined );
  _.assert( it.hasPath !== undefined );

  _.assert
  (
    !it.baseModule
    || !it.currentContext
    || !it.currentContext.toModuleForResolver
    || it.currentContext.toModuleForResolver() === it.baseModule
    ,
    `Current context belong to another base module, something wrong!`
  );

  return it;
}

//

function iteratorInitEnd( iterator )
{
  let looker = this;

  _.assert( iterator.iteratorProper( iterator ) );
  /* qqq : convert to template-string please in all files */
  _.assert
  (
    _.longHas( [ null, 0, false, 'in', 'out' ], iterator.pathResolving ),
    () => 'Unknown value of option path resolving ' + iterator.pathResolving
  );
  _.assert
  (
    !iterator.defaultResourceKind || !_.path.isGlob( iterator.defaultResourceKind ),
    () => 'Expects non glob {-defaultResourceKind-}, but got ' + _.strQuote( iterator.defaultResourceKind )
  );
  _.assert( iterator.baseModule !== undefined );

  if( !iterator.baseModule )
  {
    debugger;
    _.assert( 0, 'not tested' ); /* xxx */
    if( iterator.currentContext && _.routineIs( iterator.currentContext.toModuleForResolver ) )
    iterator.baseModule = iterator.currentContext.toModuleForResolver();
  }

  if( iterator.src === null || iterator.src === undefined )
  iterator.src = iterator.baseModule;

  return Parent.iteratorInitEnd.call( this, iterator );
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

  // etc

  _statusPreUpdate,
  _statusPostUpdate,
  _globCriterionFilter,
  _resourceMapSelect,

  _exportedWriteThrough,
  _currentExclude,
  _selectOptionsMake,
  _select,
  сontextPrepare,

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

  errResolvingMake,

}

//

_.assert( !!_.resolverAdv.Resolver.Selector );
let ResolverWillbeSelector =
({
  name : 'ResolverWillbeSelector',
  prime :
  {
  },
  looker :
  {
    ... Common,
  },
  iterationPreserve :
  {
    currentModule : null,
  },
  iteration :
  {
  },
});

/* */

_.assert( !!_.resolverAdv.Resolver );
_.assert( !!_.resolverAdv.Resolver.Replicator );
_.assert( _.resolverAdv.Resolver.Replicator === _.resolverAdv.Resolver );
_.assert( _.resolverAdv.Resolver.Iterator.resolveExtraOptions === undefined );

let ResolverWillbeReplicator =
({
  name : 'ResolverWillbeReplicator',
  prime : Prime,
  looker :
  {
    ... Common,
    performBegin,
    optionsToIteration,
    iteratorInitEnd,
  },
  iterationPreserve :
  {
    exported : null,
    currentModule : null, /* xxx : remove? */
    selectorIsPath : 0,
  },
  iteration :
  {
    exported : null,
    currentModule : null, /* xxx : remove? */
    selectorIsPath : 0,
  },
});

/* */

const ResolverWillbe = _.resolverAdv.classDefine
({
  selector : ResolverWillbeSelector,
  replicator : ResolverWillbeReplicator,
});

_.assert( ResolverWillbe.IterationPreserve.isFunction !== undefined );
_.assert( ResolverWillbe.Iteration.isFunction === undefined );
_.assert( ResolverWillbe.Iterator.isFunction === undefined );
_.assert( ResolverWillbe.isFunction !== undefined );
_.assert( ResolverWillbe.Iterator.resolveExtraOptions === undefined );
_.assert( ResolverWillbe.Looker === ResolverWillbe );

const Self = ResolverWillbe;

let resolveMaybe = _.routine.uniteInheriting( ResolverWillbe.exec.head, ResolverWillbe.exec.body );
var defaults = resolveMaybe.defaults;
defaults.Looker = defaults;
defaults.missingAction = 'undefine';

// --
// wraps
// --

let resolveRaw = _.routine.uniteInheriting( ResolverWillbe.exec.head, ResolverWillbe.exec.body );

var defaults = resolveRaw.defaults;
defaults.Looker = defaults;
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

let pathResolve = _.routine.uniteInheriting( ResolverWillbe.exec.head, ResolverWillbe.exec.body );

var defaults = pathResolve.defaults;
defaults.Looker = defaults;
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
  _.routine.options( routine, o );
  return o;
}

function pathOrReflectorResolve_body( o )
{
  let module = o.baseModule;
  let will = module.will;
  let resource;

  _.assert( _.aux.is( o ) );
  _.routine.assertOptions( pathOrReflectorResolve_body, arguments );
  _.assert( !Self.selectorIs( o.selector ) );
  _.assert( o.pathResolving === 'in' );
  _.assert( !o.pathUnwrapping );

  let o2 = _.props.extend( null, o );
  o2.missingAction = 'undefine';
  o2.selector = 'reflector::' + o.selector;
  resource = module.reflectorResolve( o2 );

  if( resource )
  return resource;

  let o3 = _.props.extend( null, o );
  o3.missingAction = 'undefine';
  o3.selector = 'path::' + o.selector;
  resource = module.reflectorResolve( o3 );

  return resource;
}

var defaults = pathOrReflectorResolve_body.defaults = _.props.extend( null, ResolverWillbe.Prime );

defaults.pathResolving = 'in';
defaults.missingAction = 'undefine';
defaults.pathUnwrapping = 0;

let pathOrReflectorResolve = _.routine.uniteCloning_replaceByUnite( pathOrReflectorResolve_head, pathOrReflectorResolve_body );

//

function filesFromResource_head( routine, args )
{
  let o =_.routine.options( routine, args );

  _.assert( args.length === 1 );
  _.assert( arguments.length === 2 );
  if( _.routineIs( routine ) ) /* zzz : remove "if" later */
  _.routine.options( routine, o );
  else
  _.routine.options( null, o, routine );

  let prefixlessAction = o.prefixlessAction;
  if( prefixlessAction === 'pathOrReflector' )
  o.prefixlessAction = 'resolved';

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

    let o2 = _.mapOnly_( null, o, module.resolve.defaults );
    delete o2.constructor;
    o2.prefixlessAction = 'default';
    o2.missingAction = 'undefine';
    o2.defaultResourceKind = 'path';
    resources = module.resolve( o2 );

    if( !resources )
    {
      let o2 = _.mapOnly_( null, o, module.resolve.defaults );
      delete o2.constructor;
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
    let o2 = _.mapOnly_( null, o, module.resolve.defaults );
    delete o2.constructor;
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

      if( o.pathResolving )
      if( _.strIs( resource ) || _.arrayIs( resource ) )
      if( o.currentContext && o.currentContext.toModuleForResolver && o.currentContext.toModuleForResolver() )
      {
        resource = _.will.resolver._pathResolveAct
        ({
          filePath : resource,
          currentContext : o.currentContext.toModuleForResolver(),
          pathResolving : o.pathResolving,
        });
      }

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

var defaults = filesFromResource_body.defaults = _.props.extend( null, ResolverWillbe.Prime );

_.assert( ResolverWillbe.Prime.Looker === undefined );

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

let filesFromResource = _.routine.uniteCloning_replaceByUnite( filesFromResource_head, filesFromResource_body );

_.assert( defaults.Looker === undefined );

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

  _.assert( _.looker.iterationIs( o ) );
  _.assert( o.pathResolving === 'in' );

  let reflector = module.resolve.body.call( module, o );

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

var defaults = reflectorResolve_body.defaults = Object.create( ResolverWillbe );
defaults.selector = null;
defaults.defaultResourceKind = 'reflector';
defaults.prefixlessAction = 'default';
defaults.currentContext = null;
defaults.pathResolving = 'in';
defaults.Looker = defaults;

let reflectorResolve = _.routine.uniteReplacing( ResolverWillbe.exec.head, reflectorResolve_body );

_.assert( reflectorResolve.defaults === reflectorResolve.defaults.Looker );
_.assert( reflectorResolve.defaults === defaults );
_.assert( reflectorResolve.body.defaults === defaults );

//

function submodulesResolve_body( o )
{
  let module = o.baseModule;
  let will = module.will;

  _.assert( o.iteratorProper( o ) );
  _.assert( o.prefixlessAction === 'default' );

  let result = module.resolve.body.call( module, o );

  return result;
}

var defaults = submodulesResolve_body.defaults = Object.create( ResolverWillbe );
defaults.selector = null;
defaults.prefixlessAction = 'default';
defaults.defaultResourceKind = 'submodule';
defaults.Looker = defaults;

let submodulesResolve = _.routine.uniteReplacing( ResolverWillbe.exec.head, submodulesResolve_body );

_.assert( submodulesResolve.body.defaults === defaults );
_.assert( submodulesResolve.defaults === defaults );
_.assert( defaults.prefixlessAction === 'default' );

//

let NamespaceExtension =
{

  name : 'resolverWillbe',
  Looker : ResolverWillbe,
  Resolver : ResolverWillbe,

  resolve : ResolverWillbe.exec,
  resolveMaybe,

  _pathResolveAct,

  resolveRaw,
  pathResolve,
  pathOrReflectorResolve,
  filesFromResource,
  reflectorResolve,
  submodulesResolve,

}

_.props.extend( _.will.resolver, NamespaceExtension );

})();
