
let _ = require( './out/Main.s' );

var sum = _.add( 4, 4 );
var mul = _.mul( 4, 4 );
var div = _.div( 4, 4 );

console.log( `The sum of 4 and 4 is : ${ sum }` );
/* log : The sum of 4 and 4 is : 8 */
console.log( `The multiplication of 4 and 4 is : ${ mul }` );
/* log : The multiplication of 4 and 4 is : 16 */
console.log( `The division of 4 and 4 is : ${ div }` );
/* log : The division of 4 and 4 is : 1 */

