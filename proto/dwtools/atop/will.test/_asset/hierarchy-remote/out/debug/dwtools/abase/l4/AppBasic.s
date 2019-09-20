( function _AppBasic_s_() {

'use strict';

/**
 * Collection of routines to execute system commands, run shell, batches, launch external processes from JavaScript application. ExecTools leverages not only outputting data from an application but also inputting, makes application arguments parsing and accounting easier. Use the module to get uniform experience from interaction with an external processes on different platforms and operating systems.
  @module Tools/base/ProcessBasic
*/

/**
 * @file ProcessBasic.s.
 */

/**
 * Collection of routines to execute system commands, run shell, batches, launch external processes from JavaScript application.
  @namespace Tools( module::ProcessBasic )
  @memberof module:Tools/base/ProcessBasic
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wPathBasic' );
  _.include( 'wGdfStrategy' );
  _.include( 'wConsequence' );

}

let System, ChildProcess;
let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools.app || _global_.wTools.app || Object.create( null );

_.assert( !!_realGlobal_ );

// --
// exec
// --

function shell_pre( routine, args )
{
  let o;

  if( _.strIs( args[ 0 ] ) || _.arrayIs( args[ 0 ] ) )
  o = { execPath : args[ 0 ] };
  else
  o = args[ 0 ];

  o = _.routineOptions( routine, o );

  _.assert( arguments.length === 2 );
  _.assert( args.length === 1, 'Expects single argument' );
  _.assert( _.arrayHas( [ 'fork', 'exec', 'spawn', 'shell' ], o.mode ) );
  _.assert( !!o.args || !!o.execPath, 'Expects {-args-} either {-execPath-}' )
  _.assert( o.args === null || _.arrayIs( o.args ) || _.strIs( o.args ) );
  _.assert( o.execPath === null || _.strIs( o.execPath ) || _.strsAreAll( o.execPath ), 'Expects string or strings {-o.execPath-}, but got', _.strType( o.execPath ) );
  _.assert( o.timeOut === null || _.numberIs( o.timeOut ), 'Expects null or number {-o.timeOut-}, but got', _.strType( o.timeOut ) );

  return o;
}

//

/**
 * @summary Executes command in a controled child process.
 *
 * @param {Object} o Options map
 * @param {String} o.execPath Command to execute, path to application, etc.
 * @param {String} o.currentPath Current working directory of child process.

 * @param {Boolean} o.sync=0 Execute command in synchronous mode.
   There are two synchrounous modes: first uses sync method of `ChildProcess` module , second uses async method, but in combination with {@link https://www.npmjs.com/package/deasync deasync} and `wConsequence` to turn async execution into synchrounous.
   Which sync mode will be selected depends on value of `o.deasync` option.
   Sync mode returns options map.
   Async mode returns instance of {@link module:Tools/base/Consequence.Consequence wConsequence} with gives a message( options map ) when execution of child process is finished.
 * @param {Boolean} o.deasync=1 Controls usage of `deasync` module in synchrounous mode. Allows to run command synchrounously in modes( o.mode ) that don't support synchrounous execution, like `fork`.

 * @param {Array} o.args=null Arguments for command.
 * @param {Array} o.interpreterArgs=null Arguments for node. Used only in `fork` mode. {@link https://nodejs.org/api/cli.html Command Line Options}
 * @param {String} o.mode='shell' Execution mode. Possible values: `fork`, `exec`, `spawn`, `shell`. {@link https://nodejs.org/api/child_process.html Details about modes}
 * @param {Object} o.ready=null `wConsequence` instance that gives a message when execution is finished.
 * @param {Object} o.logger=null `wLogger` instance that prints output during command execution.

 * @param {Object} o.env=null Environment variables( key-value pairs ).
 * @param {String/Array} o.stdio='pipe' Controls stdin,stdout configuration. {@link https://nodejs.org/api/child_process.html#child_process_options_stdio Details}
 * @param {Boolean} o.ipc=0  Creates `ipc` channel between parent and child processes.
 * @param {Boolean} o.detaching=0 Creates independent process for a child. Allows child process to continue execution when parent process exits. Platform dependent option. {@link https://nodejs.org/api/child_process.html#child_process_options_detached Details}.
 * @param {Boolean} o.passingThrough=0 Allows to pass arguments of parent process to the child process.
 * @param {Boolean} o.concurrent=0 Allows paralel execution of several child processes. By default executes commands one by one.
 * @param {Number} o.timeOut=null Time in milliseconds before execution will be terminated.

 * @param {Boolean} o.throwingExitCode=1 Throws an Error if child process returns non-zero exit code. Child returns non-zero exit code if it was terminated by parent, timeOut or when internal error occurs.

 * @param {Boolean} o.applyingExitCode=0 Applies exit code to parent process.

 * @param {Number} o.verbosity=2 Controls amount of output, `0` disables output at all.
 * @param {Boolean} o.outputGray=0 Logger prints everything in raw mode, no styles applied.
 * @param {Boolean} o.outputGrayStdout=0 Logger prints output from `stdout` in raw mode, no styles applied.
 * @param {Boolean} o.outputPrefixing=0 Add prefix with name of output channel( stderr, stdout ) to each line.
 * @param {Boolean} o.outputPiping=null Handles output from `stdout` and `stderr` channels. Is enabled by default if `o.verbosity` levels is >= 2 and option is not specified explicitly. This option is required by other "output" options that allows output customization.
 * @param {Boolean} o.outputCollecting=0 Enables coullection of output into sinle string. Collects output into `o.output` property if enabled.
 * @param {Boolean} o.outputAdditive=null Prints output during execution. Enabled by default if shell executes only single command and option is not specified explicitly.
 * @param {Boolean} o.inputMirroring=1 Print complete input line before execution: path to command, arguments.
 *
 * @return {Object} Returns `wConsequence` instance in async mode. In sync mode returns options map. Options map contains not only input options, but child process descriptor, collected output, exit code and other useful info.
 *
 * @example //short way, command and arguments in one string
 *
 * let _ = require('wTools')
 * _.include( 'wAppBasic' )
 * _.include( 'wConsequence' )
 * _.include( 'wLogger' )
 *
 * let con = _.process.start( 'node -v' );
 *
 * con.then( ( got ) =>
 * {
 *  console.log( 'ExitCode:', got.exitCode );
 *  return got;
 * })
 *
 * @example //command and arguments as options
 *
 * let _ = require('wTools')
 * _.include( 'wAppBasic' )
 * _.include( 'wConsequence' )
 * _.include( 'wLogger' )
 *
 * let con = _.process.start({ execPath : 'node', args : [ '-v' ] });
 *
 * con.then( ( got ) =>
 * {
 *  console.log( 'ExitCode:', got.exitCode );
 *  return got;
 * })
 *
 * @function shell
 * @memberof module:Tools/base/ProcessBasic.Tools( module::ProcessBasic )
 */

function shell_body( o )
{

  _.assertRoutineOptions( shell, arguments );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.arrayHas( [ 'fork', 'exec', 'spawn', 'shell' ], o.mode ) );
  _.assert( !!o.args || !!o.execPath, 'Expects {-args-} either {-execPath-}' )
  _.assert( o.args === null || _.arrayIs( o.args ) || _.strIs( o.args ) );
  _.assert( o.execPath === null || _.strIs( o.execPath ) || _.strsAreAll( o.execPath ), 'Expects string or strings {-o.execPath-}, but got', _.strType( o.execPath ) );
  _.assert( o.timeOut === null || _.numberIs( o.timeOut ), 'Expects null or number {-o.timeOut-}, but got', _.strType( o.timeOut ) );

  let state = 0;
  let currentExitCode;
  let killedByTimeout = false;
  let stderrOutput = '';
  let decoratedOutput = '';
  let decoratedErrorOutput = '';

  o.ready = o.ready || new _.Consequence().take( null );

  /* */

  if( _.arrayIs( o.execPath ) || _.arrayIs( o.currentPath ) )
  return multiple();

  /*  */

  if( o.sync && !o.deasync )
  {
    let arg = o.ready.sync();
    if( _.errIs( arg ) )
    throw _.err( arg );
    single();
    end( undefined, o )
    return o;
  }
  else
  {
    o.ready.thenGive( single );
    o.ready.finallyKeep( end );
    if( o.sync && o.deasync )
    return o.ready.finallyDeasyncGive();
    return o.ready;
  }

  /*  */

  function multiple()
  {

    if( _.arrayIs( o.execPath ) && o.execPath.length > 1 && o.concurrent && o.outputAdditive === null )
    o.outputAdditive = 0;

    o.currentPath = o.currentPath || _.path.current();

    let prevReady = o.ready;
    let readies = [];
    let options = [];

    let execPath = _.arrayAs( o.execPath );
    let currentPath = _.arrayAs( o.currentPath );

    for( let p = 0 ; p < execPath.length ; p++ )
    for( let c = 0 ; c < currentPath.length ; c++ )
    {

      let currentReady = new _.Consequence();
      readies.push( currentReady );

      if( o.concurrent )
      {
        prevReady.then( currentReady );
      }
      else
      {
        prevReady.finally( currentReady );
        prevReady = currentReady;
      }

      let o2 = _.mapExtend( null, o );
      o2.execPath = execPath[ p ];
      o2.args = o.args ? o.args.slice() : o.args;
      o2.currentPath = currentPath[ c ];
      o2.ready = currentReady;
      options.push( o2 );
      _.process.start( o2 );

    }

    // debugger;
    o.ready
    // .then( () => new _.Consequence().take( null ).andKeep( readies ) )
    .then( () => _.Consequence.AndKeep( readies ) )
    .finally( ( err, arg ) =>
    {
      // debugger;
      o.exitCode = err ? null : 0;

      for( let a = 0 ; a < options.length-1 ; a++ )
      {
        let o2 = options[ a ];
        if( !o.exitCode && o2.exitCode )
        o.exitCode = o2.exitCode;
      }

      if( err )
      throw err;

      return arg;
    });

    if( o.sync && !o.deasync )
    return o;
    if( o.sync && o.deasync )
    return o.ready.finallyDeasyncGive();

    return o.ready;
  }

  /*  */

  function single()
  {

    _.assert( state === 0 );
    state = 1;

    try
    {
      prepare();
      launch();
      pipe();
    }
    catch( err )
    {
      debugger
      appExitCode( -1 );
      if( o.sync && !o.deasync )
      throw _.errLogOnce( err );
      else
      o.ready.error( _.errLogOnce( err ) );
    }

  }

  /* */

  function end( err, arg )
  {

    if( state > 0 )
    {
      if( !o.outputAdditive )
      {
        if( decoratedOutput )
        o.logger.log( decoratedOutput );
        if( decoratedErrorOutput )
        o.logger.error( decoratedErrorOutput );
      }
    }

    if( err )
    {
      if( state < 2 )
      o.exitCode = null;
      throw err;
    }
    return arg;
  }

  /* */

  function prepare()
  {

    // qqq : cover the case ( args is string ) for both routines shell and sheller
    // if( _.strIs( o.args ) )
    // o.args = _.strSplitNonPreserving({ src : o.args });
    o.args = _.arrayAs( o.args );
    
    let execArgs;

    if( _.strIs( o.execPath ) )
    { 
      o.fullExecPath = o.execPath;
      execArgs = execPathParse( o.execPath );
      o.execPath = execArgs.shift();
    }
    
    if( o.execPath === null )
    {
      o.execPath = o.args.shift();
      o.fullExecPath = o.execPath;
      
      let begin = _.strBeginOf( o.execPath, [ '"', "'", '`' ] );
      let end = _.strEndOf( o.execPath, [ '"', "'", '`' ] );
      
      if( begin && begin === end )
      o.execPath = _.strInsideOf( o.execPath, begin, end );
    }
    
    if( o.args )
    o.fullExecPath = _.strConcat( _.arrayAppendArray( [ o.fullExecPath ], o.args ) );
    
    if( execArgs && execArgs.length )
    o.args = _.arrayPrependArray( o.args || [], execArgs );
    
    if( o.outputAdditive === null )
    o.outputAdditive = true;
    o.outputAdditive = !!o.outputAdditive;
    // o.currentPath = o.currentPath || _.path.current();
    o.currentPath = _.path.resolve( o.currentPath || '.' );
    o.logger = o.logger || _global_.logger;

    /* verbosity */

    if( !_.numberIs( o.verbosity ) )
    o.verbosity = o.verbosity ? 1 : 0;
    if( o.verbosity < 0 )
    o.verbosity = 0;
    if( o.outputPiping === null )
    o.outputPiping = o.verbosity >= 2;
    if( o.outputCollecting && !o.output )
    o.output = '';

    /* ipc */

    if( o.ipc )
    {
      if( _.strIs( o.stdio ) )
      o.stdio = _.dup( o.stdio, 3 );
      if( !_.arrayHas( o.stdio, 'ipc' ) )
      o.stdio.push( 'ipc' );
    }

    /* passingThrough */

    if( o.passingThrough )
    {
      let argumentsManual = process.argv.slice( 2 );
      if( argumentsManual.length )
      o.args = _.arrayAppendArray( o.args || [], argumentsManual );
    }

    /* out options */

    // if( o.args )
    // o.fullExecPath = _.strConcat( _.arrayAppendArray( [ o.execPath ], o.args || [] ) );
    // else
    // o.fullExecPath = _.strConcat([ o.execPath ]);

    o.exitCode = null;
    o.exitSignal = null;
    o.process = null;
    Object.preventExtensions( o );

    /* dependencies */

    if( !ChildProcess )
    ChildProcess = require( 'child_process' );

    if( !o.outputGray && typeof module !== 'undefined' )
    try
    {
      _.include( 'wLogger' );
      _.include( 'wColor' );
    }
    catch( err )
    {
      if( o.verbosity >= 2 )
      _.errLogOnce( err );
    }

  }

  /* */

  function launch()
  {

    /* logger */

    try
    {

      if( o.verbosity && o.inputMirroring )
      {
        let prefix = ' > ';
        if( !o.outputGray )
        prefix = _.color.strFormat( prefix, { fg : 'bright white' } );
        log( prefix + o.fullExecPath );
      }

      if( o.verbosity >= 3 )
      {
        let prefix = '   at ';
        if( !o.outputGray )
        prefix = _.color.strFormat( prefix, { fg : 'bright white' } );
        log( prefix + o.currentPath );
      }

    }
    catch( err )
    {
      debugger;
      _.errLogOnce( err );
    }

    /* launch */

    launchAct();

    /* time out */

    if( o.timeOut )
    if( !o.sync || o.deasync )
    _.timeBegin( o.timeOut, () =>
    {
      if( state === 2 )
      return;
      killedByTimeout = true;
      o.process.kill( 'SIGTERM' );
    });

  }

  /* */

  function launchAct()
  {
    if( _.strIs( o.interpreterArgs ) )
    o.interpreterArgs = _.strSplitNonPreserving({ src : o.interpreterArgs });

    _.assert( _.fileProvider.isDir( o.currentPath ), 'working directory', o.currentPath, 'doesn\'t exist or it\'s not a directory.' );

    if( o.mode === 'fork')
    {
      _.assert( !o.sync || o.deasync, '{ shell.mode } "fork" is available only in async/deasync version of shell' );
      let args = o.args || [];
      let o2 = optionsForFork();
      let execPath = execPathForFork();
      o.process = ChildProcess.fork( execPath, args, o2 );
    }
    else if( o.mode === 'exec' )
    {
      let currentPath = _.path.nativize( o.currentPath );
      log( '{ shell.mode } "exec" is deprecated' );
      let execPath = o.execPath + ' ' + argsJoin( o.args );
      if( o.sync && !o.deasync )
      o.process = ChildProcess.execSync( execPath, { env : o.env, cwd : currentPath } );
      else
      o.process = ChildProcess.exec( execPath, { env : o.env, cwd : currentPath } );
    }
    else if( o.mode === 'spawn' )
    {
      let appPath = o.execPath;

      // if( !o.args )
      // {
      //   o.args = _.strSplitNonPreserving({ src : o.execPath });
      //   appPath = o.args.shift();
      // }
      // else
      // {
      //   if( appPath.length )
      //   _.assert( _.strSplitNonPreserving({ src : appPath }).length === 1, ' o.execPath must not contain arguments if those were provided through options' );
      // }

      let o2 = optionsForSpawn();

      if( o.sync && !o.deasync )
      o.process = ChildProcess.spawnSync( appPath, o.args, o2 );
      else
      o.process = ChildProcess.spawn( appPath, o.args, o2 );

    }
    else if( o.mode === 'shell' )
    {

      let appPath = process.platform === 'win32' ? 'cmd' : 'sh';
      let arg1 = process.platform === 'win32' ? '/c' : '-c';
      let arg2 = o.execPath;
      let o2 = optionsForSpawn();

     /*

      windowsVerbatimArguments allows to have arguments with space(s) in shell on Windows
      Following calls will not work as expected( argument will be splitted by space ), if windowsVerbatimArguments is disabled:

      _.process.start( 'node path/to/script.js "path with space"' );
      _.process.start({ execPath : 'node path/to/script.js', args : [ "path with space" ] });

     */

      o2.windowsVerbatimArguments = true;

      if( o.args )
      arg2 = arg2 + ' ' + argsJoin( o.args );

      if( o.sync && !o.deasync )
      o.process = ChildProcess.spawnSync( appPath, [ arg1, arg2 ], o2 );
      else
      o.process = ChildProcess.spawn( appPath, [ arg1, arg2 ], o2 );

    }
    else _.assert( 0, 'Unknown mode', _.strQuote( o.mode ), 'to shell path', _.strQuote( o.paths ) );

  }

/*
qqq
add coverage

for combination:
  path to exe file : [ with space, without space ]
  execPath : [ has arguments, only path to exe file ]
  args : [ has arguments, empty ]
  mode : [ 'fork', 'exec', 'spawn', 'shell' ]

example of execPath :
  execPath : '"/dir with space/app.exe" firstArg secondArg:1 "third arg" \'fourth arg\'  `"fifth" arg`

== samples

execPath : '"/dir with space/app.exe" `firstArg secondArg ":" 1` "third arg" \'fourth arg\'  `"fifth" arg`,
args : '"some arg"'
mode : 'spawn'
->
execPath : '/dir with space/app.exe'
args : [ 'firstArg secondArg ":" 1', 'third arg', 'fourth arg', '"fifth" arg', '"some arg"' ],

=

execPath : '"/dir with space/app.exe" firstArg secondArg:1',
args : '"third arg"',
->
execPath : '/dir with space/app.exe'
args : [ 'firstArg', 'secondArg:1', '"third arg"' ]

=

execPath : '"first arg"'
->
execPath : 'first arg'
args : []

=

args : '"first arg"'
->
execPath : 'first arg'
args : []

=

args : [ '"first arg"', 'second arg' ]
->
execPath : 'first arg'
args : [ 'second arg' ]

=

args : [ '"', 'first', 'arg', '"' ]
->
execPath : '"'
args : [ 'first', 'arg', '"' ]

=

args : [ '', 'first', 'arg', '"' ]
->
execPath : ''
args : [ 'first', 'arg', '"' ]

=

args : [ '"', '"', 'first', 'arg', '"' ]
->
execPath : '"'
args : [ '"', 'first', 'arg', '"' ]

*/

  /* */

  function execPathParse( src )
  {
    let strOptions =
    {
      src : src,
      delimeter : [ ' ' ],
      quoting : 1,
      quotingPrefixes : [ "'", '"', "`" ],
      quotingPostfixes : [ "'", '"', "`" ],
      preservingEmpty : 0,
      preservingQuoting : 1,
      stripping : 1
    }
    let args = _.strSplit( strOptions );

    for( let i = 0; i < args.length; i++ )
    {
      let begin = _.strBeginOf( args[ i ], strOptions.quotingPrefixes );
      let end = _.strEndOf( args[ i ], strOptions.quotingPostfixes );
      if( begin )
      {
        _.sure( begin === end, 'Arguments string in execPath:', src, 'has not closed quoting, that begins of:', args[ i ] );
        args[ i ] = _.strInsideOf( args[ i ], begin, end );
      }
    }
    return args;
  }

  /* */

  function argsJoin( args )
  {
    args = args.slice();
    
    for( let i = 0; i < args.length; i++ )
    {
      //escaping of some quotes is needed to equalize behavior of shell and exec modes on all platforms
      let quotes = [ '"' ]
      if( process.platform !== 'win32' )
      quotes.push( "`" )
      _.each( quotes, ( quote ) =>
      {
        args[ i ] = _.strReplaceAll( args[ i ], quote, ( match, it ) => 
        { 
          if( it.input[ it.range[ 0 ] - 1 ] === '\\' )
          return match;
          return '\\' + match; 
        });
      })
    }
    
    return '"' + args.join( '" "' ) + '"';
  }

  /* */

  function optionsForSpawn()
  {
    let o2 = Object.create( null );
    if( o.stdio )
    o2.stdio = o.stdio;
    o2.detached = !!o.detaching;
    if( o.env )
    o2.env = o.env;
    if( o.currentPath )
    o2.cwd = _.path.nativize( o.currentPath );
    if( o.timeOut && o.sync )
    o2.timeout = o.timeOut;
    return o2;
  }

  /* */

  function optionsForFork()
  {
    let interpreterArgs = o.interpreterArgs || process.execArgv;
    let o2 =
    {
      silent : false,
      env : o.env,
      stdio : o.stdio,
      execArgv : interpreterArgs,
    }

    if( o.currentPath )
    o2.cwd = _.path.nativize( o.currentPath );

    return o2;
  }

  function execPathForFork()
  {
    let quotes = [ "'", '"', "`" ];
    let execPath = o.execPath;
    let begin = _.strBeginOf( execPath, quotes );
    if( begin )
    execPath = _.strInsideOf( execPath, begin, begin );
    return execPath;
  }

  /* */

  function pipe()
  {

    /* piping out channel */

    if( o.outputPiping || o.outputCollecting )
    if( o.process.stdout )
    if( o.sync && !o.deasync )
    handleStdout( o.process.stdout );
    else
    o.process.stdout.on( 'data', handleStdout );

    /* piping error channel */

    if( o.process.stderr )
    if( o.sync && !o.deasync )
    handleStderr( o.process.stderr );
    else
    o.process.stderr.on( 'data', handleStderr );

    if( o.sync && !o.deasync )
    {
      if( o.process.error )
      handleError( o.process.error );
      else
      handleClose( o.process.status, o.process.signal );
    }
    else
    {
      o.process.on( 'error', handleError );
      o.process.on( 'close', handleClose );
    }

  }

  /* */

  function appExitCode( exitCode )
  {
    if( currentExitCode )
    return;
    if( o.applyingExitCode && exitCode !== 0 )
    {
      currentExitCode = _.numberIs( exitCode ) ? exitCode : -1;
      _.process.exitCode( currentExitCode );
    }
  }

  /* */

  function infoGet()
  {
    let result = '';
    result += 'Launched as ' + _.strQuote( o.fullExecPath ) + '\n';
    result += 'Launched at ' + _.strQuote( o.currentPath ) + '\n';
    if( stderrOutput.length )
    result += '\n -> Stderr' + '\n' + ' -  ' + _.strIndentation( stderrOutput, ' -  ' ) + '\n -< Stderr';
    // !!! : implement error's collectors
    return result;
  }

  /* */

  function handleClose( exitCode, exitSignal )
  {

    o.exitCode = exitCode;
    o.exitSignal = exitSignal;

    if( o.verbosity >= 5 )
    {
      log( ' < Process returned error code ' + exitCode );
      if( exitCode )
      {
        log( infoGet() );
      }
    }

    if( state === 2 )
    return;

    state = 2;

    appExitCode( exitCode );

    if( exitCode !== 0 && o.throwingExitCode )
    {
      let err;

      if( _.numberIs( exitCode ) )
      err = _.err( 'Process returned exit code', exitCode, '\n', infoGet() );
      else if( killedByTimeout )
      err = _.err( 'Process timed out, killed by exit signal', exitSignal, '\n', infoGet() );
      else
      err = _.err( 'Process wass killed by exit signal', exitSignal, '\n', infoGet() );

      if( o.sync && !o.deasync )
      throw err;
      else
      o.ready.error( err );
    }
    else if( !o.sync || o.deasync )
    {
      o.ready.take( o );
    }

  }

  /* */

  function handleError( err )
  {

    appExitCode( -1 );

    if( state === 2 )
    return;

    state = 2;

    debugger;
    err = _.err( 'Error shelling command\n', o.execPath, '\nat', o.currentPath, '\n', err );
    if( o.verbosity )
    err = _.errLogOnce( err );

    if( o.sync && !o.deasync )
    throw err;
    else
    o.ready.error( err );
  }

  /* */

  function handleStderr( data )
  {

    if( _.bufferAnyIs( data ) )
    data = _.bufferToStr( data );

    stderrOutput += data;

    if( o.outputCollecting )
    o.output += data;

    if( !o.outputPiping )
    return;

    if( _.strEnds( data, '\n' ) )
    data = _.strRemoveEnd( data, '\n' );

    if( o.outputPrefixing )
    data = 'stderr :\n' + '  ' + _.strIndentation( data, '  ' );

    if( _.color && !o.outputGray )
    data = _.color.strFormat( data, 'pipe.negative' );

    log( data, 1 );
  }

  /* */

  function handleStdout( data )
  {

    if( _.bufferAnyIs( data ) )
    data = _.bufferToStr( data );

    if( o.outputCollecting )
    o.output += data;
    if( !o.outputPiping )
    return;

    if( _.strEnds( data, '\n' ) )
    data = _.strRemoveEnd( data, '\n' );

    if( o.outputPrefixing )
    data = 'stdout :\n' + '  ' + _.strIndentation( data, '  ' );

    if( _.color && !o.outputGray && !o.outputGrayStdout )
    data = _.color.strFormat( data, 'pipe.neutral' );

    log( data );

  }

  /* */

  function log( msg, isError )
  {

    if( o.outputAdditive )
    {
      if( isError )
      o.logger.error( msg );
      else
      o.logger.log( msg );
    }
    else
    {
      decoratedOutput += msg + '\n';
      if( isError )
      decoratedErrorOutput += msg + '\n';
    }

  }

}

shell_body.defaults =
{

  execPath : null,
  currentPath : null,

  sync : 0,
  deasync : 1,

  args : null,
  interpreterArgs : null,
  mode : 'shell', /* 'fork', 'exec', 'spawn', 'shell' */
  ready : null,
  logger : null,

  env : null,
  stdio : 'pipe', /* 'pipe' / 'ignore' / 'inherit' */
  ipc : 0,
  detaching : 0,
  passingThrough : 0,
  concurrent : 0,
  timeOut : null,

  throwingExitCode : 1, /* must be on by default */
  applyingExitCode : 0,

  verbosity : 2,
  outputGray : 0,
  outputGrayStdout : 0,
  outputPrefixing : 0,
  outputPiping : null,
  outputCollecting : 0,
  outputAdditive : null,
  inputMirroring : 1,

}

let shell = _.routineFromPreAndBody( shell_pre, shell_body );

//

let shellPassingThrough = _.routineFromPreAndBody( shell_pre, shell_body );

var defaults = shellPassingThrough.defaults;

defaults.verbosity = 0;
defaults.passingThrough = 1;
defaults.applyingExitCode = 1;
defaults.throwingExitCode = 0;
defaults.outputPiping = 1;
defaults.stdio = 'inherit';
// defaults.mode = 'spawn'; // xxx : uncomment after fix of the mode

//

/**
 * @summary Short-cut for {@link module:Tools/base/ProcessBasic.Tools( module::ProcessBasic ).shell shell} routine. Executes provided script in with `node` runtime.
 * @description
 * Expects path to javascript file in `o.execPath` option. Automatically prepends `node` prefix before script path `o.execPath`.
 * @param {Object} o Options map, see {@link module:Tools/base/ProcessBasic.Tools( module::ProcessBasic ).shell shell} for detailed info about options.
 * @param {Boolean} o.passingThrough=0 Allows to pass arguments of parent process to the child process.
 * @param {Boolean} o.maximumMemory=0 Allows `node` to use all available memory.
 * @param {Boolean} o.applyingExitCode=1 Applies exit code to parent process.
 * @param {String|Array} o.stdio='inherit' Prints all output through stdout,stderr channels of parent.
 *
 * @return {Object} Returns `wConsequence` instance in async mode. In sync mode returns options map. Options map contains not only input options, but child process descriptor, collected output, exit code and other useful info.
 *
 * @example
 *
 * let _ = require('wTools')
 * _.include( 'wAppBasic' )
 * _.include( 'wConsequence' )
 * _.include( 'wLogger' )
 *
 * let con = _.process.startNode({ execPath : 'path/to/script.js' });
 *
 * con.then( ( got ) =>
 * {
 *  console.log( 'ExitCode:', got.exitCode );
 *  return got;
 * })
 *
 * @function shellNode
 * @memberof module:Tools/base/ProcessBasic.Tools( module::ProcessBasic )
 */

function shellNode_body( o )
{

  if( !System )
  System = require( 'os' );

  _.include( 'wPathBasic' );
  _.include( 'wFiles' );

  _.assertRoutineOptions( shellNode, o );
  _.assert( _.strIs( o.execPath ) );
  _.assert( !o.code );
  _.assert( arguments.length === 1, 'Expects single argument' );

  /*
  1024*1024 for megabytes
  1.4 factor found empirically for windows
      implementation of nodejs for other OSs could be able to use more memory
  */

  let interpreterArgs = '';
  if( o.maximumMemory )
  {
    let totalmem = System.totalmem();
    if( o.verbosity )
    logger.log( 'System.totalmem()', _.strMetricFormatBytes( totalmem ) );
    if( totalmem < 1024*1024*1024 )
    Math.floor( ( totalmem / ( 1024*1024*1.4 ) - 1 ) / 256 ) * 256;
    else
    Math.floor( ( totalmem / ( 1024*1024*1.1 ) - 1 ) / 256 ) * 256;
    interpreterArgs = '--expose-gc --stack-trace-limit=999 --max_old_space_size=' + totalmem;
  }

  let path = _.fileProvider.path.nativize( o.execPath );
  if( o.mode === 'fork' )
  o.interpreterArgs = interpreterArgs;
  else
  path = _.strConcat([ 'node', interpreterArgs, path ]);

  let shellOptions = _.mapOnly( o, _.process.start.defaults );
  shellOptions.execPath = path;

  let result = _.process.start( shellOptions )
  .give( function( err, arg )
  {
    o.exitCode = shellOptions.exitCode;
    o.exitSignal = shellOptions.exitSignal;
    this.take( err, arg );
  });

  o.ready = shellOptions.ready;
  o.process = shellOptions.process;

  return result;
}

var defaults = shellNode_body.defaults = Object.create( shell.defaults );

defaults.passingThrough = 0;
defaults.maximumMemory = 0;
defaults.applyingExitCode = 1;
defaults.stdio = 'inherit';
defaults.mode = 'fork';

let shellNode = _.routineFromPreAndBody( shell_pre, shellNode_body );

//

/**
 * @summary Short-cut for {@link module:Tools/base/ProcessBasic.Tools( module::ProcessBasic ).shellNode shellNode} routine.
 * @description
 * Passes arguments of parent process to the child and allows `node` to use all available memory.
 * Expects path to javascript file in `o.execPath` option. Automatically prepends `node` prefix before script path `o.execPath`.
 * @param {Object} o Options map, see {@link module:Tools/base/ProcessBasic.Tools( module::ProcessBasic ).shell shell} for detailed info about options.
 * @param {Boolean} o.passingThrough=1 Allows to pass arguments of parent process to the child process.
 * @param {Boolean} o.maximumMemory=1 Allows `node` to use all available memory.
 * @param {Boolean} o.applyingExitCode=1 Applies exit code to parent process.
 *
 * @return {Object} Returns `wConsequence` instance in async mode. In sync mode returns options map. Options map contains not only input options, but child process descriptor, collected output, exit code and other useful info.
 *
 * @example
 *
 * let _ = require('wTools')
 * _.include( 'wAppBasic' )
 * _.include( 'wConsequence' )
 * _.include( 'wLogger' )
 *
 * let con = _.process.startNodePassingThrough({ execPath : 'path/to/script.js' });
 *
 * con.then( ( got ) =>
 * {
 *  console.log( 'ExitCode:', got.exitCode );
 *  return got;
 * })
 *
 * @function shellNodePassingThrough
 * @memberof module:Tools/base/ProcessBasic.Tools( module::ProcessBasic )
 */

let shellNodePassingThrough = _.routineFromPreAndBody( shell_pre, shellNode.body );

var defaults = shellNodePassingThrough.defaults;

defaults.verbosity = 0;
defaults.passingThrough = 1;
defaults.maximumMemory = 1;
defaults.applyingExitCode = 1;
defaults.throwingExitCode = 0;
defaults.outputPiping = 1;
defaults.mode = 'fork';

//

/**
 * @summary Generates shell routine that reuses provided option on each call.
 * @description
 * Routine vectorize `o.execPath` and `o.args` options. `wConsequence` instance `o.ready` can be reused to run several shells in a row, see examples.
 * @param {Object} o Options map
 *
 * @return {Function} Returns shell routine with options saved as inner state.
 *
 * @example //single command execution
 *
 * let _ = require('wTools')
 * _.include( 'wAppBasic' )
 * _.include( 'wConsequence' )
 * _.include( 'wLogger' )
 *
 * let shell = _.process.starter({ execPath : 'node' });
 *
 * let con = shell({ args : [ '-v' ] });
 *
 * con.then( ( got ) =>
 * {
 *  console.log( 'ExitCode:', got.exitCode );
 *  return got;
 * })
 *
 * @example //multiple commands execution with same args
 *
 * let _ = require('wTools')
 * _.include( 'wAppBasic' )
 * _.include( 'wConsequence' )
 * _.include( 'wLogger' )
 *
 * let shell = _.process.starter({ args : [ '-v' ]});
 *
 * let con = shell({ execPath : [ 'node', 'npm' ] });
 *
 * con.then( ( got ) =>
 * {
 *  console.log( 'ExitCode:', got.exitCode );
 *  return got;
 * })
 *
 * @example
 * //multiple commands execution with same args, using sinle consequence
 * //second command will be executed when first is finished
 *
 * let _ = require('wTools')
 * _.include( 'wAppBasic' )
 * _.include( 'wConsequence' )
 * _.include( 'wLogger' )
 *
 * let ready = new _.Consequence().take( null );
 * let shell = _.process.starter({ args : [ '-v' ], ready });
 *
 * shell({ execPath : 'node' });
 *
 * ready.then( ( got ) =>
 * {
 *  console.log( 'node ExitCode:', got.exitCode );
 *  return got;
 * })
 *
 * shell({ execPath : 'npm' });
 *
 * ready.then( ( got ) =>
 * {
 *  console.log( 'npm ExitCode:', got.exitCode );
 *  return got;
 * })
 *
 * @function sheller
 * @memberof module:Tools/base/ProcessBasic.Tools( module::ProcessBasic )
 */

function sheller( o0 )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  if( _.strIs( o0 ) )
  o0 = { execPath : o0 }
  o0 = _.routineOptions( sheller, o0 );
  o0.ready = o0.ready || new _.Consequence().take( null );

  return function er()
  {
    let o = optionsFrom( arguments[ 0 ] );
    let o00 = _.mapExtend( null, o0 );
    merge( o00, o );
    _.mapExtend( o, o00 )

    for( let a = 1 ; a < arguments.length ; a++ )
    {
      let o1 = optionsFrom( arguments[ a ] );
      merge( o, o1 );
      _.mapExtend( o, o1 );
    }

    return _.process.start( o );
  }

  function optionsFrom( options )
  {
    if( _.strIs( options ) || _.arrayIs( options ) )
    options = { execPath : options }
    options = options || Object.create( null );
    _.assertMapHasOnly( options, sheller.defaults );
    return options;
  }

  function merge( dst, src )
  {
    if( _.strIs( src ) || _.arrayIs( src ) )
    src = { execPath : src }
    _.assertMapHasOnly( src, sheller.defaults );

    if( src.execPath !== null && src.execPath !== undefined && dst.execPath !== null && dst.execPath !== undefined )
    {
      _.assert( _.arrayIs( src.execPath ) || _.strIs( src.execPath ), () => 'Expects string or array, but got ' + _.strType( src.execPath ) );
      if( _.arrayIs( src.execPath ) )
      src.execPath = _.arrayFlatten( src.execPath );

      /*
      condition required, otherwise vectorization of results will be done what is not desirable
      */

      if( _.arrayIs( dst.execPath ) || _.arrayIs( src.execPath ) )
      dst.execPath = _.eachSample( [ dst.execPath, src.execPath ] ).map( ( path ) => path.join( ' ' ) );
      else
      dst.execPath = dst.execPath + ' ' + src.execPath;

      delete src.execPath;
    }

    _.mapExtend( dst, src );

    return dst;
  }

}

sheller.defaults = Object.create( shell.defaults );

// --
// app
// --

/**
 * @summary Parses arguments of current process.
 * @description
 * Supports processing of regular arguments, options( key:value pairs), commands and arrays.
 * @param {Object} o Options map.
 * @param {Boolean} o.keyValDelimeter=':' Delimeter for key:value pairs.
 * @param {String} o.cmmandsDelimeter=';' Delimeneter for commands, for example : `.build something ; .exit `
 * @param {Array} o.argv=null Arguments array. By default takes arguments from `process.argv`.
 * @param {Boolean} o.caching=true Caches results for speedup next calls.
 * @param {Boolean} o.parsingArrays=true Enables parsing of array from arguments.
 *
 * @return {Object} Returns map with parsed arguments.
 *
 * @example
 *
 * let _ = require('wTools')
 * _.include( 'wAppBasic' )
 * let result = _.process.args();
 * console.log( result );
 *
 * @function appArgs
 * @memberof module:Tools/base/ProcessBasic.Tools( module::ProcessBasic )
 */

let _appArgsCache;
let _appArgsInSamFormat = Object.create( null )
var defaults = _appArgsInSamFormat.defaults = Object.create( null );

defaults.keyValDelimeter = ':';
defaults.cmmandsDelimeter = ';';
defaults.argv = null;
defaults.caching = true;
defaults.parsingArrays = true;

//

function _appArgsInSamFormatNodejs( o )
{

  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = _.routineOptions( _appArgsInSamFormatNodejs, arguments );

  if( o.caching )
  if( _appArgsCache )
  if( o.keyValDelimeter === _appArgsCache.keyValDelimeter && o.cmmandsDelimeter === _appArgsCache.cmmandsDelimeter )
  return _appArgsCache;

  let result = Object.create( null );

  if( o.caching )
  // if( o.keyValDelimeter === _appArgsInSamFormatNodejs.defaults.keyValDelimeter )
  if( o.keyValDelimeter === _appArgsInSamFormatNodejs.defaults.keyValDelimeter && o.cmmandsDelimeter === _appArgsInSamFormatNodejs.defaults.cmmandsDelimeter )
  _appArgsCache = result;

  if( !_global.process )
  {
    result.subject = '';
    result.map = Object.create( null );
    result.subjects = [];
    result.maps = [];
    return result;
  }

  o.argv = o.argv || process.argv;

  _.assert( _.longIs( o.argv ) );

  result.interpreterPath = _.path.normalize( o.argv[ 0 ] );
  result.mainPath = _.path.normalize( o.argv[ 1 ] );
  result.interpreterArgs = process.execArgv;
  result.scriptArgs = o.argv.slice( 2 );
  result.scriptString = result.scriptArgs.join( ' ' );
  result.scriptString = result.scriptString.trim();

  let r = _.strRequestParse
  ({
    src : result.scriptString,
    keyValDelimeter : o.keyValDelimeter,
    cmmandsDelimeter : o.cmmandsDelimeter,
    parsingArrays : o.parsingArrays,
  });

  _.mapExtend( result, r );

  return result;
}

_appArgsInSamFormatNodejs.defaults = Object.create( _appArgsInSamFormat.defaults );

//

function _appArgsInSamFormatBrowser( o )
{
  debugger; /* xxx */

  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = _.routineOptions( _appArgsInSamFormatNodejs, arguments );

  if( o.caching )
  if( _appArgsCache && o.keyValDelimeter === _appArgsCache.keyValDelimeter )
  return _appArgsCache;

  let result = Object.create( null );

  result.map =  Object.create( null );

  if( o.caching )
  if( o.keyValDelimeter === _appArgsInSamFormatNodejs.defaults.keyValDelimeter )
  _appArgsCache = result;

  return result;
}

_appArgsInSamFormatBrowser.defaults = Object.create( _appArgsInSamFormat.defaults );

//

/**
 * @summary Reads options from arguments of current process and copy them on target object `o.dst`.
 * @description
 * Checks if found options are expected using map `o.namesMap`. Throws an Error if arguments contain unknown option.
 *
 * @param {Object} o Options map.
 * @param {Object} o.dst=null Target object.
 * @param {Object} o.propertiesMap=null Map with parsed options. By default routine gets this map using {@link module:Tools/base/ProcessBasic.Tools( module::ProcessBasic ).appArgs appArgs} routine.
 * @param {Object} o.namesMap=null Map of expected options.
 * @param {Object} o.removing=1 Removes copied options from result map `o.propertiesMap`.
 * @param {Object} o.only=1 Check if all option are expected. Throws error if not.
 *
 * @return {Object} Returns map with parsed options.
 *
 * @function appArgsReadTo
 * @memberof module:Tools/base/ProcessBasic.Tools( module::ProcessBasic )
 */

function appArgsReadTo( o )
{

  if( arguments[ 1 ] !== undefined )
  o = { dst : arguments[ 0 ], namesMap : arguments[ 1 ] };

  o = _.routineOptions( appArgsReadTo, o );

  if( !o.propertiesMap )
  o.propertiesMap = _.process.args().map;

  if( _.arrayIs( o.namesMap ) )
  {
    let namesMap = Object.create( null );
    for( let n = 0 ; n < o.namesMap.length ; n++ )
    namesMap[ o.namesMap[ n ] ] = o.namesMap[ n ];
    o.namesMap = namesMap;
  }

  _.assert( arguments.length === 1 || arguments.length === 2 )
  _.assert( _.objectIs( o.dst ), 'Expects map {-o.dst-}' );
  _.assert( _.objectIs( o.namesMap ), 'Expects map {-o.namesMap-}' );

  for( let n in o.namesMap )
  {
    if( o.propertiesMap[ n ] !== undefined )
    {
      set( o.namesMap[ n ], o.propertiesMap[ n ] );
      if( o.removing )
      delete o.propertiesMap[ n ];
    }
  }

  if( o.only )
  {
    let but = Object.keys( _.mapBut( o.propertiesMap, o.namesMap ) );
    if( but.length )
    {
      throw _.err( 'Unknown application arguments : ' + _.strQuote( but ).join( ', ' ) );
    }
  }

  return o.propertiesMap;

  /* */

  function set( k, v )
  {
    _.assert( o.dst[ k ] !== undefined, () => 'Entry ' + _.strQuote( k ) + ' is not defined' );
    if( _.numberIs( o.dst[ k ] ) )
    {
      v = Number( v );
      _.assert( !isNaN( v ) );
      o.dst[ k ] = v;
    }
    else if( _.boolIs( o.dst[ k ] ) )
    {
      v = !!v;
      o.dst[ k ] = v;
    }
    else
    {
      o.dst[ k ] = v;
    }
  }

}

appArgsReadTo.defaults =
{
  dst : null,
  propertiesMap : null,
  namesMap : null,
  removing : 1,
  only : 1,
}

//

function appAnchor( o )
{
  o = o || {};

  _.routineOptions( appAnchor, arguments );

  let a = _.strStructureParse
  ({
    src : _.strRemoveBegin( window.location.hash, '#' ),
    keyValDelimeter : ':',
    entryDelimeter : ';',
  });

  if( o.extend )
  {
    _.mapExtend( a, o.extend );
  }

  if( o.del )
  {
    _.mapDelete( a, o.del );
  }

  if( o.extend || o.del )
  {

    let newHash = '#' + _.mapToStr
    ({
      src : a,
      keyValDelimeter : ':',
      entryDelimeter : ';',
    });

    if( o.replacing )
    history.replaceState( undefined, undefined, newHash )
    else
    window.location.hash = newHash;

  }

  return a;
}

appAnchor.defaults =
{
  extend : null,
  del : null,
  replacing : 0,
}

//

function appExitCode( status )
{
  let result;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( status === undefined || _.numberIs( status ) );

  if( _global.process )
  {
    result = process.exitCode || 0;
    if( status !== undefined )
    process.exitCode = status;
  }

  return result;
}

//

function appExit( exitCode )
{

  exitCode = exitCode !== undefined ? exitCode : appExitCode();

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( exitCode === undefined || _.numberIs( exitCode ) );

  if( _global.process )
  {
    process.exit( exitCode );
  }
  else
  {
    /*debugger;*/
  }

}

//

function appExitWithBeep( exitCode )
{

  exitCode = exitCode !== undefined ? exitCode : appExitCode();

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( exitCode === undefined || _.numberIs( exitCode ) );

  _.diagnosticBeep();

  if( exitCode )
  _.diagnosticBeep();

  _.process.exit( exitCode );
}

//

/*
qqq : use maybe appExitHandlerRepair instead of appExitHandlerOnce?
qqq : investigate difference between appExitHandlerRepair and appExitHandlerOnce
*/

let appRepairExitHandlerDone = 0;
function appExitHandlerRepair()
{

  _.assert( arguments.length === 0 );

  if( appRepairExitHandlerDone )
  return;
  appRepairExitHandlerDone = 1;

  if( typeof process === 'undefined' )
  return;

  // process.on( 'SIGHUP', function()
  // {
  //   debugger;
  //   console.log( 'SIGHUP' );
  //   try
  //   {
  //     process.exit();
  //   }
  //   catch( err )
  //   {
  //     console.log( 'Error!' );
  //     console.log( err.toString() );
  //     console.log( err.stack );
  //     process.removeAllListeners( 'exit' );
  //     process.exit();
  //   }
  // });

  process.on( 'SIGQUIT', function()
  {
    debugger;
    console.log( 'SIGQUIT' );
    try
    {
      process.exit();
    }
    catch( err )
    {
      console.log( 'Error!' );
      console.log( err.toString() );
      console.log( err.stack );
      process.removeAllListeners( 'exit' );
      process.exit();
    }
  });

  process.on( 'SIGINT', function()
  {
    debugger;
    console.log( 'SIGINT' );
    try
    {
      process.exit();
    }
    catch( err )
    {
      console.log( 'Error!' );
      console.log( err.toString() );
      console.log( err.stack );
      process.removeAllListeners( 'exit' );
      process.exit();
    }
  });

  process.on( 'SIGTERM', function()
  {
    debugger;
    console.log( 'SIGTERM' );
    try
    {
      process.exit();
    }
    catch( err )
    {
      console.log( 'Error!' );
      console.log( err.toString() );
      console.log( err.stack );
      process.removeAllListeners( 'exit' );
      process.exit();
    }
  });

  process.on( 'SIGUSR1', function()
  {
    debugger;
    console.log( 'SIGUSR1' );
    try
    {
      process.exit();
    }
    catch( err )
    {
      console.log( 'Error!' );
      console.log( err.toString() );
      console.log( err.stack );
      process.removeAllListeners( 'exit' );
      process.exit();
    }
  });

  process.on( 'SIGUSR2', function()
  {
    debugger;
    console.log( 'SIGUSR2' );
    try
    {
      process.exit();
    }
    catch( err )
    {
      console.log( 'Error!' );
      console.log( err.toString() );
      console.log( err.stack );
      process.removeAllListeners( 'exit' );
      process.exit();
    }
  });

}

//

let _onExitHandlers = [];

function appExitHandlerOnce( routine )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( routine ) );

  _.process.exitHandlerRepair();

  if( typeof process === 'undefined' )
  return;

  if( !_onExitHandlers.length )
  {
    process.once( 'exit', onExitHandler );
    // process.once( 'SIGINT', onExitHandler );
    // process.once( 'SIGTERM', onExitHandler );
  }

  _onExitHandlers.push( routine );

  /*  */

  function onExitHandler( arg )
  {
    _.each( _onExitHandlers, ( routine ) =>
    {
      try
      {
        routine( arg );
      }
      catch( err )
      {
        _.errLogOnce( err );
      }
    })
    process.removeListener( 'exit', onExitHandler );
    // process.removeListener( 'SIGINT', onExitHandler );
    // process.removeListener( 'SIGTERM', onExitHandler );
    _onExitHandlers.splice( 0, _onExitHandlers.length );
  }

}

//

/*
qqq : cover routine appExitHandlerOff by tests
*/

function appExitHandlerOff( routine )
{
  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( routine ) );

  debugger;

  return _.arrayRemovedElement( _onExitHandlers, routine );
}

// function appExitHandlerOnce( routine )
// {
//   _.assert( arguments.length === 1 );
//   _.assert( _.routineIs( routine ) );
//
//   if( typeof process === 'undefined' )
//   return;
//
//   if( !_onExitHandlers.length )
//   {
//     process.once( 'exit', onExitHandler );
//     process.once( 'SIGINT', onExitHandler );
//     process.once( 'SIGTERM', onExitHandler );
//   }
//
//   _onExitHandlers.push( routine );
//
//   /*  */
//
//   function onExitHandler( arg )
//   {
//     _.each( _onExitHandlers, ( routine ) =>
//     {
//       try
//       {
//         routine( arg );
//       }
//       catch( err )
//       {
//         _.errLogOnce( err );
//       }
//     })
//
//     process.removeListener( 'exit', onExitHandler );
//     process.removeListener( 'SIGINT', onExitHandler );
//     process.removeListener( 'SIGTERM', onExitHandler );
//   }
//
// }

//

function appMemoryUsageInfo()
{
  var usage = process.memoryUsage();
  return ( usage.heapUsed >> 20 ) + ' / ' + ( usage.heapTotal >> 20 ) + ' / ' + ( usage.rss >> 20 ) + ' Mb';
}

// --
// declare
// --

let Extend =
{

  shell,
  shellPassingThrough,
  shellNode,
  shellNodePassingThrough,
  sheller,

  _appArgsInSamFormatNodejs,
  _appArgsInSamFormatBrowser,

  appArgsInSamFormat : Config.platform === 'nodejs' ? _appArgsInSamFormatNodejs : _appArgsInSamFormatBrowser,
  appArgs : Config.platform === 'nodejs' ? _appArgsInSamFormatNodejs : _appArgsInSamFormatBrowser,
  appArgsReadTo,

  appAnchor,

  appExitCode,
  appExit,
  appExitWithBeep,

  appExitHandlerRepair,
  appExitHandlerOnce,
  appExitHandlerOff,

  appMemoryUsageInfo,

}

_.mapExtend( _, Extend );
// _.mapExtend( Self, Extend );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
