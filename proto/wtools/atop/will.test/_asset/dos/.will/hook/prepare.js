
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  if( !context.module.about )
  return;
  if( !context.module.about.name )
  return;

  /* example
  reset && mkdir ___ && cd ___ && will .module.new.with prepare && will .call publish tag:alpha && cd ..
  */

  if( context.withPath !== context.junction.localPath )
  {
    throw _.errBrief
    (
      `Attempt to prepare ${context.junction.localPath}.`
      , `\nBut called from ${context.withPath}.`
      , `\nMake a willfile in directory which you want to prepare first then call the hook from the directory.`
    );
  }

  if( o.verbosity )
  logger.log( `Preparing ${context.junction.nameWithLocationGet()}` );

  context.will.hooks.TemplateStandard.call( context );

  context.ready.then( () =>
  {
    if( !_.Will.IsModuleAt( context.junction.localPath ) )
    throw _.errBrief( `No module at ${context.junction.localPath}` );
    let tempWillfPath = context.junction.localPath + ( path.isTrailed( context.junction.localPath ) ? '' : '.' ) + 'will.yml';
    if( fileProvider.fileExists( tempWillfPath ) )
    fileProvider.fileRename( path.join( context.junction.dirPath, '-' + path.fullName( tempWillfPath ) ), tempWillfPath );
    return null;
  });

  {
    let context2 = context.will.hookContextNew( context );
    if( context2.request.map.verbosity )
    context2.request.map.verbosity += 2;
    context2.will.hooks.GitMake.call( context2 );
  }

  context.ready.thenGive( ( arg ) =>
  {
    context.ready.take( arg );

    context.start( `git add --all` );
    context.start( `git add --force '*will.*'` );
    context.start( `git add --force .gitattributes` );
    context.start( `git add --force .gitignore` );
    context.start( `git add --force .github` );
    context.start( `git add --force .eslintrc.yml` );

    context.start({ execPath : `git commit -am "prepare"`, throwingExitCode : 0 });
    context.start({ execPath : `git push -u origin --all --follow-tags`, throwingExitCode : 0 });

  });

  {
    let context2 = context.will.hookContextNew( context );
    if( context2.request.map.verbosity )
    context2.request.map.verbosity += 2;
    context2.will.hooks.hlink.call( context2 );
  }

}

module.exports = onModule;
