( function _Selector_s_() {

'use strict';

/**
 * Collection of routines to select a sub-structure from a complex data structure. Use the module to transform a data structure with the help of a short selector string.
  @module Tools/base/Selector
*/

/**
 * @file l5/Selector.s.
 */

/**
 * Collection of routines to select a sub-structure from a complex data structure.
  @namespace Tools( module::Selector )
  @memberof module:Tools/base/Selector
*/

/*
xxx qqq : optimize selector
          use test routine filesFindGlob of test suite FilesFind.Extract.test.s
          Extract use selectro extensively
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wLooker' );
  _.include( 'wReplicator' );
  _.include( 'wPathTools' );

}

let _global = _global_;
let _ = _global_.wTools;
let Parent = _.Looker;

_.assert( !!_realGlobal_ );

// --
// routine
// --

function selectSingle_pre( routine, args )
{

  let o = args[ 0 ]
  if( args.length === 2 )
  {
    // if( _.lookIterationIs( args[ 0 ] ) )
    if( Self.iterationIs( args[ 0 ] ) )
    o = { it : args[ 0 ], selector : args[ 1 ] }
    else
    o = { src : args[ 0 ], selector : args[ 1 ] }
  }

  _.routineOptionsPreservingUndefines( routine, o );
  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( o.onUpBegin === null || _.routineIs( o.onUpBegin ) );
  _.assert( o.onDownBegin === null || _.routineIs( o.onDownBegin ) );
  _.assert( _.strIs( o.selector ) );
  _.assert( _.strIs( o.downToken ) );
  _.assert( _.arrayHas( [ 'undefine', 'ignore', 'throw', 'error' ], o.missingAction ), 'Unknown missing action', o.missingAction );
  _.assert( o.selectorArray === undefined );

  if( o.it )
  {
    _.assert( o.prevSelectIteration === null || o.prevSelectIteration === o.it );
    _.assert( o.src === null );
    // _.assert( _.lookIterationIs( o.it ) );
    _.assert( Self.iterationIs( o.it ), () => 'Expects iteration of ' + Self.constructor.name + ' but got ' + _.toStrShort( o.it ) );
    _.assert( _.strIs( o.it.iterator.selector ) );
    if( o.it.iterator.selector === undefined )
    o.it.iterator.selector = '';
    _.assert( _.strIs( o.it.iterator.selector ) );
    o.src = o.it.iterator.src;
    o.selector = o.it.iterator.selector + _.strsShortest( o.it.iterator.upToken ) + o.selector;
    o.it.iterator.selector = o.selector;
    o.prevSelectIteration = o.it;
  }

  if( o.setting === null && o.set !== null )
  o.setting = 1;

  let o2 = optionsFor( o );
  let it = _.look.pre( selectIt_body, [ o2 ] );
  _.assert( Object.hasOwnProperty.call( it.iterator, 'selector' ) );
  _.assert( Object.hasOwnProperty.call( it, 'selector' ) );

  if( _.numberIs( it.iterator.selector ) )
  it.iterator.selectorArray = [ it.iterator.selector ];
  else
  it.iterator.selectorArray = split( it.iterator.selector );

  _.assert( o.it === it || o.it === null );

  return it;

  /* */

  function split( selector )
  {
    let splits = _.strSplit
    ({
      src : selector,
      delimeter : o.upToken,
      preservingDelimeters : 0,
      preservingEmpty : 1,
      preservingQuoting : 0,
      stripping : 1,
    });

    if( _.strBegins( selector, o.upToken ) )
    splits.splice( 0, 1 );
    if( _.strEnds( selector, o.upToken ) )
    splits.pop();

    return splits;
  }

  /* */

  function optionsFor( o )
  {

    let o2 = o;
    if( o2.Looker === null )
    o2.Looker = Self;
    return o2;
  }

}

//

function selectIt_body( it )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.lookerIs( it.Looker ) );
  _.assert( it.looker === undefined );
  let it2 = _.look.body( it );
  _.assert( it === it2 );
  return it;
}

var defaults = selectIt_body.defaults = Object.create( _.look.defaults )

defaults.Looker = null;
defaults.it = null;
defaults.src = null;
defaults.selector = null;
defaults.missingAction = 'undefine';
defaults.preservingIteration = 0;
defaults.usingIndexedAccessToMap = 0;
defaults.globing = 1;
defaults.trackingVisits = 1;
defaults.upToken = '/';
defaults.downToken = '..';

defaults.replicateIteration = null;
defaults.prevSelectIteration = null;

defaults.set = null;
defaults.setting = null;

defaults.onUpBegin = null;
defaults.onUpEnd = null;
defaults.onDownBegin = null;
defaults.onDownEnd = null;
defaults.onQuantitativeFail = null;

//

/**
 * @summary Selects elements from source object( src ) using provided pattern( selector ).
 * @description Returns iterator with result of selection
 * @param {} src Source entity.
 * @param {String} selector Pattern that matches against elements in a entity.
 *
 * @example //select element with key 'a1'
 * let it = _.selectIt( { a1 : 1, a2 : 2 }, 'a1' );
 * console.log( it.dst )//1
 *
 * @example //select any that starts with 'a'
 * let it = _.selectSingle( { a1 : 1, a2 : 2 }, 'a*' );
 * console.log( it.dst ) // { a1 : 1, a2 : 1 }
 *
 * @example //select with constraint, only one element should be selected
 * let it = _.selectSingle( { a1 : 1, a2 : 2 }, 'a*=1' );
 * console.log( it.error ) // error
 *
 * @example //select with constraint, two elements
 * let it = _.selectSingle( { a1 : 1, a2 : 2 }, 'a*=2' );
 * console.log( it.dst ) // { a1 : 1, a2 : 1 }
 *
 * @example //select inner element using path selector
 * let it = _.selectSingle( { a : { b : { c : 1 } } }, 'a/b' );
 * console.log( it.dst ) //{ c : 1 }
 *
 * @example //select value of each property with name 'x'
 * let it = _.selectSingle( { a : { x : 1 }, b : { x : 2 }, c : { x : 3 } }, '*\/x' );
 * console.log( it.dst ) //{a: 1, b: 2, c: 3}
 *
 * @example // select root
 * let it = _.selectSingle( { a : { b : { c : 1 } } }, '/' );
 * console.log( it.dst )
 *
 * @function selectIt
 * @memberof module:Tools/base/Selector.Tools( module::Selector )
*/

let selectIt = _.routineFromPreAndBody( selectSingle_pre, selectIt_body );

//

function selectSingle_body( it )
{
  let it2 = _.selectIt.body( it );
  _.assert( it2 === it )
  _.assert( arguments.length === 1, 'Expects single argument' );
  // if( it.selectOptions.missingAction === 'error' && it.error )
  // return it.error;
  if( it.missingAction === 'error' && it.error )
  return it.error;
  _.assert( it.error === null );
  return it.dst;
}

_.routineExtend( selectSingle_body, selectIt );

//

/**
 * @summary Selects elements from source object( src ) using provided pattern( selector ).
 * @description Short-cur for {@link module:Tools/base/Selector.Tools( module::Selector ).selectSingle _.selectIt }. Returns found element(s) instead of iterator.
 * @param {} src Source entity.
 * @param {String} selector Pattern that matches against elements in a entity.
 *
 * @example //select element with key 'a1'
 * _.selectSingle( { a1 : 1, a2 : 2 }, 'a1' ); // 1
 *
 * @example //select any that starts with 'a'
 * _.selectSingle( { a1 : 1, a2 : 2 }, 'a*' ); // { a1 : 1, a2 : 1 }
 *
 * @example //select with constraint, only one element should be selected
 * _.selectSingle( { a1 : 1, a2 : 2 }, 'a*=1' ); // error
 *
 * @example //select with constraint, two elements
 * _.selectSingle( { a1 : 1, a2 : 2 }, 'a*=2' ); // { a1 : 1, a2 : 1 }
 *
 * @example //select inner element using path selector
 * _.selectSingle( { a : { b : { c : 1 } } }, 'a/b' ); //{ c : 1 }
 *
 * @example //select value of each property with name 'x'
 * _.selectSingle( { a : { x : 1 }, b : { x : 2 }, c : { x : 3 } }, '*\/x' ); //{a: 1, b: 2, c: 3}
 *
 * @example // select root
 * _.selectSingle( { a : { b : { c : 1 } } }, '/' );
 *
 * @function selectSingle
 * @memberof module:Tools/base/Selector.Tools( module::Selector )
*/

let selectSingle = _.routineFromPreAndBody( selectSingle_pre, selectSingle_body );

//

function select_pre( routine, args )
{

  let o = args[ 0 ]
  if( args.length === 2 )
  {
    // if( _.lookIterationIs( args[ 0 ] ) )
    if( Self.iterationIs( args[ 0 ] ) )
    o = { it : args[ 0 ], selector : args[ 1 ] }
    else
    o = { src : args[ 0 ], selector : args[ 1 ] }
  }

  _.routineOptionsPreservingUndefines( routine, o );

  if( o.root === null )
  o.root = o.src;

  if( o.compositeSelecting )
  {

    if( o.onSelector === onSelector || o.onSelector === null )
    o.onSelector = _.select.functor.onSelectorComposite();
    if( o.onSelectorDown === null )
    o.onSelectorDown = _.select.functor.onSelectorDownComposite();

    _.assert( _.routineIs( o.onSelector ) );
    _.assert( _.routineIs( o.onSelectorDown ) );

  }

  return o;
}

//

function select_body( o )
{

  _.assert( !o.recursive || !!o.onSelector, () => 'For recursive selection onSelector should be defined' );
  _.assert( o.it === null || o.it.constructor === Self.constructor );

  return multipleSelect( o.selector );

  /* */

  function multipleSelect( selector )
  {
    let o2 =
    {
      src : selector,
      onUp,
      onDown,
    }

    o2.iterationPreserve = Object.create( null );
    o2.iterationPreserve.composite = false;
    o2.iterationPreserve.compositeRoot = null;

    o2.iteratorExtension = Object.create( null );
    o2.iteratorExtension.selectMultipleOptions = o;

    let it = _.replicateIt( o2 );

    return it.dst;
  }

  /* */

  function singleOptions()
  {
    let it = this;
    let single = _.mapExtend( null, o );
    single.replicateIteration = it;

    delete single.onSelectorUp;
    delete single.onSelectorDown;
    delete single.onSelector;
    delete single.recursive;
    delete single.dst;
    delete single.root;
    delete single.compositeSelecting;
    delete single.compositePrefix;
    delete single.compositePostfix;

    _.assert( !single.it || single.it.constructor === Self.constructor );

    return single;
  }

  /* */

  function singleSelectFirst()
  {
    let it = this;
    _.assert( _.strIs( it.src ) );
    let dst = singleSelect.call( it, [] );
    return dst;
  }

  /* */

  function singleSelect( visited )
  {
    let it = this;

    _.assert( !_.arrayHas( visited, it.src ), () => 'Loop selecting ' + it.src );
    _.assert( arguments.length === 1 );

    visited.push( it.src );

    let single = singleOptions.call( it );
    single.selector = it.src;

    _.assert( _.strIs( single.selector ) );

    let dst = _.selectSingle( single );

    if( o.recursive && visited.length <= o.recursive )
    {
      let selector2 = o.onSelector.call( it, dst );
      if( selector2 !== undefined )
      {
        it.src = selector2;
        return singleSelect.call( it, visited );
      }
    }

    return dst;
  }

  /* */

  function onUp()
  {
    let it = this;

    let selector = o.onSelector.call( it, it.src );
    if( _.strIs( selector ) )
    {
      it.src = selector;
      it.srcChanged();
      it.dst = singleSelectFirst.call( it );
      it.continue = false;
      it.dstSetting = false;
    }
    else if( selector !== undefined )
    {
      if( selector && selector.composite === _.select.composite )
      {
        if( !it.compositeRoot )
        it.compositeRoot = it;
        it.composite = true;
      }
      it.src = selector;
      it.srcChanged();
    }

    if( o.onSelectorUp )
    o.onSelectorUp.call( it, o );
  }

  /* */

  function onDown()
  {
    let it = this;
    if( o.onSelectorDown )
    o.onSelectorDown.call( it, o );
  }

}

_.routineExtend( select_body, selectSingle.body );

var defaults = select_body.defaults;
defaults.root = null;
defaults.onSelectorUp = null;
defaults.onSelectorDown = null;
defaults.onSelector = onSelector;
defaults.recursive = 0;
defaults.compositeSelecting = 0;

//

/**
 * @summary Selects elements from source object( src ) using provided pattern( selector ).
 * @param {} src Source entity.
 * @param {String} selector Pattern that matches against elements in a entity.
 *
 * @example //select element with key 'a1'
 * _.select( { a1 : 1, a2 : 2 }, 'a1' ); // 1
 *
 * @example //select any that starts with 'a'
 * _.select( { a1 : 1, a2 : 2 }, 'a*' ); // { a1 : 1, a2 : 1 }
 *
 * @example //select with constraint, only one element should be selected
 * _.select( { a1 : 1, a2 : 2 }, 'a*=1' ); // error
 *
 * @example //select with constraint, two elements
 * _.select( { a1 : 1, a2 : 2 }, 'a*=2' ); // { a1 : 1, a2 : 1 }
 *
 * @example //select inner element using path selector
 * _.select( { a : { b : { c : 1 } } }, 'a/b' ); //{ c : 1 }
 *
 * @example //select value of each property with name 'x'
 * _.select( { a : { x : 1 }, b : { x : 2 }, c : { x : 3 } }, '*\/x' ); //{a: 1, b: 2, c: 3}
 *
 * @example // select root
 * _.select( { a : { b : { c : 1 } } }, '/' );
 *
 * @example // select from array
 * _.selectSingle( [ 'a', 'b', 'c' ], '2' ); // 'c'
 *
 * @example // select second element from each string of array
 * _.selectSingle( [ 'ax', 'by', 'cz' ], '*\/1' ); // [ 'x', 'y', 'z' ]
 *
 * @function select
 * @memberof module:Tools/base/Selector.Tools( module::Selector )
*/

let select = _.routineFromPreAndBody( select_pre, select_body );

//

/**
 * @summary Short-cut for {@link module:Tools/base/Selector.Tools( module::Selector ).selectSingle _.selectSingle }. Sets value of element selected by pattern ( o.selector ).
 * @param {Object} o Options map
 * @param {} o.src Source entity
 * @param {String} o.selector Pattern to select element(s).
 * @param {} o.set=null Entity to set.
 * @param {Boolean} o.setting=1 Allows to set value for a property or create a new property if needed.
 *
 * @example
 * let src = {};
   _.selectSet({ src, selector : 'a', set : 1 });
   console.log( src.a ); //1
 *
 * @function selectSet
 * @memberof module:Tools/base/Selector.Tools( module::Selector )
*/

let selectSet = _.routineFromPreAndBody( selectSingle.pre, selectSingle.body );

var defaults = selectSet.defaults;
defaults.set = null;
defaults.setting = 1;

//

/**
 * @summary Short-cut for {@link module:Tools/base/Selector.Tools( module::Selector ).selectSingle _.selectSingle }. Returns only unique elements.
 * @param {} src Source entity.
 * @param {String} selector Pattern that matches against elements in a entity.
 *
 * @function select
 * @memberof module:Tools/base/Selector.Tools( module::Selector )
*/

function selectUnique_body( o )
{
  _.assert( arguments.length === 1 );

  let result = _.selectSingle.body( o );

  // if( _.arrayHas( o.selectorArray, '*' ) )
  if( _.strHas( o.selector, '*' ) )
  result = _./*longOnce*/arrayAppendArrayOnce( null, result );

  return result;
}

_.routineExtend( selectUnique_body, selectSingle.body );

let selectUnique = _.routineFromPreAndBody( selectSingle.pre, selectUnique_body );

//

function onSelector( src )
{
  let it = this;
  if( _.strIs( src ) )
  return src;
}

//

function onSelectorComposite_functor( fop )
{

  fop = _.routineOptions( onSelectorComposite_functor, arguments );
  fop.prefix = _.arrayAs( fop.prefix );
  fop.postfix = _.arrayAs( fop.postfix );
  fop.onSelector = fop.onSelector || onSelector;

  _.assert( _.strsAreAll( fop.prefix ) );
  _.assert( _.strsAreAll( fop.postfix ) );
  _.assert( _.routineIs( fop.onSelector ) );

  return function onSelectorComposite( selector )
  {
    let it = this;

    if( !_.strIs( selector ) )
    return;

    let selector2 = _.strSplitFast
    ({
      src : selector,
      delimeter : _.arrayAppendArrays( [], [ fop.prefix, fop.postfix ] ),
    });

    if( selector2[ 0 ] === '' )
    selector2.splice( 0, 1 );
    if( selector2[ selector2.length-1 ] === '' )
    selector2.pop();

    if( selector2.length < 3 )
    {
      if( fop.isStrippedSelector )
      return fop.onSelector.call( it, selector );
      else
      return;
    }

    if( selector2.length === 3 )
    if( _.strsEquivalentAny( fop.prefix, selector2[ 0 ] ) && _.strsEquivalentAny( fop.postfix, selector2[ 2 ] ) )
    return fop.onSelector.call( it, selector2[ 1 ] );

    selector2 = _.strSplitsCoupledGroup({ splits : selector2, prefix : '{', postfix : '}' });

    if( fop.onSelector )
    selector2 = selector2.map( ( split ) =>
    {
      if( !_.arrayIs( split ) )
      return split;
      _.assert( split.length === 3 )
      if( fop.onSelector.call( it, split[ 1 ] ) === undefined )
      return split.join( '' );
      else
      return split;
    });

    selector2 = selector2.map( ( split ) => _.arrayIs( split ) ? split.join( '' ) : split );
    selector2.composite = _.select.composite;

    return selector2;
  }

  function onSelector( selector )
  {
    return selector;
  }

}

onSelectorComposite_functor.defaults =
{
  prefix : '{',
  postfix : '}',
  onSelector : null,
  isStrippedSelector : 0,
}

//

function onSelectorDownComposite_functor( fop )
{
  return function onSelectorDownComposite()
  {
    let it = this;
    if( it.continue && _.arrayIs( it.dst ) && it.src.composite === _.select.composite )
    {
      it.dst = _.strJoin( it.dst );
    }
  }
}

// --
// extend looker
// --

function srcChanged()
{
  let it = this;

  _.assert( arguments.length === 0 );

  if( _.arrayLike( it.src ) )
  {
    it.iterable = 'array-like';
  }
  else if( _.objectIs( it.src ) )
  {
    it.iterable = 'map-like';
  }
  else
  {
    it.iterable = false;
  }

}

//

function selectorChanged()
{
  let it = this;

  _.assert( arguments.length === 0 );

  it.isRelative = it.selector === it.downToken;

  if( it.globing )
  {

    let isGlob;
    if( _.path && _.path.isGlob )
    isGlob = function( selector )
    {
      return _.path.isGlob( selector )
    }
    else
    isGlob = function isGlob( selector )
    {
      return _.strHas( selector, '*' );
    }

    it.isGlob = it.selector ? isGlob( it.selector ) : false;
  }

}

//

function globParse()
{
  let it = this;

  _.assert( arguments.length === 0 );
  _.assert( it.globing );

  let regexp = /(.*){?\*=(\d*)}?(.*)/;
  let match = it.selector.match( regexp );
  it.parsedSelector = it.parsedSelector || Object.create( null );

  if( !match )
  {
    it.parsedSelector.glob = it.selector;
  }
  else
  {
    _.sure( _.strCount( it.selector, '=' ) <= 1, () => 'Does not support selector with several assertions, like ' + _.strQuote( it.selector ) );
    it.parsedSelector.glob = match[ 1 ] + '*' + match[ 3 ];
    if( match[ 2 ].length > 0 )
    {
      it.parsedSelector.limit = _.numberFromStr( match[ 2 ] );
      _.sure( !isNaN( it.parsedSelector.limit ) && it.parsedSelector.limit >= 0, () => 'Epects non-negative number after "=" in ' + _.strQuote( it.selector ) );
    }
  }

}

//

function errNoDown()
{
  let it = this;
  let err = _.ErrorLooking
  (
    'Cant go down', _.strQuote( it.selector ),
    '\nbecause', _.strQuote( it.selector ), 'does not exist',
    '\nat', _.strQuote( it.path ),
    '\nin container\n', _.toStrShort( it.src )
  );
  return err;
}

//

function errNoDownThrow()
{
  let it = this;
  it.continue = false;
  if( it.missingAction === 'undefine' || it.missingAction === 'ignore' )
  {
    it.dst = undefined;
  }
  else
  {
    let err = it.errNoDown();
    it.dst = undefined;
    it.iterator.error = err;
    if( it.missingAction === 'throw' )
    throw err;
  }
}

//

function errCantSet()
{
  let it = this;
  let err = _.err
  (
    'Cant set', _.strQuote( it.key )
  );
  return err;
}

//

function errCantSetThrow()
{
  let it = this;
  throw it.errCantSet();
}

//

function errDoesNotExist()
{
  let it = this;
  let err = _.ErrorLooking
  (
    'Cant select', _.strQuote( it.selector ),
    '\nbecause', _.strQuote( it.selector ), 'does not exist',
    'at', _.strQuote( it.path ),
    '\nin container', _.toStrShort( it.src )
  );
  return err;
}

//

function errDoesNotExistThrow()
{
  let it = this;
  it.continue = false;

  if( it.missingAction === 'undefine' || it.missingAction === 'ignore' )
  {
    it.dst = undefined;
  }
  else
  {
    debugger;
    let err = it.errDoesNotExist();
    it.dst = undefined;
    it.iterator.error = err;
    if( it.missingAction === 'throw' )
    {
      debugger;
      throw err;
    }
  }

}

//

function visitUp()
{
  let it = this;

  it.visitUpBegin();

  it.selector = it.selectorArray[ it.logicalLevel-1 ];
  it.dst = it.src;

  it.dstWriteDown = function dstWriteDown( eit )
  {
    it.dst = eit.dst;
  }

  if( it.onUpBegin )
  it.onUpBegin.call( it );

  if( it.dstWritingDown )
  {

    it.selectorChanged();

    if( it.selector === undefined )
    it.upTerminal();
    else if( it.selector === it.downToken )
    it.upDown();
    else if( it.isGlob )
    it.upGlob();
    else
    it.upSingle();

  }

  if( it.onUpEnd )
  it.onUpEnd.call( it );

  /* */

  _.assert( it.visiting );
  _.assert( _.routineIs( it.onUp ) );
  let r = it.onUp.call( it, it.src, it.key, it );
  _.assert( r === undefined );

  it.visitUpEnd()

}

//

function upTerminal()
{
  let it = this;

  it.continue = false;
  it.dst = it.src;

}

//

function upDown()
{
  let it = this;

  _.assert( it.isRelative === true );

}

//

function upGlob()
{
  let it = this;

  _.assert( it.globing );

  /* !!! qqq : teach it to parse more than single "*=" */

  if( it.globing )
  it.globParse();

  if( it.globing )
  if( it.parsedSelector.glob !== '*' )
  {
    if( it.iterable )
    {
      it.src = _.path.globFilter
      ({
        src : it.src,
        selector : it.parsedSelector.glob,
        onEvaluate : ( e, k ) => k,
      });
      it.srcChanged();
    }
  }

  if( it.iterable === 'array-like' )
  {
    it.dst = [];
    it.dstWriteDown = function( eit )
    {
      if( it.missingAction === 'ignore' && eit.dst === undefined )
      return;
      if( it.preservingIteration )
      it.dst.push( eit );
      else
      it.dst.push( eit.dst );
    }
  }
  else if( it.iterable === 'map-like' )
  {
    it.dst = Object.create( null );
    it.dstWriteDown = function( eit )
    {
      if( it.missingAction === 'ignore' && eit.dst === undefined )
      return;
      if( it.preservingIteration )
      it.dst[ eit.key ] = eit;
      else
      it.dst[ eit.key ] = eit.dst;
    }
  }
  else
  {
    it.errDoesNotExistThrow();
  }

}

//

function upSingle()
{
  let it = this;
}

//

function visitDown()
{
  let it = this;

  it.visitDownBegin();

  if( it.onDownBegin )
  it.onDownBegin.call( it );

  if( it.selector === undefined )
  it.downTerminal();
  else if( it.selector === it.downToken )
  it.downDown();
  else if( it.isGlob )
  it.downGlob();
  else
  it.downSingle();

  if( it.setting && it.selector === undefined )
  {
    if( it.down && !_.primitiveIs( it.down.src ) )
    it.down.src[ it.key ] = it.set;
    else
    it.errCantSetThrow();
  }

  if( it.onDownEnd )
  it.onDownEnd.call( it );

  /* */

  _.assert( it.visiting );
  if( it.onDown )
  {
    let r = it.onDown.call( it, it.src, it.key, it );
    _.assert( r === undefined );
  }

  it.visitDownEnd();

  /* */

  if( it.down )
  {
    _.assert( _.routineIs( it.down.dstWriteDown ) );
    if( it.dstWritingDown )
    it.down.dstWriteDown( it );
  }

}

//

function downTerminal()
{
  let it = this;
}

//

function downDown()
{
  let it = this;
}

//

function downGlob()
{
  let it = this;

  if( !it.dstWritingDown )
  return;

  if( it.parsedSelector.limit === undefined )
  return;

  _.assert( it.globing );

  let length = _.entityLength( it.dst );
  if( length !== it.parsedSelector.limit )
  {
    let currentSelector = it.selector;
    if( it.parsedSelector && it.parsedSelector.full )
    currentSelector = it.parsedSelector.full;
    debugger;
    let err = _.ErrorLooking
    (
      'Select constraint ' + _.strQuote( currentSelector ) + ' failed'
      + ', got ' + length + ' elements'
      + ' for selector ' + _.strQuote( it.selector )
      + '\nAt : ' + _.strQuote( it.path )
    );
    if( it.onQuantitativeFail )
    it.onQuantitativeFail.call( it, err );
    else
    throw err;
  }

}

//

function downSingle()
{
  let it = this;
}

//

function ascend( onAscend )
{
  let it = this;

  if( it.selector === undefined )
  it.ascendTerminal( onAscend );
  else if( it.selector === it.downToken )
  it.ascendDown( onAscend );
  else if( it.isGlob )
  it.ascendGlob( onAscend );
  else
  it.ascendSingle( onAscend );

}

//

function ascendTerminal( onAscend )
{
  let it = this;
}

//

function ascendDown( onAscend )
{
  let it = this;
  let counter = 0;
  let dit = it.down;

  if( !dit )
  return it.errNoDownThrow();

  while( dit.selector === it.downToken || dit.selector === undefined || counter > 0 )
  {
    if( dit.selector === it.downToken )
    counter += 1;
    else if( dit.selector !== undefined )
    counter -= 1;
    dit = dit.down;
    if( !dit )
    return it.errNoDownThrow();
  }

  // _.assert( _.lookIterationIs( dit ) );
  _.assert( it.iterationIs( dit ) );

  it.visitPop();
  dit.visitPop();

  /* */

  let nit = it.iterationMake();
  nit.select( it.selector );
  nit.src = dit.src;
  nit.dst = undefined;

  onAscend.call( it, nit );

  return true;
}

//

function ascendGlob( onAscend )
{
  let it = this;
  Parent.ascend.call( it, onAscend );
}

//

function ascendSingle( onAscend )
{
  let it = this;

  if( _.primitiveIs( it.src ) )
  {
    it.errDoesNotExistThrow();
  }
  // else if( it.selectOptions.usingIndexedAccessToMap && _.objectLike( it.src ) && !isNaN( _.numberFromStr( it.selector ) ) )
  else if( it.usingIndexedAccessToMap && _.objectLike( it.src ) && !isNaN( _.numberFromStr( it.selector ) ) )
  {
    let q = _.numberFromStr( it.selector );
    it.selector = _.mapKeys( it.src )[ q ];
    if( it.selector === undefined )
    return it.errDoesNotExistThrow();
  }
  else if( it.src[ it.selector ] === undefined )
  {
    it.errDoesNotExistThrow();
  }
  else
  {
  }

  let eit = it.iterationMake().select( it.selector );

  onAscend.call( it, eit );

}

// --
// declare looker
// --

let Selector = Object.create( Parent );

Selector.constructor = function Selector(){};
Selector.Looker = Selector;
Selector.srcChanged = srcChanged;
Selector.selectorChanged = selectorChanged;
Selector.globParse = globParse;

Selector.errNoDown = errNoDown;
Selector.errNoDownThrow = errNoDownThrow;
Selector.errCantSet = errCantSet;
Selector.errCantSetThrow = errCantSetThrow;
Selector.errDoesNotExist = errDoesNotExist;
Selector.errDoesNotExistThrow = errDoesNotExistThrow;

Selector.visitUp = visitUp;
Selector.upTerminal = upTerminal;
Selector.upDown = upDown;
Selector.upGlob = upGlob;
Selector.upSingle = upSingle;

Selector.visitDown = visitDown;
Selector.downTerminal = downTerminal;
Selector.downDown = downDown;
Selector.downGlob = downGlob;
Selector.downSingle = downSingle;

Selector.ascend = ascend;
Selector.ascendTerminal = ascendTerminal;
Selector.ascendDown = ascendDown;
Selector.ascendGlob = ascendGlob;
Selector.ascendSingle = ascendSingle;

let Iterator = Selector.Iterator = _.mapExtend( null, Selector.Iterator );

Iterator.selectorArray = null;
Iterator.replicateIteration = null;

let Iteration = Selector.Iteration = _.mapExtend( null, Selector.Iteration );

Iteration.dst = null;
Iteration.selector = null;
Iteration.parsedSelector = null;
Iteration.isRelative = false;
Iteration.isGlob = false;
Iteration.dstWritingDown = true;
Iteration.dstWriteDown = null;

// --
// declare
// --

let composite = Symbol.for( 'composite' );
var functor = select.functor = Object.create( null );
functor.onSelectorComposite = onSelectorComposite_functor;
functor.onSelectorDownComposite = onSelectorDownComposite_functor;

let SupplementSelect =
{

  onSelector,
  composite,

}

let SupplementTools =
{

  Selector,

  selectIt,
  selectSingle,
  select,
  selectSet,
  selectUnique,

}

let Self = Selector;
_.mapSupplement( _, SupplementTools );
_.mapSupplement( select, SupplementSelect );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
