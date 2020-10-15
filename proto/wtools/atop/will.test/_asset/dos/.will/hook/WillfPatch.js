
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let willfPath = _.arrayAs( context.opener.willfilesPath );

  willfPath.forEach( ( willfPath ) =>
  {
    // pathTmpRelace( context, willfPath );
    // pathExportExportReplace( context, willfPath );
    pathExportAdd( context, willfPath );
    // pathExportUse( context, willfPath );
    // pathRemotesAdd( context, willfPath );
    // pathRemotesToOrigins( context, willfPath );
  });

}

module.exports = onModule;

//

function pathTmpRelace( context, willfPath )
{
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let logger = context.logger;
  let read = fileProvider.fileRead( willfPath );

  let ins = `temp : 'path::out'`;
  let sub =
`
  temp :
    - 'path::out'
    - 'package-lock.json'
    - 'package.json'
    - 'node_modules'
`
  if( !_.strHas( read, ins ) )
  return;

  let write = read.replace( ins, sub.trim() );

  if( o.verbosity )
  logger.log( `Replacing tmp in ${context.junction.nameWithLocationGet()}` );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
  return;

  fileProvider.fileWrite( willfPath, write );
}

//

let logger = context.logger;
let fileProvider = context.will.fileProvider;
let path = context.will.fileProvider.path;Replace( context, willfPath )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let read = fileProvider.fileRead( willfPath );

  if( !_.strHas( read, `export : '{path::export}` ) )
  return;

  let splits = _.strSplitFast( read, `export : '{path::export}` ); debugger;
  _.assert( splits.length === 3 );
  splits[ 1 ] = `export : '{path::proto}`;
  let write = splits.join( '' );

  if( o.verbosity )
  logger.log( `Replacing "export : {path::export}" in ${context.junction.nameWithLocationGet()}` );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
  return;

  fileProvider.fileWrite( willfPath, write );
}

function pathExportAdd( context, willfPath )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let read = fileProvider.fileRead( willfPath );
  let regexp = new RegExp( '\\n(((?!\\n)\\s)*)(' + _.regexpEscape( `proto : '` ) + ')(.*?)\\n' );
  let splits = _.strIsolateLeftOrAll( read, regexp );

  if( !splits[ 2 ] )
  return;

  let match = read.match( regexp );
  let inside = match[ 0 ].replace( '\n', '' ).replace( '\n', '' );
  let head = match[ 1 ];

  if( _.strHas( read, ` export : '` ) )
  return;

  if( o.verbosity )
  logger.log( `Adding path::export to ${context.junction.nameWithLocationGet()}` );

  splits.splice( 2, 0, `${head}export : '{path::proto}/**'\n` );
  let write = splits.join( '' );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
  return;

  fileProvider.fileWrite( willfPath, write );
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
}

//

function pathExportUse( context, willfPath )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let read = fileProvider.fileRead( willfPath );

  if( !_.strHas( read, 'export : path::proto' ) )
  return;

  let write = _.strReplace( read, 'export : path::proto', 'export : path::export' );

  if( o.verbosity )
  logger.log( `Using path::export in ${context.junction.nameWithLocationGet()}` );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
  return;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  fileProvider.fileWrite( willfPath, write );
}

//

function pathRemotesAdd( context, willfPath )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let read = fileProvider.fileRead( willfPath );

  if( !context.module || !context.module.about.name )
  return;

  let line = _.yaml.lineFind( read, `repository : git+` );

  if( !line )
  return;

  if( o.verbosity )
  logger.log( `Adding path::remotes to ${context.junction.nameWithLocationGet()}` );

  let remotesPath =
  [
    `git+https:///github.com/Wandalen/${context.module.name}.git`,
    `npm:///${context.module.resolve({ selector : 'about::npm.name', missingAction : 'undefine' }) || context.module.name.toLowerCase()}`,
  ];

  let ins = `${line.head}remotes :
${line.head} - ${remotesPath[ 0 ]}
${line.head} - ${remotesPath[ 1 ]}`

  let write = [ line.before, '\n', line.line, '\n', ins, '\n', line.after ].join( '' );

  if( o.verbosity >= 2 )
  logger.log( write );

  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  return;

  fileProvider.fileWrite( willfPath, write );
}

//

function pathRemotesToOrigins( context, willfPath )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let read = fileProvider.fileRead( willfPath );

  if( !_.strHas( read, ' remotes :' ) )
  return;

  let write = _.strReplace( read, ' remotes :', ' origins :' );

  if( o.verbosity )
  logger.log( `Replacing path::origins <- path::remotes ${context.junction.nameWithLocationGet()}` );

  if( o.verbosity >= 2 )
  logger.log( write );

  if( o.dry )
  return;

  fileProvider.fileWrite( willfPath, write );
}

