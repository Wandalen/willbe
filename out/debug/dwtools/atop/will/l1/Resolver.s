( function _Resolver_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

let _ = wTools;
let Parent = _.Resolver;
let Self = Object.create( Parent );

// --
// handler
// --

function _onSelectorDown()
{
  let it = this;
  let rop = it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;

  if( it.continue && _.arrayIs( it.dst ) && it.src.composite === _.select.composite )
  {

    for( let d = 0 ; d < it.dst.length ; d++ )
    if( _.errIs( it.dst[ d ] ) )
    throw it.dst[ d ];

    it.dst = _.strJoin( it.dst );

    it.src.composite = null;
    resolver._pathsNativize.call( it );

  }

  Parent._onSelectorDown.call( it );
}

//

function _onUpBegin()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
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
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;

  if( !it.dstWritingDown )
  return;

  resolver._exportedWriteThrough.call( it );
  resolver._currentExclude.call( it );

  if( !it.dstWritingDown )
  return;

  // if( it.dstWritingDown ) // xxx
  resolver._pathsCompositeResolve.call( it );

  if( !it.dstWritingDown )
  return;

  // if( it.dstWritingDown ) // xxx
  if( rop.pathResolving || it.isFunction )
  resolver._pathsResolve.call( it );

  if( !it.dstWritingDown )
  return;

  if( rop.pathUnwrapping )
  resolver._pathsUnwrap.call( it );

}

//

function _onDownEnd()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;

  if( !it.dstWritingDown )
  return;

  if( rop.pathNativizing || it.isFunction )
  resolver._pathsNativize.call( it );

  return Parent._onDownEnd.call( it );
}

//

function _onQuantitativeFail( err )
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;

  debugger;

  let result = it.dst;
  if( _.mapIs( result ) )
  result = _.mapVals( result );
  if( _.arrayIs( result ) )
  {
    let isString = 1;
    if( result.every( ( e ) => _.strIs( e ) ) )
    isString = 1;
    else
    result = result.map( ( e ) =>
    {
      if( _.strIs( e ) )
      return e;
      if( _.strIs( e.nickName ) )
      return e.nickName;
      isString = 0
    });

    if( rop.criterion )
    err = _.err( err, '\nCriterions :\n', _.toStr( rop.criterion, { wrap : 0, levels : 4, multiline : 1, stringWrapper : '', multiline : 1 } ) );

    if( isString )
    if( result.length )
    err = _.err( err, '\n', 'Found : ' + result.join( ', ' ) );
    else
    err = _.err( err, '\n', 'Found nothing' );
  }

  throw err;
}

// --
//
// --

function _statusPreUpdate()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( !it.src )
  return;

  _.assert( !_.mapHasKey( it.src, 'composite' ) );

  if( it.src instanceof will.OpenedModule )
  {
    it.currentModule = it.src;
  }
  else if( it.src instanceof will.Submodule )
  {
    if( it.src.opener && it.src.opener.openedModule )
    it.currentModule = it.src.opener.openedModule;
  }
  else if( it.src instanceof will.Exported )
  {
    it.exported = it.src;
  }

}

//

function _statusPostUpdate()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
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
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( it.down && it.down.isGlob )
  if(  rop.criterion && it.src && it.src.criterionSattisfy )
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
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  // let sop = it.selectOptions;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !it.selector )
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

    it.src = it.currentModule.resourceMapsForKind( kind );

    if( _.strIs( kind ) && path.isGlob( kind ) )
    {
      debugger;
      it.selectorArray.splice( it.logicalLevel-1, 1, '*', it.selector );
      it.selector = it.selectorArray[ it.logicalLevel-1 ];
      it.selectorChanged();
    }

    if( !it.src )
    {
      debugger;
      throw _.ErrorLooking( 'No resource map', _.strQuote( it.parsedSelector.full ) );
    }

    it.srcChanged();
  }

  // it.srcChanged();
}

//

function _exportedWriteThrough()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
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
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;

  if( rop.currentExcluding )
  if( it.src === rop.currentContext && it.down )
  it.dstWritingDown = false;

}

// --
// path
// --

function _pathsNativize()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let resource = it.dst;

  if( !rop.pathNativizing )
  return;

  if( it.selectMultipleOptions )
  {
    if( !rop.selectorIsPath )
    return;
  }
  else
  {
    if( !it.selectorIsPath )
    return;
    if( it.down && it.down.selectorIsPath )
    return;
  }

  if( it.dst )
  it.dst = _.map( it.dst, ( resource ) =>
  {
    if( _.strIs( resource ) )
    return _pathNativize.call( it, resource );
    if( resource instanceof will.PathResource )
    {
      resource = resource.cloneDerivative();
      _.assert( resource.path === null || _.arrayIs( resource.path ) || _.strIs( resource.path ) );
      if( resource.path )
      resource.path = _pathNativize.call( it, resource.path );
    }
    else debugger;
    return resource;
  });

}

//

function _pathNativize( filePath )
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = it.currentModule;
  let path = will.fileProvider.providersWithProtocolMap.file.path;
  let result = filePath;

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

function _pathCompositeResolve( currentModule, currentResource, filePath, resolving )
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
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
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = it.currentModule;
  let resource = it.dst;

  if( resource instanceof will.Reflector )
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

  if( resource instanceof will.PathResource )
  {
    if( resolver.selectorIsComposite( resource.path ) )
    {
      resource = it.dst = resource.cloneDerivative();
      resource.path = _pathCompositeResolve.call( it, currentModule, resource, resource.path, 'in' );
    }
  }

}

//

function _pathResolve( filePath, resourceName )
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = it.currentModule;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let result = filePath;

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

  if( it.replicateIteration.composite )
  if( it.replicateIteration.compositeRoot !== it.replicateIteration )
  if( it.replicateIteration.compositeRoot === it.replicateIteration.down )
  {
    if( it.replicateIteration.key !== 0 )
    return result;
  }

  let prefixPath = '.';
  if( rop.pathResolving === 'in' && resourceName !== 'in' )
  prefixPath = currentModule.inPath || '.';
  else if( rop.pathResolving === 'out' && resourceName !== 'out' )
  prefixPath = currentModule.outPath || '.';

  if( resolver.selectorIs( prefixPath ) )
  prefixPath = currentModule.pathResolve({ selector : prefixPath, currentContext : it.dst });
  if( resolver.selectorIs( result ) )
  result = currentModule.pathResolve({ selector : result, currentContext : it.dst });

  result = path.s.join( currentModule.dirPath, prefixPath, result );

  return result;
}

//

function _pathsResolve()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = it.currentModule;
  let resource = it.dst;

  if( it.dst instanceof will.PathResource )
  {
    resource = it.dst = resource.cloneDerivative();
    _.assert( resource.path === null || _.arrayIs( resource.path ) || _.strIs( resource.path ) );
    if( resource.path )
    resource.path = _pathResolve.call( it, resource.path, resource.name )
  }

}

//

function _pathsUnwrap()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  let currentModule = it.currentModule;

  if( it.dst instanceof will.PathResource )
  it.dst = it.dst.path;

}

// --
// function
// --

function _functionOsGetUp()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  // let sop = it.selectOptions;
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
  it.selectorChanged();
  it.srcChanged();
}

//

function _functionThisUp()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let resolver = rop.Resolver;
  let will = rop.baseModule.will;
  // let sop = it.selectOptions;
  let currentThis = rop.currentThis;

  if( currentThis === null )
  currentThis = resolver.resolveContextPrepare
  ({
    baseModule : rop.baseModule,
    currentThis : currentThis,
    currentContext : rop.currentContext,
    force : 1,
  });

  it.isFunction = it.selector;
  it.src = [ currentThis ];
  it.selector = 0;

  it.selectorChanged();
  it.srcChanged();
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
  if( o.rop.currentContext && o.rop.currentContext.nickName )
  return _.err( 'Failed to resolve', _.color.strFormat( o.selector, 'code' ), 'for', o.rop.currentContext.decoratedAbsoluteName, '\n', o.err );
  else
  return _.err( 'Failed to resolve', _.color.strFormat( o.selector, 'code' ), 'in', module.decoratedAbsoluteName, '\n', o.err );
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

  if( o.currentThis instanceof will.Reflector )
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
  else if( o.currentThis instanceof will.Resource )
  {
    o.currentThis = o.currentThis.dataExport();
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

//

function resolve_pre( routine, args )
{
  let resolver = this;
  let o = args[ 0 ];

  if( o.Resolver === null || o.Resolver === undefined )
  o.Resolver = Self;

  Parent.resolve.pre.call( resolver, routine, args );

  _.assert( _.arrayHas( [ null, 0, false, 'in', 'out' ], o.pathResolving ), () => 'Unknown value of option path resolving ' + o.pathResolving );
  _.assert( !o.defaultResourceKind || !_.path.isGlob( o.defaultResourceKind ), () => 'Expects non glob {-defaultResourceKind-}, but got ' + _.strQuote( o.defaultResourceKind ) );

  if( o.src === null )
  o.src = o.baseModule;

  return o;
}

//

function resolve_body( o )
{
  let resolver = this;
  let module = o.baseModule;
  let will = module.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let currentContext = o.currentContext = o.currentContext || module;

  _.assert( o.src instanceof will.OpenedModule );

  o.currentThis = resolver.resolveContextPrepare
  ({
    currentThis : o.currentThis,
    currentContext : o.currentContext,
    baseModule : o.baseModule,
  });

  return Parent.resolve.body.call( resolver, o );
}

var defaults = resolve_body.defaults = Object.create( Parent.resolve.body.defaults );

defaults.currentThis = null;
defaults.currentContext = null;
defaults.baseModule = null;
defaults.criterion = null;
defaults.pathResolving = 'in';
defaults.pathNativizing = 0;
defaults.pathUnwrapping = 1;
defaults.strictCriterion = 0;
defaults.currentExcluding = 1;
defaults.hasPath = null;
defaults.selectorIsPath = 0;

let resolve = _.routineFromPreAndBody( resolve_pre, resolve_body );
let resolveMaybe = _.routineFromPreAndBody( resolve_pre, resolve_body );

var defaults = resolveMaybe.defaults;
defaults.missingAction = 'undefine';

//

function _resolveAct( o )
{
  let resolver = this;
  let module = o.baseModule;
  let will = module.will;
  let currentContext = o.currentContext;

  if( !( o.currentContext instanceof will.AbstractModule ) )
  if( o.criterion === null && o.currentContext && o.currentContext.criterion )
  o.criterion = o.currentContext.criterion;

  _.assert( o.criterion === null || _.mapIs( o.criterion ) );
  _.assert( o.baseModule instanceof will.AbstractModule );

  o.iterationPreserve = o.iterationPreserve || Object.create( null );
  o.iterationPreserve.exported = null;
  o.iterationPreserve.currentModule = o.baseModule;
  o.iterationPreserve.selectorIsPath = 0;

  let result = Parent._resolveAct.call( resolver, o );

  return result;
}

var defaults = _resolveAct.defaults = Object.create( resolve.defaults )

defaults.visited = null;

// --
// special
// --

// function _onResolveBegin( o )
// {
//
//   let module = o.baseModule;
//   let will = module.will;
//   let currentContext = o.currentContext;
//
//   if( !( o.currentContext instanceof will.AbstractModule ) )
//   if( o.criterion === null && o.currentContext && o.currentContext.criterion )
//   o.criterion = o.currentContext.criterion;
//
//   _.assert( o.criterion === null || _.mapIs( o.criterion ) );
//   _.assert( o.baseModule instanceof will.AbstractModule );
//   _.assert( Self === will.Resolver );
//
// }

// --
// wraps
// --

let resolveRaw = _.routineFromPreAndBody( resolve_pre, resolve_body );

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

let pathResolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

var defaults = pathResolve.defaults;
defaults.pathResolving = 'in';
defaults.prefixlessAction = 'resolved';
defaults.arrayFlattening = 1;
defaults.selectorIsPath = 1;
defaults.mapValsUnwrapping = 1;

//

function filesFromResource_body( o )
{
  let module = o.baseModule;
  let will = module.will;
  let result = [];
  let fileProvider = will.fileProvider
  let path = fileProvider.path;

  let o2 = _.mapExtend( null, o );
  let resources = module.resolve( o2 );

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
    else if( resource instanceof will.Reflector )
    {
      let o2 = resource.optionsForFindExport();
      o2.outputFormat = 'absolute';
      o2.mode = 'distinct';
      let files = fileProvider.filesFind( o2 );
      filesAdd( files );
    }
    else if( _.strIs( resource ) || _.arrayIs( resource ) || _.mapIs( resource ) )
    {
      let o2 = Object.create( null );
      o2.filter = Object.create( null );
      // o2.filter.filePath = resource.path;
      o2.filter.filePath = resource;
      o2.outputFormat = 'absolute';
      o2.mode = 'distinct';
      let files = fileProvider.filesFind( o2 );
      filesAdd( files );
    }
    else _.assert( 0, 'Unknown type of resource ' + _.strType( resource ) );

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

let filesFromResource = _.routineFromPreAndBody( resolve_pre, filesFromResource_body );

//

function reflectorResolve_body( o )
{
  let module = o.baseModule;
  let will = module.will;

  let o2 = _.mapExtend( null, o );
  o2.pathResolving = 'in';
  let reflector = module.resolve( o2 );

  /*
    `pathResolving` should be `in` for proper resolving of external resources
  */

  if( o.missingAction === 'undefine' && reflector === undefined )
  return reflector;
  else if( o.missingAction === 'error' && _.errIs( reflector ) )
  return reflector;

  if( reflector instanceof will.Reflector )
  {
    _.sure( reflector instanceof will.Reflector, () => 'Reflector ' + o.selector + ' was not found' + _.strType( reflector ) );
    reflector.form();
    _.assert( reflector.formed === 3, () => reflector.nickName + ' is not formed' );
  }

  return reflector;
}

var defaults = reflectorResolve_body.defaults = Object.create( resolve.defaults );
defaults.selector = null;
defaults.defaultResourceKind = 'reflector';
defaults.prefixlessAction = 'default';
defaults.currentContext = null;
defaults.pathResolving = 'in';

let reflectorResolve = _.routineFromPreAndBody( resolve_pre, reflectorResolve_body );

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

let submodulesResolve = _.routineFromPreAndBody( resolve.pre, submodulesResolve_body );

// --
// declare
// --

let Extend =
{

  name : 'wWillResolver',
  shortName : 'Resolver',

  // handler

  _onSelectorDown,
  _onUpBegin,
  _onUpEnd,
  _onDownEnd,
  _onQuantitativeFail,

  //

  _statusPreUpdate,
  _statusPostUpdate,
  _globCriterionFilter,
  _resourceMapSelect,

  _exportedWriteThrough,
  _currentExclude,

  // path

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

  // err

  errResolving,

  // resolve

  resolveContextPrepare,
  resolve,
  resolveMaybe,
  _resolveAct,

  // wraps

  resolveRaw,
  pathResolve,
  filesFromResource,
  reflectorResolve,
  submodulesResolve,

}

_.mapExtend( Self, Extend );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
