
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let willfPath = _.array.as( context.opener.willfilesPath );

  willfPath.forEach( ( willfPath ) =>
  {
    let read = fileProvider.fileRead( willfPath );
    let write1 = _.yaml.commentOut( read, context.request.subject );
    if( write1 )
    {
      if( o.verbosity )
      logger.log( `Comment out "${context.request.subject}" in ${context.junction.nameWithLocationGet()}` );
      if( !o.dry )
      fileProvider.fileWrite( willfPath, write1 );
    }
  });

}

module.exports = onModule;
