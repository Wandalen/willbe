
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  _.fileProvider.filesFind( it.junction.dirPath + '**' );

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  let o2 = _.mapOnly( o, _.git.statusFull.defaults );
  o2.insidePath = it.junction.dirPath;
  let status = _.git.statusFull( o2 );

  if( !status.status )
  return null;

  logger.log( it.junction.nameWithLocationGet() );
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
