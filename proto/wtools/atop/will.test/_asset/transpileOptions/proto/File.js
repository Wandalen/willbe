
const _ = require( 'wTools' );
let Ts = require( '..' );
let ts = new _.trs.System({ logger }).form();

let multiple = ts.multiple
({
  inPath :  _.path.join( __dirname, 'gfx.js' ),
  outPath : _.path.join( __dirname, 'gfx.min.js' ),
  transpilingStrategy : [ 'Uglify' ],

  optimization : 9,
  minification : 9,
  splittingStrategy : 'OneToOne',
  simpleConcatenator : 0,
  diagnosing : 0,
  beautifing : 1,
});

return multiple.form().perform()
.finally( ( err, arg ) =>
{
  debugger;
  if( err )
  throw _.err( err );
  // throw _.errLogOnce( err );
  return arg;
});
