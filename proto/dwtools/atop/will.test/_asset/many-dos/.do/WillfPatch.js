
function onEach( it )
{
  let _ = it.tools;
  let logger = it.logger;
  let willfPath = _.arrayAs( it.opener.willfilesPath );

  willfPath.forEach( ( willfPath ) =>
  {
    // pathExportAdd( it, willfPath );
    // pathExportUse( it, willfPath );
    // pathRemotesAdd( it, willfPath );
    // pathRemotesToOrigins( it, willfPath );
  });

}

module.exports = onEach;

//

function pathExportAdd( it, willfPath )
{
  let _ = it.tools;
  let logger = it.logger;
  let read = _.fileProvider.fileRead( willfPath );
  let regexp = new RegExp( '\\n(((?!\\n)\\s)*)(' + _.regexpEscape( `proto : '` ) + ')(.*?)\\n' );
  let splits = _.strIsolateLeftOrAll( read, regexp );

  if( !splits[ 2 ] )
  return;

  let match = read.match( regexp );
  let inside = match[ 0 ].replace( '\n', '' ).replace( '\n', '' );
  let pre = match[ 1 ];

  if( _.strHas( read, ` export : '` ) )
  return;

  logger.log( `Adding path::export to ${it.variant.locationExport()}` );

  splits.splice( 2, 0, `${pre}export : '{path::proto}/**'\n` );
  let write = splits.join( '' );

  // logger.log( write );

  if( it.request.map.dry )
  return;

  _.fileProvider.fileWrite( willfPath, write );
}

//

function pathExportUse( it, willfPath )
{
  let _ = it.tools;
  let logger = it.logger;
  let read = _.fileProvider.fileRead( willfPath );

  if( !_.strHas( read, 'export : path::proto' ) )
  return;

  let write = _.strReplace( read, 'export : path::proto', 'export : path::export' );
  logger.log( `Using path::export in ${it.variant.locationExport()}` );

  // logger.log( write );

  if( it.request.map.dry )
  return;

  _.fileProvider.fileWrite( willfPath, write );
}

//

function pathRemotesAdd( it, willfPath )
{
  let _ = it.tools;
  let logger = it.logger;
  let read = _.fileProvider.fileRead( willfPath );

  if( !it.module || !it.module.about.name )
  return;

  let line = _.encode.yamlLineFind( read, `repository : git+` );

  if( !line )
  return;

  logger.log( `Adding path::remotes to ${it.variant.locationExport()}` );

  let remotesPath =
  [
    `git+https:///github.com/Wandalen/${it.module.name}.git`,
    `npm:///${it.module.resolve({ selector : 'about::npm.name', missingAction : 'undefine' }) || it.module.name.toLowerCase()}`,
  ];

  let ins = `${line.pre}remotes :
${line.pre} - ${remotesPath[ 0 ]}
${line.pre} - ${remotesPath[ 1 ]}`

  let write = [ line.before, '\n', line.line, '\n', ins, '\n', line.after ].join( '' );

  // logger.log( write );

  if( it.request.map.dry )
  return;

  _.fileProvider.fileWrite( willfPath, write );
}

//

function pathRemotesToOrigins( it, willfPath )
{
  let _ = it.tools;
  let logger = it.logger;
  let read = _.fileProvider.fileRead( willfPath );

  if( !_.strHas( read, ' remotes :' ) )
  return;

  let write = _.strReplace( read, ' remotes :', ' origins :' );
  logger.log( `Replacing path::origins <- path::remotes ${it.variant.locationExport()}` );

  // logger.log( write );

  if( it.request.map.dry )
  return;

  _.fileProvider.fileWrite( willfPath, write );
}
