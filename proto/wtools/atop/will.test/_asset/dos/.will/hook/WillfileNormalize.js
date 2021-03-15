
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

  // wasRename( context );
  willfileExtend( context );

}

onModule.defaults =
{
  v : null,
  verbosity : 2,
  dry : 0,
}

//

function wasRename( context )
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
  if( !fileProvider.fileExists( abs( 'was.package.json' ) ) )
  return;

  fileProvider.fileRename
  ({
    dstPath : abs( '-package.json' ),
    srcPath : abs( 'was.package.json' ),
    verbosity : 3,
  });

  // xxx

}

//

function willfileExtend( context )
{
  let o = context.request.map;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let _ = context.tools;
  let inPath = context.module ? context.module.dirPath : context.opener.dirPath;
  let abs = _.routineJoin( path, path.join, [ inPath ] );

  if( !fileProvider.fileExists( abs( 'was.package.json' ) ) )
  return;

  context.start( 'will.local .willfile.extend.willfile . -package.json' );

}

//
