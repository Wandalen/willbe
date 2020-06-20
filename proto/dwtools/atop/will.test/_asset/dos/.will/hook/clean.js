
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  if( o.verbosity )
  logger.log( `Cleaning ${context.junction.nameWithLocationGet()}` );

  del( '.module' );
  del( 'out' );
  del( 'node_modules' );

  function del( filePath )
  {
    fileProvider.filesDelete
    ({
      filePath : path.join( context.module ? context.module.inPath : context.opener.dirPath, filePath ),
      writing : !o.dry,
      verbosity : 1,
    });
  }

}

module.exports = onModule;
