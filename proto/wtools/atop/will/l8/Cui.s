( function _Cui_s_()
{

'use strict';

/**
 * @classdesc Class wWillCli implements command line interface of utility. Interface is a collection of routines to run specified commands.
 * @class wWillCli
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = _.Will;
const Self = wWillCli;
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

  let logger = will.transaction.logger;
  let fileProvider = will.fileProvider;
  let appArgs = _.process.input({ keyValDelimeter : 0 });
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
    /* aaa2 : make use of
    return ca.programPerform({ program : appArgs.original });

    - commands like .with and .imply should set some field
    - field set by .with should be reset to null after command which use the field
    - field set by .imply should not be reset to null after command which use the field, but should be reset to null bu another .imply command
    - we drop support of `.command1 ; .command2` syntax. we support only `.command1 .commadn2` syntax

    Dmytro : done
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
  will.will = will;

  // will[ currentOpenerSymbol ] = null;

  return Parent.prototype.init.apply( will, arguments );
}

//

function _openersCurrentEach( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.transaction.logger;
  let ready = _.take( null );

  // _.assert( will.currentOpener === null || will.currentOpeners === null );
  _.routineOptions( _openersCurrentEach, arguments );

  // if( will.currentOpener )
  // {
  //
  //   _.assert( will.currentOpeners === null );
  //   _.assert( will.currentOpener instanceof _.will.ModuleOpener );
  //
  //   let opener = will.currentOpener;
  //   let it = itFrom( opener );
  //   ready.then( () => o.onEach.call( will, it ) );
  //
  // }
  // else
  {

    // _.assert( will.currentOpener === null );
    _.assert( _.arrayIs( will.currentOpeners ) );

    for( let i = 0 ; i < will.currentOpeners.length ; i++ )
    {
      let it = itFrom( will.currentOpeners[ i ] );
      ready.then( () => o.onEach.call( will, it ) );
    }

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
  let logger = will.transaction.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routineOptions( openersFind, arguments );
  // _.assert( will.currentOpener === null );
  _.assert( will.currentOpeners === null );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( o.localPath === null )
  {
    _.assert( will.transaction instanceof _.will.Transaction );
    o.localPath = will.transaction.withPath || './';
  }

  if( o.tracing === null )
  o.tracing = !path.isGlob( o.localPath ) && path.isTrailed( o.localPath );

  let o2 = _.mapExtend( null, o );
  o2.selector = o.localPath;
  o2.atLeastOne = !path.isGlob( o.localPath );
  delete o2.localPath;
  delete o2.allowNoOpeners;

  return will.modulesFindWithAt( o2 )
  .finally( function( err, it )
  {

    if( err )
    debugger;
    if( err )
    throw _.err( err );

    // will.currentOpeners = it.openers;
    will.currentOpeners = it.sortedOpeners;

    if( !will.currentOpeners.length )
    {
      debugger;
      if( !o.allowNoOpeners )
      throw _.errBrief( `Found no willfile at ${path.resolve( o.localPath )}` );
      else
      will.currentOpeners = null;
    }

    return will.currentOpeners;
  })

}

openersFind.defaults =
{

  ... _.mapExtend( null, _.Will.prototype.modulesFindWithAt.defaults ),

  // localPath : './',
  localPath : null,
  // tracing : 1,
  tracing : null,

  allowNoOpeners : false

}

// //
//
// function currentOpenerChange( src )
// {
//   let will = this;
//
//   _.assert( src === null || src instanceof _.will.ModuleOpener );
//   _.assert( arguments.length === 1 );
//
//   if( src && will[ currentOpenerSymbol ] === src )
//   return src;
//
//   will[ currentOpenerSymbol ] = src;
//   // will.currentOpenerPath = null;
//
//   return src;
// }

// --
// etc
// --

function _command_head( o )
{
  let cui = this;

  if( arguments.length === 2 )
  o = { routine : arguments[ 0 ], args : arguments[ 1 ] }

  _.routineOptions( _command_head, o );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( o.args.length === 1 );

  let e = o.args[ 0 ];

  // yyy
  // if( o.propertiesMapAsProperty )
  // {
  //   let propertiesMap = Object.create( null );
  //   if( e.propertiesMap )
  //   propertiesMap[ o.propertiesMapAsProperty ] = e.propertiesMap;
  //   e.propertiesMap = propertiesMap;
  // }

  // if( cui.implied && o.usingImpliedMap )
  // {
  //   if( o.routine.defaults )
  //   _.mapExtend( e.propertiesMap, _.mapOnly_( null, cui.implied, o.routine.defaults ) );
  //   else
  //   _.mapExtend( e.propertiesMap, cui.implied );
  // }

  _.sure( _.mapIs( e.propertiesMap ), () => 'Expects map, but got ' + _.entity.exportStringShallow( e.propertiesMap ) );
  if( o.routine.command.properties )
  _.map.sureHasOnly( e.propertiesMap, o.routine.command.properties, `Command does not expect options:` );

  if( _.boolLikeFalse( o.routine.command.subjectHint ) )
  if( e.subject.trim() !== '' )
  throw _.errBrief
  (
    `Command .${e.phraseDescriptor.phrase} does not expect subject, but got "${e.subject}"` /* xxx : test */
  );

  /*
    Expected behavior of the _command_head
    - e.propertiesMap stays unchanged
    - Routine throws an error if propertiesMap contain unknown property and command does not expect it
    - Routine does not check propertiesMap if command does not have commandPropertiesMap
    - e.optionsMap contains properties of the command with applied defaults
    - e.implyMap contains properties for transaction object
    - e.implyMap properties priority:
      - Explicitly provided options from e.optionsMap
      - Explicitly provided options from cui.implied map
      - Command's defaults
      - Transaction defaults
    - Transaction object is not destroyed, but extended with properties from implyMap
    - Command without defaults reuses transaction object and should handle properties by itself
  */


  e.optionsMap = _.mapExtend( null, e.propertiesMap );

  if( cui.implied )
  _.mapSupplementNulls( e.optionsMap, cui.implied );

  if( o.routine.defaults )
  _.mapSupplementNulls( e.optionsMap, _.mapOnly_( null, o.routine.defaults, _.will.Transaction.TransactionFields ) );

  e.implyMap = _.mapOnly_( null, e.optionsMap, _.will.Transaction.TransactionFields );

  cui._transactionExtend( o.routine, e.implyMap );

  let copiedToTransaction = e.implyMap;
  if( o.routine.defaults )
  copiedToTransaction = _.mapBut_( e.implyMap, o.routine.defaults );

  e.optionsMap = _.mapBut_( null, e.optionsMap, copiedToTransaction );

  if( o.routine.defaults )
  _.routineOptions( o.routine, e.optionsMap );

  // if( o.routine.command.properties && o.routine.command.properties.v )
  /* aaa : for Dmytro : design good solution instead of this workaround. before implementing discuss! */ /* Dmytro : fixed, not me */
  // if( o.routine.command.properties && o.routine.command.properties.v )
  // if( e.propertiesMap.v !== undefined )
  // {
  //   e.propertiesMap.verbosity = e.propertiesMap.v;
  //   delete e.propertiesMap.v;
  // }
  /* Dmytro : it is not a solution, it is a temporary improvement */
  // if( o.routine.command.properties )
  // if( o.routine.command.properties.v )
  // {
  //   if( e.propertiesMap.v !== undefined )
  //   e.propertiesMap.verbosity = e.propertiesMap.v;

  //   if( e.propertiesMap.verbosity !== e.propertiesMap.v )
  //   e.propertiesMap.v = e.propertiesMap.verbosity;
  // }

}

_command_head.defaults =
{
  routine : null,
  args : null,
  // propertiesMapAsProperty : 0,
  // usingImpliedMap : 1
}

//

function errEncounter( error )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.transaction.logger;

  _.process.exitCode( -1 );
  logger.log( _.errOnce( error ) );

}

//

// function _propertiesImplyToMain( implyMap )
// {
//   let will = this;
//
//   _.assert( arguments.length === 1, 'Expects options map {-implyMap-}' );
//
//   let namesMap =
//   {
//     // v : 'verbosity',
//     // verbosity : 'verbosity',
//     // beeping : 'beeping',
//
//     // withOut : 'withOut',
//     // withIn : 'withIn',
//     // withEnabled : 'withEnabled',
//     // withDisabled : 'withDisabled',
//     // withValid : 'withValid',
//     // withInvalid : 'withInvalid',
//     // withSubmodules : 'withSubmodules',
//   };
//
//   _.process.inputReadTo
//   ({
//     dst : will,
//     propertiesMap : implyMap,
//     namesMap,
//     only : 0
//   });
// }

//

/* qqq : delete */
function _propertiesImply( implyMap )
{
  let cui = this;
  let transaction = cui.transaction;

  _.assert( 0, 'delete' );

  // cui._propertiesImplyToMain( implyMap );

  if( cui.transaction && cui.transaction.isInitial ) /* Vova : temporary, until transaction object will be moved out from main */
  {
    cui.transaction.finit();
    cui.transaction = null;
  }

  _.assert( cui.transaction === null, 'Transaction object was not removed by previous command.' );

  cui.transaction = _.will.Transaction.Make( implyMap, cui.logger );
}

//

function _transactionBegin( command, propertiesMap )
{
  let cui = this;
  let transaction = cui.transaction;

  _.assert
  (
    transaction === null || ( transaction && transaction.isInitial && !transaction.isFinited() ),
    'Problem with transaction.'
  );

  if( transaction && transaction.isInitial )
  {
    cui.transaction.finit();
    cui.transaction = null;
  }

  // let implyMap = _.mapOnly_( null, propertiesMap, cui.commandImply.defaults );
  cui.transaction = _.will.Transaction.Make( propertiesMap, cui.logger );

  return cui.transaction;
}

//

function _transactionExtend( command, propertiesMap )
{
  let cui = this;
  let transaction = cui.transaction;

  if( transaction === null )
  return cui._transactionBegin( command, propertiesMap );

  if( transaction && transaction.isInitial )
  return cui._transactionBegin( command, propertiesMap );

  // let implyMap = _.mapOnly_( null, propertiesMap, cui.commandImply.defaults );
  cui.transaction.extend( propertiesMap );

  return cui.transaction;
}

//

function beepingGet()
{
  let cui = this;
  let transaction = cui.transaction;
  _.assert( transaction instanceof _.will.Transaction );
  return transaction.beeping;
}

// --
// meta command
// --

function _commandsMake()
{
  let cui = this;
  let logger = cui.transaction.logger;
  let fileProvider = cui.fileProvider;
  let appArgs = _.process.input();

  _.assert( _.instanceIs( cui ) );
  _.assert( arguments.length === 0, 'Expects no arguments' );

  let commands =
  {

    'help' :                            { ro : _.routineJoin( cui, cui.commandHelp )                         },
    'imply' :                           { ro : _.routineJoin( cui, cui.commandImply )                        },
    'version' :                         { ro : _.routineJoin( cui, cui.commandVersion )                      },
    'version check' :                   { ro : _.routineJoin( cui, cui.commandVersionCheck )                 },
    'version bump' :                    { ro : _.routineJoin( cui, cui.commandVersionBump )                  },

    'modules list' :                    { ro : _.routineJoin( cui, cui.commandModulesList )                  },
    'modules topological list' :        { ro : _.routineJoin( cui, cui.commandModulesTopologicalList )       },
    'modules tree' :                    { ro : _.routineJoin( cui, cui.commandModulesTree )                  },
    'modules update' :                  { ro : _.routineJoin( cui, cui.commandModulesUpdate )                },
    'resources list' :                  { ro : _.routineJoin( cui, cui.commandResourcesList )                },
    'paths list' :                      { ro : _.routineJoin( cui, cui.commandPathsList )                    },
    'submodules list' :                 { ro : _.routineJoin( cui, cui.commandSubmodulesList )               },
    'reflectors list' :                 { ro : _.routineJoin( cui, cui.commandReflectorsList )               },
    'steps list' :                      { ro : _.routineJoin( cui, cui.commandStepsList )                    },
    'builds list' :                     { ro : _.routineJoin( cui, cui.commandBuildsList )                   },
    'exports list' :                    { ro : _.routineJoin( cui, cui.commandExportsList )                  },
    'about list' :                      { ro : _.routineJoin( cui, cui.commandAboutList )                    },
    'about' :                           { ro : _.routineJoin( cui, cui.commandAboutList )                    },

    'submodules clean' :                { ro : _.routineJoin( cui, cui.commandSubmodulesClean )              },
    'submodules add' :                  { ro : _.routineJoin( cui, cui.commandSubmodulesAdd )                },
    'submodules fixate' :               { ro : _.routineJoin( cui, cui.commandSubmodulesFixate )             },
    'submodules upgrade' :              { ro : _.routineJoin( cui, cui.commandSubmodulesUpgrade )            },

    'submodules download' :             { ro : _.routineJoin( cui, cui.commandSubmodulesVersionsDownload )   },
    'submodules update' :               { ro : _.routineJoin( cui, cui.commandSubmodulesVersionsUpdate )     },
    'submodules versions download' :    { ro : _.routineJoin( cui, cui.commandSubmodulesVersionsDownload )   },
    'submodules versions update' :      { ro : _.routineJoin( cui, cui.commandSubmodulesVersionsUpdate )     },
    'submodules versions verify' :      { ro : _.routineJoin( cui, cui.commandSubmodulesVersionsVerify )     },
    'submodules versions agree' :       { ro : _.routineJoin( cui, cui.commandSubmodulesVersionsAgree )      },
    'submodules shell' :                { ro : _.routineJoin( cui, cui.commandSubmodulesShell )              },
    'submodules git' :                  { ro : _.routineJoin( cui, cui.commandSubmodulesGit )                },
    'submodules git diff' :             { ro : _.routineJoin( cui, cui.commandSubmodulesGitDiff )            },
    'submodules repo pull open' :       { ro : _.routineJoin( cui, cui.commandSubmodulesRepoPullOpen )          },
    'submodules git status' :           { ro : _.routineJoin( cui, cui.commandSubmodulesGitStatus )          },
    'submodules git sync' :             { ro : _.routineJoin( cui, cui.commandSubmodulesGitSync )            },

    'shell' :                           { ro : _.routineJoin( cui, cui.commandShell )                        },
    'do' :                              { ro : _.routineJoin( cui, cui.commandDo )                           },
    'call' :                            { ro : _.routineJoin( cui, cui.commandHookCall )                     },
    'hook call' :                       { ro : _.routineJoin( cui, cui.commandHookCall )                     },
    'hooks list' :                      { ro : _.routineJoin( cui, cui.commandHooksList )                    },
    'clean' :                           { ro : _.routineJoin( cui, cui.commandClean )                        },
    'build' :                           { ro : _.routineJoin( cui, cui.commandBuild )                        },
    'export' :                          { ro : _.routineJoin( cui, cui.commandExport )                       },
    'export purging' :                  { ro : _.routineJoin( cui, cui.commandExportPurging )                },
    'export recursive' :                { ro : _.routineJoin( cui, cui.commandExportRecursive )              },

    'module new' :                      { ro : _.routineJoin( cui, cui.commandModuleNew )                    },
    'module new with' :                 { ro : _.routineJoin( cui, cui.commandModuleNewWith )                },
    'modules shell' :                   { ro : _.routineJoin( cui, cui.commandModulesShell )                 },
    'modules git' :                     { ro : _.routineJoin( cui, cui.commandModulesGit )                   },
    'modules git diff' :                { ro : _.routineJoin( cui, cui.commandModulesGitDiff )               },
    'modules repo pull open' :          { ro : _.routineJoin( cui, cui.commandModulesRepoPullOpen )             },
    'modules git status' :              { ro : _.routineJoin( cui, cui.commandModulesGitStatus )             },
    'modules git sync' :                { ro : _.routineJoin( cui, cui.commandModulesGitSync )               },

    'with' :                            { ro : _.routineJoin( cui, cui.commandWith )                         },
    'modules' :                         { ro : _.routineJoin( cui, cui.commandModules )                         },
    'submodules' :                      { ro : _.routineJoin( cui, cui.commandSubmodules )                         },
    'each' :                            { ro : _.routineJoin( cui, cui.commandEach )                         },

    'npm from willfile' :               { ro : _.routineJoin( cui, cui.commandNpmFromWillfile )              },
    'willfile from npm' :               { ro : _.routineJoin( cui, cui.commandWillfileFromNpm )              },
    'willfile get' :                    { ro : _.routineJoin( cui, cui.commandWillfileGet )                  },
    'willfile set' :                    { ro : _.routineJoin( cui, cui.commandWillfileSet )                  },
    'willfile del' :                    { ro : _.routineJoin( cui, cui.commandWillfileDel )                  },
    'willfile extend' :                 { ro : _.routineJoin( cui, cui.commandWillfileExtend )               },
    'willfile supplement' :             { ro : _.routineJoin( cui, cui.commandWillfileSupplement )           },
    'willfile extend willfile' :        { ro : _.routineJoin( cui, cui.commandWillfileExtendWillfile )       },
    'willfile supplement willfile' :    { ro : _.routineJoin( cui, cui.commandWillfileSupplementWillfile )   },
    'willfile merge into single' :      { ro : _.routineJoin( cui, cui.commandWillfileMergeIntoSingle )      },

    'git' :                             { ro : _.routineJoin( cui, cui.commandGit )                          },
    'git diff' :                        { ro : _.routineJoin( cui, cui.commandGitDiff )                      },
    'git pull' :                        { ro : _.routineJoin( cui, cui.commandGitPull )                      },
    'git push' :                        { ro : _.routineJoin( cui, cui.commandGitPush )                      },
    'git reset' :                       { ro : _.routineJoin( cui, cui.commandGitReset )                     },
    'git status' :                      { ro : _.routineJoin( cui, cui.commandGitStatus )                    },
    'git sync' :                        { ro : _.routineJoin( cui, cui.commandGitSync )                      },
    'git tag' :                         { ro : _.routineJoin( cui, cui.commandGitTag )                       },
    'git hook preserving hardlinks' :   { ro : _.routineJoin( cui, cui.commandGitHookPreservingHardLinks )   },

    'repo pull open' :                  { ro : _.routineJoin( cui, cui.commandRepoPullOpen )                 },
    'repo pull list' :                  { ro : _.routineJoin( cui, cui.commandRepoPullList )                 },
    'repo program list' :               { ro : _.routineJoin( cui, cui.commandRepoProgramList )              },
    'repo program process list' :       { ro : _.routineJoin( cui, cui.commandRepoProgramProcessList )       },

    'npm publish' :                     { ro : _.routineJoin( cui, cui.commandNpmPublish )                   },
    'npm dep add' :                     { ro : _.routineJoin( cui, cui.commandNpmDepAdd )                    },
    'npm install' :                     { ro : _.routineJoin( cui, cui.commandNpmInstall )                   },
    'npm clean' :                       { ro : _.routineJoin( cui, cui.commandNpmClean )                     },

    'package install' :                 { ro : _.routineJoin( cui, cui.commandPackageInstall )               },
    'package local versions' :          { ro : _.routineJoin( cui, cui.commandPackageLocalVersions )         },
    'package remote versions' :         { ro : _.routineJoin( cui, cui.commandPackageRemoteVersions )        },
    'package version' :                 { ro : _.routineJoin( cui, cui.commandPackageVersion )               },

  }

  let ca = _.CommandsAggregator
  ({
    basePath : fileProvider.path.current(),
    commands,
    commandPrefix : 'node ',
    logger : cui.logger,
    commandsImplicitDelimiting : 1,
  })

  _.assert( ca.logger === cui.logger );
  _.assert( ca.logger.verbosity === cui.verbosity );

  ca.form();

  return ca;
}

//

function _commandsBegin( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.transaction.logger;

  _.routineOptions( _commandsBegin, o );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.aux.is( o.properties ) );

  if( will.topCommand === null )
  will.topCommand = o.commandRoutine;

  _.assert( will.transaction instanceof _.will.Transaction )

}

_commandsBegin.defaults =
{
  commandRoutine : null,
  properties : null,
}

//

function _commandsEnd( command )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.transaction.logger;

  _.assert( will.transaction instanceof _.will.Transaction );
  _.assert( _.routineIs( command ) );

  let beeping = will.transaction.beeping;

  if( will.topCommand !== command )
  {
    // will.transaction.finit();
    // will.transaction = null;
    return false;
  }

  try
  {

    will.topCommand = null;

    // if( will.currentOpener )
    // will.currentOpener.finit();
    // will.currentOpenerChange( null );

    if( will.currentOpeners )
    will.currentOpeners.forEach( ( opener ) => opener.isFinited() ? null : opener.finit() );
    will.currentOpeners = null;
    // will.transaction.finit();
    // will.transaction = null;
    if( beeping )
    _.diagnosticBeep();
    _.procedure.terminationBegin();

  }
  catch( err )
  {
    will.errEncounter( err );
    will.currentOpeners = null;
    // will.currentOpenerChange( null );
    if( beeping )
    _.diagnosticBeep();
    _.process.exit( -1 );
  }

  return true;
}

//

function _commandListLike( o )
{
  let will = this;
  let logger = will.transaction.logger;
  let ready = _.take( null );
  let e = o.event;

  _.assert( arguments.length === 1 );
  _.routineOptions( _commandListLike, arguments );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onEach ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );
  _.assert( o.resourceKind !== undefined );

  will._commandsBegin({ commandRoutine : o.commandRoutine, properties : o.event.propertiesMap });

  // if( will.currentOpeners === null && will.currentOpener === null )
  if( will.currentOpeners === null )
  ready.then( () => will.openersFind() );

  ready
  .then( () => will.openersCurrentEach( function( it )
  {
    let ready2 = _.take( null );

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
        e.request = _.will.resolver.Resolver.strRequestParse( e.instructionArgument );

        if( _.will.resolver.Resolver.selectorIs( e.request.subject ) )
        {
          let splits = _.will.resolver.Resolver.selectorShortSplit
          ({
            selector : e.request.subject,
            defaultResourceKind : o.resourceKind,
          });
          o.resourceKind = splits[ 0 ];
          resourceKindIsGlob = _.path.isGlob( o.resourceKind );
        }

        if( resourceKindIsGlob && e.request.subject && !_.will.resolver.Resolver.selectorIs( e.request.subject ) )
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
  let logger = will.transaction.logger;
  let ready = _.take( null );

  _.routineOptions( _commandBuildLike, arguments );
  _.mapSupplementNulls( o, will.filterImplied() );
  _.mapSupplementNulls( o, _.Will.ModuleFilterDefaults );

  _.all
  (
    _.Will.ModuleFilterNulls,
    ( e, k ) => _.assert( _.boolLike( o[ k ] ), `Expects bool-like ${k}, but it is ${_.entity.strType( k )}` )
  );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onEach ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  will._commandsBegin({ commandRoutine : o.commandRoutine, properties : o.event.propertiesMap });

  // if( will.currentOpeners === null && will.currentOpener === null )
  if( will.currentOpeners === null )
  ready.then( () => will.openersFind() );

  ready
  .then( () => filter() )

  .then( () => will.openersCurrentEach( forSingle ) )
  .finally( end );

  return ready;

  /* */

  function filter()
  {
    if( will.currentOpeners )
    {
      let openers2 = will.modulesFilter( will.currentOpeners, _.mapOnly_( null, o, will.modulesFilter.defaults ) );
      if( openers2.length )
      will.currentOpeners = openers2;
    }
    return null;
  }

  /* */

  function forSingle( it )
  {
    let ready2 = _.take( null );
    let it2 = _.mapExtend( null, o, it );

    ready2.then( () =>
    {
      will.mainOpener = it.opener;
      return null;
      // return will.currentOpenerChange( it.opener );
    });

    ready2.then( () =>
    {
      will.readingEnd();
      return o.onEach.call( will, it2 );
    });

    ready2.finally( ( err, arg ) =>
    {
      // will.currentOpenerChange( null );
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
  let logger = will.transaction.logger;
  let ready = _.take( null );

  _.routineOptions( _commandCleanLike, arguments );
  _.mapSupplementNulls( o, will.filterImplied() );
  _.mapSupplementNulls( o, _.Will.ModuleFilterDefaults );
  _.all
  (
    _.Will.ModuleFilterNulls,
    ( e, k ) => _.assert( _.boolLike( o[ k ] ), `Expects bool-like ${k}, but it is ${_.entity.strType( k )}` )
  );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onAll ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  will._commandsBegin({ commandRoutine : o.commandRoutine, properties : o.event.propertiesMap });

  // if( will.currentOpeners === null && will.currentOpener === null )
  if( will.currentOpeners === null )
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

    let openers2 = will.modulesFilter( will.currentOpeners, _.mapOnly_( null, o, will.modulesFilter.defaults ) );
    if( openers2.length )
    will.currentOpeners = openers2;

    return null;
  }

  /* */

  function forAll()
  {
    let ready2 = _.take( null );
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
  let logger = will.transaction.logger;
  let ready = _.take( null );

  _.routineOptions( _commandNewLike, arguments );
  _.mapSupplementNulls( o, will.filterImplied() );

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

  will._commandsBegin({ commandRoutine : o.commandRoutine, properties : o.event.propertiesMap });

  // if( will.currentOpeners !== null || will.currentOpener !== null )
  if( will.currentOpeners !== null )
  throw _.errBrief( 'Cant call command new for module which already exists!' );

  let localPath = will.moduleNew({ collision : 'ignore', localPath : will.transaction.withPath });
  let o2 = _.mapExtend( null, o );
  o2.localPath = localPath;
  o2.tracing = 0;

  ready.then( () => will.openersFind( _.mapOnly_( null, o2, will.openersFind.defaults ) ) );
  ready.then( () => will.openersCurrentEach( forSingle ) );
  ready.finally( end );

  return ready;

  /* */

  function forSingle( it )
  {
    let ready2 = _.take( null );
    let it2 = _.mapExtend( null, o, it );

    ready2.then( () =>
    {
      will.mainOpener = it.opener;
      return null;
      // return will.currentOpenerChange( it.opener );
    });

    ready2.then( () =>
    {
      will.readingEnd();
      _.assert( it2.opener.localPath === will.transaction.withPath );
      return o.onEach.call( will, it2 );
    });

    ready2.finally( ( err, arg ) =>
    {
      // will.currentOpenerChange( null );
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
defaults.allowNoOpeners = null;

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
  let logger = will.transaction.logger;
  let ready = _.take( null );

  _.routineOptions( _commandTreeLike, arguments );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onAll ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  will._commandsBegin({ commandRoutine : o.commandRoutine, properties : o.event.propertiesMap });

  // _.assert( will.currentOpener === null );
  if( will.currentOpeners === null )
  ready.then( () => will.openersFind() );

  ready.then( () =>
  {
    let ready2 = _.take( null );

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
  let will = this;
  let logger = will.transaction.logger;
  let ready = _.take( null );

  _.routineOptions( _commandModulesLike, arguments );
  _.mapSupplementNulls( o, will.filterImplied() );
  _.mapSupplementNulls( o, _.Will.ModuleFilterDefaults );

  _.all
  (
    _.Will.ModuleFilterNulls,
    ( e, k ) => _.assert( _.boolLike( o[ k ] ), `Expects bool-like ${k}, but it is ${_.entity.strType( k )}` )
  );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.routineIs( o.onEach ) );
  _.assert( o.onModulesBegin === null || _.routineIs( o.onModulesBegin ) );
  _.assert( o.onModulesEnd === null || _.routineIs( o.onModulesEnd ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  will._commandsBegin({ commandRoutine : o.commandRoutine, properties : o.event.propertiesMap });

  // if( will.currentOpeners === null && will.currentOpener === null )
  if( will.currentOpeners === null )
  ready.then( () => will.openersFind() )
  .then( () => filter() );

  let openers = will.currentOpeners;
  will.currentOpeners = null;

  for( let i = 0 ; i < openers.length ; i++ )
  ready.then( () => openersEach( openers[ i ] ) );

  return ready.finally( ( err, arg ) =>
  {
    will.currentOpeners = openers;
    will._commandsEnd( o.commandRoutine );
    if( err )
    logger.error( _.errOnce( err ) );
    if( err )
    throw err;
    return arg;
  })

  /* */

  function filter()
  {
    if( will.currentOpeners )
    {
      let openers2 = will.modulesFilter( will.currentOpeners, _.mapOnly_( null, o, will.modulesFilter.defaults ) );
      if( openers2.length )
      will.currentOpeners = openers2;
    }
    return null;
  }

  /* */

  function openersEach( opener )
  {
    let ready2 = will.modulesFindEachAt
    ({
      selector : _.strUnquote( 'submodule::*' ),
      currentOpener : opener,
    })
    .then( function( it )
    {
      if( o.withStem )
      _.arrayPrependOnce( it.sortedOpeners, opener );
      else
      _.arrayRemove( it.sortedOpeners, opener );

      will.currentOpeners = it.sortedOpeners;
      return it;
    })

    if( o.onModulesBegin )
    ready2.then( () =>
    {
      o.onModulesBegin.call( will, will.currentOpeners, opener );
      return null;
    });

    ready2.then( () => will.openersCurrentEach( forSingle ) )

    if( o.onModulesEnd )
    ready2.finally( ( err, arg ) =>
    {
      o.onModulesEnd.call( will, will.currentOpeners, opener );

      if( err )
      throw _.err( err );

      return null;
    });

    return ready2;
  }

  /* */

  function forSingle( it )
  {
    let ready3 = _.take( null );
    let it2 = _.mapExtend( null, o, it );

    ready3.then( () =>
    {
      will.mainOpener = it.opener;
      return null;
      // return will.currentOpenerChange( it.opener );
    });

    ready3.then( () =>
    {
      will.readingEnd();
      return o.onEach.call( will, it2 );
    });

    ready3.finally( ( err, arg ) =>
    {
      // will.currentOpenerChange( null );
      if( err )
      throw _.err( err, `\nFailed to ${o.name} at ${it.opener ? it.opener.commonPath : ''}` );
      return arg;
    });

    return ready3;
  }

}

/* qqq : for Dmytro : bad : discuss modulesFor */
var defaults = _commandModulesLike.defaults = _.mapExtend( null, _.Will.ModuleFilterNulls );
defaults.event = null;
defaults.onEach = null;
defaults.onModulesBegin = null;
defaults.onModulesEnd = null;
defaults.commandRoutine = null;
defaults.name = null;
defaults.withStem = 1; /* qqq : for Dmytro : ?? */

//

function openersFindMaybe( o )
{
  let cui = this;
  let path = cui.fileProvider.path;

  _.assert( arguments.length === 1 );

  if( cui.currentOpeners )
  {
    if( !o.reload )
    return null;

    cui.currentOpeners.forEach( ( opener ) => opener.isFinited() ? null : opener.finit() );
    cui.currentOpeners = null;
  }

  return cui.openersFind
  ({
    localPath : o.localPath
  })
}

//

function _commandModuleOrientedLike( o )
{
  let will = this;
  let ready = _.take( null );

  _.routineOptions( _commandModuleOrientedLike, arguments );
  _.mapSupplementNulls( o, will.filterImplied() );
  _.mapSupplementNulls( o, _.Will.ModuleFilterDefaults );

  _.all
  (
    _.Will.ModuleFilterNulls,
    ( e, k ) => _.assert( _.boolLike( o[ k ] ), `Expects bool-like ${k}, but it is ${_.entity.strType( k )}` )
  );
  _.assert( _.routineIs( o.commandRoutine ) );
  _.assert( _.strIs( o.name ) );
  _.assert( _.objectIs( o.event ) );

  will._commandsBegin({ commandRoutine : o.commandRoutine, properties : o.event.propertiesMap });

  let modulesDepth = will.transaction.modulesDepth;

  if( o.withStem === null )
  o.withStem = modulesDepth[ 0 ] === 0;

  // if( will.currentOpeners === null )
  // ready.then( () => will.openersFind() )

  let reload = will.transaction.wasFilterFieldsChanged( will.transactionOld );

  ready.then( () => will.openersFindMaybe({ localPath : will.transaction.withPath, reload : reload }) )

  if( reload )
  ready.then( () => will.modulesUpform({ modules : will.currentOpeners, recursive : modulesDepth[ 0 ] }) )

  ready.then( () =>
  {

    let openers = will.currentOpeners;
    let o2 = _.mapOnly_( null, o, will.modulesFor.defaults );
    o2.modules = openers;
    o2.recursive = 2;
    return will.modulesFor( o2 )
    .finally( ( err, arg ) =>
    {
      will._commandsEnd( o.commandRoutine );
      if( err )
      throw _.err( err, `\nFailed to ${o.name}` );
      return arg;
    });
  })

  return ready;
}

/* qqq : for Dmytro : bad : discuss modulesFor */
var defaults = _commandModuleOrientedLike.defaults =
{
  ... Parent.prototype.modulesFor.defaults,
  withPeers : 0,
  // withStem : 1,
  withStem : null,
  event : null,
  commandRoutine : null,
  name : null,
}

// --
// command
// --

function commandHelp( e )
{
  let cui = this;
  let ca = e.aggregator;
  cui._command_head( commandHelp, arguments );

  ca._commandHelp( e );
}

var command = commandHelp.command = Object.create( null );
command.hint = 'Get help.';
command.subjectHint = 'A command name to get detailed help for specific command.';

//

function commandImply( e )
{
  let cui = this;

  let impliedPrev = cui.implied;

  cui.implied = null;
  cui._command_head( commandImply, arguments );

  cui.implied = e.propertiesMap;

  if( impliedPrev && impliedPrev.withPath )
  if( cui.implied.withPath === null || cui.implied.withPath === undefined )
  cui.implied.withPath = impliedPrev.withPath;

}

commandImply.defaults =
{
  verbosity : 3,
  beeping : null,
  withOut : null,
  withIn : 1,
  withEnabled : null,
  withEnabledModules : null,
  withEnabledSubmodules : null,
  withDisabled : null,
  withDisabledModules : null,
  withDisabledSubmodules : null,
  withValid : null,
  withInvalid : null,
  withSubmodules : null,
  withPath : null,
  willFileAdapting : null
};

var command = commandImply.command = Object.create( null );
command.hint = 'Change state or imply value of a variable.';
command.subjectHint = false;
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  verbosity : 'Set verbosity. Default is 3.',
  beeping : 'Make noise when it\'s done. Default is 0.',
  withOut : 'Include out modules. Default is 1.',
  withIn : 'Include in modules. Default is 1.',
  withEnabled : 'Include enabled modules. Default is 1.',
  withEnabledModules : 'Include enabled modules. Default is 1.',
  withEnabledSubmodules : 'Include enabled submodules. Default is 1.',
  withDisabled : 'Include disabled modules. Default is 0.',
  withDisabledModules : 'Include disabled modules. Default is 0.',
  withDisabledSubmodules : 'Include disabled submodules. Default is 0.',
  withValid : 'Include valid modules. Default is 1.',
  withInvalid : 'Include invalid modules. Default is 1.',
  withSubmodules : 'Opening submodules. 0 - not opening, 1 - opening immediate children, 2 - opening all descendants recursively. Default : depends.',
  withPath : 'A module selector.',
  recursive : 'Recursive action for modules. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:0.',
  dirPath : 'Path to local directory. Default is directory of current module.',
  dry : 'Dry run without resetting. Default is dry:0.',
  willFileAdapting : 'Try to adapt will files from old versions of willbe. Default is 0.'
};

// function commandImply( e )
// {
//   let will = this;
//   let ca = e.aggregator;
//   let logger = will.logger;
//   let isolated = ca.instructionIsolateSecondFromArgument( e.instructionArgument );
//   _.assert( !!isolated );
//
//   let request = _.will.resolver.Resolver.strRequestParse( isolated.instructionArgument );
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
//   // _.process.inputReadTo
//   // ({
//   //   dst : will,
//   //   propertiesMap : request.map,
//   //   namesMap : namesMap,
//   // });
//
//   if( isolated.secondInstruction )
//   return ca.instructionPerform
//   ({
//     command : isolated.secondInstruction,
//   });
//
// }

//

function commandVersion( e )
{
  let cui = this;
  cui._command_head( commandVersion, arguments );

  return _.npm.versionLog
  ({
    localPath : _.path.join( __dirname, '../../../../..' ),
    remotePath : 'willbe',
  });
}

var command = commandVersion.command = Object.create( null );
command.hint = 'Get information about version.';
command.subjectHint = false;

//

function commandVersionCheck( e )
{
  let cui = this;

  cui._command_head( commandVersion, arguments );

  return cui.versionIsUpToDate( e.optionsMap );
}

commandVersionCheck.defaults =
{
  throwing : 1
}
var command = commandVersionCheck.command = Object.create( null );
command.hint = 'Check if current version of willbe is the latest.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  throwing : 'Throw an error if utility is not up to date. Default : 1.',
  ... commandImply.command.properties,
};

//

function commandVersionBump( e )
{
  let cui = this;

  cui._command_head( commandVersionBump, arguments );
  let properties = e.optionsMap;

  if( e.subject )
  properties.versionDelta = e.subject;

  if( _.numberIs( properties.versionDelta ) && !_.intIs( properties.versionDelta ) )
  properties.versionDelta = _.entity.exportString( properties.versionDelta );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'version bump',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandVersionBump,
  });

  function handleEach( module )
  {
    return module.willfileVersionBump( properties );
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.willfileVersionBump( properties );
  // }
}

commandVersionBump.defaults =
{
  verbosity : 3,
  versionDelta : 1
};

var command = commandVersionBump.command = Object.create( null );
command.hint = 'Increase version in willfile on specified delta.';
command.longHint = 'Increase version in willfile on specified delta.\n\t"will .version.bump 0.1.0" - add 1 to minor version of module.\n';
command.subjectHint = 'A string in format "x.x.x" that declares delta for each version.';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  versionDelta : 'A string in format "x.x.x" that defines delta for version.',
  verbosity : 'Set verbosity. Default is 3.',
};


//

function commandResourcesList( e )
{
  let cui = this;
  cui._command_head( commandResourcesList, arguments );

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
    let logger = cui.transaction.logger;

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

var command = commandResourcesList.command = Object.create( null );
command.hint = 'List information about resources of the current module.';
command.subjectHint = 'A selector for resources. Could be a glob.';

//

function commandPathsList( e )
{
  let cui = this;
  cui._command_head( commandPathsList, arguments );

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
    let logger = cui.transaction.logger;
    logger.log( module.openedModule.infoExportPaths( resources ) );
  }

}

var command = commandPathsList.command = Object.create( null );
command.hint = 'List paths of the current module.';
command.subjectHint = 'A selector for paths. Could be a glob.';

//

function commandSubmodulesList( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesList, arguments );

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
    let logger = cui.transaction.logger;
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
  }

}

var command = commandSubmodulesList.command = Object.create( null );
command.hint = 'List submodules of the current module.';
command.subjectHint = 'A selector for submodules. Could be a glob.';

//

function commandReflectorsList( e )
{
  let cui = this;
  cui._command_head( commandReflectorsList, arguments );

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
    let logger = cui.transaction.logger;
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
  }

}

var command = commandReflectorsList.command = Object.create( null );
command.hint = 'List available reflectors of the current module.';
command.subjectHint = 'A selector for reflectors. Could be a glob.';

//

function commandStepsList( e )
{
  let cui = this;
  cui._command_head( commandStepsList, arguments );

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
    let logger = cui.transaction.logger;
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
  }

}

var command = commandStepsList.command = Object.create( null );
command.hint = 'List available steps of the current module.';
command.subjectHint = 'A selector for steps. Could be a glob.';

//

function commandBuildsList( e )
{
  let cui = this;
  cui._command_head( commandBuildsList, arguments );

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
    let logger = cui.transaction.logger;
    let request = _.will.resolver.Resolver.strRequestParse( e.instructionArgument );
    let builds = module.openedModule.buildsResolve
    ({
      name : request.subject,
      criterion : request.map,
      preffering : 'more',
    });
    logger.log( module.openedModule.resourcesExportInfo( builds ) );
  }

}

var command = commandBuildsList.command = Object.create( null );
command.hint = 'List available builds of the current module.';
command.subjectHint = 'A selector for builds. Could be a glob.';

//

function commandExportsList( e )
{
  let cui = this;
  cui._command_head( commandExportsList, arguments );

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
    let logger = cui.transaction.logger;
    let request = _.will.resolver.Resolver.strRequestParse( e.instructionArgument );
    let builds = module.openedModule.exportsResolve
    ({
      name : request.subject,
      criterion : request.map,
      preffering : 'more',
    });
    logger.log( module.openedModule.resourcesExportInfo( builds ) );
  }

}

var command = commandExportsList.command = Object.create( null );
command.hint = 'List available exports of the current module.';
command.subjectHint = 'A selector for exports. Could be a glob.';

//

function commandAboutList( e )
{
  let cui = this;
  cui._command_head( commandAboutList, arguments );

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
    let logger = cui.transaction.logger;
    logger.log( _.color.strFormat( 'About', 'highlighted' ) );
    logger.log( module.openedModule.about.exportString() );
  }

}

var command = commandAboutList.command = Object.create( null );
command.hint = 'List descriptive information about the current module.';
command.subjectHint = false;

//

function commandModulesList( e )
{
  let cui = this;
  cui._command_head( commandModulesList, arguments );

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
    let logger = cui.transaction.logger;
    logger.log( module.openedModule.resourcesExportInfo( resources ) );
  }

}

var command = commandModulesList.command = Object.create( null );
command.hint = 'List all modules.';
command.subjectHint = false;

//

function commandModulesTopologicalList( e )
{
  let cui = this;
  cui._command_head( commandModulesTopologicalList, arguments );

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
    let logger = cui.transaction.logger;
    logger.log( module.openedModule.infoExportModulesTopological( resources ) );
  }

}

var command = commandModulesTopologicalList.command = Object.create( null );
command.hint = 'List all modules topologically.';
command.subjectHint = false;

//

function commandModulesTree( e )
{
  let cui = this;
  cui._command_head( commandModulesTree, arguments );

  return cui._commandTreeLike
  ({
    event : e,
    name : 'list tree of modules',
    onAll : handleAll,
    commandRoutine : commandModulesTree,
  });

  function handleAll( it )
  {
    let logger = cui.transaction.logger;
    let modules = it.modules;
    /* filtering was done earlier */
    e.optionsMap.onlyRoots = 0;
    logger.log( cui.graphExportTreeInfo( modules, e.optionsMap ) );
    return null;
  }

}

commandModulesTree.defaults =
{
  withLocalPath : 0,
  withRemotePath : 0
};

var command = commandModulesTree.command = Object.create( null );
command.hint = 'List all found modules as a tree.';
command.subjectHint = 'A selector for path names. Could be a glob.';
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  withLocalPath : 'Print local paths. Default is 0',
  withRemotePath : 'Print remote paths. Default is 0',
  ... commandImply.command.properties,
}

//

function commandModulesUpdate( e )
{
  let cui = this;
  cui._command_head( commandModulesUpdate, arguments );

  return cui._commandBuildLike
  ({
    event : e,
    name : 'update modules',
    onEach : handleEach,
    commandRoutine : commandModulesUpdate,
  });

  function handleEach( it )
  {
    let con = _.take( null );

    con.then( () =>
    {
      if( e.optionsMap.to )
      it.opener.remotePathChangeVersionTo( e.optionsMap.to );

      let o2 = _.mapOnly_( null, e.optionsMap, it.opener.repoUpdate.defaults );
      o2.strict = 0;
      return it.opener.repoUpdate( o2 );
    })

    con.then( () =>
    {
      let o2 = cui.filterImplied();
      o2 = _.mapExtend( o2, e.optionsMap );
      delete o2.withSubmodules;
      return it.opener.openedModule.subModulesUpdate( o2 );
    })

    return con;
  }
}

commandModulesUpdate.defaults =
{
  withSubmodules : 1,

  dry : 0,
  recursive : 1,
  to : null,
}

var command = commandModulesUpdate.command = Object.create( null );
command.hint = 'Update root module and each submodule.';
command.longHint = 'Update root and each submodule or check for available updates for root module and each submodule. Does nothing if all submodules have fixated version.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  to : 'Checkouts root and it submodules to specified version/tag.',
  ... commandImply.command.properties,
}

//

function commandSubmodulesAdd( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesAdd, arguments );

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
      selector : e.instructionArgument,
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
      // if( cui.verbosity >= 2 )
      if( cui.transaction.verbosity >= 2 )
      logger.log( `Added ${added} submodules to ${module.nameWithLocationGet()}` )
      return added;
    })

    return found;
  }

}

var command = commandSubmodulesAdd.command = Object.create( null );
command.hint = 'Add submodules.';
command.subjectHint = 'A selector ( path ) for module that will be included in module.';

//

function commandSubmodulesFixate( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesFixate, arguments );

  e.optionsMap.reportingNegative = e.optionsMap.negative;
  e.optionsMap.upgrading = 0;
  delete e.optionsMap.negative;

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
    return it.opener.openedModule.submodulesFixate( _.mapExtend( null, e.optionsMap ) );
  }

}

commandSubmodulesFixate.defaults =
{
  dry : 0,
  negative : 0,
  recursive : null
}

var command = commandSubmodulesFixate.command = Object.create( null );
command.hint = 'Fixate remote submodules.';
command.longHint = 'Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  negative : 'Reporting attempt of fixation with negative outcome. Default is negative:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.command.properties,
}

//

function commandSubmodulesUpgrade( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesUpgrade, arguments );

  e.optionsMap.upgrading = 1;
  e.optionsMap.reportingNegative = e.optionsMap.negative;
  delete e.optionsMap.negative;

  return cui._commandBuildLike
  ({
    event : e,
    name : 'upgrade submodules',
    onEach : handleEach,
    commandRoutine : commandSubmodulesUpgrade,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.submodulesFixate( _.mapExtend( null, e.optionsMap ) );
  }

}

commandSubmodulesUpgrade.defaults =
{
  dry : 0,
  negative : 0,
  recursive : null
}

var command = commandSubmodulesUpgrade.command = Object.create( null );
command.hint = 'Upgrade remote submodules.';
command.longHint = 'Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  negative : 'Reporting attempt of upgrade with negative outcome. Default is negative:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.command.properties,
}

//

function commandSubmodulesVersionsDownload( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesVersionsDownload, arguments );


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

    let o2 = _.mapExtend( null, e.optionsMap );
    delete o2.withSubmodules;
    o2.modules = it.openers;
    _.routineOptions( cui.modulesDownload, o2 );
    if( o2.recursive === 2 )
    o2.modules = it.roots;

    return cui.modulesDownload( o2 );
  }

}

commandSubmodulesVersionsDownload.defaults =
{
  withSubmodules : 1,
  withEnabledModules : null,
  withDisabledModules : null,
  withDisabledSubmodules : null,
  withEnabledSubmodules : null,
  dry : 0,
  recursive : 1
}

var command = commandSubmodulesVersionsDownload.command = Object.create( null );
command.hint = 'Download each submodule.';
command.longHint = 'Download each submodule if such was not downloaded so far.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.command.properties,
}

//

function commandSubmodulesVersionsUpdate( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesVersionsUpdate, arguments );

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
    o2 = _.mapExtend( o2, e.optionsMap );
    delete o2.withSubmodules;

    return it.opener.openedModule.subModulesUpdate( o2 );
  }

}

commandSubmodulesVersionsUpdate.defaults =
{
  withSubmodules : 1,

  dry : 0,
  recursive : 1,
  to : null,
}

var command = commandSubmodulesVersionsUpdate.command = Object.create( null );
command.hint = 'Update each submodule.';
command.longHint = 'Update each submodule or check for available updates for each submodule. Does nothing if all submodules have fixated version.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  dry : 'Dry run without actually writing or deleting files. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  to : 'Checkouts submodules to specified version/tag.',
  ... commandImply.command.properties,
}

//

function commandSubmodulesVersionsVerify( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesVersionsVerify, arguments );

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
    o2 = _.mapExtend( o2, e.optionsMap );
    return it.opener.openedModule.submodulesVerify( o2 );
  }
}

commandSubmodulesVersionsVerify.defaults =
{
  recursive : null
}

var command = commandSubmodulesVersionsVerify.command = Object.create( null );
command.hint = 'Check whether each submodule is on branch which is specified in willfile.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.command.properties,
}

//

function commandSubmodulesVersionsAgree( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesVersionsAgree, arguments );

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
    o2 = _.mapExtend( o2, e.optionsMap );
    return it.opener.openedModule.subModulesAgree( o2 );
  }

}

commandSubmodulesVersionsAgree.defaults =
{
  dry : 0,
  recursive : 1
}

var command = commandSubmodulesVersionsAgree.command = Object.create( null );
command.hint = 'Update each submodule.';
command.longHint = 'Update each submodule or check for available updates for each submodule. Does not change state of module if update is needed and module has local changes.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  dry : 'Dry run without writing. Default is dry:0.',
  recursive : 'Recursive downloading. recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:1.',
  ... commandImply.command.properties,
}

//

function commandSubmodulesShell( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesShell, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'submodules shell',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandSubmodulesShell,
    withStem : 0,
  });

  function handleEach( module )
  {
    return module.shell
    ({
      execPath : e.instructionArgument,
      currentPath : module.dirPath,
    });
  }
  // function handleEach( it )
  // {
  //   debugger;
  //   return it.opener.openedModule.shell
  //   ({
  //     execPath : e.instructionArgument,
  //     currentPath : it.opener.openedModule.dirPath,
  //     // currentPath : cui.currentOpenerPath || it.opener.openedModule.dirPath,
  //   });
  // }
}

var command = commandSubmodulesShell.command = Object.create( null );
command.hint = 'Run shell command on each submodule of current module.';
command.subjectHint = 'A command to execute in shell. Command executes for each submodule of current module.';

//

function commandSubmodulesGit( e )
{
  let cui = this;

  let commandOptions = _.mapBut_( null, e.propertiesMap, commandSubmodulesGit.command.properties );
  if( _.mapKeys( commandOptions ).length >= 1 )
  {
    e.subject += ' ' + _.mapToStr({ src : commandOptions, entryDelimeter : ' ' });
    e.propertiesMap = _.mapBut_( null, e.propertiesMap, commandOptions );
  }

  cui._command_head( commandSubmodulesGit, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'submodules git',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandSubmodulesGit,
    withStem : 0,
  });

  function handleEach( module )
  {
    return module.gitExecCommand
    ({
      dirPath : module.dirPath,
      command : e.subject,
      verbosity : cui.transaction.verbosity,
      hardLinkMaybe : e.optionsMap.hardLinkMaybe,
      profile : e.optionsMap.profile,
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitExecCommand
  //   ({
  //     dirPath : it.junction.dirPath,
  //     command : e.subject,
  //     // verbosity : cui.verbosity,
  //     verbosity : cui.transaction.verbosity,
  //     hardLinkMaybe : e.optionsMap.hardLinkMaybe,
  //     profile : e.optionsMap.profile,
  //   });
  // }
}

commandSubmodulesGit.defaults =
{
  withSubmodules : 1,
  withOut : 0,
  hardLinkMaybe : 0,
  profile : 'default'
}

var command = commandSubmodulesGit.command = Object.create( null );
command.hint = 'Run custom Git command on submodules of the module.';
command.subjectHint = 'Custom git command exclude name of command "git".';
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  ... commandImply.command.properties,
  hardLinkMaybe : 'Disables saving of hardlinks. Default value is 1.',
  profile : 'A name of profile to get path for hardlinking. Default is "default".'
};

//

function commandSubmodulesGitDiff( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesGitDiff, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'submodules git diff',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandSubmodulesGitDiff,
    withStem : 0,
  });

  function handleEach( module )
  {
    return module.gitDiff
    ({
      dirPath : module.dirPath,
      verbosity : cui.transaction.verbosity,
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitDiff
  //   ({
  //     dirPath : it.junction.dirPath,
  //     // verbosity : cui.verbosity,
  //     verbosity : cui.transaction.verbosity,
  //   });
  // }
}

commandSubmodulesGitDiff.defaults =
{
  withSubmodules : 1
}

var command = commandSubmodulesGitDiff.command = Object.create( null );
command.hint = 'Get diffs of submodules repositories.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties = commandImply.command.properties;

//

function commandSubmodulesRepoPullOpen( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesRepoPullOpen, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'submodules repo pull open',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandSubmodulesRepoPullOpen,
    withStem : 0,
  });

  function handleEach( module )
  {
    return module.repoPullOpen
    ({
      title : e.subject,
      ... _.mapOnly_( null, e.optionsMap, module.repoPullOpen.defaults ),
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.repoPullOpen
  //   ({
  //     title : e.subject,
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.repoPullOpen.defaults )
  //   });
  // }
}

commandSubmodulesRepoPullOpen.defaults =
{
  token : null,
  srcBranch : null,
  dstBranch : null,
  // title : null,
  body : null,
  verbosity : null,
  withSubmodules : 1
};
var command = commandSubmodulesRepoPullOpen.command = Object.create( null );
command.subjectHint = 'A title for PR';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
};
command.properties =
{
  ... commandImply.command.properties,
  token : 'An individual authorization token. By default reads from user config file.',
  srcBranch : 'A source branch. If PR opens from fork format should be "{user}:{branch}".',
  dstBranch : 'A destination branch. Default is "master".',
  title : 'Option that rewrite title in provided argument.',
  body : 'Body message.',
  verbosity : 'Set verbosity. Default is 2.',
  withSubmodules : 'Opening submodules. 0 - not opening, 1 - opening immediate children, 2 - opening all descendants recursively. Default : 1.',
};

//

function commandSubmodulesGitStatus( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesGitStatus, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'submodules git status',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandSubmodulesGitStatus,
    withStem : 0,
  });

  function handleEach( module )
  {
    return module.gitStatus({ ... _.mapOnly_( null, e.optionsMap, module.gitStatus.defaults ) });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitStatus
  //   ({
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.gitStatus.defaults )
  //   });
  // }
}

commandSubmodulesGitStatus.defaults =
{
  local : 1,
  uncommittedIgnored : 0,
  remote : 1,
  remoteBranches : 0,
  prs : 1,
  verbosity : 1,
  withSubmodules : 1
};

var command = commandSubmodulesGitStatus.command = Object.create( null );
command.hint = 'Check the status of the submodules repositories.';
command.subjectHint = false;
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  ... commandImply.command.properties,
  local : 'Check local commits. Default value is 1.',
  uncommittedIgnored : 'Check ignored local files. Default value is 0.',
  remote : 'Check remote unmerged commits. Default value is 1.',
  remoteBranches : 'Check remote branches. Default value is 0.',
  prs : 'Check pull requests. Default is prs:1.',
  verbosity : 'Set verbosity. Default is 1.',
  withSubmodules : 'Opening submodules. 0 - not opening, 1 - opening immediate children, 2 - opening all descendants recursively. Default : 1.',
};

//

function commandSubmodulesGitSync( e )
{
  let cui = this;
  // let logger = cui.transaction.logger;
  let provider;
  cui._command_head( commandSubmodulesGitSync, arguments );

  return cui._commandModulesLike
  // return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'submodules git sync',
    // onUp : onModulesBegin,
    // onEachModule,
    // onDown : onModulesEnd,
    onModulesBegin,
    onEach,
    onModulesEnd,
    commandRoutine : commandSubmodulesGitSync,
    withStem : 0,
  });

  /* */

  function onModulesBegin( openers, rootOpener )
  {
    let pathsContainer = [ rootOpener.openedModule.dirPath ];
    for( let i = 0 ; i < openers.length ; i++ )
    pathsContainer.push( openers[ i ].openedModule.dirPath );
    provider =
    rootOpener.openedModule._providerArchiveMake
    ({
      dirPath : cui.fileProvider.path.common( pathsContainer ),
      verbosity : cui.transaction.verbosity,
      profile : e.optionsMap.profile
    });

    if( cui.transaction.verbosity )
    cui.transaction.logger.log( `Restoring hardlinks in directory(s) :\n${ _.entity.exportStringNice( provider.archive.basePath ) }` );
    provider.archive.restoreLinksBegin();
  }

  /* */

  // function onEachModule( module )
  // {
  //   return module.gitSync
  //   ({
  //     commit : e.subject,
  //     ... _.mapOnly_( null, e.optionsMap, module.gitSync.defaults ),
  //     restoringHardLinks : 0,
  //   });
  // }
  function onEach( it )
  {
    return it.opener.openedModule.gitSync
    ({
      commit : e.subject,
      ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.gitSync.defaults ),
      restoringHardLinks : 0,
    });
  }

  /* */

  function onModulesEnd( openers )
  {
    provider.archive.restoreLinksEnd();
  }
}

commandSubmodulesGitSync.defaults =
{
  dirPath : null,
  dry : 0,
  profile : 'default',
  verbosity : 1,
  withSubmodules : 1
};

var command = commandSubmodulesGitSync.command = Object.create( null );
command.hint = 'Syncronize repositories of submodules of current module.';
command.subjectHint = 'A commit message. Default value is "."';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  ... commandImply.command.properties,
  dirPath : 'Path to local cloned Git directory. Default is directory of current module.',
  dry : 'Dry run without syncronizing. Default is dry:0.',
  verbosity : 'Set verbosity. Default is 1.',
  profile : 'A name of profile to get path for hardlinking. Default is "default".',

};

//

function commandModuleNew( e )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  will._command_head( commandModuleNew, arguments );

  if( e.instructionArgument )
  e.optionsMap.localPath = e.instructionArgument;

  if( will.transaction.withPath )
  {
    if( e.optionsMap.localPath )
    e.optionsMap.localPath = path.join( path.detrail( will.transaction.withPath ), e.optionsMap.localPath );
    else
    e.optionsMap.localPath = will.transaction.withPath;
  }

  return will.moduleNew({ verbosity : will.transaction.verbosity, ... e.optionsMap });
}

commandModuleNew.defaults =
{
  localPath : null,
  withPath : null,
  verbosity : 1,
}

var command = commandModuleNew.command = Object.create( null );
command.hint = 'Create a new module.';
command.subjectHint = 'Path to module file. Default value is ".will.yml".';
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  ... commandImply.command.properties,
  localPath : 'Path to module file. Default value is ".will.yml".',
  withPath : 'A module selector.',
  verbosity : 'Set verbosity. Default is 1.'
}

//

function commandModuleNewWith( e )
{
  let cui = this;
  cui._command_head( commandModuleNewWith, arguments );

  let fileProvider = cui.fileProvider;
  let path = cui.fileProvider.path;
  let logger = cui.transaction.logger;
  let time = _.time.now();
  let execPath = e.instructionArgument;

  return cui._commandNewLike
  ({
    event : e,
    name : 'make a new module and call a hook',
    onEach : handleEach,
    commandRoutine : commandModuleNewWith,
    withOut : 0,
    // withDisabledModules : 0,
    withInvalid : 1,
    allowNoOpeners : true
  })
  .then( ( arg ) =>
  {
    if( cui.transaction.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( 'hook::' + e.instructionArgument, 'entity' )} in ${_.time.spent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let it2 = _.mapOnly_( null, it, cui.hookContextFrom.defaults );
    it2.execPath = path.join( cui.hooksPath, execPath );
    it2 = cui.hookContextFrom( it2 );
    return cui.hookCall( it2 );
  }

}

var command = commandModuleNewWith.command = Object.create( null );
command.hint = 'Make a new module in the current directory and call a specified hook for the module to prepare it.';
command.subjectHint = 'A path to hook and arguments.';

//

function commandModulesShell( e )
{
  let cui = this;
  cui._command_head( commandModulesShell, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'modules shell',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandModulesShell,
    withStem : 1,
  });

  function handleEach( module )
  {
    return module.shell
    ({
      execPath : e.instructionArgument,
      currentPath : module.dirPath,
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.shell
  //   ({
  //     execPath : e.instructionArgument,
  //     currentPath : it.opener.openedModule.dirPath,
  //     // currentPath : cui.currentOpenerPath || it.opener.openedModule.dirPath,
  //   });
  // }
}

var command = commandModulesShell.command = Object.create( null );
command.hint = 'Run shell command on current module including each submodule of the module.';
command.subjectHint =
'A command to execute in shell. Command executes for current module including each submodule of the module.';

//

function commandModulesGit( e )
{
  let cui = this;

  let commandOptions = _.mapBut_( null, e.propertiesMap, commandModulesGit.command.properties );
  if( _.mapKeys( commandOptions ).length >= 1 )
  {
    e.subject += ' ' + _.mapToStr({ src : commandOptions, entryDelimeter : ' ' });
    e.propertiesMap = _.mapBut_( null, e.propertiesMap, commandOptions );
  }

  cui._command_head( commandModulesGit, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'modules git',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandModulesGit,
    withStem : 1,
  });

  function handleEach( module )
  {
    return module.gitExecCommand
    ({
      dirPath : module.dirPath,
      command : e.subject,
      verbosity : cui.transaction.verbosity,
      hardLinkMaybe : e.optionsMap.hardLinkMaybe,
      profile : e.optionsMap.profile,
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitExecCommand
  //   ({
  //     dirPath : it.junction.dirPath,
  //     command : e.subject,
  //     // verbosity : cui.verbosity,
  //     verbosity : cui.transaction.verbosity,
  //     hardLinkMaybe : e.optionsMap.hardLinkMaybe,
  //     profile : e.optionsMap.profile,
  //   });
  // }
}

commandModulesGit.defaults =
{
  withOut : 0,
  withSubmodules : 1,
  hardLinkMaybe : 0,
  profile : 'default'
}

var command = commandModulesGit.command = Object.create( null );
command.hint = 'Run custom Git command on module and its submodules.';
command.subjectHint = 'Custom git command exclude name of command "git".';
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  ... commandImply.command.properties,
  hardLinkMaybe : 'Disables saving of hardlinks. Default value is 0.',
  profile : 'A name of profile to get path for hardlinking. Default is "default".',
};

//

function commandModulesGitDiff( e )
{
  let cui = this;
  cui._command_head( commandModulesGitDiff, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'modules git diff',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandModulesGitDiff,
    withStem : 1,
  });

  function handleEach( module )
  {
    return module.gitDiff
    ({
      dirPath : module.dirPath,
      verbosity : cui.transaction.verbosity,
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitDiff
  //   ({
  //     dirPath : it.junction.dirPath,
  //     // verbosity : cui.verbosity,
  //     verbosity : cui.transaction.verbosity,
  //   });
  // }
}

commandModulesGitDiff.defaults =
{
  withSubmodules : 1
}

var command = commandModulesGitDiff.command = Object.create( null );
command.hint = 'Get diffs of root module and submodules repositories.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties = commandImply.command.properties;

//

function commandModulesRepoPullOpen( e )
{
  let cui = this;
  cui._command_head( commandModulesRepoPullOpen, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'modules repo pull open',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandModulesRepoPullOpen,
    withStem : 1,
  });

  function handleEach( module )
  {
    return module.repoPullOpen
    ({
      title : e.subject,
      ... _.mapOnly_( null, e.optionsMap, module.repoPullOpen.defaults ),
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.repoPullOpen
  //   ({
  //     title : e.subject,
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.repoPullOpen.defaults )
  //   });
  // }
}

commandModulesRepoPullOpen.defaults =
{
  token : null,
  srcBranch : null,
  dstBranch : null,
  // title : null,
  body : null,
  verbosity : 2,
  withSubmodules : 1
};

var command = commandModulesRepoPullOpen.command = Object.create( null );
command.hint = 'Open pull requests from current module and its submodules.';
command.subjectHint = 'A title for PR';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
};
command.properties =
{
  ... commandImply.command.properties,
  token : 'An individual authorization token. By default reads from user config file.',
  srcBranch : 'A source branch. If PR opens from fork format should be "{user}:{branch}".',
  dstBranch : 'A destination branch. Default is "master".',
  title : 'Option that rewrite title in provided argument.',
  body : 'Body message.',
  verbosity : 'Set verbosity. Default is 2.',
  withSubmodules : 'Opening submodules. 0 - not opening, 1 - opening immediate children, 2 - opening all descendants recursively. Default : 1.',
};

//

function commandModulesGitStatus( e )
{
  let cui = this;
  cui._command_head( commandModulesGitStatus, arguments );

  // return cui._commandModulesLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'modules git status',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandModulesGitStatus,
    withStem : 1,
  });

  function handleEach( module )
  {
    return module.gitStatus ({ ... _.mapOnly_( null, e.optionsMap, module.gitStatus.defaults ) });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitStatus
  //   ({
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.gitStatus.defaults )
  //   });
  // }
}

commandModulesGitStatus.defaults =
{
  local : 1,
  uncommittedIgnored : 0,
  remote : 1,
  remoteBranches : 0,
  prs : 1,
  verbosity : 1,
  withSubmodules : 1
};

var command = commandModulesGitStatus.command = Object.create( null );
command.hint = 'Check the status of the module and submodules repositories.';
command.subjectHint = false;
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  ... commandImply.command.properties,
  local : 'Check local commits. Default value is 1.',
  uncommittedIgnored : 'Check ignored local files. Default value is 0.',
  remote : 'Check remote unmerged commits. Default value is 1.',
  remoteBranches : 'Check remote branches. Default value is 0.',
  prs : 'Check pull requests. Default is prs:1.',
  verbosity : 'Set verbosity. Default is 1.',
  withSubmodules : 'Opening submodules. 0 - not opening, 1 - opening immediate children, 2 - opening all descendants recursively. Default : 1.',
};

//

function commandModulesGitSync( e )
{
  let cui = this;
  let logger = cui.transaction.logger;
  let provider;
  cui._command_head( commandModulesGitSync, arguments );

  return cui._commandModulesLike
  // return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'modules git sync',
    // onUp : onModulesBegin,
    // onEachModule,
    // onDown : onModulesEnd,
    onModulesBegin,
    onEach,
    onModulesEnd,
    commandRoutine : commandModulesGitSync,
    withStem : 1,
  });

  /* */

  function onModulesBegin( openers )
  {
    let pathsContainer = [];
    for( let i = 0 ; i < openers.length ; i++ )
    pathsContainer.push( openers[ i ].openedModule.dirPath );
    provider = openers[ 0 ].openedModule._providerArchiveMake
    ({
      dirPath : cui.fileProvider.path.common( pathsContainer ),
      verbosity : cui.transaction.verbosity,
      profile : e.optionsMap.profile,
    });

    if( cui.transaction.verbosity )
    logger.log( `Restoring hardlinks in directory(s) :\n${ _.entity.exportStringNice( provider.archive.basePath ) }` );
    provider.archive.restoreLinksBegin();
  }

  /* */

  // function onEachModule( module )
  // {
  //   return module.gitSync
  //   ({
  //     commit : e.subject,
  //     ... _.mapOnly_( null, e.optionsMap, module.gitSync.defaults ),
  //     restoringHardLinks : 0,
  //   });
  // }
  function onEach( it )
  {
    return it.opener.openedModule.gitSync
    ({
      commit : e.subject,
      ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.gitSync.defaults ),
      restoringHardLinks : 0,
    });
  }

  /* */

  function onModulesEnd( openers )
  {
    provider.archive.restoreLinksEnd();
  }
}

commandModulesGitSync.defaults =
{
  dirPath : null,
  dry : 0,
  profile : 'default',
  verbosity : 1,
  withSubmodules : 1
};

var command = commandModulesGitSync.command = Object.create( null );
command.hint = 'Syncronize repositories of current module and all submodules of the module.';
command.subjectHint = 'A commit message. Default value is "."';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  ... commandImply.command.properties,
  dirPath : 'Path to local cloned Git directory. Default is directory of current module.',
  dry : 'Dry run without syncronizing. Default is dry:0.',
  verbosity : 'Set verbosity. Default is 1.',
  profile : 'A name of profile to get path for hardlinking. Default is "default".',
};

//

function commandShell( e )
{
  let cui = this;
  cui._command_head( commandShell, arguments );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'shell',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandShell,
  });

  function handleEach( module )
  {
    return module.shell
    ({
      execPath : e.instructionArgument,
      currentPath : module.dirPath,
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.shell
  //   ({
  //     execPath : e.instructionArgument,
  //     currentPath : it.opener.openedModule.dirPath,
  //     // currentPath : cui.currentOpenerPath || it.opener.openedModule.dirPath,
  //   });
  // }
}

var command = commandShell.command = Object.create( null );
command.hint = 'Run shell command on the module.';
command.subjectHint = 'A command to execute is shell.';

//

function commandDo( e )
{
  let cui = this;
  cui._command_head( commandDo, arguments );
  let fileProvider = cui.fileProvider;
  let path = cui.fileProvider.path;
  let logger = cui.transaction.logger;
  let time = _.time.now();
  let execPath = e.instructionArgument;

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
    if( cui.transaction.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( e.instructionArgument, 'code' )} in ${_.time.spent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let it2 = _.mapOnly_( null, it, cui.hookContextFrom.defaults );
    it2.execPath = execPath;
    it2 = cui.hookContextFrom( it2 );
    return cui.hookCall( it2 );
  }

}

var command = commandDo.command = Object.create( null );
command.hint = 'Run JS script on the module.';
command.subjectHint = 'A JS script to execute.';

//

function commandHookCall( e )
{
  let cui = this;
  cui._command_head( commandDo, arguments );

  let path = cui.fileProvider.path;
  let logger = cui.transaction.logger;
  let time = _.time.now();
  let execPath = e.instructionArgument;

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
    if( cui.transaction.verbosity >= 2 )
    logger.log( `Done ${_.color.strFormat( 'hook::' + e.instructionArgument, 'entity' )} in ${_.time.spent( time )}` );
    return arg;
  });

  function handleEach( it )
  {
    let it2 = _.mapOnly_( null, it, cui.hookContextFrom.defaults );
    it2.execPath = path.join( cui.hooksPath, execPath );
    it2 = cui.hookContextFrom( it2 );
    return cui.hookCall( it2 );
  }
}

commandHookCall.defaults = _.mapExtend( null, commandImply.defaults );
var command = commandHookCall.command = Object.create( null );
command.hint = 'Call a specified hook on the module.';
command.subjectHint = 'A hook to execute';

//

function commandHooksList( e )
{
  let cui = this.form();
  cui._command_head( commandHooksList, arguments );

  let logger = cui.transaction.logger;

  cui.hooksReload();
  logger.log( 'Found hooks' );
  logger.up();
  cui.hooksList();
  logger.down();
}

commandHooksList.defaults = _.mapExtend( null, commandImply.defaults );

var command = commandHooksList.command = Object.create( null );
command.hint = 'List available hooks.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties = commandImply.command.properties;

//

function commandClean( e )
{
  let cui = this;
  cui._command_head( commandClean, arguments );

  e.optionsMap.dry = !!e.optionsMap.dry;
  if( e.optionsMap.fast === undefined || e.optionsMap.fast === null )
  e.optionsMap.fast = !e.optionsMap.dry;
  e.optionsMap.fast = 0; /* xxx : implement */

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
    o2 = _.mapExtend( o2, e.optionsMap );
    delete o2.withSubmodules;
    o2.modules = it.openers;
    _.routineOptions( cui.modulesClean, o2 );
    if( o2.recursive === 2 )
    o2.modules = it.roots;
    o2.asCommand = 1;

    return cui.modulesClean( o2 );
  }

}

commandClean.defaults =
{
  withSubmodules : 0,
  withOut : 1,
  dry : 0,
  cleaningSubmodules : 1,
  cleaningOut : 1,
  cleaningTemp : 1,
  recursive : 0,
  fast : 0
}

var command = commandClean.command = Object.create( null );
command.hint = 'Clean current module.';
command.longHint = 'Clean current module. Delete genrated artifacts, temp files and downloaded submodules.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  dry : 'Dry run without deleting. Default is dry:0.',
  cleaningSubmodules : 'Deleting directory ".module" dir with remote submodules. Default is cleaningSubmodules:1.',
  cleaningOut : 'Deleting generated out files. Default is cleaningOut:1.',
  cleaningTemp : 'Deleting module-specific temporary directory. Default is cleaningTemp:1.',
  recursive : 'Recursive cleaning. recursive:0 - only curremt module, recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:0.',
  fast : 'Faster implementation, but fewer diagnostic information. Default fast:1 for dry:0 and fast:0 for dry:1.',
  ... commandImply.command.properties,
  /* aaa2 : should have verbosity and other common options */ /* Dmytro : appended to the property command.properties */
}

//

function commandSubmodulesClean( e )
{
  let cui = this;
  cui._command_head( commandSubmodulesClean, arguments );

  e.optionsMap.dry = !!e.optionsMap.dry;
  if( e.optionsMap.fast === undefined || e.optionsMap.fast === null )
  e.optionsMap.fast = !e.optionsMap.dry;
  e.optionsMap.fast = 0; /* xxx : implement */

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
    o2 = _.mapExtend( o2, e.optionsMap );
    o2.modules = it.openers;
    delete o2.withSubmodules;
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

commandSubmodulesClean.defaults =
{
  dry : 0,
  recursive : 0,
  fast : 0,
  force : 0,
  withSubmodules : 0
}

var command = commandSubmodulesClean.command = Object.create( null );
command.hint = 'Delete all downloaded submodules.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  ... commandImply.command.properties,

  dry : 'Dry run without deleting. Default is dry:0.',
  recursive : 'Recursive cleaning. recursive:0 - only curremt module, recursive:1 - current module and its submodules, recirsive:2 - current module and all submodules, direct and indirect. Default is recursive:0.',
  fast : 'Faster implementation, but fewer diagnostic information. Default fast:1 for dry:0 and fast:0 for dry:1.',
  force : 'Force cleaning. force:0 - checks submodules for local changes before cleanup, force:1 - removes submodules without any checks.',
}

//

function commandBuild( e )
{
  let cui = this;
  cui._command_head( commandBuild, arguments );
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
      ... _.mapBut_( null, cui.RelationFilterOn, { withIn : null, withOut : null } ),
      doneContainer,
      name : e.subject,
      criterion : e.propertiesMap,
      recursive : 0,
      kind : 'build',
    });
  }

}

var command = commandBuild.command = Object.create( null );
command.hint = 'Build current module with spesified criterion.';
command.subjectHint = 'A name of build scenario.';

//

function commandExport( e )
{
  let cui = this;
  cui._command_head( commandExport, arguments );
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
    // let filterProperties = _.mapBut_( null, cui.RelationFilterOn, { withIn : null, withOut : null } );
    let filterProperties = _.mapBut_( null, cui.RelationFilterDefaults, { withIn : null, withOut : null } );
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

var command = commandExport.command = Object.create( null );
command.hint = 'Export selected module with spesified criterion.';
command.longHint = 'Export selected module with spesified criterion. Save output to output willfile and archive.';
command.subjectHint = 'A name of export scenario.';

//

function commandExportPurging( e )
{
  let cui = this;
  debugger
  cui._command_head( commandExportPurging, arguments );
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
      // ... _.mapBut_( null, cui.RelationFilterOn, { withIn : null, withOut : null } ),
      ... _.mapBut_( null, cui.RelationFilterDefaults, { withIn : null, withOut : null } ),
      doneContainer,
      name : e.subject,
      criterion : e.propertiesMap,
      recursive : 0,
      purging : 1,
      kind : 'export',
    });
  }

}

var command = commandExportPurging.command = Object.create( null );
command.hint = 'Export selected the module with spesified criterion purging output willfile first.';
command.longHint = 'Export selected the module with spesified criterion purging output willfile first. Save output to output willfile and archive.';
command.subjectHint = 'A name of export scenario.';

//

function commandExportRecursive( e )
{
  let cui = this;
  cui._command_head( commandExportRecursive, arguments );
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
      // ... _.mapBut_( null, cui.RelationFilterOn, { withIn : null, withOut : null } ),
      ... _.mapBut_( null, cui.RelationFilterDefaults, { withIn : null, withOut : null } ),
      doneContainer,
      name : e.subject,
      criterion : e.propertiesMap,
      recursive : 2,
      kind : 'export',
    });
  }

}

var command = commandExportRecursive.command = Object.create( null );
command.hint = 'Export selected the module with spesified criterion and its submodules.';
command.longHint = 'Export selected the module with spesified criterion and its submodules. Save output to output willfile and archive.';
command.subjectHint = 'A name of export scenario.';

// --
// command iterator
// --

/* xxx : add test routine checking wrong syntax error handling */

// function commandWith( e )
// {
//   let cui = this.form();
//   let path = cui.fileProvider.path;

//   cui._command_head
//   ({
//     routine : commandWith,
//     args : arguments,
//     // usingImpliedMap : 0
//   });

//   // if( cui.currentOpener )
//   // {
//   //   cui.currentOpener.finit();
//   //   cui.currentOpenerChange( null );
//   // }

//   if( cui.currentOpeners )
//   cui.currentOpeners.forEach( ( opener ) => opener.isFinited() ? null : opener.finit() );
//   cui.currentOpeners = null;

//   _.sure( _.strDefined( e.instructionArgument ), 'Expects path to module' );
//   _.assert( arguments.length === 1 );

//   if( !e.instructionArgument )
//   throw _.errBrief( 'Format of .with command should be: .with {-path-} .command' );

//   if( process.platform === 'linux' )
//   {
//     let quoteRanges = _.strQuoteAnalyze({ src : e.instructionArgument, quote : [ '"' ] }).ranges;
//     if( quoteRanges.length !== 2 || ( quoteRanges[ 0 ] !== 0 && quoteRanges[ 1 ] !== e.instructionArgument.length ) )
//     {
//       let splits = e.instructionArgument.split( ' ' );
//       if( splits.length > 1 )
//       {
//         let screenMap = _.paths.ext( splits );
//         for( let i = screenMap.length - 1 ; i >= 0 ; i-- )
//         {
//           if( screenMap[ i ] === '' )
//           {
//             splits[ i ] = _.strUnquote( `${ splits[ i ] } ${ splits[ i + 1 ] }` );
//             splits.splice( i + 1, 1 );
//           }
//         }
//         e.instructionArgument = _.strCommonLeft( ... splits ) + '*';
//       }
//     }
//   }

//   // cui.withPath = path.join( path.current(), cui.withPath, path.fromGlob( e.instructionArgument ) );
//   let withPath = path.join( path.current(), cui.transaction.withPath, path.fromGlob( e.instructionArgument ) );

//   cui.implied = _.mapExtend( cui.implied, { withPath } );
//   cui._transactionExtend( commandWith, cui.implied );

//   return cui.modulesFindWithAt
//   ({
//     selector : _.strUnquote( e.instructionArgument ),
//     atLeastOne : !path.isGlob( e.instructionArgument ),
//   })
//   .then( function( it )
//   {
//     cui.currentOpeners = it.sortedOpeners;

//     if( !cui.currentOpeners.length )
//     {
//       let equalizer = ( parsed, command ) => parsed.commandName === command;
//       if( !_.longHasAny( e.parsedCommands, [ '.module.new', '.module.new.with' ], equalizer ) )
//       throw _.errBrief
//       (
//         `No module sattisfy criteria.`
//         , `\nLooked at ${ _.strQuote( path.resolve( e.instructionArgument ) )}`
//       );
//       else
//       cui.currentOpeners = null;
//     }

//     _.assert( cui.transaction instanceof _.will.Transaction );
//     // qqq : for Vova : why was it here ? aaa: removes transaction object at the end of the command execution
//     // cui.transaction.finit();
//     // cui.transaction = null;

//     return it;
//   })

// }

//

function commandWith( e )
{
  let cui = this.form();
  let path = cui.fileProvider.path;

  _.sure( _.strDefined( e.instructionArgument ), 'Expects path to module' );
  _.assert( arguments.length === 1 );

  if( !e.instructionArgument )
  throw _.errBrief( 'Format of .with command should be: .with {-path-} .command' );

  if( process.platform === 'linux' )
  {
    let quoteRanges = _.strQuoteAnalyze({ src : e.instructionArgument, quote : [ '"' ] }).ranges;
    if( quoteRanges.length !== 2 || ( quoteRanges[ 0 ] !== 0 && quoteRanges[ 1 ] !== e.instructionArgument.length ) )
    {
      let splits = e.instructionArgument.split( ' ' );
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
        e.instructionArgument = _.strCommonLeft( ... splits ) + '*';
      }
    }
  }

  // let withPath = path.join( path.current(), cui.transaction.withPath, path.fromGlob( e.instructionArgument ) );
  // let withPath = path.join( path.current(), cui.transaction.withPath, e.instructionArgument );
  let withPath = path.join( path.current(), e.instructionArgument );
  cui.implied = _.mapExtend( cui.implied, { withPath } );

  cui._command_head
  ({
    routine : commandWith,
    args : arguments,
  });

  _.assert( cui.transaction instanceof _.will.Transaction );
  _.assert( cui.transaction.withPath === withPath );

  cui.transaction.finit();
  cui.transactionOld = cui.transaction;
  cui.transaction = null;

}

// commandWith.defaults = _.mapExtend( null, commandImply.defaults );

var command = commandWith.command = Object.create( null );
command.hint = 'Select a module to execute command.';
command.subjectHint = 'A module selector.';
command.properties = Object.create( null );

//

function commandModules( e )
{
  let cui = this.form();

  _.assert( arguments.length === 1 );

  cui.implied = _.mapExtend( cui.implied, { modulesDepth : [ 0, Infinity ] } );

  cui._command_head
  ({
    routine : commandModules,
    args : arguments,
  });

  _.assert( cui.transaction instanceof _.will.Transaction );
  cui.transaction.finit();
  cui.transactionOld = cui.transaction;
  cui.transaction = null;
}

var command = commandModules.command = Object.create( null );
command.hint = 'Marks next commands to be executed modules.';
command.subjectHint = false;
command.properties = Object.create( null );

//

function commandSubmodules( e )
{
  let cui = this.form();

  _.assert( arguments.length === 1 );

  cui.implied = _.mapExtend( cui.implied, { modulesDepth : [ 1, Infinity ] } );

  cui._command_head
  ({
    routine : commandSubmodules,
    args : arguments,
  });

  _.assert( cui.transaction instanceof _.will.Transaction );
  cui.transaction.finit();
  cui.transactionOld = cui.transaction;
  cui.transaction = null;
}

var command = commandSubmodules.command = Object.create( null );
command.hint = 'Marks next commands to be executed for submodules.';
command.subjectHint = false;
command.properties = Object.create( null );

//

function commandEach( e )
{
  let cui = this.form();
  let path = cui.fileProvider.path;

  if( cui.currentOpeners )
  cui.currentOpeners.forEach( ( opener ) => opener.isFinited() ? null : opener.finit() );
  cui.currentOpeners = null;

  // if( cui.currentOpener )
  // {
  //   cui.currentOpener.finit();
  //   cui.currentOpenerChange( null );
  // }

  _.sure( _.strDefined( e.instructionArgument ), 'Expects path to module' )
  _.assert( arguments.length === 1 );

  if( !e.instructionArgument )
  throw _.errBrief( 'Format of .each command should be: .each {-path-} .command' );

  let commandIndex = _.longLeftIndex( e.parsedCommands, '.each', ( parsed, command ) => parsed.commandName === command );
  _.assert( e.parsedCommands[ commandIndex + 1 ], 'Command .each should go with the second command to apply to each module. For example : ".each submodule::* .shell ls -al"' );

  let con;
  if( _.will.resolver.Resolver.selectorIs( e.instructionArgument ) )
  {
    con = cui.modulesFindEachAt
    ({
      selector : _.strUnquote( e.instructionArgument ),
      onError : handleError,
    })
  }
  else
  {
    if( !path.isGlob( e.instructionArgument ) )
    {
      if( _.strEnds( e.instructionArgument, '/.' ) )
      e.instructionArgument = _.strRemoveEnd( e.instructionArgument, '/.' ) + '/*';
      else if( e.instructionArgument === '.' )
      e.instructionArgument = '*';
      else if( _.strEnds( e.instructionArgument, '/' ) )
      e.instructionArgument += '*';
      else
      e.instructionArgument += '/*';
    }

    con = cui.modulesFindWithAt
    ({
      selector : _.strUnquote( e.instructionArgument ),
      atLeastOne : !path.isGlob( e.instructionArgument ),
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
        , `\nLooked at ${ _.strQuote( path.resolve( e.instructionArgument ) )}`
      );
    }

    return it;
  });

  /* */

  function handleError()
  {

    if( cui.currentOpeners )
    cui.currentOpeners.forEach( ( opener ) => opener.isFinited() ? null : opener.finit() );
    cui.currentOpeners = null;
    // if( cui.currentOpener )
    // cui.currentOpener.finit();
    // cui.currentOpenerChange( null );
    cui.mainOpener = null; /* xxx2 */
  }

}

var command = commandEach.command = Object.create( null );
command.hint = 'Iterate each module in a directory.';
command.subjectHint = 'A module or resource selector.';

//

function commandNpmFromWillfile( e )
{
  let cui = this;
  // let criterionsMap = _.mapBut_( null, e.propertiesMap, commandNpmFromWillfile.defaults );
  let criterionsMap = _.mapBut_( null, e.propertiesMap, commandNpmFromWillfile.command.properties );
  e.propertiesMap = _.mapOnly_( null, e.propertiesMap, commandNpmFromWillfile.defaults );
  cui._command_head( commandNpmFromWillfile, arguments );
  // _.routineOptions( commandNpmFromWillfile, e.propertiesMap );

  // if( e.propertiesMap.withSubmodules === null || e.propertiesMap.withSubmodules === undefined )
  // cui._propertiesImply({ withSubmodules : 0 });
  // cui._propertiesImply( e.propertiesMap );

  if( e.subject )
  e.optionsMap.packagePath = e.subject;

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
      ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.npmGenerateFromWillfile.defaults ),
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
  withSubmodules : 0,
};

var command = commandNpmFromWillfile.command = Object.create( null );
command.hint = 'Generate JSON file from willfile(s) of current module.';
command.longHint = 'Generate JSON file from willfile of current module. Default JSON file is "package.json" in directory "out"\n\t"will .npm.from.willfile" - generate "package.json" from unnamed willfiles, file locates in directory "out";\n\t"will .npm.from.willfile package.json" - generate "package.json" from unnamed willfiles, file locates in directory of module.\n';
command.subjectHint = 'A name of resulted JSON file. It has priority over option "packagePath".';
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  ... commandImply.command.properties,
  'packagePath' : 'Path to generated JSON file. Default is "{path::out}/package.json".'
  + '\n\t"will .npm.from.willfile packagePath:debug/package.json" - generate "package.json" from unnamed willfiles, file locates in directory "debug".',
  'entryPath' : 'Path for field "main" of "package.json". By default "entryPath" is generated from module with path "path/entry".'
  + '\n\t"will .npm.from.willfile entryPath:proto/wtools/Include.s" - generate "package.json" with field "main" : "proto/wtools/Include.s".',
  'filesPath' : 'Path to directory ( file ) for field "files" of "package.json". By default, field "files" is generated from module with path "path/npm.files".'
  + '\n\t"will .npm.from.willfile filesPath:proto" - generate "package.json" from unnamed willfiles, field "files" will contain all files from directory "proto".',
};

//

function commandWillfileFromNpm( e )
{
  let cui = this;
  // let criterionsMap = _.mapBut_( null, e.propertiesMap, commandWillfileFromNpm.defaults );
  let criterionsMap = _.mapBut_( null, e.propertiesMap, commandWillfileFromNpm.command.properties );
  e.propertiesMap = _.mapOnly_( null, e.propertiesMap, commandWillfileFromNpm.defaults );
  cui._command_head( commandWillfileFromNpm, arguments );
  // _.routineOptions( commandWillfileFromNpm, e.propertiesMap );

  // if( e.propertiesMap.withSubmodules === null || e.propertiesMap.withSubmodules === undefined )
  // cui._propertiesImply({ withSubmodules : 0 });

  // cui._propertiesImply( e.propertiesMap );

  if( e.subject )
  e.optionsMap.willfilePath = e.subject;

  let con = _.take( null );
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
        ... e.optionsMap,
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
      packagePath : e.optionsMap.packagePath,
      willfilePath : e.optionsMap.willfilePath,
      currentContext,
      verbosity : 3,
    });
  }
}

commandWillfileFromNpm.defaults =
{
  packagePath : null,
  willfilePath : null,
  withSubmodules : 0,
};

var command = commandWillfileFromNpm.command = Object.create( null );
command.hint = 'Generate willfile from JSON file.';
command.longHint = 'Generate willfile from JSON file. Default willfile - "will.yml", default JSON file - "package.json".\n\t"will .npm.from.willfile" - generate willfile "will.yml" from file "package.json";\n\t"will .npm.from.willfile Named" - generate willfile "Named.will.yml" from file "package.json".\n';
command.subjectHint = 'A name of resulted willfile. It has priority over option "willfilePath".';
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  ... commandImply.command.properties,
  'packagePath' : 'Path to source json file. Default is "./package.json".'
  + '\n\t"will .willfile.from.npm packagePath:old.package.json" - generate willfile "will.yml" from JSON file "old.package.json".',
  'willfilePath' : 'Path to generated willfile. Default is "./.will.yml".'
  + '\n\t"will .willfile.from.npm willfilePath:Named" - generate willfile "Named.will.yml" from file "package.json".',
};

//

function commandWillfileGet( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut_( null, e.propertiesMap, commandWillfileGet.defaults );
  e.propertiesMap = _.mapOnly_( null, e.propertiesMap, commandWillfileGet.defaults );
  cui._command_head( commandWillfileExtend, arguments );

  if( !e.subject && !cui.currentOpeners )
  e.subject = './';

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
      ... e.optionsMap,
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
      ... e.optionsMap,
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
    e.subject = './';
  }
}

commandWillfileGet.defaults =
{
  verbosity : 3,
};

var command = commandWillfileGet.command = Object.create( null );
command.hint = 'Get value of separate properties of source willfile.';
command.longHint = 'Get value of separate properties of source willfile. Default willfile is unnamed willfile. If no options are provided, command shows all willfile data.\n\t"will .willfile.get" - show all unnamed willfile;\n\t"will .willfile.get Named about/author" - show property "about/author" in willfile "Named.will.yml".\n';
command.subjectHint = 'A path to source willfile.';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  'verbosity' : 'Enables output with missed preperties. Output is enabled if verbosity > 3. Default value is 3.'
  + '\n\t"will .willfile.get path/to/not/existed:1 verbosity:4" - enable output for not existed property.',
};

//

function commandWillfileSet( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut_( null, e.propertiesMap, commandWillfileSet.defaults );
  e.propertiesMap = _.mapOnly_( null, e.propertiesMap, commandWillfileSet.defaults );
  cui._command_head( commandWillfileSet, arguments );

  if( !e.subject && !cui.currentOpeners )
  if( _.mapKeys( willfilePropertiesMap ).length > 0 )
  e.subject = './';

  if( e.subject )
  {
    let o =
    {
      request : e.subject,
      willfilePropertiesMap,
      ... e.optionsMap,
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
      ... e.optionsMap,
    });
  }
}

commandWillfileSet.defaults =
{
  verbosity : 3,
  structureParse : 0,
};

var command = commandWillfileSet.command = Object.create( null );
command.hint = 'Set separate properties in destination willfile.';
command.longHint = 'Set separate properties in destination willfile. Default willfile is unnamed willfile. Expects at least one option.\n\t"will .willfile.set about/name:MyName" - sets in unnamed willfile option "about/name" to "MyName";\n\t"will .willfile.set Named about/name:MyName" - sets willfile "Named.will.yml" option "about/name" to "MyName".\n';
command.subjectHint = 'A path to destination willfile.';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  'structureParse' : 'Enable parsing of property value. Experimental feature. Default is 0.'
  + '\n\t"will .willfile.set path/out.debug/criterion:\'debug:[0,1]\'" - will parse criterion as structure.',
  'verbosity' : 'Enables output with rewritten preperties. Output is enabled if verbosity > 3. Default value is 3.'
  + '\n\t"will .willfile.set about/author/name:author verbosity:4" - enable output if option "author" has string value.',
};

//

function commandWillfileDel( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut_( null, e.propertiesMap, commandWillfileGet.defaults );
  e.propertiesMap = _.mapOnly_( null, e.propertiesMap, commandWillfileDel.defaults );
  cui._command_head( commandWillfileExtend, arguments );

  if( !e.subject && !cui.currentOpeners )
  e.subject = './';

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
      ... e.optionsMap,
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
      ... e.optionsMap,
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
    e.subject = './';
  }
}

commandWillfileDel.defaults =
{
  verbosity : 3,
};

var command = commandWillfileDel.command = Object.create( null );
command.hint = 'Delete separate properties in destination willfile.';
command.longHint = 'Delete separate properties in destination willfile. Default willfile is unnamed willfile. If no options are provided, command clear all config file.\n\t"will .willfile.del" - clear all unnamed willfile;\n\t"will .willfile.del Named about/interpreters" - delete property "interpreters" in willfile "Named.will.yml".\n';
command.subjectHint = 'A path to source willfile.';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  'verbosity' : 'Enables output with deleted preperties. Output is enabled if verbosity > 3. Default value is 3.'
  + '\n\t"will .willfile.del about/author verbosity:4" - enable output.',
};

//

function commandWillfileExtend( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut_( null, e.propertiesMap, commandWillfileExtend.defaults );
  e.propertiesMap = _.mapOnly_( null, e.propertiesMap, commandWillfileExtend.defaults );
  cui._command_head( commandWillfileExtend, arguments );

  if( !e.subject && !cui.currentOpeners )
  if( _.mapKeys( willfilePropertiesMap ).length > 0 )
  e.subject = './';

  if( e.subject )
  {
    let o =
    {
      request : e.subject,
      onProperty : _.mapExtend,
      willfilePropertiesMap,
      ... e.optionsMap,
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

  throw _.errBrief( 'Please, specify at least one option. Format: will .willfile.set about/name:name' );

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
      ... e.optionsMap,
    });
  }
}

commandWillfileExtend.defaults =
{
  verbosity : 3,
  structureParse : 0,
};

var command = commandWillfileExtend.command = Object.create( null );
command.hint = 'Extend separate properties of destination willfile.';
command.longHint = 'Extend separate properties of destination willfile. Default willfile is unnamed willfile. Expects at least one option.\n\t"will .willfile.extend about/name:MyName" - sets in unnamed willfile option "about/name" to "MyName";\n\t"will .willfile.extend Named about/interpreters/chromium:73.1.0" - throw error if property "interpreters" has String value.\n';
command.subjectHint = 'A path to destination willfile.';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  'structureParse' : 'Enable parsing of property value. Experimental feature. Default is 0.'
  + '\n\t"will .willfile.extend path/out.debug/criterion:\'debug:[0,1]\'" - will parse criterion as structure.',
  'verbosity' : 'Set verbosity. Default is 3.',
};

//

function commandWillfileSupplement( e )
{
  let cui = this;
  let willfilePropertiesMap = _.mapBut_( null, e.propertiesMap, commandWillfileSupplement.defaults );
  e.propertiesMap = _.mapOnly_( null, e.propertiesMap, commandWillfileSupplement.defaults );
  cui._command_head( commandWillfileSupplement, arguments );

  if( !e.subject && !cui.currentOpeners )
  e.subject = './';

  if( e.subject )
  {
    let o =
    {
      request : e.subject,
      onProperty : _.mapSupplement,
      willfilePropertiesMap,
      ... e.optionsMap,
    };
    return _.will.Module.prototype.willfileExtendProperty.call( cui, o );
  }

  if( cui.currentOpeners )
  return cui._commandBuildLike
  ({
    event : e,
    name : 'willfile supplement',
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
      ... e.optionsMap,
    });
  }
}

commandWillfileSupplement.defaults =
{
  verbosity : 3,
  structureParse : 0,
};

var command = commandWillfileSupplement.command = Object.create( null );
command.hint = 'Extend separate not existed properties of destination willfile.';
command.longHint = 'Extend separate not existed properties of destination willfile. Default willfile is unnamed willfile. Expects at least one property.\n\t"will .willfile.supplement about/name:MyName" - sets in unnamed willfile property "about/name" to "MyName";\n\t"will .willfile.supplement Named about/interpreters/chromium:73.1.0" - throw error if property "interpreters" has String value.\n';
command.subjectHint = 'A path to destination willfile.';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  'structureParse' : 'Enable parsing of property value. Experimental feature. Default is 0.'
  + '\n\t"will .willfile.supplement path/out.debug/criterion:\'debug:[0,1]\'" - will parse criterion as structure.',
  'verbosity' : 'Set verbosity. Default is 3.',
};

//

function commandWillfileExtendWillfile( e )
{
  let cui = this;
  cui._command_head( commandWillfileExtendWillfile, arguments );

  let o =
  {
    request : e.subject,
    onSection : _.mapExtend,
    ... e.optionsMap,
  };
  return _.will.Module.prototype.willfileExtendWillfile.call( cui, o );
}

commandWillfileExtendWillfile.defaults =
{
  'about' : 1,
  'build' : 1,
  'path' : 1,
  'reflector' : 1,
  'step' : 1,
  'submodule' : 1,

  'name' : 1,
  'version' : 1,
  'author' : 1,
  'enabled' : 1,
  'description' : 1,
  'contributors' : 1,
  'interpreters' : 1,
  'license' : 1,
  'keywords' : 1,
  'npm.name' : 1,
  'npm.scripts' : 1,

  'submodulesDisabling' : 0,
  'format' : 'willfile',
  'verbosity' : 3,
};

var command = commandWillfileExtendWillfile.command = Object.create( null );
command.hint = 'Extend willfile by data from source configuration files.';
command.longHint = 'Extend willfile by data from source configuration files. If destination willfile does not exists, the "will.yml" file is created\n\t"will .willfile.extend.willfile ./ Named package.json" - extend unnamed willfile by data from willfile "Named.will.yml" and "package.json".\n';
command.subjectHint = 'The first argument declares path to destination willfile, others declares paths to source files. Could be a glob';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
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
}

//

function commandWillfileSupplementWillfile( e )
{
  let cui = this;
  cui._command_head( commandWillfileSupplementWillfile, arguments );

  let o =
  {
    request : e.subject,
    onSection : _.mapSupplement,
    ... e.optionsMap,
  };
  return _.will.Module.prototype.willfileExtendWillfile.call( cui, o );
}

commandWillfileSupplementWillfile.defaults =
{
  ... commandWillfileExtendWillfile.defaults
};

var command = commandWillfileSupplementWillfile.command = Object.create( null );
command.hint = 'Supplement willfile by data from source configuration files.';
command.longHint = 'Supplement willfile by data from source configuration files. If destination willfile does not exists, the "will.yml" file is created\n\t"will .willfile.supplement.willfile ./ Named package.json" - supplement unnamed willfile by data from willfile "Named.will.yml" and "package.json".\n';
command.subjectHint = 'The first argument declares path to destination willfile, others declares paths to source files. Could be a glob';
command.propertiesAliases = _.mapExtend( null, commandWillfileExtendWillfile.command.propertiesAliases );
command.properties = _.mapExtend( null, commandWillfileExtendWillfile.command.properties );

//

/* qqq : for Dmytro : mess! */
function commandWillfileMergeIntoSingle( e )
{
  /*
   * Dmytro : this strange command is temporary script.
   * The command contains of all main logic. If it needs
   * then command will be divided into separate reusable parts
  */
  let cui = this;
  let fileProvider = cui.fileProvider;
  let path = cui.fileProvider.path;
  let inPath = cui.inPath ? cui.inPath : path.current();
  cui._command_head( commandWillfileMergeIntoSingle, arguments );
  // _.routineOptions( commandWillfileMergeIntoSingle, e.propertiesMap );

  let willfileName = e.optionsMap.primaryPath || 'CommandWillfileMergeIntoSingle';

  let o =
  {
    request : willfileName + ' ./',
    onSection : _.mapSupplement,
  };
  _.will.Module.prototype.willfileExtendWillfile.call( cui, o );

  if( e.optionsMap.secondaryPath )
  {
    let o2 =
    {
      request : `${ willfileName } ${ e.optionsMap.secondaryPath }`,
      name : 0,
      onSection : _.mapExtend,
    };
    _.will.Module.prototype.willfileExtendWillfile.call( cui, o2 );
  }

  let dstPath = filesFind( willfileName, 1 );
  _.assert( dstPath.length === 1 );
  dstPath = dstPath[ 0 ];

  let logger = _.logger.relativeMaybe( cui.transaction.logger, cui.fileProviderVerbosityDelta );

  let config = fileProvider.fileRead({ filePath : dstPath.absolute, encoding : 'yaml', logger });
  filterAboutNpmFields();
  filterSubmodulesCriterions();
  if( e.optionsMap.filterSameSubmodules )
  filterSameSubmodules()
  if( e.optionsMap.submodulesDisabling )
  submodulesDisable();
  fileProvider.fileWrite({ filePath : dstPath.absolute, data : config, encoding : 'yaml', logger });

  /* */

  renameFiles();

  return null;

  /* */

  function filesFind( srcPath, dst )
  {
    if( dst && path.isGlob( srcPath ) )
    throw _.err( 'Path to destination file should have not globs.' );

    srcPath = path.join( inPath, srcPath );

    if( fileProvider.isDir( srcPath ) )
    srcPath = path.join( srcPath, './' );

    return cui.willfilesFind
    ({
      commonPath : srcPath,
      withIn : 1,
      withOut : 0,
    });
  }

  /* */

  function filterSubmodulesCriterions()
  {
    let submodules = config.submodule;
    for( let name in submodules )
    {
      let criterions = submodules[ name ].criterion;
      if( criterions )
      if( criterions.debug )
      if( !_.longHasAny( _.mapKeys( criterions ) ), [ 'development', 'optional' ] )
      {
        delete criterions.debug;
        criterions.development = 1;
      }
    }
  }

  /* */

  function filterAboutNpmFields()
  {
    let about = config.about;
    for( let name in about )
    {
      if( !_.strBegins( name, 'npm.' ) )
      continue;

      if( _.arrayIs( about[ name ] ) )
      {
        about[ name ] = _.arrayRemoveDuplicates( about[ name ] );
      }
      else if( _.aux.is( about[ name ] ) )
      {
        let npmMap = about[ name ];
        let reversedMap = Object.create( null );

        for( let property in npmMap )
        if( npmMap[ property ] in reversedMap )
        filterPropertyByName( npmMap, reversedMap, property )
        else
        reversedMap[ npmMap[ property ] ] = property;
      }
    }
  }

  /* */

  function filterPropertyByName( srcMap, butMap, property )
  {
    if( _.strHas( property, '-' ) )
    delete srcMap[ property ];
    else if( _.strHas( butMap[ srcMap[ property ] ], '-' ) )
    delete srcMap[ butMap[ srcMap[ property ] ] ];
    else if( !_.strHasAny( property, [ '.', '-' ] ) )
    {
      if( !_.strHasAny( butMap[ srcMap[ property ] ], [ '.', '-' ] ) )
      delete srcMap[ butMap[ srcMap[ property ] ] ];
    }
  }

  /* */

  function filterSameSubmodules()
  {
    let submodules = config.submodule;
    let regularPaths = new Set();
    let mergedSubmodules = Object.create( null );
    for( let name in submodules )
    {
      let parsed = _.uri.parse( submodules[ name ].path );

      let parsedModuleName;
      if( _.longHas( parsed.protocols, 'npm' ) )
      {
        parsedModuleName = _.npm.path.parse( submodules[ name ].path ).host;
      }
      else if( _.longHas( parsed.protocols, 'git' ) )
      {
        parsedModuleName = _.npm.path.parse({ remotePath : submodules[ name ].path, full : 0, atomic : 0, objects : 1 }).repo;
      }
      else
      {
        if( regularPaths.has( submodules[ name ].path ) )
        continue;

        regularPaths.add( submodules[ name ].path );
        parsedModuleName = name;
      }

      if( !( parsedModuleName in mergedSubmodules ) )
      mergedSubmodules[ parsedModuleName ] = submodules[ name ];
    }
    config.submodule = mergedSubmodules;
  }

  /* */

  function submodulesDisable()
  {
    if( !config )
    config = configRead( dstPath.absolute ); /* qqq : for Dmytro : ?? */
    for( let dependency in config.submodule )
    config.submodule[ dependency ].enabled = 0;
  }

  /* */

  function renameFiles()
  {
    let unnamedWillfiles = filesFind( './.*' );
    for( let i = 0 ; i < unnamedWillfiles.length ; i++ )
    {
      let oldName = unnamedWillfiles[ i ].absolute;
      let newName = path.join( unnamedWillfiles[ i ].dir, 'Old' + unnamedWillfiles[ i ].fullName );
      fileProvider.fileRename( newName, oldName );
    }

    if( !e.optionsMap.primaryPath )
    {
      let oldName = dstPath.absolute;
      let newName = path.join( dstPath.dir, 'will.yml' );
      fileProvider.fileRename( newName, oldName );
    }
  }
}

commandWillfileMergeIntoSingle.defaults =
{
  verbosity : 3,
  primaryPath : null,
  secondaryPath : null,
  submodulesDisabling : 1,
  filterSameSubmodules : 1,
};

var command = commandWillfileMergeIntoSingle.command = Object.create( null );
command.hint = 'Merge unnamed export and import willfiles into single file.';
command.subjectHint = false;
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  verbosity : 'Set verbosity. Default is 3.',
  primaryPath : 'Name of destination willfile. Default is `will.yml`',
  secondaryPath : 'Name of file to extend destination willfile',
  submodulesDisabling : 'Disables submodules in the destination willfile. Default is 1',
  filterSameSubmodules : 'Enables filtering of submodules with the same path but different names. Default is 1',
};

// --
// git
// --

function commandGit( e )
{
  let cui = this;

  let commandOptions = _.mapBut_( null, e.propertiesMap, commandGit.command.properties );
  if( _.mapKeys( commandOptions ).length >= 1 )
  {
    e.subject += ' ' + _.mapToStr({ src : commandOptions, entryDelimeter : ' ' });
    e.propertiesMap = _.mapBut_( null, e.propertiesMap, commandOptions );
  }

  cui._command_head( commandGit, arguments );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'git',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandGit,
  });

  function handleEach( module )
  {
    return module.gitExecCommand
    ({
      dirPath : module.dirPath,
      command : e.subject,
      verbosity : cui.transaction.verbosity,
      hardLinkMaybe : e.optionsMap.hardLinkMaybe,
      profile : e.optionsMap.profile
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitExecCommand
  //   ({
  //     dirPath : it.junction.dirPath,
  //     command : e.subject,
  //     verbosity : cui.transaction.verbosity,
  //     hardLinkMaybe : e.optionsMap.hardLinkMaybe,
  //     profile : e.optionsMap.profile
  //   });
  // }
}

commandGit.defaults =
{
  hardLinkMaybe : 0,
  profile : 'default',
  withSubmodules : 0
};
var command = commandGit.command = Object.create( null );
command.hint = 'Run custom Git command in repository of module.';
command.subjectHint = 'Custom git command exclude name of command "git".';
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  hardLinkMaybe : 'Disables saving of hardlinks. Default value is 0.',
  profile : 'A name of profile to get path for hardlinking. Default is "default".',
  ... commandImply.command.properties
};

//

function commandGitDiff( e )
{
  let cui = this;
  cui._command_head( commandGitDiff, arguments );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'git diff',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandGitDiff,
  });

  function handleEach( module )
  {
    return module.gitDiff
    ({
      dirPath : module.dirPath,
      verbosity : cui.transaction.verbosity,
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitDiff
  //   ({
  //     dirPath : it.junction.dirPath,
  //     verbosity : cui.transaction.verbosity,
  //   });
  // }
}

commandGitDiff.defaults =
{
  withSubmodules : 0
};
var command = commandGitDiff.command = Object.create( null );
command.hint = 'Get diffs in module repository.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties = _.mapExtend( null, commandImply.command.properties );

//

function commandGitPull( e )
{
  let cui = this;
  cui._command_head( commandGitPull, arguments );
  // let profile = e.propertiesMap.profile;
  // if( 'profile' in e.propertiesMap )
  // delete e.propertiesMap.profile;

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'git pull',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandGitPull,
  });

  function handleEach( module )
  {
    return module.gitPull
    ({
      dirPath : module.dirPath,
      verbosity : cui.transaction.verbosity,
      profile : e.optionsMap.profile,
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitPull
  //   ({
  //     dirPath : it.junction.dirPath,
  //     verbosity : cui.transaction.verbosity,
  //     profile : e.optionsMap.profile,
  //   });
  // }
}

commandGitPull.defaults =
{
  withSubmodules : 0,
  profile : 'default',
};
var command = commandGitPull.command = Object.create( null );
command.hint = 'Pull changes from remote repository.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  profile : 'A name of profile to get path for hardlinking. Default is "default".',
  ... commandImply.command.properties
};

//

function commandGitPush( e )
{
  let cui = this;
  cui._command_head( commandGitPush, arguments );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'git push',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandGitPush,
  });

  function handleEach( module )
  {
    return module.gitPush
    ({
      dirPath : module.dirPath,
      verbosity : cui.transaction.verbosity,
      ... _.mapOnly_( null, e.optionsMap, module.gitPush.defaults ),
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitPush
  //   ({
  //     dirPath : it.junction.dirPath,
  //     verbosity : cui.transaction.verbosity,
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.gitPush.defaults ),
  //   });
  // }
}

commandGitPush.defaults =
{
  withSubmodules : 0,
  verbosity : 3,
  withTags : 1,
  force : 1,
  dry : 0,
};
var command = commandGitPush.command = Object.create( null );
command.hint = 'Push commits and tags to remote repository.';
command.subjectHint = false;
command.propertiesAliases = _.mapExtend( null, commandImply.command.propertiesAliases );
command.properties =
{
  ... commandImply.command.properties,
  withTags : 'Enable pushing of tags. Default is 1',
  force : 'Enable force pushing of commit history and tags. Default is 1',
  dry : 'Enable dry pushing of commit history and tags. Default is 0',
};

//

function commandGitReset( e )
{
  let cui = this;
  cui._command_head( commandGitReset, arguments );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'git reset',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandGitReset,
  });

  function handleEach( module )
  {
    return module.gitReset({ ... _.mapOnly_( null, e.optionsMap, module.gitReset.defaults ) });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitReset
  //   ({
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.gitReset.defaults )
  //   });
  // }
}

commandGitReset.defaults =
{
  ... commandImply.defaults,

  dirPath : '.',
  removingUntracked : 0,
  removingIgnored : 0,
  removingSubrepositories : 0,
  dry : 0,
  verbosity : 2,
  withSubmodules : 0
};
var command = commandGitReset.command = Object.create( null );
command.hint = 'Reset local changes in repository of the module.';
command.subjectHint = false;
command.propertiesAliases =
{
  verbosity : [ 'v' ]
};
command.properties =
{
  ... commandImply.command.properties,
  dirPath : 'Path to local cloned Git directory. Default is directory of current module.',
  removingUntracked : 'Remove untracked files, option does not enable deleting of ignored files. Default is removingUntracked:0.',
  removingIgnored : 'Enable deleting of ignored files. Default is removingIgnored:1.',
  removingSubrepositories : 'Enable deleting of git subrepositories in repository of module. Default is removingIgnored:1.',
  dry : 'Dry run without resetting. Default is dry:0.',
  verbosity : 'Set verbosity. Default is 2.',
};

//

function commandGitStatus( e )
{
  let cui = this;
  cui._command_head( commandGitStatus, arguments );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'git status',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandGitStatus,
  });

  function handleEach( module )
  {
    return module.gitStatus({ ... _.mapOnly_( null, e.optionsMap, module.gitStatus.defaults ) });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitStatus
  //   ({
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.gitStatus.defaults )
  //   });
  // }
}

commandGitStatus.defaults =
{
  ... commandImply.defaults,

  local : 1,
  uncommittedIgnored : 0,
  remote : 1,
  remoteBranches : 0,
  prs : 1,
  verbosity : 1,
  withSubmodules : 0
};
var command = commandGitStatus.command = Object.create( null );
command.hint = 'Check the status of the repository.';
command.subjectHint = false;
command.propertiesAliases =
{
  verbosity : [ 'v' ]
};
command.properties =
{
  ... commandImply.command.properties,
  local : 'Check local commits. Default value is 1.',
  uncommittedIgnored : 'Check ignored local files. Default value is 0.',
  remote : 'Check remote unmerged commits. Default value is 1.',
  remoteBranches : 'Check remote branches. Default value is 0.',
  prs : 'Check pull requests. Default is prs:1.',
  verbosity : 'Set verbosity. Default is 1.',
};

//

function commandGitSync( e )
{
  let cui = this;
  cui._command_head( commandGitSync, arguments );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'git sync',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandGitSync,
    ... cui.transaction.relationFilterFieldsGet()
  });

  function handleEach( module )
  {

    return module.gitSync
    ({
      commit : e.subject,
      ... _.mapOnly_( null, e.optionsMap, module.gitSync.defaults ),
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitSync
  //   ({
  //     commit : e.subject,
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.gitSync.defaults )
  //   });
  // }
}

commandGitSync.defaults =
{
  ... commandImply.defaults,

  dirPath : null,
  dry : 0,
  profile : 'default',
  // verbosity : 1,
  // withSubmodules : 0
};
var command = commandGitSync.command = Object.create( null );
command.hint = 'Syncronize local and remote repositories.';
command.subjectHint = 'A commit message. Default value is "."';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
};
command.properties =
{
  ... commandImply.command.properties,
  dirPath : 'Path to local cloned Git directory. Default is directory of current module.',
  dry : 'Dry run without syncronizing. Default is dry:0.',
  verbosity : 'Set verbosity. Default is 1.',
  profile : 'A name of profile to get path for hardlinking. Default is "default".',
};

//

function commandGitTag( e )
{
  let cui = this;
  cui._command_head( commandGitTag, arguments );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'git tag',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandGitTag,
  });

  function handleEach( module )
  {
    return module.gitTag({ ... _.mapOnly_( null, e.optionsMap, module.gitTag.defaults ) });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.gitTag
  //   ({
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.gitTag.defaults )
  //   });
  // }
}

commandGitTag.defaults =
{
  ... commandImply.defaults,
  name : '.',
  description : '',
  toVersion : null,
  dry : 0,
  light : 0,
  verbosity : 1,
  withSubmodules : 0
};
var command = commandGitTag.command = Object.create( null );
command.hint = 'Add tag for commit.';
command.subjectHint = false;
command.propertiesAliases =
{
  verbosity : [ 'v' ]
};
command.properties =
{
  ... commandImply.command.properties,
  name : 'Tag name. Default is name:".".',
  description : 'Description of annotated tag. Default is description:"".',
  toVersion : 'The commit to add tag. Default is current HEAD commit.',
  dry : 'Dry run without tagging. Default is dry:0.',
  light : 'Enables lightweight tags. Default is light:0.',
  verbosity : 'Set verbosity. Default is 1.',
};

//

function commandGitHookPreservingHardLinks( e )
{
  let cui = this;
  cui._command_head( commandGitHookPreservingHardLinks, arguments );

  let enable = _.numberFrom( e.instructionArgument );

  if( enable )
  _.git.hookPreservingHardLinksRegister();
  else
  _.git.hookPreservingHardLinksUnregister();
}

var command = commandGitHookPreservingHardLinks.command = Object.create( null );
command.hint = 'Switch on preserving hardlinks.';
command.subjectHint = 'Any subject to enable preserving hardliks.';

//

function commandRepoPullOpen( e )
{
  let cui = this;
  cui._command_head( commandRepoPullOpen, arguments );

  // return cui._commandBuildLike
  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'repo pull open',
    onEachModule : handleEach,
    // onEach : handleEach,
    commandRoutine : commandRepoPullOpen,
  });

  function handleEach( module )
  {
    return module.repoPullOpen
    ({
      title : e.subject,
      ... _.mapOnly_( null, e.optionsMap, module.repoPullOpen.defaults ),
    });
  }
  // function handleEach( it )
  // {
  //   return it.opener.openedModule.repoPullOpen
  //   ({
  //     title : e.subject,
  //     ... _.mapOnly_( null, e.optionsMap, it.opener.openedModule.repoPullOpen.defaults ),
  //   });
  // }
}

commandRepoPullOpen.defaults =
{
  ... commandImply.defaults,

  token : null,
  srcBranch : null,
  dstBranch : 'master',
  // title : null, /* Dmytro : rewrites options */
  body : null,
  verbosity : 2,
  withSubmodules : 1
};
var command = commandRepoPullOpen.command = Object.create( null );
command.hint = 'Open pull request from current modules.';
command.subjectHint = 'A title for PR';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
};
command.properties =
{
  ... commandImply.command.properties,
  token : 'An individual authorization token. By default reads from user config file.',
  srcBranch : 'A source branch. If PR opens from fork format should be "{user}:{branch}".',
  dstBranch : 'A destination branch. Default is "master".',
  title : 'Option that rewrite title in provided argument.',
  body : 'Body message.',
  verbosity : 'Set verbosity. Default is 2.',
};

//

function commandRepoPullList( e )
{
  let cui = this;

  cui._command_head( commandRepoPullList, arguments );

  _.assert( _.numberDefined( e.optionsMap.verbosity ) );
  let o2 = e.optionsMap;
  o2.logger = o2.verbosity;
  delete o2.verbosity;
  _.mapOnly_( o2, o2, _.will.Module.prototype.repoPullList.defaults );

  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'repo pull list',
    onEachModule : handleEachModule,
    commandRoutine : commandRepoPullList,
    recursive : 0,
  });

  function handleEachModule( module, op )
  {
    return module.repoPullList( _.mapExtend( null, o2 ) );
  }

}

commandRepoPullList.defaults = _.mapExtend( null,
{
  token : null,
  withOpened : 1,
  withClosed : 0,
  verbosity : 2,
})

var command = commandRepoPullList.command = Object.create( null );
command.hint = 'Open pull request from current modules.';
command.subjectHint = 'A title for PR';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties = _.mapExtend( null,
{
  token : 'An individual authorization token. By default reads from user config file.',
  withOpened : 'List closed PR-s. By default it is true.',
  withClosed : 'List closed PR-s. By default it is false.',
  verbosity : 'Set verbosity. Default is 2.',
});

//

function commandRepoProgramList( e )
{
  let cui = this;

  cui._command_head( commandRepoProgramList, arguments );
  cui._transactionExtend( commandRepoProgramList, e.propertiesMap );
  _.routineOptions( commandRepoProgramList, e.propertiesMap );

  _.assert( _.numberDefined( e.propertiesMap.verbosity ) );
  let o2 = e.propertiesMap;
  o2.logger = o2.verbosity;
  delete o2.verbosity;
  _.mapOnly_( o2, o2, _.will.Module.prototype.repoPullList.defaults );

  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'repo program list',
    onEachModule : handleEachModule,
    commandRoutine : commandRepoProgramList,
    recursive : 0,
  });

  function handleEachModule( module, op )
  {
    return module.repoProgramList( _.mapExtend( null, o2 ) );
  }

}

commandRepoProgramList.defaults = _.mapExtend( null,
{
  token : null,
  verbosity : 2,
})

var command = commandRepoProgramList.command = Object.create( null );
command.hint = 'List prototypes of procedures of the module.';
command.subjectHint = 'A title for PR';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties = _.mapExtend( null,
{
  token : 'An individual authorization token. By default reads from user config file.',
  verbosity : 'Set verbosity. Default is 2.',
});

//

function commandRepoProgramProcessList( e )
{
  let cui = this;

  cui._command_head( commandRepoProgramProcessList, arguments );
  cui._transactionExtend( commandRepoProgramProcessList, e.propertiesMap );
  _.routineOptions( commandRepoProgramProcessList, e.propertiesMap );

  _.assert( _.numberDefined( e.propertiesMap.verbosity ) );
  let o2 = e.propertiesMap;
  o2.logger = o2.verbosity;
  delete o2.verbosity;
  _.mapOnly_( o2, o2, _.will.Module.prototype.repoPullList.defaults );

  return cui._commandModuleOrientedLike
  ({
    event : e,
    name : 'repo program process list', /* xxx : remove */
    onEachModule : handleEachModule,
    commandRoutine : commandRepoProgramProcessList,
    recursive : 0,
  });

  function handleEachModule( module, op )
  {
    return module.repoProgramProcessList( _.mapExtend( null, o2 ) );
  }

}

commandRepoProgramProcessList.defaults = _.mapExtend( null,
{
  token : null,
  verbosity : 2,
})

var command = commandRepoProgramProcessList.command = Object.create( null );
command.hint = 'List prototypes of procedures of the module.';
command.subjectHint = 'A title for PR';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties = _.mapExtend( null,
{
  token : 'An individual authorization token. By default reads from user config file.',
  verbosity : 'Set verbosity. Default is 2.',
});

// --
// npm
// --

/* aaa2 :
will .willfile.extend dst/ src1 dir/src2 src/
will .willfile.extend dst src1 dir/src2 src/
will .willfile.extend dst 'src1/**' dir/src2 src/

will .willfile.extend dst src submodules:1 npm.name:1, version:1 contributors:1 format:willfile

algorithm similar to mapExtendAppending

if anon then will.yml
else then name.will.yml

*/

function commandNpmPublish( e )
{
  let cui = this;
  cui._command_head( commandNpmPublish, arguments );

  return cui._commandBuildLike
  ({
    event : e,
    name : 'publish',
    onEach : handleEach,
    commandRoutine : commandNpmPublish,
  });

  function handleEach( it )
  {
    return it.opener.openedModule.npmModulePublish
    ({
      ... e.optionsMap,
      commit : e.subject,
    });
  }
}

commandNpmPublish.defaults =
{
  commit : null,
  tag : null,

  force : 0,
  dry : 0,
  verbosity : 1,
};

var command = commandNpmPublish.command = Object.create( null );
command.hint = 'Publish in NPM.';
command.subjectHint = 'A commit message for uncommitted changes. Default is ".".';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  commit : 'message', /* qqq : for Dmytro : bad : bad name */
  tag : 'tag',
  force : 'forces diff',
  dry : 'dry run',
  verbosity : 'verbosity',
};
/* qqq : for Dmytro : bad : break of pattern */

//

/* qqq : for Dmytro : first cover
will .npm.dep.add . dry:1 editing:0
*/

/* qqq : for Dmytro : write full coverage */

function commandNpmDepAdd( e )
{
  let cui = this;
  cui._command_head( commandNpmDepAdd, arguments );

  _.sure( _.strDefined( e.subject ), 'Expects dependency path in subject' );

  e.optionsMap.depPath = e.subject;
  e.optionsMap.localPath = e.optionsMap.to;
  delete e.optionsMap.to;

  return cui.npmDepAdd( e.optionsMap );
}

commandNpmDepAdd.defaults =
{
  to : null,
  as : null,
  editing : 1,
  downloading : 1,
  linking : 1,
  dry : 0,
  verbosity : 1,
};

var command = commandNpmDepAdd.command = Object.create( null );
command.hint = 'Add as dependency to NPM.';
command.subjectHint = 'Dependency path.';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  to : 'Path to the directory with directory node_modules. Current path by default.',
  as : 'Add dependency with the alias.',
  editing : 'Editing package.json file. Default is true.',
  downloading : 'Downloading files. Default is true.',
  linking : 'Softlink instead of copying. Default is true.',
  dry : 'Dry run.',
  verbosity : 'Verbosity.',
};
/* qqq : for Dmytro : implement and cover each property */

//

function commandNpmInstall( e )
{
  let cui = this;
  let logger = cui.transaction.logger;
  let fileProvider = cui.fileProvider;
  let path = fileProvider.path;
  let ready = _.take( null );

  cui._command_head( commandNpmInstall, arguments );

  let o = e.optionsMap;
  delete o.v;

  _.routineOptions( commandNpmInstall, o );
  _.sure( !e.subject );

  // o.logger = new _.Logger({ output : logger });
  o.logger = new _.Logger({ output : cui.transaction.logger });
  o.logger.verbosity = o.verbosity;
  delete o.verbosity;
  o.localPath = path.resolve( o.to || '.' );
  delete o.to;

  return _.npm.install( o );
}

commandNpmInstall.defaults =
{
  to : null,
  locked : null,
  linkingSelf : 1,
  dry : 0,
  verbosity : 2,
};

/* qqq2 : for Dmytro : write test routines
- make sure there is test wich delete submodule which already has a link. files which are referred by the link should not be deleted
- duplicate tests in NpmTools and willbe
*/

var command = commandNpmInstall.command = Object.create( null );
command.hint = 'Add as dependency to NPM.';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  to : 'Path to directory with package.json file. Default is current directory.',
  linkingSelf : 'Softlink itself. Default is true.',
  locked : 'Use package-lock.json instead of package.json. By default use lock files if the file exists otherwise use package.json.',
  dry : 'Dry run.',
  verbosity : 'Verbosity.',
};

//

function commandNpmClean( e )
{
  let cui = this;
  let logger = cui.transaction.logger;
  let fileProvider = cui.fileProvider;
  let path = fileProvider.path;
  let ready = _.take( null );

  cui._command_head( commandNpmClean, arguments );

  let o = e.optionsMap;
  delete o.v;

  _.routineOptions( commandNpmClean, o );
  _.sure( !e.subject );

  // o.logger = new _.Logger({ output : logger });
  o.logger = new _.Logger({ output : cui.transaction.logger });
  o.logger.verbosity = o.verbosity;
  delete o.verbosity;
  o.localPath = path.resolve( o.to || '.' );
  delete o.to;

  return _.npm.clean( o );
}

commandNpmClean.defaults =
{
  to : null,
  dry : 0,
  verbosity : 1,
};

var command = commandNpmClean.command = Object.create( null );
command.hint = 'NPM clean.';
command.propertiesAliases =
{
  verbosity : [ 'v' ]
}
command.properties =
{
  to : 'Path to directory with package.json file. Default is current directory.',
  dry : 'Dry run.',
  verbosity : 'Verbosity.',
};

// --
// package
// --

function commandPackageInstall( e )
{
  let cui = this;

  let isolated = _.strIsolateLeftOrAll( e.instructionArgument, ' ' );
  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  /*let options = */e.propertiesMap = _.strStructureParse( isolated[ 2 ] );

  cui._command_head( commandPackageInstall, arguments );

  let options = e.optionsMap;

  _.map.assertHasOnly( options, commandPackageInstall.command.properties, `Command does not expect options:` );

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

var command = commandPackageInstall.command = Object.create( null );
command.hint = 'Install target package.';
command.subjectHint = 'A name or path to package.';
command.properties =
{
  sudo : 'Install package with privileges of superuser.',
  reinstall : 'Force package manager to reinstall the package.'
}

//

function commandPackageLocalVersions( e )
{
  let cui = this;
  let ready = _.take( null );

  let isolated = _.strIsolateLeftOrAll( e.instructionArgument, ' ' );
  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  /* let options = */e.propertiesMap = _.strStructureParse( isolated[ 2 ] );

  cui._command_head( commandPackageLocalVersions, arguments );

  let options = e.optionsMap;

  _.map.assertHasOnly( options, commandPackageLocalVersions.command.properties, `Command does not expect options:` );

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

var command = commandPackageLocalVersions.command = Object.create( null );
command.hint = 'Get list of package versions avaiable locally.';
command.subjectHint = 'A name of package.';

//

function commandPackageRemoteVersions( e )
{
  let cui = this;
  let logger = cui.transaction.logger;
  let ready = _.take( null );

  let isolated = _.strIsolateLeftOrAll( e.instructionArgument, ' ' );
  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  /*let options = */e.propertiesMap = _.strStructureParse( isolated[ 2 ] );

  cui._command_head( commandPackageRemoteVersions, arguments );

  let options = e.optionsMap;

  _.map.assertHasOnly( options, commandPackageRemoteVersions.command.properties, `Command does not expect options:` );

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

var command = commandPackageRemoteVersions.command = Object.create( null );
command.hint = 'Get list of package versions avaiable in remote archive.';
command.subjectHint = 'A name of package.';
command.properties =
{
  all : 'Gets verions of package from remote archive.',
}

//

function commandPackageVersion( e )
{
  let cui = this;
  let ready = _.take( null );

  let isolated = _.strIsolateLeftOrAll( e.instructionArgument, ' ' );
  let parsed = _.uri.parseConsecutive( isolated[ 0 ] );
  /*let options = */e.propertiesMap = _.strStructureParse( isolated[ 2 ] );

  cui._command_head( commandPackageVersion, arguments );

  let options = e.optionsMap;

  _.map.assertHasOnly( options, commandPackageVersion.command.properties, `Command does not expect options:` );

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

var command = commandPackageVersion.command = Object.create( null );
command.hint = 'Get version of installed package.';
command.subjectHint = 'A name of package.';

// --
// relations
// --

// let currentOpenerSymbol = Symbol.for( 'currentOpener' );

let Composes =
{
  // beeping : 0,
}

let Aggregates =
{
}

let Associates =
{
  currentOpeners : null,
  // currentOpenerPath : null,
}

let Restricts =
{
  topCommand : null,
  will : null,
  implied : _.define.own( {} ),
  transactionOld : null
}

let Statics =
{
  Exec,
}

let Forbids =
{
  currentPath : 'currentPath',
  currentOpenerPath : 'currentOpenerPath',
}

let Accessors =
{
  currentOpener : { writable : 0 },
  beeping : { get : beepingGet, writable : 0 }
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
  openersFindMaybe,
  // currentOpenerChange,

  // etc

  _command_head,
  errEncounter,
  // _propertiesImplyToMain,
  _propertiesImply,
  _transactionBegin,
  _transactionExtend,

  beepingGet,

  // meta command

  _commandsMake,
  _commandsBegin,
  _commandsEnd,

  _commandListLike,
  _commandBuildLike,
  _commandCleanLike,
  _commandNewLike,
  _commandTreeLike,
  _commandModulesLike, /* qqq : for Dmytro : remove */
  _commandModuleOrientedLike,

  // command

  commandHelp,
  commandImply,

  commandVersion,
  commandVersionCheck,
  commandVersionBump,

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
  commandModulesUpdate,

  commandSubmodulesAdd,
  commandSubmodulesFixate,
  commandSubmodulesUpgrade,

  commandSubmodulesVersionsDownload,
  commandSubmodulesVersionsUpdate,
  commandSubmodulesVersionsVerify,
  commandSubmodulesVersionsAgree,

  commandSubmodulesShell,
  commandSubmodulesGit,
  commandSubmodulesGitDiff,
  commandSubmodulesRepoPullOpen,
  commandSubmodulesGitStatus,
  commandSubmodulesGitSync,

  commandModuleNew,
  commandModuleNewWith,

  commandModulesShell,
  commandModulesGit,
  commandModulesGitDiff,
  commandModulesRepoPullOpen,
  commandModulesGitStatus,
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

  // command iterator

  commandWith,
  commandModules,
  commandSubmodules,
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
  commandWillfileMergeIntoSingle,

  // command git

  commandGit,
  commandGitDiff,
  commandGitPull,
  commandGitPush,
  commandGitReset,
  commandGitStatus,
  commandGitSync,
  commandGitTag,
  commandGitHookPreservingHardLinks,

  commandRepoPullOpen, /* aaa : cover */ /* Dmytro : covered */
  commandRepoPullList,
  commandRepoProgramList,
  commandRepoProgramProcessList,

  // npm

  commandNpmPublish,
  commandNpmDepAdd,
  commandNpmInstall,
  commandNpmClean,

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

