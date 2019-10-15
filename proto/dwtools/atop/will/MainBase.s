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

//

let _ = wTools;
let Parent = null;
let Self = function wWill( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Will';

let UpformingDefaults =
{
  all : null,
  attachedWillfilesFormed : null,
  peerModulesFormed : null,
  subModulesFormed : null,
  resourcesFormed : null,
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

  _.assert( arguments.length === 0 );
  _.assert( !will.formed );

  /* begin */

  /* end */

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

  if( !will.filesGraph )
  will.filesGraph = _.FilesGraphOld({ fileProvider : will.fileProvider });

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

function vcsFor( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;

  if( !_.mapIs( o ) )
  o = { filePath : o }

  _.assert( arguments.length === 1 );
  _.routineOptions( vcsFor, o );
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

vcsFor.defaults =
{
  filePath : null,
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

  let currentVersion = will.versionGet();

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

    let latestVersion = _.strStrip( result.output );

    if( latestVersion !== currentVersion )
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

      if( o.brief )
      throw _.errBrief( coloredMessage );
      else
      throw _.err( message );
    }
    else
    {
      logger.log( 'Utility willbe is up to date!' );
    }

    return true;
  })

  return ready;
}

versionIsUpToDate.defaults =
{
  throwing : 1,
  brief : 1
}

// --
// defaults
// --

function instanceDefaultsApply( o )
{
  let will = this;

  _.assert( arguments.length === 1 );

  for( let d in will.Defaults )
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

  for( let d in will.Defaults )
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

  for( let d in will.Defaults )
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

  for( let d in will.Defaults )
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

  let commonPath = will.AbstractModule.CommonPathFor( willfilesPath );

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
  // let module = this;
  // let will = module.will;
  let will = this;
  let logger = will.logger;

  _.assert( arguments.length === 2 );
  _.assert( variant instanceof _.Will.ModuleVariant )

  if( !opts.withOut && variant.module )
  if( variant.module.isOut )
  return false;

  if( !opts.withIn && variant.module )
  if( !variant.module.isOut )
  return false;

  if( !opts.withOptional )
  if( !variant.relation || variant.relation.isOptional() )
  return false;

  if( !opts.withMandatory && variant.relation )
  if( !variant.relation.isOptional() )
  return false;

  if( !opts.withEnabled && variant.relation )
  if( variant.relation.enabled )
  return false;

  if( !opts.withDisabled && variant.relation )
  if( !variant.relation.enabled )
  return false;

  return true;
}

var defaults = moduleFit_body.defaults = Object.create( null );

defaults.withStem = 0;
defaults.withPeers = 0;
defaults.withOut = 1;
defaults.withIn = 1;
defaults.withOptional = 1;
defaults.withMandatory = 1;
defaults.withEnabled = 1;
defaults.withDisabled = 0;

let moduleFit = _.routineFromPreAndBody( moduleFit_pre, moduleFit_body );

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

  if( _.strEnds( o.selector, '::' ) )
  o.selector = o.selector + '*';

  /* */

  if( will.Resolver.selectorIs( o.selector ) )
  {

    let opener = o.currentOpener;

    debugger;
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

    // if( !o.currentOpener )
    // opener = o.currentOpener = will.ModuleOpener({ will : will, willfilesPath : path.trail( path.current() ) }).preform();
    // opener.find();

    con = opener.openedModule.ready.split();
    con.then( () =>
    {
      let con2 = new _.Consequence();
      let resolved = opener.openedModule.submodulesResolve({ selector : o.selector, preservingIteration : 1 });
      resolved = _.arrayAs( resolved );

      debugger;
      for( let s = 0 ; s < resolved.length ; s++ ) con2.then( ( arg ) => /* !!! replace by concurrent, maybe */
      {
        let it1 = resolved[ s ];
        let opener = it1.currentModule;

        debugger;
        let it2 = Object.create( null );
        it2.currentOpener = opener._openerMake(); // zzz

        if( _.arrayIs( it1.dst ) || _.strIs( it1.dst ) )
        it2.currentPath = it1.dst;
        it2.options = o;

        if( o.onBegin )
        o.onBegin( it2 )
        if( o.onEnd )
        return o.onEnd( it2 );

        return null;
      });
      con2.take( null );
      return con2;
    });

    opener.open();

  }
  else
  {

    // o.selector = path.resolve( o.selector );
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
        dirPath : o.selector,
        includingInFiles : 1,
        includingOutFiles : 1,
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

      // debugger;
      // let opener = will._openerMake
      // ({
      //   willfilesPath : file.absolute,
      //   searching : 'smart',
      // });

      let selectedFiles = will.willfilesSelectPaired( file, files );
      let willfilesPath = selectedFiles.map( ( file ) =>
      {
        // visitedFilesHash.set( file, true );
        filesMap[ file.absolute ] = true;
        return file.absolute;
      });

      if( willfilesPath.length === 1 )
      willfilesPath = willfilesPath[ 0 ];

      // debugger;
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

      // let opener = will._openerMake({ willfilesPath : file.absolute });
      // opener.find();
      // let opener = will.ModuleOpener({ will : will, willfilesPath : file.absolute }).preform();
      // opener.find();

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

  _.sure( _.strDefined( o.selector ), 'Expects string' );
  _.assert( arguments.length === 1 );

  /* */

  will._willfilesReadBegin();
  con = new _.Consequence().take( null );

  let it = Object.create( null );
  it.options = o;
  it.errs = [];
  it.openers = [];

  let visitedFilesHash = new Map();
  let files;
  try
  {
    files = will.willfilesFind
    ({
      dirPath : o.selector,
      tracing : o.tracing,
      includingInFiles : 1,
      includingOutFiles : 1,
    });
  }
  catch( err )
  {
    throw _.err( err );
  }

  files.forEach( ( file ) => con.then( ( arg ) => /* !!! replace by concurrent, maybe */
  {
    let opener;
    try
    {
      // if( visitedFilesHash.has( file ) )
      // debugger;
      if( visitedFilesHash.has( file ) )
      return null;

      let selectedFiles = will.willfilesSelectPaired( file, files );
      let willfilesPath = selectedFiles.map( ( file ) =>
      {
        visitedFilesHash.set( file, true );
        return file.absolute;
      });

      if( willfilesPath.length === 1 )
      willfilesPath = willfilesPath[ 0 ];

      // debugger;
      let opener = will._openerMake
      ({
        opener :
        {
          willfilesPath : willfilesPath,
          searching : 'exact',
          reason : 'with',
        }
      });

      opener.find();
      opener.open();

      return opener.openedModule.ready.split()
      .then( function( arg )
      {
        _.assert( opener.willfilesArray.length > 0 );
        let l = it.openers.length;
        _.arrayAppendOnce( it.openers, opener, ( e ) => e.openedModule );
        _.assert( l < it.openers.length );
        if( l === it.openers.length )
        opener.finit();
        _.assert( !_.arrayHas( it.openers, null ) )
        return arg;
      })
      .catch( function( err )
      {
        debugger;
        err = _.err( err );
        it.errs.push( err );
        opener.finit();
        throw err;
      });
    }
    catch( err )
    {
      debugger;
      err = _.err( err );
      it.errs.push( err );
      if( opener )
      opener.finit();
      throw err;
    }
  }));

  /* */

  con.finally( ( err, arg ) =>
  {
    it.sortedModules = will.graphTopologicalSort( will.modulesArray );
    if( err )
    throw err;
    return it;
  });

  /* */

  return con;
}

modulesFindWithAt.defaults =
{
  selector : null,
  tracing : 0,
}

//

function modulesOnlyRoots( modules, o )
{
  let will = this;
  let visitedContainer = _.containerAdapter.from( new Set );
  let result = _.containerAdapter.from( new Array );
  // let variantMap = Object.create( null );
  let variantMap = will.variantMap;

  if( modules === null || modules === undefined )
  modules = will.modulesArray;

  _.assert( _.longIs( modules ) );
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );
  o = _.routineOptions( modulesOnlyRoots, o );

  if( !o.nodesGroup )
  o.nodesGroup = will.graphGroupMake({ withPeers : 1 });

  /* first make variants for each module */

  _.each( modules, ( module ) =>
  {
    if( !module.isOut )
    module.modulesEach
    ({
      withStem : 1,
      withPeers : 1,
      revisiting : 0,
      recursive : 2,
      outputFormat : '/',
      nodesGroup : o.nodesGroup,
    });
  });

  /* then add in-roots of trees */

  debugger;

  _.each( modules, ( module ) =>
  {
    if( !module.isOut )
    module.modulesEach
    ({
      withStem : 1,
      withPeers : 1,
      revisiting : 0,
      recursive : 2,
      outputFormat : '/',
      onUp : onUp1,
      nodesGroup : o.nodesGroup,
    });
  });

  debugger;

  /* add roots of what left */

  _.each( modules, ( module ) =>
  {
    if( module.isOut )
    module.modulesEach
    ({
      withStem : 1,
      withPeers : 1,
      revisiting : 0,
      recursive : 2,
      outputFormat : '/',
      onUp : onUp2,
      nodesGroup : o.nodesGroup,
      visitedContainer,
    });
  });

  debugger;

  /* add what left */

  _.each( variantMap, ( variant ) =>
  {
    if( !visitedContainer.has( variant ) )
    {
      debugger;
      result.append( variant );
      visitedContainer.append( variant );
    }
  });

  debugger;

  return result.original;

  /* */

  function onUp1( r, it )
  {
    let module = r.module || r.opener;

    if( module && !module.isOut && it.level === 0 && !visitedContainer.has( r ) )
    {
      debugger;
      result.append( r );
      visitedContainer.appendOnce( r );
      if( r.peer )
      visitedContainer.appendOnce( r.peer );
    }
    else if( it.level !== 0 )
    {
      visitedContainer.appendOnce( r );
      if( r.peer )
      visitedContainer.appendOnce( r.peer );
    }
    else
    {
      it.continueUp = false;
    }
  }

  /* */

  function onUp2( r, it )
  {
    debugger;
    if( it.level === 0 )
    {
      result.append( r );
      debugger;
      if( r.peerModule )
      visitedContainer.appendOnce( group.nodeFrom( r.peerModule ) );
    }
    else if( it.level !== 0 )
    {
      if( r.peerModule )
      debugger;
      if( r.peerModule )
      visitedContainer.appendOnce( group.nodeFrom( r.peerModule ) );
    }
    else
    {
      it.continueUp = false;
    }
  }

}

modulesOnlyRoots.defaults =
{
  nodesGroup : null,
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

  if( !o.nodesGroup )
  o.nodesGroup = will.graphGroupMake({ withPeers : o.withPeers });

  let nodes = _.arrayAs( o.nodesGroup.nodesAddOnce( o.modules ) );

  if( o.withPeers )
  {
    let nodes2 = [];
    nodes.forEach( ( node ) =>
    {
      nodes2.push( node );
      if( node.object && node.object.peerModule )
      nodes2.push( o.nodesGroup.nodeFrom( node.object.peerModule ) );
    });
    nodes = nodes2;
  }

  let fitOpts = _.mapOnly( o, _.Will.prototype.moduleFit.defaults );

  let o2 = _.mapOnly( o, o.nodesGroup.each.defaults );
  o2.roots = nodes;
  o2.onUp = handleUp;
  o2.onDown = handleDown;
  _.assert( _.boolLike( o2.left ) );
  let result = o.nodesGroup.each( o2 );

  if( o.outputFormat !== '/' )
  return result.map( ( record ) => outputFrom( record ) );

  return result;

  /* */

  function handleUp( record, it )
  {

    it.continueNode = will.moduleFit( record, fitOpts );
    if( o.onUp )
    o.onUp( outputFrom( record ), it );

  }

  /* */

  function handleDown( record, it )
  {
    if( o.onDown )
    o.onDown( outputFrom( record ), it );
  }

  /* */

  function outputFrom( record )
  {
    if( o.outputFormat === '*/module' )
    return record.module;
    else if( o.outputFormat === '*/relation' )
    return record.relation;
    else
    return record;
  }

  /* */

}

var defaults = modulesEach_body.defaults = _.mapExtend( null, _.graph.AbstractNodesGroup.prototype.each.defaults, moduleFit.defaults );

defaults.modules = null;
defaults.outputFormat = '*/module'; /* / | * / module | * / relation */
defaults.onUp = null;
defaults.onDown = null;
defaults.recursive = 1;
defaults.nodesGroup = null;

let modulesEach = _.routineFromPreAndBody( modulesEach_pre, modulesEach_body );

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
  let visitedSet = new Set;

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( modulesFor_body, arguments );

  if( !o.nodesGroup )
  o.nodesGroup = will.graphGroupMake({ withPeers : 1 });

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
    return will.modulesEach( o2 );
  }

  function variantAction( variant )
  {
    if( visitedSet.has( variant ) )
    return null;
    visitedSet.add( variant );
    let o3 = _.mapExtend( null, o );
    o3.module = variant;
    return o.onEach( variant, o3 ) || null;
  }

}

var defaults = modulesFor_body.defaults = _.mapExtend( null, _.graph.AbstractNodesGroup.prototype.each.defaults, moduleFit.defaults );

defaults.recursive = 1;
defaults.withPeers = 1;
defaults.left = 1;
defaults.nodesGroup = null;
defaults.modules = null;
defaults.onEach = null;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

let modulesFor = _.routineFromPreAndBody( modulesFor_pre, modulesFor_body );

//

function _modulesDownload_pre( routine, args )
{
  let module = this;

  _.assert( arguments.length === 2 );
  _.assert( args.length <= 2 );

  let o = args[ 0 ];

  o = _.routineOptions( routine, o );

  _.assert( _.arrayHas( [ 'download', 'update', 'agree' ], o.mode ) );

  return o;
}

function _modulesDownload_body( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let ready = new _.Consequence().take( null );

  if( !o.downloadedContainer )
  o.downloadedContainer = [];
  if( !o.localContainer )
  o.localContainer = [];
  if( !o.doneContainer )
  o.doneContainer = [];
  if( !o.remoteContainer )
  o.remoteContainer = [];

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( _modulesDownload_body, arguments );
  _.assert( _.each( o.modules, ( variant ) => variant instanceof _.Will.ModuleVariant ) );

  ready.then( () => variantsDownload( o.modules ) );

  ready.finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err );
    return o;
  });

  return ready;

  /* */

  function variantsDownload( variants )
  {
    let ready2 = new _.Consequence().take( null );

    _.assert( _.arrayIs( variants ) );
    variants.forEach( ( variant ) => /* xxx : make it parallel */
    {

      _.assert
      (
        !!variant.object,
        () => 'No object for' + ( variant.relation ? variant.relation.qualifiedName : '' ) + ''
      );

      if( _.arrayHas( o.doneContainer, variant.object.localPath ) )
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

      if( !variant.object.isRemote )
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

    if( _.arrayHas( o.localContainer, variant.object.localPath ) || _.arrayHas( o.localContainer, variant.object.remotePath ) )
    {
      _.assert( 0, 'unexpected' );
    }

    if( _.arrayHas( o.doneContainer, variant.opener.remotePath ) )
    return variantDone( variant );

    if( variant.peer )
    {
      if( _.arrayHas( o.doneContainer, variant.peer.localPath ) )
      {
        debugger;
        return variantDone( variant );
      }
      if( _.arrayHas( o.doneContainer, variant.peer.remotePath ) )
      {
        debugger;
        return variantDone( variant );
      }
    }

    _.arrayAppendOnceStrictly( o.remoteContainer, variant.opener.remotePath );
    variantDone( variant );
    if( variant.peer )
    {
      variantDone( variant.peer );
    }

    if( o.dry )
    {
      return variant.opener._remoteIsUpToDate({ mode : o.mode })
      .then( ( downloading ) =>
      {
        if( downloading )
        _.arrayAppendOnceStrictly( o.downloadedContainer, variant.opener.remotePath );
        return null;
      })
    }
    else
    {
      let o2 = _.mapOnly( o, variant.opener._remoteDownload.defaults );
      // debugger;
      let r = _.Consequence.From( variant.opener._remoteDownload( o2 ) );
      return r.then( ( downloaded ) =>
      {
        // debugger;
        _.assert( _.boolIs( downloaded ) );
        _.assert( _.strIs( variant.opener.remotePath ) );
        if( downloaded )
        _.arrayAppendOnceStrictly( o.downloadedContainer, variant.opener.remotePath );
        return downloaded;
      });
    }

  }

  /* */

  function variantLocalMaybe( variant )
  {

    if( variant.object.isRemote )
    return null;
    if( variant.peer && variant.peer.object && variant.peer.object.isRemote )
    return null;
    if( variant.object.root === variant.object )
    return null;

    // debugger;
    variantLocal( variant );
  }

  /* */

  function variantLocal( variant )
  {

    if( variant.localPath && _.strHas( variant.localPath, '.module' ) )
    debugger;

    if( variant.peer )
    {
      if( _.arrayHas( o.doneContainer, variant.peer.remotePath ) )
      return variantDone( variant );
      if( _.arrayHas( o.doneContainer, variant.peer.localPath ) )
      return variantDone( variant );
    }

    if( _.arrayHas( o.doneContainer, variant.opener.remotePath ) )
    return null;
    if( _.arrayHas( o.doneContainer, variant.opener.localPath ) )
    return null;

    _.assert( _.strIs( variant.localPath ) );
    _.arrayAppendOnce( o.localContainer, variant.localPath );

    return null;
  }

  /* */

  function variantDone( variant )
  {
    if( variant.localPath )
    _.arrayAppendOnce( o.doneContainer, variant.localPath );
    if( variant.remotePath )
    _.arrayAppendOnce( o.doneContainer, variant.remotePath );
    return null;
  }

  /* */

}

var defaults = _modulesDownload_body.defaults = Object.create( null );

defaults.mode = 'download';
defaults.strict = 1;
defaults.dry = 0;
defaults.modules = null;

defaults.downloadedContainer = null;
defaults.localContainer = null;
defaults.remoteContainer = null;
defaults.doneContainer = null;

let _modulesDownload = _.routineFromPreAndBody( _modulesDownload_pre, _modulesDownload_body );

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
  o.nodesGroup = will.graphGroupMake({ withPeers : 1 });

  _.assert( arguments.length === 1 );
  _.assertRoutineOptions( modulesDownload_body, arguments );

  o.modules = _.arrayAs( o.nodesGroup.nodesAddOnce( o.modules ) );
  _.assert( _.arrayIs( o.modules ) );

  let fitOpts = _.mapOnly( o, _.Will.prototype.moduleFit.defaults );
  fitOpts.withOut = false;
  o.modules = o.modules.filter( ( variant ) => will.moduleFit( variant, fitOpts ) );

  if( !o.modules.length )
  return _.Consequence().take( o );

  // logger.up();
  return download( o.modules )
  .finally( ( err, arg ) =>
  {
    // logger.down();
    if( err )
    debugger;
    if( err )
    throw _.err( err, '\nFailed to', ( o.mode ), 'submodules' );

    log();

    return o;
  });

  /* */

  function download( modules )
  {
    let ready = new _.Consequence().take( null );

    ready.then( () =>
    {
      return will.modulesUpform
      ({
        modules : modules,
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
      o2.modules = modules;
      modules = will.modulesEach( o2 );
      downloadedLengthWas = o.downloadedContainer.length;
      let o3 = _.mapOnly( o, will._modulesDownload.defaults );
      o3.modules = modules;
      return will._modulesDownload( o3 );
    });

    ready.then( ( o3 ) =>
    {
      let d = o.downloadedContainer.length - downloadedLengthWas;
      if( d > 0 && o.recursive >= 2 )
      return download( modules );
      return o;
    });

    return ready;
  }

  /* */

  function log()
  {
    if( !o.downloadedContainer.length && !o.loggingNoChanges )
    return;

    let total = ( o.remoteContainer.length + o.localContainer.length );
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
      logger.log( ' + ' + o.downloadedContainer.length + '/' + total + ' submodule(s)' + ' will be ' + phrase );
    }
    else
    {
      logger.log( ' + ' + o.downloadedContainer.length + '/' + total + ' submodule(s)' + ' were ' + phrase + ' in ' + _.timeSpent( time ) );
    }
    logger.rend({ verbosity : -2 });

  }

  /* */

}

var defaults = modulesDownload_body.defaults = _.mapExtend
(
  null,
  _.graph.AbstractNodesGroup.prototype.each.defaults,
  moduleFit.defaults,
  _modulesDownload.defaults
);

defaults.loggingNoChanges = 1;
defaults.recursive = 1;
defaults.withStem = 1;
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
  let visitedSet = new Set;

  o = _.routineOptions( modulesUpform, arguments );

  let o2 = _.mapOnly( o, will.modulesFor.defaults );
  o2.onEach = handleEach;
  return will.modulesFor( o2 )
  .finally( ( err, arg ) =>
  {
    if( err )
    throw _.err( err, `\nFailed to upform modules` );
    return arg;
  });

  /* */

  function handleEach( variant, op )
  {

    if( visitedSet.has( variant ) )
    return null;

    variant.reform();

    if( !variant.module && o.allowingMissing )
    return null;
    if( !variant.module )
    debugger;
    if( !variant.module )
    throw _.err
    (
        `Cant upform ${module.absoluteName} because ${variant.relation ? variant.relation.absoluteName : variant.opener.absoluteName} is not available.`
      , `\nLooked at ${variant.opener ? variant.opener.commonPath : variant.relation.path}`
    );

    visitedSet.add( variant );

    let o3 = _.mapOnly( o, variant.module.upform.defaults );
    return variant.module.upform( o3 );
  }

}

var defaults = modulesUpform.defaults = _.mapExtend( null, UpformingDefaults, modulesFor.defaults );

defaults.recursive = 2;
defaults.withStem = 1;
defaults.withPeers = 1;
// defaults.downloading = 0;
defaults.allowingMissing = 1;
defaults.all = 1;

delete defaults.outputFormat;
delete defaults.onUp;
delete defaults.onDown;
delete defaults.onNode;

// --
// variant
// --

function variantFrom( object )
{
  let will = this;
  _.assert( arguments.length === 1 );
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

// --
// graph
// --

function graphGroupMake( o )
{
  let will = this;

  o = _.routineOptions( graphGroupMake, arguments );

  // if( !o.variantMap )
  // o.variantMap = Object.create( null );

  let sys = new _.graph.AbstractGraphSystem
  ({
    onNodeIs : variantIs,
    onNodeFrom : variantFrom,
    onNodeNameGet : variantName,
    onOutNodesGet : variantSubmodules,
  });
  let group = sys.nodesGroup();

  return group;

  /* */

  function variantName( variant )
  {
    if( variant.module )
    return variant.module.qualifiedName;
    _.assert( !!variant.relation );
    return variant.relation.qualifiedName;
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
    return will.variantFrom( object );
  }

  /* */

  function variantSubmodules( variant )
  {
    let result = [];

    if( variant.module )
    for( let s in variant.module.submoduleMap )
    {
      let relation = variant.module.submoduleMap[ s ];

      if( !relation.enabled ) /* ttt */
      continue;

      let variant2 = variantFromRelation( relation );

      result.push( variant2 );

      if( o.withPeers && variant2.module && variant2.module.peerModule )
      {
        result.push( variantFromModule( variant2.module.peerModule ) );
      }

    }
    return result;
  }

  /* */

  function variantFromRelation( relation )
  {
    let variant;

    if( relation.opener )
    {
      variant = will.variantMap[ relation.opener.commonPath ];
      // variant = o.variantMap[ relation.opener.commonPath ];
    }
    else
    {
      debugger;
    }

    if( !variant )
    variant = variantFrom( relation );

    if( relation.opener )
    variant.opener = relation.opener;

    variant.relation = relation;
    return variant;
  }

  /* */

  function variantFromModule( module )
  {
    let variant;

    // variant = o.variantMap[ module.commonPath ];
    variant = will.variantMap[ module.commonPath ];

    if( !variant )
    variant = variantFrom( module );

    _.assert( !variant.module || variant.module === module );
    variant.module = module;
    return variant;
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

graphGroupMake.defaults =
{
  withPeers : 1,
  variantMap : null,
}

//

function graphTopologicalSort( modules )
{
  let will = this;

  _.assert( arguments.length === 0 || arguments.length === 1 )

  // let graph = will.graphGroupMake();
  // let group = graph.nodesGroup();
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

  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 )
  o = _.routineOptions( graphInfoExportAsTree, o );
  if( o.onNodeName === null )
  o.onNodeName = variantNameAndPath;
  if( o.onUp === null )
  o.onUp = variantUp;

  let group = will.graphGroupMake();

  modules = modules || will.modulesArray;
  modules = group.nodesFrom( modules );

  debugger;
  let o2 = _.mapOnly( o, group.rootsExportInfoTree.defaults );
  let info = group.rootsExportInfoTree( modules, o2 );
  debugger;

  return info;

  /* */

  function variantUp( variant, it )
  {
    // debugger;
    let module = variant.module || variant.opener;
    if( module )
    if( module.isOut && it.level !== 0 )
    {
      debugger;
      it.continueNode = false;
    }
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

var defaults = graphInfoExportAsTree.defaults = _.mapExtend( null, _.graph.AbstractNodesGroup.prototype.rootsExportInfoTree.defaults );

defaults.withLocalPath = 0;
defaults.withRemotePath = 0;

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

    // let isMain = o.opener.isMain;
    // if( o.isMain === null )
    // {
    //   if( will.mainOpener )
    //   o.isMain = will.mainOpener === o.opener;
    //   else
    //   o.isMain = true;
    // }

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

    // if( o.isMain !== null )
    // {
    //   o.opener.isMain = !!o.isMain;
    // }

    o.opener.preform()

    return o.opener;
  }
  catch( err )
  {
    debugger;

    // try
    // {
    //   if( madeOpener )
    //   {
    //     o.opener = null;
    //     madeOpener.finit();
    //   }
    // }
    // catch( err )
    // {
    //   throw _.err( `Failed to finit module\n`, err );
    // }

    if( o.throwing )
    throw _.err( err, `\nFailed to make module ${o.willfilesPath}` );

    return null;
  }
}

_openerMake_body.defaults =
{

  opener : null,
  throwing : 1,

  // willfilesPath : null,
  // isMain : null, // xxx : remove later
  // searching : null, // xxx : remove later

}

let _openerMake = _.routineFromPreAndBody( _openerMake_pre, _openerMake_body );

//

function openerMakeUser( o )
{
  let will = this;

  o = _.routineOptions( openerMakeUser, arguments );
  o.opener = o.opener || Object.create( null );
  o.opener.reason = o.opener.reason || 'user';
  if( o.willfilesPath )
  o.opener.willfilesPath = o.willfilesPath;

  delete o.willfilesPath;
  return will._openerMake( o );
}

var defaults = openerMakeUser.defaults = Object.create( _openerMake.defaults );

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

    if( !opener.isDownloaded )
    {
      debugger;
      opener.isDownloaded = true;
    }

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
    return false;
  });

  return will;
}

//

function openersErrorsRemoveAll()
{
  let will = this;
  _.assert( arguments.length === 0 );
  will.openersErrorsArray.splice( 0, will.openersErrorsArray.length );
}

// --
// willfile
// --

function readingBegin()
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
  // _.assert( will.mainModule === null || will.mainModule instanceof will.OpenedModule );
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
    let spent = _.timeSpentFormat( will.willfilesReadEndTime - will.willfilesReadBeginTime );
    logger.log( ' . Read', will.willfilesArray.length, 'willfile(s) in', spent, '\n' );
  }

}

//

function willfilesFind( o )
{
  let will = this;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  if( _.strIs( o ) )
  o = { dirPath : o }

  if( o.dirPath === '.' )
  o.dirPath = './';

  o.dirPath = path.normalize( o.dirPath );
  o.dirPath = _.strRemoveEnd( o.dirPath, '.' );
  o.dirPath = path.resolve( o.dirPath );

  _.routineOptions( willfilesFind, o );
  _.assert( arguments.length === 1 );
  _.assert( !!will.formed );
  _.assert( _.boolIs( o.recursive ) );
  _.assert( !path.isGlobal( path.fromGlob( o.dirPath ) ), 'Expects local path' );

  if( !o.tracing )
  return findFor( o.dirPath );

  let dirPaths = path.traceToRoot( o.dirPath );
  for( let d = dirPaths.length-1 ; d >= 0 ; d-- )
  {
    let dirPath = dirPaths[ d ];
    if( !path.isSafe( dirPath, 2 ) )
    continue;
    let result = findFor( path.trail( dirPath ) );
    if( result.length )
    return result;
  }

  return [];

  function findFor( dirPath )
  {

    let filter =
    {
      filePath : dirPath,
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

    if( !o.includingInFiles )
    filter.maskTerminal.includeAll.push( /(^|\.|\/)out(\.)/ )
    if( !o.includingOutFiles )
    filter.maskTerminal.excludeAny.push( /(^|\.|\/)out(\.)/ )

    if( !path.isGlob( dirPath ) )
    filter.recursive = o.recursive ? 2 : 1;

    let o2 =
    {
      filter : filter,
      maskPreset : 0,
      mandatory : 0,
      mode : 'distinct',
    }

    if( _.strHas( o.dirPath, 'out/submodule' ) )
    debugger;

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
        if( o.includingOutFiles && o.includingInFiles )
        {
          postfix += '?(out.)';
        }
        else if( o.includingInFiles )
        {
          postfix += '';
        }
        else if( o.includingOutFiles )
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

    // debugger;
    let files = fileProvider.filesFind( o2 );
    // debugger;
    //
    // if( files.length && _.strHas( files[ 0 ].absolute, 'out/submodule' ) )
    // debugger;

    return files;
  }
}

willfilesFind.defaults =
{
  dirPath : null,
  includingInFiles : 1,
  includingOutFiles : 1,
  exact : 0,
  recursive : false,
  tracing : false,
}

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
    let commonPath = will.AbstractModule.CommonPathFor( record.absolute );
    let array = commonPathMap[ commonPath ] = commonPathMap[ commonPath ] || [];
    _.arrayAppendOnce( array, record );
  });

  let commonPath = will.AbstractModule.CommonPathFor( record.absolute );
  let array = commonPathMap[ commonPath ] = commonPathMap[ commonPath ] || [];
  _.arrayAppendOnce( array, record );

  return array;
}

//

function willfileWithCommon( commonPath )
{
  let will = this;
  commonPath = will.AbstractModule.CommonPathFor( commonPath );
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

  // _.assert( will.willfileWithCommonPathMap[ willf.commonPath ] === willf );
  // delete will.willfileWithCommonPathMap[ willf.commonPath ];
  // _.assert( _.arrayCountElement( _.mapVals( will.willfileWithCommonPathMap ), willf ) === 0 );

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
  // _.assert( will.willfileWithCommonPathMap[ willf.commonPath ] === undefined );
  // will.willfileWithCommonPathMap[ willf.commonPath ] = willf;
  // _.assert( _.arrayCountElement( _.mapVals( will.willfileWithCommonPathMap ), willf ) === 1 );

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

let ResourceKinds = [ 'submodule', 'step', 'path', 'reflector', 'build', 'about', 'execution', 'exported' ];

let Defaults =
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
}

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
  filesGraph : null,
  logger : null,
  mainOpener : null,

}

let Restricts =
{

  formed : 0,
  willfilesReadBeginTime : null,
  willfilesReadEndTime : null,

  variantMap : _.define.own({}),
  objectToVariantHash : _.define.own( new HashMap ),
  modulesArray : _.define.own([]),
  moduleWithIdMap : _.define.own({}),
  moduleWithCommonPathMap : _.define.own({}),
  moduleWithNameMap : _.define.own({}),
  openersArray : _.define.own([]),
  openerModuleWithIdMap : _.define.own({}),
  openersErrorsArray : _.define.own([]),

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
  Defaults,
  UpformingDefaults,

}

let Forbids =
{
  mainModule : 'mainModule',
  recursiveExport : 'recursiveExport',
  graphGroup : 'graphGroup',
  graphSystem : 'graphSystem',
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

  // etc

  _verbosityChange,
  vcsFor,
  resourcesInfoExport,
  _pathChanged,
  versionGet,
  versionIsUpToDate,

  // defaults

  instanceDefaultsApply,
  instanceDefaultsSupplement,
  instanceDefaultsExtend,
  instanceDefaultsReset,
  prefer,

  // module

  moduleAt,
  moduleFit,
  moduleIdUnregister,
  moduleIdRegister,
  modulePathUnregister,
  modulePathRegister,

  modulesFindEachAt,
  modulesFindWithAt,
  modulesOnlyRoots,
  modulesEach,
  modulesFor,
  _modulesDownload,
  modulesDownload,
  modulesUpform,

  // variant

  variantFrom,
  variantsFrom,
  variantOf,
  variantsOf,

  // graph

  graphGroupMake,
  graphTopologicalSort,
  graphInfoExportAsTree,

  // opener

  _openerMake,
  openerMakeUser,
  openersAdoptModule,
  openerUnregister,
  openerRegister,
  openersErrorsRemoveOf,
  openersErrorsRemoveAll,

  // willfile

  readingBegin,
  readingEnd,

  _willfilesReadBegin,
  _willfilesReadEnd,
  _willfilesReadLog,

  willfilesFind,
  willfilesSelectPaired,
  willfileWithCommon,
  _willfileWithFilePath,
  willfileWithFilePath,
  willfileFor,
  willfileUnregister,
  willfileRegister,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

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
