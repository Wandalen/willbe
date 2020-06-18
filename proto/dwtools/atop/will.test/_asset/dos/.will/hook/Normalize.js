
module.exports = onModule;

//

function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let inPath = it.module ? it.module.dirPath : it.opener.dirPath;

  badgeReplace( it );

}

//

function badgeReplace( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let inPath = it.module ? it.module.dirPath : it.opener.dirPath;

  if( !it.module )
  return

  if( !it.module.about.name )
  return

  if( !_.fileProvider.fileExists( _.path.join( inPath, 'README.md' ) ) )
  return;

  let config = _.fileProvider.configUserRead();
  let moduleName = it.module.about.name;
  let readmePath = _.path.join( inPath, 'README.md' );
  let read = _.fileProvider.fileRead( readmePath );
  let ins = `[![Build Status](https://travis-ci.org/${config.about.user}/${moduleName}.svg?branch=master)](https://travis-ci.org/${config.about.user}/${moduleName})`;
  let sub = `[![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}}/actions?query=workflow%3ATest)`;

  if( !_.strHas( read, ins ) )
  return;

  logger.log( `Replacing badge ${it.junction.nameWithLocationGet()}` );
  // debugger;
  logger.log( _.censor.replace( readmePath, ins, sub ).report );
  // // logger.log( _.strSearchReport( read, ins ).report );
  // debugger;

  if( o.dry )
  return;

}
