
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

  let o2 = _.mapOnly_( null, o, _.git.statusFull.defaults );
  o2.insidePath = context.junction.dirPath;
  let status = _.git.statusFull( o2 );

  if( !status.status )
  return null;

  logger.log( context.junction.nameWithLocationGet() );
  logger.log( status.status );

}

var defaults = onModule.defaults = Object.create( null );

defaults.local = 0;
defaults.uncommitted = 1;
defaults.uncommittedUntracked = null;
defaults.uncommittedAdded = null;
defaults.uncommittedChanged = null;
defaults.uncommittedDeleted = null;
defaults.uncommittedRenamed = null;
defaults.uncommittedCopied = null;
defaults.uncommittedIgnored = 0;
defaults.unpushed = 0;
defaults.unpushedCommits = null;
defaults.unpushedTags = null;
defaults.unpushedBranches = null;
defaults.remote = 0;
defaults.remoteCommits = null;
defaults.remoteBranches = 0;
defaults.remoteTags = null;
defaults.prs = 0;
defaults.v = null;
defaults.verbosity = 1;

module.exports = onModule;
