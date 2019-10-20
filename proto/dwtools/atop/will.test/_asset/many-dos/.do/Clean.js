
function onEach( it )
{
  let _ = it.tools;
  let logger = it.logger;

  _.fileProvider.filesDelete( _.path.join( it.opener.inPath, '.module' ) );
  _.fileProvider.filesDelete( _.path.join( it.opener.inPath, 'out' ) );
  _.fileProvider.filesDelete( _.path.join( it.opener.inPath, 'node_modules' ) );

}

module.exports = onEach;
