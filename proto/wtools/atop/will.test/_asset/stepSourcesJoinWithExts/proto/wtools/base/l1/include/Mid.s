( function _Mid_s_()
{

'use strict';

const exported = Object.create( null );

exported.add = require( '../l1/Test.js' );
exported.mul = require( '../l1/Test.s' );
exported.div = require( '../l1/Test.ss' );

module[ 'exports' ] = exported;
})();
