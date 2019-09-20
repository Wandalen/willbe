
// > StarterInitBegin

let _global = undefined;
if( !_global && typeof Global !== 'undefined' && Global.Global === Global ) _global = Global;
if( !_global && typeof global !== 'undefined' && global.global === global ) _global = global;
if( !_global && typeof window !== 'undefined' && window.window === window ) _global = window;
if( !_global && typeof self   !== 'undefined' && self.self === self ) _global = self;
let _realGlobal = _global._realGlobal_ = _global;
let _wasGlobal = _global._global_ || _global;
_global = _wasGlobal;
_global._global_ = _wasGlobal;

let _starterGlobal_ = _realGlobal._global_ = Object.create( _wasGlobal );
_realGlobal._starterGlobal_ = _starterGlobal_;
_starterGlobal_.WTOOLS_PRIVATE = 1;
_starterGlobal_.__GLOBAL_PRIVATE_CONSEQUENCE__ = 1;

if( _global_._starterGlobal_ !== _starterGlobal_ )
throw 'Something wrong with global';
if( _realGlobal_._starterGlobal_ !== _starterGlobal_ )
throw 'Something wrong with global'
if( _starterGlobal_ !== _starterGlobal_ )
throw 'Something wrong with global';
// if( _starterGlobal_._starter_ )
// throw 'starter is already defined';

//

let _starter_ = _realGlobal._starter_ = _realGlobal._starter_ || Object.create( null );

// --
// starter
// --

function _starterFormBegin()
{
  // debugger;
  // _starter_.scriptExecBegin({ filePath : '_starter_', dirPath : '_starter_', isScript : true });
  _starter_.scriptExecBegin
  ({
    parentScriptFile : null,
    filePath : _filePath_,
    dirPath : _dirPath_,
    isScript : true,
  });
}

//

function _starterFormEnd()
{

  _.accessor.readOnly
  ({
    object : _starter_,
    names : 'module',
    strict : 0,
    prime : 0,
  });

  // _starter_.scriptExecEnd({ filePath : '_starter_', err : null });
  _starter_.scriptExecEnd
  ({
    parentScriptFile : null,
    filePath : _filePath_,
    err : null,
  });

  Object.preventExtensions( _starter_ );

  _starter_.presetsRefine( _starter_.presets );

  _starter_.fileProvider = _.FileProvider.Extract({ filesTree : _realGlobal_.FilesMap });
  _starter_.inited = 1;

  if( _starter_.usingIncludeHandlers )
  _starter_.modulesWithIncludeHandlersDeclare();

  _realGlobal._global_ = _wasGlobal;

  _starter_._starterUseFilesForm();

  if( !Config.isWorker )
  _starter_._scriptsPreload();

}

//

function _starterUseFilesForm()
{

  return; // xxx
  if( !_realGlobal_.UseFiles )
  return;

  let useFiles = _realGlobal_.UseFiles;
  let AllFilesMap = _realGlobal_.FilesMap;
  _realGlobal_.FilesMap = Object.create( null );

  let src = new _.FileProvider.Extract({ protocol : 'src', encoding : 'utf8', filesTree : AllFilesMap });
  let dst = new _.FileProvider.Extract({ protocol : 'dst', encoding : 'utf8', filesTree : FilesMap });
  let hub = new _.FileProvider.System
  ({
    verbosity : 2,
    encoding : 'utf8',
    providers : [ src, dst ],
  });

  hub.filesGrab
  ({
    srcProvider : src,
    dstProvider : dst,
    recipe : useFiles,
  });

  debugger;
}

//

function _starterStart()
{

  _.assert( _starter_.loadingCounter === 0, 'still preloading', _starter_.loadingCounter, 'scripts','asynchronous error!' );
  _.assert( !_starter_.started );
  _starter_.started = true;

  try
  {
    // debugger;
    // console.log( _filePath_ );
    // let scriptFile = _starter_.scriptsMap._starter_;
    let scriptFile = _starter_.scriptsMap[ _filePath_ ];
    // scriptFile.include( _starter_.initScriptPath );
    _starter_._includeMature( { scriptFile : null }, _starter_.initScriptPath );
  }
  catch( err )
  {

    if( !_.errIsRefined( err ) )
    debugger;

    if( _ )
    err = _._err
    ({
      args : [ 'Failed to start root script', _.uri.join( _.uri.server(), _starter_.initScriptPath ),'\n',err ],
      level : _.errIsRefined( err ) ? null : 2,
    });

    if( _ )
    _.errLogOnce( err );
    else
    console.log( err );
  }
}

//

function _starterStartWaiting()
{
  console.log( 'loadingCounter', _starter_.loadingCounter );
  _.assert( _starter_.loadingCounter >= 0 );
  if( _starter_.loadingCounter > 0 || !_starter_.preloaded )
  return _.timeOut( 500, () =>
  {
    _starter_._starterStartWaiting();
    return null;
  })
  _starter_._starterStart();
}

//

function starterStart()
{
  _starter_._starterStartWaiting();
}

//

function starterPreloadEnd()
{
  _.assert( !_starter_.preloaded );
  _starter_.preloaded = 1;
}

//

function _starterStartedWith( scriptPath, preload )
{
  debugger;
  _.assert( !_starter_.started );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( Config.isWorker );
  _starter_.started = true;
  _starter_.initScriptPath = scriptPath;
  preload();
}

// --
// script
// --

function ScriptFile( o )
{
  if( !( this instanceof ScriptFile ) )
  return new ScriptFile( o );

  if( o.isScript === undefined )
  o.isScript = true;

  this.filePath = o.filePath;
  this.dirPath = o.dirPath;
  this.isScript = o.isScript;

  this.filename = o.filePath;
  if( !this.dirPath )
  this.dirPath = _.path.dir( this.filePath );
  this.id = o.filePath;
  this.exports = undefined;
  this.paths = [ '/' ];
  this.parent = null;
  this.error = null;

  // debugger;

  this.starter = _starter_;

  let includeBound = Object.create( null );
  includeBound.scriptFile = this;
  this.include = _starter_._include.bind( includeBound, includeBound );
  // includeBound.include = this.include;

  let resolveBound = Object.create( null );
  resolveBound.scriptFile = this;
  this.resolve = _starter_._resolve.bind( resolveBound, resolveBound );
  // resolveBound.include = this.include;

  let includeAnyBound = Object.create( null );
  includeAnyBound.scriptFile = this;
  this.includeAny = _starter_._includeAny.bind( includeAnyBound, includeAnyBound );
  // includeAnyBound.includeAny = this.includeAny;

  this.presetAttach = _starter_._scriptPresetAttach.bind( this, this );
  this.presetDetach = _starter_._scriptPresetDetach.bind( this, this );

  _starter_._scriptIncludeInit( this );

  Object.preventExtensions( this );

  _starter_.scriptsMap[ this.filePath ] = this;
  _starter_.resourcesMap[ this.filePath ] = this;

  return this;
}

//

function scriptExecBegin( o )
{
  // let parent = _starter_.scriptFile;
  let parentScriptFile = o.parentScriptFile;
  let scriptFile = null;

  // if( o.filePath === '/dwtools/amid/files/l5_provider/RemoteClient.s' )
  // debugger;

  if( _ )
  {
    _.assertRoutineOptions( scriptExecBegin, arguments );
    _.assert( !!parentScriptFile || o.filePath === _starter_.initScriptPath );
  }

  if( _starter_.resourcesMap[ o.filePath ] )
  {
    scriptFile = _starter_.resourcesMap[ o.filePath ];
  }
  else
  {
    scriptFile = new ScriptFile({ filePath : o.filePath, dirPath : o.dirPath, isScript : o.isScript });
  }

  scriptFile.parent = parentScriptFile;

  _starter_.scriptsIncludedMap[ scriptFile.filePath ] = scriptFile;
  _starter_.filesIncludedMap[ scriptFile.filePath ] = scriptFile;

  _starter_.scriptFile = scriptFile;
  _starter_.scriptsStack.push( scriptFile );

  return scriptFile;
}

scriptExecBegin.defaults =
{
  parentScriptFile : null,
  isScript : true,
  filePath : null,
  dirPath : null,
}

//

function scriptExecEnd( o )
{

  if( _ )
  _.assertRoutineOptions( scriptExecEnd, arguments );

  // debugger;
  // if( o.filePath === '/dwtools/atop/tester/zLast.debug.s' )
  // debugger;

  let scriptFile = _starter_.scriptFile;
  _starter_.scriptsStack.pop();
  _starter_.scriptFile = _starter_.scriptsStack[ _starter_.scriptsStack.length-1 ];

  if( scriptFile.filePath !== o.filePath )
  {
    debugger;
    throw Error( 'Something wrong with scriptsStack' );
  }

  if( o.err )
  {
    _starter_.scriptsIncludedMap[ scriptFile.filePath ] = null;
    _starter_.filesIncludedMap[ scriptFile.filePath ] = null;
    scriptFile.error = o.err;
    throw o.err;
  }

}

scriptExecEnd.defaults =
{
  parentScriptFile : null,
  filePath : null,
  err : null,
}

//

function _scriptIncludeInit( scriptFile )
{
  if( _ )
  _.assert( arguments.length === 1, 'Expects single argument' );

  let include = scriptFile.include;
  include.resolve = scriptFile.resolve;

  include.starter = _starter_;
  include.script = scriptFile;
  include.cache = _starter_.cache;
  include.presetAttach = scriptFile.presetAttach;
  include.presetDetach = scriptFile.presetDetach;

  include.mandatory = 1;
  include.filter = Object.create( null );
  include.filter.maskAll = Object.create( null );
  include.filter.maskTerminal = Object.create( null );
  include.filter.maskDirectory = Object.create( null );

  Object.preventExtensions( include );
  return include;
}

//

function _scriptRewrite( filePath,routine )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  let d = _starter_.fileProvider._descriptorScriptMake( filePath, routine );
  _starter_.fileProvider._descriptorWrite( filePath, d );
}

//

function scriptRewrite( filePath, dirPath, routine )
{
  let scriptFile = _starter_.resourcesMap[ filePath ];

  _.assert( arguments.length === 3, 'Expects exactly three arguments' );
  _.assert( _.objectIs( scriptFile ) );

  _scriptRewrite( filePath, routine );
}

//

function _scriptsPreload()
{

  let includeAny = [ /\.s$/,/\.js$/ ];
  if( Config.interpreter === 'njs' )
  includeAny.push( /\.ss$/ );

  let files = _starter_.fileProvider.filesFindRecursive
  ({
    filePath : '/',
    onUp : onUp,
    withTransient/*maybe withStem*//*maybe withStem*/ : 0,
    withDirs : 0,
    resolvingSoftLink : 0,
    resolvingTextLink : 0,
    filter :
    {
      maskTerminal :
      {
        includeAny : includeAny,
        excludeAny : [ /(^|\/)\.(?!$|\/|\.)/, /\.raw(\.|\/|\$)/, /\.run(\.|\/|\$)/, /\.usefile(\.|\/|\$)/ ]
      },
    },
  });

  _starter_._scriptPreloadAct( _.path.normalize( _.path.join( _starter_.starterDirPath, './StarterPreloadEnd.run.s' ) ) );

  function onUp( file, op )
  {
    let d = this._descriptorRead( file.absolute );
    _starter_._scriptPreload( file.absolute );
    return file;
  }

}

//

function _scriptPreloadAct( filePath )
{

  try
  {

    if( Config.offline )
    {

      let d = _starter_.fileProvider._descriptorRead( filePath );
      if( _starter_.fileProvider._descriptorIsScript( d ) )
      {
        d[ 0 ].code();
      }
      else
      {
        _starter_._scriptPreloadFromServer( filePath );
      }

    }
    else
    {

      _starter_._scriptPreloadFromServer( filePath );

    }

  }
  catch( err )
  {
    debugger;
    _.errLogOnce( 'Failed to preload', filePath, '\n', err );
    debugger;
  }

}

//

function _scriptPreload( filePath )
{

  filePath = _.path.normalize( filePath );

  _starter_._scriptPreloadBegin( filePath );
  _starter_._scriptPreloadAct( filePath );

}

//

function _scriptPreloadBegin( filePath )
{

  // _.assert( _.path.isAbsolute( filePath ) );
  // _.assert( !_starter_.resourcesMap[ filePath ] );
  _.assert( !_starter_.loadingMap[ filePath ] );

  _starter_.loadingMap[ filePath ] = 1;
  _starter_.loadingCounter += 1;

}

//

function _scriptPreloadEnd( filePath )
{

  // console.log( 'loadingCounter', _starter_.loadingCounter, ' - ', filePath );

  /* console.log( 'Preloaded', filePath ); */
  _.assert( !!_starter_.loadingMap[ filePath ] );
  _starter_.loadingCounter -= 1;
  delete _starter_.loadingMap[ filePath ];

}

//

function _scriptPreloadFromServer( filePath )
{

  _.assert( arguments.length === 1 );
  _.assert( _.strIs( _starter_.prefixPath ) );

  filePath = _starter_.prefixPath + filePath;

  if( !Config.isWorker )
  {
    _.assert( typeof document !== 'undefined' );
    let script = document.createElement( 'script' );
    script.type = 'text/javascript';
    script.src = filePath;
    document.head.appendChild( script );
  }
  else
  {
    importScripts( filePath );
  }

}

//

function _scriptExec( o )
{
  let err;

  if( o.withBeginEnd )
  _starter_.scriptExecBegin
  ({
    parentScriptFile : o.parentScriptFile,
    filePath : o.filePath,
    dirPath : o.dirPath,
    isScript : true,
  });

  let scriptFile = _starter_.resourcesMap[ o.filePath ];

  try
  {
    let result = o.code.call( _realGlobal, o );
  }
  catch( _err )
  {
    err = _err;
    if( _ )
    err = _._err
    ({
      args : [ 'Exception including', _.uri.join( _.uri.server(), o.filePath ),'\n',err ],
      level : _.errIsRefined( err ) ? null : 2,
    });
    scriptFile.error = err;
  }

  if( o.withBeginEnd )
  _starter_.scriptExecEnd
  ({
    parentScriptFile : o.parentScriptFile,
    filePath : o.filePath,
    err : err || null,
  });
  else if( err )
  throw err;

  return scriptFile;
}

_scriptExec.defaults =
{
  parentScriptFile : null,
  withBeginEnd : 1,
  dirPath : null,
  filePath : null,
  code : null,
}

// --
// include
// --

function _includeModule( bound,filePath )
{
  let scriptFile = bound.scriptFile;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( !_.path.isAbsolute( filePath ) && !_.path.isDotted( filePath ) );

  if( !_starter_.modulesMap[ filePath ] )
  {
    throw _._err
    ({
      args : [ 'Not found module ' + _.strQuote( filePath ) + ' from ' + _.strQuote( _.uri.full( scriptFile.filePath ) ) ],
      level : 5,
    });
  }

  let module = _starter_.modulesMap[ filePath ];

  _.assert( !!module.dependenciesLogic );
  _.assert( _.strsAreAll( module.dependenciesLogic.any ) );

  let result = scriptFile.includeAny.apply( scriptFile, module.dependenciesLogic.any );

  return result;
}

//

function _includeNop( bound, filePath )
{
}

//

function _includeSingleMature( bound,filePath )
{
  let scriptFile = bound.scriptFile;

  if( _starter_.verbosity >= 2 )
  if( scriptFile )
  console.log( 'Including' , scriptFile.filePath, '<-', filePath );
  else
  console.log( 'Including root file' , filePath );

  if( !_.path.isAbsolute( filePath ) && !_.path.isDotted( filePath ) )
  if( _starter_.allowModulling )
  {
    return _starter_._includeModule( bound,filePath );
  }
  else
  {
    throw _._err
    ({
      args : [ 'Path of script to include should be relative ( starts from dot ) or absolute ( starts from slash )' ],
      level : 4,
    });
  }

  /* resolve */

  try
  {
    filePath = _starter_._resolve( bound, filePath );
  }
  catch( err )
  {
    throw _.err( err );
  }

  /* get from cache */

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( _starter_.filesIncludedMap[ filePath ] )
  {
    let scriptFile = _starter_.filesIncludedMap[ filePath ];
    return scriptFile.exports;
  }

  /* still not preloaded */

  if( !_starter_.resourcesMap[ filePath ] )
  {
    let r = _starter_._includeSingleAsset( bound, filePath );
    if( r.included )
    return r.returned;
    _.sure( Config.isWorker, 'Cant load', filePath );
    _starter_._scriptPreload( filePath );
  }

  /* get descriptor */

  let descriptor = _starter_.fileProvider._descriptorRead( filePath );

  if( !_.arrayIs( descriptor ) || descriptor.length !== 1 )
  {

    if( _ )
    throw _._err
    ({
      args : [ 'Failed to read script "' + filePath + '"' ],
      level : 4,
    });
    else
    throw Error( 'Failed to read script "' + filePath + '"' );

  }

  /* execute */

  let code;
  if( descriptor[ 0 ].code )
  {
    code = descriptor[ 0 ].code
  }
  else _.assert( 0,'unknown kind of file',filePath );

  let result = _scriptExec
  ({
    filePath : filePath,
    dirPath : _.path.dir( filePath ),
    parentScriptFile : scriptFile,
    code : code,
    withBeginEnd : 1,
  });

  return result.exports;
}

//

function _includeMature( bound, filePath )
{
  let scriptFile = bound.scriptFile;
  let fileProvider = _starter_.fileProvider;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( fileProvider.path.isDotted( filePath ) )
  filePath = fileProvider.path.resolve( scriptFile.dirPath, filePath );

  if( _starter_.usingGlob && _.path.isGlob( filePath ) )
  {
    let result = Object.create( null );

    let o = Object.create( null );
    o.filter = fileProvider.RecordFilter.And( { system : fileProvider }, _starter_.includeDefaults.filter, scriptFile.include.filter );
    o.withTransient/*maybe withStem*//*maybe withStem*/ = 0;
    o.withDirs = 0;
    o.resolvingSoftLink = 0;
    o.resolvingTextLink = 0;
    o.filePath = filePath;

    _.mapSupplement( o, _.mapOnly( scriptFile.include, fileProvider.filesFindRecursive.defaults ) );
    _.mapSupplement( o, _starter_.includeDefaults );

    let files = fileProvider.filesFindRecursive( o );

    if( !files.length )
    {
      if( scriptFile.include.mandatory )
      throw _._err
      ({
        args : [ 'None script file found at ' + filePath ],
        level : 3,
      });
      else
      return result;
    }

    for( let f = 0 ; f < files.length ; f++ )
    {
      let file = files[ f ];
      result[ file.absolute ] = _starter_._includeSingleMature( bound, files[ f ].absolute );
    }

    return result;
  }
  else
  {
    return _starter_._includeSingleMature( bound, filePath );
  }

}

//

function _include( bound, filePath )
{
  let scriptFile = bound.scriptFile;

  if( _ && _.assert )
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( _starter_.inited )
  return _starter_._includeMature.call( this, bound, filePath );
  else
  return _starter_._includeNop.call( this, bound, filePath );
}

//

function _includeSingleAsset( bound, filePath )
{
  let parentScriptFile = bound.scriptFile;

  let result = Object.create( null );
  result.included = false;

  let d = _starter_.fileDescriptor( parentScriptFile, filePath )
  if( d )
  {

    let dirPath = _.path.dir( filePath );
    let assetFile = _starter_.scriptExecBegin
    ({
      parentScriptFile : parentScriptFile,
      filePath : filePath,
      dirPath : dirPath,
      isScript : false,
    });

    try
    {
      result.returned = d.includeSingle( parentScriptFile, assetFile );
    }
    catch( err )
    {
      assetFile.error = _._err
      ({
        args : [ 'Failed to include "' + filePath + '"' ],
        level : 4,
      });
    }

    result.included = true;
    _starter_.scriptExecEnd
    ({
      parentScriptFile : parentScriptFile,
      filePath : filePath,
      err : assetFile.error,
    });

    _starter_.assetsCounter += 1;
    _.assert( !!_starter_.resourcesMap[ filePath ] );
    _.assert( !!_starter_.filesIncludedMap[ filePath ] );
  }

  return result
}

//

function _resolve( bound, filePath )
{
  let scriptFile = bound.scriptFile;

  let _ = _starterGlobal_.wTools;
  let fileOriginalPath = filePath;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  if( !_.path.isAbsolute( filePath ) )
  {
    filePath = _.path.normalize( _.path.join( scriptFile.dirPath, filePath ) );
  }

  if( _starter_.resourcesMap[ filePath ] )
  return filePath;

  if( _starter_.fileProvider )
  if( _starter_.fileProvider._descriptorRead( filePath ) )
  return filePath;

  if( _ )
  throw _._err
  ({
    args : [ 'Failed to resolve script ' + _.strQuote( fileOriginalPath ) + ( scriptFile ? ' from ' + _.strQuote( scriptFile.filePath ) : '' ) ],
    level : 2,
  });
  else
  throw Error( 'Failed to resolve script ' + _.strQuote( fileOriginalPath ) + ( scriptFile ? ' from ' + _.strQuote( scriptFile.filePath ) : '' ) );

  return filePath;
}

//

function _includeAny( bound )
{
  let scriptFile = bound.scriptFile;

  _.assert( arguments.length >= 2, 'Expects at least two arguments' );

  for( let a = 1 ; a < arguments.length ; a++ )
  {
    let src = arguments[ a ];

    if( src !== '' )
    try
    {
      let resolved = scriptFile.resolve( src );
      src = resolved;
    }
    catch( err )
    {
      if( a !== arguments.length-1 )
      continue;
    }

    if( a === arguments.length-1 && src === '' )
    return;

    let result = _starter_._include( bound, src );

    return result;
  }

  _.assert( 0,'unexpected' );
}

// --
// module support
// --

function moduleDeclare( o )
{
  o = _.routineOptions( moduleDeclare, arguments );
  _.assert( o.isIncluded === null || _.routineIs( o.isIncluded ) );
  _.assert( !_starter_.modulesMap[ o.name ], 'Module', o.name, 'was already declared' );

  _starter_.modulesMap[ o.name ] = o;

  // o.dependenciesLogic = _.logic.traverse
  // ({
  //   branchMap :
  //   {
  //     any : 'any',
  //     all : 'all',
  //   },
  //   terminalMap :
  //   {
  //     dependency : 'dependency',
  //     file : 'file',
  //     module : 'module',
  //   },
  //   src : o.dependenciesLogic,
  // });

  return o;
}

moduleDeclare.defaults =
{
  name : null,
  isIncluded : null,
  dependenciesLogic : null,
// dependenciesMap : null,
}

//

function moduleWithIncludeHandlerDeclare( o )
{
  o = _.routineOptions( moduleWithIncludeHandlerDeclare, arguments );

  let knownFields =
  {
    includeAny : null,
    isIncluded : null,
  }

  _.assertMapHasOnly( o.includeHandler, knownFields );
  _.assert( o.includeHandler.includeAny && o.includeHandler.includeAny.length >= 0 );

  let moduleOptions = Object.create( null );
  moduleOptions.name = o.name;
  let dependenciesLogic = moduleOptions.dependenciesLogic = Object.create( null );
  dependenciesLogic.any = o.includeHandler.includeAny.slice();
  dependenciesLogic.any = o.includeHandler.includeAny.map( function( e,k )
  {
    return _.path.resolve( _starter_.includeToolsPath,'..',e );
  });

  return _starter_.moduleDeclare( moduleOptions );
}

moduleWithIncludeHandlerDeclare.defaults =
{
  name : null,
  includeHandler : null,
}

//

function modulesWithIncludeHandlersDeclare( handlers )
{
  if( handlers === undefined )
  handlers = _global_.ModulesRegistry;

  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( _.objectIs( handlers ) );

  for( let h in handlers )
  {
    let handler = handlers[ h ];
    _starter_.moduleWithIncludeHandlerDeclare
    ({
      name : h,
      includeHandler : handler,
    });
  }

}

// --
// preset
// --

function _scriptPresetAttach( scriptFile, presetName )
{
  let preset = _starter_.presets[ presetName ];

  _.assert( _.objectIs( preset ), 'unknown preset', presetName );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.mapExtendAppendingOnceRecursive( scriptFile.include, preset );

  return preset;
}

//

function _scriptPresetDetach( scriptFile, presetName )
{
  let preset = _starter_.presets[ presetName ];

  _.assert( _.objectIs( preset ), 'unknown preset', presetName );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.mapSupplementRemovingRecursive( scriptFile.include, preset );

  return preset;
}

//

function _starterPresetAttach( presetName )
{
  let preset = _starter_.presets[ presetName ];

  _.assert( _.objectIs( preset ), 'unknown preset', presetName );
  _.assert( arguments.length === 1, 'Expects single argument' );

  _.mapExtendAppendingOnceRecursive( _starter_.includeDefaults, preset );

  return preset;
}

//

function _starterPresetDetach( presetName )
{
  let preset = _starter_.presets[ presetName ];

  _.assert( _.objectIs( preset ), 'unknown preset', presetName );
  _.assert( arguments.length === 1, 'Expects single argument' );

  _.mapSupplementRemovingRecursive( _starter_.includeDefaults, preset );

  return preset;
}

//

function presetRefine( preset )
{
  _.assert( _.strIs( preset ) || _.objectIs( preset ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.containerIs( preset ) || _.objectIs( _starter_.presets[ preset ] ), 'unknown preset', preset );

  if( _.strIs( preset ) )
  preset = _starter_.presets[ preset ];

  if( preset.filter )
  _.entityFreezeRecursive( preset.filter );

  return preset;
}

//

function presetsRefine( presets )
{
  _.assert( _.containerIs( presets ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  _.each( presets, function( preset )
  {
    _starter_.presetRefine( preset );
  });

}

// --
// etc
// --

function includeSingleStyleAsync( parentScriptFile, assetFile )
{
  let ext = _.uri.ext( assetFile.filePath );

  if( ext === 'css' )
  return includeSingleStyleSync( parentScriptFile, assetFile );

  _starter_._scriptPreloadBegin( assetFile.filePath );

  let link = document.createElement( 'link' );
  link.addEventListener( 'load', handleLoad );
  // debugger;
  link.type = 'text/' + ext;
  link.rel = 'stylesheet';
  link.media = 'screen,print';
  link.href = assetFile.filePath; /* xxx */
  document.head.appendChild( link );

  function handleLoad( e )
  {
    _starter_._scriptPreloadEnd( assetFile.filePath );
  }

}

//

function includeSingleStyleSync( parentScriptFile, assetFile )
{

  _starter_._scriptPreloadBegin( assetFile.filePath );

  try
  {

    let text = _.fileProvider.fileRead({ filePath : assetFile.filePath, sync : 1 });
    let ext = _.uri.ext( assetFile.filePath );
    let link = document.createElement( 'style' );

    // debugger;

    // if( ext === 'less' )
    // {
    //   debugger;
    //   less.render( text, _.mapExtend( null, less.options ), function( err, got )
    //   {
    //     debugger;
    //   });
    // }
    // else
    // {
      link.type = 'text/' + ext;
      link.rel = 'stylesheet';
      link.media = 'screen,print';
      link.appendChild( document.createTextNode( text ) );
      // if( ext === 'less' )
      // link.href = assetFile.filePath;
      document.head.appendChild( link );
    // }

    // debugger;
  }
  catch( err )
  {
    debugger;
    throw _.err( err );
  }

  // function handleLoad( e )
  // {
  _starter_._scriptPreloadEnd( assetFile.filePath );
  // }

}

//

function fileDescriptor( parentScriptFile, filePath )
{

  let ext = _.uri.ext( filePath );
  if( _.arrayHas( styleDescriptor.exts, ext ) )
  return styleDescriptor;

  return null;
}

//

let styleDescriptor =
{
  kind : 'style',
  exts : [ 'less', 'css' ],
  includeSingle : includeSingleStyleAsync,
}

//

function _moduleGet()
{
  debugger;
  return this.scriptFile;
}

//

function _mapSupplement( dst, src )
{
  for( let s in src )
  {
    if( dst[ s ] === undefined )
    dst[ s ] = src[ s ];
  }
  return dst;
}

// --
// fields
// --

let includeDefaults = Object.create( null );

includeDefaults.mandatory = 1;
includeDefaults.filter = Object.create( null );
includeDefaults.filter.maskAll = Object.create( null );
includeDefaults.filter.maskTerminal = Object.create( null );
includeDefaults.filter.maskDirectory = Object.create( null );

let presets = Object.create( null );

var preset = presets.StagingDebug = Object.create( null );
preset.filter = Object.create( null );
preset.filter.maskAll = Object.create( null );
preset.filter.maskAll.excludeAny = [ /\.release(\.|\/|$)/i, /\.production(\.|\/|$)/i ];

var preset = presets.Styles = Object.create( null );
preset.filter = Object.create( null );
preset.filter.maskTerminal = Object.create( null );
preset.filter.maskTerminal.includeAny = [ /\.css$/i, /\.less$/i ];

var preset = presets.Scripts = Object.create( null );
preset.filter = Object.create( null );
preset.filter.maskTerminal = Object.create( null );
preset.filter.maskTerminal.includeAny = [ /\.js$/i, /\.s$/i, /\.ss$/i ];

var preset = presets.ExcludeHidden = Object.create( null );
preset.filter = Object.create( null );
preset.filter.maskAll = Object.create( null );
preset.filter.maskAll.includeAny = [ /\.manual(\.|\/|$)/i, /(^|\/)-/ ];

var preset = presets.ExcludeSystem = Object.create( null );
preset.filter = Object.create( null );
preset.filter.maskAll = Object.create( null );
preset.filter.maskAll.includeAny = [ /(^|\/)node_modules(\/|$)/i, /(^|\/)\.(?!$|\/|\.)/ ];

let loadingMap = Object.create( null );

let scriptsMap = Object.create( null );
let scriptsIncludedMap = Object.create( null );

let resourcesMap = Object.create( null );
let filesIncludedMap = Object.create( null );

let modulesMap = Object.create( null );
let modulesIncludedMap = Object.create( null );

_include.cache = scriptsIncludedMap;

//

let Fields =
{

  includeDefaults : includeDefaults,
  presets : presets,

  ScriptFile : ScriptFile,
  scriptFile : null,
  scriptsStack : [],

  loadingMap : loadingMap,
  scriptsMap : scriptsMap,
  scriptsIncludedMap : scriptsIncludedMap,
  cache : scriptsIncludedMap,
  resourcesMap : resourcesMap,
  filesIncludedMap : filesIncludedMap,
  modulesMap : modulesMap,
  modulesIncludedMap : modulesIncludedMap,

  inited : 0,
  preloaded : 0,
  started : 0,
  loadingCounter : 0,
  assetsCounter : 0,
  fileProvider : null,

  prefixPath : '',
  initScriptPath : null,
  starterDirPath : null,
  includeToolsPath : '/dwtools/abase/l2/IncludeTools.s',

  allowModulling : 1,
  usingIncludeHandlers : 1,
  usingGlob : 1,
  verbosity : 1,

}

// --
// routines
// --

let Routines =
{

  // starter

  _starterFormBegin : _starterFormBegin,
  _starterFormEnd : _starterFormEnd,

  _starterUseFilesForm : _starterUseFilesForm,
  _starterStart : _starterStart,
  _starterStartWaiting : _starterStartWaiting,
  starterStart : starterStart,
  starterPreloadEnd : starterPreloadEnd,
  _starterStartedWith : _starterStartedWith,

  // script

  ScriptFile : ScriptFile,
  scriptExecBegin : scriptExecBegin,
  scriptExecEnd : scriptExecEnd,
  _scriptIncludeInit : _scriptIncludeInit,

  _scriptRewrite : _scriptRewrite,
  scriptRewrite : scriptRewrite,
  _scriptsPreload : _scriptsPreload,
  _scriptPreloadAct : _scriptPreloadAct,
  _scriptPreload : _scriptPreload,
  _scriptPreloadBegin : _scriptPreloadBegin,
  _scriptPreloadEnd : _scriptPreloadEnd,
  _scriptPreloadFromServer : _scriptPreloadFromServer,
  _scriptExec : _scriptExec,

  // include

  _includeModule : _includeModule,
  _includeNop : _includeNop,
  /*_includeStarting : _includeStarting,*/
  _includeSingleMature : _includeSingleMature,
  _includeMature : _includeMature,
  _include : _include,
  _includeSingleAsset : _includeSingleAsset,
  _resolve : _resolve,

  _includeAny : _includeAny,

  // module support

  moduleDeclare : moduleDeclare,
  moduleWithIncludeHandlerDeclare : moduleWithIncludeHandlerDeclare,
  modulesWithIncludeHandlersDeclare : modulesWithIncludeHandlersDeclare,

  // preset

  _scriptPresetAttach : _scriptPresetAttach,
  _scriptPresetDetach : _scriptPresetDetach,
  presetAttach : _starterPresetAttach,
  presetDetach : _starterPresetDetach,
  presetRefine : presetRefine,
  presetsRefine : presetsRefine,

  // etc

  fileDescriptor : fileDescriptor,
  _moduleGet : _moduleGet,

}

//

// Object.assign( _starter_, Routines );
// Object.assign( _starter_, Fields );
// debugger;
_mapSupplement( _starter_, Routines );
_mapSupplement( _starter_, Fields );
// debugger;

_starter_._starterFormBegin();

// < StarterInitBegin
