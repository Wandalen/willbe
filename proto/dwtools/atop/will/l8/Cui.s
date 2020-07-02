( function _MainTop_s_( ) {

'use strict';

/*

Command routines list

Without selectors :

commandVersion
commandVersionCheck
commandSubmodulesFixate
commandSubmodulesUpgrade
commandSubmodulesVersionsDownload
commandSubmodulesVersionsUpdate
commandSubmodulesVersionsVerify
commandSubmodulesVersionsAgree
commandHooksList
commandClean
commandSubmodulesClean
commandModulesTree

With resource selector :

commandResourcesList
commandPathsList
commandSubmodulesList
commandReflectorsList
commandStepsList
commandBuildsList
commandExportsList
commandAboutList
commandModulesList
commandModulesTopologicalList
commandSubmodulesAdd
commandGitPreservingHardLinks

With selector of build :

commandBuild
commandExport
commandExportPurging
commandExportRecursive

With other selectors :

commandHelp
commandImply,
commandModuleNew
commandModuleNewWith
commandWith
commandEach
commandPackageInstall
commandPackageLocalVersions
commandPackageRemoteVersions
commandPackageVersion

commandShell
commandDo
commandHookCall
commandNpmGenerateFromWillfile
commandWillfileGenerateFromNpm

*/

let _ = _global_.wTools;
let Parent = _.Will;
let Self = wWillCli;
function wWillCli( o )
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
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let appArgs = _.process.args({ keyValDelimeter : 0 });
  let ca = will._commandsMake();

  return _.Consequence
  .Try( () =>
  {
    return ca.appArgsPerform({ appArgs });
  })
  .then( ( arg ) =>
  {
    return arg;
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
    _.assert( will.currentOpener instanceof _.will.ModuleOpener );

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
    it.junction = will.junctionOf( opener );
    if( !it.junction )
    it.junction = will.junctionFrom( opener );
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

function openersFind( o )
{
  let will = this;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routineOptions( openersFind, arguments );
  _.assert( will.currentOpener === null );
  _.assert( will.currentOpeners === null );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  let o2 = _.mapExtend( null, o );
  o2.selector = o.localPath;
  delete o2.localPath;
  return will.modulesFindWithAt( o2 )
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
    throw _.errBrief( `Found no willfile at ${path.resolve( o.localPath )}` );

    return will.currentOpeners;
  })

}

openersFind.defaults =
{

  ... _.mapExtend( null, _.Will.prototype.modulesFindWithAt.defaults ),

  localPath : './',
  tracing : 1,

}

//

function currentOpenerChange( src )
{
  let will = this;

  _.assert( src === null || src instanceof _.will.ModuleOpener );
  _.assert( arguments.length === 1 );

  if( src && will[ currentOpenerSymbol ] === src )
  return src;

  will[ currentOpenerSymbol ] = src;
  will.currentOpenerPath = null;

  return src;
}

// --
// etc
// --

function errEncounter( error )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  _.process.exitCode( -1 );
  logger.log( _.errOnce( error ) );

}

//

function _propertiesImply( implyMap )
{
  let will = this;

  _.assert( arguments.length === 1, 'Expects options map {-implyMap-}' );

  let namesMap =
  {
    v : 'verbosity',
    verbosity : 'verbosity',
    beeping : 'beeping',

    withOut : 'withOut',
    withIn : 'withIn',
    withEnabled : 'withEnabled',
    withDisabled : 'withDisabled',
    withValid : 'withValid',
    withInvalid : 'withInvalid',
    withSubmodules : 'withSubmodules',
  };

  _.process.argsReadTo
  ({
    dst : will,
    propertiesMap : implyMap,
    namesMap : namesMap,
  });
}

// --
// meta command
// --

function _commandsMake()
{
  let will = this;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let appArgs = _.process.args();

  _.assert( _.instanceIs( will ) );
  _.assert( arguments.length === 0, 'Expects no arguments' );

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
    'about' :                           { e : _.routineJoin( will, will.commandAboutList ),                   h : 'List descriptive information about the current module.' },

    'submodules clean' :                { e : _.routineJoin( will, will.commandSubmodulesClean ),             h : 'Delete all downloaded submodules.' },
    'submodules add' :                  { e : _.routineJoin( will, will.commandSubmodulesAdd ),               h : 'Add submodules.' },
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
    'call' :                            { e : _.routineJoin( will, will.commandHookCall ),                    h : 'Call a specified hook on the module.' },
    'hook call' :                       { e : _.routineJoin( will, will.commandHookCall ),                    h : 'Call a specified hook on the module.' },
    'hooks list' :                      { e : _.routineJoin( will, will.commandHooksList ),                   h : 'List available hooks.' },
    'clean' :                           { e : _.routineJoin( will, will.commandClean ),                       h : 'Clean current module. Delete genrated artifacts, temp files and downloaded submodules.' },
    'build' :                           { e : _.routineJoin( will, will.commandBuild ),                       h : 'Build current module with spesified criterion.' },
    'export' :                          { e : _.routineJoin( will, will.commandExport ),                      h : 'Export selected the module with spesified criterion. Save output to output willfile and archive.' },
    'export purging' :                  { e : _.routineJoin( will, will.commandExportPurging ),               h : 'Export selected the module with spesified criterion purging output willfile first. Save output to output willfile and archive.' },
    'export recursive' :                { e : _.routineJoin( will, will.commandExportRecursive ),             h : 'Export selected the module with spesified criterion and its submodules. Save output to output willfile and archive.' },

    'module new' :                      { e : _.routineJoin( will, will.commandModuleNew ),                   h : 'Create a new module.' },
    'module new with' :                 { e : _.routineJoin( will, will.commandModuleNewWith ),               h : 'Make a new module in the current directory and call a specified hook for the module to prepare it.' },

    'git pull' :                        { e : _.routineJoin( will, will.commandGitPull ),                     h : 'Use "git pull" to pull changes from remote repository' },
    'git push' :                        { e : _.routineJoin( will, will.commandGitPush ),                     h : 'Use "git push" to push commits and tags to remote repository' },
    'git reset' :                       { e : _.routineJoin( will, will.commandGitReset ),                    h : 'Use "git reset" to reset changes' },
    'git status' :                      { e : _.routineJoin( will, will.commandGitStatus ),                   h : 'Use "git status" to check the status of the repository' },
    'git sync' :                        { e : _.routineJoin( will, will.commandGitSync ),                     h : 'Use "git sync" to syncronize local and remote repositories' },
    'git tag' :                         { e : _.routineJoin( will, will.commandGitTag ),                      h : 'Use "git tag" to add tag for current commit' },
    'git config preserving hardlinks' : { e : _.routineJoin( will, will.commandGitPreservingHardLinks ),      h : 'Use "git config preserving hard links" to switch on preserve hardlinks' },

    'with' :                            { e : _.routineJoin( will, will.commandWith ),                        h : 'Use "with" to select a module.' },
    'each' :                            { e : _.routineJoin( will, will.commandEach ),                        h : 'Use "each" to iterate each module in a directory.' },

    'npm from willfile' :               { e : _.routineJoin( will, will.commandNpmGenerateFromWillfile ),     h : 'Use "npm from willfile" to generate "package.json" file from willfile.' },
    'willfile from npm' :               { e : _.routineJoin( will, will.commandWillfileGenerateFromNpm ),     h : 'Use "willfile from npm" to generate ".will.yml" file from "package.json".' },
    'package install' :                 { e : _.routineJoin( will, will.commandPackageInstall ),              h : 'Use "package install" to install target package.' },
    'package local versions' :          { e : _.routineJoin( will, will.commandPackageLocalVersions ),        h : 'Use "package local versions" to get list of package versions avaiable locally' },
    'package remote versions' :         { e : _.routineJoin( will, will.commandPackageRemoteVersions ),       h : 'Use "package remote versions" to get list of package versions avaiable in remote archive' },
    'package version' :                 { e : _.routineJoin( will, will.commandPackageVersion ),              h : 'Use "package local version" to get version of installed package.' },

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
    will.currentOpeners.forEach( ( opener ) => opener.isFinited() ? null : opener.finit() );
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

  ready
  .then( () => will.openersCurrentEach( function( it )
  {
    let ready2 = new _.Consequence().take( null );

    // ready2.then( () => it.opener.openedModule.modulesUpform({ recursive : 2, all : 0, subModulesFormed : 1 }) ) /* yyy */
    ready2.then( () => it.opener.openedModule.modulesUpform({ recursive : 2, all : 0 }) )

    ready2.then( () => will.readingEnd() );

    ready2.then( () =>
    {

      let resources = null;
      if( o.resourceKind )
      {

        let resourceKindIsGlob = _.path.isGlob( o.resourceKind );
        _.assert( e.request === undefined );
        e.request = _.will.Resolver.strRequestParse( e.argument );

        if( _.will.Resolver.selectorIs( e.request.subject ) )
        {
          let splits = _.will.Resolver.selectorShortSplit
          ({
            selector : e.request.subject,
            defaultResourceKind : o.resourceKind,
          });
          o.resourceKind = splits[ 0 ];
          resourceKindIsGlob = _.path.isGlob( o.resourceKind );
        }

        if( resourceKindIsGlob && e.request.subject && !_.will.Resolver.selectorIs( e.request.subject ) )
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

  return ready;
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

  // debugger;

  _.routineOptions( _commandBuildLike, arguments );
  _.mapSupplementNulls( o, will.filterImplied() );
  _.mapSupplementNulls( o, _.Will.ModuleFilterDefaults );

  _.all( _.Will.ModuleFilterNulls, ( e, k ) => _.assert( _.boolLike( o[ k ] ), `Expects bool-like ${k}, but it is ${_.strType( k )}` ) );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onEach ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  will._commandsBegin( o.commandRoutine );

  if( will.currentOpeners === null && will.currentOpener === null )
  ready.then( () => will.openersFind() );

  ready
  .then( () => filter() )

  .then( () => will.openersCurrentEach( forSingle ) )
  .finally( end );

  //debugger;

  return ready;

  /* */

  function filter()
  {
    if( will.currentOpeners )
    {
      let openers2 = will.modulesFilter( will.currentOpeners, _.mapOnly( o, will.modulesFilter.defaults ) );
      if( openers2.length )
      will.currentOpeners = openers2;
    }
    return null;
  }

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
      throw _.err( err, `\nFailed to ${o.name} at ${it.opener ? it.opener.commonPath : ''}` );
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

var defaults = _commandBuildLike.defaults = _.mapExtend( null, _.Will.ModuleFilterNulls );

defaults.event = null;
defaults.onEach = null;
defaults.commandRoutine = null;
defaults.name = null;
defaults.subModulesFormed = 1;

//

function _commandCleanLike( o )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  _.routineOptions( _commandCleanLike, arguments );
  _.mapSupplementNulls( o, will.filterImplied() );
  _.mapSupplementNulls( o, _.Will.ModuleFilterDefaults );
  _.all( _.Will.ModuleFilterNulls, ( e, k ) => _.assert( _.boolLike( o[ k ] ), `Expects bool-like ${k}, but it is ${_.strType( k )}` ) );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onAll ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  will._commandsBegin( o.commandRoutine );

  if( will.currentOpeners === null && will.currentOpener === null )
  ready.then( () => will.openersFind() );

  ready
  .then( () => filter() )
  .then( () => forAll() )
  .finally( end );

  return ready;

  /* */

  function filter()
  {
    _.assert( _.arrayIs( will.currentOpeners ) );

    let openers2 = will.modulesFilter( will.currentOpeners, _.mapOnly( o, will.modulesFilter.defaults ) );
    if( openers2.length )
    will.currentOpeners = openers2;

    return null;
  }

  /* */

  function forAll()
  {
    let ready2 = new _.Consequence().take( null );
    let it2 = _.mapExtend( null, o );

    _.assert( arguments.length === 0, 'Expects no arguments' );
    _.assert( _.arrayIs( will.currentOpeners ) );
    it2.openers = will.currentOpeners;
    it2.roots = will.modulesOnlyRoots( it2.openers );

    ready2.then( () =>
    {
      will.readingEnd();
      return o.onAll.call( will, it2 );
    });

    ready2.finally( ( err, arg ) =>
    {
      if( err )
      throw _.err( err, `\nFailed to ${o.name}` );
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

var defaults = _commandCleanLike.defaults = _.mapExtend( null, _.Will.ModuleFilterNulls );

defaults.event = null;
defaults.onAll = null;
defaults.commandRoutine = null;
defaults.name = null;

//

function _commandNewLike( o )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  _.routineOptions( _commandNewLike, arguments );
  _.mapSupplementNulls( o, will.filterImplied() );

  debugger;
  if( o.withInvalid === null )
  o.withInvalid = 0;
  if( o.withDisabledModules === null )
  o.withDisabledModules = 0;

  _.mapSupplementNulls( o, _.Will.ModuleFilterDefaults );

  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onEach ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

//   withIn : 1,
//   withOut : 1,
//   withInvalid : 0,
//   withDisabledModules : 0,

  will._commandsBegin( o.commandRoutine );

  if( will.currentOpeners !== null || will.currentOpener !== null )
  throw _.errBrief( 'Cant call command new for module which already exists!' );

  let localPath = will.moduleNew({ collision : 'ignore', localPath : will.withPath });
  let o2 = _.mapExtend( null, o );
  o2.localPath = localPath;
  o2.tracing = 0;

  ready.then( () => will.openersFind( _.mapOnly( o2, will.openersFind.defaults ) ) );
  ready.then( () => will.openersCurrentEach( forSingle ) );
  ready.finally( end );

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
      _.assert( it2.opener.localPath === will.withPath );
      return o.onEach.call( will, it2 );
    });

    ready2.finally( ( err, arg ) =>
    {
      will.currentOpenerChange( null );
      if( err )
      throw _.err( err, `\nFailed to ${o.name} at ${it.opener ? it.opener.commonPath : ''}` );
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

var defaults = _commandNewLike.defaults = _.mapExtend( null, _.Will.ModuleFilterNulls );

defaults.event = null;
defaults.onEach = null;
defaults.commandRoutine = null;
defaults.name = null;

// _commandNewLike.defaults =
// {
//   event : null,
//   onEach : null,
//   commandRoutine : null,
//   name : null,
//   withIn : 1,
//   withOut : 1,
//   withInvalid : 0,
//   withDisabledModules : 0,
// }

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

// --
// command
// --

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
  let isolated = ca.commandIsolateSecondFromArgument( e.argument );
  /* qqq xxx : apply to other top modules */
  _.assert( !!isolated );

  let request = _.will.Resolver.strRequestParse( isolated.argument );
  will._propertiesImply( request.map );

  // let namesMap =
  // {
  //
  //   v : 'verbosity',
  //   verbosity : 'verbosity',
  //   beeping : 'beeping',
  //
  //   withOut : 'withOut',
  //   withIn : 'withIn',
  //   withEnabled : 'withEnabled',
  //   withDisabled : 'withDisabled',
  //   withValid : 'withValid',
  //   withInvalid : 'withInvalid',
  //   withSubmodules : 'withSubmodules',
  //
  // }
  //
  // _.process.argsReadTo
  // ({
  //   dst : will,
  //   propertiesMap : request.map,
  //   namesMap : namesMap,
  // });

  if( isolated.secondCommand )
  return ca.commandPerform
  ({
    command : isolated.secondCommand,
  });

}

commandImply.commandProperties =
{
  v : 'Set verbosity. Default is 3.',
  verbosity : 'Set verbosity. Default is 3.',
  beeping : 'Make noise when it\'s done. Default is 0.',
  withOut : 'Include out modules. Default is 1.',
  withIn : 'Include in modules. Default is 1.',
  withEnabled : 'Include enabled modules. Default is 1.',
  withDisabled : 'Include disabled modules. Default is 0.',
  withValid : 'Include valid modules. Default is 1.',
  withInvalid : 'Include invalid modules. Default is 1.',
  withSubmodules : 'Opening submodules. 0 - not opening, 1 - opening immediate children, 2 - opening all descendants recursively. Default : depends.',
}

//

function commandVersion( e )
{
  let cui = this;
  return _.npm.versionLog
  ({
    localPath : _.path.join( __dirname, '../../../../..' ),
    remotePath : 'willbe',
  });
}

commandVersion.hint = 'Get information about version.';

// function commandVersion( e ) /* xxx qqq : move to NpmTools */
// {
//   let will = this;
//   let ca = e.ca;
//   let logger = will.logger;
//
//   let implyMap = _.strStructureParse( e.argument );
//   _.assert( _.mapIs( implyMap ), () => 'Expects map, but got ' + _.toStrShort( implyMap ) );
//   will._propertiesImply( implyMap );
//
//   // logger.log( 'Current version:', will.versionGet() );
// }
// // commandVersion.commandProperties = commandImply.commandProperties;
//
// commandVersion.hint = 'Get information about version.';

//

function commandVersionCheck( e )
{
  let will = this;
  let ca = e.ca;
  let logger = will.logger;

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );

  let implyMap = _.mapBut( propertiesMap, commandClean.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

  return will.versionIsUpToDate( propertiesMap );
}

commandVersionCheck.commandProperties =
{
  throwing : 'Throw an error if utility is not up to date. Default : 1',
  ... commandImply.commandProperties,
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
      result += module.openedModule.about.exportString();
      logger.log( result );
    }

    logger.log( module.openedModule.resourcesExportInfo( resources ) );

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
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
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
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
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
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
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
    let request = _.will.Resolver.strRequestParse( e.argument );
    let builds = module.openedModule.buildsResolve
    ({
      name : request.subject,
      criterion : request.map,
      preffering : 'more',
    });
    logger.log( module.openedModule.resourcesExportInfo( builds ) );
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
    let request = _.will.Resolver.strRequestParse( e.argument );
    let builds = module.openedModule.exportsResolve
    ({
      name : request.subject,
      criterion : request.map,
      preffering : 'more',
    });
    logger.log( module.openedModule.resourcesExportInfo( builds ) );
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
    logger.log( module.openedModule.about.exportString() );
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
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
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
  let request = _.will.Resolver.strRequestParse( e.argument );
  let propertiesMap = _.strStructureParse( e.argument );
  let implyMap = _.mapBut( propertiesMap, commandModulesTree.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

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
    /*
    filtering was done earlier
    */
    propertiesMap.onlyRoots = 0;
    logger.log( will.graphExportTreeInfo( modules, propertiesMap ) );
    return null;
  }

}

commandModulesTree.commandProperties =
{
  withLocalPath : 'Print local paths. Default is 0',
  withRemotePath : 'Print remote paths. Default is 0',
  ... commandImply.commandProperties,
}

//

function commandSubmodulesAdd( e )
{
  let will = this;

  return will._commandBuildLike
  ({
    event : e,
    name : 'clean submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesAdd,
  });

  function handleEach( it )
  {

    let module = it.opener.openedModule;
    let filePath = module.pathResolve
    ({
      selector : e.argument,
      prefixlessAction : 'resolved',
    });

    let found = will.modulesFindWithAt
    ({
      selector : filePath,
      // withDisabledModules : 1,
      // withDisabledSubmodules : 1,
      withInvalid : 1,
      tracing : 0,
      ... will.filterImplied(),
    });

    found.then( ( it ) =>
    {
      let junctions = will.junctionsFrom( it.sortedOpeners );
      return module.submodulesAdd({ modules : junctions });
    })

    found.finally( ( err, added ) =>
    {
      debugger;
      if( err )
      throw _.err( err, `\nFaield to add submodules from ${filePath}` );
      if( will.verbosity >= 2 )
      logger.log( `Added ${added} submodules to ${module.nameWithLocationGet()}` )
      return added;
    })

    return found;
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

  let implyMap = _.mapBut( propertiesMap, commandSubmodulesFixate.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

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

  // function handleEach( it )
  // {
  //   let o2 = will.filterImplied(); /* Dmytro : it creates options map with field "withDisabledModules", "withEnabledModules", "withOut", "withIn"... but routine submodulesFixate does not expects such options. Below version which used only options "dry", "negative", "recursive" */
  //   o2 = _.mapExtend( o2, e.propertiesMap );
  //   return it.opener.openedModule.submodulesFixate( o2 );
  // }

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
  ... commandImply.commandProperties,
}

//

function commandSubmodulesUpgrade( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );

  let implyMap = _.mapBut( propertiesMap, commandSubmodulesUpgrade.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

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
  ... commandImply.commandProperties,
}

//

function commandSubmodulesVersionsDownload( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );

  let implyMap = _.mapBut( propertiesMap, commandSubmodulesVersionsDownload.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap )

  return will._commandCleanLike
  ({
    event : e,
    name : 'download submodules',
    onAll : handleAll,
    commandRoutine : commandSubmodulesVersionsDownload,
  });

  function handleAll( it )
  {
    _.assert( _.arrayIs( it.openers ) );

    let o2 = _.mapExtend( null, e.propertiesMap );
    o2.modules = it.openers;
    _.routineOptions( will.modulesDownload, o2 );
    if( o2.recursive === 2 )
    o2.modules = it.roots;

    return will.modulesDownload( o2 );
  }

}

commandSubmodulesVersionsDownload.commandProperties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.commandProperties,
}

//

function commandSubmodulesVersionsUpdate( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );

  let implyMap = _.mapBut( propertiesMap, commandSubmodulesVersionsUpdate.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

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
    let o2 = will.filterImplied();
    o2 = _.mapExtend( o2, e.propertiesMap )
    return it.opener.openedModule.subModulesUpdate( o2 );
  }

}

commandSubmodulesVersionsUpdate.commandProperties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.commandProperties,
}

//

function commandSubmodulesVersionsVerify( e )
{
  let will = this;

  let propertiesMap = _.strStructureParse( e.argument );
  _.sure( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );

  let implyMap = _.mapBut( propertiesMap, commandSubmodulesVersionsVerify.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap );

  return will._commandBuildLike
  ({
    event : e,
    name : 'submodules versions verify',
    onEach : handleEach,
    commandRoutine : commandSubmodulesVersionsVerify,
  });

  function handleEach( it )
  {
    let o2 = will.filterImplied();
    o2 = _.mapExtend( o2, e.propertiesMap )
    return it.opener.openedModule.submodulesVerify( o2 );
  }
}

commandSubmodulesVersionsVerify.commandProperties =
{
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.commandProperties,
}

//

function commandSubmodulesVersionsAgree( e )
{
  let will = this;

  let propertiesMap = _.strStructureParse( e.argument );
  _.sure( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );

  let implyMap = _.mapBut( propertiesMap, commandSubmodulesVersionsAgree.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap );

  return will._commandBuildLike
  ({
    event : e,
    name : 'submodules versions agree',
    onEach : handleEach,
    commandRoutine : commandSubmodulesVersionsAgree,
  });

  function handleEach( it )
  {
    let o2 = will.filterImplied();
    o2 = _.mapExtend( o2, e.propertiesMap )
    return it.opener.openedModule.subModulesAgree( o2 );
  }

}

commandSubmodulesVersionsAgree.commandProperties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.commandProperties,
}

//

function commandModuleNew( e )
{
  let will = this;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let ready = new _.Consequence().take( null );
  let request = _.will.Resolver.strRequestParse( e.argument );

  if( request.subject )
  request.map.localPath = request.subject;
  if( request.map.v !== undefined )
  {
    request.map.verbosity = request.map.v;
    delete request.map.v;
  }

  if( request.map.verbosity === undefined )
  request.map.verbosity = 1;

  if( will.withPath )
  if( request.map.localPath )
  request.map.localPath = path.join( will.withPath, request.map.localPath );
  else
  request.map.localPath = will.withPath;

  return will.moduleNew( request.map );
}

//

function commandModuleNewWith( e )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let time = _.time.now();
  let isolated = e.ca.commandIsolateSecondFromArgument( e.argument );
  let execPath = e.argument;

  return will._commandNewLike
  ({
    event : e,
    name : 'make a new module and call a hook',
    onEach : handleEach,
    commandRoutine : commandModuleNewWith,
    withOut : 0,
    // withDisabledModules : 0,
    withInvalid : 1,
  })
  .then( ( arg ) =>
  {
    if( will.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( 'hook::' + e.argument, 'entity' )} in ${_.time.spent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let it2 = _.mapOnly( it, will.hookContextFrom.defaults );
    it2.execPath = path.join( will.hooksPath, execPath );
    it2 = will.hookContextFrom( it2 );
    return will.hookCall( it2 );
  }

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
      currentPath : will.currentOpenerPath || it.opener.openedModule.dirPath,
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
  let time = _.time.now();
  let isolated = e.ca.commandIsolateSecondFromArgument( e.argument );
  let execPath = e.argument;

  return will._commandBuildLike
  ({
    event : e,
    name : 'do',
    onEach : handleEach,
    commandRoutine : commandDo,
    withOut : 0,
    // withDisabledModules : 0,
    withInvalid : 1,
  })
  .then( ( arg ) =>
  {
    if( will.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( e.argument, 'code' )} in ${_.time.spent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let it2 = _.mapOnly( it, will.hookContextFrom.defaults );
    it2.execPath = execPath;
    it2 = will.hookContextFrom( it2 );
    return will.hookCall( it2 );
  }

}

//

function commandHookCall( e )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let time = _.time.now();
  let isolated = e.ca.commandIsolateSecondFromArgument( e.argument );
  let execPath = e.argument;

  return will._commandBuildLike
  ({
    event : e,
    name : 'call a hook',
    onEach : handleEach,
    commandRoutine : commandHookCall,
    withOut : 0,
    withInvalid : 1,
  })
  .then( ( arg ) =>
  {
    if( will.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( 'hook::' + e.argument, 'entity' )} in ${_.time.spent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let it2 = _.mapOnly( it, will.hookContextFrom.defaults );
    it2.execPath = path.join( will.hooksPath, execPath );
    it2 = will.hookContextFrom( it2 );
    return will.hookCall( it2 );
  }

}

//

function commandHooksList( e )
{
  let will = this.form();
  let logger = will.logger;

  will.hooksReload();
  logger.log( 'Found hooks' );
  logger.up();
  will.hooksList();
  logger.down();

}

//

function commandClean( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );

  let implyMap = _.mapBut( propertiesMap, commandClean.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap );
  e.propertiesMap.dry = !!e.propertiesMap.dry;;
  let dry = e.propertiesMap.dry;
  if( e.propertiesMap.fast === undefined || e.propertiesMap.fast === null )
  e.propertiesMap.fast = !dry;
  e.propertiesMap.fast = 0; /* xxx */

  return will._commandCleanLike
  ({
    event : e,
    name : 'clean',
    onAll : handleAll,
    commandRoutine : commandClean,
  });

  function handleAll( it )
  {
    _.assert( _.arrayIs( it.openers ) );

    // let o2 = will.filterImplied();
    let o2 = { ... will.RelationFilterOn };
    o2 = _.mapExtend( o2, e.propertiesMap );
    o2.modules = it.openers;
    _.routineOptions( will.modulesClean, o2 );
    if( o2.recursive === 2 )
    o2.modules = it.roots;
    o2.asCommand = 1;

    return will.modulesClean( o2 );
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
  ... commandImply.commandProperties,
  /* aaa2 : should have verbosity and other common options */ /* Dmytro : appended to the property commandProperties */
}

//

function commandSubmodulesClean( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let propertiesMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( propertiesMap ) );

  let implyMap = _.mapBut( propertiesMap, commandSubmodulesClean.commandProperties );
  propertiesMap = _.mapBut( propertiesMap, implyMap );
  will._propertiesImply( implyMap );

  e.propertiesMap = _.mapExtend( e.propertiesMap, propertiesMap );
  e.propertiesMap.dry = !!e.propertiesMap.dry;;
  let dry = e.propertiesMap.dry;
  if( e.propertiesMap.fast === undefined || e.propertiesMap.fast === null )
  e.propertiesMap.fast = !dry;
  e.propertiesMap.fast = 0; /* xxx */

  return will._commandCleanLike
  ({
    event : e,
    name : 'clean',
    onAll : handleAll,
    commandRoutine : commandSubmodulesClean,
  });

  function handleAll( it )
  {
    _.assert( _.arrayIs( it.openers ) );

    // let o2 = will.filterImplied();
    let o2 = { ... will.RelationFilterOn };
    o2 = _.mapExtend( o2, e.propertiesMap );
    o2.modules = it.openers;
    _.routineOptions( will.modulesClean, o2 );
    if( o2.recursive === 2 )
    o2.modules = it.roots;
    o2.asCommand = 1;
    o2.cleaningSubmodules = 1;
    o2.cleaningOut = 0;
    o2.cleaningTemp = 0;

    return will.modulesClean( o2 );
  }

}

commandSubmodulesClean.commandProperties =
{
  dry : 'Dry run without deleting. Default is dry:0.',
  recursive : 'Recursive cleaning. recursive:0 - only curremt module, recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:0.',
  fast : 'Faster implementation, but fewer diagnostic information. Default fast:1 for dry:0 and fast:0 for dry:1.',
  ... commandImply.commandProperties,
}

//

function commandBuild( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let request = _.will.Resolver.strRequestParse( e.argument );
  let doneContainer = [];

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
      ... _.mapBut( will.RelationFilterOn, { withIn : null, withOut : null } ),
      doneContainer,
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
  let request = _.will.Resolver.strRequestParse( e.argument );
  let doneContainer = [];

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
      ... _.mapBut( will.RelationFilterOn, { withIn : null, withOut : null } ),
      doneContainer,
      name : request.subject,
      criterion : request.map,
      recursive : 0,
      kind : 'export',
    });
  }

}

//

function commandExportPurging( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let request = _.will.Resolver.strRequestParse( e.argument );
  let doneContainer = [];

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
      ... _.mapBut( will.RelationFilterOn, { withIn : null, withOut : null } ),
      doneContainer,
      name : request.subject,
      criterion : request.map,
      recursive : 0,
      purging : 1,
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
  let request = _.will.Resolver.strRequestParse( e.argument );
  let doneContainer = [];

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
      ... _.mapBut( will.RelationFilterOn, { withIn : null, withOut : null } ),
      doneContainer,
      name : request.subject,
      criterion : request.map,
      recursive : 2,
      kind : 'export',
    });
  }

}

//

function commandGitPull( e )
{
  let will = this;
  let implyMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( implyMap ), () => 'Expects map, but got ' + _.toStrShort( implyMap ) );
  will._propertiesImply( implyMap );

  return will._commandBuildLike
  ({
    event : e,
    name : 'git pull',
    onEach : handleEach,
    commandRoutine : commandGitPull,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitPull
    ({
      dirPath : it.junction.dirPath,
      verbosity : will.verbosity,
    });
  }
}

commandGitPull.commandProperties = commandImply.commandProperties;

//

function commandGitPush( e )
{
  let will = this;
  let implyMap = _.strStructureParse( e.argument );
  _.assert( _.mapIs( implyMap ), () => 'Expects map, but got ' + _.toStrShort( implyMap ) );
  will._propertiesImply( implyMap );

  return will._commandBuildLike
  ({
    event : e,
    name : 'git push',
    onEach : handleEach,
    commandRoutine : commandGitPush,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitPush
    ({
      dirPath : it.junction.dirPath,
      verbosity : will.verbosity,
    });
  }
}

commandGitPush.commandProperties = commandImply.commandProperties;

//

function commandGitReset( e )
{
  let will = this;
  let optionsMap = _.strStructureParse( e.argument );
  _.routineOptions( commandGitReset, optionsMap );
  optionsMap.verbosity = optionsMap.v !== null && optionsMap.v >= 0 ? optionsMap.v : optionsMap.verbosity;

  return will._commandBuildLike
  ({
    event : e,
    name : 'git reset',
    onEach : handleEach,
    commandRoutine : commandGitReset,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitReset
    ({
      ... optionsMap,
    });
  }
}

commandGitReset.defaults =
{
  dirPath : '.',
  removingUntracked : 0,
  dry : 0,
  v : null,
  verbosity : 2,
}

commandGitReset.commandProperties =
{
  dirPath : 'Path to local cloned Git directory. Default is directory of current module.',
  removingUntracked : 'Remove untracked files, option does not enable deleting of ignored files. Default is removingUntracked:0.',
  dry : 'Dry run without resetting. Default is dry:0.',
  v : 'Set verbosity. Default is 2.',
  verbosity : 'Set verbosity. Default is 2.',
}

//

function commandGitStatus( e )
{
  let will = this;
  let optionsMap = _.strStructureParse( e.argument );
  _.routineOptions( commandGitStatus, optionsMap );
  optionsMap.verbosity = optionsMap.v !== null && optionsMap.v >= 0 ? optionsMap.v : optionsMap.verbosity;

  return will._commandBuildLike
  ({
    event : e,
    name : 'git status',
    onEach : handleEach,
    commandRoutine : commandGitStatus,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitStatus
    ({
      ... optionsMap,
    });
  }
}

commandGitStatus.defaults =
{
  local : 1,
  uncommittedIgnored : 0,
  remote : 1,
  remoteBranches : 0,
  prs : 1,
  v : null,
  verbosity : 1,
}

commandGitStatus.commandProperties =
{
  local : 'Check local commits. Default value is 1.',
  uncommittedIgnored : 'Check ignored local files. Default value is 0.',
  remote : 'Check remote unmerged commits. Default value is 1.',
  remoteBranches : 'Check remote branches. Default value is 0.',
  prs : 'Check pull requests. Default is dry:1.',
  v : 'Set verbosity. Default is 1.',
  verbosity : 'Set verbosity. Default is 1.',
}


//

function commandGitSync( e )
{
  let will = this;
  let request = _.will.Resolver.strRequestParse( e.argument );
  _.routineOptions( commandGitSync, request.map );
  request.map.verbosity = request.map.v !== null && request.map.v >= 0 ? request.map.v : request.map.verbosity;

  return will._commandBuildLike
  ({
    event : e,
    name : 'git sync',
    onEach : handleEach,
    commandRoutine : commandGitSync,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitSync
    ({
      commit : request.subject,
      ... request.map,
    });
  }
}

commandGitSync.defaults =
{
  dirPath : null,
  dry : 0,
  v : null,
  verbosity : 1,
}

commandGitSync.commandProperties =
{
  v : 'Set verbosity. Default is 1.',
  verbosity : 'Set verbosity. Default is 1.',
}

//

function commandGitTag( e )
{
  let will = this;
  let optionsMap = _.strStructureParse( e.argument );
  _.routineOptions( commandGitTag, optionsMap );
  optionsMap.verbosity = optionsMap.v !== null && optionsMap.v >= 0 ? optionsMap.v : optionsMap.verbosity;

  return will._commandBuildLike
  ({
    event : e,
    name : 'git tag',
    onEach : handleEach,
    commandRoutine : commandGitTag,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitTag
    ({
      ... optionsMap,
    });
  }
}

commandGitTag.defaults =
{
  name : '.',
  description : '',
  dry : 0,
  light : 0,
  v : null,
  verbosity : 1,
}

commandGitTag.commandProperties =
{
  name : 'Tag name. Default is name:".".',
  description : 'Description of annotated tag. Default is description:"".',
  dry : 'Dry run without tagging. Default is dry:0.',
  light : 'Enables lightweight tags. Default is light:0.',
  v : 'Set verbosity. Default is 1.',
  verbosity : 'Set verbosity. Default is 1.',
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

// --
// command iterator
// --

/* xxx : add test routine checking wrong syntax error handling */
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
  throw _.errBrief( 'Format of .with command should be: .with {-path-} .command' );

  will.withPath = path.join( path.current(), will.withPath, path.fromGlob( isolated.argument ) );
  if( _.strBegins( isolated.secondSubject, '.module.new' ) )
  {
    return ca.commandPerform
    ({
      command : isolated.secondCommand,
    });
  }

  return will.modulesFindWithAt
  ({
    selector : isolated.argument,
    atLeastOne : !path.isGlob( isolated.argument ),
  })
  .then( function( it )
  {
    will.currentOpeners = it.sortedOpeners;

    if( !will.currentOpeners.length )
    throw _.errBrief
    (
        `No module sattisfy criteria.`
      , `\nLooked at ${_.strQuote( path.resolve( isolated.argument ) )}`
    );

    return ca.commandPerform
    ({
      command : isolated.secondCommand,
    });

  })
  .finally( ( err, arg ) =>
  {
    if( err )
    will.errEncounter( err );
    will._commandsEnd( commandWith );
    if( err )
    throw _.err( err );
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
    throw _.err( err );
    return arg;
  });

  return con;

  /* */

  function handleBegin( it )
  {

    // debugger;
    _.assert( will.currentOpener === null );
    _.assert( will.currentOpenerPath === null );
    // _.assert( will.mainModule === null );
    // _.assert( will.mainOpener === null ); // yyy

    if( will.mainOpener )
    will.mainOpener.isMain = false;
    will.currentOpenerChange( it.currentOpener );
    will.currentOpenerPath = it.currentOpenerPath || null;
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
      if( will.currentOpenerPath )
      logger.log( _.color.strFormat( '       at', { fg : 'bright white' } ), _.color.strFormat( will.currentOpenerPath, 'path' ) );
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
      _.assert( will.currentOpenerPath === null );
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

function commandNpmGenerateFromWillfile( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let request = _.strStructureParse( e.argument );
  let criterionsMap = _.mapBut( request, commandNpmGenerateFromWillfile.defaults );
  request = _.mapBut( request, criterionsMap );

  return will._commandBuildLike
  ({
    event : e,
    name : 'npm from willfile',
    onEach : handleEach,
    commandRoutine : commandNpmGenerateFromWillfile,
  });

  function handleEach( it )
  {
    if( _.mapKeys( criterionsMap ).length > 0 )
    it.opener.openedModule.stepMap[ "npm.generate" ].criterion = criterionsMap;

    return it.opener.openedModule.npmGenerateFromWillfile
    ({
      packagePath : request.packagePath,
      entryPath : request.entryPath,
      filesPath : request.filesPath,
      currentContext : it.opener.openedModule.stepMap[ "npm.generate" ],
      verbosity : 5,
    });
  }
}

commandNpmGenerateFromWillfile.defaults =
{
  packagePath : null,
  entryPath : null,
  filesPath : null,
};

//

function commandWillfileGenerateFromNpm( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );
  let request = _.strStructureParse( e.argument );
  let criterionsMap = _.mapBut( request, commandWillfileGenerateFromNpm.defaults );
  request = _.mapBut( request, criterionsMap );

  if( will.currentOpeners && will.currentOpeners.length )
  {
    return will._commandBuildLike
    ({
      event : e,
      name : 'npm from willfile',
      onEach : handleEach,
      commandRoutine : commandWillfileGenerateFromNpm,
    });
  }
  else
  {
    will.modulesFindWithAt( { atLeastOne: 1, selector: "./", tracing: 1 } )
    .finally( function( err, it )
    {
      if( err )
      throw _.err( err );

      will.currentOpeners = it.openers;
      if( !will.currentOpeners.length )
      return _.will.Module.prototype.willfileGenerateFromNpm.call( will,
      {
        packagePath : request.packagePath,
        willfilePath : request.willfilePath,
        verbosity : 5,
      });

      return will._commandBuildLike
      ({
        event : e,
        name : 'npm from willfile',
        onEach : handleEach,
        commandRoutine : commandWillfileGenerateFromNpm,
      });
    })
  }

  function handleEach( it )
  {
    return it.opener.openedModule.willfileGenerateFromNpm
    ({
      packagePath : request.packagePath,
      willfilePath : request.willfilePath,
      currentContext : it.opener.openedModule.stepMap[ "willfile.generate" ],
      verbosity : 5,
    });
  }
}

commandWillfileGenerateFromNpm.defaults =
{
  packagePath : null,
  willfilePath : null,
};

//

function commandPackageInstall( e )
{
  let will = this;
  let logger = will.logger;

  let isolated = _.strIsolateLeftOrAll( e.argument, ' ' );

  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  let options = _.strStructureParse( isolated[ 2 ] );

  _.assertMapHasOnly( options, commandPackageInstall.commandProperties, `Command does not expect options:` );

  let tool  = parsed.protocol;

  parsed.protocol = null;
  parsed.longPath = _.path.normalize( parsed.longPath );
  parsed.longPath = _.strRemoveBegin( parsed.longPath, '/' );

  if( parsed.tag )
  {
    let appNameAndVersion = _.uri.str( parsed );
    throw _.err( `Expects application and version in format "app#version", but got: "${appNameAndVersion}"` )
  }

  _.assert( !parsed.tag, `Expects application and version in format "app#version", but got: "${parsed.longPath}"` )

  if( !tool )
  tool = 'package';

  if( tool === 'package' )
  {
    let toolForPlatformMap =
    {
      'win32' : 'choco',
      'darwin' : 'brew',
      'linux' : 'apt'
    }
    tool = toolForPlatformMap[ process.platform ];
    if( !tool )
    throw _.err( `Unsupported platform: ${process.platform}` )
  }

  let o = Object.create( null );

  o.throwingExitCode = 1;
  o.stdio = [ 'inherit', 'pipe', 'pipe' ];
  o.outputPiping = 1;
  o.outputCollecting = 1;
  o.inputMirroring = 0;

  if( tool === 'choco' )
  {
    chocoInstallHandle();
  }
  else if( tool === 'apt' )
  {
    aptInstallHandle();
  }
  else if( tool === 'brew' )
  {
    brewInstallHandle();
  }
  else
  {
    throw _.err( `Unsupported application installation tool: ${tool}` )
  }

  if( options.sudo )
  o.execPath = 'sudo ' + o.execPath;

  return _.process.start( o )
  // .then( () =>
  // {
  //   if( o.exitCode !== 0 )
  //   {
  //     if( _.strHas( o.output, 'You need to be root' ) )
  //     throw _.errBrief( 'You need to be root to install the package. Run this command with option "sudo:1".' )
  //   }
  //   return null;
  // })

  /*  */

  function chocoInstallHandle()
  {
    if( process.platform !== 'win32' )
    throw _.err( 'Package manager choco is available only on Windows platform.' )

    o.execPath = 'choco install -y' + options.reinstall ? ' --force ' : ' ';
    o.execPath += parsed.longPath;
    if( parsed.hash )
    o.execPath += ' --version=' + parsed.hash;
  }

  function aptInstallHandle()
  {
    if( process.platform !== 'linux' )
    throw _.errBrief( 'This installation method is avaiable only on Linux platform.' )

    let linuxInfo = linuxInfoGet();
    let distroName = linuxInfo.dist.toLowerCase();

    if( _.strHas( distroName, 'centos' ) )
    {
      o.execPath = 'yum';
      o.execPath += options.reinstall ? ' reinstall ' : ' install ';
      o.execPath += ' -y ';
      o.execPath += parsed.longPath;
      if( parsed.hash )
      o.execPath += '-' + parsed.hash;
    }
    else if( _.strHas( distroName, 'ubuntu' ) )
    {
      let installExec = 'apt-get install -y ';
      if( options.reinstall )
      installExec += '--reinstall '
      installExec += parsed.longPath;
      if( parsed.hash )
      installExec += '=' + parsed.hash;

      o.execPath =
      [
        // 'sudo apt update',
        // 'sudo apt upgrade',
          installExec
      ]
    }
    else
    {
      throw _.err( `Unsupported Linux distribution: ${distroName}` )
    }
  }

  function linuxInfoGet()
  {
    try
    {
      let getos = require( 'getos' );
      let con = new _.Consequence();
      getos( con.tolerantCallback() )
      con.deasync();
      return con.sync();
    }
    catch( err )
    {
      throw _.err( 'Failed to get information about Linux distribution. Reason:\n', err );
    }
  }

  function brewInstallHandle()
  {
    o.execPath = 'brew install' + options.reinstall ? ' --force ' : ' ';
    o.execPath += parsed.longPath;
    if( parsed.hash )
    o.execPath += '@' + parsed.hash;
  }
}

commandPackageInstall.commandProperties =
{
  sudo : 'Install package with privileges of superuser.',
  reinstall : 'Force package manager to reinstall the package.'
}

//

function commandPackageLocalVersions( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let isolated = _.strIsolateLeftOrAll( e.argument, ' ' );

  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  let options = _.strStructureParse( isolated[ 2 ] );

  _.assertMapHasOnly( options, commandPackageLocalVersions.commandProperties, `Command does not expect options:` );

  let tool  = parsed.protocol;

  parsed.protocol = null;
  parsed.longPath = _.path.normalize( parsed.longPath );
  parsed.longPath = _.strRemoveBegin( parsed.longPath, '/' );

  if( parsed.tag )
  {
    let appNameAndVersion = _.uri.str( parsed );
    throw _.err( `Expects application and version in format "app#version", but got: "${appNameAndVersion}"` )
  }

  _.assert( !parsed.tag, `Expects application and version in format "app#version", but got: "${parsed.longPath}"` )

  let platform = process.platform;

  if( platform === 'linux' )
  {
    localVersionsLinux();
  }
  else if( platform === 'win32' )
  {
    localVersionsWindows();
  }
  else if( platform === 'darwin' )
  {
    localVersionsDarwin();
  }
  else
  {
    throw _.err( `Unsupported platform: ${process.platform}` )
  }

  return ready;

  /*  */

  function linuxInfoGet()
  {
    try
    {
      let getos = require( 'getos' );
      let con = new _.Consequence();
      getos( con.tolerantCallback() )
      con.deasync();
      return con.sync();
    }
    catch( err )
    {
      throw _.err( 'Failed to get information about Linux distribution. Reason:\n', err );
    }
  }

  function localVersionsLinux()
  {
    let linuxInfo = linuxInfoGet();
    let distroName = linuxInfo.dist.toLowerCase();
    let execPath;

    if( _.strHas( distroName, 'ubuntu' ) )
    {
      execPath = 'apt list --installed ' + parsed.longPath;
    }
    else if( _.strHas( distroName, 'centos' ) )
    {
      execPath = 'yum list installed ' + parsed.longPath;
    }
    else
    {
      throw _.err( `Unsupported Linux distribution: ${distroName}` )
    }

    /* */

    let o =
    {
      execPath, ready,
      inputMirroring : 0,
      throwingExitCode : 0,
    }
    _.process.start( o );
  }

  function localVersionsWindows()
  {
    let execPath = 'choco list --all --local-only ' + parsed.longPath;
    let o =
    {
      execPath, ready,
      inputMirroring : 0
    }
    _.process.start( o );
  }

  function localVersionsDarwin()
  {
    let execPath = 'brew list --versions ' + parsed.longPath;
    let o =
    {
      execPath, ready,
      inputMirroring : 0
    }
    _.process.start( o );
  }

}

commandPackageLocalVersions.commandProperties =
{
}

//

function commandPackageRemoteVersions( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let isolated = _.strIsolateLeftOrAll( e.argument, ' ' );

  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  let options = _.strStructureParse( isolated[ 2 ] )

  _.assertMapHasOnly( options, commandPackageRemoteVersions.commandProperties, `Command does not expect options:` );

  let tool  = parsed.protocol;

  parsed.protocol = null;
  parsed.longPath = _.path.normalize( parsed.longPath );
  parsed.longPath = _.strRemoveBegin( parsed.longPath, '/' );

  if( parsed.tag )
  {
    let appNameAndVersion = _.uri.str( parsed );
    throw _.err( `Expects application and version in format "app#version", but got: "${appNameAndVersion}"` )
  }

  _.assert( !parsed.tag, `Expects application and version in format "app#version", but got: "${parsed.longPath}"` )

  let platform = process.platform;

  if( platform === 'linux' )
  {
    remoteVersionsLinux();
  }
  else if( platform === 'win32' )
  {
    remoteVersionsWindows();
  }
  else if( platform === 'darwin' )
  {
    remoteVersionsDarwin();
  }
  else
  {
    throw _.err( `Unsupported platform: ${process.platform}` )
  }

  return ready;

  /*  */

  function linuxInfoGet()
  {
    try
    {
      let getos = require( 'getos' );
      let con = new _.Consequence();
      getos( con.tolerantCallback() )
      con.deasync();
      return con.sync();
    }
    catch( err )
    {
      throw _.err( 'Failed to get information about Linux distribution. Reason:\n', err );
    }
  }

  function remoteVersionsLinux()
  {
    let linuxInfo = linuxInfoGet();
    let distroName = linuxInfo.dist.toLowerCase();
    let execPath;

    if( _.strHas( distroName, 'ubuntu' ) )
    {
      execPath = 'apt-cache madison ' + parsed.longPath;

      if( options.all )
      {
        let rmadisonIsInstalled = isInstalled( 'devscripts' );
        if( rmadisonIsInstalled )
        {
          execPath = 'rmadison ' + parsed.longPath;
        }
        else
        {
          logger.warn( 'Package rmadison is required, but it is not installed.\nRun: "sudo apt-get install -y devscripts" and try again.' )
        }
      }
    }
    else if( _.strHas( distroName, 'centos' ) )
    {
      execPath = 'yum list ';
      if( options.all )
      execPath += '--showduplicates ';
      execPath += parsed.longPath;
    }
    else
    {
      throw _.err( `Unsupported Linux distribution: ${distroName}` )
    }

    /* */

    let o =
    {
      execPath, ready,
      inputMirroring : 0
    }
    _.process.start( o );
  }

  function isInstalled( packageName )
  {
    var result = _.process.start
    ({
      execPath : 'dpkg -s ' + packageName,
      outputCollecting : 1,
      outputPiping : 0,
      inputMirroring : 0,
      throwingExitCode : 0,
      sync : 1
    })
    return !_.strHas( result.output, 'is not installed' );
  }

  function remoteVersionsWindows()
  {
    let execPath = 'choco list --all ' + parsed.longPath;
    let o =
    {
      execPath, ready,
      inputMirroring : 0
    }
    _.process.start( o );
  }

  function remoteVersionsDarwin()
  {
    //Vova: lists only versions known for current version of brew
    let execPath = 'brew search ' + parsed.longPath;
    let o =
    {
      execPath, ready,
      inputMirroring : 0
    }
    _.process.start( o );
  }
}
commandPackageRemoteVersions.commandProperties =
{
  all : 'Gets verions of package from remote archive.',
}

//

function commandPackageVersion( e )
{
  let will = this;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  let isolated = _.strIsolateLeftOrAll( e.argument, ' ' );

  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  let options = _.strStructureParse( isolated[ 2 ] );

  _.assertMapHasOnly( options, commandPackageVersion.commandProperties, `Command does not expect options:` );

  let tool  = parsed.protocol;

  parsed.protocol = null;
  parsed.longPath = _.path.normalize( parsed.longPath );
  parsed.longPath = _.strRemoveBegin( parsed.longPath, '/' );

  if( parsed.tag )
  {
    let appNameAndVersion = _.uri.str( parsed );
    throw _.err( `Expects application and version in format "app#version", but got: "${appNameAndVersion}"` )
  }

  _.assert( !parsed.tag, `Expects application and version in format "app#version", but got: "${parsed.longPath}"` )

  let platform = process.platform;

  if( platform === 'linux' )
  {
    localVersionLinux();
  }
  else if( platform === 'win32' )
  {
    localVersionWindows();
  }
  else if( platform === 'darwin' )
  {
    localVersionDarwin();
  }
  else
  {
    throw _.err( `Unsupported platform: ${process.platform}` )
  }

  return ready;

  /*  */

  function linuxInfoGet()
  {
    try
    {
      let getos = require( 'getos' );
      let con = new _.Consequence();
      getos( con.tolerantCallback() )
      con.deasync();
      return con.sync();
    }
    catch( err )
    {
      throw _.err( 'Failed to get information about Linux distribution. Reason:\n', err );
    }
  }

  function localVersionLinux()
  {
    let linuxInfo = linuxInfoGet();
    let distroName = linuxInfo.dist.toLowerCase();
    let execPath;

    if( _.strHas( distroName, 'ubuntu' ) )
    {
      execPath = 'dpkg -s ' + parsed.longPath + ' | grep Version';
    }
    else if( _.strHas( distroName, 'centos' ) )
    {
      execPath = 'rpm -q ' + parsed.longPath;
    }
    else
    {
      throw _.err( `Unsupported Linux distribution: ${distroName}` )
    }

    let o =
    {
      execPath, ready,
      inputMirroring : 0,
      throwingExitCode : 0
    }
    _.process.start( o );
  }

  function localVersionWindows()
  {
    let execPath = 'choco list --local-only ' + parsed.longPath

    let o =
    {
      execPath, ready,
      inputMirroring : 0,
      throwingExitCode : 0
    }
    _.process.start( o );
  }

  function localVersionDarwin()
  {
    let execPath = 'brew list --versions ' + parsed.longPath

    let o =
    {
      execPath, ready,
      inputMirroring : 0,
      throwingExitCode : 0
    }
    _.process.start( o );
  }
}

commandPackageVersion.commandProperties =
{
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
  currentOpenerPath : null,
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
  currentPath : 'currentPath',
}

let Accessors =
{
  currentOpener : { readOnly : 1 },
}

// --
// declare
// --

let Extension =
{

  // exec

  Exec,
  exec,
  init,

  // opener

  _openersCurrentEach,
  openersCurrentEach,
  openersFind,
  currentOpenerChange,

  // etc

  errEncounter,
  _propertiesImply,

  // meta command

  _commandsMake,
  _commandsBegin,
  _commandsEnd,

  _commandListLike,
  _commandBuildLike,
  _commandCleanLike,
  _commandNewLike,
  _commandTreeLike,

  // command

  commandHelp,
  commandImply,
  commandVersion,
  commandVersionCheck,

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

  commandSubmodulesAdd,
  commandSubmodulesFixate,
  commandSubmodulesUpgrade,

  commandSubmodulesVersionsDownload,
  commandSubmodulesVersionsUpdate,
  commandSubmodulesVersionsVerify,
  commandSubmodulesVersionsAgree,

  commandModuleNew,
  commandModuleNewWith,

  commandShell,
  commandDo,
  commandHookCall,
  commandHooksList,
  commandClean,
  commandSubmodulesClean,
  commandBuild,
  commandExport,
  commandExportPurging,
  commandExportRecursive,

  // command git

  commandGitPull,
  commandGitPush,
  commandGitReset,
  commandGitStatus,
  commandGitSync,
  commandGitTag,
  commandGitPreservingHardLinks,

  // command iterator

  commandWith,
  commandEach,

  // command converters

  commandNpmGenerateFromWillfile,
  commandWillfileGenerateFromNpm,

  // command package

  commandPackageInstall,
  commandPackageLocalVersions,
  commandPackageRemoteVersions,
  commandPackageVersion,

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
  extend : Extension,
});

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
wTools[ Self.shortName ] = Self;

if( !module.parent )
Self.Exec();

})();
