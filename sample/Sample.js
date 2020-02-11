
var _ = require( 'wresolverextra' );
var src =
{
  dir :
  {
    val1 : 'Hello'
  },
}

var resolved = _.resolver.resolve
({
  src : src,
  selector : 'dir/val1',
});

console.log( resolved );

/*
`Hello`
*/
