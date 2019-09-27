( function _CommandsConfig_s_() {

'use strict';

/**
 * Collection of CLI commands to manage config. Use the module to mixin commands add/remove/delete/set to a class.
  @module Tools/mid/CommandsConfig
*/

/**
 * @file commands/CommandsConfig.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../../Tools.s' );

  _.include( 'wProto' );
  _.include( 'wCommandsAggregator' );

}

//

/**
 * @classdesc Collection of CLI commands to manage config.
 * @class wCommandsConfig
 * @memberof module:Tools/mid/CommandsConfig
*/

let _global = _global_;
let _ = _global_.wTools;
let Parent = null;
let Self = function wCommandsConfig( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'CommandsConfig';

// --
//
// --

function _commandsConfigAdd( ca )
{
  let self = this;

  _.assert( ca instanceof _.CommandsAggregator );
  _.assert( arguments.length === 1 );

  let commands =
  {
    'config will' :            { e : _.routineJoin( self, self.commandConfigWill ), h : 'Print config which is going to be saved' },
    'config read' :            { e : _.routineJoin( self, self.commandConfigRead ), h : 'Print content of config files' },
    'config define' :          { e : _.routineJoin( self, self.commandConfigDefine ), h : 'Define config fields' },
    'config append' :          { e : _.routineJoin( self, self.commandConfigAppend ), h : 'Define config fields appending them' },
    'config clear' :           { e : _.routineJoin( self, self.commandConfigClear ), h : 'Clear config fields' },
    'config default' :         { e : _.routineJoin( self, self.commandConfigDefault ), h : 'Set config to default' },
  }

  ca.commandsAdd( commands );

  return ca;
}

//

function _commandConfigWill( e )
{
  let self = this;
  let fileProvider = self.fileProvider;
  let logger = self.logger || _global_.logger;

  _.assert( _.instanceIs( self ) );
  _.assert( arguments.length === 0 );
  _.assert( self.opened !== undefined, 'Expects field {-opened-}' );

  // if( !self.formed )
  // self.form();

  // if( !self.opened )
  // {
  //   let storageFilePath = self.storageFilePathToLoadGet();
  //   if( storageFilePath === null )
  //   {
  //     logger.log( 'No storage to load at', path.current() );
  //     return;
  //   }
  //   self.sessionOpen();
  // }

  let storage = self.storageToSave({});
  logger.log( _.toStr( storage, { wrap : 0, multiline : 1, levels : 2 } ) );

  return self;
}

//

/**
 * @summary Prints config which is going to be saved.
 * @description Command: `.config.will`.
 * @function commandConfigWill
 * @memberof module:Tools/mid/CommandsConfig.wCommandsConfig#
*/

function commandConfigWill( e )
{
  let self = this;
  let fileProvider = self.fileProvider;
  let logger = self.logger || _global_.logger;

  _.assert( arguments.length === 1 );

  self._commandConfigWill();

  return self;
}
//

/**
 * @summary Prints content of config files.
 * @description Command: `.config.read`.
 * @function commandConfigRead
 * @memberof module:Tools/mid/CommandsConfig.wCommandsConfig#
*/

function commandConfigRead( e )
{
  let self = this;
  let fileProvider = self.fileProvider;
  let path = fileProvider.path;
  let logger = self.logger || _global_.logger;

  _.assert( _.instanceIs( self ) );
  _.assert( arguments.length === 1 );
  _.assert( self.opened !== undefined );

  let storageFilePath = self.storageFilePathToLoadGet();
  if( storageFilePath === null )
  {
    logger.log( 'No storage to load at', path.current() );
    return;
  }

  let read = self._storageFilesRead({ storageFilePath : storageFilePath });

  logger.log( 'Storage' );
  logger.up();
  for( let r in read )
  {
    logger.log( r );
    logger.up();
    logger.log( _.toStr( read[ r ].storage, { wrap : 0, multiline : 1, levels : 2 } ) );
    logger.down();
  }
  logger.down();

  // if( !self.opened )
  // self.sessionOpen();

  return self;
}

//

/**
 * @summary Defines config fields.
 * @description Command: `.config.define`.
 * @function commandConfigDefine
 * @memberof module:Tools/mid/CommandsConfig.wCommandsConfig#
*/

function commandConfigDefine( e )
{
  let self = this;
  let fileProvider = self.fileProvider;
  let logger = self.logger || _global_.logger;

  _.assert( _.instanceIs( self ) );
  _.assert( arguments.length === 1 );

  self.sessionOpenOrCreate();

  debugger;
  let storage = self.storageToSave({});
  storage = _.mapExtend( null, storage, e.propertiesMap );
  self.storageLoaded({ storage : storage });

  self.sessionSave();

  self._commandConfigWill();

  return self;
}

//

/**
 * @summary Defines config fields appending them.
 * @description Command: `.config.append`.
 * @function commandConfigAppend
 * @memberof module:Tools/mid/CommandsConfig.wCommandsConfig#
*/

function commandConfigAppend( e )
{
  let self = this;
  let fileProvider = self.fileProvider;
  let logger = self.logger || _global_.logger;

  _.assert( _.instanceIs( self ) );
  _.assert( arguments.length === 1 );

  self.sessionOpenOrCreate();

  debugger;
  let storage = self.storageToSave({});
  storage = _.mapExtendAppendingAnythingRecursive( storage, e.propertiesMap );
  self.storageLoaded({ storage : storage });

  self.sessionSave();

  self._commandConfigWill();

  return self;
}

//

/**
 * @summary Clears config fields.
 * @description Command: `.config.clear`.
 * @function commandConfigClear
 * @memberof module:Tools/mid/CommandsConfig.wCommandsConfig#
*/

function commandConfigClear( e )
{
  let self = this;
  let fileProvider = self.fileProvider;
  let logger = self.logger || _global_.logger;

  _.assert( _.instanceIs( self ) );
  _.assert( arguments.length === 1 );

  if( _.mapKeys( e.propertiesMap ).length )
  {

    self.sessionOpenOrCreate();
    let storage = self.storageToSave({});
    _.mapDelete( storage, e.propertiesMap );
    self.storageLoaded({ storage : storage });
    self.sessionSave();
    self._commandConfigWill();

  }
  else
  {

    fileProvider.fileDelete
    ({
      filePath : self.storagePathGet().storageFilePath,
      verbosity : 3,
      throwing : 0,
    });

  }

  return self;
}

//

/**
 * @summary Resets config to default.
 * @description Command: `.config.default`.
 * @function commandConfigDefault
 * @memberof module:Tools/mid/CommandsConfig.wCommandsConfig#
*/

function commandConfigDefault( e )
{
  let self = this;
  let fileProvider = self.fileProvider;
  let logger = self.logger || _global_.logger;

  _.assert( _.instanceIs( self ) );
  _.assert( arguments.length === 1 );

  // self.sessionOpenOrCreate();
  self.sessionCreate();
  let storage = self.storageDefaultGet();
  self.storageLoaded( storage );
  self.sessionSave();

  _.assert( !!self.opened );

  self._commandConfigWill();

  return self;
}

// --
//
// --

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

  _commandsConfigAdd : _commandsConfigAdd,
  _commandConfigWill : _commandConfigWill,

  commandConfigWill : commandConfigWill,
  commandConfigRead : commandConfigRead,
  commandConfigDefine : commandConfigDefine,
  commandConfigAppend : commandConfigAppend,
  commandConfigClear : commandConfigClear,
  commandConfigDefault : commandConfigDefault,

  //

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

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

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
