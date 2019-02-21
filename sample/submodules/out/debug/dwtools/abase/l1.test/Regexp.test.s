( function _Regexp_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../Tools.s' );
  _.include( 'wTesting' );
}

var _global = _global_;
var _ = _global_.wTools;

// --
// routines
// --

function regexpsAreIdentical( test )
{
  var context = this;

  /* */

  test.case = 'null';

  var expected = false;
  var got = _.regexpsAreIdentical( null, null );
  test.identical( got, expected );

  /* */

  test.case = 'null and regexp';

  var expected = false;
  var got = _.regexpsAreIdentical( /x/, null );
  test.identical( got, expected );

  /* */

  test.case = 'same string';

  var expected = false;
  var got = _.regexpsAreIdentical( 'x','x' );
  test.identical( got, expected );

  /* */

  test.case = 'same regexp';
  var expected = true;
  var got = _.regexpsAreIdentical( /abc/iy, /abc/yi );
  test.identical( got, expected );

  /* */

  test.case = 'not identical regexp, different flags';
  var expected = false;
  var got = _.regexpsAreIdentical( /abc/i, /abc/ );
  test.identical( got, expected );

  /* */

  test.case = 'not identical regexp, different source';
  var expected = false;
  var got = _.regexpsAreIdentical( /abcd/i, /abc/i );
  test.identical( got, expected );

  /* */

  test.case = 'not identical regexp';
  var expected = false;
  var got = _.regexpsAreIdentical( /abcd/y, /abc/i );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsAreIdentical() );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsAreIdentical( /abc/i, /def/i, /a/i ) );

}

//

function regexpsSources( test )
{
  var context = this;

  /* */

  test.case = 'empty';

  var expected =
  {
    sources : [],
    flags : null,
    escaping : 0,
  }
  var got = _.regexpsSources([]);
  test.identical( got, expected );

  /* */

  test.case = 'single string';

  var r1 = 'abc';
  var expected =
  {
    sources : [ 'abc' ],
    flags : null,
    escaping : 0
  }
  var got = _.regexpsSources([ r1 ]);
  test.identical( got, expected );

  /* */

  test.case = 'single regexp';

  var r1 = /abc/i;
  var expected =
  {
    sources : [ 'abc' ],
    flags : 'i',
    escaping : 0
  }
  var got = _.regexpsSources([ r1 ]);
  test.identical( got, expected );

  /* */

  test.case = 'all strings';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = '.+';
  var expected =
  {
    sources : [ 'abc', 'def', '.+' ],
    flags : null,
    escaping : 0
  }
  var got = _.regexpsSources([ r1, r2, r3 ]);
  test.identical( got, expected );

  /* */

  test.case = 'strings with regexps';

  var r1 = 'abc';
  var r2 = /def/;
  var r3 = /.+/;
  var expected =
  {
    sources : [ 'abc', 'def', '.+' ],
    flags : '',
    escaping : 0
  }
  var got = _.regexpsSources([ r1, r2, r3 ]);
  test.identical( got, expected );

  /* */

  test.case = 'strings with regexps and flags i';

  var r1 = 'abc';
  var r2 = /def/i;
  var r3 = /.+/i;
  var expected =
  {
    sources : [ 'abc', 'def', '.+' ],
    flags : 'i',
    escaping : 0
  }
  var got = _.regexpsSources([ r1, r2, r3 ]);
  test.identical( got, expected );

  /* */

  test.case = 'strings with regexps and flags iy';

  var r1 = /abc/iy;
  var r2 = 'def';
  var r3 = /.+/yi;
  var expected =
  {
    sources : [ 'abc', 'def', '.+' ],
    flags : 'iy',
    escaping : 0
  }
  var got = _.regexpsSources([ r1, r2, r3 ]);
  test.identical( got, expected );

  /* */

  test.case = 'empty in map';

  var expected =
  {
    sources : [],
    flags : null,
    escaping : 0
  }
  var o =
  {
    sources : []
  }
  var got = _.regexpsSources( o );
  test.identical( got, expected );
  test.is( o === got );

  /* */

  test.case = 'strings with regexps and flags iy in map';

  var r1 = /abc/iy;
  var r2 = 'def';
  var r3 = /.+/yi;
  var expected =
  {
    sources : [ 'abc', 'def', '.+' ],
    flags : 'iy',
    escaping : 0
  }
  var o =
  {
    sources : [ r1, r2, r3 ],
  }
  var got = _.regexpsSources( o );
  test.identical( got, expected );
  test.is( o === got );

  /* */

  test.case = 'options map with flags';

  var r1 = /abc/i;
  var r2 = 'def';
  var r3 = /.+/i;
  var expected =
  {
    sources : [ 'abc', 'def', '.+' ],
    flags : 'i',
    escaping : 0
  }
  var o =
  {
    sources : [ r1, r2, r3 ],
    flags : 'i',
  }
  var got = _.regexpsSources( o );
  test.identical( got, expected );
  test.is( o === got );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsSources() );

  test.case = 'strings with different flags';

  test.shouldThrowErrorSync( () => _.regexpsSources([ /abc/i, /def/iy ]) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsSources( 'ab', 'cd' ) );

  test.case = 'different flags in map';

  test.shouldThrowErrorSync( () => _.regexpsSources({ sources : [ /abc/i ], flags : 'y' }) );

}

//

function regexpsJoin( test )
{
  var context = this;

  /* */

  test.case = 'empty';

  var expected = new RegExp( '','' );
  var got = _.regexpsJoin([]);
  test.identical( got, expected );

  /* */

  test.case = 'single string';

  var r1 = 'abc';
  var expected = /abc/;
  var got = _.regexpsJoin([ r1 ]);
  test.identical( got, expected );

  /* */

  test.case = 'single regexp';

  var r1 = /abc/i;
  var expected = /abc/i;
  var got = _.regexpsJoin([ r1 ]);
  test.identical( got, expected );
  test.is( got === r1 );

  /* */

  test.case = 'all strings';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = '.+';
  var expected = /abcdef.+/;
  var got = _.regexpsJoin([ r1, r2, r3 ]);
  test.identical( got, expected );

  /* */

  test.case = 'strings with regexps';

  var r1 = 'abc';
  var r2 = /def/;
  var r3 = /.+/;
  var expected = /abcdef.+/;
  var got = _.regexpsJoin([ r1, r2, r3 ]);
  test.identical( got, expected );

  /* */

  test.case = 'strings with regexps and flags i';

  var r1 = 'abc';
  var r2 = /def/i;
  var r3 = /.+/i;
  var expected = /abcdef.+/i;
  var got = _.regexpsJoin([ r1, r2, r3 ]);
  test.identical( got, expected );

  /* */

  test.case = 'strings with regexps and flags iy';

  var r1 = /abc/iy;
  var r2 = 'def';
  var r3 = /.+/yi;
  var expected = /abcdef.+/iy;
  var got = _.regexpsJoin([ r1, r2, r3 ]);
  test.identical( got, expected );

  /* */

  test.case = 'empty in map';

  var o =
  {
    sources : [],
    flags : null,
  }
  var expected = new RegExp( '','' );
  var got = _.regexpsJoin( o );
  test.identical( got, expected );

  /* */

  test.case = 'strings with regexps and flags iy in map';

  var r1 = /abc/iy;
  var r2 = 'def';
  var r3 = /.+/yi;
  var expected = /abcdef.+/iy;
  var o =
  {
    sources : [ r1, r2, r3 ],
  }
  var got = _.regexpsJoin( o );
  test.identical( got, expected );

  /* */

  test.case = 'options map with flags';

  var r1 = /abc/i;
  var r2 = 'def';
  var r3 = /.+/i;
  var expected = /abcdef.+/i;
  var o =
  {
    sources : [ r1, r2, r3 ],
    flags : 'i',
  }
  var got = _.regexpsJoin( o );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsJoin() );

  test.case = 'strings with different flags';

  test.shouldThrowErrorSync( () => _.regexpsJoin([ /abc/i, /def/iy ]) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsJoin( 'ab', 'cd' ) );

  test.case = 'different flags in map';

  test.shouldThrowErrorSync( () => _.regexpsJoin({ sources : [ /abc/i ], flags : 'y' }) );

}

//

function regexpsAtLeastFirst( test )
{
  var context = this;

  test.case = 'empty';

  var expected = new RegExp( '' );
  var got = _.regexpsAtLeastFirst([]);
  test.identical( got, expected );

  test.case = 'single regexp';

  var r1 = /.+/i;
  var expected = /.+/i;
  var got = _.regexpsAtLeastFirst([ r1 ]);
  test.identical( got, expected );
  test.is( got === r1 );

  test.case = 'strings';

  var r1 = 'abc';
  var r2 = 'def';
  var expected = /abc(?:def)?/;
  var got = _.regexpsAtLeastFirst([ r1, r2 ]);
  test.identical( got, expected );

  test.case = 'strings and regexps';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = /.+/i;
  var expected = /abc(?:def(?:.+)?)?/i;
  var got = _.regexpsAtLeastFirst([ r1, r2, r3 ]);
  test.identical( got, expected );

  test.case = 'strings and regexps and flags';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = /.+/i;
  var expected = /abc(?:def(?:.+)?)?/i;
  var got = _.regexpsAtLeastFirst({ sources : [ r1, r2, r3 ], flags : 'i' });
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsAtLeastFirst() );

  test.case = 'strings with different flags';

  test.shouldThrowErrorSync( () => _.regexpsAtLeastFirst([ /abc/i, /def/iy ]) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsAtLeastFirst( 'ab', 'cd' ) );

  test.case = 'different flags in map';

  test.shouldThrowErrorSync( () => _.regexpsAtLeastFirst({ sources : [ /abc/i ], flags : 'y' }) );

}

//

function regexpsNone( test )
{
  var context = this;

  test.case = 'empty';

  var expected = /^(?:(?!(?:)).)+$/;
  var got = _.regexpsNone([]);
  test.identical( got, expected );

  test.case = 'single regexp';

  var r1 = /.+/i;
  var expected = /^(?:(?!(?:.+)).)+$/i;
  var got = _.regexpsNone([ r1 ]);
  test.identical( got, expected );
  test.is( got !== r1 );

  test.case = 'strings';

  var r1 = 'abc';
  var r2 = 'def';
  var expected = /^(?:(?!(?:abc)|(?:def)).)+$/;
  var got = _.regexpsNone([ r1, r2 ]);
  test.identical( got, expected );

  test.case = 'strings and regexps';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = /.+/i;
  var expected = /^(?:(?!(?:abc)|(?:def)|(?:.+)).)+$/i;
  var got = _.regexpsNone([ r1, r2, r3 ]);
  test.identical( got, expected );

  test.case = 'strings and regexps and flags';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = /.+/i;
  var expected = /^(?:(?!(?:abc)|(?:def)|(?:.+)).)+$/i;
  var got = _.regexpsNone({ sources : [ r1, r2, r3 ], flags : 'i' });
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsNone() );

  test.case = 'strings with different flags';

  test.shouldThrowErrorSync( () => _.regexpsNone([ /abc/i, /def/iy ]) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsNone( 'ab', 'cd' ) );

  test.case = 'different flags in map';

  test.shouldThrowErrorSync( () => _.regexpsNone({ sources : [ /abc/i ], flags : 'y' }) );

}

//

function regexpsAny( test )
{
  var context = this;

  test.case = 'empty';

  var expected = /(?:)/;
  var got = _.regexpsAny([]);
  test.identical( got, expected );

  test.case = 'single regexp';

  var r1 = /.+/i;
  var expected = /.+/i;
  var got = _.regexpsAny([ r1 ]);
  test.identical( got, expected );
  test.is( got === r1 );

  test.case = 'strings';

  var r1 = 'abc';
  var r2 = 'def';
  var expected = /(?:abc)|(?:def)/;
  var got = _.regexpsAny([ r1, r2 ]);
  test.identical( got, expected );

  test.case = 'strings and regexps';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = /.+/i;
  var expected = /(?:abc)|(?:def)|(?:.+)/i;
  var got = _.regexpsAny([ r1, r2, r3 ]);
  test.identical( got, expected );

  test.case = 'strings and regexps and flags';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = /.+/i;
  var expected = /(?:abc)|(?:def)|(?:.+)/i;
  var got = _.regexpsAny({ sources : [ r1, r2, r3 ], flags : 'i' });
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsAny() );

  test.case = 'strings with different flags';

  test.shouldThrowErrorSync( () => _.regexpsAny([ /abc/i, /def/iy ]) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsAny( 'ab', 'cd' ) );

  test.case = 'different flags in map';

  test.shouldThrowErrorSync( () => _.regexpsAny({ sources : [ /abc/i ], flags : 'y' }) );

}

//

function regexpsAll( test )
{
  var context = this;

  test.case = 'empty';

  var expected = new RegExp( '' );
  var got = _.regexpsAll([]);
  test.identical( got, expected );

  test.case = 'single regexp';

  var r1 = /.+/i;
  var expected = /.+/i;
  var got = _.regexpsAll([ r1 ]);
  test.identical( got, expected );
  test.is( got === r1 );

  test.case = 'strings';

  var r1 = 'abc';
  var r2 = 'def';
  var expected = /(?=abc)(?:def)/;
  var got = _.regexpsAll([ r1, r2 ]);
  test.identical( got, expected );

  test.case = 'strings and regexps';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = /.+/i;
  var expected = /(?=abc)(?=def)(?:.+)/i;
  var got = _.regexpsAll([ r1, r2, r3 ]);
  test.identical( got, expected );

  test.case = 'strings and regexps and flags';

  var r1 = 'abc';
  var r2 = 'def';
  var r3 = /.+/i;
  var expected = /(?=abc)(?=def)(?:.+)/i;
  var got = _.regexpsAll({ sources : [ r1, r2, r3 ], flags : 'i' });
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsAll() );

  test.case = 'strings with different flags';

  test.shouldThrowErrorSync( () => _.regexpsAll([ /abc/i, /def/iy ]) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsAll( 'ab', 'cd' ) );

  test.case = 'different flags in map';

  test.shouldThrowErrorSync( () => _.regexpsAll({ sources : [ /abc/i ], flags : 'y' }) );

}

//

function _regexpTest( test )
{
  var context = this;

  test.case = 'identical strings';

  var r1 = 'abc';
  var r2 = 'abc';
  var expected = true;
  var got = _._regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings';

  var r1 = 'abc';
  var r2 = 'abcd';
  var expected = false;
  var got = _._regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in string';

  var r1 = /abc/;
  var r2 = 'abcd';
  var expected = true;
  var got = _._regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp not in string';

  var r1 = /.abc/;
  var r2 = 'abcd';
  var expected = false;
  var got = _._regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp in string';

  var r1 = /\d+(?!\.)/;
  var r2 = 'abcd3';
  var expected = true;
  var got = _._regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp not in string';

  var r1 = /\d+(?=\.)/;
  var r2 = 'abcd4';
  var expected = false;
  var got = _._regexpTest( r1, r2 );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _._regexpTest() );

  test.case = 'not enough arguments';

  test.shouldThrowErrorSync( () => _._regexpTest( 'ab' ) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _._regexpTest( 'ab', 'cd', 'ef' ) );

  test.case = 'wrong order of arguments';

  test.shouldThrowErrorSync( () => _._regexpTest([ 'Hello', /o/ ]) );

  test.case = 'null';

  test.shouldThrowErrorSync( () => _._regexpTest([ null, 'Hello' ]) );
  test.shouldThrowErrorSync( () => _._regexpTest([ 'Hello', null ]) );

  test.case = 'NaN';

  test.shouldThrowErrorSync( () => _._regexpTest([ 'Hello', NaN ]) );
  test.shouldThrowErrorSync( () => _._regexpTest([ NaN, 'Hello' ]) );

  test.case = 'array';

  test.shouldThrowErrorSync( () => _._regexpTest([ [], 's' ]) );
  test.shouldThrowErrorSync( () => _._regexpTest([  /o/, [] ]) );

}

//

function regexpTest( test )
{
  var context = this;

  test.case = 'identical strings';

  var r1 = 'hi';
  var r2 = 'hi';
  var expected = true;
  var got = _.regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp not in string';

  var r1 = /^bc/;
  var r2 = 'abcd';
  var expected = false;
  var got = _.regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp in string array';

  var r1 = /\d+(?!\.)/;
  var r2 = [ 'abcd3', '2', 'dwq1!c' ];
  var expected = [ true, true, true ];
  var got = _.regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp in part of string array';

  var r1 = /\d+(?=\.)/;
  var r2 = [ 'abcd4', '1.5768', 'Hi' ];
  var expected = [ false, true, false ];
  var got = _.regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp not in string array';

  var r1 = /^abc{2}$/;
  var r2 = [ 'abcc4', '1.5768', 'bcc', '0abcc' ];
  var expected = [ false, false, false, false ];
  var got = _.regexpTest( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in string array once';

  var r1 = /^abc{2}$/;
  var r2 = [ 'abcc4', '1.5768', 'bcc', '0abcc', 'abcc' ];
  var expected = [ false, false, false, false, true ];
  var got = _.regexpTest( r1, r2 );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpTest() );

  test.case = 'not enough arguments';

  test.shouldThrowErrorSync( () => _.regexpTest( 'ab' ) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpTest( 'ab', 'cd', 'ef' ) );

  test.case = 'wrong order of arguments';

  test.shouldThrowErrorSync( () => _.regexpTest([ 'Hello', /o/ ]) );

  test.case = 'null';

  test.shouldThrowErrorSync( () => _.regexpTest([ null, 'Hello' ]) );
  test.shouldThrowErrorSync( () => _.regexpTest([ 'Hello', null ]) );

  test.case = 'NaN';

  test.shouldThrowErrorSync( () => _.regexpTest([ 'Hello', NaN ]) );
  test.shouldThrowErrorSync( () => _.regexpTest([ NaN, 'Hello' ]) );

  test.case = 'array';

  test.shouldThrowErrorSync( () => _.regexpTest([ [], 's' ]) );
  test.shouldThrowErrorSync( () => _.regexpTest([  /o/, [] ]) );

}

//

function regexpTestAll( test )
{
  var context = this;

  test.case = 'identical strings';

  var r1 = 'abc';
  var r2 = 'abc';
  var expected = true;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings';

  var r1 = 'abc';
  var r2 = 'abcd';
  var expected = false;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'identical strings array';

  var r1 = 'abc';
  var r2 = [ 'abc', 'abc' ];
  var expected = true;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings array';

  var r1 = 'abc';
  var r2 = [ 'abc', 'a', 'b', 'c' ];
  var expected = false;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in string';

  var r1 = /b/;
  var r2 = 'abcd';
  var expected = true;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp not in string';

  var r1 = /.a/;
  var r2 = 'abcd';
  var expected = false;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in string array';

  var r1 = /abc/;
  var r2 = [ 'dabcd', 'efabcgh', 'ijklabc' ];
  var expected = true;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp not in string array';

  var r1 = /.abc/;
  var r2 = [ 'abcd','efgh', 'ijkl' ];
  var expected = false ;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp in string';

  var r1 = /\d|a/;
  var r2 = 'abcd3';
  var expected = true;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp not in string';

  var r1 = /\d(?=\.)/;
  var r2 = 'abcd4';
  var expected = false;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp in string array';

  var r1 = /\d+(?!\.)|\d+(?=\.)/;
  var r2 = [ 'abcd3', 'abcd4', '2' ];
  var expected = true;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp not in string array';

  var r1 = /[^fdh]/;
  var r2 = [ 'abcd4', 'fd' ];
  var expected = false;
  var got = _.regexpTestAll( r1, r2 );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpTestAll() );

  test.case = 'not enough arguments';

  test.shouldThrowErrorSync( () => _.regexpTestAll( 'ab' ) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpTestAll( 'ab', 'cd', 'ef' ) );

  test.case = 'wrong order of arguments';

  test.shouldThrowErrorSync( () => _.regexpTestAll([ 'Hello', /o/ ]) );

  test.case = 'null';

  test.shouldThrowErrorSync( () => _.regexpTestAll([ null, 'Hello' ]) );
  test.shouldThrowErrorSync( () => _.regexpTestAll([ 'Hello', null ]) );

  test.case = 'NaN';

  test.shouldThrowErrorSync( () => _.regexpTestAll([ 'Hello', NaN ]) );
  test.shouldThrowErrorSync( () => _.regexpTestAll([ NaN, 'Hello' ]) );

  test.case = 'array';

  test.shouldThrowErrorSync( () => _.regexpTestAll([ [], 'h' ]) );

}

//

function regexpTestAny( test )
{
  var context = this;

  test.case = 'identical strings';

  var r1 = 'abc';
  var r2 = 'abc';
  var expected = true;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings';

  var r1 = 'abc';
  var r2 = 'abcd';
  var expected = false;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'One identical string, array';

  var r1 = 'abc';
  var r2 = [ 'abc', 'abc' ];
  var expected = true;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings array';

  var r1 = 'abc';
  var r2 = [ 'abd', 'a', 'b', 'c' ];
  var expected = false;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in string';

  var r1 = /b/;
  var r2 = 'abcd';
  var expected = true;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp not in string';

  var r1 = /.a/;
  var r2 = 'abcd';
  var expected = false;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in string array';

  var r1 = /abc/;
  var r2 = [ 'dabcd', 'efabcgh', 'ijklabc' ];
  var expected = true;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in only one string array';

  var r1 = /.abc/;
  var r2 = [ 'dabcd', 'efgh', 'ijkl' ];
  var expected = true;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp not in string array';

  var r1 = /.abc/;
  var r2 = [ 'abcd', 'efgh', 'ijkl' ];
  var expected = false ;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp in string';

  var r1 = /\d|a/;
  var r2 = 'abcd3';
  var expected = true;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp not in string';

  var r1 = /\d(?=\.)/;
  var r2 = 'abcd4';
  var expected = false;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp in one string array';

  var r1 = /\d+(?!\.)|\d+(?=\.)/;
  var r2 = [ 'abcd3', 'abcd', 'fgh' ];
  var expected = true;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp not in string array';

  var r1 = /[^f-h]/;
  var r2 = [ 'fg', 'fh', 'h' ];
  var expected = false;
  var got = _.regexpTestAny( r1, r2 );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpTestAny() );

  test.case = 'not enough arguments';

  test.shouldThrowErrorSync( () => _.regexpTestAny( 'ab' ) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpTestAny( 'ab', 'cd', 'ef' ) );

  test.case = 'wrong order of arguments';

  test.shouldThrowErrorSync( () => _.regexpTestAny([ 'Hello', /o/ ]) );

  test.case = 'null';

  test.shouldThrowErrorSync( () => _.regexpTestAny([ null, 'Hello' ]) );
  test.shouldThrowErrorSync( () => _.regexpTestAny([ 'Hello', null ]) );

  test.case = 'NaN';

  test.shouldThrowErrorSync( () => _.regexpTestAny([ 'Hello', NaN ]) );
  test.shouldThrowErrorSync( () => _.regexpTestAny([ NaN, 'Hello' ]) );

  test.case = 'array';

  test.shouldThrowErrorSync( () => _.regexpTestAny([ [], 'h' ]) );

}

//

function regexpTestNone( test )
{
  var context = this;

  test.case = 'identical strings';

  var r1 = 'abc';
  var r2 = 'abc';
  var expected = false;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings';

  var r1 = 'c';
  var r2 = 'abcd';
  var expected = true;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'One identical string, array';

  var r1 = 'abc';
  var r2 = [ 'abc', 'abcd' ];
  var expected = false;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings array';

  var r1 = 'abc';
  var r2 = [ 'abd', 'a', 'b', 'c' ];
  var expected = true;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in string';

  var r1 = /b/;
  var r2 = 'abcd';
  var expected = false;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp not in string';

  var r1 = /a+/;
  var r2 = 'bcd';
  var expected = true;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in string array';

  var r1 = /abc/;
  var r2 = [ 'dabcd', 'efabcgh', 'ijklabc' ];
  var expected = false;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp in only one string array';

  var r1 = /.abc/;
  var r2 = [ 'dabcd', 'efgh', 'ijkl' ];
  var expected = false;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexp not in string array';

  var r1 = /.abc/;
  var r2 = [ 'abcd', 'efgh', 'ijkl' ];
  var expected = true ;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp in string';

  var r1 = /\d|a/;
  var r2 = 'abcd3';
  var expected = false;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp not in string';

  var r1 = /\d(?=\.)/;
  var r2 = 'abcd4';
  var expected = true;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp in one string array';

  var r1 = /\d+(?!\.)|\d+(?!\!)/;
  var r2 = [ 'abcd3', 'abcd', 'fgh' ];
  var expected = false;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexp not in string array';

  var r1 = /[^f-h]/;
  var r2 = [ 'fg', 'fh', 'h' ];
  var expected = true;
  var got = _.regexpTestNone( r1, r2 );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpTestNone() );

  test.case = 'not enough arguments';

  test.shouldThrowErrorSync( () => _.regexpTestNone( 'ab' ) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpTestNone( 'ab', 'cd', 'ef' ) );

  test.case = 'wrong order of arguments';

  test.shouldThrowErrorSync( () => _.regexpTestNone([ 'Hello', /o/ ]) );

  test.case = 'null';

  test.shouldThrowErrorSync( () => _.regexpTestNone([ null, 'Hello' ]) );
  test.shouldThrowErrorSync( () => _.regexpTestNone([ 'Hello', null ]) );

  test.case = 'NaN';

  test.shouldThrowErrorSync( () => _.regexpTestNone([ 'Hello', NaN ]) );
  test.shouldThrowErrorSync( () => _.regexpTestNone([ NaN, 'Hello' ]) );

  test.case = 'array';

  test.shouldThrowErrorSync( () => _.regexpTestNone([ [], 'h' ]) );

}

//

function regexpsTestAll( test )
{
  var context = this;

  test.case = 'identical strings';

  var r1 = 'abc';
  var r2 = 'abc';
  var expected = true;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings';

  var r1 = 'abc';
  var r2 = 'abcd';
  var expected = false;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'identical strings array';

  var r1 = [ 'abc', 'abc' ];
  var r2 = 'abc';
  var expected = true;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings array';

  var r1 = [ 'abc', 'a', 'b', 'c' ];
  var r2 = 'abc';
  var expected = false;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'regexps in string';

  var r1 = /b/;
  var r2 = 'abcd';
  var expected = true;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'regexps not in string';

  var r1 = /.a/;
  var r2 = 'abcd';
  var expected = false;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'regexps array in string';

  var r1 = [ /a/, /b/, /c/ ];
  var r2 = 'abc';
  var expected = true;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'regexps array not in string';

  var r1 = [ /a/, /b/, /c/, /d/, /e/ ];
  var r2 = 'abcd';
  var expected = false ;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexps in string';

  var r1 = /\d|a/;
  var r2 = 'abcd3';
  var expected = true;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexps not in string';

  var r1 = /\d(?=\.)/;
  var r2 = 'abcd4';
  var expected = false;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexps array not in string';

  var r1 = [ /\d+(?!\.)/, /\d+(?=\.)/ ];
  var r2 = 'abcd3';
  var expected = false;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexps array in string';

  var r1 = [ /[^fdh]/, /\d+(?!\.)/ ];
  var r2 = 'abcd4';
  var expected = true;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexps array in string array';

  var r1 = [ /[^fdh]/, /\d+(?!\.)/ ];
  var r2 = [ 'abcd4', 'd3,', '7' ];
  var expected = true;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  test.case = 'Regexps array not in part of string array';

  var r1 = [ /[^fdh]/, /\d+(?!\.)/ ];
  var r2 = [ 'abcd4', 'd3,', '7', 'd' ];
  var expected = false;
  var got = _.regexpsTestAll( r1, r2 );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsTestAll() );

  test.case = 'not enough arguments';

  test.shouldThrowErrorSync( () => _.regexpsTestAll( 'ab' ) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsTestAll( 'ab', 'cd', 'ef' ) );

  test.case = 'wrong order of arguments';

  test.shouldThrowErrorSync( () => _.regexpsTestAll([ 'Hello', /o/ ]) );

  test.case = 'null';

  test.shouldThrowErrorSync( () => _.regexpsTestAll([ null, 'Hello' ]) );
  test.shouldThrowErrorSync( () => _.regexpsTestAll([ 'Hello', null ]) );

  test.case = 'NaN';

  test.shouldThrowErrorSync( () => _.regexpsTestAll([ 'Hello', NaN ]) );
  test.shouldThrowErrorSync( () => _.regexpsTestAll([ NaN, 'Hello' ]) );

  test.case = 'array';

  test.shouldThrowErrorSync( () => _.regexpsTestAll([ 'h', [] ]) );

}

//

function regexpsTestAny( test )
{

  var context = this;

  test.case = 'One different regexp';

  var r1 = [ 'abc', 'def' ];
  var r2 = 'abc';
  var expected = true;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Identical regexp and string arrays';

  var r1 = [ 'abc', 'def' ];
  var r2 = [ 'abc', 'def' ];
  var expected = true;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'String array with one no- match';

  var r1 = [ 'abc', 'def' ];
  var r2 = [ 'abc', 'def', 'ghi' ];
  var expected = true;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'different regexp array';

  var r1 = [ 'abd', 'a', 'b', 'c' ];
  var r2 = 'abc';
  var expected = false;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'regexps in string';

  var r1 = /b/;
  var r2 = 'abcd';
  var expected = true;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'regexps not in string';

  var r1 = /.a/;
  var r2 = 'abcd';
  var expected = false;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'regexps array with one no-match in string ';

  var r1 = [ /[abc]/, /.a/, /\d/ ];
  var r2 = 'dabcd';
  var expected = true;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'No regexps in string -  array';

  var r1 = [ /[abc]/, /.a/, /\d/ ];;
  var r2 = 'ijkl';
  var expected = false;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexps in one string array';

  var r1 = [ /\d+(?!\.)/, /\d+(?=\!)/ ];
  var r2 = [ 'abcd3', 'abcd', 'fg2!h' ];
  var expected = true;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  test.case = 'Conditional regexps not in string array';

  var r1 = [ /[^f-h]/, /[ab]/ ];
  var r2 = [ 'fg', 'fh', 'h' ];
  var expected = false;
  var got = _.regexpsTestAny( r1, r2 );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsTestAny() );

  test.case = 'not enough arguments';

  test.shouldThrowErrorSync( () => _.regexpsTestAny( 'ab' ) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsTestAny( 'ab', 'cd', 'ef' ) );

  test.case = 'wrong order of arguments';

  test.shouldThrowErrorSync( () => _.regexpsTestAny([ 'Hello', /o/ ]) );

  test.case = 'null';

  test.shouldThrowErrorSync( () => _.regexpsTestAny([ null, 'Hello' ]) );
  test.shouldThrowErrorSync( () => _.regexpsTestAny([ 'Hello', null ]) );

  test.case = 'NaN';

  test.shouldThrowErrorSync( () => _.regexpsTestAny([ 'Hello', NaN ]) );
  test.shouldThrowErrorSync( () => _.regexpsTestAny([ NaN, 'Hello' ]) );

  test.case = 'array';

  test.shouldThrowErrorSync( () => _.regexpsTestAny([ 'h', [] ]) );

}

//

function regexpsTestNone( test )
{

  var context = this;

  test.case = 'identical strings';

  var r1 = 'abc';
  var r2 = 'abc';
  var expected = false;
  var got = _.regexpsTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings';

  var r1 = 'c';
  var r2 = 'abcd';
  var expected = true;
  var got = _.regexpsTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'One identical string, array';

  var r1 = 'abc';
  var r2 = [ 'abc', 'abcd' ];
  var expected = false;
  var got = _.regexpsTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'One identical string, array';

  var r1 = [ 'abc', 'abcd' ];
  var r2 = 'abc';
  var expected = false;
  var got = _.regexpsTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'different strings array';

  var r1 = [ 'abc', /\d/ ];
  var r2 = [ 'abd', 'a', 'b', 'c' ];
  var expected = true;
  var got = _.regexpsTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'regexps in string';

  var r1 = [ /b/, /c$/ ];
  var r2 = [ 'abc', 'hij', '6' ];
  var expected = false;
  var got = _.regexpsTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'regexps not in string';

  var r1 = [ /ba+/, /^\s/ ];
  var r2 = [ 'bcd', 'a a', '7633.32' ];
  var expected = true;

  var got = _.regexpsTestNone( r1, r2 );
  test.identical( got, expected );

  test.case = 'one regexps in only one string array';

  var r1 = [ /.abc/, /\d$/];
  var r2 = [ 'dabcd', 'efgh', 'ijkl' ];
  var expected = false;
  var got = _.regexpsTestNone( r1, r2 );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.case = 'none argument';

  test.shouldThrowErrorSync( () => _.regexpsTestNone() );

  test.case = 'not enough arguments';

  test.shouldThrowErrorSync( () => _.regexpsTestNone( 'ab' ) );

  test.case = 'too many arguments';

  test.shouldThrowErrorSync( () => _.regexpsTestNone( 'ab', 'cd', 'ef' ) );

  test.case = 'wrong order of arguments';

  test.shouldThrowErrorSync( () => _.regexpsTestNone([ 'Hello', /o/ ]) );

  test.case = 'null';

  test.shouldThrowErrorSync( () => _.regexpsTestNone([ null, 'Hello' ]) );
  test.shouldThrowErrorSync( () => _.regexpsTestNone([ 'Hello', null ]) );

  test.case = 'NaN';

  test.shouldThrowErrorSync( () => _.regexpsTestNone([ 'Hello', NaN ]) );
  test.shouldThrowErrorSync( () => _.regexpsTestNone([ NaN, 'Hello' ]) );

  test.case = 'array';

  test.shouldThrowErrorSync( () => _.regexpsTestNone([ 'h', [] ]) );

}



// --
// suite definition
// --

var Self =
{

  name : 'Tools/base/l1/Regexp',
  silencing : 1,

  tests :
  {

    regexpsAreIdentical : regexpsAreIdentical,

    regexpsSources : regexpsSources,
    regexpsJoin : regexpsJoin,
    regexpsAtLeastFirst : regexpsAtLeastFirst,

    regexpsNone : regexpsNone,
    regexpsAny : regexpsAny,
    regexpsAll : regexpsAll,

    _regexpTest : _regexpTest,
    regexpTest : regexpTest,

    regexpTestAll : regexpTestAll,
    regexpTestAny : regexpTestAny,
    regexpTestNone : regexpTestNone,

    regexpsTestAll : regexpsTestAll,
    regexpsTestAny : regexpsTestAny,
    regexpsTestNone : regexpsTestNone,

  }

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
