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
  let appArgs = _.appArgs({ keyValDelimeter : 0 });
  let ca = will._commandsMake();


  return _.Consequence
  .Try( () =>
  {
    return ca.appArgsPerform({ appArgs });
  })
  .catch( ( err ) =>
  {
    _.appExitCode( -1 );
    return _.errLogOnce( err );
  });

  // return ca.appArgsPerform({ appArgs : appArgs });
}

//

function init( o )
{
  let will = this;

  will[ currentOpenerSymbol ] = null;

  return Parent.prototype.init.apply( will, arguments );
}

//

function _moduleReadyThen( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let willfilesPath = fileProvider.path.trail( fileProvider.path.current() );
  let con = new _.Consequence();

  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( o.onReady ) );
  _.assert( will.currentOpener === null || will.currentOpeners === null );
  _.routineOptions( _moduleReadyThen, arguments );

  if( will.currentOpeners )
  {

    will.currentOpeners.forEach( ( opener ) =>
    {
      con.then( ( arg ) =>
      {
        _.assert( will.currentOpener === null );
        _.assert( will.currentPath === null );
        _.assert( will.mainModule === null );
        will.currentOpenerChange( opener );
        return ready( opener );
      });
      con.then( ( arg ) =>
      {
        _.assert( will.currentOpener === opener );
        _.assert( will.currentPath === null );
        _.assert( will.mainModule === null );
        will.currentOpenerChange( null );
        return arg;
      });
    });

  }
  else
  {

    let made = false;
    con.then( ( arg ) =>
    {
      let opener = will.currentOpener;
      if( !opener )
      {
        opener = will.moduleMake
        ({
          willfilesPath : willfilesPath,
          isMain : 1,
        });
        _.assert( will.currentOpener === null );
        _.assert( will.currentPath === null );
        _.assert( will.mainModule === opener.openedModule );
        will.currentOpenerChange( opener );
        made = true;
      }
      return ready( opener );
    });
    con.then( ( arg ) =>
    {
      if( made )
      {
        _.assert( will.currentPath === null );
        _.assert( will.mainModule === will.currentOpener.openedModule );
        will.currentOpenerChange( null );
      }
      return arg;
    });

  }

  con.take( null );
  con.finally( ( err, arg ) =>
  {
    if( err )
    throw err;
    return arg;
  });

  return con;

  /* */

  function ready( opener )
  {
    return opener.openedModule.ready.split()
    .then( function( arg )
    {
      let result = o.onReady( opener );
      _.assert( result !== undefined );
      return result;
    })
    .finally( ( err, arg ) =>
    {
      if( err )
      will.errEncounter( err );
      if( err )
      throw _.errLogOnce( err );
      return arg;
    })
    ;
  }

}

_moduleReadyThen.defaults =
{
  onReady : null,
}

//

function moduleReadyThen( onReady )
{
  let will = this.form();
  _.assert( arguments.length === 1 );
  return will._moduleReadyThen
  ({
    onReady : onReady,
  });
}

//

function _commandsMake()
{
  let will = this;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let appArgs = _.appArgs();

  _.assert( _.instanceIs( will ) );
  _.assert( arguments.length === 0 );

  let commands =
  {

    'help' :                    { e : _.routineJoin( will, will.commandHelp ),                        h : 'Get help.' },
    'imply' :                   { e : _.routineJoin( will, will.commandImply ),                       h : 'Change state or imply value of a variable' },

    'resources list' :          { e : _.routineJoin( will, will.commandResourcesList ),               h : 'List information about resources of the current module.' },
    'paths list' :              { e : _.routineJoin( will, will.commandPathsList ),                   h : 'List paths of the current module.' },
    'submodules list' :         { e : _.routineJoin( will, will.commandSubmodulesList ),              h : 'List submodules of the current module.' },
    'modules list' :            { e : _.routineJoin( will, will.commandModulesList ),                 h : 'List all modules.' },
    'modules topological list' :{ e : _.routineJoin( will, will.commandModulesTopologicalList ),      h : 'List all modules topologically.' },
    'modules tree list' :       { e : _.routineJoin( will, will.commandModulesTreeList ),             h : 'List all modules as tree.' },
    'reflectors list' :         { e : _.routineJoin( will, will.commandReflectorsList ),              h : 'List avaialable reflectors the current module.' },
    'steps list' :              { e : _.routineJoin( will, will.commandStepsList ),                   h : 'List avaialable steps the current module.' },
    'builds list' :             { e : _.routineJoin( will, will.commandBuildsList ),                  h : 'List avaialable builds the current module.' },
    'exports list' :            { e : _.routineJoin( will, will.commandExportsList ),                 h : 'List avaialable exports the current module.' },
    'about list' :              { e : _.routineJoin( will, will.commandAboutList ),                   h : 'List descriptive information about the current module.' },

    'submodules clean' :        { e : _.routineJoin( will, will.commandSubmodulesClean ),             h : 'Delete all downloaded submodules.' },
    'submodules download' :     { e : _.routineJoin( will, will.commandSubmodulesDownload ),          h : 'Download each submodule if such was not downloaded so far.' },
    'submodules update' :       { e : _.routineJoin( will, will.commandSubmodulesUpdate ),            h : 'Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.' },
    'submodules fixate' :       { e : _.routineJoin( will, will.commandSubmodulesFixate ),            h : 'Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.' },
    'submodules upgrade' :      { e : _.routineJoin( will, will.commandSubmodulesUpgrade ),           h : 'Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.' },

    'shell' :                   { e : _.routineJoin( will, will.commandShell ),                       h : 'Execute shell command on the module.' },
    'clean' :                   { e : _.routineJoin( will, will.commandClean ),                       h : 'Clean current module. Delete genrated artifacts, temp files and downloaded submodules.' },
    'build' :                   { e : _.routineJoin( will, will.commandBuild ),                       h : 'Build current module with spesified criterion.' },
    'export' :                  { e : _.routineJoin( will, will.commandExport ),                      h : 'Export selected the module with spesified criterion. Save output to output file and archive.' },
    'with' :                    { e : _.routineJoin( will, will.commandWith ),                        h : 'Use "with" to select a module.' },
    'each' :                    { e : _.routineJoin( will, will.commandEach ),                        h : 'Use "each" to iterate each module in a directory.' },

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
    _.appExit( -1 );
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

  _.appExitCode( -1 );
  _.errLogOnce( error );

}

//

function errTooMany( elements, what )
{
  let will = this;

  if( elements.length !== 1 )
  {
    debugger;
    if( elements.length === 0 )
    return _.errBriefly( 'Please specify exactly one ' + what + ', none satisfies passed arguments' );
    else
    return _.errBriefly( 'Please specify exactly one ' + what + ', ' + elements.length + ' satisfy(s)' + '\nFound : ' + _.strQuote( _.select( elements, '*/name' ) ) );
  }

  return false;
}

//

function currentOpenerChange( src )
{
  let will = this;

  _.assert( src === null || src instanceof will.OpenerModule );
  _.assert( arguments.length === 1 );

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
  }

  let request = will.Resolver.strRequestParse( e.argument );

  _.appArgsReadTo
  ({
    dst : will,
    propertiesMap : request.map,
    namesMap : namesMap,
  });

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

  let isolated = ca.commandIsolateSecondFromArgument( e.argument );

  if( !isolated )
  throw _.err( 'Format is: .with {-path-} .action' );

  return will.moduleWithAt({ selector : isolated.argument })
  .then( function( it )
  {

    will.currentOpeners = it.openers;

    if( !will.currentOpeners.length )
    throw _.errBriefly( 'Found no willfile at ' + _.strQuote( isolated.argument ) );

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
    throw _.errLogOnce( err );
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
  throw _.err( 'Format is: .each {-path-} .action' );

  _.assert( _.objectIs( isolated ), 'Command .each should go with the second command to apply to each module. For example : ".each submodule::* .shell ls -al"' );

  let con = will.moduleEachAt
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
    throw _.errLogOnce( err );
    return arg;
  });

  return con;

  /* */

  function handleBegin( it )
  {

    _.assert( will.currentOpener === null );
    _.assert( will.currentPath === null );
    _.assert( will.mainModule === null );

    if( will.verbosity > 1 )
    {
      logger.log( '' );
      logger.log( _.color.strFormat( 'Module at', { fg : 'bright white' } ), _.color.strFormat( it.currentOpener.commonPath, 'path' ) );
      if( will.currentPath )
      logger.log( _.color.strFormat( '       at', { fg : 'bright white' } ), _.color.strFormat( will.currentPath, 'path' ) );
    }

    will.currentOpenerChange( it.currentOpener );
    will.currentPath = it.currentPath || null;
    will.mainModule = it.currentOpener.openedModule;

    return null;
  }

  /* */

  function handleEnd( it )
  {

    logger.up();
    levelUp = 1;

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

      _.assert( will.currentOpener === it.currentOpener );
      _.assert( will.mainModule === will.currentOpener.openedModule );
      will.currentOpener.finit();
      will.currentOpenerChange( null );
      will.mainModule = null;

      if( err )
      logger.log( _.errOnce( _.errBriefly( '\n', err, '\n' ) ) );
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
    will.mainModule = null;
    if( levelUp )
    {
      levelUp = 0;
      logger.down();
    }

  }

}

//

function _commandList( e, act, resourceKind )
{
  let will = this;

  _.assert( arguments.length === 3 );

  return will.moduleReadyThen( function( module )
  {

    let resources = null;
    if( resourceKind )
    {

      let resourceKindIsGlob = _.path.isGlob( resourceKind );
      _.assert( e.request === undefined );
      e.request = will.Resolver.strRequestParse( e.argument );

      if( will.Resolver.selectorIs( e.request.subject ) )
      {
        let splits = will.Resolver.selectorShortSplit
        ({
          selector : e.request.subject,
          defaultResourceKind : resourceKind,
        });
        resourceKind = splits[ 0 ];
        resourceKindIsGlob = _.path.isGlob( resourceKind );
      }

      if( resourceKindIsGlob && e.request.subject && !will.Resolver.selectorIs( e.request.subject ) )
      {
        e.request.subject = '*::' + e.request.subject;
      }

      let o2 =
      {
        selector : resourceKindIsGlob ? ( e.request.subject || '*::*' ) : ( e.request.subject || '*' ),
        criterion : e.request.map,
        defaultResourceKind : resourceKindIsGlob ? null : resourceKind,
        prefixlessAction : resourceKindIsGlob ? 'throw' : 'default',
        arrayWrapping : 1,
        pathUnwrapping : resourceKindIsGlob ? 0 : 1,
        pathResolving : 0,
        mapValsUnwrapping : resourceKindIsGlob ? 0 : 1,
        strictCriterion : 1,
        currentExcluding : 0,
      }

      if( resourceKind === 'path' )
      o2.mapValsUnwrapping = 0;

      resources = module.openedModule.resolve( o2 );

      if( _.arrayIs( resources ) )
      resources = _.longUnduplicate( resources );

    }

    return act( module, resources ) || null;
  });

}

//

function commandResourcesList( e )
{
  let will = this;

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

  return will._commandList( e, act, '*' );
}

//

function commandPathsList( e )
{
  let will = this;

  function act( module, resources )
  {

    let logger = will.logger;
    logger.log( module.openedModule.infoExportPaths( resources ) );

  }

  return will._commandList( e, act, 'path' );
}

//

function commandSubmodulesList( e )
{
  let will = this;

  function act( module, resources )
  {
    let logger = will.logger;
    logger.log( module.openedModule.infoExportResource( resources ) );
  }

  return will._commandList( e, act, 'submodule' );
}

//

function commandModulesList( e )
{
  let will = this;

  function act( module, resources )
  {
    let logger = will.logger;
    logger.log( module.openedModule.infoExportResource( resources ) );
  }

  return will._commandList( e, act, 'module' );
}

//

function commandModulesTopologicalList( e )
{
  let will = this;

  function act( module, resources )
  {
    let logger = will.logger;
    logger.log( module.openedModule.infoExportModulesTopological( resources ) );
  }

  return will._commandList( e, act, 'module' );
}

//

function commandModulesTreeList( e )
{
  let will = this;

  function act( module, resources )
  {
    let logger = will.logger;
    logger.log( will.modulesInfoExportAsTree( resources ) );
  }

  return will._commandList( e, act, 'module' );
}

//

function commandReflectorsList( e )
{
  let will = this;

  function act( module, resources )
  {
    let logger = will.logger;
    logger.log( module.openedModule.infoExportResource( resources ) );
  }

  return will._commandList( e, act, 'reflector' );
}

//

function commandStepsList( e )
{
  let will = this;

  function act( module, resources )
  {
    let logger = will.logger;

    logger.log( module.openedModule.infoExportResource( resources ) );
  }

  return will._commandList( e, act, 'step' );
}

//

function commandBuildsList( e )
{
  let will = this;

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

  return will._commandList( e, act, null );
}

//

function commandExportsList( e )
{
  let will = this;

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

  return will._commandList( e, act, null );
}

//

function commandAboutList( e )
{
  let will = this;

  function act( module )
  {
    let logger = will.logger;
    logger.log( _.color.strFormat( 'About', 'highlighted' ) );
    logger.log( module.openedModule.about.infoExport() );
  }

  return will._commandList( e, act, null );
}

//

function commandSubmodulesClean( e )
{
  let will = this;
  return will.moduleReadyThen( function( module )
  {
    return module.openedModule.submodulesClean();
  });
}

//

function commandSubmodulesDownload( e )
{
  let will = this;

  let propertiesMap = _.strStructureParse( e.argument );
  _.sure( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )

  return will.moduleReadyThen( function( module )
  {
    return module.openedModule.submodulesDownload({ dry : e.propertiesMap.dry });
  });
}

commandSubmodulesDownload.commandProperties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
}

//

function commandSubmodulesUpdate( e )
{
  let will = this;

  let propertiesMap = _.strStructureParse( e.argument );
  _.sure( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )

  return will.moduleReadyThen( function( module )
  {
    return module.openedModule.submodulesUpdate({ dry : e.propertiesMap.dry });
  });
}

commandSubmodulesUpdate.commandProperties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
}

//

function commandSubmodulesFixate( e )
{
  let will = this;

  let propertiesMap = _.strStructureParse( e.argument );
  _.sure( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )

  e.propertiesMap.reportingNegative = e.propertiesMap.negative;
  delete e.propertiesMap.negative;

  return will.moduleReadyThen( function( module )
  {
    return module.openedModule.submodulesFixate( e.propertiesMap );
  });

}

commandSubmodulesFixate.commandProperties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  negative : 'Reporting attempt of upgrade with negative outcome. Default is negative:0.',
}

//

function commandSubmodulesUpgrade( e )
{
  let will = this;

  let propertiesMap = _.strStructureParse( e.argument );
  _.sure( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )

  _.assert( e.propertiesMap.upgrading === undefined, 'Unknown option upgrading' );

  e.propertiesMap.upgrading = 1;
  e.propertiesMap.reportingNegative = e.propertiesMap.negative;
  delete e.propertiesMap.negative;

  return will.moduleReadyThen( function( module )
  {
    return module.openedModule.submodulesFixate( e.propertiesMap );
  });

}

commandSubmodulesUpgrade.commandProperties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  negative : 'Reporting attempt of upgrade with negative outcome. Default is negative:0.',
}

//

function commandShell( e )
{
  let will = this;

  return will.moduleReadyThen( function( module )
  {
    let logger = will.logger;
    return module.openedModule.shell
    ({
      execPath : e.argument,
      currentPath : will.currentPath || module.openedModule.dirPath,
    });
  });

}

//

function commandClean( e )
{
  let will = this;

  let propertiesMap = _.strStructureParse( e.argument );
  _.sure( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );
  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap );

  return will.moduleReadyThen( function( module )
  {
    let logger = will.logger;

    if( e.propertiesMap.dry )
    return module.openedModule.cleanWhatReport();
    else
    return module.openedModule.clean();

  });

}

commandClean.commandProperties =
{
  dry : 'Dry run without deleting. Default is dry:0.',
}

//

function commandBuild( e )
{
  let will = this;
  return will.moduleReadyThen( function( module )
  {
    let request = will.Resolver.strRequestParse( e.argument );
    let builds = module.openedModule.buildsResolve( request.subject, request.map );
    let logger = will.logger;

    if( logger.verbosity >= 2 && builds.length > 1 )
    {
      logger.up();
      logger.log( module.openedModule.infoExportResource( builds ) );
      logger.down();
    }

    if( builds.length !== 1 )
    throw errTooMany( builds, 'build scenario' );

    let build = builds[ 0 ];
    return build.perform();
  });
}

//

function commandExport( e )
{
  let will = this;
  return will.moduleReadyThen( function( module )
  {
    let request = will.Resolver.strRequestParse( e.argument );
    let builds = module.openedModule.exportsResolve( request.subject, request.map );

    if( logger.verbosity >= 2 && builds.length > 1 )
    {
      logger.up();
      logger.log( module.openedModule.infoExportResource( builds ) );
      logger.down();
    }

    if( builds.length !== 1 )
    throw errTooMany( builds, 'export scenario' );

    let build = builds[ 0 ];
    return build.perform()
  });
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

  _moduleReadyThen,
  moduleReadyThen,

  _commandsMake,
  _commandsBegin,
  _commandsEnd,
  errEncounter,
  errTooMany,
  currentOpenerChange,

  commandHelp,
  commandImply,
  commandWith,
  commandEach,

  _commandList,
  commandResourcesList,
  commandPathsList,
  commandSubmodulesList,
  commandModulesList,
  commandModulesTopologicalList,
  commandModulesTreeList,
  commandReflectorsList,
  commandStepsList,
  commandBuildsList,
  commandExportsList,
  commandAboutList,

  commandSubmodulesClean,
  commandSubmodulesDownload,
  commandSubmodulesUpdate,
  commandSubmodulesFixate,
  commandSubmodulesUpgrade,

  commandShell,
  commandClean,
  commandBuild,
  commandExport,

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

// _.appExitHandlerRepair();
if( !module.parent )
Self.Exec();

})();
