( function _MainTop_s_( )
{

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
commandNpmFromWillfile
commandWillfileFromNpm

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
    return ca.programPerform
    ({
      program : _.strUnquote( appArgs.original ),
      withParsed : 1,
    });
    // return ca.appArgsPerform({ appArgs });
    /* qqq2 : make use of
    return ca.programPerform({ program : appArgs.original });

    - commands like .with and .imply should set some field
    - field set by .with should be reset to null after command which use the field
    - field set by .imply should not be reset to null after command which use the field, but should be reset to null bu another .imply command
    - we drop support of `.command1 ; .command2` syntax. we support only `.command1 .commadn2` syntax

  */
  })
  .then( ( arg ) =>
  {
    return arg;
  })
  .catch( ( err ) =>
  {
    _.process.exitCode( -1 );
    err = _.err( err );
    logger.error( _.errOnce( err ) );
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

function _command_pre( o )
{
  let cui = this;

  if( arguments.length === 2 )
  o = { routine : arguments[ 0 ], args : arguments[ 1 ] }

  _.routineOptions( _command_pre, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( o.args.length === 1 );

  let e = o.args[ 0 ];

  if( o.propertiesMapAsProperty )
  {
    let propertiesMap = Object.create( null );
    if( e.propertiesMap )
    propertiesMap[ o.propertiesMapAsProperty ] = e.propertiesMap;
    e.propertiesMap = propertiesMap;
  }

  if( cui.implied )
  {
    if( o.routine.defaults )
    _.mapExtend( e.propertiesMap, _.mapOnly( cui.implied, o.routine.defaults ) );
    else
    _.mapExtend( e.propertiesMap, cui.implied );
  }

  _.sure( _.mapIs( e.propertiesMap ), () => 'Expects map, but got ' + _.toStrShort( e.propertiesMap ) );
  if( o.routine.commandProperties )
  _.sureMapHasOnly( e.propertiesMap, o.routine.commandProperties, `Command does not expect options:` );

  if( _.boolLikeFalse( o.routine.commandSubjectHint ) )
  if( e.subject.trim() !== '' )
  throw _.errBrief
  (
    `Command .${e.subjectDescriptor.phraseDescriptor.phrase} does not expect subject`
    + `, but got "${e.subject}"`
  );

  if( o.routine.commandProperties && o.routine.commandProperties.v )
  if( e.propertiesMap.v !== undefined )
  {
    e.propertiesMap.verbosity = e.propertiesMap.v;
    delete e.propertiesMap.v;
  }
}

_command_pre.defaults =
{
  routine : null,
  args : null,
  propertiesMapAsProperty : 0,
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
    namesMap,
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

    'help' :                            { e : _.routineJoin( will, will.commandHelp )                         },
    'imply' :                           { e : _.routineJoin( will, will.commandImply )                        },
    'version' :                         { e : _.routineJoin( will, will.commandVersion )                      },
    'version check' :                   { e : _.routineJoin( will, will.commandVersionCheck )                 },

    'modules list' :                    { e : _.routineJoin( will, will.commandModulesList )                  },
    'modules topological list' :        { e : _.routineJoin( will, will.commandModulesTopologicalList )       },
    'modules tree' :                    { e : _.routineJoin( will, will.commandModulesTree )                  },
    'resources list' :                  { e : _.routineJoin( will, will.commandResourcesList )                },
    'paths list' :                      { e : _.routineJoin( will, will.commandPathsList )                    },
    'submodules list' :                 { e : _.routineJoin( will, will.commandSubmodulesList )               },
    'reflectors list' :                 { e : _.routineJoin( will, will.commandReflectorsList )               },
    'steps list' :                      { e : _.routineJoin( will, will.commandStepsList )                    },
    'builds list' :                     { e : _.routineJoin( will, will.commandBuildsList )                   },
    'exports list' :                    { e : _.routineJoin( will, will.commandExportsList )                  },
    'about list' :                      { e : _.routineJoin( will, will.commandAboutList )                    },
    'about' :                           { e : _.routineJoin( will, will.commandAboutList )                    },

    'submodules clean' :                { e : _.routineJoin( will, will.commandSubmodulesClean )              },
    'submodules add' :                  { e : _.routineJoin( will, will.commandSubmodulesAdd )                },
    'submodules fixate' :               { e : _.routineJoin( will, will.commandSubmodulesFixate )             },
    'submodules upgrade' :              { e : _.routineJoin( will, will.commandSubmodulesUpgrade )            },

    'submodules download' :             { e : _.routineJoin( will, will.commandSubmodulesVersionsDownload )   },
    'submodules update' :               { e : _.routineJoin( will, will.commandSubmodulesVersionsUpdate )     },
    'submodules versions download' :    { e : _.routineJoin( will, will.commandSubmodulesVersionsDownload )   },
    'submodules versions update' :      { e : _.routineJoin( will, will.commandSubmodulesVersionsUpdate )     },
    'submodules versions verify' :      { e : _.routineJoin( will, will.commandSubmodulesVersionsVerify )     },
    'submodules versions agree' :       { e : _.routineJoin( will, will.commandSubmodulesVersionsAgree )      },
    'submodules shell' :                { e : _.routineJoin( will, will.commandSubmodulesShell )              },
    'submodules git' :                  { e : _.routineJoin( will, will.commandSubmodulesGit )                },
    'submodules git pr open' :          { e : _.routineJoin( will, will.commandSubmodulesGitPrOpen )          },
    'submodules git sync' :             { e : _.routineJoin( will, will.commandSubmodulesGitSync )            },

    'shell' :                           { e : _.routineJoin( will, will.commandShell )                        },
    'do' :                              { e : _.routineJoin( will, will.commandDo )                           },
    'call' :                            { e : _.routineJoin( will, will.commandHookCall )                     },
    'hook call' :                       { e : _.routineJoin( will, will.commandHookCall )                     },
    'hooks list' :                      { e : _.routineJoin( will, will.commandHooksList )                    },
    'clean' :                           { e : _.routineJoin( will, will.commandClean )                        },
    'build' :                           { e : _.routineJoin( will, will.commandBuild )                        },
    'export' :                          { e : _.routineJoin( will, will.commandExport )                       },
    'export purging' :                  { e : _.routineJoin( will, will.commandExportPurging )                },
    'export recursive' :                { e : _.routineJoin( will, will.commandExportRecursive )              },

    'module new' :                      { e : _.routineJoin( will, will.commandModuleNew )                    },
    'module new with' :                 { e : _.routineJoin( will, will.commandModuleNewWith )                },
    'modules shell' :                   { e : _.routineJoin( will, will.commandModulesShell )                 },
    'modules git' :                     { e : _.routineJoin( will, will.commandModulesGit )                   },
    'modules git pr open' :             { e : _.routineJoin( will, will.commandModulesGitPrOpen )             },
    'modules git sync' :                { e : _.routineJoin( will, will.commandModulesGitSync )               },

    'git' :                             { e : _.routineJoin( will, will.commandGit )                          },
    'git pr open' :                     { e : _.routineJoin( will, will.commandGitPrOpen )                    },
    'git pull' :                        { e : _.routineJoin( will, will.commandGitPull )                      },
    'git push' :                        { e : _.routineJoin( will, will.commandGitPush )                      },
    'git reset' :                       { e : _.routineJoin( will, will.commandGitReset )                     },
    'git status' :                      { e : _.routineJoin( will, will.commandGitStatus )                    },
    'git sync' :                        { e : _.routineJoin( will, will.commandGitSync )                      },
    'git tag' :                         { e : _.routineJoin( will, will.commandGitTag )                       },
    'git config preserving hardlinks' : { e : _.routineJoin( will, will.commandGitPreservingHardLinks )       },

    'with' :                            { e : _.routineJoin( will, will.commandWith )                         },
    'each' :                            { e : _.routineJoin( will, will.commandEach )                         },

    'npm from willfile' :               { e : _.routineJoin( will, will.commandNpmFromWillfile )              },
    'willfile from npm' :               { e : _.routineJoin( will, will.commandWillfileFromNpm )              },
    'willfile get' :                    { e : _.routineJoin( will, will.commandWillfileGet )                  },
    'willfile set' :                    { e : _.routineJoin( will, will.commandWillfileSet )                  },
    'willfile del' :                    { e : _.routineJoin( will, will.commandWillfileDel )                  },
    'willfile extend' :                 { e : _.routineJoin( will, will.commandWillfileExtend )               },
    'willfile supplement' :             { e : _.routineJoin( will, will.commandWillfileSupplement )           },
    'willfile extend willfile' :        { e : _.routineJoin( will, will.commandWillfileExtendWillfile )       },
    'willfile supplement willfile' :    { e : _.routineJoin( will, will.commandWillfileSupplementWillfile )   },
    'package install' :                 { e : _.routineJoin( will, will.commandPackageInstall )               },
    'package local versions' :          { e : _.routineJoin( will, will.commandPackageLocalVersions )         },
    'package remote versions' :         { e : _.routineJoin( will, will.commandPackageRemoteVersions )        },
    'package version' :                 { e : _.routineJoin( will, will.commandPackageVersion )               },

  }

  let ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands,
    commandPrefix : 'node ',
    logger : will.logger,
    commandsImplicitDelimiting : 1,
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
        e.request = _.will.Resolver.strRequestParse( e.commandArgument );

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
    logger.error( _.errOnce( err ) );
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

  _.all
  (
    _.Will.ModuleFilterNulls,
    ( e, k ) => _.assert( _.boolLike( o[ k ] ), `Expects bool-like ${k}, but it is ${_.strType( k )}` )
  );
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
    logger.error( _.errOnce( err ) );
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
  _.all
  (
    _.Will.ModuleFilterNulls,
    ( e, k ) => _.assert( _.boolLike( o[ k ] ), `Expects bool-like ${k}, but it is ${_.strType( k )}` )
  );
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
    logger.error( _.errOnce( err ) );
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

  // withIn : 1,
  // withOut : 1,
  // withInvalid : 0,
  // withDisabledModules : 0,

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
    logger.error( _.errOnce( err ) );
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
    logger.error( _.errOnce( err ) );
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

function _commandModulesLike( o )
{
  let cui = this;
  let logger = cui.logger;
  let ready = new _.Consequence().take( null );

  _.routineOptions( _commandModulesLike, arguments );
  _.mapSupplementNulls( o, cui.filterImplied() );
  _.mapSupplementNulls( o, _.Will.ModuleFilterDefaults );

  _.all
  (
    _.Will.ModuleFilterNulls,
    ( e, k ) => _.assert( _.boolLike( o[ k ] ), `Expects bool-like ${k}, but it is ${_.strType( k )}` )
  );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onEach ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  cui._commandsBegin( o.commandRoutine );

  if( cui.currentOpeners === null && cui.currentOpener === null )
  ready.then( () => cui.openersFind() )
  .then( () => filter() );

  let openers = cui.currentOpeners;
  cui.currentOpeners = null;

  for( let i = 0 ; i < openers.length ; i++ )
  ready.then( () => openersEach( openers[ i ] ) );

  return ready.finally( ( err, arg ) =>
  {
    cui.currentOpeners = openers;
    cui._commandsEnd( o.commandRoutine );
    if( err )
    logger.error( _.errOnce( err ) );
    if( err )
    throw err;
    return arg;
  })

  /* */

  function filter()
  {
    if( cui.currentOpeners )
    {
      let openers2 = cui.modulesFilter( cui.currentOpeners, _.mapOnly( o, cui.modulesFilter.defaults ) );
      if( openers2.length )
      cui.currentOpeners = openers2;
    }
    return null;
  }
  /* */

  function openersEach( opener )
  {
    let ready2 = cui.modulesFindEachAt
    ({
      selector : _.strUnquote( 'submodule::*' ),
      currentOpener : opener,
    })
    .then( function( it )
    {
      if( o.withRoot )
      _.arrayPrependOnce( it.sortedOpeners, opener );
      else
      _.arrayRemove( it.sortedOpeners, opener );

      cui.currentOpeners = it.sortedOpeners;
      return it;
    })

    ready2
    .then( () => cui.openersCurrentEach( forSingle ) )

    return ready2;
  }

  /* */

  function forSingle( it )
  {
    let ready3 = new _.Consequence().take( null );
    let it2 = _.mapExtend( null, o, it );

    ready3.then( () =>
    {
      return cui.currentOpenerChange( it.opener );
    });

    ready3.then( () =>
    {
      cui.readingEnd();
      return o.onEach.call( cui, it2 );
    });

    ready3.finally( ( err, arg ) =>
    {
      cui.currentOpenerChange( null );
      if( err )
      throw _.err( err, `\nFailed to ${o.name} at ${it.opener ? it.opener.commonPath : ''}` );
      return arg;
    });

    return ready3;
  }

}

var defaults = _commandModulesLike.defaults = _.mapExtend( null, _.Will.ModuleFilterNulls );
defaults.event = null;
defaults.onEach = null;
defaults.commandRoutine = null;
defaults.name = null;
defaults.withRoot = 1;

// --
// command
// --

function commandHelp( e )
{
  let cui = this;
  let ca = e.ca;
  cui._command_pre( commandHelp, arguments );

  ca._commandHelp( e );
}

commandHelp.hint = 'Get help.';
commandHelp.commandSubjectHint = 'A command name to get detailed help for specific command.';

//

function commandImply( e )
{
  let cui = this;

  cui.implied = null;
  cui._command_pre( commandImply, arguments );

  cui.implied = e.propertiesMap;
  cui._propertiesImply( _.mapOnly( e.propertiesMap, commandImply.defaults ) );

}

commandImply.defaults =
{
  v : 3,
  verbosity : 3,
  beeping : null,
  withOut : null,
  withIn : 1,
  withEnabled : null,
  withDisabled : null,
  withValid : null,
  withInvalid : null,
  withSubmodules : null,
};
commandImply.hint = 'Change state or imply value of a variable';
commandImply.commandSubjectHint = false;
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
  recursive : 'Recursive action for modules. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:0.',
  dirPath : 'Path to local directory. Default is directory of current module.',
  dry : 'Dry run without resetting. Default is dry:0.',
};

// function commandImply( e )
// {
//   let will = this;
//   let ca = e.ca;
//   let logger = will.logger;
//   let isolated = ca.commandIsolateSecondFromArgument( e.commandArgument );
//   /* qqq xxx : apply to other top modules */
//   _.assert( !!isolated );
//
//   let request = _.will.Resolver.strRequestParse( isolated.commandArgument );
//   will._propertiesImply( request.map );
//
//   // let namesMap =
//   // {
//   //
//   //   v : 'verbosity',
//   //   verbosity : 'verbosity',
//   //   beeping : 'beeping',
//   //
//   //   withOut : 'withOut',
//   //   withIn : 'withIn',
//   //   withEnabled : 'withEnabled',
//   //   withDisabled : 'withDisabled',
//   //   withValid : 'withValid',
//   //   withInvalid : 'withInvalid',
//   //   withSubmodules : 'withSubmodules',
//   //
//   // }
//   //
//   // _.process.argsReadTo
//   // ({
//   //   dst : will,
//   //   propertiesMap : request.map,
//   //   namesMap : namesMap,
//   // });
//
//   if( isolated.secondCommand )
//   return ca.commandPerform
//   ({
//     command : isolated.secondCommand,
//   });
//
// }

//

function commandVersion( e )
{
  let cui = this;
  cui._command_pre( commandVersion, arguments );

  return _.npm.versionLog
  ({
    localPath : _.path.join( __dirname, '../../../../..' ),
    remotePath : 'willbe',
  });
}

commandVersion.hint = 'Get information about version.';
commandVersion.commandSubjectHint = false;

// function commandVersion( e ) /* xxx qqq : move to NpmTools */
// {
//   let will = this;
//   let ca = e.ca;
//   let logger = will.logger;
//
//   let implyMap = _.strStructureParse( e.commandArgument );
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
  let cui = this;
  cui._command_pre( commandVersion, arguments );
  cui._propertiesImply( e.propertiesMap );

  return cui.versionIsUpToDate( e.propertiesMap );
}

commandVersionCheck.hint = 'Check if current version of willbe is the latest.';
commandVersionCheck.commandSubjectHint = false;
commandVersionCheck.commandProperties =
{
  throwing : 'Throw an error if utility is not up to date. Default : 1.',
  ... commandImply.commandProperties,
};

//

function commandResourcesList( e )
{
  let cui = this;
  cui._command_pre( commandResourcesList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list resources',
    onEach : act,
    commandRoutine : commandResourcesList,
    resourceKind : '*',
  });

  function act( module, resources )
  {
    let logger = cui.logger;

    if( !e.request.subject && !_.mapKeys( e.request.map ).length )
    {
      let result = '';
      result += _.color.strFormat( 'About', 'highlighted' );
      result += module.openedModule.about.exportString();
      logger.log( result );
    }

    logger.log( module.openedModule.resourcesExportInfo( resources ) );
  }

}

commandResourcesList.hint = 'List information about resources of the current module.';
commandResourcesList.commandSubjectHint = 'A selector for resources. Could be a glob.';

//

function commandPathsList( e )
{
  let cui = this;
  cui._command_pre( commandPathsList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list paths',
    onEach : act,
    commandRoutine : commandPathsList,
    resourceKind : 'path',
  });

  function act( module, resources )
  {
    let logger = cui.logger;
    logger.log( module.openedModule.infoExportPaths( resources ) );
  }

}

commandPathsList.hint = 'List paths of the current module.';
commandPathsList.commandSubjectHint = 'A selector for paths. Could be a glob.';

//

function commandSubmodulesList( e )
{
  let cui = this;
  cui._command_pre( commandSubmodulesList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list submodules',
    onEach : act,
    commandRoutine : commandSubmodulesList,
    resourceKind : 'submodule',
  });

  function act( module, resources )
  {
    let logger = cui.logger;
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
  }

}

commandSubmodulesList.hint = 'List submodules of the current module.';
commandSubmodulesList.commandSubjectHint = 'A selector for submodules. Could be a glob.';

//

function commandReflectorsList( e )
{
  let cui = this;
  cui._command_pre( commandReflectorsList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list reflectors',
    onEach : act,
    commandRoutine : commandReflectorsList,
    resourceKind : 'reflector',
  });

  function act( module, resources )
  {
    let logger = cui.logger;
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
  }

}

commandReflectorsList.hint = 'List available reflectors of the current module.';
commandReflectorsList.commandSubjectHint = 'A selector for reflectors. Could be a glob.';

//

function commandStepsList( e )
{
  let cui = this;
  cui._command_pre( commandStepsList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list steps',
    onEach : act,
    commandRoutine : commandStepsList,
    resourceKind : 'step',
  });

  function act( module, resources )
  {
    let logger = cui.logger;
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
  }

}

commandStepsList.hint = 'List available steps of the current module.';
commandStepsList.commandSubjectHint = 'A selector for steps. Could be a glob.';

//

function commandBuildsList( e )
{
  let cui = this;
  cui._command_pre( commandBuildsList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list builds',
    onEach : act,
    commandRoutine : commandBuildsList,
    resourceKind : null,
  });

  function act( module )
  {
    let logger = cui.logger;
    let request = _.will.Resolver.strRequestParse( e.commandArgument );
    let builds = module.openedModule.buildsResolve
    ({
      name : request.subject,
      criterion : request.map,
      preffering : 'more',
    });
    logger.log( module.openedModule.resourcesExportInfo( builds ) );
  }

}

commandBuildsList.hint = 'List available builds of the current module.';
commandBuildsList.commandSubjectHint = 'A selector for builds. Could be a glob.';

//

function commandExportsList( e )
{
  let cui = this;
  cui._command_pre( commandExportsList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list exports',
    onEach : act,
    commandRoutine : commandExportsList,
    resourceKind : null,
  });

  function act( module )
  {
    let logger = cui.logger;
    let request = _.will.Resolver.strRequestParse( e.commandArgument );
    let builds = module.openedModule.exportsResolve
    ({
      name : request.subject,
      criterion : request.map,
      preffering : 'more',
    });
    logger.log( module.openedModule.resourcesExportInfo( builds ) );
  }

}

commandExportsList.hint = 'List available exports of the current module.';
commandExportsList.commandSubjectHint = 'A selector for exports. Could be a glob.';

//

function commandAboutList( e )
{
  let cui = this;
  cui._command_pre( commandAboutList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list about',
    onEach : act,
    commandRoutine : commandAboutList,
    resourceKind : null,
  });

  function act( module )
  {
    let logger = cui.logger;
    logger.log( _.color.strFormat( 'About', 'highlighted' ) );
    logger.log( module.openedModule.about.exportString() );
  }

}

commandAboutList.hint = 'List descriptive information about the current module.';
commandAboutList.commandSubjectHint = false;

//

function commandModulesList( e )
{
  let cui = this;
  cui._command_pre( commandModulesList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list modules',
    onEach : act,
    commandRoutine : commandModulesList,
    resourceKind : 'module',
  });

  function act( module, resources )
  {
    let logger = cui.logger;
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
  }

}

commandModulesList.hint = 'List all modules.';
commandModulesList.commandSubjectHint = false;

//

function commandModulesTopologicalList( e )
{
  let cui = this;
  cui._command_pre( commandModulesTopologicalList, arguments );

  return cui._commandListLike
  ({
    event : e,
    name : 'list topological sorted order',
    onEach : act,
    commandRoutine : commandModulesTopologicalList,
    resourceKind : 'module',
  });

  function act( module, resources )
  {
    let logger = cui.logger; // xxx
    logger.log( module.openedModule.infoExportModulesTopological( resources ) );
  }

}

commandModulesTopologicalList.hint = 'List all modules topologically.';
commandModulesTopologicalList.commandSubjectHint = false;

//

function commandModulesTree( e )
{
  let cui = this;
  let logger = cui.logger;
  cui._command_pre( commandModulesTree, arguments );

  let implyMap = _.mapOnly( e.propertiesMap, commandModulesTree.defaults );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  cui._propertiesImply( implyMap );

  return cui._commandTreeLike
  ({
    event : e,
    name : 'list tree of modules',
    onAll : handleAll,
    commandRoutine : commandModulesTree,
  });

  function handleAll( it )
  {
    let modules = it.modules;
    /* filtering was done earlier */
    e.propertiesMap.onlyRoots = 0;
    logger.log( cui.graphExportTreeInfo( modules, e.propertiesMap ) );
    return null;
  }

}

commandModulesTree.defaults = commandImply.defaults;
commandModulesTree.hint = 'List all found modules as a tree.';
commandModulesTree.commandSubjectHint = 'A selector for path names. Could be a glob.';
commandModulesTree.commandProperties =
{
  withLocalPath : 'Print local paths. Default is 0',
  withRemotePath : 'Print remote paths. Default is 0',
  ... commandImply.commandProperties,
}

//

function commandSubmodulesAdd( e )
{
  let cui = this;
  cui._command_pre( commandSubmodulesAdd, arguments );

  return cui._commandBuildLike
  ({
    event : e,
    name : 'add submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesAdd,
  });

  function handleEach( it )
  {

    let module = it.opener.openedModule;
    let filePath = module.pathResolve
    ({
      selector : e.commandArgument,
      prefixlessAction : 'resolved',
    });

    let found = cui.modulesFindWithAt
    ({
      selector : filePath,
      // withDisabledModules : 1,
      // withDisabledSubmodules : 1,
      withInvalid : 1,
      tracing : 0,
      ... cui.filterImplied(),
    });

    found.then( ( it ) =>
    {
      let junctions = cui.junctionsFrom( it.sortedOpeners );
      return module.submodulesAdd({ modules : junctions });
    })

    found.finally( ( err, added ) =>
    {
      if( err )
      throw _.err( err, `\nFaield to add submodules from ${filePath}` );
      if( cui.verbosity >= 2 )
      logger.log( `Added ${added} submodules to ${module.nameWithLocationGet()}` )
      return added;
    })

    return found;
  }

}

commandSubmodulesAdd.hint = 'Add submodules.';
commandSubmodulesAdd.commandSubjectHint = 'A selector ( path ) for module that will be included in module.';

//

function commandSubmodulesFixate( e )
{
  let cui = this;
  cui._command_pre( commandSubmodulesFixate, arguments );

  let implyMap = _.mapOnly( e.propertiesMap, commandSubmodulesFixate.defaults );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  cui._propertiesImply( implyMap );

  e.propertiesMap.reportingNegative = e.propertiesMap.negative;
  e.propertiesMap.upgrading = 0;
  delete e.propertiesMap.negative;

  return cui._commandBuildLike
  ({
    event : e,
    name : 'fixate submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesFixate,
  });

  // function handleEach( it )
  // {
  //   let o2 = cui.filterImplied(); /* Dmytro : it creates options map with field "withDisabledModules", "withEnabledModules", "withOut", "withIn"... but routine submodulesFixate does not expects such options. Below version which used only options "dry", "negative", "recursive" */
  //   o2 = _.mapExtend( o2, e.propertiesMap );
  //   return it.opener.openedModule.submodulesFixate( o2 );
  // }

  function handleEach( it )
  {
    return it.opener.openedModule.submodulesFixate( _.mapExtend( null, e.propertiesMap ) );
  }

}

commandSubmodulesFixate.defaults = commandImply.defaults;
commandSubmodulesFixate.hint = 'Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.';
commandSubmodulesFixate.commandSubjectHint = false;
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
  let cui = this;
  cui._command_pre( commandSubmodulesUpgrade, arguments );

  let implyMap = _.mapOnly( e.propertiesMap, commandSubmodulesUpgrade.defaults );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  cui._propertiesImply( implyMap );

  e.propertiesMap.upgrading = 1;
  e.propertiesMap.reportingNegative = e.propertiesMap.negative;
  delete e.propertiesMap.negative;

  return cui._commandBuildLike
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

commandSubmodulesUpgrade.defaults = commandImply.defaults;
commandSubmodulesUpgrade.hint = 'Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.';
commandSubmodulesUpgrade.commandSubjectHint = false;
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
  let cui = this;
  cui._command_pre( commandSubmodulesVersionsDownload, arguments );

  debugger;
  let implyMap = _.mapOnly( e.propertiesMap, commandSubmodulesVersionsDownload.defaults );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  cui._propertiesImply( implyMap );

  return cui._commandCleanLike
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
    _.routineOptions( cui.modulesDownload, o2 );
    if( o2.recursive === 2 )
    o2.modules = it.roots;

    return cui.modulesDownload( o2 );
  }

}

commandSubmodulesVersionsDownload.defaults = commandImply.defaults;
commandSubmodulesVersionsDownload.hint = 'Download each submodule if such was not downloaded so far.';
commandSubmodulesVersionsDownload.commandSubjectHint = false;
commandSubmodulesVersionsDownload.commandProperties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.commandProperties,
}

//

function commandSubmodulesVersionsUpdate( e )
{
  let cui = this;
  cui._command_pre( commandSubmodulesVersionsUpdate, arguments );

  let implyMap = _.mapOnly( e.propertiesMap, commandSubmodulesVersionsUpdate.defaults );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  cui._propertiesImply( implyMap );

  return cui._commandBuildLike
  ({
    event : e,
    name : 'update submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesVersionsUpdate,
  });

  function handleEach( it )
  {
    let o2 = cui.filterImplied();
    o2 = _.mapExtend( o2, e.propertiesMap );
    return it.opener.openedModule.subModulesUpdate( o2 );
  }

}

commandSubmodulesVersionsUpdate.defaults = commandImply.defaults;
commandSubmodulesVersionsUpdate.hint = 'Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.';
commandSubmodulesVersionsUpdate.commandSubjectHint = false;
commandSubmodulesVersionsUpdate.commandProperties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.commandProperties,
}

//

function commandSubmodulesVersionsVerify( e )
{
  let cui = this;
  cui._command_pre( commandSubmodulesVersionsVerify, arguments );

  let implyMap = _.mapOnly( e.propertiesMap, commandSubmodulesVersionsVerify.defaults );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  cui._propertiesImply( implyMap );

  return cui._commandBuildLike
  ({
    event : e,
    name : 'submodules versions verify',
    onEach : handleEach,
    commandRoutine : commandSubmodulesVersionsVerify,
  });

  function handleEach( it )
  {
    let o2 = cui.filterImplied();
    o2 = _.mapExtend( o2, e.propertiesMap );
    return it.opener.openedModule.submodulesVerify( o2 );
  }
}

commandSubmodulesVersionsVerify.defaults = commandImply.defaults;
commandSubmodulesVersionsVerify.hint = 'Check whether each submodule is on branch which is specified in willfile';
commandSubmodulesVersionsVerify.commandSubjectHint = false;
commandSubmodulesVersionsVerify.commandProperties =
{
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.commandProperties,
}

//

function commandSubmodulesVersionsAgree( e )
{
  let cui = this;
  cui._command_pre( commandSubmodulesVersionsAgree, arguments );

  let implyMap = _.mapOnly( e.propertiesMap, commandSubmodulesVersionsAgree.defaults );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  cui._propertiesImply( implyMap );

  return cui._commandBuildLike
  ({
    event : e,
    name : 'submodules versions agree',
    onEach : handleEach,
    commandRoutine : commandSubmodulesVersionsAgree,
  });

  function handleEach( it )
  {
    let o2 = cui.filterImplied();
    o2 = _.mapExtend( o2, e.propertiesMap );
    return it.opener.openedModule.subModulesAgree( o2 );
  }

}

commandSubmodulesVersionsAgree.defaults = commandImply.defaults;
commandSubmodulesVersionsAgree.hint = 'Update each submodule, checking for available updates for each submodule. Does not change state of module if update is needed and module has local changes.';
commandSubmodulesVersionsAgree.commandSubjectHint = false;
commandSubmodulesVersionsAgree.commandProperties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.commandProperties,
}

//

function commandSubmodulesShell( e )
{
  let cui = this;
  cui._command_pre( commandSubmodulesShell, arguments );

  return cui._commandModulesLike
  ({
    event : e,
    name : 'submodules shell',
    onEach : handleEach,
    commandRoutine : commandSubmodulesShell,
    withRoot : 0,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.shell
    ({
      execPath : e.commandArgument,
      currentPath : cui.currentOpenerPath || it.opener.openedModule.dirPath,
    });
  }

}

commandSubmodulesShell.hint = 'Run shell command on each submodule of current module.';
commandSubmodulesShell.commandSubjectHint = 'A command to execute in shell. Command executes for each submodule of current module.';

//

function commandSubmodulesGit( e )
{
  let cui = this;
  let commandOptions = _.mapBut( e.propertiesMap, commandImply.defaults );
  let hardLinkMaybe = commandOptions.hardLinkMaybe;
  if( hardLinkMaybe !== undefined )
  delete commandOptions.hardLinkMaybe;

  e.propertiesMap = _.mapOnly( e.propertiesMap, commandImply.defaults );
  if( _.mapKeys( commandOptions ).length >= 1 )
  e.subject += ' ' + _.mapToStr({ src : commandOptions, entryDelimeter : ' ' });
  cui._command_pre( commandGit, arguments );

  _.routineOptions( commandSubmodulesGit, e.propertiesMap );
  cui._propertiesImply( e.propertiesMap );

  return cui._commandModulesLike
  ({
    event : e,
    name : 'submodules git',
    onEach : handleEach,
    commandRoutine : commandSubmodulesGit,
    withRoot : 0,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitExecCommand
    ({
      dirPath : it.junction.dirPath,
      command : e.subject,
      verbosity : cui.verbosity,
      hardLinkMaybe,
    });
  }
}

commandSubmodulesGit.defaults = _.mapExtend( null, commandImply.defaults );
commandSubmodulesGit.defaults.withSubmodules = 0;
commandSubmodulesGit.hint = 'Use "submodules git" to run custom Git command on submodules of the module.';
commandSubmodulesGit.commandSubjectHint = 'Custom git command exclude name of command "git".';
commandSubmodulesGit.commandProperties = commandImply.commandProperties;
commandSubmodulesGit.commandProperties.hardLinkMaybe = 'Disables saving of hardlinks. Default value is 1.';

//

function commandSubmodulesGitPrOpen( e )
{
  let cui = this;
  cui._command_pre( commandSubmodulesGitPrOpen, arguments );

  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply( _.mapExtend( commandImply.defaults, { withSubmodules : 0  } ) );

  return cui._commandModulesLike
  ({
    event : e,
    name : 'submodules git pr open',
    onEach : handleEach,
    commandRoutine : commandSubmodulesGitPrOpen,
    withRoot : 0,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitPrOpen
    ({
      title : e.subject,
      ... e.propertiesMap,
    });
  }
}

commandSubmodulesGitPrOpen.defaults =
{
  token : null,
  remotePath : null,
  srcBranch : null,
  dstBranch : null,
  title : null,
  body : null,
  v : null,
  verbosity : null,
};
commandSubmodulesGitPrOpen.hint = 'Use "modules git pr open" to open pull requests from current modules and its submodules.';
commandSubmodulesGitPrOpen.commandSubjectHint = 'A title for PR';
commandSubmodulesGitPrOpen.commandProperties =
{
  token : 'An individual authorization token. By default reads from user config file.',
  srcBranch : 'A source branch. If PR opens from fork format should be "{user}:{branch}".',
  dstBranch : 'A destination branch. Default is "master".',
  title : 'Option that rewrite title in provided argument.',
  body : 'Body message.',
  v : 'Set verbosity. Default is 2.',
  verbosity : 'Set verbosity. Default is 2.',
};

//

function commandSubmodulesGitSync( e )
{
  let cui = this;
  cui._command_pre( commandSubmodulesGitSync, arguments );

  _.routineOptions( commandSubmodulesGitSync, e.propertiesMap );
  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply({ withSubmodules : 0 });

  return cui._commandModulesLike
  ({
    event : e,
    name : 'submodules git sync',
    onEach : handleEach,
    commandRoutine : commandSubmodulesGitSync,
    withRoot : 0,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitSync
    ({
      commit : e.subject,
      ... e.propertiesMap,
    });
  }
}

commandSubmodulesGitSync.defaults =
{
  dirPath : null,
  dry : 0,
  v : null,
  verbosity : 1,
};
commandSubmodulesGitSync.hint =
'Use "submodules git sync" to syncronize repositories of submodules of current module.';
commandSubmodulesGitSync.commandSubjectHint = 'A commit message. Default value is "."';
commandSubmodulesGitSync.commandProperties =
{
  dirPath : 'Path to local cloned Git directory. Default is directory of current module.',
  dry : 'Dry run without syncronizing. Default is dry:0.',
  v : 'Set verbosity. Default is 1.',
  verbosity : 'Set verbosity. Default is 1.',
};

//

function commandModuleNew( e )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  will._command_pre( commandModuleNew, arguments );

  if( e.commandArgument )
  e.propertiesMap.localPath = e.commandArgument;
  if( e.propertiesMap.verbosity === undefined )
  e.propertiesMap.verbosity = 1;

  if( will.withPath )
  {
    if( e.propertiesMap.localPath )
    e.propertiesMap.localPath = path.join( will.withPath, e.propertiesMap.localPath );
    else
    e.propertiesMap.localPath = will.withPath;
  }

  return will.moduleNew( e.propertiesMap );
}

commandModuleNew.hint = 'Create a new module.';
commandModuleNew.commandSubjectHint = 'Path to module file. Default value is ".will.yml".';
commandModuleNew.commandProperties =
{
  localPath : 'Path to module file. Default value is ".will.yml".',
}

//

function commandModuleNewWith( e )
{
  let cui = this;
  cui._command_pre( commandModuleNewWith, arguments );

  let fileProvider = cui.fileProvider;
  let path = cui.fileProvider.path;
  let logger = cui.logger;
  let time = _.time.now();
  let execPath = e.commandArgument;

  return cui._commandNewLike
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
    if( cui.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( 'hook::' + e.commandArgument, 'entity' )} in ${_.time.spent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let it2 = _.mapOnly( it, cui.hookContextFrom.defaults );
    it2.execPath = path.join( cui.hooksPath, execPath );
    it2 = cui.hookContextFrom( it2 );
    return cui.hookCall( it2 );
  }

}

commandModuleNewWith.hint = 'Make a new module in the current directory and call a specified hook for the module to prepare it.';
commandModuleNewWith.commandSubjectHint = 'A path to hook and arguments.';

//

function commandModulesShell( e )
{
  let cui = this;
  cui._command_pre( commandModulesShell, arguments );

  return cui._commandModulesLike
  ({
    event : e,
    name : 'modules shell',
    onEach : handleEach,
    commandRoutine : commandModulesShell,
    withRoot : 1,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.shell
    ({
      execPath : e.commandArgument,
      currentPath : cui.currentOpenerPath || it.opener.openedModule.dirPath,
    });
  }

}

commandModulesShell.hint = 'Run shell command on current module including each submodule of the module.';
commandModulesShell.commandSubjectHint =
'A command to execute in shell. Command executes for current module including each submodule of the module.';

//

function commandModulesGit( e )
{
  let cui = this;
  let commandOptions = _.mapBut( e.propertiesMap, commandImply.defaults );
  let hardLinkMaybe = commandOptions.hardLinkMaybe;
  if( hardLinkMaybe !== undefined )
  delete commandOptions.hardLinkMaybe;

  e.propertiesMap = _.mapOnly( e.propertiesMap, commandImply.defaults );
  if( _.mapKeys( commandOptions ).length >= 1 )
  e.subject += ' ' + _.mapToStr({ src : commandOptions, entryDelimeter : ' ' });
  cui._command_pre( commandGit, arguments );

  _.routineOptions( commandModulesGit, e.propertiesMap );
  cui._propertiesImply( e.propertiesMap );

  return cui._commandModulesLike
  ({
    event : e,
    name : 'modules git',
    onEach : handleEach,
    commandRoutine : commandModulesGit,
    withRoot : 1,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitExecCommand
    ({
      dirPath : it.junction.dirPath,
      command : e.subject,
      verbosity : cui.verbosity,
      hardLinkMaybe,
    });
  }
}

commandModulesGit.defaults = _.mapExtend( null, commandImply.defaults );
commandModulesGit.defaults.withSubmodules = 0;
commandModulesGit.hint = 'Use "modules git" to run custom Git command on module and its submodules.';
commandModulesGit.commandSubjectHint = 'Custom git command exclude name of command "git".';
commandModulesGit.commandProperties = commandImply.commandProperties;
commandModulesGit.commandProperties.hardLinkMaybe = 'Disables saving of hardlinks. Default value is 1.';

//

function commandModulesGitPrOpen( e )
{
  let cui = this;
  cui._command_pre( commandModulesGitPrOpen, arguments );

  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply( _.mapExtend( commandImply.defaults, { withSubmodules : 0  } ) );

  return cui._commandModulesLike
  ({
    event : e,
    name : 'modules git pr open',
    onEach : handleEach,
    commandRoutine : commandModulesGitPrOpen,
    withRoot : 1,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitPrOpen
    ({
      title : e.subject,
      ... e.propertiesMap,
    });
  }
}

commandModulesGitPrOpen.defaults =
{
  token : null,
  remotePath : null,
  srcBranch : null,
  dstBranch : null,
  title : null,
  body : null,
  v : null,
  verbosity : null,
};
commandModulesGitPrOpen.hint = 'Use "modules git pr open" to open pull requests from current modules and its submodules.';
commandModulesGitPrOpen.commandSubjectHint = 'A title for PR';
commandModulesGitPrOpen.commandProperties =
{
  token : 'An individual authorization token. By default reads from user config file.',
  srcBranch : 'A source branch. If PR opens from fork format should be "{user}:{branch}".',
  dstBranch : 'A destination branch. Default is "master".',
  title : 'Option that rewrite title in provided argument.',
  body : 'Body message.',
  v : 'Set verbosity. Default is 2.',
  verbosity : 'Set verbosity. Default is 2.',
};

//

function commandModulesGitSync( e )
{
  let cui = this;
  cui._command_pre( commandModulesGitSync, arguments );

  _.routineOptions( commandModulesGitSync, e.propertiesMap );
  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply({ withSubmodules : 0 });

  return cui._commandModulesLike
  ({
    event : e,
    name : 'modules git sync',
    onEach : handleEach,
    commandRoutine : commandModulesGitSync,
    withRoot : 1,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitSync
    ({
      commit : e.subject,
      ... e.propertiesMap,
    });
  }
}

commandModulesGitSync.defaults =
{
  dirPath : null,
  dry : 0,
  v : null,
  verbosity : 1,
};
commandModulesGitSync.hint =
'Use "modules git sync" to syncronize repositories of current module and all submodules of the module.';
commandModulesGitSync.commandSubjectHint = 'A commit message. Default value is "."';
commandModulesGitSync.commandProperties =
{
  dirPath : 'Path to local cloned Git directory. Default is directory of current module.',
  dry : 'Dry run without syncronizing. Default is dry:0.',
  v : 'Set verbosity. Default is 1.',
  verbosity : 'Set verbosity. Default is 1.',
};

//

function commandShell( e )
{
  let cui = this;
  cui._command_pre( commandShell, arguments );

  return cui._commandBuildLike
  ({
    event : e,
    name : 'shell',
    onEach : handleEach,
    commandRoutine : commandShell,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.shell
    ({
      execPath : e.commandArgument,
      currentPath : cui.currentOpenerPath || it.opener.openedModule.dirPath,
    });
  }

}

commandShell.hint = 'Run shell command on the module.';
commandShell.commandSubjectHint = 'A command to execute is shell.';

//

function commandDo( e )
{
  let cui = this;
  cui._command_pre( commandDo, arguments );
  let fileProvider = cui.fileProvider;
  let path = cui.fileProvider.path;
  let logger = cui.logger;
  let time = _.time.now();
  let execPath = e.commandArgument;

  return cui._commandBuildLike
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
    if( cui.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( e.commandArgument, 'code' )} in ${_.time.spent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let it2 = _.mapOnly( it, cui.hookContextFrom.defaults );
    it2.execPath = execPath;
    it2 = cui.hookContextFrom( it2 );
    return cui.hookCall( it2 );
  }

}

commandDo.hint = 'Run JS script on the module.';
commandDo.commandSubjectHint = 'A JS script to execute.';

//

function commandHookCall( e )
{
  let cui = this;
  cui._command_pre( commandDo, arguments );

  let path = cui.fileProvider.path;
  let logger = cui.logger;
  let time = _.time.now();
  let execPath = e.commandArgument;

  return cui._commandBuildLike
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
    if( cui.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( 'hook::' + e.commandArgument, 'entity' )} in ${_.time.spent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let it2 = _.mapOnly( it, cui.hookContextFrom.defaults );
    it2.execPath = path.join( cui.hooksPath, execPath );
    it2 = cui.hookContextFrom( it2 );
    return cui.hookCall( it2 );
  }

}

commandHookCall.hint = 'Call a specified hook on the module.';
commandHookCall.commandSubjectHint = 'A hook to execute';

//

function commandHooksList( e )
{
  let cui = this.form();
  cui._command_pre( commandHooksList, arguments );

  let implyMap = _.mapOnly( e.propertiesMap, commandHooksList.commandProperties );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  cui._propertiesImply( implyMap );
  let logger = cui.logger;

  cui.hooksReload();
  logger.log( 'Found hooks' );
  logger.up();
  cui.hooksList();
  logger.down();
}

commandHooksList.hint = 'List available hooks.';
commandHooksList.commandSubjectHint = false;
commandHooksList.commandProperties = commandImply.commandProperties;

//

function commandClean( e )
{
  let cui = this;
  cui._command_pre( commandClean, arguments );

  let implyMap = _.mapOnly( e.propertiesMap, commandClean.defaults );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  _.routineOptions( commandClean, implyMap );
  cui._propertiesImply( implyMap );

  e.propertiesMap.dry = !!e.propertiesMap.dry;
  if( e.propertiesMap.fast === undefined || e.propertiesMap.fast === null )
  e.propertiesMap.fast = !e.propertiesMap.dry;
  e.propertiesMap.fast = 0; /* xxx */

  return cui._commandCleanLike
  ({
    event : e,
    name : 'clean',
    onAll : handleAll,
    commandRoutine : commandClean,
  });

  function handleAll( it )
  {
    _.assert( _.arrayIs( it.openers ) );

    // let o2 = cui.filterImplied();
    let o2 = { ... cui.RelationFilterOn };
    o2 = _.mapExtend( o2, e.propertiesMap );
    o2.modules = it.openers;
    _.routineOptions( cui.modulesClean, o2 );
    if( o2.recursive === 2 )
    o2.modules = it.roots;
    o2.asCommand = 1;

    return cui.modulesClean( o2 );
  }

}

commandClean.defaults = _.mapExtend( null, commandImply.defaults );
commandClean.defaults.withSubmodules = 0;
commandClean.defaults.withOut = 1;
commandClean.hint = 'Clean current module. Delete genrated artifacts, temp files and downloaded submodules.';
commandClean.commandSubjectHint = false;
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
  let cui = this;
  cui._command_pre( commandSubmodulesClean, arguments );

  let implyMap = _.mapOnly( e.propertiesMap, commandSubmodulesClean.defaults );
  e.propertiesMap = _.mapBut( e.propertiesMap, implyMap );
  _.routineOptions( commandSubmodulesClean, implyMap );
  cui._propertiesImply( implyMap );

  e.propertiesMap.dry = !!e.propertiesMap.dry;;
  if( e.propertiesMap.fast === undefined || e.propertiesMap.fast === null )
  e.propertiesMap.fast = !e.propertiesMap.dry;
  e.propertiesMap.fast = 0; /* xxx */

  return cui._commandCleanLike
  ({
    event : e,
    name : 'clean',
    onAll : handleAll,
    commandRoutine : commandSubmodulesClean,
  });

  function handleAll( it )
  {
    _.assert( _.arrayIs( it.openers ) );

    // let o2 = cui.filterImplied();
    let o2 = { ... cui.RelationFilterOn };
    o2 = _.mapExtend( o2, e.propertiesMap );
    o2.modules = it.openers;
    _.routineOptions( cui.modulesClean, o2 );
    if( o2.recursive === 2 )
    o2.modules = it.roots;
    o2.asCommand = 1;
    o2.cleaningSubmodules = 1;
    o2.cleaningOut = 0;
    o2.cleaningTemp = 0;

    return cui.modulesClean( o2 );
  }

}

commandSubmodulesClean.defaults = _.mapExtend( null, commandImply.defaults );
commandSubmodulesClean.defaults.withSubmodules = 0;
commandSubmodulesClean.hint = 'Delete all downloaded submodules.';
commandSubmodulesClean.commandSubjectHint = false;
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
  let cui = this;
  cui._command_pre( commandBuild, arguments );
  let doneContainer = [];

  return cui._commandBuildLike
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
      ... _.mapBut( cui.RelationFilterOn, { withIn : null, withOut : null } ),
      doneContainer,
      name : e.subject,
      criterion : e.propertiesMap,
      recursive : 0,
      kind : 'build',
    });
  }

}

commandBuild.defaults = Object.create( null );
commandBuild.hint = 'Build current module with spesified criterion.';
commandBuild.commandSubjectHint = 'A name of build scenario.';

//

function commandExport( e )
{
  let cui = this;
  cui._command_pre( commandExport, arguments );
  let doneContainer = [];

  return cui._commandBuildLike
  ({
    event : e,
    name : 'export',
    onEach : handleEach,
    commandRoutine : commandExport,
  });

  function handleEach( it )
  {
    let filterProperties = _.mapBut( cui.RelationFilterOn, { withIn : null, withOut : null } );
    return it.opener.openedModule.modulesExport
    ({
      ... filterProperties,
      doneContainer,
      name : e.subject,
      criterion : e.propertiesMap,
      recursive : 0,
      kind : 'export',
    });
  }

}

commandExport.defaults = Object.create( null );
commandExport.hint = 'Export selected the module with spesified criterion. Save output to output willfile and archive.';
commandExport.commandSubjectHint = 'A name of export scenario.';

//

function commandExportPurging( e )
{
  let cui = this;
  cui._command_pre( commandExportPurging, arguments );
  let doneContainer = [];

  return cui._commandBuildLike
  ({
    event : e,
    name : 'export',
    onEach : handleEach,
    commandRoutine : commandExportPurging,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.modulesExport
    ({
      ... _.mapBut( cui.RelationFilterOn, { withIn : null, withOut : null } ),
      doneContainer,
      name : e.subject,
      criterion : e.propertiesMap,
      recursive : 0,
      purging : 1,
      kind : 'export',
    });
  }

}

commandExportPurging.defaults = Object.create( null );
commandExportPurging.hint = 'Export selected the module with spesified criterion purging output willfile first. Save output to output willfile and archive.';
commandExportPurging.commandSubjectHint = 'A name of export scenario.';

//

function commandExportRecursive( e )
{
  let cui = this;
  cui._command_pre( commandExportRecursive, arguments );
  let doneContainer = [];

  return cui._commandBuildLike
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
      ... _.mapBut( cui.RelationFilterOn, { withIn : null, withOut : null } ),
      doneContainer,
      name : e.subject,
      criterion : e.propertiesMap,
      recursive : 2,
      kind : 'export',
    });
  }

}

commandExportRecursive.defaults = Object.create( null );
commandExportRecursive.hint = 'Export selected the module with spesified criterion and its submodules. Save output to output willfile and archive.';
commandExportRecursive.commandSubjectHint = 'A name of export scenario.';

//

function commandGit( e )
{
  let cui = this;
  let commandOptions = _.mapBut( e.propertiesMap, commandImply.defaults );
  let hardLinkMaybe = commandOptions.hardLinkMaybe;
  if( hardLinkMaybe !== undefined )
  delete commandOptions.hardLinkMaybe;

  e.propertiesMap = _.mapOnly( e.propertiesMap, commandImply.defaults );
  if( _.mapKeys( commandOptions ).length >= 1 )
  e.subject += ' ' + _.mapToStr({ src : commandOptions, entryDelimeter : ' ' });
  cui._command_pre( commandGit, arguments );

  _.routineOptions( commandGit, e.propertiesMap );
  cui._propertiesImply( e.propertiesMap );

  return cui._commandBuildLike
  ({
    event : e,
    name : 'git',
    onEach : handleEach,
    commandRoutine : commandGit,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitExecCommand
    ({
      dirPath : it.junction.dirPath,
      command : e.subject,
      verbosity : cui.verbosity,
      hardLinkMaybe,
    });
  }
}

commandGit.defaults = _.mapExtend( null, commandImply.defaults );
commandGit.defaults.withSubmodules = 0;
commandGit.hint = 'Use "git" to run custom Git command in repository of module.';
commandGit.commandSubjectHint = 'Custom git command exclude name of command "git".';
commandGit.commandProperties = commandImply.commandProperties;
commandGit.commandProperties.hardLinkMaybe = 'Disables saving of hardlinks. Default value is 1.';

//

function commandGitPrOpen( e )
{
  let cui = this;
  cui._command_pre( commandGitPrOpen, arguments );

  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply( _.mapExtend( commandImply.defaults, { withSubmodules : 0  } ) );

  return cui._commandBuildLike
  ({
    event : e,
    name : 'git pr open',
    onEach : handleEach,
    commandRoutine : commandGitPrOpen,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.gitPrOpen
    ({
      title : e.subject,
      ... e.propertiesMap,
    });
  }
}

commandGitPrOpen.defaults =
{
  token : null,
  remotePath : null,
  srcBranch : null,
  dstBranch : null,
  title : null,
  body : null,
  v : null,
  verbosity : null,
};
commandGitPrOpen.hint = 'Use "git pr open" to open pull request from current modules.';
commandGitPrOpen.commandSubjectHint = 'A title for PR';
commandGitPrOpen.commandProperties =
{
  token : 'An individual authorization token. By default reads from user config file.',
  srcBranch : 'A source branch. If PR opens from fork format should be "{user}:{branch}".',
  dstBranch : 'A destination branch. Default is "master".',
  title : 'Option that rewrite title in provided argument.',
  body : 'Body message.',
  v : 'Set verbosity. Default is 2.',
  verbosity : 'Set verbosity. Default is 2.',
};

//

function commandGitPull( e )
{
  let cui = this;
  cui._command_pre( commandGitPull, arguments );

  _.routineOptions( commandGitPull, e.propertiesMap );
  cui._propertiesImply( e.propertiesMap );

  return cui._commandBuildLike
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
      verbosity : cui.verbosity,
    });
  }
}

commandGitPull.defaults = _.mapExtend( null, commandImply.defaults );
commandGitPull.defaults.withSubmodules = 0;
commandGitPull.hint = 'Use "git pull" to pull changes from remote repository.';
commandGitPull.commandSubjectHint = false;
commandGitPull.commandProperties = commandImply.commandProperties;

//

function commandGitPush( e )
{
  let cui = this;
  cui._command_pre( commandGitPush, arguments );

  _.routineOptions( commandGitPush, e.propertiesMap );
  cui._propertiesImply( e.propertiesMap );

  return cui._commandBuildLike
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
      verbosity : cui.verbosity,
    });
  }
}

commandGitPush.defaults = _.mapExtend( null, commandImply.defaults );
commandGitPush.defaults.withSubmodules = 0;
commandGitPush.hint = 'Use "git push" to push commits and tags to remote repository.';
commandGitPush.commandSubjectHint = false;
commandGitPush.commandProperties = commandImply.commandProperties;

//

function commandGitReset( e )
{
  let cui = this;
  cui._command_pre( commandGitReset, arguments );

  _.routineOptions( commandGitReset, e.propertiesMap );
  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply({ withSubmodules : 0 });

  return cui._commandBuildLike
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
      ... e.propertiesMap,
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
};
commandGitReset.hint = 'Use "git reset" to reset changes.';
commandGitReset.commandSubjectHint = false;
commandGitReset.commandProperties =
{
  dirPath : 'Path to local cloned Git directory. Default is directory of current module.',
  removingUntracked : 'Remove untracked files, option does not enable deleting of ignored files. Default is removingUntracked:0.',
  dry : 'Dry run without resetting. Default is dry:0.',
  v : 'Set verbosity. Default is 2.',
  verbosity : 'Set verbosity. Default is 2.',
};

//

function commandGitStatus( e )
{
  let cui = this;
  cui._command_pre( commandGitStatus, arguments );

  _.routineOptions( commandGitStatus, e.propertiesMap );
  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply({ withSubmodules : 0 });

  return cui._commandBuildLike
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
      ... e.propertiesMap,
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
};
commandGitStatus.hint = 'Use "git status" to check the status of the repository.';
commandGitStatus.commandSubjectHint = false;
commandGitStatus.commandProperties =
{
  local : 'Check local commits. Default value is 1.',
  uncommittedIgnored : 'Check ignored local files. Default value is 0.',
  remote : 'Check remote unmerged commits. Default value is 1.',
  remoteBranches : 'Check remote branches. Default value is 0.',
  prs : 'Check pull requests. Default is dry:1.',
  v : 'Set verbosity. Default is 1.',
  verbosity : 'Set verbosity. Default is 1.',
};

//

function commandGitSync( e )
{
  let cui = this;
  cui._command_pre( commandGitSync, arguments );

  _.routineOptions( commandGitSync, e.propertiesMap );
  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply({ withSubmodules : 0 });

  return cui._commandBuildLike
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
      commit : e.subject,
      ... e.propertiesMap,
    });
  }
}

commandGitSync.defaults =
{
  dirPath : null,
  dry : 0,
  v : null,
  verbosity : 1,
};
commandGitSync.hint = 'Use "git sync" to syncronize local and remote repositories.';
commandGitSync.commandSubjectHint = 'A commit message. Default value is "."';
commandGitSync.commandProperties =
{
  dirPath : 'Path to local cloned Git directory. Default is directory of current module.',
  dry : 'Dry run without syncronizing. Default is dry:0.',
  v : 'Set verbosity. Default is 1.',
  verbosity : 'Set verbosity. Default is 1.',
};

//

function commandGitTag( e )
{
  let cui = this;
  cui._command_pre( commandGitTag, arguments );

  _.routineOptions( commandGitTag, e.propertiesMap );
  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply({ withSubmodules : 0 });

  return cui._commandBuildLike
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
      ... e.propertiesMap,
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
};
commandGitTag.hint = 'Use "git tag" to add tag for current commit.';
commandGitTag.commandSubjectHint = false;
commandGitTag.commandProperties =
{
  name : 'Tag name. Default is name:".".',
  description : 'Description of annotated tag. Default is description:"".',
  dry : 'Dry run without tagging. Default is dry:0.',
  light : 'Enables lightweight tags. Default is light:0.',
  v : 'Set verbosity. Default is 1.',
  verbosity : 'Set verbosity. Default is 1.',
};

//

function commandGitPreservingHardLinks( e )
{
  let cui = this;
  cui._propertiesImply( e.propertiesMap );

  let enable = _.numberFrom( e.commandArgument );

  if( enable )
  _.git.hookPreservingHardLinksRegister();
  else
  _.git.hookPreservingHardLinksUnregister();
}

commandGitPreservingHardLinks.hint = 'Use "git config preserving hard links" to switch on preserve hardlinks.';
commandGitPreservingHardLinks.commandSubjectHint = 'Any subject to enable preserving hardliks.';

// --
// command iterator
// --

/* xxx : add test routine checking wrong syntax error handling */

function commandWith( e )
{
  let cui = this.form();
  let path = cui.fileProvider.path;
  cui._command_pre( commandWith, arguments );

  if( cui.currentOpener )
  {
    cui.currentOpener.finit();
    cui.currentOpenerChange( null );
  }

  _.sure( _.strDefined( e.commandArgument ), 'Expects path to module' );
  _.assert( arguments.length === 1 );

  if( !e.commandArgument )
  throw _.errBrief( 'Format of .with command should be: .with {-path-} .command' );

  if( process.platform === 'linux' )
  {
    let quoteRanges = _.strQuoteAnalyze({ src : e.commandArgument, quote : [ '"' ] }).ranges;
    if( quoteRanges.length !== 2 || ( quoteRanges[ 0 ] !== 0 && quoteRanges[ 1 ] !== e.commandArgument.length ) )
    {
      let splits = e.commandArgument.split( ' ' );
      if( splits.length > 1 )
      {
        let screenMap = _.paths.ext( splits );
        for( let i = screenMap.length - 1 ; i >= 0 ; i-- )
        {
          if( screenMap[ i ] === '' )
          {
            splits[ i ] = _.strUnquote( `${ splits[ i ] } ${ splits[ i + 1 ] }` );
            splits.splice( i + 1, 1 );
          }
        }
        e.commandArgument = _.strCommonLeft( ... splits ) + '*';
      }
    }
  }

  cui.withPath = path.join( path.current(), cui.withPath, path.fromGlob( e.commandArgument ) );

  return cui.modulesFindWithAt
  ({
    selector : _.strUnquote( e.commandArgument ),
    atLeastOne : !path.isGlob( e.commandArgument ),
  })
  .then( function( it )
  {
    cui.currentOpeners = it.sortedOpeners;

    if( !cui.currentOpeners.length )
    {
      let equalizer = ( parsed, command ) => parsed.commandName === command;
      if( !_.longHasAny( e.parsedCommands, [ '.module.new', '.module.new.with' ], equalizer ) )
      throw _.errBrief
      (
        `No module sattisfy criteria.`
        , `\nLooked at ${ _.strQuote( path.resolve( e.commandArgument ) )}`
      );
    }

    return it;
  })

}

commandWith.hint = 'Use "with" to select a module.';
commandWith.commandSubjectHint = 'A module selector.';

//

function commandEach( e )
{
  let cui = this.form();
  let path = cui.fileProvider.path;

  if( cui.currentOpener )
  {
    cui.currentOpener.finit();
    cui.currentOpenerChange( null );
  }

  _.sure( _.strDefined( e.commandArgument ), 'Expects path to module' )
  _.assert( arguments.length === 1 );

  if( !e.commandArgument )
  throw _.errBrief( 'Format of .each command should be: .each {-path-} .command' );

  let commandIndex = _.longLeftIndex( e.parsedCommands, '.each', ( parsed, command ) => parsed.commandName === command );
  _.assert( e.parsedCommands[ commandIndex + 1 ], 'Command .each should go with the second command to apply to each module. For example : ".each submodule::* .shell ls -al"' );

  let con;
  if( _.will.Resolver.selectorIs( e.commandArgument ) )
  {
    con = cui.modulesFindEachAt
    ({
      selector : _.strUnquote( e.commandArgument ),
      onError : handleError,
    })
  }
  else
  {
    if( !path.isGlob( e.commandArgument ) )
    {
      if( _.strEnds( e.commandArgument, '/.' ) )
      e.commandArgument = _.strRemoveEnd( e.commandArgument, '/.' ) + '/*';
      else if( e.commandArgument === '.' )
      e.commandArgument = '*';
      else if( _.strEnds( e.commandArgument, '/' ) )
      e.commandArgument += '*';
      else
      e.commandArgument += '/*';
    }

    con = cui.modulesFindWithAt
    ({
      selector : _.strUnquote( e.commandArgument ),
      atLeastOne : !path.isGlob( e.commandArgument ),
      withInvalid : 1,
    })
  }

  return con.then( function( it )
  {
    cui.currentOpeners = it.sortedOpeners;

    if( !cui.currentOpeners.length )
    {
      let equalizer = ( parsed, command ) => parsed.commandName === command;
      if( !_.longHasAny( e.parsedCommands, [ '.module.new', '.module.new.with' ], equalizer ) )
      throw _.errBrief
      (
        `No module sattisfy criteria.`
        , `\nLooked at ${ _.strQuote( path.resolve( e.commandArgument ) )}`
      );
    }

    return it;
  });

  /* */

  function handleError()
  {

    if( cui.currentOpener )
    cui.currentOpener.finit();
    cui.currentOpenerChange( null );
    cui.mainOpener = null;
  }

  // con.finally( ( err, arg ) =>
  // {
  //   if( err )
  //   cui.errEncounter( err );
  //   cui._commandsEnd( commandEach );
  //   if( err )
  //   throw _.err( err );
  //   return arg;
  // });
  //
  // return con;
  //
  // /* */
  //
  // function handleBegin( it )
  // {
  //
  //   // debugger;
  //   _.assert( cui.currentOpener === null );
  //   _.assert( cui.currentOpenerPath === null );
  //   // _.assert( cui.mainModule === null );
  //   // _.assert( cui.mainOpener === null ); // yyy
  //
  //   if( cui.mainOpener )
  //   cui.mainOpener.isMain = false;
  //   cui.currentOpenerChange( it.currentOpener );
  //   cui.currentOpenerPath = it.currentOpenerPath || null;
  //   it.currentOpener.isMain = true;
  //   _.assert( cui.mainOpener === it.currentOpener );
  //   _.assert( cui.currentOpener === it.currentOpener );
  //   // cui.mainOpener = it.currentOpener;
  //   // cui.mainModule = it.currentOpener.openedModule;
  //   // cui.mainOpener === it.currentOpener; // yyy
  //
  //   if( cui.verbosity > 1 )
  //   {
  //     logger.log( '' );
  //     logger.log( _.color.strFormat( 'Module at', { fg : 'bright white' } ), _.color.strFormat( it.currentOpener.commonPath, 'path' ) );
  //     if( cui.currentOpenerPath )
  //     logger.log( _.color.strFormat( '       at', { fg : 'bright white' } ), _.color.strFormat( cui.currentOpenerPath, 'path' ) );
  //   }
  //
  //   return null;
  // }
  //
  // /* */
  //
  // function handleEnd( it )
  // {
  //
  //   // debugger;
  //   logger.up();
  //   levelUp = 1;
  //
  //   debugger;
  //   let r = ca.commandPerform
  //   ({
  //     command : e.parsedCommands[ commandIndex + 1 ].command,
  //   });
  //
  //   _.assert( r !== undefined );
  //
  //   r = _.Consequence.From( r );
  //
  //   return r.finally( ( err, arg ) =>
  //   {
  //     logger.down();
  //     levelUp = 0;
  //
  //     // debugger;
  //     _.assert( cui.currentOpener === it.currentOpener || cui.currentOpener === null );
  //     // _.assert( cui.currentOpener === it.currentOpener ); // xxx
  //     // _.assert( cui.mainModule === cui.currentOpener.openedModule );
  //     _.assert( cui.mainOpener === it.currentOpener );
  //     cui.currentOpenerChange( null );
  //     it.currentOpener.isMain = false;
  //     if( !it.currentOpener.isUsed() )
  //     it.currentOpener.finit();
  //     _.assert( cui.mainOpener === null );
  //     _.assert( cui.currentOpener === null );
  //     _.assert( cui.currentOpenerPath === null );
  //     // cui.mainModule = null;
  //     // cui.mainOpener = null; // yyy
  //
  //     if( err )
  //     logger.log( _.errOnce( _.errBrief( '\n', err, '\n' ) ) );
  //     if( err )
  //     throw _.err( err );
  //     return arg;
  //   });
  //
  // }
  //
  // /* */
  //
  // function handleError( err )
  // {
  //
  //   if( cui.currentOpener )
  //   cui.currentOpener.finit();
  //   cui.currentOpenerChange( null );
  //   // cui.mainModule = null;
  //   cui.mainOpener = null;
  //
  //   if( levelUp )
  //   {
  //     levelUp = 0;
  //     logger.down();
  //   }
  //
  // }

}

commandEach.hint = 'Use "each" to iterate each module in a directory.';
commandEach.commandSubjectHint = 'A module or resource selector.';

//

function commandNpmFromWillfile( e )
{
  let cui = this;
  let criterionsMap = _.mapBut( e.propertiesMap, commandNpmFromWillfile.defaults );
  e.propertiesMap = _.mapOnly( e.propertiesMap, commandNpmFromWillfile.defaults );
  cui._command_pre( commandNpmFromWillfile, arguments );
  _.routineOptions( commandNpmFromWillfile, e.propertiesMap );

  if( cui.withSubmodules === null || cui.withSubmodules === undefined )
  cui._propertiesImply({ withSubmodules : 0 });

  if( e.subject )
  e.propertiesMap.packagePath = e.subject;

  return cui._commandBuildLike
  ({
    event : e,
    name : 'npm from willfile',
    onEach : handleEach,
    commandRoutine : commandNpmFromWillfile,
  });

  function handleEach( it )
  {
    if( _.mapKeys( criterionsMap ).length > 0 )
    it.opener.openedModule.stepMap[ 'npm.generate' ].criterion = criterionsMap;
    let currentContext = it.opener.openedModule.stepMap[ 'npm.generate' ];

    return it.opener.openedModule.npmGenerateFromWillfile
    ({
      ... e.propertiesMap,
      currentContext,
      verbosity : 2,
    });
  }

}

commandNpmFromWillfile.defaults =
{
  packagePath : '{path::out}/package.json',
  entryPath : null,
  filesPath : null,
};
commandNpmFromWillfile.hint = 'Use "npm from willfile" to generate "package.json" file from willfile.\n\t"will .npm.from.willfile" - generate "package.json" from unnamed willfiles, file locates in directory "out" of module;\n\t"will .npm.from.willfile package.json" - generate "package.json" from unnamed willfiles, file locates in directory of module.';
commandNpmFromWillfile.commandSubjectHint = 'A name of resulted JSON file. It has priority over option "packagePath".';
commandNpmFromWillfile.commandProperties =
{
  packagePath : 'Path to generated JSON file. Default is "{path::out}/package.json".\n\t"will .npm.from.willfile packagePath:out/package.json" - generate "package.json" from unnamed willfiles, file locates in directory "out" of module.',
  entryPath : 'Path to file that for field "main" of "package.json". By default "entryPath" is generated from module with path "path/entry".\n\t"will .npm.from.willfile entryPath:proto/wtools/Include.s" - generate "package.json" with field "main" : "proto/wtools/Include.s".',
  filesPath : 'Path to directory or file for field "files" of "package.json". By default, field "files" is generated from module\n\twith path "path/npm.files"a.\n\t"will .npm.from.willfile filesPath:proto" - generate "package.json" from unnamed willfiles, field "files" will contain all files from directory "proto".',
};

//

function commandWillfileFromNpm( e )
{
  let cui = this;
  let criterionsMap = _.mapBut( e.propertiesMap, commandWillfileFromNpm.defaults );
  e.propertiesMap = _.mapOnly( e.propertiesMap, commandWillfileFromNpm.defaults );
  cui._command_pre( commandWillfileFromNpm, arguments );
  _.routineOptions( commandWillfileFromNpm, e.propertiesMap );

  let con = new _.Consequence().take( null );
  if( !cui.currentOpeners )
  {
    con = cui.modulesFindWithAt
    ({
      atLeastOne : 1,
      selector : './',
      tracing : 1,
    })
    .finally( ( err, it ) =>
    {
      if( err )
      throw _.err( err );
      cui.currentOpeners = it.openers;
      return null;
    });
  }

  return con.then( () =>
  {

    if( !cui.currentOpeners.length )
    {
      let o =
      {
        ... e.propertiesMap,
        verbosity : 3,
      };
      return _.will.Module.prototype.willfileGenerateFromNpm.call( cui, o );
    }

    return cui._commandBuildLike
    ({
      event : e,
      name : 'npm from willfile',
      onEach : handleEach,
      commandRoutine : commandWillfileFromNpm,
    });
  })

  function handleEach( it )
  {
    if( _.mapKeys( criterionsMap ).length > 0 )
    it.opener.openedModule.stepMap[ 'willfile.generate' ].criterion = criterionsMap;
    let currentContext = it.opener.openedModule.stepMap[ 'willfile.generate' ];
    return it.opener.openedModule.willfileGenerateFromNpm
    ({
      ... e.propertiesMap,
      currentContext,
      verbosity : 3,
    });
  }
}

commandWillfileFromNpm.defaults =
{
  packagePath : null,
  willfilePath : null,
};
commandWillfileFromNpm.hint = 'Use "willfile from npm" to generate ".will.yml" file from "package.json".';
commandWillfileFromNpm.commandSubjectHint = false;
commandWillfileFromNpm.commandProperties =
{
  packagePath : 'Path to source json file. Default is "./package.json". Could be a selector.',
  willfilePath : 'Path to generated willfile. Default is "./.will.yml". Could be a selector.',
};

//

function commandWillfileGet( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut( e.propertiesMap, commandWillfileGet.defaults );
  e.propertiesMap = _.mapOnly( e.propertiesMap, commandWillfileGet.defaults );
  cui._command_pre( commandWillfileExtend, arguments );

  if( !e.subject && !cui.currentOpeners )
  e.subject = './(.im|.ex|will)*';

  if( e.subject )
  subjectNormalize();

  if( _.mapKeys( willfilePropertiesMap ).length === 0 )
  willfilePropertiesMap = { about : 1, build : 1, path : 1, reflector : 1, step : 1, submodule : 1 };

  if( e.subject )
  {
    let o =
    {
      request : e.subject,
      willfilePropertiesMap,
      ... e.propertiesMap,
    };
    return _.will.Module.prototype.willfileGetProperty.call( cui, o );
  }

  if( cui.currentOpeners )
  return cui._commandBuildLike
  ({
    event : e,
    name : 'willfile get',
    onEach : handleEach,
    commandRoutine : commandWillfileGet,
  });

  function handleEach( it )
  {
    let request = it.opener.commonPath;
    if( cui.fileProvider.isDir( request ) )
    request = cui.fileProvider.path.join( request, './.*' );

    return it.opener.openedModule.willfileGetProperty
    ({
      request,
      willfilePropertiesMap,
      ... e.propertiesMap,
    });
  }

  /* */

  function subjectNormalize()
  {
    let subject = e.subject;
    let isolated = _.strIsolateLeftOrAll( e.subject, ' ' );
    if( cui.fileProvider.path.isGlob( isolated[ 0 ] ) )
    {
      e.subject = isolated[ 0 ];
    }
    else
    {
      let firstKey = isolated[ 0 ].split( '/' )[ 0 ];
      if( _.longHas( [ 'about', 'build', 'path', 'reflector', 'step', 'submodule' ], firstKey ) )
      e.subject = undefined;
      else
      e.subject = isolated[ 0 ];
    }

    let splits = subject.split( /\s+/ );
    let i = e.subject === undefined ? 0 : 1;
    for( ; i < splits.length ; i++ )
    willfilePropertiesMap[ splits[ i ] ] = 1;

    if( !e.subject && !cui.currentOpeners )
    e.subject = './(.im|.ex|will)*';
  }
}

commandWillfileGet.defaults =
{
  verbosity : 3,
  v : 3,
};
commandWillfileGet.hint = 'Use "willfile get" to get value of separate properties of source willfile.';
commandWillfileGet.commandSubjectHint = 'A path to source willfile.';
commandWillfileGet.commandProperties =
{
  verbosity : 'Set verbosity. Default is 3.',
  v : 'Set verbosity. Default is 3.',
};

//

function commandWillfileSet( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut( e.propertiesMap, commandWillfileSet.defaults );
  e.propertiesMap = _.mapOnly( e.propertiesMap, commandWillfileSet.defaults );
  cui._command_pre( commandWillfileSet, arguments );

  if( !e.subject && !cui.currentOpeners )
  if( _.mapKeys( willfilePropertiesMap ).length >= 1 )
  e.subject = './(.im|.ex|will)*';

  if( e.subject )
  {
    let o =
    {
      request : e.subject,
      willfilePropertiesMap,
      ... e.propertiesMap,
    };
    return _.will.Module.prototype.willfileSetProperty.call( cui, o );
  }

  if( cui.currentOpeners )
  return cui._commandBuildLike
  ({
    event : e,
    name : 'willfile set',
    onEach : handleEach,
    commandRoutine : commandWillfileSet,
  });

  throw _.errBrief( 'Please, specify at least one option. Format: will .willfile.set about/name:name' );

  function handleEach( it )
  {
    let request = it.opener.commonPath;
    if( cui.fileProvider.isDir( request ) )
    request = cui.fileProvider.path.join( request, './.*' );

    return it.opener.openedModule.willfileSetProperty
    ({
      request,
      willfilePropertiesMap,
      ... e.propertiesMap,
    });
  }
}

commandWillfileSet.defaults =
{
  verbosity : 3,
  v : 3,
  structureParse : 0,
};
commandWillfileSet.hint = 'Use "willfile set" to set separate properties of destination willfile.';
commandWillfileSet.commandSubjectHint = 'A path to destination willfile.';
commandWillfileSet.commandProperties =
{
  structureParse : 'Enable parsing of property value. Default is 0.',
  verbosity : 'Set verbosity. Default is 3.',
  v : 'Set verbosity. Default is 3.',
};

//

function commandWillfileDel( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut( e.propertiesMap, commandWillfileGet.defaults );
  e.propertiesMap = _.mapOnly( e.propertiesMap, commandWillfileDel.defaults );
  cui._command_pre( commandWillfileExtend, arguments );

  if( !e.subject && !cui.currentOpeners )
  e.subject = './(.im|.ex|will)*';

  if( e.subject )
  subjectNormalize();

  if( _.mapKeys( willfilePropertiesMap ).length === 0 )
  willfilePropertiesMap = { about : 1, build : 1, path : 1, reflector : 1, step : 1, submodule : 1 };

  if( e.subject )
  {
    let o =
    {
      request : e.subject,
      willfilePropertiesMap,
      ... e.propertiesMap,
    };
    return _.will.Module.prototype.willfileDeleteProperty.call( cui, o );
  }

  if( cui.currentOpeners )
  return cui._commandBuildLike
  ({
    event : e,
    name : 'willfile del',
    onEach : handleEach,
    commandRoutine : commandWillfileDel,
  });

  function handleEach( it )
  {
    let request = it.opener.commonPath;
    if( cui.fileProvider.isDir( request ) )
    request = cui.fileProvider.path.join( request, './.*' );

    return it.opener.openedModule.willfileDeleteProperty
    ({
      request,
      willfilePropertiesMap,
      ... e.propertiesMap,
    });
  }

  /* */

  function subjectNormalize()
  {
    let subject = e.subject;
    let isolated = _.strIsolateLeftOrAll( e.subject, ' ' );
    if( cui.fileProvider.path.isGlob( isolated[ 0 ] ) )
    {
      e.subject = isolated[ 0 ];
    }
    else
    {
      let firstKey = isolated[ 0 ].split( '/' )[ 0 ];
      if( _.longHas( [ 'about', 'build', 'path', 'reflector', 'step', 'submodule' ], firstKey ) )
      e.subject = undefined;
      else
      e.subject = isolated[ 0 ];
    }

    let splits = subject.split( /\s+/ );
    let i = e.subject === undefined ? 0 : 1;
    for( ; i < splits.length ; i++ )
    willfilePropertiesMap[ splits[ i ] ] = 1;

    if( !e.subject && !cui.currentOpeners )
    e.subject = './(.im|.ex|will)*';
  }
}

commandWillfileDel.defaults =
{
  verbosity : 3,
  v : 3,
};
commandWillfileDel.hint = 'Use "willfile del" to delete separate properties of destination willfile.';
commandWillfileDel.commandSubjectHint = 'A path to source willfile.';
commandWillfileDel.commandProperties =
{
  verbosity : 'Set verbosity. Default is 3.',
  v : 'Set verbosity. Default is 3.',
};

//

function commandWillfileExtend( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut( e.propertiesMap, commandWillfileExtend.defaults );
  e.propertiesMap = _.mapOnly( e.propertiesMap, commandWillfileExtend.defaults );
  cui._command_pre( commandWillfileExtend, arguments );

  if( !e.subject && !cui.currentOpeners )
  e.subject = './(.im|.ex|will)*';

  if( e.subject )
  {
    let o =
    {
      request : e.subject,
      onProperty : _.mapExtend,
      willfilePropertiesMap,
      ... e.propertiesMap,
    };
    return _.will.Module.prototype.willfileExtendProperty.call( cui, o );
  }

  if( cui.currentOpeners )
  return cui._commandBuildLike
  ({
    event : e,
    name : 'willfile extend',
    onEach : handleEach,
    commandRoutine : commandWillfileExtend,
  });

  function handleEach( it )
  {
    let request = it.opener.commonPath;
    if( cui.fileProvider.isDir( request ) )
    request = cui.fileProvider.path.join( request, './.*' );

    return it.opener.openedModule.willfileExtendProperty
    ({
      request,
      onProperty : _.mapExtend,
      willfilePropertiesMap,
      ... e.propertiesMap,
    });
  }
}

commandWillfileExtend.defaults =
{
  verbosity : 3,
  v : 3,
  structureParse : 0,
};
commandWillfileExtend.hint = 'Use "willfile extend" to extend separate properties of destination willfile.';
commandWillfileExtend.commandSubjectHint = 'A path to destination willfile.';
commandWillfileExtend.commandProperties =
{
  structureParse : 'Enable parsing of property value. Default is 0.',
  verbosity : 'Set verbosity. Default is 3.',
  v : 'Set verbosity. Default is 3.',
};

//

function commandWillfileSupplement( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut( e.propertiesMap, commandWillfileSupplement.defaults );
  e.propertiesMap = _.mapOnly( e.propertiesMap, commandWillfileSupplement.defaults );
  cui._command_pre( commandWillfileSupplement, arguments );

  if( !e.subject && !cui.currentOpeners )
  e.subject = './(.im|.ex|will)*';

  if( e.subject )
  {
    let o =
    {
      request : e.subject,
      onProperty : _.mapSupplement,
      willfilePropertiesMap,
      ... e.propertiesMap,
    };
    return _.will.Module.prototype.willfileExtendProperty.call( cui, o );
  }

  if( cui.currentOpeners )
  return cui._commandBuildLike
  ({
    event : e,
    name : 'willfile extend',
    onEach : handleEach,
    commandRoutine : commandWillfileSupplement,
  });

  function handleEach( it )
  {
    let request = it.opener.commonPath;
    if( cui.fileProvider.isDir( request ) )
    request = cui.fileProvider.path.join( request, './.*' );

    return it.opener.openedModule.willfileExtendProperty
    ({
      request,
      onProperty : _.mapSupplement,
      willfilePropertiesMap,
      ... e.propertiesMap,
    });
  }
}

commandWillfileSupplement.defaults =
{
  verbosity : 3,
  v : 3,
  structureParse : 0,
};
commandWillfileSupplement.hint = 'Use "willfile supplement" to extend separate not existed properties of destination willfile.';
commandWillfileSupplement.commandSubjectHint = 'A path to destination willfile.';
commandWillfileSupplement.commandProperties = commandWillfileExtend.commandProperties;

//

function commandWillfileExtendWillfile( e )
{
  let cui = this;
  cui._command_pre( commandWillfileExtendWillfile, arguments );

  let o =
  {
    request : e.subject,
    onSection : _.mapExtend,
    ... e.propertiesMap,
  };
  return _.will.Module.prototype.willfileExtendWillfile.call( cui, o );
}

commandWillfileExtendWillfile.defaults =
{
  verbosity : 3,
  v : 3,
};
commandWillfileExtendWillfile.hint = 'Use "willfile extend willfile" to extend existing willfile by data from source configuration files.';
commandWillfileExtendWillfile.commandSubjectHint = 'The first argument declares path to destination willfile, others declares paths to source files. Could be a glob';
commandWillfileExtendWillfile.commandProperties =
{
  'about' : 'Enables extension of section "about". Default value is 1.',
  'build' : 'Enables extension of section "build". Default value is 1.',
  'path' : 'Enables extension of section "path". Default value is 1.',
  'reflector' : 'Enables extension of section "reflector". Default value is 1.',
  'step' : 'Enables extension of section "step". Default value is 1.',
  'submodule' : 'Enables extension of section "submodule". Default value is 1.',

  'author' : 'Enables extension of field "author" in section "about". Default value is 1.',
  'contributors' : 'Enables extension of field "contributors" in section "about". Default value is 1.',
  'description' : 'Enables extension of field "description" in section "about". Default value is 1.',
  'enabled' : 'Enables extension of field "enabled" in section "about". Default value is 1.',
  'interpreters' : 'Enables extension of field "interpreters" in section "about". Default value is 1.',
  'keywords' : 'Enables extension of field "keywords" in section "about". Default value is 1.',
  'license' : 'Enables extension of field "license" in section "about". Default value is 1.',
  'name' : 'Enables extension of field "name" in section "about". Default value is 1.',
  'npm.name' : 'Enables extension of field "npm.name" in section "about". Default value is 1.',
  'npm.scripts' : 'Enables extension of field "npm.scripts" in section "about". Default value is 1.',
  'version' : 'Enables extension of field "version" in section "about". Default value is 1.',

  'format' : 'Defines output format of config file: "willfile" - output file is willfile, "json" - output is NPM json file. Default value is "willfile".',
  'submodulesDisabling' : 'Disables new submodules from source files. Default value is 0.',
  'verbosity' : 'Set verbosity. Default is 3.',
  'v' : 'Set verbosity. Default is 3.',
}

//

function commandWillfileSupplementWillfile( e )
{
  let cui = this;
  cui._command_pre( commandWillfileSupplementWillfile, arguments );

  let o =
  {
    request : e.subject,
    onSection : _.mapSupplement,
    ... e.propertiesMap,
  };
  return _.will.Module.prototype.willfileExtendWillfile.call( cui, o );
}

commandWillfileSupplementWillfile.defaults =
{
  verbosity : 3,
  v : 3,
};
commandWillfileSupplementWillfile.hint = 'Use "willfile supplement willfile" to supplement existing willfile by new data from source configuration files.';
commandWillfileSupplementWillfile.commandSubjectHint = 'The first argument declares path to destination willfile, others declares paths to source files. Could be a glob';
commandWillfileSupplementWillfile.commandProperties = commandWillfileExtendWillfile.commandProperties;

//

function commandPackageInstall( e )
{
  let cui = this;

  let isolated = _.strIsolateLeftOrAll( e.commandArgument, ' ' );
  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  let options = e.propertiesMap = _.strStructureParse( isolated[ 2 ] );

  cui._command_pre( commandPackageInstall, arguments );

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

commandPackageInstall.hint = 'Use "package install" to install target package.';
commandPackageInstall.commandSubjectHint = 'A name or path to package.';
commandPackageInstall.commandProperties =
{
  sudo : 'Install package with privileges of superuser.',
  reinstall : 'Force package manager to reinstall the package.'
}

//

function commandPackageLocalVersions( e )
{
  let cui = this;
  let ready = new _.Consequence().take( null );

  let isolated = _.strIsolateLeftOrAll( e.commandArgument, ' ' );
  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  let options = e.propertiesMap = _.strStructureParse( isolated[ 2 ] );

  cui._command_pre( commandPackageLocalVersions, arguments );

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
      execPath,
      ready,
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
      execPath,
      ready,
      inputMirroring : 0
    }
    _.process.start( o );
  }

  function localVersionsDarwin()
  {
    let execPath = 'brew list --versions ' + parsed.longPath;
    let o =
    {
      execPath,
      ready,
      inputMirroring : 0
    }
    _.process.start( o );
  }

}

commandPackageLocalVersions.hint = 'Use "package local versions" to get list of package versions avaiable locally.';
commandPackageLocalVersions.commandSubjectHint = 'A name of package.';

//

function commandPackageRemoteVersions( e )
{
  let cui = this;
  let logger = cui.logger;
  let ready = new _.Consequence().take( null );

  let isolated = _.strIsolateLeftOrAll( e.commandArgument, ' ' );
  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  let options = e.propertiesMap = _.strStructureParse( isolated[ 2 ] );

  cui._command_pre( commandPackageRemoteVersions, arguments );

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
      execPath,
      ready,
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
      execPath,
      ready,
      inputMirroring : 0
    }
    _.process.start( o );
  }

  function remoteVersionsDarwin()
  {
    // Vova: lists only versions known for current version of brew
    let execPath = 'brew search ' + parsed.longPath;
    let o =
    {
      execPath,
      ready,
      inputMirroring : 0
    }
    _.process.start( o );
  }
}

commandPackageRemoteVersions.hint = 'Use "package remote versions" to get list of package versions avaiable in remote archive.';
commandPackageRemoteVersions.commandSubjectHint = 'A name of package.';
commandPackageRemoteVersions.commandProperties =
{
  all : 'Gets verions of package from remote archive.',
}

//

function commandPackageVersion( e )
{
  let cui = this;
  let ready = new _.Consequence().take( null );

  let isolated = _.strIsolateLeftOrAll( e.commandArgument, ' ' );
  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  let options = e.propertiesMap = _.strStructureParse( isolated[ 2 ] );

  cui._command_pre( commandPackageVersion, arguments );

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
      execPath,
      ready,
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
      execPath,
      ready,
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
      execPath,
      ready,
      inputMirroring : 0,
      throwingExitCode : 0
    }
    _.process.start( o );
  }
}

commandPackageVersion.hint = 'Use "package local version" to get version of installed package.';
commandPackageVersion.commandSubjectHint = 'A name of package.';

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
  implied : _.define.own( {} ),
}

let Statics =
{
  Exec,
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

  _command_pre,
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
  _commandModulesLike,

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

  commandSubmodulesShell,
  commandSubmodulesGit,
  commandSubmodulesGitPrOpen,
  commandSubmodulesGitSync,

  commandModuleNew,
  commandModuleNewWith,

  commandModulesShell,
  commandModulesGit,
  commandModulesGitPrOpen,
  commandModulesGitSync,

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

  commandGit,
  commandGitPrOpen,
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

  commandNpmFromWillfile,
  commandWillfileFromNpm,

  commandWillfileGet,
  commandWillfileSet,
  commandWillfileDel,
  commandWillfileExtend,
  commandWillfileSupplement,

  commandWillfileExtendWillfile,
  commandWillfileSupplementWillfile,
  /* aaa2 :
  will .willfile.extend dst/ src1 dir/src2 src/
  will .willfile.extend dst src1 dir/src2 src/
  will .willfile.extend dst 'src1/**' dir/src2 src/

  will .willfile.extend dst src submodules:1 npm.name:1, version:1 contributors:1 format:willfile

  algorithm similar to mapExtendAppending

  if anon then will.yml
  else then name.will.yml

  */

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
