
function onEach( it )
{
  let _ = it.tools;
  let logger = it.logger;
  let willfPath = _.arrayAs( it.opener.willfilesPath );

  willfPath.forEach( ( willfPath ) =>
  {
    let read = _.fileProvider.fileRead( willfPath );
    let write1 = _.encode.yamlCommentOut( read, it.request.subject );
    if( write1 )
    {
      logger.log( `Comment out "${it.request.subject}" in ${it.variant.locationExport()}` );
      if( !it.request.map.dry )
      _.fileProvider.fileWrite( willfPath, write1 );
    }
  });

}

module.exports = onEach;
