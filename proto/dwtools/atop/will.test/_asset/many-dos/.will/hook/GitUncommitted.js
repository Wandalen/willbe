
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  _.fileProvider.filesFind( it.variant.dirPath + '**' );

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  let status = _.git.infoStatus
  ({
    insidePath : it.variant.dirPath,
    local : o.local,
    uncommitted : o.uncommitted,
    unpushed : o.unpushed,
    remote : o.remote,
    prs : o.prs,
  });

  if( !status.info )
  return null;

  logger.log( it.variant.nameWithLocationGet() );
  logger.log( status.info );

}

onModule.defaults =
{
  local : 0,
  unpushed : 0,
  uncommitted : 1,
  remote : 0,
  prs : 0,
  v : null,
  verbosity : 1,
}

module.exports = onModule;
