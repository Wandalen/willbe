
module.exports = onModule;

//

function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;

  badgeReplace( context );

}

//

function badgeReplace( context )
{
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let logger = context.logger;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;

  if( !context.module )
  return

  if( !context.module.about.name )
  return

  if( !fileProvider.fileExists( path.join( inPath, 'README.md' ) ) )
  return;

  let config = fileProvider.configUserRead();
  let moduleName = context.module.about.name;
  let readmePath = path.join( inPath, 'README.md' );
  let read = fileProvider.fileRead( readmePath );
  let ins = `[![Build Status](https://travis-ci.org/${config.about.user}/${moduleName}.svg?branch=master)](https://travis-ci.org/${config.about.user}/${moduleName})`;
  let sub = `[![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}}/actions?query=workflow%3ATest)`;

  if( !_.strHas( read, ins ) )
  return;

  logger.log( `Replacing badge ${context.junction.nameWithLocationGet()}` );
  logger.log( _.censor.fileReplace( readmePath, ins, sub ).log );

  if( o.dry )
  return;

}
