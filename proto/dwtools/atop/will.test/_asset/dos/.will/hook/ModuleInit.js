
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let willfPath = _.arrayAs( it.opener.willfilesPath );

  if( o.verbosity )
  logger.log( `Module init of ${it.junction.nameWithLocationGet()}` );

  xxx

}

module.exports = onModule;
