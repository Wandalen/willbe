
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let fileProvider = it.fileProvider;
  let path = it.fileProvider.path;

  if( !it.module.about )
  return;
  if( !it.module.about.name )
  return;

  if( it.withPath !== it.junction.localPath )
  {
    debugger;
    throw _.errBrief
    (
        `Attempt to prepare ${it.junction.localPath}.`
      , `\nBut called from ${it.withPath}.`
      , `\nMake a willfile in directory which you want to prepare first then call the hook from the directory.`
    );
  }

  if( o.verbosity )
  logger.log( `Preparing ${it.junction.nameWithLocationGet()}` );

  it.will.hooks.TemplateStandard.call( it );

  it.ready.then( () =>
  {
    if( !_.Will.IsModuleAt( it.junction.localPath ) )
    throw _.errBrief( `No module at ${it.junction.localPath}` );
    let tempWillfPath = it.junction.localPath + ( path.isTrailed( it.junction.localPath ) ? '' : '.' ) + 'will.yml';
    if( fileProvider.fileExists( tempWillfPath ) )
    fileProvider.fileRename( path.join( it.junction.dirPath, '-' + path.fullName( tempWillfPath ) ), tempWillfPath );
    return null;
  });

  {
    let it2 = it.will.hookItNew( it );
    if( it2.request.map.verbosity )
    it2.request.map.verbosity += 2;
    it2.will.hooks.GitMake.call( it2 );
  }

  it.ready.thenGive( ( arg ) =>
  {
    it.ready.take( arg );

    it.start( `git add --all` );
    it.start( `git add --force '*.will.*'` );
    it.start( `git add --force .gitattributes` );
    it.start( `git add --force .gitignore` );
    it.start( `git add --force .github` );
    it.start( `git add --force .eslintrc.yml` );

    it.start({ execPath : `git commit -am "prepare"`, throwingExitCode : 0 });
    it.start({ execPath : `git push -u origin --all --follow-tags`, throwingExitCode : 0 });

  });

  {
    let it2 = it.will.hookItNew( it );
    if( it2.request.map.verbosity )
    it2.request.map.verbosity += 2;
    it2.will.hooks.hlink.call( it2 );
  }

}

module.exports = onModule;
