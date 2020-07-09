
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
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;
  if( !context.module.about.name )
  return;
  if( !context.module.about.enabled )
  return;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routineOptions( onModule, o );

  // hardLink( context, '.eslintrc.yml', '.eslintrc.yml' );
  // hardLink( context, 'proto/Integration.test.s', 'Integration.test.s' );
  // hardLink( context, '.github/workflows/Test.yml', 'hlink/.github/workflows/Test.yml' );
  // hardLink( context, '.circleci/config.yml', 'hlink/.circleci/config.yml' );

  workflowsReplace( context );

  // fileProvider.filesDelete({ filePath : abs( '.travis.yml' ), verbosity : o.verbosity >= 2 ? 3 : 0 });

  // samplesRename( context );
  // dwtoolsRename( context );

  badgeCiReplace( context );
  // badgesSwap( context );
  // badgeStabilityAdd( context );
  // badgeCircleCiAdd( context );
  // badgeCircleCiRemove( context );
  // badgeCircleCiReplace( context );

  // readmeModuleNameAdjust( context );

}

onModule.defaults =
{
  v : null,
  verbosity : 2,
  dry : 0,
}

//

function hardLink( context, dstPath, srcPath )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.path )
  return null;
  if( !config.path.proto || !config.path.module )
  return null;
  let protoPath = config.path.proto;
  if( !fileProvider.fileExists( protoPath ) )
  return null;

  let mpath = _.routineJoin( path, path.join, [ inPath ] );
  let ppath = _.routineJoin( path, path.join, [ protoPath ] );

  let moduleName = context.module.about.name;

  if( o.dry )
  return logger.log( filePath );

  fileProvider.hardLink
  ({
    dstPath : mpath( dstPath ),
    srcPath : ppath( srcPath ),
    allowingDiscrepancy : 0,
    makingDirectory : 1,
    verbosity : o.verbosity >= 2 ? o.verbosity : 0,
  });

  return true;
}

//

function workflowsReplace( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !fileProvider.fileExists( abs( '.github/workflows/Test.yml' ) ) )
  return;

  if( o.dry )
  return;

  logger.log( `Replacing workflows of ${context.junction.nameWithLocationGet()}` );

  hardLink( context, '.github/workflows/Publish.yml', 'hlink/.github/workflows/Publish.yml' );
  hardLink( context, '.github/workflows/PullRequest.yml', 'hlink/.github/workflows/PullRequest.yml' );
  hardLink( context, '.github/workflows/Push.yml', 'hlink/.github/workflows/Push.yml' );

  fileProvider.fileDelete( abs( '.github/workflows/Test.yml' ) );

}

//

function samplesRename( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'sample' ) ) )
  return;

  fileProvider.filesRename
  ({
    filePath : abs( 'sample/**' ),
    onRename : ( r, o ) => r.ext === 'js' ? r.path.changeExt( r.absolute, 's' ) : undefined,
    verbosity : o.verbosity >= 2 ? o.verbosity : 0,
  });

}

//

function dwtoolsRename( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'proto/wtools' ) ) )
  return;

  fileProvider.fileRename
  ({
    dstPath : abs( 'proto/wtools' ),
    srcPath : abs( 'proto/wtools' ),
    verbosity : o.verbosity >= 2 ? o.verbosity : 0,
  });

}

//

function badgeCiReplace( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;
  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user || !config.about.user )
  return null;

  if( !fileProvider.fileExists( abs( '.github/workflows/Publish.yml' ) ) )
  return;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `[![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;
  let sub = `[![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Publish/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3APublish)`;

  if( !_.strHas( read, ins ) )
  return false;

  logger.log( `Replacing CI badge ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return console.log( filePath );

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( 'README.md' ),
    ins,
    sub,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

  return true;
}

//

function badgeStabilityAdd( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user || !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let has = `badge/stability`;
  let ins = `[![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;
  let sub = `[![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`
          + ` [![experimental](https://img.shields.io/badge/stability-experimental-orange.svg)](https://github.com/emersion/stability-badges#experimental)`;

  if( _.strHas( read, has ) )
  return false;

  debugger;
  logger.log( `Adding stability badge ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return console.log( filePath );

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( 'README.md' ),
    ins,
    sub,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

  return true;
}

//

function badgeCircleCiAdd( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user || !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let has = `https://circleci.com/gh`;
  let ins = `[![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;
  let sub = `[![Status](https://img.shields.io/circleci/build/github/${config.about.user}/${moduleName}?label=Test&logo=Test)](https://circleci.com/gh/${config.about.user}/${moduleName}) [![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;

  if( _.strHas( read, has ) )
  return false;

  logger.log( `Adding CircleCI badge ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return console.log( filePath );

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( 'README.md' ),
    ins,
    sub,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

  return true;
}

//

function badgeCircleCiRemove( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user || !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `[![Status](https://img.shields.io/circleci/build/github/${config.about.user}/${moduleName}?label=Test&logo=Test)](https://circleci.com/gh/${config.about.user}/${moduleName})`;
  let sub = ``;

  debugger;
  if( !_.strHas( read, ins ) )
  return false;

  logger.log( `Removing CircleCI badge ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return console.log( filePath );

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( 'README.md' ),
    ins,
    sub,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

  return true;
}

//

function badgeCircleCiReplace( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user || !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `[![Status](https://circleci.com/gh/${config.about.user}/${moduleName}.svg?style=shield)](https://img.shields.io/circleci/build/github/${config.about.user}/${moduleName}?label=Test&logo=Test)`;
  let sub = `[![Status](https://img.shields.io/circleci/build/github/${config.about.user}/${moduleName}?label=Test&logo=Test)](https://circleci.com/gh/${config.about.user}/${moduleName})`;

  if( !_.strHas( read, ins ) )
  return false;

  logger.log( `Replacing CircleCI badge ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return console.log( filePath );

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( 'README.md' ),
    ins,
    sub,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

  return true;
}

//

function badgesSwap( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user || !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `[![experimental](https://img.shields.io/badge/stability-experimental-orange.svg)](https://github.com/emersion/stability-badges#experimental) [![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;
  let sub = `[![Status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest) [![experimental](https://img.shields.io/badge/stability-experimental-orange.svg)](https://github.com/emersion/stability-badges#experimental)`;

  if( !_.strHas( read, ins ) )
  return;

  logger.log( `Swaping badges ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return console.log( filePath );

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( 'README.md' ),
    ins,
    sub,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

}

//

function readmeModuleNameAdjust( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user || !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let shortModuleName = _.strDesign( moduleName );

  if( shortModuleName === moduleName )
  return;

  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let has = `# ${moduleName}`;

  debugger;
  if( !_.strHas( read, has ) )
  return false;

  logger.log( `Adjusting name of module in readme of ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return console.log( filePath );

  {
    let ins = `# ${moduleName}  [`;
    let sub = `# module::${shortModuleName}  [`;
    logger.log( _.censor.fileReplace
    ({
      filePath : abs( 'README.md' ),
      ins,
      sub,
      verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
    }).log );
  }

  {
    let ins = `# ${moduleName} [`;
    let sub = `# module::${shortModuleName} [`;
    logger.log( _.censor.fileReplace
    ({
      filePath : abs( 'README.md' ),
      ins,
      sub,
      verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
    }).log );
  }

  return true;
}
