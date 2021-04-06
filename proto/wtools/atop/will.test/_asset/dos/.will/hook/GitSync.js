
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  // _.assert( _.lengthOf( context.request.map ) === 0 );

  /* read stats to fix for windows to update edit time of hard linked files */
  if( process.platform === 'win32' )
  fileProvider.filesFind({ filePath : context.junction.dirPath + '**', safe : 0 });

  let status = _.git.statusFull
  ({
    insidePath : context.junction.dirPath,
    prs : 0,
  });

  if( status.uncommitted )
  {
    let context2 = context.will.hookContextNew( context );
    if( !context2.request.subject )
    {
      context2.request.original = '-am "."';
      context2.request.subject = '-am "."';
    }
    context2.will.hooks.GitCommit.call( context2 );
  }

  if( status.remote )
  context.will.hooks.GitPull.call( context );

  if( status.local )
  context.will.hooks.GitPush.call( context );

  // {
  //   let context2 = context.will.hookContextNew( context );
  //   context2.request.map = { verbosity : 2 }
  //   context2.will.hooks.ProtoSync.call( context2 );
  // }

}

module.exports = onModule;
