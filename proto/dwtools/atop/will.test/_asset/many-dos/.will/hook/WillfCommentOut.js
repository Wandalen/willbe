
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let willfPath = _.arrayAs( it.opener.willfilesPath );

  willfPath.forEach( ( willfPath ) =>
  {
    let read = _.fileProvider.fileRead( willfPath );
    let write1 = _.yaml.commentOut( read, it.request.subject );
    if( write1 )
    {
      if( o.verbosity )
      logger.log( `Comment out "${it.request.subject}" in ${it.variant.nameWithLocationGet()}` );
      if( !o.dry )
      _.fileProvider.fileWrite( willfPath, write1 );
    }
  });

}

module.exports = onModule;
