
module.exports = onModule;

//

function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;
  if( !context.module.about.name )
  return;
  // if( !context.module.about.enabled )
  // return;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routine.options( onModule, o );

  // hardLinkFromProto( context, '.eslintrc.yml', '.eslintrc.yml' );
  // hardLinkFromProto( context, 'proto/Integration.test.s', 'Integration.test.s' );
  // hardLinkFromProto( context, '.github/workflows/Test.yml', 'common/.github/workflows/Test.yml' );
  // hardLinkFromProto( context, '.circleci/config.yml', 'common/.circleci/config.yml' );

  // repoProgramsNormalize( context );
  // repoProgramsReplace( context );
  // repoProgramsDelete( context );
  // gitIgnorePatch( context );
  // gitIgnoreReplace( context );

  // fileProvider.filesDelete({ filePath : abs( '.travis.yml' ), verbosity : o.verbosity >= 2 ? 3 : 0 });
  // fileProvider.filesDelete({ filePath : abs( '**/.DS_Store' ), verbosity : o.verbosity >= 2 ? 3 : 0, writing : !o.dry });
  // fileProvider.filesDelete({ filePath : abs( 'appveyor.yml' ), verbosity : o.verbosity >= 2 ? 3 : 0, writing : !o.dry });
  // fileRenameTools( context );

  // integrationTestRename( context );
  // samplesRename( context );
  // dwtoolsRename( context );
  // metaFilesRename( context );

  // badgeGithubReplace( context );
  // badgesSwap( context );
  // badgeStabilityAdd( context );
  // badgeCircleCiAdd( context );
  // badgeCircleCiRemove( context );
  // badgeCircleCiReplace( context );

  // npmDepRemoveSelf( context );
  // npmDepAddFileNodeModulesEntry( context );
  // npmEntryPathAdjust( context );
  // npmFilesDeleteTools( context );
  // willProtoEntryPathFromNpm( context );
  // willProtoEntryPathOrder( context );
  // willProtoEntryPathAdjustTools( context );
  // willDisableIfEmpty( context );
  willFixDmytrosFuckup( context );
  // deleteIfDisabled( context );

  // readmeModuleNameAdjust( context );
  // readmeTryOutAdjust( context );
  // readmeToAddRemove( context );
  // readmeInstructionsAdjust( context );
  // readmeSampleRename( context );

  // sourceNodeModulesEntryAdd( context );
  // sourcesRemoveOld( context );
  // sourcesRemoveOld2( context );
  // sampleFix( context );
  // sampleTrivial( context );

  // context.start( 'censor.local .hlink' );
}

onModule.defaults =
{
  v : null,
  verbosity : 2,
  dry : 0,
}

//

function protoPathGet()
{
  let _ = _global_.wTools;
  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let protoPath = _.censor.configGet({ selector : 'path/proto' });
  if( !_.fileProvider.fileExists( protoPath ) )
  return null;
  return protoPath;
}

//

function hardLinkFromProto( context, dstPath, srcPath )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let protoPath = protoPathGet();

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  // if( !config )
  // return null;
  // if( !config.path )
  // return null;
  // if( !config.path.proto || !config.path.module )
  // return null;
  // let protoPath = config.path.proto;
  // if( !fileProvider.fileExists( protoPath ) )
  // return null;

  let mpath = _.routineJoin( path, path.join, [ inPath ] );
  let ppath = _.routineJoin( path, path.join, [ protoPathGet() ] );

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

function repoProgramsNormalize( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );
  let pabs = _.routineJoin( path, path.join, [ protoPathGet() ] );

  if( !fileProvider.isDir( abs( '.github/workflows' ) ) )
  return;

  let nameOfCollection = nameOfCollectionGet();

  logger.log( `Replacing repo programs of ${context.junction.nameWithLocationGet()} by ${_.ct.format( nameOfCollection, 'entity' )} collection` );

  if( !o.dry )
  {
    fileProvider.filesDelete( abs( '.github/workflows/PullRequest.yml' ) );
    fileProvider.filesDelete( abs( '.github/workflows/Publish.yml' ) );
    fileProvider.filesDelete( abs( '.github/workflows/Push.yml' ) );
  }

  programHlink( 'Publish' );
  programHlink( 'PullRequest' );
  programHlink( 'Push' );

  function programHlink( nameOfFile )
  {
    if( fileProvider.isTerminal( pabs( `common/.github/workflows/${nameOfCollection}${nameOfFile}.yml` ) ) )
    hardLinkFromProto( context, `.github/workflows/${nameOfCollection}${nameOfFile}.yml`, `common/.github/workflows/${nameOfCollection}${nameOfFile}.yml` );
  }

  function nameOfCollectionGet()
  {
    let files = fileProvider.dirRead( abs( '.github/workflows' ) );
    for( let f = 0 ; f < files.length ; f++ )
    {
      let file = files[ f ];
      if( _.strEnds( file, 'Push.yml' ) )
      {
        let name = _.strRemoveEnd( file, 'Push.yml' );
        if( name === '' )
        return 'Standard';
        return name;
      }
    }
  }

}

//

function repoProgramsReplace( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !fileProvider.fileExists( abs( '.github/workflows/Test.yml' ) ) )
  return;

  if( o.dry )
  return;

  logger.log( `Replacing workflows of ${context.junction.nameWithLocationGet()}` );

  hardLinkFromProto( context, '.github/workflows/Publish.yml', 'common/.github/workflows/Publish.yml' );
  hardLinkFromProto( context, '.github/workflows/PullRequest.yml', 'common/.github/workflows/PullRequest.yml' );
  hardLinkFromProto( context, '.github/workflows/Push.yml', 'common/.github/workflows/Push.yml' );

  fileProvider.fileDelete( abs( '.github/workflows/Test.yml' ) );

}

//

function repoProgramsDelete( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !fileProvider.fileExists( abs( '.github/workflows/Publish.yml' ) ) )
  return;

  logger.log( `Deleting workflows ${abs( '.github/workflows/Publish.yml' )}` );

  if( o.dry )
  return;

  fileProvider.fileDelete( abs( '.github/workflows/Publish.yml' ) );

}

//

function gitIgnorePatch( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !fileProvider.isTerminal( abs( '.gitignore' ) ) )
  return;

  let ins = /^node_modules$/m;
  let sub = '/node_modules';
  let read = fileProvider.fileRead( abs( '.gitignore' ) );
  if( !_.strHas( read, ins ) )
  return;

  if( o.dry )
  logger.log( `Patching ${context.junction.nameWithLocationGet()}` );

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( '.gitignore' ),
    ins,
    sub,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

}

//

function gitIgnoreReplace( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !fileProvider.fileExists( abs( '.gitignore' ) ) )
  return;

  if( o.dry )
  return;

  logger.log( `Replacing gitignore of ${context.junction.nameWithLocationGet()}` );

  hardLinkFromProto( context, '.gitignore', 'hlink/.gitignore' );

}

//

function fileRenameTools( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;

  let toolsPath = abs( 'proto/node_modules/Tools' );
  let toolsPath2 = abs( 'proto/node_modules/Tools' );

  if( !fileProvider.fileExists( toolsPath ) )
  return;

  fileProvider.fileRename( toolsPath2, toolsPath );

}

//

function integrationTestRename( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'sample' ) ) )
  return;

  if( !o.dry )
  if( fileProvider.fileExists( abs( 'proto/Integration.test.s' ) ) )
  fileProvider.fileRename({ dstPath : abs( 'proto/Integration.test.ss' ), srcPath : abs( 'proto/Integration.test.s' ), verbosity : o.verbosity >= 2 ? 3 : 0 });

}

//

function samplesRename( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
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
  let inPath = context.junction.dirPath;
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

function metaFilesRename( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return

  if( fileProvider.fileExists( abs( 'README.md' ) ) )
  fileProvider.fileRename
  ({
    dstPath : abs( 'Readme.md' ),
    srcPath : abs( 'README.md' ),
    verbosity : o.verbosity >= 2 ? o.verbosity : 0,
  });

  if( fileProvider.fileExists( abs( 'LICENSE' ) ) )
  fileProvider.fileRename
  ({
    dstPath : abs( 'License' ),
    srcPath : abs( 'LICENSE' ),
    verbosity : o.verbosity >= 2 ? o.verbosity : 0,
  });

}

//

function badgeGithubReplace( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;
  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
  return null;

  if( !fileProvider.fileExists( abs( '.github/workflows/Publish.yml' ) ) )
  return;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `[![status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;
  let sub = `[![status](https://github.com/${config.about.user}/${moduleName}/workflows/Publish/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions/workflows/StandardPublish.yml)`;

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
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let has = `badge/stability`;
  let ins = `[![status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;
  let sub = `[![status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`
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
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let has = `https://circleci.com/gh`;
  let ins = `[![status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;
  let sub = `[![status](https://img.shields.io/circleci/build/github/${config.about.user}/${moduleName}?label=Test&logo=Test)](https://circleci.com/gh/${config.about.user}/${moduleName}) [![status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;

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
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );

  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `[![status](https://img.shields.io/circleci/build/github/${config.about.user}/${moduleName}?label=Test&logo=Test)](https://circleci.com/gh/${config.about.user}/${moduleName})`;
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
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `[![status](https://circleci.com/gh/${config.about.user}/${moduleName}.svg?style=shield)](https://img.shields.io/circleci/build/github/${config.about.user}/${moduleName}?label=Test&logo=Test)`;
  let sub = `[![status](https://img.shields.io/circleci/build/github/${config.about.user}/${moduleName}?label=Test&logo=Test)](https://circleci.com/gh/${config.about.user}/${moduleName})`;

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
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `[![experimental](https://img.shields.io/badge/stability-experimental-orange.svg)](https://github.com/emersion/stability-badges#experimental) [![status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest)`;
  let sub = `[![status](https://github.com/${config.about.user}/${moduleName}/workflows/Test/badge.svg)](https://github.com/${config.about.user}/${moduleName}/actions?query=workflow%3ATest) [![experimental](https://img.shields.io/badge/stability-experimental-orange.svg)](https://github.com/emersion/stability-badges#experimental)`;

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

function npmDepRemoveSelf( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  let configPath = abs( 'was.package.json' );
  let name = _.npm.fileReadName({ configPath });
  if( !name )
  return;

  _.npm.depRemove
  ({
    configPath,
    depPath : name,
    dry : o.dry,
    verbosity : o.verbosity - 1,
  });

}

//

function npmDepAddFileNodeModulesEntry( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  let protoPath = abs( 'proto' );
  if( !protoPath )
  return;

  let configPath = abs( 'was.package.json' );
  let name = _.npm.fileReadName({ configPath });
  if( !name )
  return;

  let includePath = path.join( protoPath, 'node_modules', name );
  if( !fileProvider.fileExists( includePath ) )
  {
    console.error( `File ${includePath} does not exists` );
    return;
  }

  let relativeIncludeDirPath = path.relative( inPath, path.dir( includePath ) );

  let files = _.npm.fileReadFilePath({ configPath });

  if( !files && !files.length )
  return;

  if( o.dry )
  return;

  _.npm.fileAddfilePath
  ({
    configPath,
    filePath : relativeIncludeDirPath,
    dry : o.dry,
    verbosity : o.verbosity - 1,
  });

}

//

function npmEntryPathAdjust( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;

  let configPath = abs( 'was.package.json' );
  let name = _.npm.fileReadName({ configPath });
  if( !name )
  return;

  let protoPath = abs( 'proto' );
  let includePath = path.join( protoPath, 'node_modules', name );

  _.npm.fileWriteField
  ({
    key : 'main',
    val : path.relative( inPath, includePath ),
    configPath,
    dry : o.dry,
    logger : o.verbosity - 1,
  });

}

//

function npmFilesDeleteTools( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;

  let configPath = abs( 'was.package.json' );
  let filesPath = _.npm.fileReadField({ configPath, key : 'files' });
  if( !filesPath )
  return;

  filesPath = _.filter_( filesPath, ( filePath ) =>
  {
    if( abs( filePath ) !== abs( 'proto/node_modules/Tools' ) )
    return filePath;
    return;
  });

  _.npm.fileWriteField
  ({
    key : 'files',
    val : filesPath,
    configPath,
    dry : o.dry,
    logger : o.verbosity - 1,
  });

}

//

function willProtoEntryPathFromNpm( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;

  let configPath = abs( 'was.package.json' );
  let name = _.npm.fileReadName({ configPath });
  if( !name )
  return;

  let entryPath = _.npm.fileReadEntryPath({ configPath });
  if( !entryPath )
  return;
  entryPath = abs( entryPath );

  let protoPath = abs( 'proto' );
  let includePath = path.join( protoPath, 'node_modules', name );

  _.will.fileWriteResource
  ({
    commonPath : context.module.commonPath,
    resourceKind : 'path',
    resourceName : 'npm.proto.entry',
    withExport : 0,
    val : [ entryPath, includePath ],
  });

  let protoEntryPath = _.will.fileReadPath( context.module.commonPath, 'npm.proto.entry' );
  console.log( `protoEntryPath : ${protoEntryPath}` );

}

//

function willProtoEntryPathOrder( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;

  // - adjust :
  //     npm.proto.entry:
  //       - proto/wtools/amid/bufferFromFile/Main.ss
  //       - proto/node_modules/bufferfromfile
  // npm.proto.entry:
  //   - proto/node_modules/Tools
  //   - proto/node_modules/wimagereaderdds

  let protoEntryPath = _.will.fileReadPath( context.module.commonPath, 'npm.proto.entry' );

  if( !protoEntryPath )
  return;

  let pependArray = [];
  _.each( protoEntryPath, ( entryPath ) =>
  {
    if( _.strBegins( entryPath, 'proto/node_modules' ) )
    if( !_.strEnds( entryPath, 'node_modules/Tools' ) )
    pependArray.push();
  });

  _.each( protoEntryPath.slice(), ( entryPath ) =>
  {
    _.arrayRemove( protoEntryPath, entryPath );
    _.arrayPrepend( protoEntryPath, entryPath );
  });

  console.log( `${protoEntryPath}` );

  _.will.fileWriteResource
  ({
    commonPath : context.module.commonPath,
    resourceKind : 'path',
    resourceName : 'npm.proto.entry',
    withExport : 0,
    val : protoEntryPath,
  });

}

//

function willProtoEntryPathAdjustTools( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;

  let protoEntryPath = _.will.fileReadPath( context.module.commonPath, 'npm.proto.entry' );
  if( !protoEntryPath )
  return;

  protoEntryPath = _.container.map_( protoEntryPath, ( entryPath ) =>
  {
    if( abs( entryPath ) !== abs( 'proto/node_modules/Tools' ) )
    return entryPath;
    return 'proto/node_modules/Tools';
  });

  console.log( `${protoEntryPath}` );

  _.will.fileWriteResource
  ({
    commonPath : context.module.commonPath,
    resourceKind : 'path',
    resourceName : 'npm.proto.entry',
    withExport : 0,
    val : protoEntryPath,
  });

}

//

function willDisableIfEmpty( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;

  let protoEntryPath = _.will.fileReadPath( context.module.commonPath, 'npm.proto.entry' );
  if( !protoEntryPath )
  return;

  let any = _.any( protoEntryPath, ( entryPath ) =>
  {
    if( abs( entryPath ) === abs( 'proto/node_modules/Tools' ) )
    return true;
  });

  if( !any )
  return;

  logger.log( `Disabling ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  _.will.fileWriteResource
  ({
    commonPath : context.module.commonPath,
    resourceKind : 'about',
    resourceName : 'enabled',
    val : 0,
  });

}

//

function willFixDmytrosFuckup( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  debugger;
  if( !context.module )
  return;

  // debugger; xxx

// submodule:
//   wTools:
//     path:
//       path: 'npm:///wTools'
//       enabled: 0
//     enabled: 0

  debugger;
  let filePath = _.arrayAs( context.junction.module.willfilesPath )[ 0 ];
  let config = fileProvider.fileReadUnknown( filePath );
  debugger;

  let edited = false;
  for( let k in config.submodule )
  {
    let submodule = config.submodule[ k ];
    if( _.mapIs( submodule.path ) )
    {
      _.props.extend( submodule, submodule.path );
      edited = true;
    }
  }

  if( !edited )
  return;

  // let protoEntryPath = _.will.fileReadPath( context.module.commonPath, 'npm.proto.entry' );
  // if( !protoEntryPath )
  // return;
  //
  // let any = _.any( protoEntryPath, ( entryPath ) =>
  // {
  //   if( abs( entryPath ) === abs( 'proto/node_modules/Tools' ) )
  //   return true;
  // });
  //
  // if( !any )
  // return;

  logger.log( `Fixing ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  fileProvider.fileWriteUnknown( filePath, config );

}

//

function deleteIfDisabled( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;

  debugger;

  if( context.module.about.enabled )
  return;

  if( _.git.localPathFromInside( inPath ) !== inPath )
  return;

  let changes = _.git.hasLocalChanges( context.junction.dirPath );
  _.assert( changes !== undefined );
  if( changes )
  {
    logger.log( `Cant delete ${context.junction.nameWithLocationGet()}, it has local changes.` );
    return;
  }

  logger.log( `Deleting ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  fileProvider.filesDelete( abs( '.' ) );

}

//

function readmeModuleNameAdjust( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
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

//

function readmeTryOutAdjust( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
  return null;

  let moduleName = context.module.about.name; debugger;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `## Try out
\`\`\`
npm install
node sample/trivial/Sample.s
\`\`\``;
  let sub = `## Try out from the repository
\`\`\`
git clone https://github.com/${config.about.user}/${moduleName}
cd ${moduleName}
npm install
node sample/trivial/Sample.s
\`\`\``;

  debugger;
  if( !_.strHas( read, ins ) )
  return;

  logger.log( `Replacing "Try out" for ${context.junction.nameWithLocationGet()}` );

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

function readmeToAddRemove( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  // let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  let config = _.censor.configRead();
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
  return null;
  debugger;
  if( !context.module.about.values[ 'npm.name' ] )
  return null;

  let moduleName = context.module.about.name; debugger;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins = `## To add
\`\`\`
npm add '${context.module.about.values[ 'npm.name' ]}@stable'
\`\`\``;
  let sub = '';

  debugger;
  if( !_.strHas( read, ins ) )
  return;

  logger.log( `Removing "To add" from ${context.junction.nameWithLocationGet()}` );

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

function readmeInstructionsAdjust( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return
  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return;

  let config = _.censor.configRead();
  if( !config )
  return null;
  if( !config.about )
  return null;
  if( !config.about.user )
  return null;

  if( !context.module.about.values[ 'npm.name' ] )
  return null;

  let moduleName = context.module.about.name;
  let read = fileProvider.fileRead( abs( 'README.md' ) );
  let ins1 = `Try out from the repository`;
  let ins2 = `To add to your project`;
  let ins3 = `@stable'`;
  let ins4 = `node sample/trivial/Sample.s`;

  if( !_.strHas( read, ins1 ) )
  return skip();
  if( !_.strHas( read, ins2 ) )
  return skip();
  if( !_.strHas( read, ins3 ) )
  return skip();
  if( !_.strHas( read, ins4 ) )
  return skip();

  let tryOutSection =
`### Try out from the repository

\`\`\`
git clone https://github.com/${config.about.user}/${context.module.about.name}
cd ${context.module.about.name}
will .npm.install
node sample/trivial/Sample.s
\`\`\`

Make sure you have utility \`willbe\` installed. To install willbe: \`npm i -g willbe@stable\`. Willbe is required to build of the module.

`

  let toAddSection =
`### To add to your project

\`\`\`
npm add '${context.module.about.values[ 'npm.name' ]}@stable'
\`\`\`

\`Willbe\` is not required to use the module in your project as submodule.

`

  logger.log( `Patching readme of ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  // logger.log( _.censor.fileReplace
  // ({
  //   filePath : abs( 'README.md' ),
  //   ins : sectionOf( read, ins1 ),
  //   sub : tryOutSection,
  //   verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  // }).log );

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( 'README.md' ),
    ins : sectionOf( read, ins2 ),
    sub : toAddSection,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

  function sectionOf( read, key )
  {
    let parsed = _.md.parse( read );
    if( !parsed.sectionMap[ key ] )
    return null;
    return parsed.sectionMap[ key ][ 0 ].text;
  }

  function skip()
  {
    return logger.log( `Skipping ${context.junction.nameWithLocationGet()}` );
  }

}

//

function readmeSampleRename( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return

  let ins = `sample/Sample`;
  let sub = `sample/trivial/Sample`;

  if( !fileProvider.fileExists( abs( 'README.md' ) ) )
  return null;

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( 'README.md' ),
    ins,
    sub,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

}

//

function sourcesRemoveOld( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return

  let ins1 = `// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }`
  let sub1 = ``;
  logger.log( _.censor.filesReplace
  ({
    filePath : abs( inPath, '**/*.(js|ss|s)' ),
    ins : ins1,
    sub : sub1,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

  let ins2 = `if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }`
  let sub2 = ``;
  logger.log( _.censor.filesReplace
  ({
    filePath : abs( inPath, '**/*.(js|ss|s)' ),
    ins : ins2,
    sub : sub2,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

  let ins3 = `if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ delete require.cache[ module.id ]; }`
  let sub3 = ``;
  logger.log( _.censor.filesReplace
  ({
    filePath : abs( inPath, '**/*.(js|ss|s)' ),
    ins : ins3,
    sub : sub3,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

}

//

function sourceNodeModulesEntryAdd( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return;
  if( context.module.about.values.native )
  return

  let protoPath = abs( 'proto' );
  let configPath = abs( 'was.package.json' );
  let name = _.npm.fileReadName({ configPath });
  if( !name )
  return;

  let name2 = context.module.about.name;
  if( !name2 )
  return;

  if( _.longHas( [ 'wTools', 'wTesting' ], name2 ) )
  return;

  let entryPath = _.npm.fileReadEntryPath({ configPath });
  if( !entryPath )
  return;
  entryPath = abs( entryPath );

  if( !fileProvider.fileExists( entryPath ) )
  {
    console.error( `Entry path ${entryPath} of ${configPath} does not exists` );
    return;
  }

  if( !protoPath )
  return;

  let includePath = path.join( protoPath, 'node_modules', name );
  let relativeEntryPath = path.relative( path.dir( includePath ), entryPath );

  logger.log( `Adding include file ${includePath} referring ${relativeEntryPath}` );
  if( o.dry )
  return;

  let code =
`
module.exports = require( '${relativeEntryPath}' );
const _ = _global_.wTools;
_.module.predeclare
({
  alias : [ '${name2}', '${name2.toLowerCase()}' ],
  entryPath : __filename,
});
`;

  fileProvider.fileWrite( includePath, code );

}

//

function sourcesRemoveOld2( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return

  let ins1 = /@file .+\n/
  let sub1 = ``;
  logger.log( _.censor.filesReplace
  ({
    filePath : abs( inPath, '**/*.(js|ss|s)' ),
    ins : ins1,
    sub : sub1,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

}

//

function sampleFix( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return

  let ins = `___`;
  let sub = `console.log( '___ not implemented ___' );`;

  if( !fileProvider.fileExists( abs( 'sample/Sample.s' ) ) )
  return null;

  logger.log( _.censor.fileReplace
  ({
    filePath : abs( 'sample/Sample.s' ),
    ins,
    sub,
    verbosity : o.verbosity >= 2 ? o.verbosity-1 : 0,
  }).log );

}

//

function sampleTrivial( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.junction.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !context.module )
  return
  if( !context.module.about.name )
  return

  if( !fileProvider.fileExists( abs( 'sample/trivial' ) ) )
  fileProvider.dirMake( abs( 'sample/trivial' ) );

  move( 'Sample.s' );
  move( 'Sample.js' );
  move( 'Sample.ss' );
  move( 'Sample.html' );

  function move( name )
  {
    if( fileProvider.fileExists( abs( `sample/${name}` ) ) )
    fileProvider.fileRename
    ({
      dstPath : abs( `sample/trivial/${name}` ),
      srcPath : abs( `sample/${name}` ),
      verbosity : o.verbosity >= 2 ? o.verbosity : 0,
    });
  }

}

//
