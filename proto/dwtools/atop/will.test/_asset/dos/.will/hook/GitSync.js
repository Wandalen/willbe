
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  _.fileProvider.filesFind({ filePath : it.junction.dirPath + '**', safe : 0 });

  let status = _.git.statusFull
  ({
    insidePath : it.junction.dirPath,
  });

  if( status.uncommitted )
  it.will.hooks.GitCommit.call( it );

  if( status.remote )
  it.will.hooks.GitPull.call( it );

  if( status.local )
  it.will.hooks.GitPush.call( it );

}

module.exports = onModule;
