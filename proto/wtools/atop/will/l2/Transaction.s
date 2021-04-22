( function _Transaction_s_()
{

'use strict';

//

let _ = _global_.wTools;
const Parent = null;
let Self = wWillTransaction;
function wWillTransaction( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Transaction';

// --
// inter
// --

function finit()
{
  let t = this;

  t.unform();

  return _.Copyable.prototype.finit.apply( t, arguments );
}

//

function init( o )
{
  let t = this;

  _.assert( arguments.length === 1 );

  if( o.logger )
  {
    _.assert( o.logger instanceof _.Logger );
    t.logger = o.logger;
  }
  else
  {
    _.assert( o.targetLogger instanceof _.Logger );
    t.logger = _.Logger({ output : o.targetLogger, name : 'transaction' });
    _.assert( t.logger.output === o.targetLogger );
  }

  _.workpiece.initFields( t );
  Object.preventExtensions( t );

  if( o )
  t.copy( o )

  t.form();
}

//

function Make( properties, targetLogger )
{
  return new _.will.Transaction({ targetLogger, ... _.mapOnly_( null, properties, _.will.Transaction.TransactionFields ) });
}

//

function extend( properties )
{
  let t = this;
  _.assert( arguments.length === 1 );
  t.formed = 0;
  // _.mapExtend( t, _.mapBut_( _.mapOnly_( null, properties, _.will.Transaction.TransactionFields ), [ 'verbosity' ] ) );
  _.mapExtend( t, _.mapOnly_( null, properties, _.will.Transaction.TransactionFields ) );
  t.formed = 1;
  return t;
}

//

function unform()
{
  let t = this;
  let logger = t.logger;
  _.assert( logger.verbosity === t.verbosity, 'Verbosity of the main logger was changed' );
  t.formed = 0;
}

//

function form()
{
  let t = this;

  for( let p in TransactionFields )
  if( t[ p ] === null )
  t[ p ] = TransactionFields[ p ];

  if( !t.withPath )
  t.withPath = _.fileProvider.path.join( _.fileProvider.path.current(), './' );

  t.formed = 1;

  // Object.freeze( t );
}

//

function wasFilterFieldsChanged( transaction )
{
  let t = this;

  if( !transaction )
  return false;

  if( t.withPath !== transaction.withPath )
  return true;

  for( let propName in t.TransactionModuleFields )
  if( t[ propName ] !== transaction[ propName ] )
  return true;

  if( t.modulesDepth[ 0 ] !== transaction.modulesDepth[ 0 ] )
  return true
  if( t.modulesDepth[ 1 ] !== transaction.modulesDepth[ 1 ] )
  return true

  return false;
}

//

function relationFilterFieldsGet()
{
  let t = this;
  return _.mapOnly_( null, t, _.Will.RelationFilterDefaults );
}

//

function verbosityGet()
{
  let t = this;
  let logger = t.logger;
  _.assert( logger.verbosity === t._.verbosity, 'Verbosity of the transaction logger was changed outside of the transaction' );
  /* qqq : for Vova : logger should always exists */
  return t._.verbosity;
}

//

function verbositySet( src )
{
  let t = this;
  let logger = t.logger;

  if( t.formed )
  return;

  if( src === null )
  src = _.will.Transaction.TransactionFields.verbosity;

  t._.verbosity = src;
  logger.verbosity = src;
}

//

function withSubmodulesSet( src )
{
  let t = this;

  _.assert( arguments.length === 1 );
  _.assert( _.boolIs( src ) || _.numberIs( src ) || src === null );

  if( _.boolIs( src ) )
  src = src ? 1 : 0;

  if( t.formed )
  return t._.withSubmodules;

  if( t._.withSubmodules === src )
  return t._.withSubmodules;

  t._.withSubmodules = src;

  if( src === null )
  {
  }
  else if( src )
  {
    t._.subModulesFormedOfMain = true;
    if( src === 2 )
    {
      t._.subModulesFormedOfSub = true;
      return 2;
    }
    else
    {
      t._.subModulesFormedOfSub = false;
      return 1;
    }
  }
  else
  {
    t._.subModulesFormedOfMain = false;
    t._.subModulesFormedOfSub = false;
    return 0;
  }

}

//

function modulesDepthSet( src )
{
  let t = this;

  _.assert( arguments.length === 1 );
  _.assert( _.arrayIs( src ) );
  _.assert( src.length === 2 );

  if( t.formed )
  return;

  if( !t._.modulesDepth )
  {
    t._.modulesDepth = src.slice();
  }
  else
  {
    t._.modulesDepth[ 0 ] = src[ 0 ];
    t._.modulesDepth[ 1 ] = src[ 1 ];
  }

  _.assert( t._.modulesDepth[ 0 ] >= 0 && t._.modulesDepth[ 0 ] <= 2 );
  _.assert( t._.modulesDepth[ 1 ] === 0 || t._.modulesDepth[ 1 ] === Infinity );
}

//

function _transactionPropertyGetter_functor( propName )
{
  return function get()
  {
    let t = this;
    _.assert( t._[ propName ] === null || _.boolLike( t._[ propName ] ) || _.strDefined( t._[ propName ] ) || _.numberIs( t._[ propName ] ) || _.arrayIs( t._[ propName ] ) );
    return t._[ propName ];
  }
}

//

function _transactionPropertySetter_functor( propName )
{
  return function set( src )
  {
    let t = this;
    if( t.formed )
    return;

    if( src === null )
    src = _.will.Transaction.TransactionFields[ propName ];

    t._[ propName ] = src;
  }
}

//

function _transactionWithPropertySetter_functor( propName, backPropName )
{
  return function set( src )
  {
    let t = this;
    if( t.formed )
    return;

    if( src === null )
    src = t[ backPropName ];

    t._[ propName ] = src;
  }
}

//

let TransactionFields =
{
  verbosity : 3,
  verboseStaging : 0,

  beeping : 0,

  ... _.Will.FilterFields,

  withPath : null,
  withSubmodules : null,

  withEnabledModules : null,
  withEnabledSubmodules : null,

  withDisabledModules : null,
  withDisabledSubmodules : null,

  ... _.Will.IntentionFields,

  willFileAdapting : 0,

  modulesDepth : _.define.own([ 0, 0 ])
}

//

let TransactionModuleFields =
{
  withEnabledModules : null,
  withDisabledModules : null,
}

// --
// relations
// --

let Composes =
{
  ... TransactionFields,
}

let Aggregates =
{
  isInitial : 0,
}

let Associates =
{
  // will : null, /* qqq : for Vova : remove */
  logger : null
}

let Restricts =
{
  formed : 0,
}

let Medials =
{
  targetLogger : null
}

let Statics =
{
  Make,
  TransactionFields,
  TransactionModuleFields,
}

let Forbids =
{
}

let Accessors =
{
  _ : { get : _.accessor.getter.withSymbol, writable : 0 },
  verbosity : { get : verbosityGet, set : verbositySet },
  withSubmodules : { get : _transactionPropertyGetter_functor( 'withSubmodules' ), set : withSubmodulesSet },
  withEnabledModules : { get : _transactionPropertyGetter_functor( 'withEnabledModules' ), set : _transactionWithPropertySetter_functor( 'withEnabledModules', 'withEnabled' ) },
  withEnabledSubmodules : { get : _transactionPropertyGetter_functor( 'withEnabledSubmodules' ), set : _transactionWithPropertySetter_functor( 'withEnabledSubmodules', 'withEnabled' ) },
  withDisabledModules : { get : _transactionPropertyGetter_functor( 'withDisabledModules' ), set : _transactionWithPropertySetter_functor( 'withDisabledModules', 'withDisabled' ) },
  withDisabledSubmodules : { get : _transactionPropertyGetter_functor( 'withDisabledSubmodules' ), set : _transactionWithPropertySetter_functor( 'withDisabledSubmodules', 'withDisabled' ) },
  modulesDepth : { get : _transactionPropertyGetter_functor( 'modulesDepth' ), set : modulesDepthSet }
}

_.each( TransactionFields, ( val, key ) =>
{
  if( !Accessors[ key ] )
  Accessors[ key ] = { get : _transactionPropertyGetter_functor( key ), set : _transactionPropertySetter_functor( key ) }
})

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,
  Make,
  extend,

  unform,
  form,

  wasFilterFieldsChanged,
  relationFilterFieldsGet,

  verbositySet,
  withSubmodulesSet,
  modulesDepthSet,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Medials,
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
});

_.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();
