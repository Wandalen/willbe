( function _TemplateTreeAresolver_s_( ) {

'use strict';

/**
 * Class to resolve tree-like with links data structures or paths in the structure. Use the module to resolve template or path to value.
  @module Tools/mid/TemplateTreeResolver
*/

/**
 * @file TemplateTreeResolver.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wCopyable' );

}

/**
 * @classdesc Class to resolve tree-like with links data structures or paths in the structure
 * @param {Object} o Options map for constructor. {@link module:Tools/mid/TemplateTreeResolver.wTemplateTreeResolver.Fields Options description }
 * @class wTemplateTreeResolver
 * @memberof module:Tools/mid/TemplateTreeResolver
*/

let _ = _global_.wTools;
let Parent = null;
let Self = function wTemplateTreeResolver( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'TemplateTreeResolver';

// --
// inter
// --

function init( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.workpiece.initFields( self );

  if( self.constructor === Self )
  Object.preventExtensions( self );

  if( o )
  self.copy( o );

}

// --
// resolve
// --

/**
 * @summary Resolves provided string `src` to value.
 * @description Prepends prefix and appends postfix symbols to string before resolve.
 * @param {String} src String to resolve.
 * @function resolveString
 * @memberof module:Tools/mid/TemplateTreeResolver.wTemplateTreeResolver#
*/

function resolveString( src )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( src ) );

  return self.resolve( self.prefixToken + srcStr + self.postfixSymbo );
}

//

/**
 * @summary Resolves provided entity `src` to value.
 * @description Resolves intermediate links if they exist.
 * @param {Array|Object|String|RegExp} src Entity to resolve.
 *
 * @example
 * let tree = { property : 'value' };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.resolve( '{{property}}' ); // 'value'
 *
 * @example
 * let tree = { map : { property : 'value' } };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.resolve( '{{map/property}}' ); // 'value'
 *
 * @example
 * let tree = { property1 : 'value1', property2 : 'value2' };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.resolve( '{{property1}}/{{property2}}' ); // 'value1/value2'
 *
 * @example
 * let tree = { array : [ 'a', 'b' ], property : 'c' };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.resolve( '{{array}} {{property}}' ); // [ 'a c', 'b c' ]
 *
 * @example
 * let tree = { map : { a : '1', b : '2' }, property : '3' };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.resolve( '{{map}} {{property}}' ); // { a: '1 3', b: '2 3' }
 *
 * @example //resolving of intermediate links: a -> b -> c
 * let tree = { a : '{{b}}', b : '{{c}}', c : 1 };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.resolve( '{{a}}' ); // 1
 *
 * @function resolve
 * @throws {Error} If resolve fails.
 * @memberof module:Tools/mid/TemplateTreeResolver.wTemplateTreeResolver#
*/

function resolve( src )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  let result = self._resolve( src );

  if( result instanceof self.ErrorLooking )
  {
    let result = self._resolve( src );
    throw _.err( result );
  }

  return result;
}

//

/**
 * @summary Resolves provided entity `src` to value.
 * Returns 'undefined' if fails to resolve.
 * @param {Array|Object|String|RegExp} src Entity to resolve.
 * @function resolveTry
 * @memberof module:Tools/mid/TemplateTreeResolver.wTemplateTreeResolver#
*/

function resolveTry( src )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  let result = self._resolve( src );

  if( result instanceof self.ErrorLooking )
  return;

  return result;
}

//

function _resolve( src )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( self.stack.length === 0, 'Something wrong with stack' );

  let result = self._resolveEnter
  ({
    subject : src,
    rootContainer : self.tree,
    currentContainer : self.tree,
    selector : '',
    path : self.upTokenDefault(),
  });

  _.assert( self.stack.length === 0, 'Something wrong with stack' );

  return result;
}

//

function _resolveEnter( o )
{
  let self = this;
  let current = self.stack[ self.stack.length-1 ];

  _.assert( arguments.length === 1 );
  _.routineOptionsPreservingUndefines( _resolveEnter, arguments );

  if( o.path === null )
  o.path = current ? current.path : self.upTokenDefault();

  let result = self._resolveEntered( o.subject );

  return result;
}

_resolveEnter.defaults =
{
  subject : null,
  rootContainer : null,
  currentContainer : null,
  selector : null,
  path : null,
}

//

function _resolveEntered( src )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( !self.shouldInvestigate( src ) )
  return src;

  if( _.strIs( src ) )
  return self._resolveString( src );

  if( _.regexpIs( src ) )
  return self._resolveRegexp( src );

  if( _.mapIs( src ) )
  return self._resolveMap( src );

  if( _.longIs( src ) )
  return self._resolveArray( src );

  throw _.err( 'Unexpected type of src', _.strType( src ) );
}

//

function _resolveString( src )
{
  let self = this;
  let r;
  let rarray = [];
  let throwen = 0;
  // let current = self.current[ self.current.length - 1 ];
  let current = self.stack[ self.stack.length-1 ];

  if( src === '' )
  return src;

  let o2 =
  {
    src : src,
    prefix : self.prefixToken,
    postfix : self.postfixToken,
    onInlined : function( src ){ return [ src ]; },
  }

  let strips = _.strExtractInlinedStereo( o2 );

  /* */

  for( let s = 0 ; s < strips.length ; s++ )
  {
    let element;
    let strip = strips[ s ];

    if( _.strIs( strip ) )
    {
      element = strip;
    }
    else
    {
      _.assert( strip.length === 1 );
      strip = strip[ 0 ];
      element = handleStrip( strip );
    }

    _.assert( _.strIs( strip ) );

    if( element instanceof _.ErrorLooking || throwen )
    {
      // debugger;
      element = _.err
      (
        'Cant resolve', _.strQuote( src.substring( 0, 80 ) ),
        '\n', _.strQuote( strip ), 'is not defined', '\n',
        element
      );

      if( throwen )
      throw element

      return element;
    }

    if( strips.length > 1 )
    {
      _.assert( element !== undefined );
      let element2 = self.strFrom( element );
      if( !_.strIs( element2 ) && !_.arrayIs( element2 ) && !_.mapIs( element2 ) )
      {
        debugger;
        element2 = _.err
        (
         'Cant resolve', _.strQuote( src.substring( 0, 80 ) ), '\n', _.strQuote( strip ), 'is', _.strType( element2 ), '\n',
         'Allowed types are: String, Array, Map'
        );
        return element2;
      }
      element = element2;
    }

    rarray.push( element );

  }

  /* */

  if( rarray.length <= 1 )
  return rarray[ 0 ];

  let result;

  try
  {
    result = self.strJoin.apply( self, rarray );
  }
  catch( err )
  {
    throw _.err
    (
      'Can\'t mix different elements of template :', _.strQuote( src.substring( 0, 80 ) ),
      '\n', 'Elements:\n', rarray, '\n', err.message
    );
  }

  return result;

  /* */

  function handleStrip( strip )
  {
    let element = strip;

    let it;
    try
    {
      it = self._selectTracking( element );
    }
    catch( err )
    {
      throwen = 1;
      element = err;
    }

    if( it && it.error )
    element = it.error;

    if( it && !it.error )
    {
      let lit = it.lastSelected;
      self._selectBegin( lit );

      if( it.error )
      {
        element = it.error;
      }
      else
      {

        let element2 = it.dst;
        if( element !== element2 && element2 !== undefined )
        {
          // debugger;
          element2 = self._resolveEnter
          ({
            subject : element2,
            rootContainer : current ? current.root : self.tree,
            currentContainer : it.lastSelected.src,
            path : it.lastSelected.path,
            selector : '',
          });
        }
        element = element2;

        self._selectEnd( lit );
      }

    }

    return element
  }

}

//

function _resolveRegexp( src )
{
  let self = this;

  _.assert( _.regexpIs( src ) );

  let source = src.source;
  // debugger;
  source = self._resolveString( source );
  // debugger;

  if( source instanceof self.ErrorLooking )
  return source;

  if( source === src.source )
  return src;

  src = new RegExp( source, src.flags );

  return src;
}

//

function _resolveMap( src )
{
  let self = this;
  // let current = self.current[ self.current.length - 1 ];
  let current = self.stack[ self.stack.length-1 ];
  let result = Object.create( null );

  for( let s in src )
  {
    result[ s ] = self._resolveEnter
    ({
      subject : src[ s ],
      currentContainer : src[ s ],
      rootContainer : current ? current.root : self.tree,
      selector : s,
    });
    if( result[ s ] instanceof self.ErrorLooking )
    {
      return result[ s ];
    }
  }

  return result;
}

//

function _resolveArray( src )
{
  let self = this;
  // let current = self.current[ self.current.length - 1 ];
  let current = self.stack[ self.stack.length-1 ];
  let result = new src.constructor( src.length );

  for( let s = 0 ; s < src.length ; s++ )
  {
    result[ s ] = self._resolveEnter
    ({
      subject : src[ s ],
      currentContainer : src[ s ],
      rootContainer : current ? current.root : self.tree,
      selector : s,
    });
    if( result[ s ] instanceof self.ErrorLooking )
    {
      return result[ s ];
    }
  }

  return result;
}

// --
// select
// --

function select_pre( routine, args )
{

  args = _.longSlice( args );

  let o = args[ 0 ]
  if( _.strIs( o ) )
  o = { selector : o }

  o.src = this.tree;
  o.downToken = this.downToken;
  o.upToken = this.upToken;

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );

  return _.selectSingle.pre.call( this, routine, [ o ] );
}

//

function _selectIt_body( it )
{
  let self = this;
  let result = _.selectSingle.body.call( _, it );
  return it;
}

_.routineExtend( _selectIt_body, _.selectSingle.body );

var defaults = _selectIt_body.defaults;

defaults.missingAction = 'throw';

let _selectIt = _.routineFromPreAndBody( select_pre, _selectIt_body );

//

function select_body( o )
{
  let it = this._selectIt.body.call( this, o );
  return it.dst;
}

_.routineExtend( select_body, _selectIt.body );

/**
 * @summary Selects raw value from tree using provided selector string.
 * @description Doesn't resolve intermediate links. Throws an Error if fails to select the value.
 * @param {String} src Selector string.
 *
 * @example
 * let tree = { a : '{{b}}', b : 1 };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.select( 'a/b' );// 1
 *
 * @example
 * let tree = { a : '{{b}}', b : 1 };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.select( 'a' );// '{{b}}'
 *
 * @example
 * let tree = { a : { b : '{{c}}' } };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.select( 'a/b' );// '{{c}}'
 *
 * @function select
 * @throws If fails to select the value.
 * @memberof module:Tools/mid/TemplateTreeResolver.wTemplateTreeResolver#
*/

let select = _.routineFromPreAndBody( select_pre, select_body );

var defaults = select.defaults;

select.missingAction = 'throw';

//

/**
 * @summary Selects raw value from tree using provided selector string.
 * @description Doesn't resolve intermediate links. Returns `undefined` if fails to select the value.
 * @param {String} src Selector string.
 *
 * @example
 * let tree = { a : 1 };
 * let template = new wTemplateTreeResolver({ tree : tree });
 * template.select( 'b' );// undefined
 *
 * @function selectTry
 * @memberof module:Tools/mid/TemplateTreeResolver.wTemplateTreeResolver#
*/

let selectTry = _.routineFromPreAndBody( select_pre, select_body );

var defaults = selectTry.defaults;

defaults.missingAction = 'undefine';

//

function _selectTracking_pre( routine, args )
{
  let self = this;
  let current = self.stack[ self.stack.length-1 ];

  args = _.longSlice( args );

  let o = args[ 0 ]
  if( _.strIs( o ) )
  o = { selector : o }

  o.src = this.tree;
  o.downToken = this.downToken;
  o.upToken = this.upToken;

  if( _.strBegins( o.selector, [ '..', '.' ] ) )
  {
    debugger;
    _.sure( !!current, 'Cant resolve', () => _.strQuote( o.selector ) + ' no current!' );
    o.it = current.iterationReinit();
    o.src = null;
  }

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );

  return _.selectSingle.pre.call( this, routine, [ o ] );
}

//

function _selectTracking_body( it )
{
  let self = this;
  this._selectIt.body.call( this, it );
  // self.stack.push( it.lastSelected );
  return it;
}

_.routineExtend( _selectTracking_body, _selectIt.body );

let _selectTracking = _.routineFromPreAndBody( _selectTracking_pre, _selectTracking_body );

_.assert( _selectTracking.defaults.missingAction === 'throw' );
_selectTracking.defaults.missingAction = 'error';
_.assert( _selectTracking.defaults.missingAction === 'error' );

//

function _selectBegin( it )
{
  let self = this;

  // debugger;
  let found = _.entityFilter( self.stack, { src : it.src } );

  if( found.length )
  {
    debugger;
    it.iterator.error = _.ErrorLooking
    (
      'Dead lock', _.strQuote( it.src ),
      '\nbecause', _.strQuote( it.selector ), 'does not exist',
      '\nat', _.strQuote( it.path ),
      '\nin container', _.toStr( it.src )
    );
    return it.iterator.error;
  }

  self.stack.push( it );
  return it;
}

//

function _selectEnd( it )
{
  let self = this;
  let pit = self.stack.pop();
  _.assert( pit === it );
  return it;
}

// --
// etc
// --

let ErrorLooking = _.ErrorLooking;
_.assert( _.routineIs( ErrorLooking ) );

//

function shouldInvestigate( src )
{
  let self = this;

  if( _.strIs( src ) )
  return self.investigatingString;

  if( _.mapIs( src ) )
  return self.investigatingMap;

  if( _.regexpIs( src ) )
  return self.investigatingRegexp;

  if( _.longIs( src ) )
  return self.investigatingArrayLike;

  return false;
}

//

function strFrom( src )
{
  let self = this;

  if( _.regexpIs( src ) )
  src = src.source;

  if( !_.strIs( src ) && self.onStrFrom )
  src = self.onStrFrom( src );

  return src;
}

//

function _strJoin()
{
  let result = '';
  for( var i = 0; i < arguments.length; i++ )
  {
    _.assert( _.strIs( arguments[ i ] ), 'Can\'t join elements:', '\n', arguments, '\n', 'Expects String, but got:', arguments[ i ] );
    result += arguments[ i ];
  }
  return result;
}

let strJoin = _.routineVectorize_functor
({
  routine : _strJoin,
  vectorizingArray : 1,
  vectorizingMapVals : 1,
  vectorizingMapKeys : 0,
  select : Infinity
})

//

function upTokenDefault()
{
  let self = this;
  let result = self.onUpTokenDefault();
  _.assert( _.strIs( result ) );
  return result;
}

//

function onUpTokenDefault()
{
  let self = this;
  let result = self.upToken;
  if( _.arrayIs( result ) )
  result = _.strsShortest( result );
  return result;
}

// --
// shortcuts
// --

function resolveAndAssign( src )
{
  let self = this;

  if( src !== undefined )
  self.tree = src;

  self.tree = self.resolve( self.tree );

  return self.tree;
}

//

function EntityResolve( src, tree )
{
  if( tree === undefined )
  tree = src;
  _.assert( arguments.length === 1 || arguments.length === 2 );
  let self = new Self({ tree : tree });
  return self.resolve( src );
}

// --
// relations
// --

/**
 * @typedef {Object} Fields
 * @property {Boolean} investigatingString=true
 * @property {Boolean} investigatingMap=true
 * @property {Boolean} investigatingRegexp=true
 * @property {Boolean} investigatingArrayLike=true

 * @property {Array} stack

 * @property {String} prefixToken='{{'
 * @property {String} postfixToken='}}'
 * @property {String} downToken='..'
 * @property {String} upToken=[ '\\/', '/' ]

 * @property {Function} onStrFrom
 * @property {Function} onUpTokenDefault
 * @memberof module:Tools/mid/TemplateTreeResolver.wTemplateTreeResolver
*/

/*
 xxx : implement sophisticated template resolver
*/

let KnownTypes = [ 'each' ];

let Composes =
{

  investigatingString : true,
  investigatingMap : true,
  investigatingRegexp : true,
  investigatingArrayLike : true,

  stack : _.define.own([]),

  // middleToken : '::',
  prefixToken : '{{',
  postfixToken : '}}',
  downToken : '..',
  upToken : _.define.own([ '\\/', '/' ]),

  onStrFrom : null,
  onUpTokenDefault : onUpTokenDefault,

}

let Associates =
{
  tree : null,
}

let Restricts =
{
}

let Statics =
{
  KnownTypes,
  ErrorLooking,
  EntityResolve,
}

let Globals =
{
  entityResolve : EntityResolve,
}

// --
// declare
// --

let Proto =
{

  init,

  // resolve

  resolveString,
  resolve,
  resolveTry,
  _resolve,
  _resolveEnter,
  _resolveEntered,

  _resolveString,
  _resolveMap,
  _resolveArray,
  _resolveRegexp,

  // select

  _selectIt,
  select,
  selectTry,

  _selectTracking,
  _selectBegin,
  _selectEnd,

  // etc

  shouldInvestigate,
  strFrom,
  _strJoin,
  strJoin,
  upTokenDefault,

  // shortcuts

  resolveAndAssign,
  EntityResolve,

  // relations

  Composes,
  Associates,
  Restricts,
  Statics,
  Globals,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );
_.mapExtend( _global_, Globals );

//

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

_[ Self.shortName ] = _global_[ Self.name ] = Self;
if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
