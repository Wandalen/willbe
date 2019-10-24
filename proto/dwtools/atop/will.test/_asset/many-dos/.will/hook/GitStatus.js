
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  _.fileProvider.filesFind( it.variant.dirPath + '**' );

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  // debugger;
  let got = _.git.infoStatus
  ({
    insidePath : it.variant.dirPath,
    local : o.local,
    uncommitted : o.uncommitted,
    unpushed : o.unpushed,
    remote : o.remote,
    prs : o.prs,
  });
  debugger;

  if( !got.status )
  return null;

  logger.log( it.variant.nameWithLocationGet() );
  logger.log( got.status );

}

onModule.defaults =
{
  local : 1,
  unpushed : null,
  uncommitted : null,
  remote : 1,
  prs : 1,
  v : null,
  verbosity : 1,
}

module.exports = onModule;
