
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let ready = context.ready;

  ready.then( () => context.fileProvider.filesDelete( context.path.join( context.junction.dirPath, 'node_modules' ) ) );
  ready.then( () => context.fileProvider.filesDelete( context.path.join( context.junction.dirPath, 'package-lock.json' ) ) );

  context.start( 'npm i' );

}

module.exports = onModule;
