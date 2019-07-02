( function _Resolver_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

let _ = wTools;

// --
// parser
// --

function strRequestParse( srcStr )
{

  if( Self._selectorIs( srcStr ) )
  {
    let left, right;
    let splits = _.strSplit( srcStr );

    if( splits.length > 1 )
    debugger;

    for( let s = splits.length - 1 ; s >= 0 ; s-- )
    {
      let split = splits[ s ];
      if( Self._selectorIs( split ) )
      {
        left = splits.slice( 0, s+1 ).join( ' ' );
        right = splits.slice( s+1 ).join( ' ' );
      }
    }
    let result = _.strRequestParse( right );
    result.subject = left + result.subject;
    result.subjects = [ result.subject ];
    return result;
  }

  let result = _.strRequestParse( srcStr );
  return result;
}

//

function _selectorIs( selector )
{
  if( !_.strIs( selector ) )
  return false;
  if( !_.strHas( selector, '::' ) )
  return false;
  return true;
}

//

function selectorIs( selector )
{
  if( _.arrayIs( selector ) )
  {
    for( let s = 0 ; s < selector.length ; s++ )
    if( this.selectorIs( selector[ s ] ) )
    return true;
  }
  return this._selectorIs( selector );
}

//

function selectorIsComposite( selector )
{

  if( !this.selectorIs( selector ) )
  return false;

  if( _.arrayIs( selector ) )
  {
    for( let s = 0 ; s < selector.length ; s++ )
    if( isComposite( selector[ s ] ) )
    return true;
  }
  else
  {
    return isComposite( selector );
  }

  /* */

  function isComposite( selector )
  {

    let splits = _.strSplitFast
    ({
      src : selector,
      delimeter : [ '{', '}' ],
    });

    if( splits.length < 5 )
    return false;

    splits = _.strSplitsCoupledGroup({ splits : splits, prefix : '{', postfix : '}' });

    if( !splits.some( ( split ) => _.arrayIs( split ) ) )
    return false;

    return true;
  }

}

function _selectorShortSplit( selector )
{
  _.assert( !_.strHas( selector, '/' ) );
  let result = _.strIsolateLeftOrNone( selector, '::' );
  _.assert( result.length === 3 );
  result[ 1 ] = result[ 1 ] || '';
  return result;
}

//

function selectorShortSplit( o )
{
  let result;

  _.assertRoutineOptions( selectorShortSplit, o );
  _.assert( arguments.length === 1 );
  _.assert( !_.strHas( o.selector, '/' ) );
  _.sure( _.strIs( o.selector ) || _.strsAreAll( o.selector ), 'Expects string, but got', _.strType( o.selector ) );

  let splits = this._selectorShortSplit( o.selector );

  if( !splits[ 0 ] && o.defaultResourceKind )
  {
    splits = [ o.defaultResourceKind, '::', o.selector ];
  }

  return splits;
}

var defaults = selectorShortSplit.defaults = Object.create( null )
defaults.selector = null
defaults.defaultResourceKind = null;

//

function selectorLongSplit( o )
{
  let result = [];

  if( _.strIs( o ) )
  o = { selector : o }

  _.routineOptions( selectorLongSplit, o );
  _.assert( arguments.length === 1 );
  _.sure( _.strIs( o.selector ) || _.strsAreAll( o.selector ), 'Expects string, but got', _.strType( o.selector ) );

  let selectors = o.selector.split( '/' );

  selectors.forEach( ( selector ) =>
  {
    let o2 = _.mapExtend( null, o );
    o2.selector = selector;
    result.push( this.selectorShortSplit( o2 ) );
  });

  return result;
}

var defaults = selectorLongSplit.defaults = Object.create( null )
defaults.selector = null
defaults.defaultResourceKind = null;

//

function selectorParse( o )
{
  let self = this;
  let result = [];

  if( _.strIs( o ) )
  o = { selector : o }

  _.routineOptions( selectorParse, o );
  _.assert( arguments.length === 1 );
  _.sure( _.strIs( o.selector ) || _.strsAreAll( o.selector ), 'Expects string, but got', _.strType( o.selector ) );

  let splits = _.strSplitFast
  ({
    src : o.selector,
    delimeter : [ '{', '}' ],
  });

  splits = _.strSplitsCoupledGroup({ splits : splits, prefix : '{', postfix : '}' });

  if( splits[ 0 ] === '' )
  splits.splice( 0, 1 );
  if( splits[ splits.length-1 ] === '' )
  splits.splice( splits.length-1, 1 );

  splits = splits.map( ( split ) =>
  {
    if( !_.arrayIs( split ) )
    return split;
    _.assert( split.length === 3 )
    if( !this.selectorIs( split[ 1 ] ) )
    return split.join( '' );

    let o2 = _.mapExtend( null, o );
    o2.selector = split[ 1 ];
    return this.selectorLongSplit( o2 );
  });

  splits = _.strSplitsUngroupedJoin( splits );

  if( splits.length === 1 && _.strIs( splits[ 0 ] ) && self.selectorIs( splits[ 0 ] ) )
  {
    let o2 = _.mapExtend( null, o );
    o2.selector = splits[ 0 ];
    splits[ 0 ] = self.selectorLongSplit( o2 );
  }

  return splits;
}

var defaults = selectorParse.defaults = Object.create( null )
defaults.selector = null
defaults.defaultResourceKind = null;

//

function selectorStr( parsedSelector )
{
  let self = this;

  if( _.strIs( parsedSelector ) )
  return parsedSelector;

  let result = '';

  for( let i = 0 ; i < parsedSelector.length ; i++ )
  {
    let inline = parsedSelector[ i ];
    if( _.strIs( inline ) )
    {
      result += inline;
    }
    else
    {
      _.arrayIs( inline )
      result += '{';
      for( let s = 0 ; s < inline.length ; s++ )
      {
        let split = inline[ s ];
        _.assert( _.arrayIs( split ) && split.length === 3 );
        if( s > 0 )
        result += '/';
        result += split.join( '' );
      }
      result += '}';
    }
  }

  return result;
}

//

function selectorNormalize( src )
{
  let self = this;

  if( !self.selectorIs( src ) )
  return src;

  let parsed = self.selectorParse( src );
  let result = self.selectorStr( parsed );

  return result;
}

// --
// iterator methods
// --

function _onSelector( selector )
{
  let it = this;
  let rop = it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( !_.strIs( selector ) )
  return;

  if( will.Resolver._selectorIs( selector ) )
  {
    return Self._onSelectorComposite.call( it, selector );
  }

  if( rop.prefixlessAction === 'default' )
  {
    return selector;
  }
  else if( rop.prefixlessAction === 'throw' || rop.prefixlessAction === 'error' )
  {
    debugger;
    it.iterator.continue = false;
    let err = Self.errResolving
    ({
      selector : selector,
      currentContext : currentContext,
      err : _.ErrorLooking( 'Resource selector should have prefix' ),
      baseModule : rop.baseModule,
    });
    if( rop.prefixlessAction === 'throw' )
    throw err;
    it.dst = err;
    return;
  }
  else if( rop.prefixlessAction === 'resolved' )
  {
    return;
  }
  else _.assert( 0 );

}

//

let _onSelectorComposite = _.select.functor.onSelectorComposite({ isStrippedSelector : 1 });
/* let _onSelectorDown = _.select.functor.onSelectorDownComposite({}); */

//

function _onSelectorDown()
{
  let it = this;
  let rop = it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( it.continue && _.arrayIs( it.dst ) && it.src.rejoin === _.hold )
  {

    for( let d = 0 ; d < it.dst.length ; d++ )
    if( _.errIs( it.dst[ d ] ) )
    throw it.dst[ d ];

    it.dst = _.strJoin( it.dst );

    _pathsNativize1.call( it );

  }
  else
  {

    _arrayFlatten.call( it );

  }

}

//

function _onUpBegin()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  _statusPreUpdate.call( it );
  _globCriterionFilter.call( it );

  if( !it.dstWritingDown )
  return;

  /*
  _resourceMapSelect, _statusPostUpdate should go after _queryParse
  */

  _queryParse.call( it );
  _resourceMapSelect.call( it );
  _statusPostUpdate.call( it );

}

//

function _onUpEnd()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  // if( rop.selector === 'path::export' )
  // debugger;

  if( !it.dstWritingDown )
  return;

  _exportedWriteThrough.call( it );
  _currentExclude.call( it );

  if( it.dstWritingDown )
  _pathsCompositeResolve.call( it );

  if( it.dstWritingDown )
  if( rop.pathResolving || it.isFunction )
  _pathsResolve.call( it );

  if( rop.pathUnwrapping )
  _pathsUnwrap.call( it );

}

//

function _onDownEnd()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( !it.dstWritingDown )
  return;

  if( it.dstWritingDown )
  if( rop.pathNativizing || it.isFunction )
  _pathsNativize1.call( it );
  // _pathsNativize2.call( it );

  _functionStringsJoinDown.call( it );
  _mapsFlatten.call( it );
  _mapValsUnwrap.call( it );
  _arrayFlatten.call( it );
  _singleUnwrap.call( it );

}

//

function _onQuantitativeFail( err )
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

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

//

function _pathsNativize1()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  let resource = it.dst;

  if( !rop.pathNativizing )
  return;

  debugger;

  if( it.selectMultipleOptions )
  {
    debugger;
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
    return _pathNativize1.call( it, resource );
    if( resource instanceof will.PathResource )
    {
      resource = resource.cloneDerivative();
      _.assert( resource.path === null || _.arrayIs( resource.path ) || _.strIs( resource.path ) );
      if( resource.path )
      resource.path = _pathNativize1.call( it, resource.path );
    }
    else debugger;
    return resource;
  });

}

// //
//
// function _pathsNativize2()
// {
//   let it = this;
//   let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
//   let will = rop.baseModule.will;
//   let currentModule = it.currentModule;
//   let resource = it.dst;
//
//   if( it.selectorIsPath )
//   {
//     if( it.down && it.down.selectorIsPath )
//     return;
//     if( it.dst )
//     it.dst = _.map( it.dst, ( resource ) =>
//     {
//       if( _.strIs( resource ) )
//       return _pathNativize2.call( it, resource );
//       if( resource instanceof will.PathResource )
//       {
//         resource = resource.cloneDerivative();
//         _.assert( resource.path === null || _.arrayIs( resource.path ) || _.strIs( resource.path ) );
//         if( resource.path )
//         resource.path = _pathNativize2.call( it, resource.path );
//       }
//       else debugger;
//       return resource;
//     });
//     return;
//   }
//
// }
//
//

function _pathNativize1( filePath )
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
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

// //
//
// function _pathNativize2( filePath )
// {
//   let it = this;
//   let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
//   let will = rop.baseModule.will;
//   let currentModule = it.currentModule;
//   let result = filePath;
//
//   _.assert( _.strIs( filePath ) || _.strsAreAll( filePath ) );
//
//   result = will.fileProvider.providersWithProtocolMap.file.path.s.nativize( result );
//
//   return result;
// }
//
//

function _pathCompositeResolve( currentModule, currentResource, filePath, resolving )
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  let result = filePath;

  _.assert( _.strIs( result ) || _.strsAreAll( result ) );
  _.assert( arguments.length === 4 );

  if( will.Resolver.selectorIsComposite( result ) )
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
  let will = rop.baseModule.will;
  let currentModule = it.currentModule;
  let resource = it.dst;

  if( resource instanceof will.Reflector )
  {
    if( will.Resolver.selectorIsComposite( resource.src.prefixPath ) || will.Resolver.selectorIsComposite( resource.dst.prefixPath ) )
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
    if( will.Resolver.selectorIsComposite( resource.path ) )
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

  if( will.Resolver.selectorIs( prefixPath ) )
  prefixPath = currentModule.pathResolve({ selector : prefixPath, currentContext : it.dst });
  if( will.Resolver.selectorIs( result ) )
  result = currentModule.pathResolve({ selector : result, currentContext : it.dst });

  result = path.s.join( currentModule.dirPath, prefixPath, result );

  return result;
}

//

function _pathsResolve()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  let currentModule = it.currentModule;
  let resource = it.dst;

  if( it.dst instanceof will.Reflector )
  {
    resource = it.dst = it.dst.cloneDerivative();

    _.assert( resource.formed >= 1 );

    let srcHasAnyPath = resource.src.hasAnyPath();
    let dstHasAnyPath = resource.dst.hasAnyPath();

    if( srcHasAnyPath || dstHasAnyPath )
    {
      if( srcHasAnyPath )
      resource.src.prefixPath = _pathResolve.call( it, resource.src.prefixPath || '.' );
      if( dstHasAnyPath )
      resource.dst.prefixPath = _pathResolve.call( it, resource.dst.prefixPath || '.' );
    }

  }

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
  let will = rop.baseModule.will;
  let currentModule = it.currentModule;

  if( it.dst instanceof will.PathResource )
  it.dst = it.dst.path;

}

//

function _arrayFlatten()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  let currentModule = it.currentModule;

  _.assert( _.mapIs( rop ) );

  if( !rop.arrayFlattening || !_.arrayIs( it.dst ) )
  return;

  it.dst = _.arrayFlattenDefined( it.dst );

}

//

function _arrayWrap( result )
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( !rop.arrayWrapping )
  return;

  if( !_.mapIs( it.dst ) )
  it.dst = _.arrayAs( it.dst );

}

//

function _mapsFlatten()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( !rop.mapFlattening || !_.mapIs( it.dst ) )
  return;

  it.dst = _.mapsFlatten([ it.dst ]);

}

// //
//
// function _mapsFlatten2( result )
// {
//   if( o.mapFlattening && _.mapIs( result ) )
//   result = _.mapsFlatten([ result ]);
//   return result;
// }

//

function _mapValsUnwrap()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( !rop.mapValsUnwrapping )
  return;
  if( !_.mapIs( it.dst ) )
  return;
  if( !_.all( it.dst, ( e ) => _.instanceIs( e ) || _.primitiveIs( e ) ) )
  return;

  it.dst = _.mapVals( it.dst );
}

// //
//
// function _mapValsUnwrap2( result )
// {
//   if( !o.mapValsUnwrapping )
//   return result
//   if( !_.mapIs( result ) )
//   return result;
//   if( !_.all( result, ( e ) => _.instanceIs( e ) || _.primitiveIs( e ) ) )
//   return result;
//   return _.mapVals( result );
// }

//

function _singleUnwrap()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( !rop.singleUnwrapping )
  return;

  if( _.any( it.dst, ( e ) => _.mapIs( e ) || _.arrayIs( e ) ) )
  return;

  if( _.mapIs( it.dst ) )
  {
    if( _.mapKeys( it.dst ).length === 1 )
    it.dst = _.mapVals( it.dst )[ 0 ];
  }
  else if( _.arrayIs( it.dst ) )
  {
    if( it.dst.length === 1 )
    it.dst = it.dst[ 0 ];
  }

}

// //
//
// function _singleUnwrap2( result )
// {
//
//   if( !o.singleUnwrapping )
//   return result;
//
//   if( _.any( result, ( e ) => _.mapIs( e ) || _.arrayIs( e ) ) )
//   return result;
//
//   if( _.mapIs( result ) )
//   {
//     if( _.mapKeys( result ).length === 1 )
//     result = _.mapVals( result )[ 0 ];
//   }
//   else if( _.arrayIs( result ) )
//   {
//     if( result.length === 1 )
//     result = result[ 0 ];
//   }
//
//   return result;
// }

//

function _statusPreUpdate()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;

  if( !it.src )
  return;

  _.assert( !_.mapHasKey( it.src, 'rejoin' ) );

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

function _queryParse()
{
  let it = this;
  let rop = it.resolveOptions;
  let will = rop.baseModule.will;

  if( !it.selector )
  return;

  _.assert( it.currentModule instanceof will.OpenedModule );

  let splits = will.Resolver.selectorShortSplit
  ({
    selector : it.selector,
    defaultResourceKind : rop.defaultResourceKind,
  });

  it.parsedSelector = Object.create( null );
  it.parsedSelector.kind = splits[ 0 ];

  if( !it.parsedSelector.kind )
  {
    if( splits[ 1 ] !== undefined )
    it.parsedSelector.kind = null;
  }

  it.parsedSelector.full = splits.join( '' );
  it.selector = it.parsedSelector.name = splits[ 2 ];

}

//

function _resourceMapSelect()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  let sop = it.selectOptions;
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

    if( it.selector === 'strings.join' )
    {
      _functionStringsJoinUp.call( it );
    }
    else if( it.selector === 'os' )
    {
      _functionOsGetUp.call( it );
    }
    else if( it.selector === 'this' )
    {
      _functionThisUp.call( it );
    }
    else _.sure( 0, 'Unknown function', it.parsedSelector.full );

  }
  else
  {

    // if( _.path.isGlob( kind ) )
    // it.src = it.currentModule.resourceMaps();
    // else
    // it.src = it.currentModule.resourceMapForKind( kind );

    it.src = it.currentModule.resourceMapsForKind( kind );

    // if( !_.path.isGlob( resourceSelector ) )
    // return module.resourceMapForKind( resourceSelector );
    // let resources = module.resourceMaps();
    // let result = _.path.globFilterKeys( resources, resourceSelector );
    // return result;

    if( _.strIs( kind ) && path.isGlob( kind ) )
    {
      sop.selectorArray.splice( it.logicalLevel-1, 1, '*', it.selector );
      it.selector = sop.selectorArray[ it.logicalLevel-1 ];
      sop.selectorChanged.call( it );
    }

    if( !it.src )
    {
      debugger;
      throw _.ErrorLooking( 'No resource map', _.strQuote( it.parsedSelector.full ) );
    }

  }

  it.srcChanged();
}

//

function _exportedWriteThrough()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
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
  let will = rop.baseModule.will;

  if( rop.currentExcluding )
  if( it.src === rop.currentContext && it.down )
  it.dstWritingDown = false;

}

//

function _functionStringsJoinUp()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  let sop = it.selectOptions;

  _.sure( !!it.down, () => it.parsedSelector.full + ' expects context to join it' );

  it.src = [ it.src ];
  it.src[ functionSymbol ] = it.selector;

  it.selector = 0;
  it.isFunction = it.selector;
  sop.selectorChanged.call( it );

}

//

function _functionStringsJoinDown()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  let sop = it.selectOptions;

  if( !_.arrayIs( it.src ) || !it.src[ functionSymbol ] )
  return;

  debugger;
  if( _.arrayIs( it.dst ) && it.dst.every( ( e ) => _.arrayIs( e ) ) )
  {
    it.dst = it.dst.map( ( e ) => e.join( ' ' ) );
  }
  else
  {
    it.dst = it.dst.join( ' ' );
  }

}

//

function _functionOsGetUp()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  let sop = it.selectOptions;
  let Os = require( 'os' );
  let os = 'posix';

  if( Os.platform() === 'win32' )
  os = 'windows';
  else if( Os.platform() === 'darwin' )
  os = 'osx';

  it.src = os;
  it.dst = os;
  it.selector = undefined;
  sop.selectorChanged.call( it );

}

//

function _functionThisUp()
{
  let it = this;
  let rop = it.resolveOptions ? it.resolveOptions : it.selectMultipleOptions.iteratorExtension.resolveOptions;
  let will = rop.baseModule.will;
  let sop = it.selectOptions;
  let currentThis = rop.currentThis;

  debugger;

  if( currentThis === null )
  currentThis = Self.resolveContextPrepare
  ({
    baseModule : rop.baseModule,
    currentThis : currentThis,
    currentContext : rop.currentContext,
    force : 1,
  });

  it.src = [ currentThis ];
  it.selector = 0;

  sop.selectorChanged.call( it );

}

// --
// err
// --

function errResolving( o )
{
  let Self = this;
  let module = o.baseModule;
  _.assertRoutineOptions( errResolving, arguments );
  if( o.currentContext && o.currentContext.nickName )
  return _.err( 'Failed to resolve', _.color.strFormat( o.selector, 'code' ), 'for', o.currentContext.decoratedNickName, 'in', module.decoratedNickName, '\n', o.err );
  else
  return _.err( 'Failed to resolve', _.color.strFormat( o.selector, 'code' ), 'in', module.decoratedNickName, '\n', o.err );
}

errResolving.defaults =
{
  err : null,
  selector : null,
  currentContext : null,
  baseModule : null,
}

//

function errThrow( o )
{
  let Self = this;
  let module = o.baseModule;
  _.assertRoutineOptions( errThrow, arguments );
  if( o.missingAction === 'undefine' )
  return;
  debugger;
  let err = Self.errResolving
  ({
    selector : o.selector,
    currentContext : o.currentContext,
    err : o.err,
    baseModule : o.baseModule,
  });
  if( o.missingAction === 'throw' )
  throw err;
  else
  return err;

}

errThrow.defaults =
{
  missingAction : null,
  err : null,
  selector : null,
  currentContext : null,
  baseModule : null,
}

// --
// Self
// --

function resolveContextPrepare( o )
{
  let Self = this;
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
  let Self = this;
  let o = args[ 0 ];

  if( _.strIs( o ) || _.arrayIs( o ) )
  o = { selector : o }

  _.routineOptions( routine, o );

  if( o.visited === null )
  o.visited = [];

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( _.arrayHas( [ null, 0, false, 'in', 'out' ], o.pathResolving ), 'Unknown value of option path resolving', o.pathResolving );
  _.assert( _.arrayHas( [ 'undefine', 'throw', 'error' ], o.missingAction ), 'Unknown value of option missing action', o.missingAction );
  _.assert( _.arrayHas( [ 'default', 'resolved', 'throw', 'error' ], o.prefixlessAction ), 'Unknown value of option prefixless action', o.prefixlessAction );
  _.assert( _.arrayIs( o.visited ) );
  _.assert( !o.defaultResourceKind || !_.path.isGlob( o.defaultResourceKind ), 'Expects non glob {-defaultResourceKind-}' );

  return o;
}

//

function resolve_body( o )
{
  let Self = this;
  let module = o.baseModule;
  let will = module.will;
  let hardDrive = will.fileProvider.providersWithProtocolMap.file;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let currentContext = o.currentContext = o.currentContext || module;

  _.assert( !!Self._resolveAct );
  _.assert( o.prefixlessAction === 'default' || o.defaultResourceKind === null, 'Prefixless action should be "default" if default resource is provided' );

  o.currentThis = Self.resolveContextPrepare
  ({
    currentThis : o.currentThis,
    currentContext : o.currentContext,
    baseModule : o.baseModule,
  });

  let result = Self._resolveAct( o );

  if( result === undefined )
  {
    result = Self.errResolving
    ({
      selector : o.selector,
      currentContext : o.currentContext,
      err : _.ErrorLooking( o.selector, 'was not found' ),
      baseModule : o.baseModule,
    })
  }

  if( _.errIs( result ) )
  {
    return Self.errThrow
    ({
      selector : o.selector,
      missingAction : o.missingAction,
      err : result,
      currentContext : o.currentContext,
      baseModule : o.baseModule,
    });
  }

  let it =
  {
    dst : result,
    resolveOptions : o,
  }

  _mapsFlatten.call( it );
  _mapValsUnwrap.call( it );
  _singleUnwrap.call( it );
  _arrayWrap.call( it );

  return it.dst;
}

resolve_body.defaults =
{
  selector : null,
  defaultResourceKind : null,
  prefixlessAction : 'resolved',
  missingAction : 'throw',
  visited : null,
  currentThis : null,
  currentContext : null,
  baseModule : null,
  criterion : null,
  // submodulesUniquing : 1,
  pathResolving : 'in',
  pathNativizing : 0,
  pathUnwrapping : 1,
  singleUnwrapping : 1,
  mapValsUnwrapping : 1,
  mapFlattening : 1,
  arrayWrapping : 0,
  arrayFlattening : 1,
  // arrayUniquing : 0,
  preservingIteration : 0,
  strictCriterion : 0,
  currentExcluding : 1,
  hasPath : null,
  selectorIsPath : 0,
}

let resolve = _.routineFromPreAndBody( resolve_pre, resolve_body );
let resolveMaybe = _.routineFromPreAndBody( resolve_pre, resolve_body );

var defaults = resolveMaybe.defaults;
defaults.missingAction = 'undefine';

//

function _resolveAct( o )
{
  let Self = this;
  let module = o.baseModule;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result;
  let currentContext = o.currentContext;

  if( !( o.currentContext instanceof will.AbstractModule ) )
  if( o.criterion === null && o.currentContext && o.currentContext.criterion )
  o.criterion = o.currentContext.criterion;

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( _resolveAct, arguments );
  _.assert( o.criterion === null || _.mapIs( o.criterion ) );
  _.assert( _.arrayIs( o.visited ) );
  _.assert( o.baseModule instanceof will.AbstractModule );
  _.assert( Self === will.Resolver );

  /* */

  try
  {

    result = _.select
    ({
      src : module,
      selector : o.selector,
      preservingIteration : o.preservingIteration,
      missingAction : o.missingAction,
      // missingAction : o.missingAction === 'undefine' ? 'undefine' : 'error', // yyy

      onSelector : _onSelector,
      onSelectorDown : _onSelectorDown,
      onUpBegin : _onUpBegin,
      onUpEnd : _onUpEnd,
      onDownEnd : _onDownEnd,
      onQuantitativeFail : _onQuantitativeFail,

      iteratorExtension :
      {
        resolveOptions : o,
      },
      iterationExtension :
      {
      },
      iterationPreserve :
      {
        currentModule : o.baseModule,
        exported : null,
        isFunction : null,
        selectorIsPath : 0,
      },
    });

  }
  catch( err )
  {
    debugger;
    throw Self.errResolving
    ({
      selector : o.selector,
      currentContext : currentContext,
      err : err,
      baseModule : o.baseModule,
    });
  }

  return result;
}

var defaults = _resolveAct.defaults = Object.create( resolve.defaults )

defaults.visited = null;

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

//

let pathResolve = _.routineFromPreAndBody( resolve_pre, resolve_body );

var defaults = pathResolve.defaults;
defaults.pathResolving = 'in';
defaults.prefixlessAction = 'resolved';
defaults.selectorIsPath = 1;
defaults.arrayFlattening = 1;

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

let functionSymbol = Symbol.for( 'function' );
let Self =
{

  name : 'wWillResolver',
  shortName : 'Resolver',

  // parser

  strRequestParse,

  _selectorIs,
  selectorIs,
  selectorIsComposite,
  _selectorShortSplit,
  selectorShortSplit,
  selectorLongSplit,
  selectorParse,
  selectorStr,
  selectorNormalize,

  // iterator methods

  _onSelector,
  _onSelectorComposite,
  _onSelectorDown,
  _onUpBegin,
  _onUpEnd,
  _onDownEnd,
  _onQuantitativeFail,

  _pathNativize1,
  _pathsNativize1,
  _pathCompositeResolve,
  _pathsCompositeResolve,
  _pathResolve,
  _pathsResolve,
  _pathsUnwrap,

  _arrayFlatten,
  _arrayWrap,
  _mapsFlatten,
  _mapValsUnwrap,
  _singleUnwrap,

  _statusPreUpdate,
  _statusPostUpdate,
  _globCriterionFilter,
  _queryParse,
  _resourceMapSelect,
  _exportedWriteThrough,
  _currentExclude,

  _functionStringsJoinUp,
  _functionStringsJoinDown,
  _functionOsGetUp,
  _functionThisUp,

  // err

  errResolving,
  errThrow,

  // Self

  resolveContextPrepare,
  resolve,
  resolveMaybe,
  _resolveAct,

  // wraps

  resolveRaw,
  pathResolve,
  reflectorResolve,
  submodulesResolve,

}

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
