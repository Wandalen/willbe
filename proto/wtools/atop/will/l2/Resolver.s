( function _Resolver_s_()
{

'use strict';

const _ = _global_.wTools;
const Parent = _.resolver2.Looker;
_.assert( !!_.resolver2.resolve );
// _.assert( !!_.resolver2.Looker.resolve );
_.assert( !_.resolver2.Looker.resolve );
_.assert( !!_.resolver2.Looker.exec );
_.assert( !!_.resolver2.compositeSymbol );
_.will.resolver = Object.create( _.resolver2 );

// --
// relation
// --

// let Defaults = _.mapExtend( null, Parent.resolve.body.defaults );
let Defaults = _.mapExtend( null, Parent.Prime );

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

Defaults.onSelectorReplicate = _onSelectorReplicate;
Defaults.onSelectorDown = _onSelectorDown;
Defaults.onUpBegin = _onUpBegin;
Defaults.onUpEnd = _onUpEnd;
Defaults.onDownEnd = _onDownEnd;
Defaults.onQuantitativeFail = _onQuantitativeFail;

// --
// handler
// --

function _onSelectorReplicate( o )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = it.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
  let selector = o.selector;

  let result = Parent._onSelectorReplicate.call( it, o );

  if( /*resolver*/it._selectorIs( selector ) )
  return result;

  if( result === undefined && o.counter > 0 )
  return;

  if( /*rop*/rit.prefixlessAction === 'default' && !it.composite )
  {
    return selector;
  }
  else if( /*rop*/rit.prefixlessAction === 'resolved' || /*rop*/rit.prefixlessAction === 'default' )
  {
    if( /*rop*/rit.pathResolving )
    if( /*rop*/rit.defaultResourceKind === 'path' || /*rop*/rit.selectorIsPath )
    if( _.strIs( selector ) || _.arrayIs( selector ) )
    if( !/*resolver*/it.selectorIs( selector ) )
    if( !it.composite )
    {
      selector = new _.will.PathResource({ module : /*rop*/rit.baseModule, name : null, phantom : 1, path : selector });
      selector.form1();
      // debugger; /* yyy */
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
  // let rop = it.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;

  // debugger; /* yyy */

  if( it.continue && _.arrayIs( it.dst ) && it.src.composite === _.resolver2.compositeSymbol )
  {

    for( let d = 0 ; d < it.dst.length ; d++ )
    {
      if( it.dst[ d ] && it.dst[ d ] instanceof _.will.PathResource )
      it.dst[ d ] = it.dst[ d ].path;
      if( _.errIs( it.dst[ d ] ) )
      throw it.dst[ d ];
    }

    it.dst = _.strJoin( it.dst );

    if( /*rop*/rit.defaultResourceKind === 'path' || /*rop*/rit.selectorIsPath )
    {
      it.dst = new _.will.PathResource({ module : /*rop*/rit.baseModule, name : null, phantom : 1, path : it.dst });
      it.dst.form1();
    }

    it.src.composite = null;

  }

  if( !it.dstWritingDown )
  return end();

  /*resolver*/it._pathPerform.call( it );

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
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;

  /*resolver*/it._statusPreUpdate.call( it );
  /*resolver*/it._globCriterionFilter.call( it );

  if( !it.dstWritingDown )
  return;

  /*
  _resourceMapSelect, _statusPostUpdate should go after _queryParse
  */

  /*resolver*/it._queryParse.call( it );
  /*resolver*/it._resourceMapSelect.call( it );
  /*resolver*/it._statusPostUpdate.call( it );

}

//

function _onUpEnd()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;

  if( !it.dstWritingDown )
  return;

  /*resolver*/it._exportedWriteThrough.call( it );
  /*resolver*/it._currentExclude.call( it );

  if( !it.dstWritingDown )
  return;

  /*resolver*/it._pathsCompositeResolve.call( it );

}

//

function _onDownEnd()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;

  if( !it.dstWritingDown )
  return;

  /*resolver*/it._pathPerform.call( it );

  return Parent._onDownEnd.call( it );
}

//

function _onQuantitativeFail( err )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
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

    if( /*rop*/rit.criterion )
    err = _.err( err, '\nCriterions :\n', _.entity.exportString( /*rop*/rit.criterion, { wrap : 0, levels : 4, stringWrapper : '', multiline : 1 } ) );

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
  // let rop = rit.iterator;
  let will = /*rop*/rit.baseModule.will;

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
    // debugger; /* yyy : should selector iteration have individual currentModule? */
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  let will = /*rop*/rit.baseModule.will;

  if( /*rop*/rit.selectorIsPath )
  it.selectorIsPath = 1;

  if( it.parsedSelector )
  {
    let kind = it.parsedSelector.kind;

    if( kind === 'path' && /*rop*/rit.hasPath === null )
    /*rop*/rit.hasPath = true;

    if( kind === 'path' )
    it.selectorIsPath = 1;

  }

}

//

function _globCriterionFilter()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  let will = /*rop*/rit.baseModule.will;

  _.debugger;

  if( it.down && it.down.selectorIsGlob )
  if( /*rop*/rit.criterion && it.src && it.src.criterionSattisfy )
  {

    let s = /*rop*/rit.strictCriterion ? it.src.criterionSattisfyStrict( /*rop*/rit.criterion ) : it.src.criterionSattisfy( /*rop*/rit.criterion );

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
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
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
      /*resolver*/it._functionStringsJoinUp.call( it );
    }
    else if( it.selector === 'os' )
    {
      /*resolver*/it._functionOsGetUp.call( it );
    }
    else if( it.selector === 'this' )
    {
      /*resolver*/it._functionThisUp.call( it );
    }
    else _.sure( 0, 'Unknown function', it.parsedSelector.full );

  }
  else
  {

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
      throw _.LookingError( 'No resource map', _.strQuote( it.parsedSelector.full ) );
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
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;

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
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;

  // debugger; /* yyy */
  if( /*rop*/rit.currentExcluding )
  if( it.src === /*rop*/rit.currentContext && it.down )
  it.dstWritingDown = false;

}

//

function _select( visited )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;

  _.assert( !_.property.own( it, 'criterion' ) );

  let it2 = Parent._select.apply( this, arguments );

  _.assert( it2 !== it );
  _.assert( it2.criterion === undefined ); /* yyy : uncomment */
  _.assert( it._onUpBegin === Self._onUpBegin );
  _.assert( it.onUpBegin === Self._onUpBegin );
  _.assert( it2._onUpBegin === Self._onUpBegin );
  _.assert( it2.onUpBegin === Self._onUpBegin );

  return it2;
}

//

function resolveContextPrepare( o )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  //let resolver = this;
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;

  if( !it.dstWritingDown )
  return;

  if( /*rop*/rit.pathResolving || it.isFunction )
  /*resolver*/it._pathsResolve.call( it );

  /*resolver*/it._pathsNormalize.call( it );

  if( /*rop*/rit.pathNativizing || it.isFunction )
  /*resolver*/it._pathsNativize.call( it );

  /*resolver*/it._pathsUnwrap.call( it );

}

//

function _pathsTransform( onPath, onStr )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
  let resource = it.dst;
  // debugger; /* yyy */
  let transform = it.preservingIteration ? wrapTransform : elementTransform;
  // let transform = /*rop*/rit.preservingIteration ? wrapTransform : elementTransform;

  it.dst = transform( it.dst );

  /* */

  function wrapTransform( resource )
  {
    // debugger;
    // if( _.prototype.isPrototypeFor( _.Looker, resource ) )
    if( _.looker.iterationIs( resource ) )
    {
      // debugger;
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
  let resource = it.dst;

  /*resolver*/it._pathsTransform.call( it, ( filePath, resource ) =>
  {
    resource.path = /*resolver*/it._pathNormalize.call( it, filePath, resource )
    return resource;
  });

}

//

function _pathNormalize( filePath, resource )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
  let resource = it.dst;

  if( !/*rop*/rit.pathNativizing )
  return;

  /*resolver*/it._pathsTransform.call( it, handleResource, handleStr );

  function handleResource( filePath, resource )
  {
    resource.path = /*resolver*/it._pathNativize.call( it, filePath, resource )
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
  // let rop = rit.iterator;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
  let result = filePath;

  _.assert( _.strIs( result ) || _.strsAreAll( result ) );
  _.assert( arguments.length === 4 );

  if( /*resolver*/it.selectorIsComposite( result ) )
  {

    result = currentModule.pathResolve
    ({
      selector : result,
      visited : _.arrayFlatten( null, [ /*rop*/rit.visited, result ] ),
      pathResolving : resolving ? /*rop*/rit.pathResolving : 0,
      currentContext : currentResource,
      pathNativizing : /*rop*/rit.pathNativizing,
      missingAction : /*rop*/rit.missingAction,
    });

  }

  return result;
}

//

function _pathsCompositeResolve()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
  let currentModule = rit.currentModule;
  let resource = it.dst;

  if( resource instanceof _.will.Reflector )
  {
    if( /*resolver*/it.selectorIsComposite( resource.src.prefixPath ) || /*resolver*/it.selectorIsComposite( resource.dst.prefixPath ) )
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
    if( /*resolver*/it.selectorIsComposite( resource.path ) )
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
  _.assert( rit.OriginalLooker === rit.Replicator );
  _.assert( _.prototype.has( rit.Looker, rit.Replicator ) );
  _.assert( rit.baseModule !== undefined );
  _.assert( rit.currentModule !== undefined );
  _.assert( /*rop*/rit.baseModule !== undefined );
  _.assert( /*rop*/rit.currentModule !== undefined );
  _.assert( rit.currentModule !== undefined );
  let will = /*rop*/rit.baseModule.will;
  let currentModule = rit.currentModule || /*rop*/rit.baseModule;
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
    if( /*rop*/rit.missingAction === 'error' )
    return filePath;
    else
    throw filePath;
  }
  else if( _.arrayIs( filePath ) )
  for( let f = 0 ; f < filePath.length ; f++ )
  if( _.errIs( filePath[ f ] ) )
  {
    if( /*rop*/rit.missingAction === 'error' )
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
  if( /*rop*/rit.pathResolving === 'in' )
  {
    if( resourceName !== 'in' )
    prefixPath = currentModule.inPath || '.';
    else
    prefixPath = currentModule.dirPath;
  }
  else if( /*rop*/rit.pathResolving === 'out' )
  {
    if( resourceName !== 'out' )
    prefixPath = currentModule.outPath || '.';
    else
    prefixPath = currentModule.dirPath;
  }

  if( /*resolver*/it.selectorIs( prefixPath ) )
  prefixPath = currentModule.pathResolve({ selector : prefixPath, currentContext : it.dst });
  if( /*resolver*/it.selectorIs( result ) )
  result = currentModule.pathResolve({ selector : result, currentContext : it.dst });

  result = path.s.join( prefixPath, result );

  return result;
}

//

function _pathsResolve()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
  let currentModule = rit.currentModule;
  let resource = it.dst;

  /*resolver*/it._pathsTransform.call( it, ( filePath, resource ) =>
  {
    resource.path = /*resolver*/it._pathResolve.call( it, filePath, resource )
    return resource;
  });

}

//

function _pathsUnwrap()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
  let currentModule = rit.currentModule;

  /*resolver*/it._pathsTransform.call( it, unwrap );

  function unwrap( filePath, resource )
  {
    let result = resource;

    if( !/*rop*/rit.pathUnwrapping && !resource.phantom )
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
  debugger;
  // let rop = rit.iterator;
  let will = /*rop*/rit.baseModule.will;
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  debugger;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;
  let will = /*rop*/rit.baseModule.will;
  let currentThis = /*rop*/rit.currentThis;

  if( currentThis === null )
  currentThis = /*resolver*/it.resolveContextPrepare
  ({
    baseModule : /*rop*/rit.baseModule,
    currentThis,
    currentContext : /*rop*/rit.currentContext,
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
  let rit = it.replicateIteration ? it.replicateIteration : it;
  // let rop = rit.iterator;
  //let resolver = /*rop*/rit.Resolver;

  if( !_.arrayIs( it.src ) || !it.src[ functionSymbol ] )
  return;

  return Parent._functionStringsJoinDown.call( it );
}

// --
// err
// --

function errResolving( o )
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  //let resolver = this;
  let module = rit.baseModule;
  // let module = o./*rop*/rit.baseModule;
  _.assertRoutineOptions( errResolving, arguments );
  _.assert( arguments.length === 1 );
  // if( o./*rop*/rit.currentContext && o./*rop*/rit.currentContext.qualifiedName )
  if( rit.currentContext && rit.currentContext.qualifiedName )
  return _.err( o.err, '\nFailed to resolve', _.color.strFormat( _.entity.exportStringShort( o.selector ), 'path' ), 'for', rit.currentContext.decoratedAbsoluteName );
  // return _.err( o.err, '\nFailed to resolve', _.color.strFormat( _.entity.exportStringShort( o.selector ), 'path' ), 'for', o./*rop*/rit.currentContext.decoratedAbsoluteName );
  else
  return _.err( o.err, '\nFailed to resolve', _.color.strFormat( _.entity.exportStringShort( o.selector ), 'path' ), 'in', module.decoratedAbsoluteName );
}

errResolving.defaults =
{
  selector : null,
  // rop : null,
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

// Defaults.onSelectorReplicate = _onSelectorReplicate;
// Defaults.onSelectorDown = _onSelectorDown;
// Defaults.onUpBegin = _onUpBegin;
// Defaults.onUpEnd = _onUpEnd;
// Defaults.onDownEnd = _onDownEnd;
// Defaults.onQuantitativeFail = _onQuantitativeFail;
//
// var defaults = resolve_body.defaults = Defaults

// let resolve = _.routineUnite( resolve_head, resolve_body );
// let resolveMaybe = _.routineUnite( resolve_head, resolve_body );
// var defaults = resolveMaybe.defaults;
// defaults.missingAction = 'undefine';

// //
//
// function head( routine, args )
// {
//   _.assert( arguments.length === 2 );
//   let o = routine.defaults.Looker.optionsFromArguments( args );
//   if( _.routineIs( routine ) )
//   o.Looker = o.Looker || routine.defaults.Looker;
//   else
//   o.Looker = o.Looker || routine.Looker;
//   _.assert( _.routineIs( routine ) || _.auxIs( routine ) );
//   if( _.routineIs( routine ) ) /* zzz : remove "if" later */
//   _.assertMapHasOnly( o, routine.defaults );
//   // _.routineOptionsPreservingUndefines( routine, o );
//   else if( routine !== null )
//   _.assertMapHasOnly( o, routine );
//   // _.routineOptionsPreservingUndefines( null, o, routine );
//   // o.Looker.optionsForm( routine, o );
//   o.optionsForSelect = o.Looker.selectorOptionsForSelectFrom( o );
//   let it = o.Looker.optionsToIteration( null, o );
//   return it;
// }

//

function performBegin()
{
  let it = this;
  let rit = it.replicateIteration ? it.replicateIteration : it;
  Parent.performBegin.apply( it, arguments );
  // _.assert( Object.is( it.originalSrc, it.src ) );

  let module = it.baseModule;
  let will = module.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let currentContext = it.currentContext = it.currentContext || module;

  _.assert( it.srcForSelect instanceof _.will.Module );

  it.iterator.currentThis = it.resolveContextPrepare
  ({
    currentThis : it.currentThis,
    currentContext : it.currentContext,
    baseModule : it.baseModule,
  });
  _.assert( !_.property.own( it, 'currentThis' ) );

  _.assert( it.iterationProper( it ) );
  if( !( it.currentContext instanceof _.will.AbstractModule ) )
  if( it.iterator.criterion === null && it.currentContext && it.currentContext.criterion )
  it.iterator.criterion = it.currentContext.criterion;

  _.assert( it.criterion === null || _.mapIs( it.criterion ) );
  _.assert( it.baseModule instanceof _.will.AbstractModule );
  _.assert( !_.property.own( it, 'criterion' ) );
  // _.assert( it.Looker === ResolverWillbe );
  _.assert( it.OriginalLooker === ResolverWillbe );
  _.assert( _.prototype.has( it.Looker, ResolverWillbe ) );
  _.assert( it.Looker.Iteration.currentModule !== undefined );
  _.assert( it.Looker.IterationPreserve.currentModule !== undefined );

  return it;
}

//

function optionsForm( routine, o )
{
  // if( o.Resolver === null || o.Resolver === undefined )
  // o.Resolver = Self;

  _.assert( o.iteratorProper( o ) );
  /* qqq : convert to template-string please in all files */
  _.assert( _.longHas( [ null, 0, false, 'in', 'out' ], o.pathResolving ), () => 'Unknown value of option path resolving ' + o.pathResolving );
  _.assert( !o.defaultResourceKind || !_.path.isGlob( o.defaultResourceKind ), () => 'Expects non glob {-defaultResourceKind-}, but got ' + _.strQuote( o.defaultResourceKind ) );
  _.assert( o.baseModule !== undefined );

  if( o.src === null )
  o.src = o.baseModule;

  Parent.optionsForm.call( this, routine, o );

  return o;
}

//

function optionsToIteration( iterator, o )
{
  let it = Parent.optionsToIteration.call( this, iterator, o );
  _.assert( arguments.length === 2 );
  _.assert( !!Self.Selector );
  _.assert( it.Selector === Self.Selector );
  _.assert( it.Looker.Selector === Self.Selector );
  return it;
}

//

function _iterator_functor()
{

  _.assert( !!_.resolver2.Resolver.Selector );
  // let ResolverWillbeSelector = _.looker.classDefine
  let ResolverWillbeSelector =
  ({
    name : 'ResolverWillbeSelector',
    parent : _.resolver2.Resolver.Selector,
    defaults :
    {
      // defaultResourceKind : null,
      // prefixlessAction : null,
      // singleUnwrapping : null,
      // mapValsUnwrapping : null,
      // mapFlattening : null,
      // arrayWrapping : null,
      // arrayFlattening : null,
      // ... Defaults,
    },
    looker :
    {
      ... Common,
    },
  });

  /* */

  _.assert( !!_.resolver2.Resolver );
  _.assert( !!_.resolver2.Resolver.Replicator );
  _.assert( _.resolver2.Resolver.Replicator === _.resolver2.Resolver );
  // _.assert( _.resolver2.Resolver.Iterator.resolveExtraOptions !== undefined );
  _.assert( _.resolver2.Resolver.Iterator.resolveExtraOptions === undefined );

  /* xxx : redefine _.resolver.classDefine() */
  // let ResolverWillbeReplicator = _.resolver2.classDefine
  let ResolverWillbeReplicator =
  ({
    name : 'ResolverWillbeReplicator',
    parent : _.resolver2.Resolver.Replicator,
    defaults : Defaults, /* yyy */
    looker :
    {
      ... Common,

      // resolve,
      // resolveMaybe,
      // head,
      performBegin,
      // exec : resolve,
      optionsForm,
      optionsToIteration,

    },
    iterationPreserve :
    {
      exported : null,
      currentModule : null,
      selectorIsPath : 0,
    },
    iteration :
    {
      exported : null,
      currentModule : null,
      selectorIsPath : 0,
    },
  });

  /* */

  let ResolverWillbe = _.resolver.classDefine
  ({
    selector : ResolverWillbeSelector,
    replicator : ResolverWillbeReplicator,
  });

  _.assert( ResolverWillbe.IterationPreserve.isFunction !== undefined );
  _.assert( ResolverWillbe.Iterator.resolveExtraOptions === undefined );
  // _.assert( ResolverWillbe.Iterator.resolveExtraOptions !== undefined );
  _.assert( ResolverWillbe.Looker === ResolverWillbe );

  // ResolverWillbeReplicator.Selector = ResolverWillbeSelector;
  // ResolverWillbeReplicator.Replicator = ResolverWillbeReplicator;
  // ResolverWillbeSelector.Selector = ResolverWillbeSelector;
  // ResolverWillbeSelector.Replicator = ResolverWillbeReplicator;

  // return ResolverWillbeReplicator;
  return ResolverWillbe;
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

  // onSelectorReplicate : _onSelectorReplicate,
  // onSelectorDown : _onSelectorDown,
  // onUpBegin : _onUpBegin,
  // onUpEnd : _onUpEnd,
  // onDownEnd : _onDownEnd,
  // onQuantitativeFail : _onQuantitativeFail,

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

  errResolving, /* xxx : remove? */

  // // wraps
  //
  // resolveRaw,
  // pathResolve,
  // pathOrReflectorResolve,
  // filesFromResource,
  // reflectorResolve,
  // submodulesResolve,

}

//

const ResolverWillbe = _iterator_functor();
const Self = ResolverWillbe;

/* xxx */
// let resolveMaybe = _.routineUnite({ head : ResolverWillbe.exec.head, body : ResolverWillbe.exec.body, strategy : 'inheriting' });
let resolveMaybe = _.routine.uniteInheriting( ResolverWillbe.exec.head, ResolverWillbe.exec.body );
var defaults = resolveMaybe.defaults;
defaults.Looker = defaults;
defaults.missingAction = 'undefine';

// resolve_body.defaults = _.mapExtend( null, ResolverWillbe.Prime );
// let resolve = _.routineUnite( resolve_head, resolve_body );

// --
// wraps
// --

// let resolveRaw = _.routineUnite( resolve_head, resolve_body );
// let resolveRaw = _.routineUnite({ head : ResolverWillbe.exec.head, body : ResolverWillbe.exec.body, strategy : 'inheriting' });
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

// let pathResolve = _.routineUnite( resolve_head, resolve_body );
// let pathResolve = _.routineUnite({ head : ResolverWillbe.exec.head, body : ResolverWillbe.exec.body, strategy : 'inheriting' });
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
  _.routineOptions( routine, o );
  return o;
}

function pathOrReflectorResolve_body( o )
{
  //let resolver = this;
  let module = o.baseModule;
  let will = module.will;
  let resource;

  _.assert( _.aux.is( o ) );
  _.assertRoutineOptions( pathOrReflectorResolve_body, arguments );
  _.assert( !/*resolver*/Self.selectorIs( o.selector ) );
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

// var defaults = pathOrReflectorResolve_body.defaults = Object.create( resolve_body.defaults );
var defaults = pathOrReflectorResolve_body.defaults = _.mapExtend( null, ResolverWillbe.Prime );

defaults.pathResolving = 'in';
defaults.missingAction = 'undefine';
defaults.pathUnwrapping = 0;

let pathOrReflectorResolve = _.routineUnite( pathOrReflectorResolve_head, pathOrReflectorResolve_body );

//

function filesFromResource_head( routine, args )
{
  //let resolver = this;
  let o =_.routineOptions( routine, args );

  _.assert( args.length === 1 );
  _.assert( arguments.length === 2 );
  // if( _.routineIs( routine ) )
  // o.Looker = o.Looker || routine.defaults.Looker || Self;
  // else
  // o.Looker = o.Looker || routine.Looker || Self;
  if( _.routineIs( routine ) ) /* zzz : remove "if" later */
  _.routineOptionsPreservingUndefines( routine, o );
  else
  _.routineOptionsPreservingUndefines( null, o, routine );

  let prefixlessAction = o.prefixlessAction;
  if( prefixlessAction === 'pathOrReflector' )
  o.prefixlessAction = 'resolved';

  // resolve_head.call( Self, routine, [ o ] );

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
    delete o2.constructor;
    o2.prefixlessAction = 'default';
    o2.missingAction = 'undefine';
    o2.defaultResourceKind = 'path';
    resources = module.resolve( o2 );
    if( !resources )
    {
      let o2 = _.mapOnly( o, module.resolve.defaults );
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
    let o2 = _.mapOnly( o, module.resolve.defaults );
    debugger;
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

// var defaults = filesFromResource_body.defaults = Object.create( resolve.defaults );

var defaults = filesFromResource_body.defaults = _.mapExtend( null, ResolverWillbe.Prime );

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

let filesFromResource = _.routineUnite( filesFromResource_head, filesFromResource_body );

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

// var defaults = reflectorResolve_body.defaults = _.mapExtend( null, ResolverWillbe.Prime );
//
// defaults.selector = null;
// defaults.defaultResourceKind = 'reflector';
// defaults.prefixlessAction = 'default';
// defaults.currentContext = null;
// defaults.pathResolving = 'in';
//
// let reflectorResolve = _.routineUnite( ResolverWillbe.exec.head, reflectorResolve_body );

var defaults = reflectorResolve_body.defaults = Object.create( ResolverWillbe );
defaults.selector = null;
defaults.defaultResourceKind = 'reflector';
defaults.prefixlessAction = 'default';
defaults.currentContext = null;
defaults.pathResolving = 'in';
defaults.Looker = defaults;

// let reflectorResolve = _.routineUnite({ head : ResolverWillbe.exec.head, body : reflectorResolve_body, strategy : 'replacing' });
let reflectorResolve = _.routine.uniteReplacing( ResolverWillbe.exec.head, reflectorResolve_body );

_.assert( reflectorResolve.defaults === reflectorResolve.defaults.Looker );
_.assert( reflectorResolve.defaults === defaults );
_.assert( reflectorResolve.body.defaults === defaults );

// var defaults = reflectorResolve.defaults = Object.create( ResolverWillbe.exec.defaults );
// var defaults = reflectorResolve.defaults = _.mapExtend( null, ResolverWillbe.Prime );

// var defaults = reflectorResolve_body.defaults = Object.create( resolve.defaults );

// var defaults = reflectorResolve_body.defaults;
// defaults.selector = null;
// defaults.defaultResourceKind = 'reflector';
// defaults.prefixlessAction = 'default';
// defaults.currentContext = null;
// defaults.pathResolving = 'in';

// let reflectorResolve = _.routineUnite( reflectorResolve_head, reflectorResolve_body );

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

// submodulesResolve
// defaults.selector = null;

var defaults = submodulesResolve_body.defaults = Object.create( ResolverWillbe );
defaults.selector = null;
defaults.prefixlessAction = 'default';
defaults.defaultResourceKind = 'submodule';
defaults.Looker = defaults;

// let submodulesResolve = _.routineUnite({ head : ResolverWillbe.exec.head, body : submodulesResolve_body, strategy : 'replacing' });
let submodulesResolve = _.routine.uniteReplacing( ResolverWillbe.exec.head, submodulesResolve_body );

_.assert( submodulesResolve.body.defaults === defaults );
_.assert( submodulesResolve.defaults === defaults );
_.assert( defaults.prefixlessAction === 'default' );

// var defaults = submodulesResolve_body.defaults = _.mapExtend( null, ResolverWillbe.Prime );
// // var defaults = submodulesResolve_body.defaults = Object.create( resolve.defaults );
// defaults.selector = null;
// defaults.prefixlessAction = 'default';
// defaults.defaultResourceKind = 'submodule';
//
// let submodulesResolve = _.routineUnite( ResolverWillbe.exec.head, submodulesResolve_body );

//

let Extension =
{

  // ... _.resolver2,
  // ... Common,

  Looker : ResolverWillbe,
  Resolver : ResolverWillbe,
  // ResolverExtra : ResolverWillbe,
  // ResolverWillbe,

  resolve : ResolverWillbe.exec,
  resolveMaybe,

  resolveRaw,
  pathResolve,
  pathOrReflectorResolve,
  filesFromResource,
  reflectorResolve,
  submodulesResolve,

}

_.mapExtend( _.will.resolver, Extension );

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
