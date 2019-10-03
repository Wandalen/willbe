( function _StarterMaker_s_() {

'use strict';

/**
 * @file starter/StarterMaker.s.
 */

if( typeof module !== 'undefined' )
{

  // let _ = require( '../../Tools.s' );
  // require( './light/StarterMaker.s' );

  let _ = wTools;

  _.include( 'wCopyable' );
  _.include( 'wVerbal' );
  _.include( 'wFiles' );
  _.include( 'wTemplateTreeEnvironment' );

}

//

/**
 * @classdesc Class to generate code for run-time.
 * @param {Object} o Options map for constructor. {@link module:Tools/mid/Starter.wStarterMaker.Fields Options description }
 * @class wStarterMaker
 * @memberof module:Tools/mid/Starter
*/

let _ = wTools;
let Parent = null;
let Self = function wStarterMaker( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'StarterMaker';

//

function init( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  self.logger = new _.Logger({ output : logger });

  _.workpiece.initFields( self );
  Object.preventExtensions( self );

  if( o )
  self.copy( o );

}

//


/**
 * @descriptionNeeded
 * @function exec
 * @memberof module:Tools/mid/Starter.wStarterMaker#
*/

function exec()
{

  _.assert( arguments.length === 0 );

  let o = {};
  let appArgs = _.appArgs();
  let self = new this.Self( o );

  return self;
}

//

/**
 * @summary Forms and checks fields of current instance.
 * @function form
 * @memberof module:Tools/mid/Starter.wStarterMaker#
*/

function form()
{
  let self = this;
  let logger = self.logger;

  _.assert( arguments.length === 0 );
  _.assert( !self.formed );
  _.assert( !!self.system );

  self.formed = 1;

  if( self.inPath === null )
  self.inPath = self.outPath;
  if( self.outPath === null )
  self.outPath = self.inPath;

  // self.inPath = self.env.resolve( self.inPath );
  // self.outPath = self.env.resolve( self.outPath );
  // self.toolsPath = self.env.resolve( self.toolsPath );
  // self.initScriptPath = self.env.resolve( self.initScriptPath );

  if( !self.env )
  self.env = _.TemplateTreeEnvironment({ tree : self, path : _.uri });
  self.env.pathsNormalize();

  // /* !!! temp fix, should be replaced but fixing pathsNormalize */
  // self.toolsPath = _.strReplaceAll( self.toolsPath, '//', '/' );

  if( !self.system.providersWithProtocolMap.dst )
  self.system.providerRegister( new _.FileProvider.Extract({ protocol : 'dst'/*, encoding : 'utf8'*/ }) );

  _.assert( !!self.system );
  _.assert( !!self.system.providersWithProtocolMap.src );
  _.assert( !!self.system.providersWithProtocolMap.dst );

  _.assert( _.strIs( self.inPath ) );
  _.assert( _.strIs( self.outPath ) );
  _.assert( _.strIs( self.toolsPath ) );
  _.assert( _.strIs( self.initScriptPath ) );
  _.assert( _.strIs( self.starterDirPath ) );
  _.assert( _.strIs( self.starterScriptPath ) );
  _.assert( _.strIs( self.rootPath ) );
  _.assert( _.strIs( self.prefixPath ) );

  logger.rbegin({ verbosity : -2 });
  logger.log( 'Starter.paths :' );
  logger.up();
  logger.log( 'inPath :', self.inPath );
  logger.log( 'outPath :', self.outPath );
  logger.log( 'rootPath :', self.rootPath );
  logger.log( 'initScriptPath :', self.initScriptPath );
  logger.log( 'starterDirPath :', self.starterDirPath );
  logger.log( 'starterScriptPath :', self.starterScriptPath );
  logger.log( 'starterConfigPath :', self.starterConfigPath );
  logger.log( 'toolsPath :', self.toolsPath );
  logger.log( 'prefixPath :', self.prefixPath );
  logger.down();
  logger.rend({ verbosity : -2 });

  return self;
}

//

/**
 * @summary Forms hub file provider and registers additional providers on it.
 * @function fileProviderForm
 * @memberof module:Tools/mid/Starter.wStarterMaker#
*/

function fileProviderForm()
{
  let self = this;

  _.assert( arguments.length === 0 );

  let srcFileProvider = new _.FileProvider.Extract({ protocol : 'src'  });
  let dstFileProvider = new _.FileProvider.Extract({ protocol : 'dst'  });
  let hdFileProvider = new _.FileProvider.HardDrive({});

  self.system = self.system || new _.FileProvider.System
  ({
    verbosity : 2,
    providers : [],
  });

  if( !self.system.providersWithProtocolMap.src )
  self.system.providerRegister( new _.FileProvider.Extract({ protocol : 'src'  }) );

  if( !self.system.providersWithProtocolMap.dst )
  self.system.providerRegister( new _.FileProvider.Extract({ protocol : 'dst'  }) );

  if( !self.system.providersWithProtocolMap.file )
  self.system.providerRegister( new _.FileProvider.HardDrive({}) );

  return self;
}

//

/**
 * @summary Reads source files from path `o.srcPath` to inner file provider.
 * @param {Object} o Options map.
 * @param {String} o.srcPath Path to directory with source files.
 * @function fromHardDriveRead
 * @memberof module:Tools/mid/Starter.wStarterMaker#
*/

function fromHardDriveRead( o )
{
  let self = this;
  let srcFileProvider = self.system.providersWithProtocolMap.src;

  if( _.strIs( arguments[ 0 ] ) )
  o = { srcPath : arguments[ 0 ] }

  // let protoPath = _.uri.join( 'file://', this.env.pathGet( '{{path/proto}}' ) );
  // let stagingPath = _.uri.join( 'file://', this.env.pathGet( '{{path/staging}}' ) );

  _.assert( arguments.length === 1 );
  _.routineOptions( fromHardDriveRead, o );

  self.system.verbosity = 1;
  let srcLocalPath = _.uri.parse( o.srcPath ).longPath;

  let reflect = self.system.filesReflector
  ({
    src : { prefixPath : o.srcPath, basePath : srcLocalPath },
    dst : { prefixPath : 'src:///' },
    filter :
    {
      ends : [ '.js', '.s', '.css', '.less', '.jslike' ],
      maskAll : _.files.regexpMakeSafe(),
      maskTransientAll : _.files.regexpMakeSafe()
    },
    linking : 'softLink',
    mandatory : 1,
  });

  let reflected = reflect( '.' );

}

fromHardDriveRead.defaults =
{
  srcPath : null,
}

//

/**
 * @summary Writes source files from inner file provider to path `o.dstPath` on hard drive.
 * @param {Object} o Options map.
 * @param {String} o.dstPath Path where to write source files.
 * @function toHardDriveWrite
 * @memberof module:Tools/mid/Starter.wStarterMaker#
*/

function toHardDriveWrite( o )
{
  let self = this;

  if( _.strIs( arguments[ 0 ] ) )
  o = { dstPath : arguments[ 0 ] }

  _.assert( arguments.length === 1 );
  _.routineOptions( toHardDriveWrite, o );

  let reflect = self.system.filesReflector
  ({
    src : { basePath : _.uri.join( 'dst://', '/' ), prefixPath : _.uri.join( 'dst://', '/' ) },
    dst : { prefixPath : _.uri.join( 'file://', o.dstPath ), basePath : _.uri.join( 'file://', o.dstPath ) },
    mandatory : 1,
  });

  let reflected = reflect( '.' );

}

toHardDriveWrite.defaults =
{
  dstPath : null,
}

//


/**
 * @summary Generates source code wrapper for a single file.
 * @description Wrapper helps to load( require ) source file on a client side.
 * @param {Object} o Options map.
 * @param {String} o.prefixPath Prefix for file path
 * @param {String} o.filePath Path to source file
 * @param {String} o.dirPath Path to directory with source file
 * @param {Boolean} o.running
 * @function fixesFor
 * @memberof module:Tools/mid/Starter.wStarterMaker#
*/

function fixesFor( o )
{

  _.routineOptions( fixesFor, arguments );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( o.filePath ) );

  if( o.prefixPath )
  o.filePath = o.prefixPath + o.filePath;
  if( o.prefixPath && o.dirPath !== null )
  o.dirPath = o.prefixPath + o.dirPath;

  // if( o.prefixPath )
  // o.rootPath = o.prefixPath + o.rootPath;

  var result = Object.create( null );
  var exts = _.path.exts( o.filePath );

  if( o.running === null )
  o.running = _.arrayHasAny( [ 'run' ], exts );

  if( o.dirPath === null )
  o.dirPath = _.path.dir( o.filePath );
  // var filePath = _.path.normalize( _.path.reroot( o.rootPath, o.filePath ) );
  var shortName = _.strVarNameFor( _.path.fullName( o.filePath ) );

  result.prefix = `/* */ /* > ${o.filePath} */ `
  result.prefix += `( function ${shortName}() { `; /**/
  result.prefix += `var _naked = function ${shortName}_naked() { `; /**/

  /* .. code .. */

  result.postfix = '/* */\n';
  result.postfix += `/* */ }\n`; /* end of _naked */

  result.postfix +=
`/* */
/* */  var _filePath_ = '${o.filePath}';
/* */  var _dirPath_ = '${o.dirPath}';
/* */  var __filename = _filePath_;
/* */  var __dirname = _dirPath_;
/* */  var _scriptFile_, module, include, require;
`

  result.postfix +=
`/* */
/* */  var _preload = function ${shortName}_preload()
/* */  {
/* */    if( typeof _starter_ === 'undefined' )
/* */    return;
/* */    _scriptFile_ = new _starter_.ScriptFile({ filePath : _filePath_, dirPath : _dirPath_ });
/* */    module = _scriptFile_;
/* */    include = _scriptFile_.include;
/* */    require = include;
/* */    _starter_.scriptRewrite( _filePath_, _dirPath_, _naked );
/* */    _starter_._scriptPreloadEnd( _filePath_ );
/* */  }
`

  if( o.running )
  result.postfix +=
`/* */
/* */  _naked();
`
  else
  result.postfix +=
`/* */
/* */  if( typeof _starterScriptsToPreload === 'undefined' )
/* */  _starterScriptsToPreload = Object.create( null )
/* */
/* */  if( typeof _starter_ !== 'undefined' )
/* */  {
/* */    _preload();
/* */  }
/* */  else
/* */  {
/* */    _starterScriptsToPreload[ __filename ] = _preload;
/* */    _naked();
/* */  }
`

  result.postfix += `/* */})();\n`; /* end of r */
  result.postfix += `/* */ /* < ${o.filePath} */`;

  return result;
}

fixesFor.defaults =
{
  prefixPath : '',
  filePath : null,
  dirPath : null,
  running : null,
}

//

/**
 * @summary Makes files map and saves it to hard drive.
 * @descriptionNeeded
 * @function filesMapMake
 * @memberof module:Tools/mid/Starter.wStarterMaker#
*/

function filesMapMake()
{
  let self = this;
  let logger = self.logger;
  let system = self.system;
  let srcFileProvider = system.providersWithProtocolMap.src;
  // let dstFileProvider = system.providersWithProtocolMap.dst;

  _.assert( _.strIs( self.appName ) );
  _.assert( arguments.length === 0 );

  logger.rbegin({ verbosity : -2 });
  logger.log( 'Making files map..' );
  logger.rend({ verbosity : -2 });

  let fmap = new _.FileProvider.Extract({ protocol : 'fmap' });
  system.providerRegister( fmap );

  /* */

  debugger;
  if( self.useFile === null && self.useFilePath )
  self.useFile = self.system.fileRead
  ({
    filePath : self.useFilePath,
    encoding : 'js.smart',
    sync : 1,
    resolvingSoftLink : 1,
  });
  debugger;
  self.useFile = self.useFile || Object.create( null );
  self.useFile.reflectMap = self.useFile.reflectMap || '**';

  /* */

  // debugger;
  let reflect = self.system.filesReflector
  ({
    // reflectMap : self.useFile || '**',
    dst :
    {
      prefixPath : _.uri.join( self.inPath, 'fmap://' ),
      basePath : _.uri.join( self.inPath, 'fmap://' )
    },
    src :
    {
      prefixPath : _.uri.join(  self.inPath, 'src://', ),
      basePath : _.uri.join(  self.inPath, 'src://', ),
      recursive : 2,
    },
    linking : 'fileCopy',
    resolvingSrcSoftLink : 0,
    // recursive : 2,
  });
  // debugger;

  debugger;
  let found = reflect( self.useFile );
  debugger;

  if( self.offline )
  {

    let found = self.system.filesFind
    ({
      filter :
      {
        filePath : 'fmap:///',
        recursive : 2,
      },
      includingTerminals : 1,
      includingTransient : 0,
      resolvingSoftLink : 0,
      onUp : onUp,
    });

    _.sure( !!found.length, 'none script found' );

  }

  if( self.includePath )
  self.system.softLinksRebase
  ({
    filePath : 'fmap:///',
    oldPath : self.includePath,
    newPath : 'file:///',
  })

  // debugger;
  system.fileWriteJs
  ({
    filePath : _.uri.join( 'dst://', self.outPath, self.appName + '.raw.filesmap.s' ),
    prefix : 'FilesMap = \n',
    data : fmap.filesTree,
  });
  // debugger;

  // system.providerUnregister( fmap );
  fmap.finit();
  _.assert( system.providersWithProtocolMap.fmap === undefined );

  /* */

  function onUp( file, op )
  {
    let resolvedPath = system.pathResolveLinkFull( file.absoluteGlobal ).filePath;
    let prefixToRemove = /^#\!\s*\/.+/;

    if( self.offline && _.arrayHas( [ 's','js','ss' ], file.ext ) )
    {

      let fixes = self.fixesFor
      ({
        filePath : file.absolute,
      });

      let data = system.fileRead( resolvedPath );
      data = _.strRemoveBegin( data,prefixToRemove );
      data = fixes.prefix + data + fixes.postfix;
      fmap._descriptorWrite( file.absolute, fmap._descriptorScriptMake( file.absolute, data ) );
    }
    else if( file.isSoftLink )
    {
      fmap.softLink
      ({
        srcPath : file.absolute,
        dstPath : file.absolute,
        allowingMissed : 1,
      });
    }

    return file;
  }

}

//

/**
 * @summary Prepares starter files and writes them to the hard drive.
 * @descriptionNeeded
 * @function starterMake
 * @memberof module:Tools/mid/Starter.wStarterMaker#
*/

function starterMake()
{
  let self = this;
  let requireCode = '';
  let builtinMapCode = '';
  let logger = self.logger;
  let system = self.system;
  let srcFileProvider = system.providersWithProtocolMap.src;
  let dstFileProvider = system.providersWithProtocolMap.dst;

  logger.rbegin({ verbosity : -2 });
  logger.log( 'Making starter..' );
  logger.rend({ verbosity : -2 });

  _.assert( arguments.length === 0 );

  let find = self.system.filesFinder
  ({
    includingTerminals : 1,
    includingTransient : 0,
    mandatory : 1,
    onUp : onUpInliningToStarter,
    filter :
    {
      filePath : _.uri.join( 'src://', self.toolsPath ),
      recursive : 2,
      ends : [ '.js','.s' ],
    }
  });

  // debugger;
  find( 'abase/l0' );
  find( 'abase/l1' );
  find( 'abase/l2' );
  find( 'abase/l3' );
  find( 'abase/l4' );
  find( 'abase/l5' );
  find( 'abase/l6' );
  find( 'abase/l7' );
  find( 'abase/l7_mixin' );
  find( 'abase/l8' );
  find( 'abase/l9/consequence' );
  find( 'abase/l9/printer' );

  find( 'amid/l5_mapper/TemplateTreeAresolver.s' );
  find( 'amid/amixin/Verbal.s' );
  find( 'amid/bclass/RegexpObject.s' );

  find( 'amid/files/UseBase.s' );
  find( 'amid/files/l1' );
  find( 'amid/files/l2' );
  find( 'amid/files/l3' );
  find( 'amid/files/l5_provider/Extract.s' );
  find( 'amid/files/l5_provider/HtmlDocument.js' );
  find( 'amid/files/l5_provider/Http.js' );
  find( 'amid/files/l7/System.s' );

  _.sure( _.strIs( builtinMapCode ), 'None source script' );

  starterWrite();
  configWrite();
  starterPreloadWrite();
  starterStartWrite();

  /* - */

  function starterWrite()
  {
    let begin = _.fileProvider.fileRead( _.path.join( __dirname, './StarterInitBegin.raw.s' ) );
    let end = _.fileProvider.fileRead( _.path.join( __dirname, './StarterInitEnd.raw.s' ) );

    let fixes = self.fixesFor
    ({
      filePath : self.starterScriptPath,
      dirPath : self.rootPath,
      running : 1,
    });

    let code = fixes.prefix + begin + builtinMapCode + /*settingsCode +*/ requireCode + end + fixes.postfix;
    code = '(function _StarterInit_s_(){\n' + code + '\n})();';
    dstFileProvider.fileWrite( self.starterScriptPath, code );
  }

  /* - */

  function configWrite()
  {

    let begin = _.fileProvider.fileRead( _.path.join( __dirname, './StarterConfigBegin.raw.s' ) );
    let settingsCode =
`
_realGlobal._starter_.prefixPath = '${self.prefixPath}';
_realGlobal._starter_.initScriptPath = '${self.initScriptPath}';
_realGlobal._starter_.starterDirPath = '${self.starterDirPath}';
Config.offline = ${_.toStr( !!self.offline )};
`;

    let code = begin + settingsCode;
    dstFileProvider.fileWrite( self.starterConfigPath, code );

  }

  /* - */

  function starterPreloadWrite()
  {
    let code = _.fileProvider.fileRead( _.path.join( __dirname, 'StarterPreloadEnd.raw.s' ) );
    dstFileProvider.fileWrite( _.path.join( self.outPath, 'StarterPreloadEnd.run.s' ), code );
    // srcFileProvider.fileWrite( _.path.join( self.outPath, 'StarterPreloadEnd.run.s' ), code );
  }

  /* - */

  function starterStartWrite()
  {
    let code = _.fileProvider.fileRead( _.path.join( __dirname, './StarterStart.raw.s' ) );
    dstFileProvider.fileWrite( _.path.join( self.outPath, 'StarterStart.run.s' ), code );
  }

  /* - */

  function onUpInliningToStarter( file )
  {
    _.assert( file.isActual );

    if( self.verbosity >= 3 )
    logger.log( ' +', 'starter use', file.absolute );

    let read = this.fileCodeRead( file.absolutePreferred );

    builtinMapCode += read;

    return file;
  }

  /* */

  // function onUpInliningToFilesMap( file )
  // {
  //   _.assert( file.isActual );
  //
  //   debugger;
  //   _.assert( 0 );
  //
  //   if( self.verbosity >= 3 )
  //   logger.log( ' +', 'starter use', file.absolute );
  //
  //   let filePath = `['` + file.absolute.split( '/' ).filter( ( e ) => e ? true : false ).join( `']['` ) + `']`;
  //   let line = `_starter_._requireStarting( _starter_.module, '${file.absolute}' );\n`;
  //
  //   requireCode += line;
  //
  //   let fileCode = `FilesMap${filePath}[ 0 ].code`;
  //   let line = `_starter_.modulesBuiltinMap[ '${file.absolute}' ] = { code : ${fileCode}, filePath : '${file.absolute}', dirPath : '${file.dir}', },\n`;
  //
  //   builtinMapCode += line;
  //
  //   return file;
  // }

}

//

function _verbosityChange()
{
  let self = this;

  let _verbosityForFileProvider = _.numberClamp( self.verbosity-2, 0, 9 );

  if( self.system )
  {
    let system = self.system;
    let srcFileProvider = system.providersWithProtocolMap.src;
    let dstFileProvider = system.providersWithProtocolMap.dst;
    system.verbosity = _verbosityForFileProvider;
    srcFileProvider.verbosity = _verbosityForFileProvider;
    dstFileProvider.verbosity = _verbosityForFileProvider;
  }

  if( self.logger )
  {
    // self.logger.verbosity = self._verbosityForLogger();
    self.logger.verbosity = self.verbosity;
    self.logger.outputGray = self.coloring ? 0 : 1;
  }

}

/**
 * @descriptionNeeded
 * @typedef {Object} Fields
 * @property {String} inPath
 * @property {String} outPath
 * @property {String} appName
 * @property {String} useFilePath
 * @property {String} includePath

 * @property {String} toolsPath='{{inPath}}/dwtools'
 * @property {String} initScriptPath='{{outPath}}/index.s'
 * @property {String} starterDirPath='{{outPath}}'
 * @property {String} starterScriptPath='{{starterDirPath}}/StarterInit.run.s'
 * @property {String} starterConfigPath='{{starterDirPath}}/{{appName}}.raw.starter.config.s'
 * @property {String} rootPath='/'
 * @property {String} prefixPath=''

 * @property {Boolean} offline=0
 * @property {Number} verbosity=2

 * @memberof module:Tools/mid/Starter.wStarterMaker
 */

// --
// relations
// --

let Composes =
{

  inPath : null,
  outPath : null,
  appName : null,
  useFilePath : null,
  includePath : null,

  toolsPath : '{{inPath}}/dwtools',
  initScriptPath : '{{outPath}}/index.s',
  starterDirPath : '{{outPath}}',
  starterScriptPath : '{{starterDirPath}}/StarterInit.run.s',
  starterConfigPath : '{{starterDirPath}}/{{appName}}.raw.starter.config.s',
  rootPath : '/',
  prefixPath : '',

  offline : 0,
  verbosity : 2,

}

let Aggregates =
{

  useFile : null,

}

let Associates =
{

  system : null,
  logger : null,

}

let Restricts =
{
  formed : 0,
  env : null,
}

let Medials =
{
}

let Statics =
{
  exec : exec,
  fixesFor : fixesFor,
}

let Events =
{
}

let Forbids =
{
  inliningScriptsToFilesMap : 'inliningScriptsToFilesMap',
  srcFileProvider : 'srcFileProvider',
  dstFileProvider : 'dstFileProvider',
}

// --
// declare
// --

let Proto =
{

  init,
  exec,
  form,

  fileProviderForm,
  fromHardDriveRead,
  toHardDriveWrite,

  fixesFor,
  filesMapMake,
  starterMake,

  _verbosityChange,

  // relations

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Medials,
  Statics,
  Events,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );
_.Verbal.mixin( Self );

//

_global_[ Self.name ] = wTools[ Self.shortName ] = Self;
if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

if( typeof module !== 'undefined' && !module.parent )
Self.exec();

})();
