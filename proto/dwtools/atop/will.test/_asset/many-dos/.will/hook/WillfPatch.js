
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let willfPath = _.arrayAs( it.opener.willfilesPath );

  willfPath.forEach( ( willfPath ) =>
  {
    // pathExportAdd( it, willfPath );
    // pathExportUse( it, willfPath );
    // pathRemotesAdd( it, willfPath );
    // pathRemotesToOrigins( it, willfPath );
    pathExportExportReplace( it, willfPath );
  });

}

module.exports = onModule;

//

function pathExportExportReplace( it, willfPath )
{
  let _ = it.tools;
  let logger = it.logger;
  let read = _.fileProvider.fileRead( willfPath );

  if( !_.strHas( read, `export : '{path::export}` ) )
  return;

  if( o.verbosity )
  logger.log( `Replacing "export : {path::export}" in ${it.variant.nameWithLocationGet()}` );

  let splits = _.strSplitFast( read, `export : '{path::export}` ); debugger;
  _.assert( splits.length === 3 );
  splits[ 1 ] = `export : '{path::proto}`;
  let write = splits.join( '' );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
  return;

  _.fileProvider.fileWrite( willfPath, write );
}

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

  if( o.verbosity )
  logger.log( `Adding path::export to ${it.variant.nameWithLocationGet()}` );

  splits.splice( 2, 0, `${pre}export : '{path::proto}/**'\n` );
  let write = splits.join( '' );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
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

  if( o.verbosity )
  logger.log( `Using path::export in ${it.variant.nameWithLocationGet()}` );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
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

  let line = _.yaml.lineFind( read, `repository : git+` );

  if( !line )
  return;

  if( o.verbosity )
  logger.log( `Adding path::remotes to ${it.variant.nameWithLocationGet()}` );

  let remotesPath =
  [
    `git+https:///github.com/Wandalen/${it.module.name}.git`,
    `npm:///${it.module.resolve({ selector : 'about::npm.name', missingAction : 'undefine' }) || it.module.name.toLowerCase()}`,
  ];

  let ins = `${line.pre}remotes :
${line.pre} - ${remotesPath[ 0 ]}
${line.pre} - ${remotesPath[ 1 ]}`

  let write = [ line.before, '\n', line.line, '\n', ins, '\n', line.after ].join( '' );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
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

  if( o.verbosity )
  logger.log( `Replacing path::origins <- path::remotes ${it.variant.nameWithLocationGet()}` );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
  return;

  _.fileProvider.fileWrite( willfPath, write );
}
