
if( typeof module !== 'undefined' )
{

  let Self;

  if( typeof _global_ === 'undefined' || !Object.hasOwnProperty.call( _global_, 'wBase' ) )
  {
    let toolsPath = './l1/Include.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      Self = require( 'wmodulefortesting1' );
    }
    if( !toolsExternal )
    Self = require( toolsPath );
  }

  module[ 'exports' ] = Self;

}
