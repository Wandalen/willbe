( function _TemplateTreeResolver_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../l5_mapper/TemplateTreeAresolver.s' );

}

//

var _ = _global_.wTools;
var Parent = wTester;

var tree =
{

  atomic1 : 'a1',
  atomic2 : 2,
  branch1 : { a : 1, b : 'b', c : /xx/, d : '{atomic1}', e : '{atomic2}', f : '{branch2/0}', g :'{branch2/5}' },
  branch2 : [ 11, 'bb', /yy/, '{atomic1}', '{atomic2}', '{branch1/a}', '{branch1/f}' ],
  branch3 : [ 'a{atomic1}c', 'a{branch1/b}c', 'a{branch3/1}c', 'x{branch3/0}y{branch3/1}{branch3/2}z', '{branch3/0}x{branch3/1}y{branch3/2}' ],

  relative : [ 'a', '{../0}', '0{../1}0' ],

  regexp : [ /b/, /a{regexp\/0}/, /{regexp\/1}c/, /{atomic1}x{regexp\/0}y{regexp\/2}z/g ],

  error : [ '{error/a}', '{error2/0}', '{../c}', '{error/3}' ],

  array : [ 'a', 'b', 'c' ],
  map : { a : 'a', b : 'b', c : 'c' },
  arrayFromString : 'prefix {array} postfix',
  mapFromString : 'prefix {map} postfix',

  emptyString : '',
  resolveEmptyString : '{emptyString}',

}

// --
// test
// --

function select( test )
{
  var context = this;
  var template = new wTemplateTreeResolver
  ({
    tree : tree,
    prefixToken : '{',
    postfixToken : '}',
    // upToken : '/',
  });

  /* */

  var got = template.select( 'atomic1' );
  var expected = 'a1';
  test.identical( got, expected );

  var got = template.select( 'atomic2' );
  var expected = 2;
  test.identical( got, expected );

  /* */

  var got = template.select( 'branch1/a' );
  var expected = 1;
  test.identical( got, expected );

  var got = template.select( 'branch1/b' );
  var expected = 'b';
  test.identical( got, expected );

  var got = template.select( 'branch1/c' );
  var expected = /xx/;
  test.identical( got, expected );

  var got = template.select( 'branch1/d' );
  var expected = 'a1';
  var expected = '{atomic1}';
  test.identical( got, expected );

  var got = template.select( 'branch1/e' );
  var expected = 2;
  var expected = '{atomic2}';
  test.identical( got, expected );

  var got = template.select( 'branch1/f' );
  var expected = 11;
  var expected = '{branch2/0}';
  test.identical( got, expected );

  var got = template.select( 'branch1/g' );
  var expected = 1;
  var expected = '{branch2/5}';
  test.identical( got, expected );

  var got = template.select( 'branch2/0' );
  var expected = 11;
  test.identical( got, expected );

  var got = template.select( 'branch2/1' );
  var expected = 'bb';
  test.identical( got, expected );

  var got = template.select( 'branch2/2' );
  var expected = /yy/;
  test.identical( got, expected );

  var got = template.select( 'branch2/3' );
  var expected = 'a1';
  var expected = '{atomic1}';
  test.identical( got, expected );

  var got = template.select( 'branch2/4' );
  var expected = 2;
  var expected = '{atomic2}';
  test.identical( got, expected );

  var got = template.select( 'branch2/5' );
  var expected = 1;
  var expected = '{branch1/a}';
  test.identical( got, expected );

  var got = template.select( 'branch2/6' );
  var expected = 11;
  var expected = '{branch1/f}';
  test.identical( got, expected );

  /* */

  var got = template.select( 'regexp/0' );
  var expected = 11;
  var expected = /b/;
  test.identical( got, expected );

  var got = template.select( 'regexp/1' );
  var expected = /ab/;
  var expected = /a{regexp\/0}/;
  test.identical( got, expected );

  /* */

  test.open( 'throwing' );

  test.shouldThrowErrorSync( () => template.select( 'regexp/99' ) );
  test.shouldThrowErrorSync( () => template.select( 'regexp/xx' ) );
  test.shouldThrowErrorSync( () => template.select( /a{regexp\/0}/ ) );
  test.shouldThrowErrorSync( () => template.select( [] ) );

  test.close( 'throwing' );
}

//

function selectTry( test )
{
  var context = this;
  var template = new wTemplateTreeResolver
  ({
    tree : tree,
    prefixToken : '{',
    postfixToken : '}',
    // upToken : '/',
  });

  /* */

  var got = template.selectTry( 'aa' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.selectTry( 'nothing/0' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.selectTry( 'nothing/1' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.selectTry( 'nothing/2' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.selectTry( 'nothing/3' );
  var expected = undefined;
  test.identical( got, expected );

}

//

function resolve( test )
{
  var context = this;
  var template = new wTemplateTreeResolver
  ({
    tree : tree,
    prefixToken : '{',
    postfixToken : '}',
    // upToken : '/',
  });

  /* */

  test.open( 'trivial cases' );

  var got = template.resolve( 'atomic1' );
  var expected = 'atomic1';
  test.identical( got, expected );

  var got = template.resolve( '{atomic1}' );
  var expected = 'a1';
  test.identical( got, expected );

  var got = template.resolve( '{atomic2}' );
  var expected = 2;
  test.identical( got, expected );

  var got = template.resolve( 'a{atomic1}b' );
  var expected = 'aa1b';
  test.identical( got, expected );

  var got = template.resolve( '{atomic2}' );
  var expected = 2;
  test.identical( got, expected );

  test.close( 'trivial cases' );

  /* */

  test.open( 'complex cases' );

  var got = template.resolve( '{branch3/0}' );
  var expected = 'aa1c';
  test.identical( got, expected );

  var got = template.resolve( '{branch3/1}' );
  var expected = 'abc';
  test.identical( got, expected );

  var got = template.resolve( '{branch3/2}' );
  var expected = 'aabcc';
  test.identical( got, expected );

  var got = template.resolve( '0{branch3/3}0' );
  var expected = '0xaa1cyabcaabccz0';
  test.identical( got, expected );

  var got = template.resolve( '0{branch3/4}0' );
  var expected = '0aa1cxabcyaabcc0';
  test.identical( got, expected );

  test.close( 'complex cases' );

  /* */

  test.open( 'regexp cases' );

  var got = template.resolve( '{regexp/0}' );
  var expected = /b/;
  test.identical( got, expected );

  var got = template.resolve( '{regexp/1}' );
  var expected = /ab/;
  test.identical( got, expected );

  var got = template.resolve( '{regexp/2}' );
  var expected = /abc/;
  test.identical( got, expected );

  var got = template.resolve( '{regexp/3}' );
  var expected = /a1xbyabcz/g;
  test.identical( got, expected );

  var got = template.resolve( /0{regexp\/3}0/ );
  var expected = /0a1xbyabcz0/;
  test.identical( got, expected );

  test.close( 'regexp cases' );

  /* */

  test.open( 'non-string' );

  var got = template.resolve( [ '{atomic1}', '{atomic2}' ] );
  var expected = [ 'a1', 2 ];
  test.identical( got, expected );

  var got = template.resolve( { atomic1 : '{atomic1}', atomic2 : '{atomic2}' } );
  var expected = { atomic1 : 'a1', atomic2 : 2 };
  test.identical( got, expected );

  var got = template.resolve( '{branch2}' );
  var expected = [ 11, 'bb', /yy/, 'a1', 2, 1, 11 ];
  test.identical( got, expected );

  test.close( 'non-string' );

  /* */

  test.open( 'relative' );

  var got = template.resolve( '{relative/1}' );
  var expected = 'a';
  test.identical( got, expected );

  var got = template.resolve( '{relative/2}' );
  var expected = '0a0';
  test.identical( got, expected );

  test.close( 'relative' );

  /* */

  test.open( 'resolving empty string' );

  var got = template.resolve( '{resolveEmptyString}' );
  var expected = '';
  test.identical( got, expected );

  test.close( 'resolving empty string' );

  /* */

  test.open( 'throwing error' );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    template.resolve( '{aa}' );
  });

  test.shouldThrowErrorSync( function()
  {
    template.resolve( 'aa{aa}aa' );
  });

  test.shouldThrowErrorSync( function()
  {
    template.resolve( '{error/0}' );
  });

  test.shouldThrowErrorSync( function()
  {
    template.resolve( '{error/1}' );
  });

  test.shouldThrowErrorSync( function()
  {
    template.resolve( '{error/2}' );
  });

  test.shouldThrowErrorSync( function()
  {
    template.resolve( '{error/3}' );
  });

  test.shouldThrowErrorSync( function()
  {
    template.resolve( [ '{error/3}' ] );
  });

  test.shouldThrowErrorSync( function()
  {
    template.resolve( { a : '{error/3}' } );
  });

  test.shouldThrowErrorSync( function()
  {
    template.resolve( /{error\/3}/ );
  });

  test.close( 'throwing error' );

  debugger;
}

//

function resolveTry( test )
{
  var context = this;
  var template = new wTemplateTreeResolver
  ({
    tree : tree,
    prefixToken : '{',
    postfixToken : '}',
  });

  var got = template.resolveTry( '{aa}' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.resolveTry( 'aa{aa}aa' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.resolveTry( '{error/0}' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.resolveTry( '{error/1}' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.resolveTry( '{error/2}' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.resolveTry( '{error/3}' );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.resolveTry( [ '{error/3}' ] );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.resolveTry( { a : '{error/3}' } );
  var expected = undefined;
  test.identical( got, expected );

  var got = template.resolveTry( /{error\/3}/ );
  var expected = undefined;
  test.identical( got, expected );

}

//

function resolveStringToArray( test )
{

  var template = new wTemplateTreeResolver
  ({
    tree : tree,
    prefixToken : '{',
    postfixToken : '}',
    // upToken : '/',
  });

  /* */

  test.case = 'trivial cases';

  var expected = [ 'prefix a postfix', 'prefix b postfix', 'prefix c postfix' ];
  var got = template.resolve( '{arrayFromString}' );
  test.identical( got, expected );

  /* */

  test.case = 'trivial cases';

  var expected = { a : 'prefix a postfix', b : 'prefix b postfix', c : 'prefix c postfix' };
  var got = template.resolve( '{mapFromString}' );
  test.identical( got, expected );

}

//

function resolveComplex( test )
{
  function File( path )
  {
    this.filePath = path;
  }

  let tree =
  {
    complex1 : new File( '/a/b/c' ),
    complex2 : [ new File( '/x/y/z' ), new File( '/z/y/x' ) ],
    complex2_1 : [ new File( '/x/y/z' ) ],
    complex3 : { file1 : new File( '/1/2/3' ), file2 : new File( '/4/5/6' ) },
    complex4 : new Date(),
    complex5 : { file1 : '/a/b/c', file2 : '/c/b/a' },
    complex6 : [ '/a', new Date() ],
    complex7 : { file1 : '/a', date : new Date() },
    complex8 : test,
    arrayOfStrings : [ 'a', 'b' ],
  }

  var template = new wTemplateTreeResolver
  ({
    tree : tree,
    prefixToken : '{{',
    postfixToken : '}}',
    onStrFrom : onStrFrom,
    // upToken : '/',
  });

  function onStrFrom( src )
  {
    if( src instanceof File )
    return src.filePath;

    if( _.arrayIs( src ) )
    return src.map( ( e ) => e instanceof File ? e.filePath : e );

    if( _.mapIs( src ) )
    for( var k in src )
    src[ k ] = src[ k ] instanceof File ? src[ k ].filePath : src[ k ];

    return src;
  }

  /* */

  test.open( 'resolving single element' );

  var got = template.resolve( '{{complex1}}' );
  var expected = tree.complex1;
  test.identical( got, expected );

  var got = template.resolve( '{{complex1/filePath}}' );
  var expected = '/a/b/c';
  test.identical( got, expected );

  var got = template.resolve( '{{complex2}}' );
  var expected = tree.complex2;
  test.identical( got, expected );

  var got = template.resolve( '{{complex2/0/filePath}}' );
  var expected = '/x/y/z';
  test.identical( got, expected );

  var got = template.resolve( '{{complex3}}' );
  var expected = tree.complex3;
  test.identical( got, expected );

  var got = template.resolve( '{{complex3/file1/filePath}}' );
  var expected = '/1/2/3';
  test.identical( got, expected );

  test.close( 'resolving single element' );

  /* */

  test.open( 'resolving several elements with mixing' );

  var got = template.resolve( '{{complex1}} , {{complex1}}' );
  var expected = '/a/b/c , /a/b/c'
  test.identical( got, expected );

  var got = template.resolve( '{{complex1/filePath}} , {{complex2/0/filePath}}' );
  var expected = '/a/b/c , /x/y/z'
  test.identical( got, expected );

  var got = template.resolve( '{{complex1}} , {{complex2}}' );
  var expected =
  [
    '/a/b/c , /x/y/z',
    '/a/b/c , /z/y/x',
  ]
  test.identical( got, expected );

  var got = template.resolve( '{{complex2}} , {{complex1}}' );
  var expected =
  [
    '/x/y/z , /a/b/c',
    '/z/y/x , /a/b/c',
  ]
  test.identical( got, expected );

  var got = template.resolve( '{{complex1}} , {{complex3}}' );
  var expected =
  {
    file1 : '/a/b/c , /1/2/3',
    file2 : '/a/b/c , /4/5/6'
  }
  test.identical( got, expected );

  var got = template.resolve( '{{complex3}} , {{complex1}}' );
  var expected =
  {
    file1 : '/1/2/3 , /a/b/c',
    file2 : '/4/5/6 , /a/b/c'
  }
  test.identical( got, expected );

  var got = template.resolve( '{{complex2}} , {{complex2}}' );
  var expected =
  [
    '/x/y/z , /x/y/z',
    '/z/y/x , /z/y/x',
  ]
  test.identical( got, expected );

  var got = template.resolve( '{{complex2}} , {{arrayOfStrings}}' );
  var expected =
  [
    '/x/y/z , a',
    '/z/y/x , b',
  ]
  test.identical( got, expected );

  var got = template.resolve( '{{complex3}} , {{complex3}}' );
  var expected =
  {
    file1 : '/1/2/3 , /1/2/3',
    file2 : '/4/5/6 , /4/5/6'
  }
  test.identical( got, expected );

  var got = template.resolve( '{{complex3}} , {{complex5}}' );
  var expected =
  {
    file1 : '/1/2/3 , /a/b/c',
    file2 : '/4/5/6 , /c/b/a'
  }
  test.identical( got, expected );

  test.close( 'resolving several elements with mixing' );

  /* */

  test.open( 'resolving several elements, errors on resolve stage' );

  test.case = 'complex4( Date ) can not be resolved';
  var got = template.resolve( '{{complex1}} , {{complex4}}' );
  test.is( _.errIs( got ) );

  test.case = 'complex8( wTestRoutineDescriptor ) can not be resolved';
  var got = template.resolve( '{{complex8}} , {{complex1}}' );
  test.is( _.errIs( got ) );

  test.close( 'resolving several elements, errors on resolve stage' );

  /* */

  if( !Config.debug )
  return;

  test.open( 'errors on join stage' );

  test.case = 'try to mix array with map';
  test.shouldThrowErrorOfAnyKind( () =>
  {
    template.current.pop();
    template.resolve( '{{complex2}} , {{complex3}}' );
  })

  test.case = 'try to mix two arrays of different length';
  test.shouldThrowErrorOfAnyKind( () =>
  {
    template.current.pop();
    template.resolve( '{{complex2_1}} , {{complex2}}' );
  })

  test.case = 'complex6( array ) contains element of unsupported type';
  test.shouldThrowErrorOfAnyKind( () =>
  {
    template.current.pop();
    template.resolve( '{{complex1}} , {{complex6}}' );
  })

  test.case = 'complex7( map ) contains element of unsupported type';
  test.shouldThrowErrorOfAnyKind( () =>
  {
    template.current.pop();
    template.resolve( '{{complex1}} , {{complex7}}' );
  })

  test.close( 'errors on join stage' );
}

// --
// declare
// --

var Self =
{

  name : 'Tools.mid.TemplateTreeResolver',
  silencing : 1,
  // verbosity : 1,

  tests :
  {

    select,
    selectTry,

    resolve,
    resolveTry,
    resolveStringToArray,
    resolveComplex

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
