( function _Procedure_s_() {

'use strict';

/**
 * Minimal programming interface to launch, stop and track collection of asynchronous procedures. It prevents an application from termination waiting for the last procedure and helps to diagnose your system with many interdependent procedures.
  @module Tools/base/Procedure
*/

/**
 * @file Procedure.s.
 */

/**
 *@summary Collection of routines to launch, stop and track collection of asynchronous procedures.
  @namespace "wTools.procedure"
  @memberof module:Tools/base/Procedure
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wProto' );
  _.include( 'wCopyable' );

}

if( _realGlobal_ !== _global_ )
if( _realGlobal_.wTools && _realGlobal_.wTools.procedure )
{
  _global_.wTools.procedure = _realGlobal_.wTools.procedure;
  if( typeof module !== 'undefined' && module !== null )
  module[ 'exports' ] = _global_.wTools.procedure;
  return;
}

let _global = _global_;
let _ = _global_.wTools;

_.assert( !!_realGlobal_.wTools, 'Real global does not have wTools' );
_.assert( _global_.wTools.procedure === undefined, 'wTools.procedure is already defined' );
_.assert( _global_.wTools.Procedure === undefined, 'wTools.Procedure is already defined' );

_realGlobal_.wTools.procedure = _global_.wTools.procedure = Object.create( null );

// --
//
// --

/**
 * @classdesc Minimal programming interface to launch, stop and track collection of asynchronous procedures
 * @class wProcedure
 * @memberof module:Tools/base/Procedure
 */

let Parent = null;
let Self = function wProcedure( o )
{

  if( _.strIs( o ) )
  o = { _name : o }

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( o === undefined || _.objectIs( o ) );

  if( o === undefined )
  o = Object.create( null );

  if( o._sourcePath === undefined )
  o._sourcePath = 1;
  if( _.numberIs( o._sourcePath ) )
  o._sourcePath += 1;
  o._sourcePath = _.procedure.sourcePathGet( o._sourcePath );

  let args = [ o ];

  if( !( this instanceof Self ) )
  if( o instanceof Self )
  {
    return o;
  }
  else
  {
    return new( _.constructorJoin( Self, args ) );
  }

  return Self.prototype.init.apply( this, args );
}

Self.shortName = 'Procedure';

// --
// instance
// --

function init( o )
{
  let procedure = this;

  _.workpiece.initFields( procedure );
  Object.preventExtensions( procedure );
  procedure.copy( o );

  _.assert( _.strIs( procedure._sourcePath ) );

  procedure._longNameMake();

  _.assert( _.strIs( procedure._sourcePath ) );
  _.assert( arguments.length === 1 );
  _.assert( _.procedure.namesMap[ procedure._longName ] === procedure );

  return procedure;
}

//

/**
 * @summary Launches the procedure.
 * @method begin
 * @memberof module:Tools/base/Procedure.wProcedure
 */

function begin()
{
  let procedure = this;

  _.assert( arguments.length === 0 );

  if( procedure._timer === null )
  procedure._timer = _.timeBegin( Infinity );

  if( !procedure._longName )
  procedure._longNameMake();

  _.assert( _.procedure.namesMap[ procedure._longName ] === procedure );

  return procedure;
}

//

/**
 * @summary Stops the procedure.
 * @method end
 * @memberof module:Tools/base/Procedure.wProcedure
 */

function end()
{
  let procedure = this;

  _.assert( arguments.length === 0 );
  _.assert( !!procedure._timer );
  _.assert( _.procedure.namesMap[ procedure._longName ] === procedure, () => 'Procedure ' + _.strQuote( o._longName ) + ' not found' );

  delete _.procedure.namesMap[ procedure._longName ];

  _.timeEnd( procedure._timer );
  procedure._timer = null;
  procedure.id = 0;
  procedure._sourcePathSetExplicitly = 0;

  if( _.procedure.terminating )
  {
    _.procedure.terminationListInvalidated = 1;
    _.procedure._terminationRestart();
    // logger.log( 'Waiting for ' + Object.keys( _.procedure.namesMap ).length + ' procedure(s) ... ' )
  }

  return procedure;
}

//

/**
 * @summary Returns true if procedure is running.
 * @method isBegun
 * @memberof module:Tools/base/Procedure.wProcedure
 */

function isBegun()
{
  let procedure = this;
  _.assert( arguments.length === 0 );
  return !!procedure._timer;
}

//

function sourcePath( sourcePath )
{
  let procedure = this;

  if( !Config.debug || !_.procedure.usingSourcePath )
  {
    if( !procedure._sourcePath )
    procedure._sourcePath = '';
    return procedure;
  }

  if( arguments.length === 0 )
  return procedure._sourcePath;

  _.assert( arguments.length === 1 );

  if( sourcePath === undefined )
  sourcePath = 1;
  if( _.numberIs( sourcePath ) )
  sourcePath += 1;
  if( _.numberIs( sourcePath ) )
  sourcePath = _.procedure.sourcePathGet( sourcePath );

  _.assert( _.strIs( sourcePath ) );

  procedure._sourcePath = sourcePath;

  if( procedure._longName )
  procedure._longNameMake();

  return procedure;
}

//

function sourcePathFirst( sourcePath )
{
  let procedure = this;

  if( !Config.debug || !_.procedure.usingSourcePath )
  {
    if( !procedure._sourcePath )
    procedure._sourcePath = '';
    return procedure;
  }

  if( arguments.length === 0 )
  return procedure._sourcePath;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( procedure._sourcePath && procedure._sourcePathSetExplicitly )
  return procedure;

  procedure._sourcePathSetExplicitly = 1;

  if( sourcePath === undefined )
  sourcePath = 1;
  if( _.numberIs( sourcePath ) )
  sourcePath += 1;

  let result = procedure.sourcePath( sourcePath );

  // if( procedure && procedure._sourcePath && _.strHas( procedure._sourcePath, '\Consequence.s:' ) )
  // debugger;

  return result;
}

//

/**
 * @summary Getter/Setter routine for `name` property.
 * @description
 * Returns name of the procedure if no args provided. Sets name of procedure if provided single argument `name`.
 * @param {String} [name] Name of the procedure.
 * @method name
 * @memberof module:Tools/base/Procedure.wProcedure
 */

function name( name )
{
  let procedure = this;

  if( arguments.length === 0 )
  return procedure._name;

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( name ), () => 'Expects string, but got ' + _.strType( name ) );

  procedure._name = name;

  if( procedure._longName )
  procedure._longNameMake();

  return procedure;
}

//

/**
 * @summary Getter/Setter routine for `longName` property.
 * @description
 * Returns `longName` of the procedure if no args provided. Sets name of procedure if provided single argument `name`.
 * @param {String} [longName] Full name of the procedure.
 * @method longName
 * @memberof module:Tools/base/Procedure.wProcedure
 */

function longName( longName )
{
  let procedure = this;

  if( arguments.length === 0 )
  return procedure._longName;

  _.assert( arguments.length === 1 );
  _.assert( _.strDefined( longName ) );

  if( procedure._longName )
  {
    _.assert( _.procedure.namesMap[ procedure._longName ] === procedure, () => 'Procedure ' + _.strQuote( procedure._longName ) + ' not found' );
    delete _.procedure.namesMap[ procedure._longName ];
    procedure._longName = null;
  }

  if( procedure.id === 0 )
  procedure.id = procedure.IndexAlloc();

  procedure._longName = longName;
  _.procedure.namesMap[ procedure._longName ] = procedure;

  return procedure;
}

//

function _longNameMake()
{
  let procedure = this;

  if( procedure.id === 0 )
  procedure.id = procedure.IndexAlloc();

  let name = procedure._name || '';
  let sourcePath = procedure._sourcePath;

  _.assert( arguments.length === 0 );
  _.assert( _.strIs( name ) );
  _.assert( procedure.id > 0 );

  let result = ( sourcePath ? ( sourcePath + ' - ' ) : '' ) + name + ' # ' + procedure.id;

  procedure.longName( result );

  return result;
}

// --
// static
// --

/**
 * @summary Find procedure using id/name/routine as key.
 * @param {Number|String|Routine} procedure Selector for procedure.
 * @routine Get
 * @returns {Object|Array} Returns one or several instances of {@link module:Tools/base/Procedure.wProcedure}.
 * @memberof module:Tools/base/Procedure.wProcedure
 */

 /**
 * @summary Find procedure using id/name/routine as key.
 * @param {Number|String|Routine} procedure Selector for procedure.
 * @routine get
 * @returns {Object|Array} Returns one or several instances of {@link module:Tools/base/Procedure.wProcedure}.
 * @memberof module:Tools/base/Procedure.wTools.procedure
 */

function Get( procedure )
{
  let Cls = this;

  _.assert( arguments.length === 1 );

  if( _.arrayIs( procedure ) )
  {
    let result = procedure.map( ( p ) => Cls.Get( p ) );
    result = _.arrayFlatten( result );
    return result;
  }

  let result = procedure;

  if( _.numberIs( procedure ) )
  {
    result = _.filter( _.procedure.namesMap, { id : procedure } );
    result = _.mapVals( result );
    if( result.length > 1 )
    return result;
    if( !result.length )
    return result;
    // procedure = result[ 0 ];
  }

  if( _.strIs( procedure ) )
  {
    result = _.filter( _.procedure.namesMap, { _name : procedure } );
    result = _.mapVals( result );
    if( result.length > 1 )
    return result;
    if( !result.length )
    return result;
    // procedure = result[ 0 ];
  }

  if( _.routineIs( procedure ) )
  {
    result = _.filter( _.procedure.namesMap, { _routine : procedure } );
    result = _.mapVals( result );
    if( result.length > 1 )
    return result;
    if( !result.length )
    return result;
    // procedure = result[ 0 ];
  }

  if( _.arrayIs( result ) )
  _.assert( result.every( ( result ) => result instanceof Self, 'Not procedure' ) );
  else
  _.assert( result instanceof Self, 'Not procedure' );

  return result;
}

//

/**
 * @summary Find procedure using id/name/routine as key.
 * @param {Number|String|Routine} procedure Selector for procedure.
 * @routine GetSingleMaybe
 * @returns {Object} Returns single instance of {@link module:Tools/base/Procedure.wProcedure} or null.
 * @memberof module:Tools/base/Procedure.wProcedure
 */

/**
 * @summary Find procedure using id/name/routine as key.
 * @param {Number|String|Routine} procedure Selector for procedure.
 * @routine getSingleMaybe
 * @returns {Object} Returns single instance of {@link module:Tools/base/Procedure.wProcedure} or null.
 * @memberof module:Tools/base/Procedure.wTools.procedure
 */

function GetSingleMaybe( procedure )
{
  _.assert( arguments.length === 1 );
  let result = _.procedure.get( procedure );
  if( _.arrayIs( result ) && result.length !== 1 )
  return null;
  return result;
}

//

/**
 * @summary Short-cut for `begin` method. Creates instance of `wProcedure` and launches the routine.
 * @param {Object} o Options map
 * @param {String} o._name Name of procedure.
 * @param {Number} o._timer Timer for procedure.
 * @param {Function} o._routine Routine to lauch.
 * @routine Begin
 * @returns {Object} Returns instance of {@link module:Tools/base/Procedure.wProcedure}
 * @memberof module:Tools/base/Procedure.wProcedure
 */

/**
 * @summary Short-cut for `begin` method. Creates instance of `wProcedure` and launches the routine.
 * @param {Object} o Options map
 * @param {String} o._name Name of procedure.
 * @param {Number} o._timer Timer for procedure.
 * @param {Function} o._routine Routine to lauch.
 * @routine begin
 * @returns {Object} Returns instance of {@link module:Tools/base/Procedure.wProcedure}
 * @memberof module:Tools/base/Procedure.wTools.procedure
 */

function Begin( o )
{
  if( _.strIs( o ) )
  o = { _name : o }

  _.assert( o === undefined || _.objectIs( o ) );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( o === undefined )
  o = Object.create( null );

  if( o._sourcePath === undefined || o._sourcePath === null )
  o._sourcePath = 1;
  if( _.numberIs( o._sourcePath ) )
  o._sourcePath += 1;
  o._sourcePath = _.procedure.sourcePathGet( o._sourcePath );

  let result = new Self( o );

  result.begin();

  return result;
}

Begin.defaults =
{
  _name : null,
  _timer : null,
  _routine : null,
}

//

/**
 * @summary Short-cut for `end` method. Selects procedure using `get` routine and stops the execution.
 * @param {Number|String|Routine} procedure Procedure selector.
 * @routine End
 * @returns {Object} Returns instance of {@link module:Tools/base/Procedure.wProcedure}
 * @memberof module:Tools/base/Procedure.wProcedure
 */

/**
 * @summary Short-cut for `end` method. Selects procedure using `get` routine and stops the execution.
 * @param {Number|String|Routine} procedure Procedure selector.
 * @routine end
 * @returns {Object} Returns instance of {@link module:Tools/base/Procedure.wProcedure}
 * @memberof module:Tools/base/Procedure.wTools.procedure
 */

function End( procedure )
{
  _.assert( arguments.length === 1 );
  procedure = _.procedure.get( procedure );
  return procedure.end();
}

//

/**
 * @summary Prints report with number of procedures that are still working.
 * @routine TerminationReport
 * @memberof module:Tools/base/Procedure.wProcedure
 */

/**
 * @summary Prints report with number of procedures that are still working.
 * @routine terminationReport
 * @memberof module:Tools/base/Procedure.wTools.procedure
 */

function TerminationReport()
{
  if( _.procedure.terminationListInvalidated )
  for( let p in _.procedure.namesMap )
  {
    let procedure = _.procedure.namesMap[ p ];
    logger.log( procedure._longName );
  }
  _.procedure.terminationListInvalidated = 0;
  logger.log( 'Waiting for ' + Object.keys( _.procedure.namesMap ).length + ' procedure(s) ... ' );
}

//

/**
 * @summary Starts procedure of termination.
 * @routine TerminationReport
 * @memberof module:Tools/base/Procedure.wProcedure
 */

/**
 * @summary Starts procedure of termination.
 * @routine terminationReport
 * @memberof module:Tools/base/Procedure.wTools.procedure
 */

function TerminationBegin()
{
  _.routineOptions( TerminationBegin, arguments );
  _.procedure.terminating = 1;
  _.procedure.terminationListInvalidated = 1;
  _.procedure._terminationRestart();
}

TerminationBegin.defaults =
{
}

//

function _TerminationIteration()
{
  _.assert( arguments.length === 1 );
  _.assert( _.procedure.terminating === 1 );
  _.procedure.terminationTimer = null;
  _.procedure.terminationReport();
  _.procedure._terminationRestart();
}

//

function _TerminationRestart()
{
  _.assert( arguments.length === 0 );
  _.assert( _.procedure.terminating === 1 );
  if( _.procedure.terminationTimer )
  _.timeEnd( _.procedure.terminationTimer );
  _.procedure.terminationTimer = null;

  if( Object.keys( _.procedure.namesMap ).length )
  {
    // _.procedure.terminationReport();
    _.procedure.terminationTimer = _.timeBegin( _.procedure.terminationPeriod, _.procedure._terminationIteration );
  }

}

//

/**
 * @summary Increases counter of procedures and returns it value.
 * @routine IndexAlloc
 * @memberof module:Tools/base/Procedure.wProcedure
 */

/**
 * @summary Increases counter of procedures and returns it value.
 * @routine indexAlloc
 * @memberof module:Tools/base/Procedure.wTools.procedure
 */

function IndexAlloc()
{
  let procedure = this;
  _.assert( arguments.length === 0 );
  _.procedure.counter += 1;
  let result = _.procedure.counter;
  return result;
}

//

function SourcePathGet( sourcePath )
{
  if( !Config.debug || !_.procedure.usingSourcePath )
  return '';

  if( _.numberIs( sourcePath ) )
  sourcePath = _.diagnosticStack([ sourcePath+1, sourcePath+2 ]).trim();

  _.assert( arguments.length === 1 );
  _.assert( _.strDefined( sourcePath ), () => 'Expects source path of procedure, but got ' + _.strType( sourcePath ) );

  return sourcePath;
}

// --
// relations
// --

let Associates =
{
  id : 0,
  _name : null,
  _sourcePath : null,
  _sourcePathSetExplicitly : 0,
  _longName : null,
  _timer : null,
  _waitTime : Infinity,
  _routine : null,
}

let Statics =
{

  Get, /* qqq : cover static routine Get */
  GetSingleMaybe,
  Begin,
  End,

  TerminationReport,
  TerminationBegin,
  _TerminationIteration,
  _TerminationRestart,

  IndexAlloc,
  SourcePathGet,

}

let Fields =
{
  namesMap : Object.create( null ),
  terminating : 0,
  terminationTimer : null,
  terminationPeriod : 7500,
  terminationListInvalidated : 1,
  usingSourcePath : 1,
  counter : 0,
}

let Routines =
{

  get : Get,
  getSingleMaybe : GetSingleMaybe,
  begin : Begin,
  end : End,

  terminationReport : TerminationReport,
  terminationBegin : TerminationBegin,
  _terminationIteration : _TerminationIteration,
  _terminationRestart : _TerminationRestart,

  indexAlloc : IndexAlloc,
  sourcePathGet : SourcePathGet,

}

// --
// declare
// --

let Extend =
{

  // inter

  init,
  begin,
  end,

  isBegun,

  sourcePath,
  sourcePathFirst,
  name,
  longName,
  _longNameMake,

  // relations

  Associates,
  Statics,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );

Object.assign( _.procedure, Routines );
Object.assign( _.procedure, Fields );

_[ Self.shortName ] = Self;

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _.procedure;

})();
