( function _MainBase_s_( ) {

'use strict';

/**
 * Utility to manage modules of complex modular systems.
  @module Tools/Willbe
*/

/**
 * @file Main.bse.s
 */

/*

= Principles

- Willbe prepends all relative paths by path::in. path::out and path::temp are prepended by path::in as well.
- Willbe prepends path::in by module.dirPath, a directory which has the willfile.
- Major difference between generated out-willfiles and manually written willfile is section exported. out-willfiles has such section, manually written willfile does not.
- Output files are generated and input files are for manual editing, but the utility can help with it.

*/

/*

= Requested features

- Command .submodules.update should change back manually updated fixated submodules.
- Faster loading, perhaps without submodules
- Timelapse for transpilation
- Reflect submodules into dir with the same name as submodule

*/

//

if( typeof module !== 'undefined' )
{

  require( './IncludeBase.s' );

}

// --
// relations
// --

let _ = _global_.wTools;
let Parent = null;
let Self = function wWill( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Will';

//

let UpformingDefaults =
{
  all : null,
  attachedWillfilesFormed : null,
  peerModulesFormed : null,
  subModulesFormed : null,
  resourcesFormed : null,
}

let ModuleFilterNulls =
{
  withOut : null,
  withIn : null,
  withEnabledModules : null,
  withDisabledModules : null,
  withValid : null,
  withInvalid : null,
  withKnown : null,
  withUnknown : null,
}

let ModuleFilterDefaults =
{
  withOut : 1,
  withIn : 1,
  withEnabledModules : 1,
  withDisabledModules : 0,
  withValid : 1,
  withInvalid : 1,
  withKnown : 1,
  withUnknown : 0,
}

let ModuleFilterOff =
{
  withOut : 0,
  withIn : 0,
  withEnabledModules : 0,
  withDisabledModules : 0,
  withValid : 0,
  withInvalid : 0,
  withKnown : 0,
  withUnknown : 0,
}

let ModuleFilterOn =
{
  withOut : 1,
  withIn : 1,
  withEnabledModules : 1,
  withDisabledModules : 1,
  withValid : 1,
  withInvalid : 1,
  withKnown : 1,
  withUnknown : 1,
}

let RelationFilterNulls =
{
  ... ModuleFilterNulls,
  withEnabledSubmodules : null,
  withDisabledSubmodules : null,
  withOptionalSubmodules : null,
  withMandatorySubmodules : null,
}

let RelationFilterDefaults =
{
  ... ModuleFilterDefaults,
  withEnabledSubmodules : 1,
  withDisabledSubmodules : 0,
  withOptionalSubmodules : 1,
  withMandatorySubmodules : 1,
}

let RelationFilterOff =
{
  ... ModuleFilterOff,
  withEnabledSubmodules : 0,
  withDisabledSubmodules : 0,
  withOptionalSubmodules : 0,
  withMandatorySubmodules : 0,
}

let RelationFilterOn =
{
  ... ModuleFilterOn,
  withEnabledSubmodules : 1,
  withDisabledSubmodules : 1,
  withOptionalSubmodules : 1,
  withMandatorySubmodules : 1,
}

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let will = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  let logger = will.logger = new _.Logger({ output : _global_.logger, name : 'will' });

  will._.hooks = null;

  _.workpiece.initFields( will );
  Object.preventExtensions( will );

  _.assert( logger === will.logger );

  if( o )
  will.copy( o );

}

//

function unform()
{
  let will = this;

  _.assert( arguments.length === 0 );
  _.assert( !!will.formed );

  /* begin */

  /* end */

  will.formed = 0;
  return will;
}

//

function form()
{
  let will = this;

  if( will.formed >= 1 )
  return will;

  will.formAssociates();

  if( !will.environmentPath )
  will.environmentPath = will.environmentPathDetermine( will.fileProvider.path.current() );
  if( !will.withPath )
  will.withPath = will.fileProvider.path.join( will.fileProvider.path.current(), './' );

  _.assert( arguments.length === 0 );
  _.assert( !will.formed );
  _.assert( _.path.is( will.environmentPath ) );

  will.formed = 1;
  return will;
}

//

function formAssociates()
{
  let will = this;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !will.formed );
  _.assert( !!logger );
  _.assert( logger.verbosity === will.verbosity );

  if( !will.fileProvider )
  {

    let hub = _.FileProvider.System({ providers : [] });

    _.FileProvider.Git().providerRegisterTo( hub );
    _.FileProvider.Npm().providerRegisterTo( hub );
    _.FileProvider.Http().providerRegisterTo( hub );

    let defaultProvider = _.FileProvider.Default();
    let image = _.FileFilter.Image({ originalFileProvider : defaultProvider });
    let archive = new _.FilesGraphArchive({ imageFileProvider : image });
    image.providerRegisterTo( hub );
    hub.defaultProvider = image;

    will.fileProvider = hub;

  }

  // if( !will.filesGraph )
  // will.filesGraph = _.FilesGraphOld({ fileProvider : will.fileProvider });

  let logger2 = new _.Logger({ output : logger, name : 'will.providers' });

  will.fileProvider.logger = logger2;
  for( var f in will.fileProvider.providersWithProtocolMap )
  {
    let fileProvider = will.fileProvider.providersWithProtocolMap[ f ];
    fileProvider.logger = logger2;
  }

  _.assert( will.fileProvider.logger === logger2 );
  _.assert( logger.verbosity === will.verbosity );
  _.assert( will.fileProvider.logger !== will.logger );

  will._verbosityChange();

  _.assert( logger2.verbosity <= logger.verbosity );
}

// --
// path
// --

function WillPathGet()
{
  return _.path.join( __dirname, 'Exec' );
}

//

function PathIsOut( filePath )
{
  if( _.arrayIs( filePath ) )
  filePath = filePath[ 0 ];
  return _.strHas( filePath, /\.out(\.\w+)?(\.\w+)?$/ );
}

//

function DirPathFromFilePaths( filePaths )
{
  let module = this;

  filePaths = _.arrayAs( filePaths );

  _.assert( _.strsAreAll( filePaths ) );
  _.assert( arguments.length === 1 );

  filePaths = filePaths.map( ( filePath ) =>
  {
    filePath = _.path.normalize( filePath );

    let r1 = /(.*)(?:\.will(?:\.|$))[^\/]*$/;
    let parsed1 = r1.exec( filePath );
    if( parsed1 )
    filePath = parsed1[ 1 ];

    let r2 = /(.*)(?:\.(?:im|ex)(?:\.|$))[^\/]*$/;
    let parsed2 = r2.exec( filePath );
    if( parsed2 )
    filePath = parsed2[ 1 ];

    return filePath;
  });

  let filePath = _.strCommonLeft.apply( _, _.arrayAs( filePaths ) );
  _.assert( filePath.length > 0 );
  return filePath;
}

//

function PrefixPathForRole( role, isOut )
{
  let cls = this;
  let result = cls.PrefixPathForRoleMaybe( role, isOut );

  _.assert( arguments.length === 2 );
  _.sure( _.strIs( result ), 'Unknown role', _.strQuote( role ) );

  return result;
}

//

function PrefixPathForRoleMaybe( role, isOut )
{
  let cls = this;
  let result = '';

  _.assert( arguments.length === 2 );

  if( role === 'import' )
  result += '.im';
  else if( role === 'export' )
  result += '.ex';
  else if( role === 'single' )
  result += '';
  else return null;

  result += isOut ? '.out' : '';
  result += '.will';

  return result;
}

//

function PathToRole( filePath )
{
  let role = null;

  if( _.arrayLike( filePath ) )
  return _.map( filePath, ( filePath ) => this.PathToRole( filePath ) );

  let isImport = _.strHas( filePath, /(^|\.|\/)im\.will(\.|$)/ );
  let isExport = _.strHas( filePath, /(^|\.|\/)ex\.will(\.|$)/ );

  if( isImport )
  role = 'import';
  else if( isExport )
  role = 'export';
  else
  role = 'single';

  return role;
}

//

function CommonPathFor( willfilesPath )
{

  if( _.arrayIs( willfilesPath ) )
  {
    if( !willfilesPath.length )
    return null;
    willfilesPath = willfilesPath[ 0 ];
  }

  _.assert( arguments.length === 1 );

  if( willfilesPath === null )
  return null;

  _.assert( _.strIs( willfilesPath ) );

  let common = willfilesPath;
  // let common2 = common.replace( /((\.|\/|^)(im|ex))?((\.|\/|^)will)(\.out)?(\.\w+)?$/, '' );
  // let common2 = common.replace( /((\.|\/|^)(im|ex))?(\.out)?((\.|\/|^)will)(\.\w+)?$/, '' );
  let common2 = common.replace( /((\.|\/|^)(im|ex))?((\.|\/|^)will)(\.\w+)?$/, '' );
  let removed = _.strRemoveBegin( common, common2 );
  if( removed[ 0 ] === '/' )
  common2 = common2 + '/';
  common = common2;

  return common;
}

//

function CommonPathNormalize( commonPath )
{
  let commonPath2 = commonPath;
  commonPath2 = commonPath.replace( /((\.|\/|^)(im|ex))?((\.|\/|^)will)(\.\w+)?$/, '' );
  if( commonPath !== commonPath2 )
  debugger;
  return commonPath2;
}

//

function CloneDirPathFor( inPath )
{
  _.assert( arguments.length === 1 );
  _.assert( _.path.isAbsolute( inPath ) );

  let splits = _.path.split( inPath );
  let insideClone = _.arrayHas( splits, '.module' );

  if( insideClone )
  return inPath;

  return _.path.join( inPath, '.module' );
}

//

function OutfilePathFor( outPath, name )
{
  _.assert( arguments.length === 2 );
  _.assert( _.path.isAbsolute( outPath ), 'Expects absolute path outPath' );
  _.assert( _.strDefined( name ), 'Module should have name, declare about::name' );
  name = _.strJoinPath( [ name, '.out.will.yml' ], '.' );
  return _.path.join( outPath, name );
}

//

function RemotePathAdjust( remotePath, relativePath )
{
  let remotePathParsed = _.uri.parseConsecutive( remotePath );

  if( !remotePathParsed.query )
  {
    return _.uri.join( remotePath, relativePath );
  }

  remotePathParsed.query = _.strWebQueryParse( remotePathParsed.query );

  if( !remotePathParsed.query.out )
  {
    debugger;
    return _.uri.join( remotePath, relativePath );
  }

  remotePathParsed.query.out = _.path.join( remotePathParsed.query.out, relativePath );

  return _.uri.str( remotePathParsed );
}

//

function HooksPathGet( environmentPath )
{
  return _.path.join( environmentPath, '.will/hook' );
}

//

function IsModuleAt( filePath )
{
  let cls = this;
  return cls.WillfilesFind( filePath ).length > 0;
}

//

function hooksPathGet()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return will.HooksPathGet( will.environmentPath );
}

//

function environmentPathSet( src )
{
  let will = this;

  _.assert( src === null || _.strDefined( src ) );

  if( !src )
  {
    will._.environmentPath = src;
    return src;
  }

  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  src = path.canonize( src );

  _.assert( !path.isTrailed( src ) );
  _.assert( path.isAbsolute( src ) );

  will._.environmentPath = src;
  return src;
}

//

function environmentPathDetermine( dirPath )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  dirPath = path.canonize( dirPath );

  if( check( dirPath ) )
  return dirPath;

  let paths = path.traceToRoot( dirPath );
  for( var i = paths.length - 1; i >= 0; i-- )
  if( check( paths[ i ] ) )
  return paths[ i ];

  return dirPath;

  function check( dirPath )
  {
    if( !fileProvider.isDir( path.join( dirPath, '.will' ) ) )
    return false
    return true;
  }
}

// --
// etc
// --

function _verbosityChange()
{
  let will = this;

  _.assert( arguments.length === 0 );
  _.assert( !will.fileProvider || will.fileProvider.logger !== will.logger );

  if( will.fileProvider )
  will.fileProvider.verbosity = will.verbosity-2;

}

//

function vcsProviderFor( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !_.mapIs( o ) )
  o = { filePath : o }

  _.assert( arguments.length === 1 );
  _.routineOptions( vcsProviderFor, o );
  _.assert( !!will.formed );

  if( _.arrayIs( o.filePath ) && o.filePath.length === 0 )
  return null;

  if( !o.filePath )
  return null;

  let result = fileProvider.providerForPath( o.filePath );

  if( !result )
  return null

  if( !result.isVcs )
  return null

  return result;
}

vcsProviderFor.defaults =
{
  filePath : null,
}

//

function vcsToolsFor( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !_.mapIs( o ) )
  o = { filePath : o }

  _.assert( arguments.length === 1 );
  _.routineOptions( vcsToolsFor, o );
  _.assert( !!will.formed );

  if( _.arrayIs( o.filePath ) && o.filePath.length === 0 )
  return null;

  if( !o.filePath )
  return null;

  _.assert( _.strIs( o.filePath ) );
  _.assert( path.isGlobal( o.filePath ) );

  let parsed = path.parse( o.filePath );

  if( _.arrayHasAny( parsed.protocols, _.git.protocols ) )
  return _.git;
  if( _.arrayHasAny( parsed.protocols, _.npm.protocols ) )
  return _.npm;

  return null;
}

vcsToolsFor.defaults =
{
  filePath : null,
}

//

function repoFrom( o )
{
  let will = this;

  _.assert( _.mapIs( o ) );
  _.assert( arguments.length === 1 );

  o.will = will;

  let hash = _.Will.Repository.Hash({ downloadPath : o.downloadPath, remotePath : o.remotePath });
  let repo = will.repoMap[ hash ];
  if( repo )
  return repo;

  repo = will.repoMap[ hash ] = new _.Will.Repository( o );

  return repo;
}

//

function resourceWrap( o )
{
  let will = this;

  if( o && !_.mapIs( o ) )
  if( o instanceof _.Will.OpenedModule )
  o = { module : o }
  else if( o instanceof _.Will.ModuleOpener )
  o = { opener : o }
  else if( o instanceof _.Will.ModuleVariant )
  o = { variant : o }

  return o;
}

//

function resourcesInfoExport( o )
{
  let will = this;
  let result = Object.create( null );

  o = _.routineOptions( resourcesInfoExport, arguments );

  let names =
  {
    openersArray : 'openers',
    modulesArray : 'modules',
    willfilesArray : 'willfiles',
  }

  for( let n in names )
  {
    if( n === 'willfilesArray' )
    result[ names[ n ] ] = _.filter( will[ n ], ( willf ) => willf.filePath + ' # ' + willf.id );
    else
    result[ names[ n ] ] = _.filter( will[ n ], ( e ) => e.commonPath + ' # ' + e.id );
  }

  result.openersErrors = _.filter( will.openersErrorsArray, ( r ) => r.err.originalMessage || r.err.message );

  if( o.stringing )
  result = _.toStrNice( result );

  return result;
}

resourcesInfoExport.defaults =
{
  stringing : 1,
}

//

function variantsWithId( id )
{
  let will = this;

  for( let v in will.variantMap )
  {
    let variant = will.variantMap[ v ];
    if( variant.id === id )
    return variant;
  }

  return null;
}

//

function variantsInfoExport( variants )
{
  let will = this;
  if( !variants )
  {
    variants = _.longOnce( _.mapVals( will.variantMap ) );
    // variants = variants.filter( ( variant ) =>
    // {
    //   if( variant.relation && !variant.relation.enabled )
    //   return false;
    //   if( variant.isRemote === false )
    //   return false;
    //   return variant;
    // });
  }

  return _.map( variants, ( variant ) => variant.infoExport() ).join( '\n' );
}

//

function _pathChanged( o )
{
  let will = this;
  let logger = will.logger;

  if( !Config.debug )
  return;

  o.ex = _.path.simplify( o.ex );
  o.val = _.path.simplify( o.val );
  if( o.isIdential === null )
  o.isIdentical = o.ex === o.val || _.entityIdentical( o.val, o.ex );

  // if( o.val )
  // if( o.fieldName === 'remotePath' || o.fieldName === 'remote' )
  // if( o.object.id === 1086 )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.fieldName, _.toStrNice( o.val ) );
  //   debugger;
  // }

  // if( o.val )
  // if( o.fieldName === 'outPath' || o.fieldName === 'out' )
  // if( o.object.id === 209 || o.object.id === 84 )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.fieldName, _.toStrNice( o.val ) );
  //   debugger;
  // }

  // if( o.val )
  // if( o.fieldName === 'download' )
  // // if( o.object.isOut && !o.object.isRemote )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.fieldName, _.toStrNice( o.val ) );
  //   debugger;
  // }

  // if( o.fieldName === 'module.original.willfiles' )
  // if( o.object.isOut )
  // if( o.val )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.fieldName, _.toStrNice( o.val ) );
  //   debugger;
  // }

  // if( o.fieldName === 'willfilesPath' || o.fieldName === 'module.willfiles' )
  // if( _.strIs( o.val ) && _.strHas( o.val, 'wTools.out' ) )
  // {
  //   logger.log( o.object.absoluteName, '#' + o.object.id, o.kind, o.fieldName, _.toStrNice( o.val ) );
  //   // debugger;
  // }

  // if( o.fieldName === 'willfilesPath' || o.fieldName === 'module.willfiles' )
  // {
  //   logger.log( o.object.absoluteName, o.kind, o.fieldName, _.toStrNice( o.val ) );
  //   debugger;
  // }

  // if( _.strIs( o.ex ) && _.strEnds( o.ex, '/wTools.out.will' ) )
  // debugger;
  // if( _.strIs( o.val ) && _.strEnds( o.val, '/wTools.out.will' ) )
  // debugger;

  // if( !o.isIdential )
  // logger.log( o.object.absoluteName, o.kind, o.fieldName, _.toStrNice( o.val ) );

}

_pathChanged.defaults =
{
  val : null,
  ex : null,
  isIdentical : null,
  object : null,
  fieldName : null,
  kind : null,
}

//

function versionGet()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 0 );

  let packageJsonPath = path.join( __dirname, '../../../../package.json' );
  let packageJson =  fileProvider.fileRead({ filePath : packageJsonPath, encoding : 'json' });
  return packageJson.version
}

//

function versionIsUpToDate( o )
{
  let will = this;

  _.assert( arguments.length === 1 );

  _.routineOptions( versionIsUpToDate, o );


  let ready = _.process.start
  ({
    execPath : 'npm view willbe version',
    inputMirroring : 0,
    outputPiping : 0,
    outputCollecting : 1,
  });

  ready.finally( ( err, result ) =>
  {
    if( err )
    throw _.err( err, '\nFailed to check version of utility willbe' );

    let currentVersion = parse( will.versionGet() );
    let latestVersion = parse( _.strStrip( result.output ) );

    let upToDate = true;
    for( let i = 0; i < currentVersion.length; i++ )
    if( currentVersion[ i ] < latestVersion[ i ] )
    {
      upToDate = false;
      break;
    }

    if( !upToDate )
    {
      let message =
      [
        '╔════════════════════════════════════════════════════════════╗',
        '║ Utility willbe is out of date!                             ║',
        `║ Current version: ${currentVersion}`,
        `║ Latest: ${latestVersion}`,
        '║ Please run: "npm r -g willbe && npm i -g willbe" to update.║',
        '╚════════════════════════════════════════════════════════════╝'
      ]

      message[ 2 ] = message[ 2 ] + _.strDup( ' ', message[ 4 ].length - message[ 2 ].length - 1 ) + '║';
      message[ 3 ] = message[ 3 ] + _.strDup( ' ', message[ 4 ].length - message[ 3 ].length - 1 ) + '║';

      message = message.join( '\n' )

      let coloredMessage = _.color.strBg( message, 'yellow' );

      if( !o.throwing )
      {
        logger.log( coloredMessage );
        return false;
      }

      // if( o.brief )
      throw _.errBrief( coloredMessage );
      // else
      // throw _.err( message );
    }
    else
    {
      logger.log( `Current version: ${currentVersion}. Utility willbe is up to date.` );
    }

    return true;
  })

  return ready;

  function parse( src )
  {
    let parts = _.strSplitNonPreserving({ src, delimeter : '.' });
    return parts.map( ( p ) => parseInt( p ) );
  }
}

versionIsUpToDate.defaults =
{
  throwing : 1,
  // brief : 1
}

// --
// defaults
// --

function filterDefaults( o )
{
  let will = this.form();

  if( o.withEnabledSubmodules === null && will.withEnabled !== undefined && will.withEnabled !== null )
  o.withEnabledSubmodules = will.withEnabled;
  if( o.withDisabledSubmodules === null && will.withDisabled !== undefined && will.withDisabled !== null )
  o.withDisabledSubmodules = will.withDisabled;

  if( o.withEnabledModules === null && will.withEnabled !== undefined && will.withEnabled !== null )
  o.withEnabledModules = will.withEnabled;
  if( o.withDisabledModules === null && will.withDisabled !== undefined && will.withDisabled !== null )
  o.withDisabledModules = will.withDisabled;

  for( let n in _.Will.RelationFilterDefaults )
  {
    if( o[ n ] === null && will[ n ] !== undefined && will[ n ] !== null )
    o[ n ] = will[ n ];
  }

  return o;
}

//

function instanceDefaultsApply( o )
{
  let will = this;

  _.assert( arguments.length === 1 );

  for( let d in will.OpeningDefaults )
  {
    if( o[ d ] === null )
    o[ d ] = will[ d ];
  }

  return o;
}

//

function instanceDefaultsSupplement( o )
{
  let will = this;

  _.assert( arguments.length === 1 );

  for( let d in will.OpeningDefaults )
  {
    if( o[ d ] !== null && o[ d ] !== undefined )
    if( will[ d ] === null )
    will[ d ] = o[ d ];
  }

  return will;
}

//

function instanceDefaultsExtend( o )
{
  let will = this;

  _.assert( arguments.length === 1 );

  for( let d in will.OpeningDefaults )
  {
    if( o[ d ] !== null && o[ d ] !== undefined )
    will[ d ] = o[ d ];
  }

  return will;
}

//

function instanceDefaultsReset()
{
  let will = this;
  let FieldsOfTightGroups = will.FieldsOfTightGroups;

  _.assert( arguments.length === 0 );

  for( let d in will.OpeningDefaults )
  {
    _.assert( FieldsOfTightGroups[ d ] !== undefined );
    _.assert( _.primitiveIs( FieldsOfTightGroups[ d ] ) );
    will[ d ] = FieldsOfTightGroups[ d ];
  }

  return will;
}

//

function prefer( o )
{
  let will = this;
  let ready = new _.Consequence();

  o = _.routineOptions( prefer, arguments );

  forward();
  will.instanceDefaultsApply( o );
  forward();
  will.instanceDefaultsExtend( o );

  return will;

  function forward()
  {

    if( _.boolLike( o.allOfMain ) )
    {
      o.allOfMain = !!o.allOfMain;
      if( o.attachedWillfilesFormedOfMain === null )
      o.attachedWillfilesFormedOfMain = o.allOfMain;
      if( o.peerModulesFormedOfMain === null )
      o.peerModulesFormedOfMain = o.allOfMain;
      if( o.subModulesFormedOfMain === null )
      o.subModulesFormedOfMain = o.allOfMain;
      if( o.resourcesFormedOfMain === null )
      o.resourcesFormedOfMain = o.allOfMain;
    }

    if( _.boolLike( o.allOfSub ) )
    {
      o.allOfSub = !!o.allOfSub;
      if( o.attachedWillfilesFormedOfSub === null )
      o.attachedWillfilesFormedOfSub = o.allOfSub;
      if( o.peerModulesFormedOfSub === null )
      o.peerModulesFormedOfSub = o.allOfSub;
      if( o.subModulesFormedOfSub === null )
      o.subModulesFormedOfSub = o.allOfSub;
      if( o.resourcesFormedOfSub === null )
      o.resourcesFormedOfSub = o.allOfSub;
    }

  }

}

prefer.defaults =
{

  attachedWillfilesFormedOfMain : null,
  peerModulesFormedOfMain : null,
  subModulesFormedOfMain : null,
  resourcesFormedOfMain : null,
  allOfMain : null,

  attachedWillfilesFormedOfSub : null,
  peerModulesFormedOfSub : null,
  subModulesFormedOfSub : null,
  resourcesFormedOfSub : null,
  allOfSub : null,

  verbosity : null,
  // recursiveExport : null,

}

// --
// module
// --

function moduleAt( willfilesPath )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );

  let commonPath = _.Will.CommonPathFor( willfilesPath );

  return will.moduleWithCommonPathMap[ commonPath ];
}

//

function moduleFit_pre( routine, args )
{
  let module = this;

  let variant = args[ 0 ];
  let opts = args[ 1 ];
  opts = _.routineOptions( routine, opts );
  _.assert( args.length === 2 );

  return _.unrollFrom([ variant, opts ]);
}

function moduleFit_body( variant, opts )
{
  let will = this;
  let logger = will.logger;

  _.assert( arguments.length === 2 );
  _.assert( variant instanceof _.Will.ModuleVariant )

  if( !opts.withKnown && variant.object )
  return false;

  if( !opts.withUnknown && !variant.object )
  return false;

  if( !opts.withValid && variant.object )
  if( variant.object.isValid() )
  {
    debugger;
    return false;
  }

  if( !opts.withInvalid && variant.object )
  if( !variant.object.isValid() )
  {
    debugger;
    return false;
  }

  if( !opts.withOut && variant.isOut !== null )
  if( variant.isOut )
  return false;

  if( !opts.withIn && variant.isOut !== null )
  if( !variant.isOut )
  return false;

  if( !opts.withEnabledModules && variant.module )
  if( variant.module.about.enabled )
  return false;

  if( !opts.withDisabledModules && variant.module )
  if( !variant.module.about.enabled )
  return false;

  // if( !opts.withOptionalSubmodules )
  // if( !variant.relation || variant.relation.isOptional() )
  // return false;
  //
  // if( !opts.withMandatorySubmodules && variant.relation )
  // if( !variant.relation.isOptional() )
  // return false;

  return true;
}

var defaults = moduleFit_body.defaults = _.mapExtend( null, ModuleFilterDefaults );

defaults.withStem = 0;
defaults.withPeers = 0;

// defaults.withOptionalSubmodules = 1;
// defaults.withMandatorySubmodules = 1;
//
// defaults.withOut = 1;
// defaults.withIn = 1;
// defaults.withEnabled = 1;
// defaults.withDisabled = 0;
// defaults.withValid = 1;
// defaults.withInvalid = 1;

let moduleFit = _.routineFromPreAndBody( moduleFit_pre, moduleFit_body );

//

function relationFit_body( variant, opts )
{
  let will = this;
  let logger = will.logger;

  _.assert( arguments.length === 2 );
  _.assert( variant instanceof _.Will.ModuleVariant )

  let result = will.moduleFit.body.call( will, variant, _.mapOnly( opts, will.moduleFit.defaults ) );
  if( !result )
  return result;

  if( !opts.withOptionalSubmodules )
  if( !variant.relation || variant.relation.isOptional() )
  return false;

  if( !opts.withMandatorySubmodules && variant.relation )
  if( !variant.relation.isOptional() )
  return false;

  if( !opts.withEnabledSubmodules && variant.relation )
  if( variant.relation.enabled )
  return false;

  if( !opts.withDisabledSubmodules && variant.relation )
  if( !variant.relation.enabled )
  return false;

  return true;
}

var defaults = relationFit_body.defaults =
{

  ... moduleFit.defaults,
  ... RelationFilterDefaults,

}

// var defaults = relationFit_body.defaults = _.mapExtend( null, moduleFit.defaults );
//
// defaults.withOptionalSubmodules = 1;
// defaults.withMandatorySubmodules = 1;
// defaults.withEnabledSubmodules = 1;
// defaults.withDisabledSubmodules = 1;

let relationFit = _.routineFromPreAndBody( moduleFit_pre, relationFit_body );

//

function modulesFilter( variants, o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [];

  _.assert( arguments.length === 2 );
  _.assert( _.arrayIs( variants ) );
  o = _.routineOptions( modulesFilter, o );

  variants.forEach( ( module ) =>
  {
    let variant = module;
    if( !( variant instanceof _.Will.ModuleVariant ) )
    variant = will.variantFrom( module );
    if( will.moduleFit.body.call( will, variant, o ) )
    result.push( module );
  });

  return result;
}

modulesFilter.defaults = _.mapExtend( null, moduleFit.defaults );
// modulesFilter.defaults.withDisabledStem = 0;

//

function relationsFilter( variants, o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [];

  _.assert( arguments.length === 2 );
  _.assert( _.arrayIs( variants ) );
  o = _.routineOptions( relationsFilter, o );

  variants.forEach( ( module ) =>
  {
    let variant = module;
    if( !( variant instanceof _.Will.ModuleVariant ) )
    variant = will.variantFrom( module );
    if( will.relationFit.body.call( will, variant, o ) )
    result.push( module );
  });

  return result;
}

relationsFilter.defaults = _.mapExtend( null, relationFit.defaults );
// relationsFilter.defaults.withDisabledStem = 0;

//

function moduleIdUnregister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( openedModule instanceof will.OpenedModule );
  _.assert( openedModule.id > 0 );

  _.assert( will.moduleWithIdMap[ openedModule.id ] === openedModule || will.moduleWithIdMap[ openedModule.id ] === undefined );
  delete will.moduleWithIdMap[ openedModule.id ];
  _.assert( _.arrayCountElement( _.mapVals( will.moduleWithIdMap ), openedModule ) === 0 );
  _.arrayRemoveOnceStrictly( will.modulesArray, openedModule );

}

//

function moduleIdRegister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( openedModule instanceof will.OpenedModule );
  _.assert( arguments.length === 1 );
  _.assert( openedModule.id > 0 );

  _.assert( will.moduleWithIdMap[ openedModule.id ] === openedModule || will.moduleWithIdMap[ openedModule.id ] === undefined );
  will.moduleWithIdMap[ openedModule.id ] = openedModule;
  _.assert( _.arrayCountElement( _.mapVals( will.moduleWithIdMap ), openedModule ) === 1 );
  _.arrayAppendOnceStrictly( will.modulesArray, openedModule );

}

//

function modulePathUnregister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( openedModule instanceof will.OpenedModule );
  _.assert( openedModule._registeredPath === null || openedModule._registeredPath === openedModule.commonPath );

  if( !openedModule._registeredPath )
  return;

  if( openedModule.commonPath )
  {
    let registered = will.moduleWithCommonPathMap[ openedModule._registeredPath ];
    _.assert( _.strIs( openedModule._registeredPath ) );
    // _.assert( registered === openedModule || !openedModule.isPreformed() );
    _.assert( registered === openedModule || registered === undefined );
    delete will.moduleWithCommonPathMap[ openedModule._registeredPath ];
    openedModule._registeredPath = null;
  }

  _.assert( _.arrayCountElement( _.mapVals( will.moduleWithCommonPathMap ), openedModule ) === 0 );

}

//

function modulePathRegister( openedModule )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  openedModule._registeredPath = openedModule.commonPath;

  _.assert( openedModule instanceof will.OpenedModule );
  _.assert( arguments.length === 1 );
  _.assert( _.strIs( openedModule.commonPath ) );

  _.assert
  (
    will.moduleWithCommonPathMap[ openedModule.commonPath ] === openedModule || will.moduleWithCommonPathMap[ openedModule.commonPath ] === undefined,
    () => 'Different instance of ' + openedModule.constructor.name + ' is registered at ' + openedModule.commonPath
  );
  will.moduleWithCommonPathMap[ openedModule.commonPath ] = openedModule;
  _.assert( _.arrayCountElement( _.mapVals( will.moduleWithCommonPathMap ), openedModule ) === 1 );

}

//

function moduleNew( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;

  o = _.routineOptions( moduleNew, arguments );

  if( o.localPath )
  o.localPath = path.join( path.current(), o.localPath );
  else
  o.localPath = path.join( path.current(), './' );

  if( !o.name )
  o.name = path.name( o.localPath );

  _.assert( _.strDefined( o.name ) );
  _.assert( _.arrayHas( [ 'throw', 'ignore' ], o.collision ) );

  let code =
`
about :

  name : ${o.name}

build :

  export :
    criterion :
      default : 1
      export : 1
    steps :
      step::module.export
`

  if( fileCheck( '.im.will.yml' ) )
  return o.localPath;
  if( fileCheck( '.ex.will.yml' ) )
  return o.localPath;
  if( fileCheck( '.will.yml' ) )
  return o.localPath;
  if( path.isTrailed( o.localPath ) )
  {
    if( fileCheck( 'im.will.yml' ) )
    return o.localPath;
    if( fileCheck( 'ex.will.yml' ) )
    return o.localPath;
    if( fileCheck( 'will.yml' ) )
    return o.localPath;
  }

  let filePath = path.isTrailed( o.localPath ) ? o.localPath + 'will.yml' : o.localPath + '.will.yml';

  _.assert( !fileProvider.fileExists( filePath ) );
  fileProvider.fileWrite( filePath, code );

  if( o.verbosity )
  logger.log( `Create module::${o.name} at ${o.localPath}` );

  return o.localPath;

  function fileCheck( postfix )
  {
    let filePath = o.localPath + postfix;
    if( fileProvider.fileExists( filePath ) )
    {
      if( o.collision === 'throw' )
      throw _.errBrief( `Cant make a new module::${o.name} at ${o.localPath}\nWillfile at ${filePath} already exists!` );
      else if( o.collision === 'ignore' )
      return o.localPath;
    }
  }

}

moduleNew.defaults =
{
  localPath : null,
  name : null,
  verbosity : 0,
  collision : 'throw', /* 'throw', 'ignore' */
}

//

function modulesFindEachAt( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let con;
  let errs = [];

  _.sure( _.strDefined( o.selector ), 'Expects string' );
  _.assert( arguments.length === 1 );

  will.readingBegin();

  if( _.strEnds( o.selector, '::' ) )
  o.selector = o.selector + '*';

  /* */

  if( will.Resolver.selectorIs( o.selector ) )
  {

    let opener = o.currentOpener;
    if( !opener )
    opener = will._openerMake
    ({
      opener :
      {
        willfilesPath : path.trail( path.current() ),
        searching : 'strict',
        reason : 'each',
      }
    });
    opener.find();

    con = opener.openedModule.ready.split();
    con.then( () =>
    {
      let con2 = new _.Consequence();
      // debugger;
      // _global_.debugger = 1;
      let resolved = opener.openedModule.submodulesResolve
      ({
        selector : o.selector,
        preservingIteration : 1,
        pathUnwrapping : 1,
      });
      // debugger;

      if( !_.mapIs( resolved ) )
      resolved = _.arrayAs( resolved );

      _.each( resolved, ( it1 ) => con2.then( ( arg ) =>
      {
        let it2 = Object.create( null );
        // it2.currentOpener = opener._openerMake(); // zzz
        // it2.dst = element;

        it2.currentModule = it1.currentModule;
        _.assert( it2.currentModule instanceof _.Will.OpenedModule );
        it2.currentOpener = it2.currentModule.userArray[ 0 ];
        _.assert( it2.currentOpener instanceof _.Will.ModuleOpener );

        debugger;
        if( _.arrayIs( it1.dst ) || _.strIs( it1.dst ) )
        it2.currentOpenerPath = it1.dst;
        it2.options = o;

        if( o.onBegin )
        o.onBegin( it2 )
        if( o.onEnd )
        return o.onEnd( it2 );

        return null;
      }));
      con2.take( null );
      return con2;
    });

    opener.open();

  }
  else
  {

    con = new _.Consequence().take( null );

    if( !path.isGlob( o.selector ) )
    {
      if( _.strEnds( o.selector, '/.' ) )
      o.selector = _.strRemoveEnd( o.selector, '/.' ) + '/*';
      else if( o.selector === '.' )
      o.selector = '*';
      else if( _.strEnds( o.selector, '/' ) )
      o.selector += '*';
      else
      o.selector += '/*';
    }

    let files;
    try
    {
      files = will.willfilesFind
      ({
        commonPath : o.selector,
        withIn : 1,
        withOut : 1,
        excludingUnderscore : 1,
      });
    }
    catch( err )
    {
      throw _.err( err );
    }

    let filesMap = Object.create( null );
    for( let f = 0 ; f < files.length ; f++ ) con
    .then( ( arg ) => /* !!! replace by concurrent, maybe */
    {
      let file = files[ f ];

      if( filesMap[ file.absolute ] )
      {
        return true;
      }

      let selectedFiles = will.willfilesSelectPaired( file, files );
      let willfilesPath = selectedFiles.map( ( file ) =>
      {
        filesMap[ file.absolute ] = true;
        return file.absolute;
      });

      if( willfilesPath.length === 1 )
      willfilesPath = willfilesPath[ 0 ];

      let opener = will._openerMake
      ({
        opener :
        {
          willfilesPath : willfilesPath,
          searching : 'exact',
          reason : 'each',
        }
      });

      opener.find();

      let it = Object.create( null );
      it.currentOpener = opener;
      it.options = o;

      opener.openedModule.stager.stageConsequence( 'preformed' ).then( ( arg ) =>
      {
        if( o.onBegin )
        return o.onBegin( it );
        return arg;
      });

      opener.open();

      return opener.openedModule.ready.split().then( function( arg )
      {
        _.assert( opener.willfilesArray.length > 0 );
        if( opener.willfilesPath )
        _.mapSet( filesMap, opener.willfilesPath, true );

        let r = null;
        if( o.onEnd )
        r = o.onEnd( it );

        return r;
      })

    })
    .finally( ( err, arg ) =>
    {
      if( err )
      {
        debugger;
        if( o.onError )
        o.onError( err );
        errs.push( _.err( err ) );
        return null;
      }
      return arg;
    });

  }

  /* */

  con.finally( ( err, arg ) =>
  {
    // debugger;
    if( errs.length )
    {
      errs.forEach( ( err, index ) => index > 0 ? _.errAttend( err ) : null );
    }
    if( err )
    {
      throw _.err( err );
    }
    if( errs.length )
    {
      throw errs[ 0 ];
    }
    return o;
  });

  /* */

  return con;
}

modulesFindEachAt.defaults =
{
  currentOpener : null,
  selector : null,
  onBegin : null,
  onEnd : null,
}

//

function modulesFindWithAt( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let con;

  o = _.routineOptions( modulesFindWithAt, arguments );
  _.sure( _.strDefined( o.selector ), 'Expects string' );
  _.assert( arguments.length === 1 );

  will.filterDefaults( o );

  /* */

  will.readingBegin();
  con = new _.Consequence().take( null );

  let op = Object.create( null );
  op.options = o;
  op.errs = [];
  op.openers = [];

  let visitedFilesSet = new Set();
  let files;
  try
  {
    files = will.willfilesFind
    ({
      commonPath : o.selector,
      tracing : o.tracing,
      withIn : o.withIn,
      withOut : o.withOut,
      excludingUnderscore : 1,
    });
  }
  catch( err )
  {
    throw _.err( err );
  }

  /* !!! replace by concurrent, maybe */
  files.forEach( ( file ) =>
  {
    let it = Object.create( null );
    it.file = file;
    it.opener = null;
    con
    .then( ( arg ) => moduleOpen( it ) )
    .finally( ( err, arg ) => moduleEnd( it, err, arg ) )
  });

  con.finally( ( err, arg ) => end( err, arg ) );

  return con;

  /* */

  function moduleOpen( it )
  {
    if( visitedFilesSet.has( it.file ) )
    return null;

    let selectedFiles = will.willfilesSelectPaired( it.file, files );
    let willfilesPath = selectedFiles.map( ( file ) =>
    {
      visitedFilesSet.add( file );
      return file.absolute;
    });

    it.opener = will._openerMake
    ({
      opener :
      {
        willfilesPath : willfilesPath,
        searching : 'exact',
        reason : 'with',
      }
    });

    it.opener.find();
    it.opener.open();

    return it.opener.openedModule.ready.split()
    .then( function( arg )
    {
      _.assert( it.opener.willfilesArray.length > 0 );
      let l = op.openers.length;
      _.arrayAppendOnce( op.openers, it.opener, ( e ) => e.openedModule );
      _.assert( l < op.openers.length );
      _.assert( !_.arrayHas( op.openers, null ) )
      return arg;
    })
  }

  /* */

  function moduleEnd( it, err, arg )
  {
    if( err )
    {
      err = _.err( err );
      op.errs.push( err );
      if( o.withInvalid && it.opener && it.opener.openedModule )
      {
        _.arrayAppendOnce( op.openers, it.opener );
      }
      else if( it.opener )
      {
        it.opener.finit();
      }
      logger.log( _.errOnce( err ) );
      return null;
    }
    return arg;
  }

  /* */

  function end( err, arg )
  {
    if( !op.openers.length )
    if( !err )
    err = op.errs[ 0 ];

    if( err )
    {
      debugger;
      _.arrayAppendOnce( op.errs, err );
      throw err;
    }

    {
      let filter = _.mapOnly( o, will.modulesFilter.defaults );
      let openers2 = will.modulesFilter( op.openers, filter );
      if( !o.atLeastOne || openers2.length )
      op.openers = openers2;
    }

    op.variants = will.variantsFrom( op.openers );
    op.sortedVariants = will.graphTopSort( op.variants );
    op.sortedVariants.reverse();
    op.sortedOpeners = [];
    op.sortedVariants = _.filter( op.sortedVariants, ( variant ) =>
    {
      let opener = _.arraySetIntersection( op.openers.slice(), variant.openers )[ 0 ];
      if( !opener )
      return;
      _.assert( !opener.superRelation );
      op.sortedOpeners.push( opener );
      return variant;
    });
    return op;
  }

  /* */

}

var defaults = modulesFindWithAt.defaults = _.mapExtend( null, ModuleFilterNulls );

defaults.selector = null;
defaults.tracing = null;
defaults.atLeastOne = 1;

//

function modulesOnlyRoots( modules )
{
  let will = this;
  let visitedContainer = _.containerAdapter.from( new Set );
  let variantMap = will.variantMap;

  if( modules === null || modules === undefined )
  modules = will.modulesArray;

  _.assert( _.longIs( modules ) );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  let filter =
  {
    withPeers : 1,
    withStem : 1,
    ... _.Will.RelationFilterOn,
  }

  let nodesGroup = will.graphGroupMake( _.mapOnly( filter, will.graphGroupMake.defaults ) );

  /* first make variants for each module */

  let o2 =
  {
    ... filter,
    modules : modules,
    revisiting : 0,
    recursive : 2,
    outputFormat : '/',
    nodesGroup : nodesGroup,
  }
  let variants = will.modulesEach( o2 );

  /* then add in-roots of trees */

  let sources = nodesGroup.sourcesFromNodes( variants );
  sources = sources.filter( ( variant ) =>
  {
    if( !variant.object )
    return false;
    if( !variant.isOut )
    return true;
    if( variant.peer && _.arrayHas( sources, variant.peer ) )
    return false;
    return true;
  });

  return sources;
}

modulesOnlyRoots.defaults =
{
}

//

function modulesEach_pre( routine, args )
{
  let will = this;

  let o = args[ 0 ]
  if( _.routineIs( args[ 0 ] ) )
  o = { onUp : args[ 0 ] };
  o = _.routineOptions( routine, o );
  _.assert( args.length === 0 || args.length === 1 );
  _.assert( _.arrayHas( [ '/', '*/module', '*/relation' ], o.outputFormat ) )

  return o;
}

function modulesEach_body( o )
{
  let will = this;
  let logger = will.logger;

  _.assert( !o.visitedContainer || !!o.nodesGroup, 'Expects nodesGroup if visitedContainer provided' );
  _.assertRoutineOptions( modulesEach_body, o );

  if( !o.nodesGroup )
  o.nodesGroup = will.graphGroupMake( _.mapOnly( o, will.graphGroupMake.defaults ) );

  let nodes = _.arrayAs( o.nodesGroup.nodesAddOnce( o.modules ) );

  if( o.withPeers )
  {
    let nodes2 = nodes.slice();
    nodes.forEach( ( node ) =>
    {
      if( node.object && node.object.peerModule )
      _.arrayAppendOnce( nodes2, o.nodesGroup.nodeFrom( node.object.peerModule ) );
    });
    nodes = nodes2;
  }

  let filter = _.mapOnly( o, _.Will.prototype.relationFit.defaults );

  will.assertGraphGroup( o.nodesGroup, o );
  let o2 = _.mapOnly( o, o.nodesGroup.each.defaults );
  o2.roots = nodes;
  o2.onUp = handleUp;
  o2.onDown = handleDown;
  _.assert( _.boolLike( o2.left ) );

  let result = o.nodesGroup.each( o2 );

  if( o.outputFormat !== '/' )
  return result.map( ( variant ) => outputFrom( variant ) );

  return result;

  /* */

  function handleUp( variant, it )
  {

    if( o.withDisabledStem && it.level === 0 )
    {
      let filter2 = _.mapExtend( null, filter );
      filter2.withDisabledSubmodules = 1;
      filter2.withDisabledModules = 1;
      it.continueNode = will.relationFit( variant, filter2 );
    }
    else
    {
      it.continueNode = will.relationFit( variant, filter );
    }

    if( o.onUp )
    o.onUp( outputFrom( variant ), it );

  }

  /* */

  function handleDown( variant, it )
  {
    if( o.onDown )
    o.onDown( outputFrom( variant ), it );
  }

  /* */

  function outputFrom( variant )
  {
    if( o.outputFormat === '*/module' )
    return variant.module;
    else if( o.outputFormat === '*/relation' )
    return variant.relation;
    else
    return variant;
  }

  /* */

}

var defaults = modulesEach_body.defaults =
{

  ... _.mapExtend( null, _.graph.AbstractNodesGroup.prototype.each.defaults ),
  ... _.mapExtend( null, relationFit.defaults ),

  withPeers : 0,
  withStem : 0,
  withoutDuplicates : 0,
  withDisabledStem : null,
  // withDisabledSubmodules : 0,
  // withDisabledModules : 0,

  modules : null,
  outputFormat : '*/module', /* / | * / module | * / relation */
  onUp : null,
  onDown : null,
  recursive : 1,
  nodesGroup : null,

}

_.assert( defaults.withStem === 0 );
_.assert( defaults.withDisabledStem === null );
_.assert( defaults.withDisabledSubmodules === 0 );
_.assert( defaults.withDisabledModules === 0 );
_.assert( defaults.withPeers === 0 );

// _.mapExtend
// (
//   null,
//   _.graph.AbstractNodesGroup.prototype.each.defaults,
//   relationFit.defaults
// );
//
// defaults.withPeers = 1;
// defaults.withDisabledSubmodules = 0;
// defaults.withDisabledModules = 0;
// defaults.withDisabledStem = null;
//
// defaults.modules = null;
// defaults.outputFormat = '*/module'; /* / | * / module | * / relation */
// defaults.onUp = null;
// defaults.onDown = null;
// defaults.recursive = 1;
// defaults.nodesGroup = null;

let modulesEach = _.routineFromPreAndBody( modulesEach_pre, modulesEach_body );
let modulesEachAll = _.routineDefaults( null, modulesEach, RelationFilterOn );

// let modulesEachAll = _.routineFromPreAndBody( modulesEach_pre, modulesEach_body );
// _.mapExtend( modulesEachAll.defaults, RelationFilterOn );

//

function modulesFor_pre( routine, args )
{
  let module = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o = args[ 0 ];

  o = _.routineOptions( routine, o );

  return o;
}

function modulesFor_body( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let visitedVariantsSet = new Set;
  let visitedModulesSet = new Set;

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( modulesFor_body, arguments );

  if( !o.nodesGroup )
  o.nodesGroup = will.graphGroupMake( _.mapOnly( o, will.graphGroupMake.defaults ) );
  o.modules = _.arrayAs( o.nodesGroup.nodesAddOnce( o.modules ) );
  _.assert( _.arrayIs( o.modules ) );

  let variants = variantsEach( o.modules );

  return act( variants )
  .finally( ( err, arg ) =>
  {
    if( err )
    debugger;
    if( err )
    throw _.err( err );
    return o;
  });

  /* */

  function act( variants )
  {
    let ready = new _.Consequence().take( null );

    ready.then( () =>
    {
      let ready = new _.Consequence().take( null );
      variants.forEach( ( variant ) => ready.then( () => variantAction( variant ) ) );
      return ready;
    });

    ready.then( () =>
    {
      let variants2 = variantsEach( variants );
      if( variants2.length > variants.length && o.recursive >= 2 )
      return act( variants2 );
      return o;
    });

    return ready;
  }

  function variantsEach( variants )
  {
    let o2 = _.mapOnly( o, will.modulesEach.defaults );
    o2.outputFormat = '/';
    o2.modules = variants;
    let result = will.modulesEach( o2 );
    return result;
  }

  function variantAction( variant )
  {
    let ready = new _.Consequence().take( null );
    if( o.onEachModule )
    variant.modules.forEach( ( module ) =>
    {
      if( visitedModulesSet.has( module ) )
      return null;
      visitedModulesSet.add( module );
      let o3 = _.mapExtend( null, o );
      o3.module = module;
      ready.then( () => o.onEachModule( module, o3 ) );
    });
    if( visitedVariantsSet.has( variant ) )
    return null;
    visitedVariantsSet.add( variant );
    if( o.onEachVariant )
    {
      let o3 = _.mapExtend( null, o );
      o3.variant = variant;
      ready.then( () => o.onEachVariant( variant, o3 ) );
    }
    return ready;
  }

}

var defaults = modulesFor_body.defaults = _.mapExtend
(
  null,
  modulesEach.defaults,
  relationFit.defaults
);

defaults.recursive = 1;
defaults.withPeers = 1;
defaults.left = 1;
defaults.nodesGroup = null;
defaults.modules = null;
defaults.onEachVariant = null;
defaults.onEachModule = null;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

_.assert( defaults.onEach === undefined );
_.assert( defaults.withDisabledSubmodules === 0 );
_.assert( defaults.withDisabledModules === 0 );

let modulesFor = _.routineFromPreAndBody( modulesFor_pre, modulesFor_body );

//

function modulesDownload_pre( routine, args )
{
  let module = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o = args[ 0 ];

  o = _.routineOptions( routine, o );
  _.assert( _.arrayHas( [ 'download', 'update', 'agree' ], o.mode ) );

  return o;
}

function modulesDownload_body( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let time = _.timeNow();
  let downloadedLengthWas = 0;

  if( !o.downloadedContainer )
  o.downloadedContainer = [];
  if( !o.localContainer )
  o.localContainer = [];
  if( !o.remoteContainer )
  o.remoteContainer = [];
  if( !o.doneContainer )
  o.doneContainer = [];
  if( !o.nodesGroup )
  o.nodesGroup = will.graphGroupMake( _.mapOnly( o, will.graphGroupMake.defaults ) );

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( modulesDownload_body, arguments );

  o.modules = _.arrayAs( o.nodesGroup.nodesAddOnce( o.modules ) );
  _.assert( _.arrayIs( o.modules ) );

  let filter = _.mapOnly( o, _.Will.prototype.relationsFilter.defaults );
  filter.withOut = false;
  if( o.withDisabledStem )
  {
    filter.withDisabledSubmodules = 1;
    filter.withDisabledModules = 1;
  }
  o.modules = will.relationsFilter( o.modules, filter );

  if( !o.modules.length )
  return _.Consequence().take( o );

  let rootModule = o.modules.length === 1 ? o.modules[ 0 ].module : null;
  // let rootModulePath = rootModule ? rootModule.localPath : null;
  // let rootVariant = rootModule ? will.variantFrom( rootModule ) : null;
  let rootVariants = will.variantsFrom( o.modules );

  return variantsUpformAndDownload( rootVariants )
  .finally( ( err, arg ) =>
  {
    if( err )
    debugger;
    if( err )
    throw _.err( err, '\nFailed to', ( o.mode ), 'submodules' );
    log();
    return o;
  });

  /* */

  function variantsUpformAndDownload( variants )
  {
    let ready = new _.Consequence().take( null );

    ready.then( () =>
    {
      return will.modulesUpform
      ({
        modules : variants,
        recursive : o.recursive,
        all : 0,
        subModulesFormed : 1,
        withPeers : 1,
      });
    });

    ready.then( ( arg ) =>
    {
      let o2 = _.mapOnly( o, will.modulesEach.defaults );
      o2.outputFormat = '/';
      o2.modules = variants;
      o2.withPeers = 1; /* yyy */
      o2.withIn = 1;
      o2.withOut = 1;
      delete o2.nodesGroup;
      variants = will.modulesEach( o2 );
      downloadedLengthWas = o.downloadedContainer.length;
      return variantsDownload( variants );
    });

    ready.then( () =>
    {
      let d = o.downloadedContainer.length - downloadedLengthWas;
      if( d > 0 && o.recursive >= 2 )
      return variantsUpformAndDownload( variants );
      return o;
    });

    return ready;
  }

  /* */

  function log()
  {

    rootVariants = rootVariants.filter( ( variant ) =>
    {
      if( !variantIsRoot( variant ) )
      return;
      if( variant.isOut && variant.peer )
      if( _.arrayHas( rootVariants, variant.peer ) )
      return;
      return variant;
    });
    let remoteContainer = o.remoteContainer.filter( ( variant ) =>
    {
      if( variantIsRoot( variant ) )
      return;
      return !variant.isOut || !_.arrayHas( o.remoteContainer, variant.peer );
    });
    let localContainer = o.localContainer.filter( ( variant ) =>
    {
      if( variantIsRoot( variant ) )
      return;
      // if( variant === rootVariant || variant.peer === rootVariant )
      // return;
      return !variant.isOut || !_.arrayHas( o.localContainer, variant.peer );
    });

    if( !o.downloadedContainer.length && !o.loggingNoChanges )
    return;

    let ofModule = rootModule ? ' of ' + rootModule.absoluteName : '';
    let total = ( remoteContainer.length + localContainer.length );
    logger.rbegin({ verbosity : -2 });
    let phrase = '';
    if( o.mode === 'update' )
    phrase = 'updated';
    else if( o.mode === 'agree' )
    phrase = 'agreed';
    else if( o.mode === 'download' )
    phrase = 'downloaded';
    if( o.dry )
    {
      logger.log( ' + ' + o.downloadedContainer.length + '/' + total + ' submodule(s)' + ofModule + ' will be ' + phrase );
    }
    else
    {
      logger.log( ' + ' + o.downloadedContainer.length + '/' + total + ' submodule(s)' + ofModule + ' were ' + phrase + ' in ' + _.timeSpent( time ) );
    }
    logger.rend({ verbosity : -2 });

  }

  /* */

  function variantsDownload( variants )
  {
    let ready2 = new _.Consequence().take( null );

    _.assert( _.arrayIs( variants ) );
    variants.forEach( ( variant ) => /* xxx : make it parallel */
    {

      if( !variant.object )
      return;

      _.assert
      (
        !!variant.object,
        () => `No object for ${variant.localPath}`
      );

      if( _.arrayHas( o.doneContainer, variant ) )
      return null;

      _.assert
      (
        !!variant.opener,
        () => 'Submodule' + ( variant.relation ? variant.relation.qualifiedName : variant.module.qualifiedName ) + ' was not opened or downloaded'
      );

      _.assert
      (
        !!variant.opener && variant.opener.formed >= 2,
        () => 'Submodule' + ( variant.opener ? variant.opener.qualifiedName : n ) + ' was not preformed to download it'
      );

      if( !variant.isRemote || !variant.relation )
      return variantLocalMaybe( variant );
      if( variant.relation && !variant.relation.enabled )
      return variantLocalMaybe( variant );

      ready2.then( () =>
      {
        return variantDownload( variant );
      });

    });

    return ready2;
  }

  /* */

  function variantDownload( variant )
  {

    if( _.arrayHas( o.localContainer, variant ) || _.arrayHas( o.localContainer, variant ) )
    {
      _.assert( 0, 'unexpected' );
    }

    if( _.arrayHas( o.doneContainer, variant ) )
    return variantDone( variant );

    if( variant.peer )
    {
      if( _.arrayHas( o.doneContainer, variant.peer ) )
      {
        return variantDone( variant );
      }
    }

    _.assert( !!variant.relation && !!variant.relation.opener );
    let opener = variant.relation.opener;

    variantRemote( variant );
    variantDone( variant );
    if( variant.peer )
    {
      variantDone( variant.peer );
    }

    if( o.dry )
    {
      let statusOptions =
      {
        downloadRequired : o.mode === 'download',
        updateRequired : o.mode === 'update',
        agreeRequired : o.mode === 'agree',
      }

      return variant.opener.repo.status( statusOptions )
      .then( ( result ) =>
      {
        if( result.downloadRequired || result.updateRequired || result.agreeRequired )
        variantDownloaded( variant );
        return null;
      })
    }
    else
    {
      let o2 = _.mapOnly( o, opener._repoDownload.defaults );
      let r = _.Consequence.From( opener._repoDownload( o2 ) );
      return r.then( ( downloaded ) =>
      {
        _.assert( _.boolIs( downloaded ) );
        if( downloaded )
        variantDownloaded( variant );
        return downloaded;
      });
    }

  }

  /* */

  function variantIsRoot( variant )
  {
    if( variant.isRemote )
    return false;
    if( _.arrayHas( rootVariants, variant ) )
    return true;
    if( rootVariants.some( ( rootVariant ) => rootVariant.peer === variant ) )
    return true;
    return false;
  }

  /* */

  function variantDownloaded( variant )
  {
    _.arrayAppendOnceStrictly( o.downloadedContainer, variant );
  }

  /* */

  function variantLocalMaybe( variant )
  {

    if( variant.isRemote )
    return variantRemote( variant );

    if( variant.peer && variant.peer.object && variant.peer.isRemote )
    return variantRemote( variant );

    if( variant.object.root === variant.object )
    debugger;

    variantLocal( variant );
  }

  /* */

  function variantRemote( variant )
  {

    // if( variantIsRoot( variant ) )
    // {
    //   debugger;
    //   return null;
    // }
    //
    // if( rootModulePath && variant.localPath && rootModulePath === variant.localPath )
    // {
    //   debugger;
    //   return null;
    // }

    _.assert( !!variant.remotePath );
    _.arrayAppendOnce( o.remoteContainer, variant );
    _.assert( !_.arrayHas( o.localContainer, variant ) );
    return null;
  }

  /* */

  function variantLocal( variant )
  {

    // if( variantIsRoot( variant ) )
    // {
    //   debugger;
    //   return null;
    // }
    //
    // if( rootModulePath && variant.localPath && rootModulePath === variant.localPath )
    // return null;

    if( variant.peer )
    {
      if( _.arrayHas( o.doneContainer, variant.peer ) )
      return variantDone( variant );
    }

    if( _.arrayHas( o.doneContainer, variant ) )
    return null;

    _.assert( _.strIs( variant.localPath ) );
    _.arrayAppendOnce( o.localContainer, variant );

    return null;
  }

  /* */

  function variantDone( variant )
  {

    // if( variantIsRoot( variant ) )
    // {
    //   debugger;
    //   return null;
    // }
    //
    // if( rootModulePath && variant.localPath && rootModulePath === variant.localPath )
    // return null;

    _.arrayAppendOnce( o.doneContainer, variant );
    return null;
  }

  /* */
}

var defaults = modulesDownload_body.defaults = _.mapExtend
(
  null,
  modulesEach.defaults,
  relationFit.defaults
);

defaults.mode = 'download';
defaults.strict = 1;
defaults.dry = 0;
defaults.modules = null;
defaults.rootModulePath = null;
defaults.downloadedContainer = null;
defaults.localContainer = null;
defaults.remoteContainer = null;
defaults.doneContainer = null;

defaults.loggingNoChanges = 1;
defaults.recursive = 1;
defaults.withStem = 1;
defaults.withOut = 1;
defaults.withIn = 1;
defaults.withPeers = 1;
defaults.nodesGroup = null;

delete defaults.withPeers;
delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

let modulesDownload = _.routineFromPreAndBody( modulesDownload_pre, modulesDownload_body );

//

function modulesUpform( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  // let visitedSet = new Set;

  o = _.routineOptions( modulesUpform, arguments );

  let o2 = _.mapOnly( o, will.modulesFor.defaults );
  o2.onEachModule = handleEach;
  return will.modulesFor( o2 )
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, `\nFailed to upform modules` );
    return arg;
  });

  /* */

  function handleEach( module, op )
  {
    let o3 = _.mapOnly( o, module.upform.defaults );
    return module.upform( o3 );
  }

  // function handleEach( variant, op )
  // {
  //
  //   if( visitedSet.has( variant ) )
  //   debugger;
  //   if( visitedSet.has( variant ) )
  //   return null;
  //
  //   variant.reform();
  //
  //   if( !variant.module && o.allowingMissing )
  //   return null;
  //   if( !variant.module )
  //   debugger;
  //   if( !variant.module )
  //   throw _.err
  //   (
  //       `Cant upform ${module.absoluteName} because ${variant.relation ? variant.relation.absoluteName : variant.opener.absoluteName} is not available.`
  //     , `\nLooked at ${variant.opener ? variant.opener.commonPath : variant.relation.path}`
  //   );
  //
  //   visitedSet.add( variant );
  //   let o3 = _.mapOnly( o, variant.module.upform.defaults );
  //   return variant.module.upform( o3 );
  // }

}

var defaults = modulesUpform.defaults = _.mapExtend( null, UpformingDefaults, modulesFor.defaults );

defaults.recursive = 2;
defaults.withStem = 1;
defaults.withPeers = 1;
// defaults.allowingMissing = 1;
defaults.all = 1;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

//

function modulesClean( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let files = Object.create( null );

  o = _.routineOptions( modulesClean, arguments );

  if( o.beginTime === null )
  o.beginTime = _.timeNow();

  let o2 = _.mapOnly( o, will.modulesFor.defaults );
  o2.onEachModule = handleEach;
  return will.modulesFor( o2 )
  .then( ( arg ) =>
  {
    let o2 = _.mapOnly( o, will.cleanDelete.defaults );
    o2.files = files;
    return will.cleanDelete( o2 );
  })
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, `\nFailed to clean modules` );

    debugger;
    let o2 = _.mapOnly( o, will.cleanLog.defaults );
    o2.files = files;
    will.cleanLog( o2 );
    debugger;

    return arg;
  });

  /* */

  function handleEach( module, op )
  {

    let o3 = _.mapOnly( o, module.cleanWhatSingle.defaults );
    o3.files = files;
    return module.cleanWhatSingle( o3 );

    // let o3 = _.mapOnly( o, module.clean.defaults );
    // debugger;
    // return module.clean( o3 );
  }

}

var defaults = modulesClean.defaults = _.mapExtend( null, modulesFor.defaults );

defaults.dry = 0;
defaults.fast = 0;
defaults.beginTime = null;
defaults.cleaningSubmodules = 1;
defaults.cleaningOut = 1;
defaults.cleaningTemp = 1;

defaults.recursive = 0;
defaults.withStem = 1;
defaults.withPeers = 1;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

// --
// clean
// --

function cleanLog( o )
{
  // let module = this;
  let will = this;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  // let time = _.timeNow();

  o = _.routineOptions( cleanLog, arguments );

  _.assert( _.intIs( o.beginTime ) );
  _.assert( _.mapIs( o.files ) )

  if( o.explanation === null )
  if( o.dry )
  o.explanation = ' . Clean will delete ';
  else
  o.explanation = ' - Clean deleted ';

  if( !o.spentTime )
  o.spentTime = _.timeNow() - o.beginTime;

  let textualReport = path.groupTextualReport
  ({
    explanation : o.explanation,
    groupsMap : o.files,
    verbosity : logger.verbosity,
    spentTime : o.spentTime,
  });

  if( will.verbosity >= 2 )
  logger.log( textualReport );

  return textualReport;
}

var defaults = cleanLog.defaults =
{

  // cleaningSubmodules : 1,
  // cleaningOut : 1,
  // cleaningTemp : 1,

  files : null,
  explanation : null,
  beginTime : null,
  spentTime : null,
  dry : 1,

}

//

function cleanDelete( o )
{
  // let module = this;
  let will = this;
  let logger = will.logger;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  o = _.routineOptions( cleanDelete, arguments );

  // if( o.beginTime === null )
  // o.beginTime = _.timeNow();

  will.readingEnd();

  if( o.dry )
  {
    return null;
    // let o2 = _.mapOnly( o, module.cleanLog.defaults );
    // return module.cleanLog( o2 );
  }

  // let o2 = _.mapExtend( null, o );
  // delete o2.late;
  // delete o2.dry;
  // let files = module.cleanWhat( o2 );

  _.assert( _.mapIs( o.files ) );
  _.assert( _.arrayIs( o.files[ '/' ] ) );

  for( let f = o.files[ '/' ].length-1 ; f >= 0 ; f-- )
  {
    let filePath = o.files[ '/' ][ f ];
    _.assert( path.isAbsolute( filePath ) );

    if( o.fast )
    fileProvider.filesDelete
    ({
      filePath : filePath,
      verbosity : 0,
      throwing : 0,
      late : 1,
    });
    else
    fileProvider.fileDelete
    ({
      filePath : filePath,
      verbosity : 0,
      throwing : 0,
    });

  }

  // time = _.timeNow() - time;
  //
  // let o3 = _.mapOnly( o, module.cleanLog.defaults );
  // o3.explanation = ' - Clean deleted ';
  // o3.spentTime = time;
  // o3.files = files;
  //
  // let textualReport = module.cleanLog( o3 );

  return o.files;
}

var defaults = cleanDelete.defaults =
{

  // cleaningSubmodules : 1,
  // cleaningOut : 1,
  // cleaningTemp : 1,

  // beginTime : null,

  dry : 0,
  fast : 0,
  files : null,

  // explanation : ' . Clean will delete ',
  // spentTime : null,

}

// var defaults = clean.defaults = Object.create( cleanWhat.defaults );
//
// defaults.dry = 0;

// --
// variant
// --

function variantFrom( object )
{
  let will = this;
  _.assert( arguments.length === 1 );

  // xxx : switch on optimization
  // let result = will.variantOf( object );
  // if( result )
  // return result;

  return _.Will.ModuleVariant.VariantFrom( will, object );
}

//

function variantsFrom( varaints )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.Will.ModuleVariant.VariantsFrom( will, varaints );
}

//

function variantOf( object )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.Will.ModuleVariant.VariantOf( will, object );
}

//

function variantsOf( varaints )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.Will.ModuleVariant.VariantsOf( will, object );
}

//

function variantWithId( id )
{
  let will = this;
  _.assert( arguments.length === 1 );
  return _.any( will.variantMap, ( variant ) => variant.id === id ? variant : undefined );
}

// --
// graph
// --

function assertGraphGroup( group, opts )
{
  if( !Config.debug )
  return true;
  for( let c in group.context )
  _.assert( group.context[ c ] === opts[ c ] || opts[ c ] === undefined );
  return true;
}

//

function graphGroupMake( o )
{
  let will = this;

  o = _.routineOptions( graphGroupMake, arguments );
  o.will = will;

  let sys = new _.graph.AbstractGraphSystem
  ({
    onNodeIs : variantIs,
    onNodeFrom : variantFrom,
    onNodeNameGet : variantName,
    onOutNodesGet : variantSubmodules,
  });
  let group = sys.nodesGroup();

  group.context = o;

  return group;

  /* */

  function variantName( variant )
  {
    return variant.name;
  }

  /* */

  function variantIs( variant )
  {
    if( !variant )
    return false;
    return variant instanceof _.Will.ModuleVariant;
  }

  /* */

  function variantFrom( object )
  {
    let variant = will.variantOf( object );
    if( variant )
    return variant;
    variant = will.variantFrom( object );
    return variant;
  }

  /* */

  function variantSubmodules( variant )
  {
    return variant.submodulesGet( _.mapOnly( o, variant.submodulesGet.defaults ) );
  }

  /* */

  function onInNodesGet( module ) /* xxx : make it working */
  {
    if( module.superRelations )
    return module.superRelations;
    if( module.subRelation )
    return [ module.subRelation ];
    return [];
  }

}

var defaults = graphGroupMake.defaults = _.mapExtend( null, RelationFilterDefaults );

defaults.withPeers = 1;
defaults.withoutDuplicates = 0;

//

function graphTopSort( modules )
{
  let will = this;

  _.assert( arguments.length === 0 || arguments.length === 1 )

  let group = will.graphGroupMake();

  modules = modules || will.modulesArray;
  modules = group.nodesFrom( modules );
  modules = group.rootsToAllReachable( modules );

  let sorted = group.topSort( modules );

  return sorted;
}

//

function graphInfoExportAsTree( modules, o )
{
  let will = this;

  o = _.routineOptions( graphInfoExportAsTree, o );
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 )

  o = _.routineOptions( graphInfoExportAsTree, o );

  if( o.onNodeName === null )
  o.onNodeName = variantNameAndPath;
  if( o.onUp === null )
  o.onUp = variantUp;

  let group = will.graphGroupMake( _.mapOnly( o, will.graphGroupMake.defaults ) );

  modules = modules || will.modulesArray;
  modules = group.nodesFrom( modules );

  if( o.onlyRoots )
  modules = will.modulesOnlyRoots( modules );

  let o2 = _.mapOnly( o, group.rootsExportInfoTree.defaults );
  let info = group.rootsExportInfoTree( modules, o2 );

  return info;

  /* */

  function variantUp( variant, it )
  {
    return variant;
  }

  function variantNameAndPath( variant )
  {
    let result = variant.object instanceof _.Will.ModuleOpener ? 'module::' + variant.opener.name : variant.object.qualifiedName;
    if( o.withLocalPath )
    result += ` - path::local:=${_.color.strFormat( variant.localPath, 'path' )}`;
    if( o.withRemotePath && variant.remotePath )
    result += ` - path::remote:=${_.color.strFormat( variant.remotePath, 'path' )}`;
    return result;
  }

}

var defaults = graphInfoExportAsTree.defaults = _.mapExtend
(
  null,
  _.graph.AbstractNodesGroup.prototype.rootsExportInfoTree.defaults,
  RelationFilterDefaults
);

defaults.withDisabledModules = 1;
defaults.withDisabledSubmodules = 1;
defaults.withoutDuplicates = 1;
defaults.withLocalPath = 0;
defaults.withRemotePath = 0;
defaults.withOut = 1;
defaults.onlyRoots = 1;

// --
// opener
// --

function _openerMake_pre( routine, args )
{
  let module = this;
  let o = args[ 0 ];

  if( _.strIs( o ) || _.arrayIs( o ) )
  o = { selector : o }

  _.routineOptions( routine, o );
  _.assert( arguments.length === 2 );
  _.assert( args.length === 1 );
  _.assert( !o.isMain || !o.mainOpener || !o.opener || o.mainOpener === o.opener );

  return o;
}

function _openerMake_body( o )
{
  let will = this.form();
  let fileProvider = will.fileProvider;
  let path = will.fileProvider.path;
  let logger = will.logger;
  let madeOpener = null;

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( _openerMake_body, arguments );

  try
  {

    if( !o.opener )
    o.opener = o.opener || Object.create( null );
    o.opener.will = will;

    if( !o.willfilesPath && !o.opener.willfilesPath )
    o.willfilesPath = o.willfilesPath || fileProvider.path.current();
    if( o.willfilesPath )
    o.opener.willfilesPath = o.willfilesPath;

    if( !( o.opener instanceof will.ModuleOpener ) )
    o.opener = madeOpener = will.ModuleOpener( o.opener );

    _.assert( o.opener instanceof will.ModuleOpener );

    if( o.searching )
    o.opener.searching = o.searching;

    if( !o.opener.will )
    o.opener.will = will;

    o.opener.preform()

    return o.opener;
  }
  catch( err )
  {
    debugger;

    if( o.throwing )
    throw _.err( err, `\nFailed to make module at ${o.opener.willfilesPath}` );

    return null;
  }
}

_openerMake_body.defaults =
{

  opener : null,
  throwing : 1,

}

let _openerMake = _.routineFromPreAndBody( _openerMake_pre, _openerMake_body );

//

function openerMakeManual( o )
{
  let will = this;

  o = _.routineOptions( openerMakeManual, arguments );
  o.opener = o.opener || Object.create( null );
  o.opener.reason = o.opener.reason || 'user';
  if( o.willfilesPath )
  o.opener.willfilesPath = o.willfilesPath;

  delete o.willfilesPath;
  return will._openerMake( o );
}

var defaults = openerMakeManual.defaults = Object.create( _openerMake.defaults );

defaults.willfilesPath = null;

//

function openersAdoptModule( module )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = 0;
  let commonPath = module.commonPath;

  _.assert( arguments.length === 1 );

  will.openersArray.forEach( ( opener ) =>
  {
    if( opener.commonPath !== commonPath )
    return;
    if( opener.openedModule == module )
    return;

    _.assert( opener.openedModule === null );
    opener.moduleAdopt( module );
    result += 1;

    // if( !opener.repo.isDownloaded )
    // {
    //   debugger;
    //   opener.repo.isDownloaded = true;
    // }

  });

  return result;
}

//

function openerUnregister( opener )
{
  let will = this;

  _.assert( will.openerModuleWithIdMap[ opener.id ] === opener );
  delete will.openerModuleWithIdMap[ opener.id ];
  _.assert( _.arrayCountElement( _.mapVals( will.openerModuleWithIdMap ), opener ) === 0 );
  _.arrayRemoveOnceStrictly( will.openersArray, opener );

}

//

function openerRegister( opener )
{
  let will = this;

  _.assert( opener.id > 0 );
  will.openerModuleWithIdMap[ opener.id ] = opener;
  _.arrayAppendOnceStrictly( will.openersArray, opener );
  _.assert( _.arrayCountElement( _.mapVals( will.openerModuleWithIdMap ), opener ) === 1 );

}

//

function openersErrorsRemoveOf( opener )
{
  let will = this;

  _.assert( arguments.length === 1 );
  _.assert( opener instanceof will.ModuleOpener );

  will.openersErrorsArray = will.openersErrorsArray.filter( ( r ) =>
  {
    if( r.opener === opener )
    {
      debugger;
      delete will.openersErrorsMap[ r.localPath ];
      return false;
    }
  });

  return will;
}

//

function openersErrorsRemoveAll()
{
  let will = this;
  _.assert( arguments.length === 0 );
  will.openersErrorsArray.splice( 0, will.openersErrorsArray.length );
  debugger;
  _.mapDelete( will.openersErrorsMap );
}

// --
// willfile
// --

function readingReset()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  will.willfilesReadBeginTime = null;
  will.willfilesReadEndTime = null;

  return will;
}

//

function readingBegin()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );

  if( will.willfilesReadBeginTime )
  return will;

  will._willfilesReadBegin();

  return will;
}

//

function readingEnd()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !!will.mainOpener );

  will._willfilesReadEnd( will.mainOpener ? will.mainOpener.openedModule : null );

  return will;
}

//

function _willfilesReadBegin()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( will.mainOpener === null || will.mainOpener instanceof will.ModuleOpener );

  will.willfilesReadBeginTime = will.willfilesReadBeginTime || _.timeNow();

}

//

function _willfilesReadEnd( module )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( module instanceof will.OpenedModule );
  _.assert( will.mainOpener === null || will.mainOpener instanceof will.ModuleOpener );

  if( will.willfilesReadEndTime )
  return will;

  if( will.mainOpener && module === will.mainOpener.openedModule && !module.original )
  will._willfilesReadLog();

  return will;
}

//

function _willfilesReadLog()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !will.willfilesReadEndTime );

  will.willfilesReadEndTime = will.willfilesReadEndTime || _.timeNow();

  if( will.verbosity >= 2 )
  {
    let total = 0;
    will.willfilesArray.forEach( ( willf ) =>
    {
      total += _.arrayIs( willf.filePath ) ? willf.filePath.length : 1
    });
    let spent = _.timeSpentFormat( will.willfilesReadEndTime - will.willfilesReadBeginTime );
    logger.log( ' . Read', total, 'willfile(s) in', spent, '\n' );
  }

}

//

function WillfilePathIs( filePath )
{
  let fname = _.path.fullName( filePath );
  let r = /\.will\.\w+/;
  if( _.strHas( fname, r ) )
  return true;
  return false;
}

//

function WillfilesFind( o )
{

  if( _.strIs( o ) )
  o = { commonPath : o }

  _.routineOptions( WillfilesFind, o );

  if( !o.fileProvider )
  o.fileProvider = _.fileProvider;
  if( !o.logger )
  o.logger = _global_.logger;

  let fileProvider = o.fileProvider;
  let path = fileProvider.path;
  let logger = o.logger;

  if( o.commonPath === '.' )
  o.commonPath = './';
  o.commonPath = path.normalize( o.commonPath );
  o.commonPath = _.strRemoveEnd( o.commonPath, '.' );
  o.commonPath = path.resolve( o.commonPath );

  _.assert( arguments.length === 1 );
  _.assert( _.boolIs( o.recursive ) );
  _.assert( o.recursive === false );
  _.assert( !path.isGlobal( path.fromGlob( o.commonPath ) ), 'Expects local path' );

  if( !o.tracing )
  return findFor( o.commonPath );

  let commonPaths = path.traceToRoot( o.commonPath );

  {
    let result = findFor( commonPaths[ commonPaths.length-1 ] );
    if( result.length )
    return result;
  }

  for( let d = commonPaths.length-1 ; d >= 0 ; d-- )
  {
    let commonPath = commonPaths[ d ];
    let result = findFor( path.trail( commonPath ) );
    if( result.length )
    return result;
  }

  return [];

  function findFor( commonPath )
  {

    if( !path.isSafe( commonPath, 1 ) )
    return [];

    let filter =
    {
      filePath : commonPath,
      maskTransientDirectory :
      {
      },
      maskDirectory :
      {
      },
      maskTerminal :
      {
        includeAny : /(\.|((^|\.|\/)will(\.[^.]*)?))$/,
        excludeAny :
        [
          /\.DS_Store$/,
          /(^|\/)-/,
        ],
        includeAll : []
      }
    };

    if( o.excludingUnderscore && path.isGlob( commonPath ) )
    {
      filter.maskDirectory.excludeAny = [ /(^|\/)_/, /(^|\/)-/, /(^|\/)\.will($|\/)/ ];
      filter.maskTransientDirectory.excludeAny = [ /(^|\/)_/, /(^|\/)-/, /(^|\/)\.will($|\/)/ ];
    }

    if( !o.withIn )
    filter.maskTerminal.includeAll.push( /(^|\.|\/)out(\.)/ )
    if( !o.withOut )
    filter.maskTerminal.excludeAny.push( /(^|\.|\/)out(\.)/ )

    if( !path.isGlob( commonPath ) )
    filter.recursive = o.recursive ? 2 : 1;

    let o2 =
    {
      filter : filter,
      maskPreset : 0,
      mandatory : 0,
      mode : 'distinct',
    }

    // if( _.strHas( o.commonPath, 'out/submodule' ) )
    // debugger;

    filter.filePath = path.mapExtend( filter.filePath );
    filter.filePath = path.filterPairs( filter.filePath, ( it ) =>
    {
      if( !_.strIs( it.dst ) )
      return { [ it.src ] : it.dst };

      _.sure( !o.tracing || !path.isGlob( it.src ) )

      let hasExt = /(^|\.|\/)will\.[^\.\/]+$/.test( it.src );
      let hasWill = /(^|\.|\/)will(\.)?[^\.\/]*$/.test( it.src );
      let hasImEx = /(^|\.|\/)(im|ex)[^\/]*$\./.test( it.src );

      let postfix = '?(.)';
      if( !hasWill )
      {
        postfix += '?(im.|ex.)';
        if( !o.exact )
        if( o.withOut && o.withIn )
        {
          postfix += '?(out.)';
        }
        else if( o.withIn )
        {
          postfix += '';
        }
        else if( o.withOut )
        {
          postfix += 'out.';
        }
        postfix += 'will';
      }

      if( !hasExt )
      postfix += '.*';

      it.src += postfix;

      return { [ it.src ] : it.dst };
    });

    let files = fileProvider.filesFind( o2 );

    let files2 = [];
    files.forEach( ( file ) =>
    {
      if( _.Will.PathIsOut( file.absolute ) )
      files2.push( file );
    });
    files.forEach( ( file ) =>
    {
      if( !_.Will.PathIsOut( file.absolute ) )
      files2.push( file );
    });

    return files2;
  }
}

WillfilesFind.defaults =
{
  commonPath : null,
  withIn : 1,
  withOut : 1,
  exact : 0,
  recursive : false,
  tracing : 0,
  excludingUnderscore : 0,
  fileProvider : null,
  logger : null,
}

//

function willfilesFind( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  will.readingBegin();

  o.logger = logger;
  o.fileProvider = fileProvider;

  return will.WillfilesFind( o );
}

willfilesFind.defaults = _.mapExtend( null, WillfilesFind.defaults );

delete willfilesFind.defaults.logger;
delete willfilesFind.defaults.fileProvider;

//

function willfilesSelectPaired( record, records )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let result = [ record ];
  let commonPathMap = Object.create( null );

  _.assert( arguments.length === 2 );
  _.assert( record instanceof _.FileRecord );
  _.assert( _.arrayIs( records ) );

  records.forEach( ( record ) =>
  {
    let commonPath = _.Will.CommonPathFor( record.absolute );
    let array = commonPathMap[ commonPath ] = commonPathMap[ commonPath ] || [];
    _.arrayAppendOnce( array, record );
  });

  let commonPath = _.Will.CommonPathFor( record.absolute );
  let array = commonPathMap[ commonPath ] = commonPathMap[ commonPath ] || [];
  _.arrayAppendOnce( array, record );

  return array;
}

//

function willfileWithCommon( commonPath )
{
  let will = this;
  commonPath = _.Will.CommonPathFor( commonPath );
  let result = will.willfileWithCommonPathMap[ commonPath ];
  if( !result || !result.length )
  return null
  return result;
}

//

function _willfileWithFilePath( filePath )
{
  let will = this;
  let result = will.willfileWithFilePathPathMap[ filePath ];
  if( !result )
  return null
  return result;
}

//

let _willfileWithFilePath2 = _.vectorize( _willfileWithFilePath );
function willfileWithFilePath( filePath )
{
  let will = this;
  let result = _willfileWithFilePath2.apply( this, arguments );
  if( _.arrayIs( result ) )
  {
    result = result.filter( ( r ) => r !== null );
    if( !result.length )
    return null;
  }
  return result;
}

//

function willfileFor( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let r = Object.create( null );

  _.routineOptions( willfileFor, arguments );
  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o.willf ) );
  _.assert( _.arrayHas( [ false, 0, 'supplement' ], o.combining ) );

  o.willf.will = will;

  let willf = will.willfileWithFilePath( o.willf.filePath );
  if( willf )
  {
    r.willf = willf;
    r.new = false;
    if( o.combining === 'supplement' )
    return r;
    _.assert( !o.willf.data );
    _.assert( !o.willf.structure );
    _.arrayAs( willf ).forEach( ( willf ) =>
    {
      if( !o.combining )
      throw _.err( `Cant redefine willfile ${willf.filePath}, because {- o.combining -} is off` );
      willf.copy( o.willf );
    });
  }
  else
  {
    willf = new will.Willfile( o.willf ).preform();
    r.willf = willf;
    r.new = true;
  }

  return r;
}

willfileFor.defaults =
{
  willf : null,
  combining : false,
}

//

function willfileUnregister( willf )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayRemoveOnceStrictly( will.willfileWithCommonPathMap[ willf.commonPath ], willf );
  if( !will.willfileWithCommonPathMap[ willf.commonPath ].length )
  delete will.willfileWithCommonPathMap[ willf.commonPath ];

  let filePath = _.arrayAs( willf.filePath );
  for( let f = 0 ; f < filePath.length ; f++ )
  {
    _.assert( will.willfileWithFilePathPathMap[ filePath[ f ] ] === willf );
    delete will.willfileWithFilePathPathMap[ filePath[ f ] ];
  }
  _.assert( _.arrayCountElement( _.mapVals( will.willfileWithFilePathPathMap ), willf ) === 0 );

  _.arrayRemoveOnceStrictly( will.willfilesArray, willf );

}

//

function willfileRegister( willf )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.arrayAppendOnceStrictly( will.willfilesArray, willf );

  let filePath = _.arrayAs( willf.filePath );
  for( let f = 0 ; f < filePath.length ; f++ )
  {
    _.assert( _.arrayHas( [ willf, undefined ], will.willfileWithFilePathPathMap[ filePath[ f ] ] ) );
    will.willfileWithFilePathPathMap[ filePath[ f ] ] = willf;
  }
  _.assert( _.arrayCountElement( _.mapVals( will.willfileWithFilePathPathMap ), willf ) === filePath.length );

  will.willfileWithCommonPathMap[ willf.commonPath ] = will.willfileWithCommonPathMap[ willf.commonPath ] || [];
  _.arrayAppendOnceStrictly( will.willfileWithCommonPathMap[ willf.commonPath ], willf );

}

// --
// hooks
// --

function hooksReload()
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let hooks = will._.hooks = will._.hooks || Object.create( null );

  _.assert( arguments.length === 0 );
  _.assert( path.is( will.environmentPath ) );

  let hooksFiles = fileProvider.filesFind
  ({
    filePath : will.hooksPath + '/*',
    withDirs : 0,
  });

  hooksFiles.forEach( ( hookFile ) =>
  {
    let hook = Object.create( null );
    hook.name = path.name( hookFile.absolute );
    hook.file = hookFile;
    hook.call = function call( it )
    {
      _.assert( arguments.length === 1 );
      it = will.resourceWrap( it );
      let it2 = will.hookItNew( it );
      it2.execPath = hook.file.absolute;
      it2 = will.hookItFrom( it2 );
      return will.hookCall( it2 );
    }
    _.assert( !hooks[ hook.name ], () => `Redefinition of hook::${name}` );
    hooks[ hook.name ] = hook;
  });

}

//

function hookItNew( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  /* xxx : use recursive clone here */

  let o2 = _.mapExtend( null, o );
  delete o2.execPath;
  delete o2.interpreterName;

  if( o2.request )
  o2.request = clone( o2.request );
  if( o2.request.map )
  o2.request.map = clone( o2.request.map );

  _.assert( !o2.request || o2.request !== o.request );
  _.assert( !o2.request || !o2.request.map || o2.request.map !== o.request.map );

  return o2;

  function clone( src )
  {
    if( _.mapIs( src ) )
    return _.mapExtend( null, src );
    return src;
  }

}

//

function hookItFrom( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let withPath = path.join( _.path.current(), will.withPath || './' );

  o = will.resourceWrap( o );

  o = _.routineOptions( hookItFrom, o );
  _.assert( arguments.length === 1 );

  if( o.opener && !o.module )
  o.module = o.opener.openedModule;
  o.openers = will.currentOpeners;
  if( !o.variant )
  o.variant = will.variantOf( opener );
  if( !o.variant )
  o.variant = will.variantFrom( opener );
  if( !o.opener )
  o.opener = o.variant.opener;
  if( !o.module )
  o.module = o.variant.module;

  _.assert( o.variant instanceof _.Will.ModuleVariant );

  let relativeLocalPath = _.path.relative( o.variant.dirPath, o.variant.localPath );

  if( !o.will )
  o.will = will;
  if( !o.tools )
  o.tools = wTools;
  if( !o.path )
  o.path = path;
  if( !o.fileProvider )
  o.fileProvider = fileProvider;
  if( !o.ready )
  o.ready = new _.Consequence().take( null );
  if( !o.withPath )
  o.withPath = withPath;
  if( !o.logger )
  o.logger = logger;

  let delimeter;
  if( o.request === null )
  [ o.execPath, delimeter, o.request ] = _.strIsolateLeftOrAll( o.execPath, /\s+/ );
  if( o.request === null )
  o.request = '';
  if( _.strIs( o.request ) )
  o.request = _.strRequestParse( o.request );
  _.assert( !!o.request.map );

  if( !o.start )
  o.start = _.process.starter
  ({
    currentPath : o.variant.dirPath,
    outputCollecting : 1,
    outputGraying : 1,
    outputPiping : 1,
    inputMirroring : 1,
    briefExitCode : 1,
    sync : 0,
    deasync : 1,
    mode : 'shell',
    ready : o.ready
  });

  if( !o.startNonThrowing )
  o.startNonThrowing = _.process.starter
  ({
    currentPath : o.variant.dirPath,
    outputCollecting : 1,
    outputGraying : 1,
    outputPiping : 1,
    inputMirroring : 1,
    briefExitCode : 1,
    throwingExitCode : 0,
    sync : 0,
    deasync : 1,
    mode : 'shell',
    ready : o.ready
  });

  if( !o.startWill )
  o.startWill = _.process.starter
  ({
    currentPath : o.variant.dirPath,
    execPath : `${will.WillPathGet()} .with ${relativeLocalPath} `,
    outputCollecting : 1,
    outputGraying : 1,
    outputPiping : 1,
    inputMirroring : 1,
    briefExitCode : 1,
    sync : 0,
    deasync : 1,
    mode : 'fork',
    ready : o.ready,
  });

  _.assert( _.strIs( o.withPath ) );
  _.assert( _.strIs( o.execPath ) );
  _.assert( _.arrayIs( o.openers ) );
  _.assert( o.will === will );

  return o;
}

hookItFrom.defaults =
{

  will : null,
  variant : null,
  module : null,
  opener : null,
  openers : null,

  tools : null,
  path : null,
  fileProvider : null,
  ready : null,
  logger : null,

  withPath : null,
  execPath : null,
  request : null,
  interpreterName : null,
  sync : 1,

  start : null,
  startNonThrowing : null,
  startWill : null,

}

//

function hookCall( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  o = _.routineOptions( hookCall, arguments );
  _.assert( o.will === will );
  _.assert( !!o.variant );

  /* */

  if( o.module && o.withPath && will.Resolver.selectorIs( o.withPath ) )
  o.withPath = o.module.pathResolve
  ({
    selector : o.withPath,
    prefixlessAction : 'resolved',
  });

  _.sure
  (
      o.withPath === null || _.strIs( o.withPath ) || _.strsAreAll( o.withPath )
    , 'Current path should be string if defined'
  );

  if( o.module && o.withPath )
  o.withPath = path.s.join( o.module.inPath, o.withPath );
  else
  o.withPath = path.s.join( o.will.withPath, o.withPath );

  /* */

  if( o.module && will.Resolver.selectorIs( o.execPath ) )
  o.execPath = o.module.resolve
  ({
    selector : o.execPath,
    prefixlessAction : 'resolved',
  });

  o.execPath = path.s.join( o.withPath, o.execPath );
  o.execPath = will.hookFindAt( o.execPath );

  /* */

  if( !o.interpreterName )
  {
    if( _.arrayHasAny( [ 'js', 'ss', 's' ], path.exts( o.execPath ) ) )
    o.interpreterName = 'js';
    else
    o.interpreterName = 'os';
  }

  /* */

  _.assert( path.isAbsolute( o.execPath ) );
  _.assert( _.strDefined( o.interpreterName ) );

  if( o.interpreterName === 'js' )
  return jsCall();
  else if( o.interpreterName === 'os' )
  return exeCall();
  else _.assert( 0, `Unknown interpreter of hook ${o.interpreterName}` );

  /* */

  function jsCall()
  {
    // let ready = o.ready;
    let ready = new _.Consequence().take( null );

    ready
    .then( () =>
    {
      return require( _.fileProvider.path.nativize( o.execPath ) );
    })
    .then( ( routine ) =>
    {
      if( !_.routineIs( routine ) )
      throw _.errBrief( `Script file should export routine or consequence, but exports ${_.strType( routine )}` );
      defaultsApply( routine );
      let r = routine.call( will, o );
      if( r === ready )
      return null;
      if( _.consequenceIs( r ) || _.promiseLike( r ) )
      return r;
      return null;
    })
    .finally( ( err, arg ) =>
    {
      if( err )
      debugger;
      if( err )
      throw _.err( err, `\nFailed to ${o.execPath}` );
      return arg;
    })

    if( o.sync )
    ready.deasync();

    return ready.split();
  }

  /* */

  function defaultsApply( routine )
  {
    if( routine.defaults )
    {
      _.routineOptions( routine, o.request.map );
    }
    else
    {
      if( o.request.map.v !== undefined )
      {
        o.request.map.verbosity = o.request.map.v;
        delete o.request.map.v;
      }
      if( o.request.map.verbosity === undefined )
      o.request.map.verbosity = 1;
    }
  }

  /* */

  function exeCall()
  {
    _.assert( 0, 'not tested' );
    o.execPath = `${o.execPath} ${_.strRequestStr( o.request )} localPath:${o.variant.localPath}`;
    return _.process.start
    ({
      ready : o.ready,
      currentPath : o.withPath,
      execPath : o.execPath,
      outputCollecting : 1,
      outputGraying : 1,
      outputPiping : 1,
      inputMirroring : 1,
      mode : 'shell',
    });
  }

  /* */

}

hookCall.defaults = _.mapExtend( null, hookItFrom.defaults );

//

function hookFindAt( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( !_.mapIs( o ) )
  o = { execPath : o }
  _.routineOptions( hookFindAt, o );
  _.assert( arguments.length === 1 );

  if( fileProvider.isTerminal( o.execPath ) )
  return end( o.execPath );

  let filePath = `${o.execPath}.(${will.KnownHookExts.join( '|' )})`;
  let found = fileProvider.filesFind({ filePath, outputFormat : 'absolute', withDirs : 0 });
  return end( found );

  function end( found )
  {
    if( !o.single )
    return _.arrayAs( found );
    if( _.strIs( found ) )
    return found;
    _.assert( _.arrayIs( found ) );
    if( found.length )
    return found[ 0 ];
    if( !found.length )
    throw _.errBrief( `Found none hook file at ${o.execPath}` );
    else
    throw _.errBrief( `Found several ( ${found.length} ) hook file at ${o.execPath}, not clear which to use\n${found.join( '\n' )}` );
    return found
  }

}

hookFindAt.defaults =
{
  execPath : null,
  single : 1,
}

//

function hooksGet()
{
  let will = this;

  if( !will._.hooks )
  will.hooksReload();

  return will._.hooks;
}

// --
// relations
// --

let ResourceKindToClassName = new _.NameMapper({ leftName : 'resource kind', rightName : 'resource class name' }).set
({

  'submodule' : 'ModulesRelation',
  'step' : 'Step',
  'path' : 'PathResource',
  'reflector' : 'Reflector',
  'build' : 'Build',
  'about' : 'About',
  'execution' : 'Execution',
  'exported' : 'Exported',

});

let ResourceKindToMapName = new _.NameMapper({ leftName : 'resource kind', rightName : 'resource map name' }).set
({

  'about' : 'about',
  'module' : 'moduleWithNameMap',
  'submodule' : 'submoduleMap',
  'step' : 'stepMap',
  'path' : 'pathResourceMap',
  'reflector' : 'reflectorMap',
  'build' : 'buildMap',
  'exported' : 'exportedMap',

});

let ResourceKinds =
[
  'submodule',
  'step',
  'path',
  'reflector',
  'build',
  'about',
  'execution',
  'exported',
];

let KnownHookExts =
[
  'js',
  's',
  'ss',
  'exe',
  'bat',
  'cmd',
  'sh',
  'bash',
]

let OpeningDefaults =
{

  attachedWillfilesFormedOfMain : null,
  peerModulesFormedOfMain : null,
  subModulesFormedOfMain : null,
  resourcesFormedOfMain : null,
  allOfMain : null,

  attachedWillfilesFormedOfSub : null,
  peerModulesFormedOfSub : null,
  subModulesFormedOfSub : null,
  resourcesFormedOfSub : null,
  allOfSub : null,

  verbosity : null,

}

let Composes =
{

  verbosity : 3,
  verboseStaging : 0,

  environmentPath : null,
  withPath : null,

  withEnabled : 1,
  withDisabled : 0,
  ... _.mapBut( ModuleFilterDefaults, { withEnabledModules : null, withDisabledModules : null } ),

}

_.assert( Composes.withEnabledModules === undefined );

let Aggregates =
{

  attachedWillfilesFormedOfMain : true,
  peerModulesFormedOfMain : true,
  subModulesFormedOfMain : true,
  resourcesFormedOfMain : null,
  allOfMain : null,

  attachedWillfilesFormedOfSub : true,
  peerModulesFormedOfSub : true,
  subModulesFormedOfSub : true,
  resourcesFormedOfSub : null,
  allOfSub : null,

}

let Associates =
{

  fileProvider : null,
  logger : null,
  mainOpener : null,

}

let Restricts =
{

  formed : 0,
  willfilesReadBeginTime : null,
  willfilesReadEndTime : null,

  repoMap : _.define.own({}),
  variantMap : _.define.own({}),
  objectToVariantHash : _.define.own( new HashMap ),
  modulesArray : _.define.own([]),
  moduleWithIdMap : _.define.own({}),
  moduleWithCommonPathMap : _.define.own({}),
  moduleWithNameMap : _.define.own({}),
  openersArray : _.define.own([]),
  openerModuleWithIdMap : _.define.own({}),
  openersErrorsArray : _.define.own([]),
  openersErrorsMap : _.define.own({}),

  willfilesArray : _.define.own([]),
  willfileWithCommonPathMap : _.define.own({}),
  willfileWithFilePathPathMap : _.define.own({}),

}

let Statics =
{

  ResourceCounter : 0,
  ResourceKindToClassName,
  ResourceKindToMapName,
  ResourceKinds,
  KnownHookExts,
  OpeningDefaults,
  UpformingDefaults,
  ModuleFilterNulls,
  ModuleFilterDefaults,
  ModuleFilterOn,
  ModuleFilterOff,
  RelationFilterNulls,
  RelationFilterDefaults,
  RelationFilterOn,
  RelationFilterOff,

  // path

  WillPathGet,
  WillfilePathIs,
  PathIsOut,
  DirPathFromFilePaths,
  PrefixPathForRole,
  PrefixPathForRoleMaybe,
  PathToRole,
  CommonPathFor,
  CommonPathNormalize,
  CloneDirPathFor,
  OutfilePathFor,
  RemotePathAdjust,
  HooksPathGet,
  IsModuleAt,
  WillfilesFind,

}

let Forbids =
{
  mainModule : 'mainModule',
  recursiveExport : 'recursiveExport',
  graphGroup : 'graphGroup',
  graphSystem : 'graphSystem',
  filesGraph : 'filesGraph',
}

let Accessors =
{

  _ : { getter : _.accessor.getter.withSymbol, readOnly : 1, },
  hooks : { getter : hooksGet, readOnly : 1, },
  environmentPath : { setter : environmentPathSet },
  hooksPath : { getter : hooksPathGet, readOnly : 1, },

}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,
  unform,
  form,
  formAssociates,

  // path

  WillPathGet,
  PathIsOut,
  DirPathFromFilePaths,
  PrefixPathForRole,
  PrefixPathForRoleMaybe,
  PathToRole,
  CommonPathFor,
  CommonPathNormalize,
  CloneDirPathFor,
  OutfilePathFor,
  RemotePathAdjust,
  HooksPathGet,
  IsModuleAt,

  hooksPathGet,
  environmentPathSet,
  environmentPathDetermine,

  // etc

  _verbosityChange,

  vcsProviderFor,
  vcsToolsFor,
  repoFrom,

  resourceWrap,
  resourcesInfoExport,
  variantsWithId,
  variantsInfoExport,
  _pathChanged,
  versionGet,
  versionIsUpToDate,

  // defaults

  filterDefaults,
  instanceDefaultsApply,
  instanceDefaultsSupplement,
  instanceDefaultsExtend,
  instanceDefaultsReset,
  prefer,

  // module

  moduleAt,
  moduleFit,
  relationFit,
  modulesFilter,
  relationsFilter,
  moduleIdUnregister,
  moduleIdRegister,
  modulePathUnregister,
  modulePathRegister,
  moduleNew,

  modulesFindEachAt,
  modulesFindWithAt,
  modulesOnlyRoots,
  modulesEach,
  modulesEachAll,
  modulesFor,
  modulesDownload,
  modulesUpform,
  modulesClean,

  // clean

  cleanLog,
  cleanDelete,

  // variant

  variantFrom,
  variantsFrom,
  variantOf,
  variantsOf,
  variantWithId,

  // graph

  assertGraphGroup,
  graphGroupMake,
  graphTopSort,
  graphInfoExportAsTree,

  // opener

  _openerMake,
  openerMakeManual,
  openersAdoptModule,
  openerUnregister,
  openerRegister,
  openersErrorsRemoveOf,
  openersErrorsRemoveAll,

  // willfile

  readingReset,
  readingBegin,
  readingEnd,

  _willfilesReadBegin,
  _willfilesReadEnd,
  _willfilesReadLog,

  WillfilePathIs,
  WillfilesFind,
  willfilesFind,
  willfilesSelectPaired,
  willfileWithCommon,
  _willfileWithFilePath,
  willfileWithFilePath,
  willfileFor,
  willfileUnregister,
  willfileRegister,

  // hooks

  hooksReload,
  hookItNew,
  hookItFrom,
  hookCall,
  hookFindAt,
  hooksGet,

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

_.Copyable.mixin( Self );
_.Verbal.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
wTools[ Self.shortName ] = Self;

if( typeof module !== 'undefined' )
require( './IncludeMid.s' );

})();
