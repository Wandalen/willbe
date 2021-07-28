
let aboutCache = Object.create( null );
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let abs = _.routine.join( path, path.join, [ context.junction.dirPath ] );
  let configPath = abs( 'package.json' );
  let wasСonfigPath = abs( 'was.package.json' );
  let wasPublished = null;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routine.options( onModule, o );

  if( o.org === null )
  o.org = [ 'srt', 'wtools' ];

  if( !context.junction.module )
  return;

  if( !o.tag )
  throw _.errBrief( 'Expects option {-tag-}' );

  if( !o.org )
  throw _.errBrief( 'Expects option {-org-}' );

  if( !o.npmUserName )
  throw _.errBrief( 'Expects option {-npmUserName-}' );

  if( !fileProvider.fileExists( wasСonfigPath ) )
  throw _.errBrief( `Does not have ${wasСonfigPath}` );

  if( !isEnabled( context, wasСonfigPath ) )
  return;

  let diff;

  {
    let context2 = context.will.hookContextNew( context );
    context2.request.subject = `-am "."`
    context2.request.original = context2.request.subject;
    delete context2.request.map.tag;
    delete context2.request.map.dry;
    delete context2.request.map.submodulesUpdating;
    delete context2.request.map.force;
    delete context2.request.map.org;
    delete context2.request.map.npmUserName;
    _.assert( context2.request.map !== context.request.map );
    context2.will.hooks.GitSync.call( context2 );
  }

  if( !o.force )
  {
    try
    {
      diff = _.git.diff
      ({
        state2 : '!' + o.tag,
        localPath : context.junction.dirPath,
        sync : 1,
      });
    }
    catch( err )
    {
      _.errAttend( err );
      logger.log( err );
    }
  }

  if( o.force || !diff || diff.status )
  {
    if( o.verbosity )
    logger.log( ` + Publishing ${context.junction.nameWithLocationGet()}` );
    if( o.verbosity >= 2 && diff && diff.status )
    {
      logger.up();
      logger.log( _.entity.exportStringNice( diff.status ) );
      logger.down();
    }
  }
  else
  {
    if( o.verbosity )
    logger.log( ` x Nothing to publish in ${context.junction.nameWithLocationGet()}` );
    return;
  }

  if( o.dry )
  return;

  fileProvider.filesDelete( abs( 'node_modules' ) );
  fileProvider.filesDelete( abs( 'package-lock.json' ) );

  let bumped = _.npm.fileBump
  ({
    dry : o.dry,
    configPath : wasСonfigPath,
    logger : o.verbosity - 4,
  });

  _.assert( path.isTrailed( context.junction.localPath ), 'not tested' );

  if( o.submodulesUpdating )
  context.start( 'will .imply withOut:0 .submodules.update' );
  // context.start( 'will .submodules.update' );
  context.start( 'will .export.purging' ); /* xxx */

  let activeСonfigPath = wasСonfigPath;
  if( !o.dry )
  {
    fileProvider.fileCopy( configPath, wasСonfigPath );
    activeСonfigPath = configPath;
  }

  _.npm.fileFixate
  ({
    dry : o.dry,
    localPath : context.junction.dirPath,
    configPath : activeСonfigPath,
    tag : o.tag,
    onDep,
    logger : o.verbosity - 2,
  });

  // /* adjust styles */
  // {
  //   context.start( `add-dependencies ${context.junction.dirPath}/package.json eslint@7.1.0 --dev` );
  //   let read = fileProvider.fileRead( `${context.junction.dirPath}/package.json` );
  //   read += '\n';
  //   fileProvider.fileWrite( `${context.junction.dirPath}/package.json`, read );
  // }

  {
    let context2 = context.will.hookContextNew( context );
    context2.request.subject = `-am "version ${bumped.config.version}"`
    context2.request.original = context2.request.subject;
    delete context2.request.map.tag;
    delete context2.request.map.dry;
    delete context2.request.map.submodulesUpdating;
    delete context2.request.map.force;
    delete context2.request.map.org;
    delete context2.request.map.npmUserName;
    context2.will.hooks.GitSync.call( context2 );
  }

  {
    let context2 = context.will.hookContextNew( context );
    context2.request.subject = '';
    context2.request.original = '';
    context2.request.map = { name : 'v' + bumped.config.version };
    context2.will.hooks.GitTag.call( context2 );
  }

  {
    let context2 = context.will.hookContextNew( context );
    context2.request.subject = '';
    context2.request.original = '';
    context2.request.map = { name : o.tag };
    context2.will.hooks.GitTag.call( context2 );
  }

  {
    let context2 = context.will.hookContextNew( context );
    context2.request.subject = '';
    context2.request.original = '';
    context2.will.hooks.GitPush.call( context2 );
  }

  _.npm.publish
  ({
    localPath : context.junction.dirPath,
    tag : o.tag,
    ready : context.ready,
    logger : o.verbosity === 2 ? 2 : o.verbosity -1,
  })

  {
    let context2 = context.will.hookContextNew( context );
    context2.request.map = { verbosity : 2 }
    context2.will.hooks.ProtoSync.call( context2 );
  }

  function onDep( dep )
  {
    // console.log( dep );

    if( dep.version )
    return;

    let about = aboutCache[ dep.name ];
    if( !about )
    about = aboutCache[ dep.name ] = _.npm.remoteAbout( dep.name );

    if( about )
    {
      let isOwner = false;

      if( about.org )
      {
        if( _.longHasAny( _.array.as( o.org ), about.org ) )
        isOwner = true;
      }
      else if( about._npmUser && about._npmUser.name === o.npmUserName )
      {
        isOwner = true;
      }

      if( isOwner )
      {
        dep.version = o.tag;
        return;
      }

      if( about.version )
      {
        dep.version = about.version;
      }
    }
  }

}

var defaults = onModule.defaults = Object.create( null );

defaults.tag = null;
defaults.v = null;
defaults.dry = 0;
defaults.submodulesUpdating = 0;
defaults.force = 0;
defaults.verbosity = 2;
defaults.org = null;
defaults.npmUserName = 'wandalen'

module.exports = onModule;

//

function isEnabled( context, localPath )
{
  let _ = context.tools;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  if( !_.strEnds( path.fullName( localPath ), '.json' ) )
  localPath = path.join( localPath, 'package.json' );
  let config = fileProvider.fileReadUnknown( localPath );
  if( !config.name )
  return false;
  if( config.enabled !== undefined && !config.enabled )
  return false;
  return true;
}
