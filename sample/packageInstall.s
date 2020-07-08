
let willbePath = require.resolve( '..' );
let _ = require( 'wTools' )
_.include( 'wFiles' );
_.include( 'wProcess' );

_.process.start
({ 
  execPath : 'node ' + willbePath, 
  args : [ '.package.install package:///git#1:2.7.4-0ubuntu1.7' ], 
  mode : 'spawn' 
})
