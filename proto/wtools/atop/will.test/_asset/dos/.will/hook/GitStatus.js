
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  /* read stats to fix for windows to update edit time of hard linked files */
  if( process.platform === 'win32' )
  fileProvider.filesFind({ filePath : context.junction.dirPath + '**', safe : 0 });

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routine.options( onModule, o );

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();
  let token = null;
  if( config !== null && config.about && config.about[ 'github.token' ] )
  token = config.about[ 'github.token' ];

  let o2 = _.mapOnly_( null, o, _.git.statusFull.defaults );
  o2.insidePath = context.junction.dirPath;
  if( !o2.token )
  o2.token = token;
  let got = _.git.statusFull( o2 );

  if( !got.status )
  return null;

  logger.log( context.junction.nameWithLocationGet() );
  logger.log( got.status );

}

var defaults = onModule.defaults = Object.create( null );

defaults.local = 1;
defaults.uncommitted = null;
defaults.uncommittedUntracked = null;
defaults.uncommittedAdded = null;
defaults.uncommittedChanged = null;
defaults.uncommittedDeleted = null;
defaults.uncommittedRenamed = null;
defaults.uncommittedCopied = null;
defaults.uncommittedIgnored = 0;
defaults.unpushed = null;
defaults.unpushedCommits = null;
defaults.unpushedTags = null;
defaults.unpushedBranches = null;
defaults.remote = 1;
defaults.remoteCommits = null;
defaults.remoteBranches = 0;
defaults.remoteTags = null;
defaults.prs = 1;
defaults.v = null;
defaults.verbosity = 1;
defaults.token = null;

module.exports = onModule;
