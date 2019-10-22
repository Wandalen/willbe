
function onEach( it )
{
  let _ = it.tools;
  let logger = it.logger;

  del( '.module' );
  del( 'out' );
  del( 'node_modules' );

  function del( filePath )
  {
    _.fileProvider.filesDelete
    ({
      filePath : _.path.join( it.module ? it.module.inPath : it.opener.dirPath, filePath ),
      writing : !it.request.map.dry,
      verbosity : 1,
    });
  }

}

module.exports = onEach;
