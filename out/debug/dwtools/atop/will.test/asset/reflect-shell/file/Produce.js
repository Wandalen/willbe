let File = require( 'fs' );

let read = [];
for( let a = 2 ; a < process.argv.length-1 ; a++ )
read[ a ] = File.readFileSync( process.argv[ a ], 'utf8' );

if( process.argv.length < 4 )
throw 'Lack of arguments';

File.writeFileSync( process.argv[ process.argv.length-1 ], read.join( '' ) );
