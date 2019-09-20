( function _StateSession_s_() {

'use strict';

/**
 * Mixin to add persistent session storing functionality to a class. StateSession extends StateStorage. These modules solve the common problem to persistently store the state( session ) of an object. Them let save the state in a specific moment ( for example on process exit ) and to restore the state later ( for example on process start ). Use the module to be more cross-platform, don't repeat yourself and forget about details of implementation you don't worry.
  @module Tools/mid/StateSession
*/

/**
 * @file files/StateSession.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wProto' );
  _.include( 'wStateStorage' );

}

//

/**
 * @classdesc Mixin to add persistent session storing functionality to a class.
 * @class wStateSession
 * @memberof module:Tools/mid/StateSession
*/

let _global = _global_;
let _ = _global_.wTools;
let Parent = null;
let Self = function wStateSession( o )
{
  _.assert( arguments.length === 0 || arguments.length === 1, 'Expects single argument' );
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'StateSession';

// --
//
// --

/**
 * @summary Creates new session.
 * @description
 * Opens new sesstion and prepares file path for a session storage.
 * Only one session can be created. Throws an Error if session is opened.
 * @function sessionCreate
 * @memberof module:Tools/mid/StateSession.wStateSession#
*/

function sessionCreate()
{
  let self = this;
  let exists = true;

  _.assert( self.opened !== undefined );
  _.assert( !self.opened );
  _.assert( arguments.length === 0 );

  if( self.storageFilePath === null )
  self.storageFilePath = self.storageFilePathToSaveGet();
  self.opened = 1;

  return exists;
}

//

/**
 * @summary Creates new session or opens existing one.
 * @function sessionOpenOrCreate
 * @returns {Boolean} Returns true if session was loaded and false if session was created.
 * @memberof module:Tools/mid/StateSession.wStateSession#
*/

function sessionOpenOrCreate()
{
  let self = this;
  let exists = true;

  _.assert( self.opened !== undefined );
  _.assert( !self.opened );
  _.assert( arguments.length === 0 );

  if( !self.opened )
  {
    if( !self.storageLoad() )
    {
      exists = false;
    }
  }

  self.sessionCreate();

  return exists;
}

//

/**
 * @summary Opens current session and loads storage.
 * @function sessionOpen
 * @returns {Object} Returns instance of `wStateSession`.
 * @memberof module:Tools/mid/StateSession.wStateSession#
*/

function sessionOpen()
{
  let self = this;

  if( self.opened )
  return self;

  _.assert( self.opened !== undefined );
  _.assert( !self.opened );
  _.assert( arguments.length === 0 );
  _.assert( _.strDefined( self.storageFileName ), 'Expects string field {-storageFileName-}' );

  if( !self.storageLoad() )
  throw _.errBrief
  (
    'Cant open a session ' + _.strQuote( self.storageFileName ) + '.\n'
    + 'At ' + _.strQuote( self.storageFilePathToLoadGet() ) + '.'
  );

  self.opened = 1;
  return self;
}

//

/**
 * @summary Closes current session and removes loaded storages.
 * @function sessionClose
 * @returns {Object} Returns instance of `wStateSession`.
 * @memberof module:Tools/mid/StateSession.wStateSession#
*/

function sessionClose()
{
  let self = this;
  _.assert( self.opened !== undefined );
  _.assert( arguments.length === 0 );

  if( !self.opened )
  {
    return self ;
  }

  self.opened = 0;
  if( self.storageFilePath !== undefined )
  self.storageFilePath = null;
  if( self.storagesLoaded )
  self.storagesLoaded.splice( 0 );

  return self;
}

//

/**
 * @summary Saves current session and closes it.
 * @function sessionCloseSaving
 * @returns {Object} Returns instance of `wStateSession`.
 * @memberof module:Tools/mid/StateSession.wStateSession#
*/

function sessionCloseSaving()
{
  let self = this;
  _.assert( self.opened !== undefined );
  _.assert( arguments.length === 0 );
  if( !self.opened )
  return;
  self.sessionSave();
  self.sessionClose();
  return self;
}

//

/**
 * @summary Saves storage of current session to hard drive.
 * @function sessionSave
 * @returns {Object} Returns instance of `wStateSession`.
 * @memberof module:Tools/mid/StateSession.wStateSession#
*/


function sessionSave()
{
  let self = this;
  _.assert( self.opened !== undefined );
  _.assert( !!self.opened, 'Cant save closed session' );
  _.assert( arguments.length === 0 );
  self.storageSave();
  return self;
}

// --
//
// --

let MustHave =
{
  opened : null,
}

let CouldHave =
{
  storageFilePath : null,
}

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
}

let Forbids =
{
}

let Accessors =
{
}

// --
// declare
// --

let Supplement =
{

  sessionCreate,
  sessionOpenOrCreate,
  sessionOpen,
  sessionClose,
  sessionCloseSaving,
  sessionSave,

  //

  MustHave,
  CouldHave,

  Composes,
  Aggregates,
  Associates,
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
  supplement : Supplement,
  withMixin : true,
  withClass : true,
});

// --
// export
// --

_global_[ Self.name ] = _[ Self.shortName ] = Self;

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
