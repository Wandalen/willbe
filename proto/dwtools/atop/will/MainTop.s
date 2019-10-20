( function _MainTop_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './MainBase.s' );

}

//

let _ = wTools;
let Parent = _.Will;
let Self = function wWillCli( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'WillCli';

// --
// exec
// --

function Exec()
{
  let will = new this.Self();
  return will.exec();
}

//

function exec()
{
  let will = this;

  will.formAssociates();

  _.assert( _.instanceIs( will ) );
  _.assert( arguments.length === 0 );

  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let appArgs = _.process.args({ keyValDelimeter : 0 });
  let ca = will._commandsMake();


  return _.Consequence
  .Try( () =>
  {
    return ca.appArgsPerform({ appArgs });
  })
  .catch( ( err ) =>
  {
    _.process.exitCode( -1 );
    err = _.err( err );
    logger.log( _.errOnce( err ) );
    throw err;
  });

}

//

function init( o )
{
  let will = this;

  will[ currentOpenerSymbol ] = null;

  return Parent.prototype.init.apply( will, arguments );
}

//

function _openersCurrentEach( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  _.assert( will.currentOpener === null || will.currentOpeners === null );
  _.routineOptions( _openersCurrentEach, arguments );

  if( will.currentOpener )
  {

    _.assert( will.currentOpeners === null );
    _.assert( will.currentOpener instanceof will.ModuleOpener );

    let opener = will.currentOpener;
    let it = itFrom( opener );
    ready.then( () => o.onEach.call( will, it ) );

  }
  else
  {

    _.assert( will.currentOpener === null );
    _.assert( _.arrayIs( will.currentOpeners ) );

    will.currentOpeners.forEach( ( opener ) =>
    {
      let it = itFrom( opener );
      ready.then( () => o.onEach.call( will, it ) );
    });

  }

  return ready;

  function itFrom( opener )
  {
    let it = Object.create( null );
    it.opener = opener;
    it.module = opener.openedModule;
    it.openers = will.currentOpeners;
    it.variant = will.variantOf( opener );
    it.will = will;
    return it;
  }

}

_openersCurrentEach.defaults =
{
  onEach : null,
}

//

function openersCurrentEach( onEach )
{
  let will = this.form();
  _.assert( arguments.length === 1 );
  return will._openersCurrentEach
  ({
    onEach,
  });
}

//

function _commandListLike( o )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let e = o.event;

  _.assert( arguments.length === 1 );
  _.routineOptions( _commandListLike, arguments );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onEach ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );
  _.assert( o.resourceKind !== undefined );

  will._commandsBegin( o.commandRoutine );

  if( will.currentOpeners === null && will.currentOpener === null )
  ready.then( () => will.openersFind() );

  // debugger;
  ready
  .then( () => will.openersCurrentEach( function( it )
  {
    let ready2 = new _.Consequence().take( null );

    ready2.then( () => it.opener.openedModule.modulesUpform({ recursive : 2, all : 0, subModulesFormed : 1 }) )

    ready2.then( () => will.readingEnd() );

    ready2.then( () =>
    {

      let resources = null;
      if( o.resourceKind )
      {

        let resourceKindIsGlob = _.path.isGlob( o.resourceKind );
        _.assert( e.request === undefined );
        e.request = will.Resolver.strRequestParse( e.argument );

        if( will.Resolver.selectorIs( e.request.subject ) )
        {
          let splits = will.Resolver.selectorShortSplit
          ({
            selector : e.request.subject,
            defaultResourceKind : o.resourceKind,
          });
          o.resourceKind = splits[ 0 ];
          resourceKindIsGlob = _.path.isGlob( o.resourceKind );
        }

        if( resourceKindIsGlob && e.request.subject && !will.Resolver.selectorIs( e.request.subject ) )
        {
          e.request.subject = '*::' + e.request.subject;
        }

        let o2 =
        {
          selector : resourceKindIsGlob ? ( e.request.subject || '*::*' ) : ( e.request.subject || '*' ),
          criterion : e.request.map,
          defaultResourceKind : resourceKindIsGlob ? null : o.resourceKind,
          prefixlessAction : resourceKindIsGlob ? 'throw' : 'default',
          arrayWrapping : 1,
          pathUnwrapping : resourceKindIsGlob ? 0 : 1,
          pathResolving : 0,
          mapValsUnwrapping : resourceKindIsGlob ? 0 : 1,
          strictCriterion : 1,
          currentExcluding : 0,
        }

        if( o.resourceKind === 'path' )
        o2.mapValsUnwrapping = 0;

        o2.criterion = _.mapExtend( null, o2.criterion );
        // if( o2.criterion.predefined === undefined )
        // o2.criterion.predefined = false;

        // debugger;
        resources = it.opener.openedModule.resolve( o2 );

        if( _.arrayIs( resources ) )
        resources = _.longOnce( resources );

      }

      return o.onEach( it.opener, resources ) || null;
    });

    return ready2;
  }))
  .finally( ( err, arg ) =>
  {
    will._commandsEnd( o.commandRoutine );
    if( err )
    logger.log( _.errOnce( err ) );
    if( err )
    throw err;
    return arg;
  });

}

_commandListLike.defaults =
{
  event : null,
  onEach : null,
  commandRoutine : null,
  name : null,
  resourceKind : null,
}

//

function _commandBuildLike( o )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  _.routineOptions( _commandBuildLike, arguments );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onEach ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  will._commandsBegin( o.commandRoutine );

  if( will.currentOpeners === null && will.currentOpener === null )
  ready.then( () => will.openersFind() );

  if( will.currentOpeners )
  {
    let filter =
    {
      withIn : o.withIn,
      withOut : o.withOut,
      withBroken : o.withBroken,
    }
    let openers2 = will.modulesFilter( will.currentOpeners, filter );
    if( openers2.length )
    will.currentOpeners = openers2;
  }

  ready
  .then( () => will.openersCurrentEach( forSingle ) )
  .finally( end );

  return ready;

  /* */

  function forSingle( it )
  {
    let ready2 = new _.Consequence().take( null );
    let it2 = _.mapExtend( null, o, it );

    ready2.then( () =>
    {
      return will.currentOpenerChange( it.opener );
    });

    ready2.then( () =>
    {
      will.readingEnd();
      return o.onEach.call( will, it2 );
    });

    ready2.finally( ( err, arg ) =>
    {
      will.currentOpenerChange( null );
      if( err )
      throw _.err( err, `\nFailed to ${o.name} ${it.opener ? it.opener.commonPath : ''}` );
      return arg;
    });

    return ready2;
  }

  /* */

  function end( err, arg )
  {
    will._commandsEnd( o.commandRoutine );
    if( err )
    debugger;
    if( err )
    logger.log( _.errOnce( err ) );
    if( err )
    throw err;
    return arg;
  }

}

_commandBuildLike.defaults =
{
  event : null,
  onEach : null,
  commandRoutine : null,
  name : null,
  withIn : 1,
  withOut : 1,
  withBroken : 0,
}

//

function _commandTreeLike( o )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  _.routineOptions( _commandTreeLike, arguments );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onAll ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  will._commandsBegin( o.commandRoutine );

  _.assert( will.currentOpener === null );
  if( will.currentOpeners === null )
  ready.then( () => will.openersFind() );

  ready.then( () =>
  {
    let ready2 = new _.Consequence().take( null );

    will.currentOpeners.forEach( ( opener ) => ready2.then( () =>
    {
      _.assert( !!opener.openedModule );
      if( !opener.openedModule.isValid() )
      return null;
      return opener.openedModule.modulesUpform({ recursive : 2, all : 1, resourcesFormed : 0 });
    }));

    ready2.then( () =>
    {
      will.readingEnd();
      let it2 = _.mapExtend( null, o );
      it2.modules = will.modulesOnlyRoots();
      return o.onAll.call( will, it2 );
    });

    return ready2;
  })
  .finally( ( err, arg ) =>
  {
    will._commandsEnd( o.commandRoutine );
    if( err )
    err = _.err( err, `\nFailed to ${o.name}` );
    if( err )
    logger.log( _.errOnce( err ) );
    if( err )
    throw err;
    return arg;
  });

  return ready;
}

_commandTreeLike.defaults =
{
  event : null,
  onAll : null,
  commandRoutine : null,
  name : null,
}

//

function openersFind()
{
  let will = this;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( will.currentOpener === null );
  _.assert( will.currentOpeners === null );
  _.assert( arguments.length === 0 );

  return will.modulesFindWithAt({ selector : './', tracing : 1 })
  .finally( function( err, it )
  {

    if( err )
    debugger;
    if( err )
    throw _.err( err );

    will.currentOpeners = it.openers;
    if( !will.currentOpeners.length )
    debugger;
    if( !will.currentOpeners.length )
    throw _.errBrief( `Found no willfile at ${path.resolve( './' )}` );

    return will.currentOpeners;
  })

}

//

function _commandsMake()
{
  let will = this;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let appArgs = _.process.args();

  _.assert( _.instanceIs( will ) );
  _.assert( arguments.length === 0 );

  let commands =
  {

    'help' :                            { e : _.routineJoin( will, will.commandHelp ),                        h : 'Get help.' },
    'imply' :                           { e : _.routineJoin( will, will.commandImply ),                       h : 'Change state or imply value of a variable' },
    'version' :                         { e : _.routineJoin( will, will.commandVersion ),                     h : 'Get current version.' },
    'version check' :                   { e : _.routineJoin( will, will.commandVersionCheck ),                h : 'Check if current version of willbe is the latest.' },

    'resources list' :                  { e : _.routineJoin( will, will.commandResourcesList ),               h : 'List information about resources of the current module.' },
    'paths list' :                      { e : _.routineJoin( will, will.commandPathsList ),                   h : 'List paths of the current module.' },
    'submodules list' :                 { e : _.routineJoin( will, will.commandSubmodulesList ),              h : 'List submodules of the current module.' },
    'modules list' :                    { e : _.routineJoin( will, will.commandModulesList ),                 h : 'List all modules.' },
    'modules topological list' :        { e : _.routineJoin( will, will.commandModulesTopologicalList ),      h : 'List all modules topologically.' },
    'modules tree' :                    { e : _.routineJoin( will, will.commandModulesTree ),                 h : 'List all found modules as a tree.' },
    'reflectors list' :                 { e : _.routineJoin( will, will.commandReflectorsList ),              h : 'List avaialable reflectors the current module.' },
    'steps list' :                      { e : _.routineJoin( will, will.commandStepsList ),                   h : 'List avaialable steps the current module.' },
    'builds list' :                     { e : _.routineJoin( will, will.commandBuildsList ),                  h : 'List avaialable builds the current module.' },
    'exports list' :                    { e : _.routineJoin( will, will.commandExportsList ),                 h : 'List avaialable exports the current module.' },
    'about list' :                      { e : _.routineJoin( will, will.commandAboutList ),                   h : 'List descriptive information about the current module.' },

    'submodules clean' :                { e : _.routineJoin( will, will.commandSubmodulesClean ),             h : 'Delete all downloaded submodules.' },
    'submodules fixate' :               { e : _.routineJoin( will, will.commandSubmodulesFixate ),            h : 'Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.' },
    'submodules upgrade' :              { e : _.routineJoin( will, will.commandSubmodulesUpgrade ),           h : 'Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.' },

    'submodules download' :             { e : _.routineJoin( will, will.commandSubmodulesVersionsDownload ),  h : 'Download each submodule if such was not downloaded so far.' },
    'submodules update' :               { e : _.routineJoin( will, will.commandSubmodulesVersionsUpdate ),    h : 'Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.' },
    'submodules versions download' :    { e : _.routineJoin( will, will.commandSubmodulesVersionsDownload ),  h : 'Download each submodule if such was not downloaded so far.' },
    'submodules versions update' :      { e : _.routineJoin( will, will.commandSubmodulesVersionsUpdate ),    h : 'Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.' },
    'submodules versions verify' :      { e : _.routineJoin( will, will.commandSubmodulesVersionsVerify ),    h : 'Check whether each submodule is on branch which is specified in willfile' },
    'submodules versions agree' :       { e : _.routineJoin( will, will.commandSubmodulesVersionsAgree ),     h : 'Update each submodule, checking for available updates for each submodule. Does not change state of module if update is needed and module has local changes.' },

    'shell' :                           { e : _.routineJoin( will, will.commandShell ),                       h : 'Run shell command on the module.' },
    'do' :                              { e : _.routineJoin( will, will.commandDo ),                          h : 'Run JS script on the module.' },
    'clean' :                           { e : _.routineJoin( will, will.commandClean ),                       h : 'Clean current module. Delete genrated artifacts, temp files and downloaded submodules.' },
    'build' :                           { e : _.routineJoin( will, will.commandBuild ),                       h : 'Build current module with spesified criterion.' },
    'export' :                          { e : _.routineJoin( will, will.commandExport ),                      h : 'Export selected the module with spesified criterion. Save output to output willfile and archive.' },
    'export recursive' :                { e : _.routineJoin( will, will.commandExportRecursive ),             h : 'Export selected the module with spesified criterion and its submodules. Save output to output willfile and archive.' },
    'with' :                            { e : _.routineJoin( will, will.commandWith ),                        h : 'Use "with" to select a module.' },
    'each' :                            { e : _.routineJoin( will, will.commandEach ),                        h : 'Use "each" to iterate each module in a directory.' },

    'git config preserving hardlinks' : { e : _.routineJoin( will, will.commandGitPreservingHardLinks ),      h : 'Use "git config preserving hard links" to switch on preserve hardlinks' },

  }

  let ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands : commands,
    commandPrefix : 'node ',
    logger : will.logger,
  })

  _.assert( ca.logger === will.logger );
  _.assert( ca.verbosity === will.verbosity );

  //will._commandsConfigAdd( ca );

  ca.form();

  return ca;
}

//

function _commandsBegin( command )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  if( will.topCommand === null )
  will.topCommand = command;

}

//

function _commandsEnd( command )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  if( will.topCommand !== command )
  return false;

  try
  {

    will.topCommand = null;

    if( will.currentOpener )
    will.currentOpener.finit();
    will.currentOpenerChange( null );

    if( will.currentOpeners )
    will.currentOpeners.forEach( ( opener ) => opener.finitedIs() ? null : opener.finit() );
    will.currentOpeners = null;

    if( will.beeping )
    _.diagnosticBeep();
    _.procedure.terminationBegin();

  }
  catch( err )
  {
    debugger;
    will.errEncounter( err );
    will.currentOpenerChange( null );
    if( will.beeping )
    _.diagnosticBeep();
    _.process.exit( -1 );
  }

  return true;
}

//

function errEncounter( error )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  _.process.exitCode( -1 );
  logger.log( _.errOnce( error ) );
  // _.errLogOnce( error );

}

//

function currentOpenerChange( src )
{
  let will = this;

  _.assert( src === null || src instanceof will.ModuleOpener );
  _.assert( arguments.length === 1 );

  if( src && will[ currentOpenerSymbol ] === src )
  return src;

  will[ currentOpenerSymbol ] = src;
  will.currentPath = null;

  return src;
}

//

function commandHelp( e )
{
  let will = this;
  let ca = e.ca;
  let logger = will.logger;

  ca._commandHelp( e );

  if( !e.subject )
  {
    _.assert( 0 );
  }

}

//

function commandImply( e )
{
  let will = this;
  let ca = e.ca;
  let logger = will.logger;

  let namesMap =
  {
    v : 'verbosity',
    verbosity : 'verbosity',
    beeping : 'beeping',
    withOut : 'withOut',
    withIn : 'withIn',
  }

  let request = will.Resolver.strRequestParse( e.argument );

  _.process.argsReadTo
  ({
    dst : will,
    propertiesMap : request.map,
    namesMap : namesMap,
  });

}

//

function commandVersion( e )
{
  let will = this;
  let ca = e.ca;
  let logger = will.logger;
  logger.log( 'Current version:', will.versionGet() );
}

//

function commandVersionCheck( e )
{
  let will = this;
  let ca = e.ca;
  let logger = will.logger;

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );

  return will.versionIsUpToDate( propertiesMap );
}

commandVersionCheck.commandProperties =
{
  throwing : 'Throw an error if utility is not up to date. Default : 1'
}

//

function commandWith( e )
{
  let will = this.form();
  let ca = e.ca;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  if( will.currentOpener )
  {
    will.currentOpener.finit();
    will.currentOpenerChange( null );
  }

  _.sure( _.strDefined( e.argument ), 'Expects path to module' );
  _.assert( arguments.length === 1 );

  will._commandsBegin( commandWith );

  // debugger;
  let isolated = ca.commandIsolateSecondFromArgument( e.argument );
  // debugger;

  if( !isolated )
  throw _.errBrief( 'Format of .with command should be: .with {-path-} .command' );

  return will.modulesFindWithAt({ selector : isolated.argument })
  .then( function( it )
  {

    // debugger;
    // will.currentOpeners = it.openers;
    will.currentOpeners = it.sortedOpeners;

    if( !will.currentOpeners.length )
    throw _.errBrief( 'Found no willfile at ' + _.strQuote( path.resolve( isolated.argument ) ) );

    return ca.commandPerform
    ({
      command : isolated.secondCommand,
    })
  })
  .finally( ( err, arg ) =>
  {
    if( err )
    will.errEncounter( err );
    will._commandsEnd( commandWith );
    if( err )
    {
      err = _.err( err );
      logger.log( _.errOnce( err ) );
      throw err;
    }
    return arg;
  });

}

//

function commandEach( e )
{
  let will = this.form();
  let ca = e.ca;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let levelUp = 0;

  if( will.currentOpener )
  {
    will.currentOpener.finit();
    will.currentOpenerChange( null );
  }

  _.sure( _.strDefined( e.argument ), 'Expects path to module' )
  _.assert( arguments.length === 1 );

  will._commandsBegin( commandEach );

  let isolated = ca.commandIsolateSecondFromArgument( e.argument );

  if( !isolated )
  throw _.errBrief( 'Format of .each command should be: .each {-path-} .command' );

  _.assert( _.objectIs( isolated ), 'Command .each should go with the second command to apply to each module. For example : ".each submodule::* .shell ls -al"' );

  let con = will.modulesFindEachAt
  ({
    selector : isolated.argument,
    onBegin : handleBegin,
    onEnd : handleEnd,
    onError : handleError,
  });

  con.finally( ( err, arg ) =>
  {
    if( err )
    will.errEncounter( err );
    will._commandsEnd( commandEach );
    if( err )
    {
      err = _.err( err );
      logger.log( _.errOnce( err ) );
      throw err;
    }
    // throw _.errLogOnce( err );
    return arg;
  });

  return con;

  /* */

  function handleBegin( it )
  {

    // debugger;
    _.assert( will.currentOpener === null );
    _.assert( will.currentPath === null );
    // _.assert( will.mainModule === null );
    // _.assert( will.mainOpener === null ); // yyy

    if( will.mainOpener )
    will.mainOpener.isMain = false;
    will.currentOpenerChange( it.currentOpener );
    will.currentPath = it.currentPath || null;
    it.currentOpener.isMain = true;
    _.assert( will.mainOpener === it.currentOpener );
    _.assert( will.currentOpener === it.currentOpener );
    // will.mainOpener = it.currentOpener;
    // will.mainModule = it.currentOpener.openedModule;
    // will.mainOpener === it.currentOpener; // yyy

    if( will.verbosity > 1 )
    {
      logger.log( '' );
      logger.log( _.color.strFormat( 'Module at', { fg : 'bright white' } ), _.color.strFormat( it.currentOpener.commonPath, 'path' ) );
      if( will.currentPath )
      logger.log( _.color.strFormat( '       at', { fg : 'bright white' } ), _.color.strFormat( will.currentPath, 'path' ) );
    }

    return null;
  }

  /* */

  function handleEnd( it )
  {

    // debugger;
    logger.up();
    levelUp = 1;

    // debugger;
    let r = ca.commandPerform
    ({
      command : isolated.secondCommand,
    });

    _.assert( r !== undefined );

    r = _.Consequence.From( r );

    return r.finally( ( err, arg ) =>
    {
      logger.down();
      levelUp = 0;

      // debugger;
      _.assert( will.currentOpener === it.currentOpener || will.currentOpener === null );
      // _.assert( will.currentOpener === it.currentOpener ); // xxx
      // _.assert( will.mainModule === will.currentOpener.openedModule );
      _.assert( will.mainOpener === it.currentOpener );
      will.currentOpenerChange( null );
      it.currentOpener.isMain = false;
      if( !it.currentOpener.isUsed() )
      it.currentOpener.finit();
      _.assert( will.mainOpener === null );
      _.assert( will.currentOpener === null );
      _.assert( will.currentPath === null );
      // will.mainModule = null;
      // will.mainOpener = null; // yyy

      if( err )
      logger.log( _.errOnce( _.errBrief( '\n', err, '\n' ) ) );
      if( err )
      throw _.err( err );
      return arg;
    });

  }

  /* */

  function handleError( err )
  {

    if( will.currentOpener )
    will.currentOpener.finit();
    will.currentOpenerChange( null );
    // will.mainModule = null;
    will.mainOpener = null;

    if( levelUp )
    {
      levelUp = 0;
      logger.down();
    }

  }

}

//

function commandGitPreservingHardLinks( e )
{
  let will = this;
  let ca = e.ca;
  let logger = will.logger;

  let enable = _.numberFrom( e.argument );

  if( enable )
  _.git.hookPreservingHardLinksRegister();
  else
  _.git.hookPreservingHardLinksUnregister();
}

//

function commandResourcesList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list resources',
    onEach : act,
    commandRoutine : commandResourcesList,
    resourceKind : '*',
  });

  function act( module, resources )
  {
    let logger = will.logger;

    if( !e.request.subject && !_.mapKeys( e.request.map ).length )
    {
      let result = '';
      result += _.color.strFormat( 'About', 'highlighted' );
      result += module.openedModule.about.infoExport();
      logger.log( result );
    }

    logger.log( module.openedModule.infoExportResource( resources ) );

  }

  // return will._commandListLike( e, act, '*' );
}

//

function commandPathsList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list paths',
    onEach : act,
    commandRoutine : commandPathsList,
    resourceKind : 'path',
  });

  function act( module, resources )
  {

    let logger = will.logger;
    logger.log( module.openedModule.infoExportPaths( resources ) );

  }

  // return will._commandListLike( e, act, 'path' );
}

//

function commandSubmodulesList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list submodules',
    onEach : act,
    commandRoutine : commandSubmodulesList,
    resourceKind : 'submodule',
  });

  function act( module, resources )
  {
    let logger = will.logger;
    logger.log( module.openedModule.infoExportResource( resources ) );
  }

  // return will._commandListLike( e, act, 'submodule' );
}

//

function commandReflectorsList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list reflectors',
    onEach : act,
    commandRoutine : commandReflectorsList,
    resourceKind : 'reflector',
  });

  function act( module, resources )
  {
    let logger = will.logger;
    logger.log( module.openedModule.infoExportResource( resources ) );
  }

  // return will._commandListLike( e, act, 'reflector' );
}

//

function commandStepsList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list steps',
    onEach : act,
    commandRoutine : commandStepsList,
    resourceKind : 'step',
  });

  function act( module, resources )
  {
    let logger = will.logger;
    logger.log( module.openedModule.infoExportResource( resources ) );
  }

  // return will._commandListLike( e, act, 'step' );
}

//

function commandBuildsList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list builds',
    onEach : act,
    commandRoutine : commandBuildsList,
    resourceKind : null,
  });

  function act( module )
  {
    let logger = will.logger;
    let request = will.Resolver.strRequestParse( e.argument );
    let builds = module.openedModule.buildsResolve
    ({
      name : request.subject,
      criterion : request.map,
      preffering : 'more',
    });
    logger.log( module.openedModule.infoExportResource( builds ) );
  }

  // return will._commandListLike( e, act, null );
}

//

function commandExportsList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list exports',
    onEach : act,
    commandRoutine : commandExportsList,
    resourceKind : null,
  });

  function act( module )
  {
    let logger = will.logger;
    let request = will.Resolver.strRequestParse( e.argument );
    let builds = module.openedModule.exportsResolve
    ({
      name : request.subject,
      criterion : request.map,
      preffering : 'more',
    });
    logger.log( module.openedModule.infoExportResource( builds ) );
  }

  // return will._commandListLike( e, act, null );
}

//

function commandAboutList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list about',
    onEach : act,
    commandRoutine : commandAboutList,
    resourceKind : null,
  });

  function act( module )
  {
    let logger = will.logger;
    logger.log( _.color.strFormat( 'About', 'highlighted' ) );
    logger.log( module.openedModule.about.infoExport() );
  }

  // return will._commandListLike( e, act, null );
}

//

function commandModulesList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list modules',
    onEach : act,
    commandRoutine : commandModulesList,
    resourceKind : 'module',
  });

  function act( module, resources )
  {
    let logger = will.logger;
    logger.log( module.openedModule.infoExportResource( resources ) );
  }

  // return will._commandListLike( e, act, 'module' );
}

//

function commandModulesTopologicalList( e )
{
  let will = this;

  return will._commandListLike
  ({
    event : e,
    name : 'list topological sorted order',
    onEach : act,
    commandRoutine : commandModulesTopologicalList,
    resourceKind : 'module',
  });

  function act( module, resources )
  {
    let logger = will.logger; // xxx
    logger.log( module.openedModule.infoExportModulesTopological( resources ) );
  }

  // return will._commandListLike( e, act, 'module' );
}

//

function commandModulesTree( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let request = will.Resolver.strRequestParse( e.argument );
  let propertiesMap = _.strStructureParse( e.argument );

  return will._commandTreeLike
  ({
    event : e,
    name : 'list tree of modules',
    onAll : handleAll,
    commandRoutine : commandModulesTree,
  });

  function handleAll( it )
  {
    let modules = it.modules;
    logger.log( will.graphInfoExportAsTree( modules, propertiesMap ) );
    return null;
  }

}

var defaults = commandModulesTree.commandProperties = Object.create( null );

defaults.withLocalPath = 'Print local paths. Default is 0';
defaults.withRemotePath = 'Print remote paths. Default is 0';

//

function commandSubmodulesClean( e )
{
  let will = this;

  return will._commandBuildLike
  ({
    event : e,
    name : 'clean submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesClean,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.submodulesClean();
  }
}

//

function commandSubmodulesFixate( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )
  e.propertiesMap.reportingNegative = e.propertiesMap.negative;
  e.propertiesMap.upgrading = 0;
  delete e.propertiesMap.negative;

  return will._commandBuildLike
  ({
    event : e,
    name : 'fixate submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesFixate,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.submodulesFixate( _.mapExtend( null, e.propertiesMap ) );
  }

}

commandSubmodulesFixate.commandProperties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  negative : 'Reporting attempt of fixation with negative outcome. Default is negative:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
}

//

function commandSubmodulesUpgrade( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )
  e.propertiesMap.upgrading = 1;
  e.propertiesMap.reportingNegative = e.propertiesMap.negative;
  delete e.propertiesMap.negative;

  return will._commandBuildLike
  ({
    event : e,
    name : 'upgrade submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesUpgrade,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.submodulesFixate( _.mapExtend( null, e.propertiesMap ) );
  }

}

commandSubmodulesUpgrade.commandProperties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  negative : 'Reporting attempt of upgrade with negative outcome. Default is negative:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
}

//

function commandSubmodulesVersionsDownload( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )

  return will._commandBuildLike
  ({
    event : e,
    name : 'download submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesVersionsDownload,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.subModulesDownload( _.mapExtend( null, e.propertiesMap ) );
  }

}

commandSubmodulesVersionsDownload.commandProperties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
}

//

function commandSubmodulesVersionsUpdate( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )

  return will._commandBuildLike
  ({
    event : e,
    name : 'update submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesVersionsUpdate,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.subModulesUpdate( _.mapExtend( null, e.propertiesMap ) );
  }

}

commandSubmodulesVersionsUpdate.commandProperties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
}

//

function commandSubmodulesVersionsVerify( e )
{
  let will = this;

  let propertiesMap = _.strStructureParse( e.argument );
  _.sure( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )

  return will._commandBuildLike
  ({
    event : e,
    name : 'submodules versions verify',
    onEach : handleEach,
    commandRoutine : commandSubmodulesVersionsVerify,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.versionsVerify( _.mapExtend( null, e.propertiesMap ) );
  }
}

commandSubmodulesVersionsVerify.commandProperties =
{
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
}

//

function commandSubmodulesVersionsAgree( e )
{
  let will = this;

  let propertiesMap = _.strStructureParse( e.argument );
  _.sure( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )

  return will._commandBuildLike
  ({
    event : e,
    name : 'submodules versions agree',
    onEach : handleEach,
    commandRoutine : commandSubmodulesVersionsAgree,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.subModulesAgree( _.mapExtend( null, e.propertiesMap ) );
  }

}

commandSubmodulesVersionsVerify.commandProperties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
}

//

function commandShell( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  return will._commandBuildLike
  ({
    event : e,
    name : 'shell',
    onEach : handleEach,
    commandRoutine : commandShell,
  });

  function handleEach( it )
  {
    let logger = will.logger;
    debugger;
    return it.opener.openedModule.shell
    ({
      execPath : e.argument,
      currentPath : will.currentPath || it.opener.openedModule.dirPath,
    });
  }

}

//

function commandDo( e )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let time = _.timeNow();

  let isolated = e.ca.commandIsolateSecondFromArgument( e.argument );
  let execPath, delimeter, request;
  // debugger;
  [ execPath, delimeter, request ] = _.strIsolateLeftOrAll( e.argument, /\s+/ );
  request = _.strRequestParse( request );
  // debugger;

  return will._commandBuildLike
  ({
    event : e,
    name : 'do',
    onEach : handleEach,
    commandRoutine : commandDo,
    withOut : 0,
    withBroken : 1,
  })
  .then( ( arg ) =>
  {
    if( will.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( e.argument, 'code' )} in ${_.timeSpent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let currentPath = will.currentPath || _.path.current();
    it.tools = wTools;
    it.path = path;
    it.fileProvider = fileProvider;
    it.ready = new _.Consequence().take( null );
    it.currentPath = currentPath;
    it.dirPath = path.dirFirst( it.variant.localPath );
    it.logger = logger;
    it.request = request;
    it.start = _.process.starter
    ({
      currentPath : it.dirPath,
      outputCollecting : 1,
      outputGraying : 1,
      outputPiping : 1,
      inputMirroring : 1,
      mode : 'spawn',
      ready : it.ready
    });
    let r = it.opener.openedModule.doJs
    ({
      execPath : execPath,
      currentPath : currentPath,
      args : [ it ],
      ready : it.ready,
    });
    if( _.consequenceIs( r ) || _.promiseLike( r ) )
    return r;
    return it.ready;
  }

}

//

function commandClean( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap );
  e.propertiesMap.dry = !!e.propertiesMap.dry;;
  let dry = e.propertiesMap.dry;
  // delete e.propertiesMap.dry;
  if( e.propertiesMap.fast === undefined || e.propertiesMap.fast === null )
  e.propertiesMap.fast = !dry;
  e.propertiesMap.fast = 0;

  return will._commandBuildLike
  ({
    event : e,
    name : 'clean',
    onEach : handleEach,
    commandRoutine : commandClean,
  });

  function handleEach( it )
  {
    // if( dry )
    // return it.opener.openedModule.cleanWhatReport( _.mapExtend( null, e.propertiesMap ) );
    // else
    return it.opener.openedModule.clean( _.mapExtend( null, e.propertiesMap ) );
  }

}

commandClean.commandProperties =
{
  dry : 'Dry run without deleting. Default is dry:0.',
  cleaningSubmodules : 'Deleting directory ".module" dir with remote submodules. Default is cleaningSubmodules:1.',
  cleaningOut : 'Deleting generated out files. Default is cleaningOut:1.',
  cleaningTemp : 'Deleting module-specific temporary directory. Default is cleaningTemp:1.',
  recursive : 'Recursive cleaning. recursive:0 - only curremt module, recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:0.',
  fast : 'Faster implementation, but fewer diagnostic information. Default fast:1 for dry:0 and fast:0 for dry:1.',
}

//

function commandBuild( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let request = will.Resolver.strRequestParse( e.argument );

  return will._commandBuildLike
  ({
    event : e,
    name : 'build',
    onEach : handleEach,
    commandRoutine : commandBuild,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.modulesBuild
    ({
      name : request.subject,
      criterion : request.map,
      recursive : 0,
      kind : 'build',
    });
  }

}

//

function commandExport( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let request = will.Resolver.strRequestParse( e.argument );

  return will._commandBuildLike
  ({
    event : e,
    name : 'export',
    onEach : handleEach,
    commandRoutine : commandExport,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.modulesExport
    ({
      name : request.subject,
      criterion : request.map,
      recursive : 0,
      kind : 'export',
    });
  }

}

//

function commandExportRecursive( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let request = will.Resolver.strRequestParse( e.argument );

  return will._commandBuildLike
  ({
    event : e,
    name : 'export',
    onEach : handleEach,
    commandRoutine : commandExportRecursive,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.modulesExport
    ({
      name : request.subject,
      criterion : request.map,
      recursive : 2,
      kind : 'export',
    });
  }

}

// --
// relations
// --

let currentOpenerSymbol = Symbol.for( 'currentOpener' );

let Composes =
{
  beeping : 0,
}

let Aggregates =
{
}

let Associates =
{
  currentOpeners : null,
  currentPath : null,
}

let Restricts =
{
  topCommand : null,
}

let Statics =
{
  Exec : Exec,
}

let Forbids =
{
}

let Accessors =
{
  currentOpener : { readOnly : 1 },
}

// --
// declare
// --

let Extend =
{

  // exec

  Exec,
  exec,
  init,

  _openersCurrentEach,
  openersCurrentEach,

  _commandListLike,
  _commandBuildLike,
  _commandTreeLike,

  openersFind,

  _commandsMake,
  _commandsBegin,
  _commandsEnd,
  errEncounter,
  currentOpenerChange,

  commandHelp,
  commandImply,
  commandVersion,
  commandVersionCheck,
  commandWith,
  commandEach,

  commandResourcesList,
  commandPathsList,
  commandSubmodulesList,
  commandReflectorsList,
  commandStepsList,
  commandBuildsList,
  commandExportsList,
  commandAboutList,

  commandModulesList,
  commandModulesTopologicalList,
  commandModulesTree,

  commandSubmodulesClean,
  commandSubmodulesFixate,
  commandSubmodulesUpgrade,
  commandSubmodulesVersionsDownload,
  commandSubmodulesVersionsUpdate,
  commandSubmodulesVersionsVerify,
  commandSubmodulesVersionsAgree,

  commandShell,
  commandDo,
  commandClean,
  commandBuild,
  commandExport,
  commandExportRecursive,

  commandGitPreservingHardLinks,

  // relation

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
  extend : Extend,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
wTools[ Self.shortName ] = Self;

// _.process.exitHandlerRepair();
if( !module.parent )
Self.Exec();

})();
