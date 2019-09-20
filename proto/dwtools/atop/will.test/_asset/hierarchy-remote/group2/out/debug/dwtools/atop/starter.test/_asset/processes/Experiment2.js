
let _ = require( '../../Tools.s' );

_.include( 'wAppBasic' );
_.include( 'wFiles' );

let o =
{
  execPath : _.path.join( __dirname, 'Experiment.js' ),
  // mode : 'shell',
}
// _.process.exitHandlerRepair();
let shell = _.process.startNodePassingThrough( o );
