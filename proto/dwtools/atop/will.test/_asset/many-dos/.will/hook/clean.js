
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;

  if( o.verbosity )
  logger.log( `Cleaning ${it.variant.locationExport()}` );

  del( '.module' );
  del( 'out' );
  del( 'node_modules' );

  function del( filePath )
  {
    _.fileProvider.filesDelete
    ({
      filePath : _.path.join( it.module ? it.module.inPath : it.opener.dirPath, filePath ),
      writing : !o.dry,
      verbosity : 1,
    });
  }

}

module.exports = onModule;
