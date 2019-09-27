( function _String_toStr2_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  if( Config.platform === 'nodejs' )
  var File = require( 'fs' );

}

var _global = _global_;
var _ = _global_.wTools;

//
/*

\' 	single quote 	byte 0x27 in ASCII encoding
\" 	double quote 	byte 0x22 in ASCII encoding
\\ 	backslash 	byte 0x5c in ASCII encoding
\b 	backspace 	byte 0x08 in ASCII encoding
\f 	form feed - new page 	byte 0x0c in ASCII encoding
\n 	line feed - new line 	byte 0x0a in ASCII encoding
\r 	carriage return 	byte 0x0d in ASCII encoding
\t 	horizontal tab 	byte 0x09 in ASCII encoding
\v 	vertical tab 	byte 0x0b in ASCII encoding
\nnn 	arbitrary octal value 	byte nnn
\xnn 	arbitrary hexadecimal value 	byte nn
\unnnn 	universal character name
(arbitrary Unicode value);
may result in several characters 	code point U+nnnn
\Unnnnnnnn 	universal character name
(arbitrary Unicode value);
may result in several characters 	code point U+nnnnnnnn

source : http://en.cppreference.com/w/cpp/language/escape

*/
//

function reportChars()
{

  debugger;
  var r = '';
  for( var i = 0 ; i < 512 ; i++ )
  {
    var d = _.strDup( '0',4-i.toString( 16 ).length ) + i.toString( 16 );
    var u = eval( `"\\u${d}"` );
    r += `${d} : "${u}"\n`;
  }

  console.log( r );
  debugger;

}

/*reportChars();*/

//

function stringFromFile( name, encoding, begin, end )
{
  var str = File.readFileSync( __dirname + '/../../../file.test/' + name, encoding );
  str = str.slice( begin, end );

  //if( name === 'file1' )
  //str = str.substring( 0,10 ) + str.substring( 14 );

  return str;
}

//

function testFunction( test, desc, src, options, expected )
{
  debugger;
  var got = null;
  var result = null;
  var exp = null;
  for( var k = 0; k < src.length; ++k  )
  {
    test.case = desc ;
    var optionsTest = options[ k ] || options[ 0 ];
    got = _.toStr( src[ k ],optionsTest );

    if( test.case.slice( 0,4 ) === 'json' && optionsTest.json )
    {

      // good
      // if JSON.parse is OK,compare source vs parse result
      // else throws error
      try
      {
        result = JSON.parse( got );
        test.identical( result, src[ k ] );
      }
      catch( err )
      {
        //  throw err;
        logger.log( '1510 : ' + got.charCodeAt( 1510 ) );
        logger.log( '1511 : ' + got.charCodeAt( 1511 ) );
        logger.log( '1512 : ' + got.charCodeAt( 1512 ) );
        logger.log( 'JSON :' );
        logger.log( got );
        throw _.err( err );
        //test fail call when JSON.parse throws error
        //test.identical( 0,1 );
      }

    }
    else
    {
      test.identical( got, expected[ k ] );
    }

  }

  // test.onError = function()
  // {
  //   debugger;
  //   console.log( 'onError' );
  // }

  debugger;
}

//

function toStrUnwrapped( test )
{
  var desc =  'Error test',
  src =
  [

    /*01*/
    [
      [
        "abc",
        "edf",
        { a : 1 },
      ],
    ],

    /*02*/
    [
      {
        nameLong : "abc",
        description : "edf",
        rewardForVisitor : { a : 1 },
      },
    ],

    /*03*/
    {
      a :
      {
        nameLong : "abc",
        description : "edf",
        rewardForVisitor : { a : 1 },
      },
    },

    /*04*/
    {
      a :
      [
        "abc",
        "edf",
        { a : 1 },
      ],
    },

    /*05*/
    [
      [
        "abc",
        "edf",
        { a : 1 },
      ],
      1,
      2,
    ],

    /*06*/
    [ 'a', 7, [ 1 ], 8, 'b' ],

    /*07*/
    [ 'a', 7, { u : 1 }, 8, 'b' ],

    /*08*/
    [ [ 5, 4 ],[ 2, 1, 0 ] ],

    /*09*/
    [ [ 5, 4, [ 3 ] ],[ 2, 1, 0 ] ],

    /*10*/
    ( function( )
    {
      var structure =
      [
        {
          nameLong : "abc",
          description : "edf",
          rewardForVisitor : { a : 1 },
          stationary : 1,
          f : "f",
          quantity : 1
        },
        {
          nameLong : "abc2",
          description : "edf2",
          rewardForVisitor : { a : 1 },
          stationary : 1,
          f : "f",
          quantity : 1
        },
      ];
      return structure;
    } )( ),

    /*11*/
    {
      1 : 'a',
      2 : [ 10, 20, 30 ],
      3 : { 21 : 'aa', 22 : 'bb' },
      4 : [ 10, 20, 30 ],
      13 : [ 10, 20, 30 ],
    },

  ],
  options =
  [

    /*01*/  { wrap : 0, levels : 4 },

  ],
  expected =
  [

    /*01*/

    [
      '    "abc" ',
      '    "edf" ',
      '    a : 1',
    ].join( '\n' ),

    /*02*/

    [
      '    nameLong : "abc" ',
      '    description : "edf" ',
      '    rewardForVisitor : a : 1',
    ].join( '\n' ),

    /*03*/

    [
      '  a : ',
      '    nameLong : "abc" ',
      '    description : "edf" ',
      '    rewardForVisitor : a : 1',
    ].join( '\n' ),

    /*04*/

    [
      '  a : ',
      '    "abc" ',
      '    "edf" ',
      '    a : 1',
    ].join( '\n' ),

    /*05*/

    [
      '    "abc" ',
      '    "edf" ',
      '    a : 1 ',
      '  1 ',
      '  2',
    ].join( '\n' ),

    /*06*/

    [
      '  "a" ',
      '  7 ',
      '    1 ',
      '  8 ',
      '  "b"',
    ].join( '\n' ),

    /*07*/

    [
      '  "a" ',
      '  7 ',
      '  u : 1 ',
      '  8 ',
      '  "b"',
    ].join( '\n' ),

    /*08*/
    [
      '    5 4 ',
      '    2 1 0',
    ].join( '\n' ),

    /*09*/
    [
      '    5 ',
      '    4 ',
      '      3 ',
      '',
      '    2 1 0',
    ].join( '\n' ),

    /*10*/
    [
      '    nameLong : "abc" ',
      '    description : "edf" ',
      '    rewardForVisitor : a : 1 ',
      '    stationary : 1 ',
      '    f : "f" ',
      '    quantity : 1 ',
      '',
      '    nameLong : "abc2" ',
      '    description : "edf2',
      '    rewardForVisitor : a : 1 ',
      '    stationary : 1 ',
      '    f : "f" ',
      '    quantity : 1',

    ].join( '\n' ),

    /*11*/

    [
      '-  1 : "a" ',
      '-  2 : 10 20 30 ',
      '-  3 : 21 : "aa" 22 : "bb" ',
      '-  4 : 10 20 30 ',
      '-  13 : 10 20 30',
    ].join( '\n' ),

  ];

  testFunction( test,desc,src,options,expected );

}

// toStrUnwrapped.cover = [ _.toStr ];

//

function toStrError( test )
{
  var desc =  'Error test',
  src =
  [
    /*01*/  new Error(),
    /*02*/  new Error( 'msg' ),
    /*03*/  new Error( 'msg2' ),
    /*04*/  new Error( 'message' ),
    /*05*/  new Error( 'message2' ),
    /*06*/  new Error( 'err message' ),
    /*07*/  new Error( 'my message' ),
    /*08*/  new Error( 'my message2' ),
    /*09*/  new Error( 'my message3' ),
    /*10*/  ( function()
              {
                var err = new Error( 'my message4' );
                err.stack = err.stack.slice( 0,18 );
                return err;
              } )(),

    /*11*/  ( function()
              {
                var err = new Error( 'my error' );
                err.stack = err.stack.slice( 0,16 );
                return err;
              } )(),
  ],
  options =
  [
    /*01*/  { },
    /*02*/  { },
    /*03*/  { levels : 0 },
    /*04*/  { noError : 1 },
    /*05*/  { errorAsMap : 1 },
    /*06*/  { errorAsMap : 1, onlyEnumerable : 1 },
    /*07*/  { errorAsMap : 1, onlyEnumerable : 1, own : 0 },
    /*08*/  { errorAsMap : 1, onlyEnumerable : 0 },
    /*09*/  { errorAsMap : 1, onlyEnumerable : 0, own : 0 },
    /*10*/  { errorAsMap : 1, levels : 2 },
    /*11*/  { errorAsMap : 1, levels : 2, escaping : 1 },

  ],
  expected =
  [

    /*01*/  'Error',
    /*02*/  'Error: msg',
    /*03*/  '[object Error]',
    /*04*/  '',
    /*05*/  '{ stack : [ "Error: message2\\n   " ... "ut (timers.js:198:5)" ], message : "message2" }',
    /*06*/  '{}',
    /*07*/  '{}',
    /*08*/  '{ stack : [ "Error: my message2\\n" ... "ut (timers.js:198:5)" ], message : "my message2" }',
    /*09*/
      [
        '{',
        '  toLocaleString : [ routine toLocaleString ], ',
        '  valueOf : [ routine valueOf ], ',
        '  hasOwnProperty : [ routine hasOwnProperty ], ',
        '  isPrototypeOf : [ routine isPrototypeOf ], ',
        '  propertyIsEnumerable : [ routine propertyIsEnumerable ], ',
        '  __defineGetter__ : [ routine __defineGetter__ ], ',
        '  __lookupGetter__ : [ routine __lookupGetter__ ], ',
        '  __defineSetter__ : [ routine __defineSetter__ ], ',
        '  __lookupSetter__ : [ routine __lookupSetter__ ], ',
        '  __proto__ : [ Error with 0 elements ], ',
        '  name : "Error", ',
        '  constructor : [ routine Error ], ',
        '  toString : [ routine toString ], ',
        '  stack : [ "Error: my message3\\n" ... "ut (timers.js:198:5)" ], ',
        '  message : "my message3"',
        '}',
      ].join( '\n' ),

    /*10*/
      [
        '{ stack : "Error: my message4", message : "my message4" }',
      ].join( '\n' ),

    /*11*/
      [
        '{ stack : "Error: my error\\n", message : "my error" }',
      ].join( '\n' ),
  ];


  testFunction( test,desc,src,options,expected );

}

// toStrError.cover = [ _.toStr ];

//

function toStrArray( test )
{
  var  desc = 'Array test',
  src =
  [
    /*01*/ [ 1, 2, 3 ],
    /*02*/ [ { a : 1 }, { b : 2 } ],
    /*03*/ [ function( ){ }, function add( ){ } ],
    /*04*/ [ 1000, 2000, 3000 ],
    /*05*/ [ 1.1111, 2.2222, 3.3333 ],
    /*06*/ [ 0, 1, 2 ],
    /*07*/ [  7, { v : 0 }, 1, 'x' ],
    /*08*/ [ 'e', 'e', 'e' ],
    /*09*/ [ '\n\nEscaping test' ],
    /*10*/ [ 0, 1, 2 ],
    /*11*/ [ 'a','b','c', 1, 2, 3 ],
    /*12*/ [ { x : 1 }, { y : 2 } ],
    /*13*/ [ 1, [ 2, 3, 4 ], 5 ],
    /*14*/ [ 6, [ 7, 8, 9 ], 10 ],
    /*15*/ [ { k : 3 }, { l : 4 } ],
    /*16*/ [ 1, { a : 2 }, 5 ],
    /*17*/ [ 0, { b : 1 }, 3 ],
    /*18*/ [ 'a', 7, { u : 2 }, 8, 'b' ],
    /*19*/ [ function f1( ){ }, function( ){ } ],
    /*20*/ [ function f2( ){ }, function f3( ){ } ],
    /*21*/ [ { a : { a : '1' } } ],
    /*22*/ [ { c : 1 }, { d : 2 } ],
    /*23*/ [ new Date( Date.UTC( 1993, 12, 12 ) ), { d : 2 }, new Error( 'error' ) ],
    /*24*/ [ function ff( ){ }, { d : 3 }, 15 ],
    /*25*/ [ [ 1, 2, 3 ],[ 4, 5, 6 ] ],
    /*26*/ [ [ 1, 2, 3 ],[ '4, 5, 6' ], undefined, false ],
    /*27*/ [ 'e', 'e', 'e' ],
    /*28*/ [ 'a','b','c', 1, 2, 3 ],
    /*29*/ [ 15, 16, 17, 18 ],
    /*30*/ [ { a : 5, b : 6, c : 7 } ],
    /*31*/ [ 'a', 1, function() { }, false ],
    /*32*/ [ 'b', 2, function() { }, true ],
    /*33*/ [ function() { } ],
    /*34*/ [ 'a', 1000, 2000, 3000 ],
    /*35*/ [ 1.1111, 2.2222, 3.3333 ],
    /*36*/ [  7, { v : 0 }, 1, 'x' ],
    /*37*/ [ '\n\nEscaping & wrap test' ],
    /*38*/ [ 0, [ 1, 2, 3, 4 ], 5, { a : 6 } ],
    /*39*/ [ ['a','b','c'],'d','e' ],
    /*40*/ [ { a : 0 }, { b : 1 }, [ 2, 3 ] ],
    /*41*/ [ { a : 'a', b : 'b', c : 'c' } ],
    /*42*/ [ 'a', 7, { u : 2 }, 8, 'b' ],
    /*43*/ [ 0.1111, 0.2222, 0.3333 ],
    /*44*/ [ 'x', 2000, 3000, 4000 ],
    /*45*/ [ 0, { b : 1 }, 3 ],
    /*46*/ [ { a : '\na', b : { d : '\ntrue' } } ],
    /*47*/ [ { x : '\na', y : { z : '\ntrue' } } ],
    /*48*/ [ 1, { a : 2 }, '03' ],
    /*49*/ [ 0, [ 1, 2, 3, 4 ], 5, { a : 6 } ],
    /*50*/ [ { a : 'string' }, [ true ], 1 ],
    /*51*/ [ [ 5, 4, [ 3 ] ],[ 2, 1, 0 ] ],
    /*52*/ [ { a : 0 }, { b : 1 }, [ 2, 3 ] ],
    /*53*/ [ [ 1.100,1.200 ], [ 2, 3 ] ],
    /*54*/ [ 9000,[ 8000, 6000], 7000 ],
    /*55*/ [ { a : '\\test' }, { b : '\ntest' }, { c : 'test' } ],
    /*56*/ [ { a : function func ( ){ } }, 0, 1, 'a' ],
    /*57*/ [ { b : function f ( ){ } }, 1, 2 , 3 ],
    /*58*/ [ new Error('msg'),new Date(1990, 0, 0),'test' ],
    /*59*/ [ 1, [ 2, 3, 4 ], 2 ],
    /*60*/ [ 1, [ '2', null,undefined, '4' ], 2 ],
    /*61*/ [ [ 1, 2 ],'string',{ a : true, b : null }, undefined ],
    /*62*/ [ [ 0, 1 ],'test',{ a : Symbol() }, undefined ],
    /*63*/ [ 0, 'str', { a : Symbol() },function test(){ }, null ],
    /*64*/ [ 0, 'str', { a : Symbol() },function test( ){ }, true, new Date(1990, 0, 0) ],
    /*65*/ [ [ 0, 1 ],'test', { a : 'a' } ],
    /*66*/ [ [ 1, 2 ],'sample', { a : 'b' } ],
    /*67*/ [ 11,22,function routine( ){ }, { a : 'string' } ],
    /*68*/ [ ['a',100],['b',200] ],
    /*69*/ [ ['aa',300],['bb',400] ],
    /*70*/ [ [ 1.00, 2.00 ], [ 3.00, 4.00],'str sample' ],
    /*71*/ [ '1', [ 2, 3, 4 ], '2' ],
    /*72*/ [ '1', [ 2.00, 3.00, 4.00 ], '2' ],
    /*73*/ [ 'o', [ 90, 80, 70 ], 'o' ],
    /*74*/ [ 'o', 1, { a : true, b : undefined, c : null } ],
    /*75*/ [ 'a', 2, { a : '\\true', b : true, c : null } ],
    /*76*/ [ [ 'a', 1 ], new Error( 'err msg' ), new Date(1990, 0, 0) ],
    /*77*/ [ [ 'a', 1 ], new Date(1999, 1, 1) ],
    /*78*/ [ [ 1, 2, 3 ], 'a' ],

  ],
  options =
  [
    /*01*/ { },
    /*02*/ { },
    /*03*/ { },
    /*04*/ { precision : 2, multiline : 1 },
    /*05*/ { fixed : 2 },
    /*06*/ { noArray : 1 },
    /*07*/ { noAtomic : 1 },
    /*08*/ { noArray : 1 },
    /*09*/ { escaping : 1, levels : 2 },
    /*10*/ { levels : 0 },
    /*11*/ { levels : 2, noString : 1 },
    /*12*/ { levels : 2, dtab : '-' },
    /*13*/ { levels : 2, multiline : 1 },
    /*14*/ { levels : 2, noNumber : 1 },
    /*15*/ { levels : 2, colon : '->' },
    /*16*/ { levels : 2, noObject : 1 },
    /*17*/ { levels : 2, noNumber : 1 },
    /*18*/ { levels : 2, noAtomic : 1 },
    /*19*/ { levels : 2 },
    /*20*/ { levels : 2, noRoutine : 1 },
    /*21*/ { levels : 3, noSubObject : 1 },
    /*22*/ { levels : 2, tab : '|', prependTab : 0 },
    /*23*/ { levels : 2, noError : 1, noDate : 1 },
    /*24*/ { levels : 2, noRoutine : 1, noSubObject : 1 },

    /*25*/  { wrap : 0, comma : ' | ' },
    /*26*/  { wrap : 0, noString : 1, noNumber: 1, comma : ', ' },
    /*27*/  { wrap : 0, comma : ' ' },
    /*28*/  { wrap : 0, prependTab : 0, comma : ', ' },
    /*29*/  { wrap : 0, tab : '| ', dtab : '', comma : '. ' },
    /*30*/  { wrap : 0, colon : '->', comma : '.' },
    /*31*/  { wrap : 0, noRoutine : 1, comma : '. ' },
    /*32*/  { wrap : 0, noAtomic : 1, comma : '. ' },
    /*33*/  { wrap : 0, onlyRoutines : 1, comma : '| ' },
    /*34*/  { wrap : 0, precision : 3, comma : '* ' },
    /*35*/  { wrap : 0, fixed : 3, comma : ', ' },
    /*36*/  { wrap : 0, multiline : 1, comma : '. ' },
    /*37*/  { wrap : 0, escaping : 1, comma : '. ' },

    /*38*/  { levels : 2, wrap : 0, comma : '- ' },
    /*39*/  { levels : 2, wrap : 0, comma : '. '},
    /*40*/  { levels : 2, wrap : 0, tab : '| ', dtab : '', comma : ', ' },
    /*41*/  { levels : 2, wrap : 0, colon : ' - ', comma : '| ' },
    /*42*/  { levels : 2, wrap : 0, prependTab : 0, comma : ', ' },
    /*43*/  { levels : 2, wrap : 0, fixed : 1, comma : '* ' },
    /*44*/  { levels : 2, wrap : 0, precision : 1, comma : ', ' },
    /*45*/  { levels : 2, wrap : 0, multiline : 1, comma : '| ' },
    /*46*/  { levels : 3, wrap : 0, escaping : 1, comma : '. ' },
    /*47*/  { levels : 4, wrap : 0, escaping : 1, comma : ', ' },
    /*48*/  { levels : 3, wrap : 0, noAtomic : 1, comma : ' ,' },
    /*49*/  { levels : 2, wrap : 0, noSubObject : 1, noArray : 1, comma : ' ..' },
    /*50*/  { levels : 2, wrap : 0, noString : 1, noNumber : 1, comma : '/ ' },

    /*51*/  { levels : 3, wrap : 0, comma : '||' },
    /*52*/  { levels : 2, wrap : 0, comma : ',, ', tab :'  |', colon : '->' },
    /*53*/  { levels : 2, prependTab : 0, fixed : 2 },
    /*54*/  { levels : 2, prependTab : 0, precision : 1 },
    /*55*/  { levels : 2, multiline : 1, escaping : 1 },
    /*56*/  { levels : 2, noRoutine : 1 },
    /*57*/  { levels : 3, noRoutine : 1 },
    /*58*/  { levels : 3, noError : 1, noDate : 1 },
    /*59*/  { levels : 2, noArray : 1 },
    /*60*/  { levels : 2, noNumber : 1, noString : 1 },
    /*61*/  { levels : 2, noNumber : 1, noString : 1, noObject : 1 },
    /*62*/  { levels : 3, noNumber : 1, noString : 1, noObject : 1 },
    /*63*/  { levels : 2, noNumber : 1, noString : 1, noObject : 1, noRoutine : 1 },
    /*64*/  { levels : 2, noNumber : 1, noString : 1, noObject : 1, noRoutine : 1, noDate : 1 },
    /*65*/  { levels : 2, noNumber : 1, noString : 1, noSubObject : 1 },
    /*66*/  { levels : 3, noNumber : 1, noString : 1, noSubObject : 1 },
    /*67*/  { levels : 2, noNumber : 1, noString : 1, onlyRoutines : 1 },
    /*68*/  { levels : 2, noString : 1, precision : 2 },
    /*69*/  { levels : 3, noString : 1, precision : 3 },
    /*70*/  { levels : 2, noString : 1, fixed : 3 },
    /*71*/  { levels : 2, noString : 1, noNumber : 1, precision : 1 },
    /*72*/  { levels : 2, noString : 1, noNumber : 1, fixed : 1 },
    /*73*/  { levels : 3, noString : 1, noNumber : 1, precision : 1 },
    /*74*/  { levels : 2, noString : 1, noNumber : 1, multiline : 1 },
    /*75*/  { levels : 2, noString : 1, noNumber : 1, multiline : 1, escaping : 1 },
    /*76*/  { levels : 2, noString : 1, noNumber : 1, noError : 1 },
    /*77*/  { levels : 2, noString : 1, noNumber : 1, tab : '|', prependTab : 0 },
    /*78*/  { levels : 3, noAtomic : 1, noNumber : 0 },


  ],
  expected =
  [
    /*01*/ '[ 1, 2, 3 ]',
    /*02*/
    [
      '[',
      '  [ Object with 1 elements ], ',
      '  [ Object with 1 elements ]',
      ']'
    ].join( '\n' ),

    /*03*/ '[ [ routine without name ], [ routine add ] ]',
    /*04*/
    [
      '[',
      '  1.0e+3, ',
      '  2.0e+3, ',
      '  3.0e+3',
      ']',
    ].join( '\n' ),

    /*05*/ '[ 1.11, 2.22, 3.33 ]',

    /*06*/ '',


    /*07*/
    [
      '[',
      '  [ Object with 1 elements ]',
      ']'
    ].join( '\n' ),

    /*08*/ '',


    /*09*/ '[ "\\n\\nEscaping test" ]',

    /*10*/ '[ Array with 3 elements ]',
    /*11*/ '[ 1, 2, 3 ]',
    /*12*/
    [
      '[',
      '-{ x : 1 }, ',
      '-{ y : 2 }',
      ']'
    ].join( '\n' ),

    /*13*/
    [
      '[',
      '  1, ',
      '  [',
      '    2, ',
      '    3, ',
      '    4',
      '  ], ',
      '  5',
      ']',

    ].join( '\n' ),

    /*14*/
    [
      '[',
      '  []',
      ']'
    ].join( '\n' ),

    /*15*/
    [
      '[',
      '  { k->3 }, ',
      '  { l->4 }',
      ']'
    ].join( '\n' ),

    /*16*/
    [

      '[ 1, 5 ]'

    ].join( '\n' ),

    /*17*/
    [
      '[',
      '  {}',
      ']'
    ].join( '\n' ),

    /*18*/
    [
      '[',
      '  {}',
      ']'
    ].join( '\n' ),

    /*19*/ '[ [ routine f1 ], [ routine without name ] ]',
    /*20*/ '[]',
    /*21*/
    [
      '[',
      '  {}',
      ']'
    ].join( '\n' ),

    /*22*/
    [
      '[',
      '|  { c : 1 }, ',
      '|  { d : 2 }',
      '|]',
    ].join( '\n' ),

    /*23*/
    [
      '[',
      '  { d : 2 }',
      ']',
    ].join( '\n' ),

    /*24*/
    [
      '[',
      '  { d : 3 }, ',
      '  15',
      ']',
    ].join( '\n' ),

    /*25*/
    [
      '  [ Array with 3 elements ] | ',
      '  [ Array with 3 elements ]',
    ].join( '\n' ),

    /*26*/
    [
      '  undefined, false',
    ].join( '\n' ),

    /*27*/
    '  "e" "e" "e"',

    /*28*/
    '  "a", "b", "c", 1, 2, 3',
    /*29*/
    '| 15. 16. 17. 18',
    /*30*/
    '  [ Object with 3 elements ]',
    /*31*/
    '  "a". 1. false',
    /*32*/
    '  [ routine without name ]',
    /*33*/
    '',
    /*34*/
    '  "a"* 1.00e+3* 2.00e+3* 3.00e+3',

    /*35*/
    '  1.111, 2.222, 3.333',
    /*36*/
    [
      '  7. ',
      '  [ Object with 1 elements ]. ',
      '  1. ',
      '  "x"',
    ].join( '\n' ),

    /*37*/
    '  "\\n\\nEscaping & wrap test"',

    /*38*/
    [
      '  0- ',
      '    1- 2- 3- 4- ',
      '  5- ',
      '  a : 6',
    ].join( '\n' ),

    /*39*/
    [
      '    "a". "b". "c". ',
      '  "d". ',
      '  "e"'
    ].join( '\n' ),

    /*40*/
    [
      '| a : 0, ',
      '| b : 1, ',
      '| 2, 3'
    ].join( '\n' ),

    /*41*/
    [
      '  a - "a"| b - "b"| c - "c"'
    ].join( '\n' ),

    /*42*/
    [
      '  "a", ',
      '  7, ',
      '  u : 2, ',
      '  8, ',
      '  "b"',
    ].join( '\n' ),

    /*43*/
    [
      '  0.1* 0.2* 0.3',
    ].join( '\n' ),

    /*44*/
    [
      '  "x", 2e+3, 3e+3, 4e+3',
    ].join( '\n' ),

    /*45*/
    [
      '  0| ',
      '    b : 1| ',
      '  3',
    ].join( '\n' ),

    /*46*/
    [
      '    a : "\\na". ',
      '    b : d : "\\ntrue"',
    ].join( '\n' ),

    /*47*/
    [
      '    x : "\\na", ',
      '    y : z : "\\ntrue"',
    ].join( '\n' ),

    /*48*/
    [
      '',
    ].join( '\n' ),

    /*49*/
    [
      '',
    ].join( '\n' ),

    /*50*/
    [
      '    true'
    ].join( '\n' ),

//[ { a : 'string' }, [ true ], 1 ],
//{ levels : 2, wrap : 0, noString : 1, noNumber : 1, comma : '/ ' },

    /*51*/ // !!! please move to toStrUnwrapped
    [
      '    5||',
      '    4||',
      '      3||',
      '',
      '    2||1||0',
    ].join( '\n' ),

    /*52*/
    [
      '  |  a->0,, ',
      '  |  b->1,, ',
      '  |    2,, 3',
    ].join( '\n' ),

    /*53*/
    [
      '[',
      '  [ 1.10, 1.20 ], ',
      '  [ 2.00, 3.00 ]',
      ']',
    ].join( '\n' ),

    /*54*/
    [
      '[',
      '  9e+3, ',
      '  [ 8e+3, 6e+3 ], ',
      '  7e+3',
      ']',
    ].join( '\n' ),

    /*55*/
    [
      '[',
      '  {',
      '    a : "\\\\test"',
      '  }, ',
      '  {',
      '    b : "\\ntest"',
      '  }, ',
      '  {',
      '    c : "test"',
      '  }',
      ']',
    ].join( '\n' ),

    /*56*/
    [
      '[',
      '  {}, ',
      '  0, ',
      '  1, ',
      '  "a"',
      ']',
    ].join( '\n' ),

    /*57*/
    [
      '[',
      '  {}, ',
      '  1, ',
      '  2, ',
      '  3',
      ']',
    ].join( '\n' ),

    /*58*/
    [
      '[ "test" ]',
    ].join( '\n' ),

    /*59*/
     '',

    /*60*/

    [ '[',
      '  [ null, undefined ]',
      ']',
    ].join( '\n' ),

    /*61*/

    [ '[',
      '  [], ',
      '  undefined',
      ']',
    ].join( '\n' ),

    /*62*/

    [ '[',
      '  [], ',
      '  undefined',
      ']',
    ].join( '\n' ),

    /*63*/

    [
      '[ null ]',
    ].join( '\n' ),

    /*64*/

    [
      '[ true ]',
    ].join( '\n' ),

    /*65*/

    [ '[',
      '  [], ',
      '  {}',
      ']',
    ].join( '\n' ),

    /*66*/

    [ '[',
      '  [], ',
      '  {}',
      ']',
    ].join( '\n' ),

    /*67*/

    [
      ''
    ].join( '\n' ),

    /*68*/

    [
      '[',
      '  [ 1.0e+2 ], ',
      '  [ 2.0e+2 ]',
      ']'
    ].join( '\n' ),

    /*69*/

    [
      '[',
      '  [ 300 ], ',
      '  [ 400 ]',
      ']'
    ].join( '\n' ),

    /*70*/

    [
      '[',
      '  [ 1.000, 2.000 ], ',
      '  [ 3.000, 4.000 ]',
      ']'
    ].join( '\n' ),

    /*71*/

    [
      '[',
      '  []',
      ']'
    ].join( '\n' ),

    /*72*/

    [
      '[',
      '  []',
      ']'
    ].join( '\n' ),

    /*73*/

    [
      '[',
      '  []',
      ']'
    ].join( '\n' ),

    /*74*/

    [
      '[',
      '  {',
      '    a : true, ',
      '    b : undefined, ',
      '    c : null',
      '  }',
      ']'
    ].join( '\n' ),

    /*75*/

    [
      '[',
      '  {',
      '    b : true, ',
      '    c : null',
      '  }',
      ']'
    ].join( '\n' ),

    /*76*/

    [
      '[',
      '  [], ',
      '  1989-12-30T22:00:00.000Z',
      ']'
    ].join( '\n' ),

    /*77*/

    [
      '[',
      '|  [], ',
      '|  1999-01-31T22:00:00.000Z',
      '|]'
    ].join( '\n' ),

    /*78*/

    [
      '[',
      '  []',
      ']'
    ].join( '\n' ),


  ];

  testFunction( test,desc,src,options,expected );
}
// toStrArray.cover = [ _.toStr ];

//

function toStrObject( test )
{
  var desc =  'Object test',
  src =
  [
    /*01*/  { a : 1, b : 2, c : 3 },
    /*02*/  { x : 3, y : 5, z : 5 },
    /*03*/  { q : 6, w : 7, e : 8 },
    /*04*/  { u : 12, i : { o : 13 }, p : 14 },
    /*05*/  { r : 9, t : { a : 10 }, y : 11 },
      /* redundant */
    /*06*/  { z : '01', x : { c : { g : 4 } }, v : '03' },
    /*07*/  { u : 12, i : { o : { x : { y : [ 1, 2, 3 ] } } }, p : 14 },
      /* redundant */
    /*08*/  { q : { a : 1 }, w : 'c', e : [1] },
    /*09*/  { z : '02', x : { c : { g : 6 } }, v : '01' },
    /*10*/  { h : { d : 1 }, g : 'c', c : [2] },
    /*11*/  { a : 6, b : 7, c : 1 },
    /*12*/  { a : true, b : '2', c : 3, d : undefined },
    /*13*/  { a : null, b : 1, c : '2', d : undefined, e : true, f : Symbol( 'symbol' ) },
    /*14*/  { a : 'true', b : 2, c : false, d : undefined },
    /*15*/  { e : new Error('msg') },
    /*16*/  { f : 1, g : function f(  ) { } },
    /*17*/  { x : function y(  ) { } },
    /*18*/  { a : null, b : 1, c : '2', d : undefined },
    /*19*/  { e : function r( ) { }, f : 1, g : '2', h : [ 1 ] },
    /*20*/  { i : 0, k : 1, g : 2, l : 3 },
    /*21*/  { o : 4, p : 5, r : 6, s : 7 },
    /*22*/  { m : 8, n : 9 },
    /*23*/  { x : '\n10', z : '\\11' },
    /*24*/  { a : 1, b : { d : 2 }, c : 3 },
    /*25*/  { a : 3, b : { d : 2 }, c : 1 },
    /*26*/  { a : 4, b : { d : 5 }, c : 6 },
    /*27*/  { a : 7, b : { d : 8 }, c : 9 },
    /*28*/  { a : 9, b : { d : 8 }, c : 7 },
    /*29*/  { a : 10, b : { d : 20 }, c : 30 },
    /*30*/  { a : 10.00, b : { d : 20.00 }, c : 30.00 },
    /*31*/  { a : 'a', b : { d : false }, c : 3 },
    /*32*/  { a : '\na', b : { d : '\ntrue' }, c : '\n' },
    /*33*/  { a : 'a', b : { d : false }, c : 3 },
    /*34*/  { a : 'aa', b : { d : true }, c : 40 },
    /*35*/  { a : [ 'a','b' ], b : { d : 'true' }, c : 1 },
    /*36*/  { a : [ 'a','b' ], b : { d : 'true' }, c : 1 },
    /*37*/  { a : 1, b : { d : 2 }, c : 3 },
    /*38*/  { a : 3, b : { d : 2 }, c : 1 },
    /*39*/  { a : 'bb', b : { d : false }, c : 30 },
    /*40*/  { a : 100, b : { d : 110 }, c : 120 },
    /*41*/  { a : '\na', b : { d : '\ntrue' } },
    /*42*/  { a : 'aa', b : { d : function(){ } } },
    /*43*/  { a : 'bb', b : { d : function(){ } } },
    /*44*/  { a : new Date( Date.UTC( 1993, 12, 12 ) ), b : { d : new Error( 'msg' ) }, c : 1 },
    /*45*/  { "sequence" : "\u001b[A", "name" : "undefined", "shift" : false, "code" : "[A"  },
    /*46*/  { "sequence" : "\x7f[A", "name" : "undefined", "shift" : false, "code" : "[A"  },
    /*47*/  { "sequence" : "<\u001cb>text<\u001cb>", "data" : { "name" : "myname", "age" : 1 }, "shift" : false, "code" : "<b>text<b>"  },
    /*48*/  { "sequence" : "\u0068\u0065\u004C\u004C\u006F", "shift" : false, "code" : "heLLo"  },
    /*49*/  { "sequence" : "\n\u0061\u0062\u0063", "shift" : false, "code" : "abc"  },
    /*50*/  { "sequence" : "\t\u005b\u0063\u0062\u0061\u005d\t", "data" : 100, "code" : "\n[cba]\n"  },
    /*51*/  { "sequence" : "\u005CABC\u005C", "data" : 100, "code" : "\\ABC\\"  },
    /*52*/  { "sequence" : "\u000Aline\u000A", "data" : null, "code" : "\nline\n"  },
    /*53*/  { "sequence" : "\rspace\r",  },
    /*54*/  { "sequence" : "\btest",  },
    /*55*/  { "sequence" : "\vsample",  },
    /*56*/  { "sequence" : "\ftest",  },
    /*57*/  { a : 1, b : { d : 'string' }, c : true },
    /*58*/  { a : 1, b : { d : 'string' }, c : new Date() },
    /*59*/  { a : 1000, b : { d : 'string' }, c : 1.500 },
    /*60*/  { a : 1000, b : 'text', c : 1.500 },
    /*61*/  { a : 1000, b : 'text', c : false, d : undefined, e : null},
    /*62*/  { a : 1001, b : 'text', c : false, d : undefined, e : null},
    /*63*/  ( function( ) //own:0 option test
            {
              var x = { a : 1, b : 2 },
              y = Object.create( x );
              y.c = 3;
              return y;
            } )( ),

    /*64*/  ( function( ) //own:1 option test
            {
              var x = { a : '0', b : '1' },
              y = Object.create( x );
              y.c = '3';
              return y;
            } )( ),

    /*65*/  { "sequence" : "\u001b[A", "name" : "undefined", "shift" : false, "code" : "[A"  },

  ],
  options =
  [
    /*01*/  { },
    /*02*/  { levels : 0 },
    /*03*/  { levels : 1 },
    /*04*/  { levels : 1 },
    /*05*/  { levels : 2 },

      /* redundant */
    /*06*/  { levels : 3 },
    /*07*/  { levels : 5 },
      /* redundant */

    /*08*/  { levels : 2, noSubObject : 1, noArray : 1 },
    /*09*/  { levels : 3, noAtomic : 1 },
    /*10*/  { levels : 2, noObject : 1 },


    /*11*/  { wrap : 0, comma : ' | ' },
    /*12*/  { wrap : 0, noString : 1, noNumber: 1, comma : ', ' },
    /*13*/  { wrap : 0, comma : '* ' },
    /*14*/  { wrap : 0, prependTab : 0, comma : '-> ' },
    /*15*/  { wrap : 0, tab : '| ', dtab : '', comma : '> ' },
    /*16*/  { wrap : 0, colon : '', comma : ' ' },
    /*17*/  { wrap : 0, noRoutine : 1, comma : '.. ' },
    /*18*/  { wrap : 0, noAtomic : 1, comma : ', ' },
    /*19*/  { wrap : 0, onlyRoutines : 1, comma : '<< ' },
    /*20*/  { wrap : 0, precision : 3, comma : '| ' },
    /*21*/  { wrap : 0,  fixed : 3, comma : '^ ' },
    /*22*/  { wrap : 0,  multiline : 1, comma : ', ' },
    /*23*/  { wrap : 0,  escaping : 1, comma : '| ' },

    /*24*/  { levels : 2, wrap : 0, comma : '. ' },
    /*25*/  { levels : 2, wrap : 0, comma : '. '},
    /*26*/  { levels : 2, wrap : 0, tab : '| ', dtab : '', comma : '@ ' },
    /*27*/  { levels : 2, wrap : 0, colon : ' - ', comma : '-? ' },
    /*28*/  { levels : 2, wrap : 0, prependTab : 0, comma : ', ' },
    /*29*/  { levels : 2, wrap : 0, fixed : 1, comma : '| ' },
    /*30*/  { levels : 2, wrap : 0, precision : 1, comma : '/ ' },
    /*31*/  { levels : 2, wrap : 0, multiline : 1, comma : ',, ' },
    /*32*/  { levels : 3, wrap : 0, escaping : 1, comma : '| ' },
    /*33*/  { levels : 2, wrap : 0, noAtomic : 1, comma : '< ' },
    /*34*/  { levels : 3, wrap : 0, noAtomic : 1, comma : ', ' },
    /*35*/  { levels : 2, wrap : 0, noSubObject : 1, noArray : 1, comma : '' },
    /*36*/  { levels : 2, wrap : 0, noString : 1, noNumber : 1, comma : '. ' },
    /*37*/  { levels : 2, wrap : 0, comma : '. '},
    /*38*/  { levels : 2, wrap : 0, comma : ',, ', tab :'  |', colon : '->' },
    /*39*/  { levels : 2, prependTab : 0, fixed : 5 },
    /*40*/  { levels : 2, prependTab : 0, precision : 5 },
    /*41*/  { levels : 2, multiline : 1, escaping : 1 },
    /*42*/  { levels : 2, noRoutine : 1 },
    /*43*/  { levels : 3, noRoutine : 1,},
    /*44*/  { levels : 3, noError : 1, noDate : 1 },
    /*45*/  { escaping : 1 },
    /*46*/  { escaping : 0 },
    /*47*/  { escaping : 0 },
    /*48*/  { multiline : 1 },
    /*49*/  { levels : 2, multiline : 1, escaping : 1 },
    /*50*/  { levels : 2, multiline : 1, escaping : 1 },
    /*51*/  { levels : 2, multiline : 1, escaping : 1 },
    /*52*/  { levels : 2, multiline : 1, escaping : 1 },
    /*53*/  { levels : 2, escaping : 1 },
    /*54*/  { levels : 2, escaping : 1 },
    /*55*/  { levels : 2, escaping : 1 },
    /*56*/  { levels : 2, escaping : 1 },
    /*57*/  { levels : 3, noNumber : 1, noString : 1},
    /*58*/  { levels : 3, noNumber : 1, noString : 1, noDate : 1},
    /*59*/  { levels : 2, noString : 1, fixed : 1},
    /*60*/  { levels : 2, noString : 1, precision : 1},
    /*61*/  { levels : 2, noString : 1, noNumber :1, tab : '-', prependTab : 0 },
    /*62*/  { levels : 2, noAtomic : 1, noNumber : 0 },
    /*63*/  { own : 0},
    /*64*/  {  },
    /*65*/  {  },

  ],
  expected =
  [
    /*01*/  '{ a : 1, b : 2, c : 3 }',
    /*02*/  '[ Object with 3 elements ]',
    /*03*/  '{ q : 6, w : 7, e : 8 }',

    /*04*/
    [
      '{',
      '  u : 12, ',
      '  i : [ Object with 1 elements ], ',
      '  p : 14',
      '}'
    ].join( '\n' ),

    /*05*/
    [
      '{',
      '  r : 9, ',
      '  t : { a : 10 }, ',
      '  y : 11',
      '}'
    ].join( '\n' ),

      /* redundant */
    /*06*/
    [
      '{',
      '  z : "01", ',
      '  x : ',
      '  {',
      '    c : { g : 4 }',
      '  }, ',
      '  v : "03"',
      '}'
    ].join( '\n' ),

    /*07*/
    [
      '{',
      '  u : 12, ',
      '  i : ',
      '  {',
      '    o : ',
      '    {',
      '      x : ',
      '      {',
      '        y : [ 1, 2, 3 ]',
      '      }',
      '    }',
      '  }, ',
      '  p : 14',
      '}'
    ].join( '\n' ),
    /* redundant */

    /*08*/
    [
      '{',
      '  w : "c"',
      '}'
    ].join( '\n' ),

    /*09*/
    [
      '{',
      '  x : ',
      '  {',
      '    c : {}',
      '  }',
      '}'
    ].join( '\n' ),

    /*10*/  '',


    /*11*/  'a : 6 | b : 7 | c : 1',

    /*12*/
    [
      'a : true, d : undefined'

    ].join( '\n' ),

    /*13*/
    [
      '  a : null* ',
      '  b : 1* ',
      '  c : "2"* ',
      '  d : undefined* ',
      '  e : true* ',
      '  f : Symbol(symbol)'

    ].join( '\n' ),

    /*14*/
    [
      '  a : "true"-> ',
      '  b : 2-> ',
      '  c : false-> ',
      '  d : undefined'

    ].join( '\n' ),

    /*15*/

      '| e : [object Error]',

    /*16*/

      'f1 g[ routine f ]',

    /*17*/

      '',

    /*18*/
    [
      ''

    ].join( '\n' ),

    /*19*/

    '',

    /*20*/

    [
      '  i : 0.00| ',
      '  k : 1.00| ',
      '  g : 2.00| ',
      '  l : 3.00'

    ].join( '\n' ),

    /*21*/

    [
      '  o : 4.000^ ',
      '  p : 5.000^ ',
      '  r : 6.000^ ',
      '  s : 7.000'

    ].join( '\n' ),

    /*22*/

    [
      '  m : 8, ',
      '  n : 9'

    ].join( '\n' ),

    /*23*/

    'x : "\\n10"| z : "\\\\11"',

    /*24*/
    [
      '  a : 1. ',
      '  b : d : 2. ',
      '  c : 3'

    ].join( '\n' ),

    /*25*/
    [
      '  a : 3. ',
      '  b : d : 2. ',
      '  c : 1'

    ].join( '\n' ),

    /*26*/
    [
      '| a : 4@ ',
      '| b : d : 5@ ',
      '| c : 6'

    ].join( '\n' ),

    /*27*/
    [
      '  a - 7-? ',
      '  b - d - 8-? ',
      '  c - 9'

    ].join( '\n' ),

    /*28*/
    [
      '  a : 9, ',
      '  b : d : 8, ',
      '  c : 7'

    ].join( '\n' ),

    /*29*/
    [
      '  a : 10.0| ',
      '  b : d : 20.0| ',
      '  c : 30.0'

    ].join( '\n' ),

    /*30*/
    [
      '  a : 1e+1/ ',
      '  b : d : 2e+1/ ',
      '  c : 3e+1'
    ].join( '\n' ),

    /*31*/
    [
      '  a : "a",, ',
      '  b : ',
      '    d : false,, ',
      '  c : 3'
    ].join( '\n' ),

    /*32*/
    [
      '  a : "\\na"| ',
      '  b : d : "\\ntrue"| ',
      '  c : "\\n"'

    ].join( '\n' ),

    /*33*/
    '',

    /*34*/
    '',

    /*35*/
    '  c : 1',

    /*36*/
    [
      '',
    ].join( '\n' ),

    /*37*/
    [
      '  a : 1. ',
      '  b : d : 2. ',
      '  c : 3',
    ].join( '\n' ),

    /*38*/
    [
      '  |  a->3,, ',
      '  |  b->d->2,, ',
      '  |  c->1',
    ].join( '\n' ),

    /*39*/
    [
      '{',
      '  a : "bb", ',
      '  b : { d : false }, ',
      '  c : 30.00000',
      '}'

    ].join( '\n' ),

    /*40*/
    [
      '{',
      '  a : 100.00, ',
      '  b : { d : 110.00 }, ',
      '  c : 120.00',
      '}'

    ].join( '\n' ),

    /*41*/
    [
      '{',
      '  a : "\\na", ',
      '  b : ',
      '  {',
      '    d : "\\ntrue"',
      '  }',
      '}'

    ].join( '\n' ),

    /*42*/
    [
      '{',
      '  a : "aa", ',
      '  b : {}',
      '}'

    ].join( '\n' ),

    /*43*/
    [
      '{',
      '  a : "bb", ',
      '  b : {}',
      '}'

    ].join( '\n' ),

    /*44*/
    [
      '{',
      '  b : {}, ',
      '  c : 1',
      '}'

    ].join( '\n' ),

    /*45*/
    [

      '{',
      '  sequence : "\\u001b[A", ',
      '  name : "undefined", ',
      '  shift : false, ',
      '  code : "[A"',
      '}'

    ].join( '\n' ),

    /*46*/
    [
      '{',
      '  sequence : "\\u007f[A", ',
      '  name : "undefined", ',
      '  shift : false, ',
      '  code : "[A"',
      '}'

    ].join( '\n' ),

    /*47*/
    [
      '{',
      '  sequence : "<\\u001cb>text<\\u001cb>", ',
      '  data : [ Object with 2 elements ], ',
      '  shift : false, ',
      '  code : "<b>text<b>"',
      '}'

    ].join( '\n' ),

    /*48*/
    [
      '{',
      '  sequence : "heLLo", ',
      '  shift : false, ',
      '  code : "heLLo"',
      '}'

    ].join( '\n' ),

    /*49*/
    [
      '{',
      '  sequence : "\\nabc", ',
      '  shift : false, ',
      '  code : "abc"',
      '}'

    ].join( '\n' ),

    /*50*/
    [
      '{',
      '  sequence : "\\t[cba]\\t", ',
      '  data : 100, ',
      '  code : "\\n[cba]\\n"',
      '}'

    ].join( '\n' ),

    /*51*/
    [
      '{',
      '  sequence : "\\\\ABC\\\\", ',
      '  data : 100, ',
      '  code : "\\\\ABC\\\\"',
      '}'

    ].join( '\n' ),

    /*52*/
    [
      '{',
      '  sequence : "\\nline\\n", ',
      '  data : null, ',
      '  code : "\\nline\\n"',
      '}'

    ].join( '\n' ),

    /*53*/
    [
      '{ sequence : "\\rspace\\r" }'

    ].join( '\n' ),

    /*54*/
    [
      '{ sequence : "\\btest" }'

    ].join( '\n' ),

    /*55*/
    [
      '{ sequence : "\\u000bsample" }'

    ].join( '\n' ),

    /*56*/
    [
      '{ sequence : "\\ftest" }'

    ].join( '\n' ),

    /*57*/
    [
      '{',
      '  b : {}, ',
      '  c : true',
      '}'


    ].join( '\n' ),

    /*58*/
    [
      '{',
      '  b : {}',
      '}'


    ].join( '\n' ),

    /*59*/
    [
      '{',
      '  a : 1000.0, ',
      '  b : {}, ',
      '  c : 1.5',
      '}'


    ].join( '\n' ),

    /*60*/
    [
      '{ a : 1e+3, c : 2 }',

    ].join( '\n' ),

    /*61*/
    [
      '{ c : false, d : undefined, e : null }'

    ].join( '\n' ),

    /*62*/
    [
      '{}',

    ].join( '\n' ),

    /*63*/
    [
      '{ c : 3, a : 1, b : 2 }',

    ].join( '\n' ),

    /*64*/
    [
      '{ c : "3" }',

    ].join( '\n' ),

    /*65*/
    [

      '{',
      '  sequence : "\\u001b[A", ',
      '  name : "undefined", ',
      '  shift : false, ',
      '  code : "[A"',
      '}'

    ].join( '\n' ),


  ];

  testFunction( test,desc,src,options,expected );

}

// toStrObject.cover = [ _.toStr ];

//

function toStrJson( test )
{
   var desc =  'json test',

   src =
   [

     /*01*/ { "a" : 100, "b" : "c", "c" : { "d" : true, "e" : null } },
     /*02*/ { "b" : "a", "c" : 50, "d" : { "a" : "undefined", "e" : null } },
     /*03*/ [ { "a" : 100, "b" : "x", "c" : { "d" : true, "e" : null } } ],
     /*04*/ { a : '\n\nABC' },

     ///*04*/ { a : "aa", b : [ 1,2,3 ], c : function r( ){ } },
     ///*05*/ [ { a : 1, b : 2, c : { d : [ null,undefined ] } } ],
     ///*06*/ { a : new Date( Date.UTC( 1993, 12, 12 ) ) },
     ///*07*/ { a : new Error( "r" ) },
     ///*08*/ { a : Symbol( 'sm' ) },

   ],

   options =
   [
     /*01*/ { jsonLike : 1 },
     /*02*/ { jsonLike : 1 },
     /*03*/ { jsonLike : 1 },
     /*04*/ { jsonLike : 1 },

     ///*04*/ { jsonLike : 1, noRoutine : 1 },
     ///*05*/ { jsonLike : 1 },
     ///*06*/ { jsonLike : 1 },
     ///*07*/ { jsonLike : 1 },
     ///*08*/ { jsonLike : 1 },

   ]

  //  expected =
  //  [
   //
  //   /*01*/
  //   [
  //     '{',
  //     '  "a" : 100, ',
  //     '  "b" : "c", ',
  //     '  "c" : { "d" : true, "e" : null }',
  //     '}'
  //   ].join( '\n' ),
   //
  //   /*02*/
  //   [
  //     '{',
  //     '  "b" : "a", ',
  //     '  "c" : 50, ',
  //     '  "d" : { "a" : "undefined", "e" : null }',
  //     '}'
   //
  //   ].join( '\n' ),
   //
  //   /*03*/
  //   [
  //     '[',
  //     '  {',
  //     '    "a" : 100, ',
  //     '    "b" : "x", ',
  //     '    "c" : { "d" : true, "e" : null }',
  //     '  }',
  //     ']'
   //
  //   ].join( '\n' ),
   //
  //   /*04*/
  //   [
  //     '{',
  //     '  "a" : "aa", ',
  //     '  "b" : [ 1, 2, 3 ], ',
  //     '  "c" : [ routine r ]',
  //     '}',
   //
  //   ].join( '\n' ),
   //
  //   /*05*/
  //   [
   //
  //     '[',
  //     '  {',
  //     '    "a" : 1, ',
  //     '    "b" : 2, ',
  //     '    "c" : ',
  //     '    {',
  //     '      "d" : [ null, null ]',
  //     '    }',
  //     '  }',
  //     ']',
   //
  //   ].join( '\n' ),
   //
  //   /*06*/
  //   [
   //
  //     '{',
  //     '  "a" : 1994-01-12T00:00:00.000Z',
  //     '}',
   //
  //   ].join( '\n' ),
   //
  //   /*07*/
  //   [
   //
  //     '{ "a" : "Error: r" }',
   //
  //   ].join( '\n' ),
   //
  //   /*08*/
  //   [
   //
  //     '{ "a" : Symbol(sm) }'
   //
   //
  //   ].join( '\n' ),
   //
  //   /*09*/
  //   [
   //
  //     '{ "a" : "\\n\\nABC" }'
   //
   //
  //   ].join( '\n' ),
  //
  //     /*10*/
  //     [
  //       '',
  //     ].join( '\n' ),
  //
  //     /*11*/
  //     [
  //       ''
  //     ].join( '\n' ),
  //
  //     /*12*/
  //     [
  //       ''
  //
  //     ].join( '\n' ),
  //
  //     /*13*/
  //     [
  //       ''
  //     ].join( '\n' ),
  //
  //     /*14*/
  //     [
  //       ''
  //     ].join( '\n' ),
  //
  //   /*15*/
  //   [
  //     ''
  //   ].join( '\n' ),
  //
  //   /*16*/
  //   [
  //     ''
  //   ].join( '\n' ),
  //
  //   /*17*/
  //   [
  //     ''
  //   ].join( '\n' ),
  //
  //   /*18*/
  //   [
  //     ''
  //   ].join( '\n' ),
  //
  //   /*19*/
  //   [
  //     ''
  //   ].join( '\n' ),
  //
  //   /*20*/
  //   [
  //     ''
  //   ].join( '\n' ),
  //
  //   /*21*/
  //   [
  //     ''
  //   ].join( '\n' ),
   //
  //  ]

  testFunction( test, desc, src, options );

}

// toStrJson.cover = [ _.toStr ];

//

function _toStrJsonFromFile( test,encoding )
{
  var desc =  'json from file as utf8',

  src =
  [

    stringFromFile( 'file1', encoding ),
    stringFromFile( 'file4.pdf', encoding ),
    stringFromFile( 'test.exe', encoding ),
    stringFromFile( 'small', encoding ),
    stringFromFile( 'small2', encoding ),
    stringFromFile( 'small3', encoding ),
    stringFromFile( 'small4', encoding ),
    stringFromFile( 'small5', encoding ),
    stringFromFile( 'small6', encoding ),
    stringFromFile( 'small7', encoding ),
    stringFromFile( 'small5', encoding ),

    { a : stringFromFile( 'file1', encoding ), b : stringFromFile( 'file2', encoding ), c : 1 },
    { a : stringFromFile( 'file3', encoding ), b : stringFromFile( 'file4.pdf', encoding ), c : 1 },
    { a : [ stringFromFile( 'test.exe', encoding ) ], b : stringFromFile( 'small', encoding ) },
    { a : stringFromFile( 'small2', encoding ), b : stringFromFile( 'small3', encoding ) },
    { a : stringFromFile( 'small4', encoding ), b : stringFromFile( 'small5', encoding ) },
    { a : stringFromFile( 'small6', encoding ), b : stringFromFile( 'small7', encoding ) },

  ],

  options =
  [
    { jsonLike : 1 },
  ]

  testFunction( test, desc, src, options );

}

//

function toStrJsonFromFileU( test )
{

  return _toStrJsonFromFile( test,'utf8' );

}

// toStrJsonFromFileU.cover = [ _.toStr ];

//

function toStrJsonFromFileA( test )
{

  return _toStrJsonFromFile( test,'ascii' );

}

// toStrJsonFromFileA.cover = [ _.toStr ];

//

function toStrstringWrapper( test )
{
   var desc =  'stringWrapper test',
   src =
   [
     /*01*/ { a : "string",b : 1, c : null , d : undefined },
     /*02*/ { a : "sample",b : 0, c : false , d : [ "a" ] },
     /*03*/ { a : [ "example" ],b : 1, c : null , d : [ "b" ] },
     /*04*/ { a : "test", b : new Error( "err" ) },
     /*05*/ { a : "a", b : "b", c : { d : "d" } },
     /*06*/ { a : { h : "a" }, b : "b", c : { d : "d" } },
     /*07*/ { a : "line1\nline2\nline3" },
     /*08*/ { a : "line1" },
   ],
   options =
   [
     /*01*/ { stringWrapper : '' },
     /*02*/ { levels : 2, stringWrapper : '' },
     /*03*/ { levels : 3, stringWrapper : '' },
     /*04*/ { levels : 2 },
     /*05*/ { stringWrapper: '', levels : 1 },
     /*06*/ { stringWrapper: '', levels : 2 },
     /*07*/ { levels : 2, multilinedString : 1 },
     /*08*/ { levels : 2, multilinedString : 1 },
   ],

   expected =
   [
    /*01*/
      [

       '{',
       '  a : string, ',
       '  b : 1, ',
       '  c : null, ',
       '  d : undefined',
       '}'

     ].join( '\n' ),

    /*02*/
      [

       '{',
       '  a : sample, ',
       '  b : 0, ',
       '  c : false, ',
       '  d : [ a ]',
       '}'

     ].join( '\n' ),

    /*03*/
      [

       '{',
       '  a : [ example ], ',
       '  b : 1, ',
       '  c : null, ',
       '  d : [ b ]',
       '}'

     ].join( '\n' ),

    /*04*/
      [

       '{ a : "test", b : Error: err }',

     ].join( '\n' ),

    /*05*/
      [

       '{',
       '  a, ',
       '  b, ',
       '  c : [ Object with 1 elements ]',
       '}'

     ].join( '\n' ),

    /*06*/
    [

       '{',
       '  a : { h : a }, ',
       '  b, ',
       '  c : { d }',
       '}'

     ].join( '\n' ),

    /*07*/
    [

       '{',
       '  a : `line1',
       'line2',
       'line3`',
       '}'

     ].join( '\n' ),

    /*08*/
    [

       '{ a : `line1` }',

      ].join( '\n' ),

   ]

  testFunction( test,desc,src,options,expected );

}
// toStrstringWrapper.cover = [ _.toStr ];

//

function toStrLevel( test )
{
   var desc =  'level test',
   src =
   [
     /*01*/ { a : "a", b : "b", c : { d : "d" } },
     /*02*/ { a : { h : "a" }, b : "b", c : { d : "d" } },
     /*03*/ { a : [ "example" ],b : 1, c : null , d : [ "b" ] },
     /*04*/ { a : "a", b : "b", c : { d : "d" } },
   ],
   options =
   [
     /*01*/ { level: 0, levels : 0 },
     /*02*/ { level: 1, levels : 2 },
     /*03*/ { level: 1, levels : 0 },
     /*04*/ { },
   ],

   expected =
   [
    /*01*/
      [
       '[ Object with 3 elements ]',
      ].join( '\n' ),

    /*02*/
      [
       '{',
       '  a : [ Object with 1 elements ], ',
       '  b : "b", ',
       '  c : [ Object with 1 elements ]',
       '}'

      ].join( '\n' ),

    /*03*/
      [
       '[ Object with 4 elements ]',
      ].join( '\n' ),

    /*04*/
      [
       '{',
       '  a : "a", ',
       '  b : "b", ',
       '  c : [ Object with 1 elements ]',
       '}',

      ].join( '\n' ),

   ]
  testFunction( test,desc,src,options,expected );
}
// toStrLevel.cover = [ _.toStr ];

//

function toStrEnumerable( test )
{
   var desc =  'onlyEnumerable test',
   src =
   [
     /*01*/ ( function()
            {
             var x = Object.create({},
              {
                getFoo:
                {
                  value: function() { return this.foo; },
                  enumerable: false
                }
              });

             x.foo = 1;

             var y = Object.create( x );
             y.a = "string";

             return y;

            } )(),

     /*02*/ ( function()
            {
             var x = Object.create({},
              {
                getFoo:
                {
                  value: function() { return this.foo; },
                  enumerable: false
                }
              });

             x.foo = 1;

             var y = Object.create( x );
             y.a = "string";

             return y;

            } )(),

     /*03*/ ( function()
            {
             var x = Object.create({},
              {
                getFoo:
                {
                  value: function() { return this.foo; },
                  enumerable: false
                }
              });

             x.foo = 1;

             return x;

            } )(),

      /*04*/ ( function()
      {
        var x = Object.create({},
          {
            getFoo:
            {
              value: function() { return this.foo; },
              enumerable: false
            }
          });

          x.foo = 1;

          var y = Object.create( x );
          y.a = "string";

          return y;

        } )(),

   ],
   options =
   [
     /*01*/ {  }, //own :1,onlyEnumerable:1
     /*02*/ { own : 0 }, //own :0,onlyEnumerable:1
     /*03*/ { onlyEnumerable : 0 }, //own :1,onlyEnumerable:0
     /*04*/ { own : 0, onlyEnumerable : 0 },
   ],
   expected =
   [
    /*01*/
      [
       '{ a : "string" }'
      ].join( '\n' ),

    /*02*/
      [
       '{ a : "string", foo : 1 }'
      ].join( '\n' ),

    /*03*/
      [
       '{ getFoo : [ routine without name ], foo : 1 }'
      ].join( '\n' ),

    /*04*/
      [
        '{',
        '  constructor : [ routine Object ], ',
        '  toString : [ routine toString ], ',
        '  toLocaleString : [ routine toLocaleString ], ',
        '  valueOf : [ routine valueOf ], ',
        '  hasOwnProperty : [ routine hasOwnProperty ], ',
        '  isPrototypeOf : [ routine isPrototypeOf ], ',
        '  propertyIsEnumerable : [ routine propertyIsEnumerable ], ',
        '  __defineGetter__ : [ routine __defineGetter__ ], ',
        '  __lookupGetter__ : [ routine __lookupGetter__ ], ',
        '  __defineSetter__ : [ routine __defineSetter__ ], ',
        '  __lookupSetter__ : [ routine __lookupSetter__ ], ',
        '  __proto__ : [ Object with 1 elements ], ',
        '  getFoo : [ routine without name ], ',
        '  foo : 1, ',
        '  a : "string"',
        '}',
      ].join( '\n' ),
   ]
  testFunction( test,desc,src,options,expected );
}
// toStrEnumerable.cover = [ _.toStr ];
//

function toStrEmptyArgs( test )
{
  var desc = 'empty arguments',
  src = [ {}, '', [] ],
  options = [ {} ],
  expected =[ '{}', '""', '[]' ];

  testFunction( test,desc,src,options,expected );
}
// toStrEmptyArgs.cover = [ _.toStr ];
//

function toStrSymbol( test )
{
  var desc =  'Symbol test',
  src =
  [
    Symbol(),
    Symbol('sm'),
    Symbol('sx'),
    Symbol('sy')
  ],
  options =
  [
    {},
    {},
    { levels : 0 },
    { noAtomic : 1 },

  ],
  expected =
  [
    'Symbol()',
    'Symbol(sm)',
    'Symbol(sx)',
    ''
  ]

  testFunction( test,desc,src,options,expected );
}
// toStrSymbol.cover = [ _.toStr ];
//

function toStrNumber( test )
{
  var desc = 'Number test',
  src =
  [
    Number(),
    5,
    15000,
    1222.222,
    1234.4321,
    15,
    99,
    22


  ],
  options =
  [
    {},
    {},
    { precision : 3 },
    { fixed : 1 },
    { noNumber : 1 },
    { noAtomic : 1 },
    { levels : 0 },
    { noRoutine : 1 }
  ],
  expected =
  [
    '0',
    '5',
    '1.50e+4',
    '1222.2',
    '',
    '',
    '99',
    '22'

  ]

  testFunction( test,desc,src,options,expected );
}
// toStrNumber.cover = [ _.toStr ];
//

function toStrString( test )
{
  var desc =  'String test',
  src =
  [
    String(),
    'sample',
    'sample2',
    'sample3',
    '\nsample4\n',
    'sample5',
    'sample6',
    '\nsample7'

  ],
  options =
  [
    { },
    { },
    { noAtomic : 1 },
    { noString : 1 },
    { escaping : 1 },
    { tab : '---' },
    { levels : 0 },
    { },
  ],
  expected =
  [
    '""',
    '"sample"',
    '',
    '',
    '"\\nsample4\\n"',
    '"sample5"',
    '"sample6"',
    '"\nsample7"'
  ]

  testFunction( test,desc,src,options,expected );
}

// toStrString.cover = [ _.toStr ];

//

function toStrAtomic( test )
{
  var desc = 'boolean, null, undefined test',
  src =
  [
    Boolean(),
    true,
    false,
    1!=2,

    null,
    null,

    undefined,
    undefined
  ],
  options =
  [
    { },
    { },
    { levels : 0 },
    { onlyRoutines : 1 },

    { },
    { levels : 3 },

    { },
    { noAtomic : 1 }

  ],
  expected =
  [
    'false',
    'true',
    'false',
    '',

    'null',
    'null',

    'undefined',
    ''
  ]
  testFunction( test,desc,src,options,expected );
}
// toStrAtomic.cover = [ _.toStr ];

//

function toStrDate( test )
{
  var desc =  'Date test',
  src =
  [
    new Date( Date.UTC( 1993, 12, 12 ) ),
    new Date( 1990, 0, 0 ),
    new Date( 2016, 12, 8 ),
    new Date( 2016, 1, 2 ),
  ],
  options =
  [
    { },
    { },
    { levels : 0 },
    { noDate : 1 }
  ],
  expected =
  [
    '1994-01-12T00:00:00.000Z',
    '1989-12-30T22:00:00.000Z',
    '2017-01-07T22:00:00.000Z',
    '',
  ]
  testFunction( test,desc,src,options,expected );
}
// toStrDate.cover = [ _.toStr ];

//

function toStrRoutine( test )
{
  var desc =  'Routine test',
  src =
  [
    function rr( ){ },
    function rx( ){ },
    [ function ry( ){ } , 1],
  ],
  options =
  [
    { },
    { noRoutine : 1 },
    { onlyRoutines : 1 },

  ],
  expected =
  [
    '[ routine rr ]',
    '',
    '',
  ]
  testFunction( test,desc,src,options,expected );
}
// toStrRoutine.cover = [ _.toStr ];

//

function toStrThrow( test )
{
  if( Config.debug )
  {
    test.case = 'wrong type of argument';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStr( { a : 1 }, null );
    });

    test.case = '( o.precision ) is not between 1 and 21';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStr( { a : 1 }, { precision : 0 } );
    });

    test.case = '( o.fixed ) is not between 0 and 20';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStr( { a : 1 }, { fixed : 22 } );
    });

    test.case = 'if jsonLike : 1, multilinedString 1 " ';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStr( { a : 1 }, { jsonLike : 1, multilinedString : 1 } );
    });

    test.case = 'wrong arguments count';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStr( { a : 1 }, { b : 1 }, { jsonLike : 1 } );
    });

    test.case = 'invalid json if multilinedString is true`';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStr( { a : 1, b : "text" }, { jsonLike : 1, multilinedString : 1 } );
    });

    test.case = 'onlyRoutines & noRoutine both true';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStr( { a : function f(){}, b : "text" }, { onlyRoutines : 1, noRoutine : 1 } );
    });


  }
}
// toStrThrow.cover = [ _.toStr ];

//

function toStrLimitElements( test )
{
  var desc =  'limitElementsNumber options test',
  src =
  [
  //Arrays
  /*01*/[ 1, 2 ,3, 4, 5 ],
  /*02*/[ 1, 2 ,'3', 4, 5 ],
  /*03*/[ 1, 2 ,'3', 4, 5 ],
  /*04*/[ 1, 2 ,'3', 4, 5 ],
  /*05*/[ 1, 2 ,'3', 4, 5 ],
  /*06*/[ 1, 2 ,'3', 4, { a : '1'  }, '5', '6' ],
  /*07*/[ 1, 2 ,'3', 4, { a : '1'  }, '5', '6' ],

  //Objects
  /*08*/{ a : 1, b : 2, c : 3, d : 4 },
  /*09*/{ a : 1, b : function n(){ }, c : { a : '1' }, d : 4 },
  /*10*/{ a : 1, b : undefined, c : { a : '1' }, d : 4 },
  /*11*/{ a : 1, b : 2, c : { a : 1, b : '2' }, d : 3 },


  ],
  options =
  [
  //Arrays
  /*01*/{ limitElementsNumber : 2 },
  /*02*/{ limitElementsNumber : 3, noString : 1 },
  /*03*/{ limitElementsNumber : 2, noNumber : 1 },
  /*04*/{ limitElementsNumber : 5, noArray : 1 },
  /*05*/{ limitElementsNumber : 2, multiline : 1 },
  /*06*/{ levels : 2, limitElementsNumber : 3, noNumber : 1, multiline : 1 },
  /*07*/{ levels : 2, limitElementsNumber : 3, noNumber : 1, multiline : 1, wrap : 0, comma : ', '  },

  //Objects
  /*08*/{ limitElementsNumber : 2 },
  /*09*/{ limitElementsNumber : 2, levels : 2,  noRoutine : 1, noString : 1 },
  /*10*/{ limitElementsNumber : 2, multiline : 1, noString : 1 },
  /*11*/{ limitElementsNumber : 4, wrap : 0, comma : ', ' },




  ],
  expected =
  [
  //Arrays
  /*01*/'[ 1, 2, [ ... other 3 element(s) ] ]',
  /*02*/'[ 1, 2, 4, [ ... other 1 element(s) ] ]',
  /*03*/'[ "3" ]',
  /*04*/'',
  /*05*/
  [
    '[',
    '  1, ',
    '  2, ',
    '  [ ... other 3 element(s) ]',
    ']',
  ].join( '\n' ),

  /*06*/
  [
    '[',
    '  "3", ',
    '  {',
    '    a : "1"',
    '  }, ',
    '  "5", ',
    '  [ ... other 1 element(s) ]',
    ']',
  ].join( '\n' ),

  /*07*/
  [
    '  "3", ',
    '    a : "1", ',
    '  "5", ',
    '  [ ... other 1 element(s) ]',

  ].join( '\n' ),

  //Objects
  /*08*/
  [
    '{',
    '  a : 1, ',
    '  b : 2, ',
    '  [ ... other 2 element(s) ]',
    '}',

  ].join( '\n' ),

  /*09*/
  [
    '{',
    '  a : 1, ',
    '  c : {}, ',
    '  [ ... other 1 element(s) ]',
    '}',

  ].join( '\n' ),

  /*10*/
  [
    '{',
    '  a : 1, ',
    '  b : undefined, ',
    '  [ ... other 2 element(s) ]',
    '}',

  ].join( '\n' ),

  /*11*/
  [
    '  a : 1, ',
    '  b : 2, ',
    '  c : [ Object with 2 elements ], ',
    '  d : 3',

  ].join( '\n' ),

  ]
  testFunction( test,desc,src,options,expected );
}

// toStrRoutine.cover = [ _.toStr ];

//

function toStrMethods( test )
{
  test.case = 'converts routine to string default options';
  var got = _.toStrMethods( function route() {} );
  var expected = '[ routine route ]';
  test.identical( got,expected );

  test.case = 'converts routine to string, levels:0';
  var got = _.toStrMethods( function route() {}, { levels : 0 } );
  var expected = '[ routine route ]';
  test.identical( got,expected );

  test.case = 'different input data types';
  var got = _.toStrMethods( [ function route() {}, 0, '1', null ] );
  var expected = '';
  test.identical( got,expected );


  /**/

  test.case = 'invalid argument type';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.toStrMethods( 'one','two' );
  });

  test.case = 'wrong arguments count';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.toStrMethods( { a : 1 }, { b : 1 }, { jsonLike : 1 } );
  });

  test.case = 'onlyRoutines & noRoutine both true';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.toStrMethods( function f () {},{ noRoutine : 1 } );
  });

}

//

function toStrFields( test )
{
  test.case = 'Fields default options';
  var got = _.toStrFields( [ 1, 2, 'text', undefined ] );
  var expected = '[ 1, 2, "text", undefined ]';
  test.identical( got,expected );

  test.case = 'Fields, levels : 0';
  var got = _.toStrFields( [ 1, 2, 'text', undefined ], { levels : 0 } );
  var expected = '[ Array with 4 elements ]';
  test.identical( got,expected );

  test.case = 'Ignore routine';
  var got = _.toStrFields( [ function f () {}, 1, 2, 3 ] );
  var expected = '[ 1, 2, 3 ]';
  test.identical( got,expected );

  test.case = 'no arguments';
  var got = _.toStrFields();
  var expected = 'undefined';
  test.identical( got,expected );



  /**/

  if( Config.debug )
  {
    test.case = 'invalid argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStrFields( 'one','two' );
    });

    test.case = 'wrong arguments count';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStrFields( { a : 1 }, { b : 1 }, { jsonLike : 1 } );
    });

    test.case = 'onlyRoutines & noRoutine both true';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStrFields( function f () {}, { onlyRoutines : 1 } );
    });

  }
}

//

function toStrShort( test )
{
  test.case = 'Array length test';
  var got = _.toStrShort( [ 1, 2, 'text', undefined ], { } );
  var expected = '[ Array with 4 elements ]';
  test.identical( got,expected );

  test.case = 'date to string';
  var got = _.toStrShort( new Date( Date.UTC( 1993, 12, 12 ) ), { }  );
  var expected = '1994-01-12T00:00:00.000Z';
  test.identical( got,expected );

  test.case = 'string length > 40';
  var got = _.toStrShort( 'toxtndmtmdbmmlzoirmfypyhnrrqfuvybuuvixyrx', { stringWrapper : '"' } );
  var expected = '[ "toxtndmtmdbmmlzoirmf" ... "pyhnrrqfuvybuuvixyrx" ]';
  test.identical( got,expected );

  test.case = 'string with options';
  var got = _.toStrShort( '\toxtndmtmdb', { escaping : 1 } );
  var expected = '\\toxtndmtmdb';
  test.identical( got,expected );

  test.case = 'error to string ';
  var got = _.toStrShort( new Error( 'err' ), { } );
  var expected = '[object Error]';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStrShort( '1', 2 );
    });

    test.case = 'only one argument provided';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStrShort( '1' );
    });

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _.toStrShort( );
    });

  }
}

//

function _toStrIsVisibleElement( test )
{
  test.case = 'default options';
  var got = _._toStrIsVisibleElement( 123, {} );
  var expected = true;
  test.identical( got,expected );

  test.case = 'noAtomic';
  var got = _._toStrIsVisibleElement( 'test', { noAtomic : 1 } );
  var expected = false;
  test.identical( got,expected );

  test.case = 'noObject';
  var got = _._toStrIsVisibleElement( { a : 'test' }, { noObject : 1 } );
  var expected = false;
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid arguments count';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrIsVisibleElement( '1' );
    });

    // test.case = 'second argument is not a object';
    // test.shouldThrowErrorOfAnyKind( function()
    // {
    //   _._toStrIsVisibleElement( '1', 2 );
    // });

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrIsVisibleElement();
    });

  }
}

//

function _toStrIsSimpleElement( test )
{
  test.case = 'default options';
  var got = _._toStrIsSimpleElement( 123, {} );
  var expected = true;
  test.identical( got,expected );

  test.case = 'string length > 40';
  var got = _._toStrIsSimpleElement( 'toxtndmtmdbmmlzoirmfypyhnrrqfuvybuuvixyrx', {} );
  var expected = false;
  test.identical( got,expected );

  test.case = 'object test';
  var got = _._toStrIsSimpleElement( { a : 1 }, {} );
  var expected = false;
  test.identical( got,expected );

  test.case = 'atomic test';
  var got = _._toStrIsSimpleElement( undefined, {} );
  var expected = true;
  test.identical( got,expected );

  test.case = 'escaping test';
  var got = _._toStrIsSimpleElement( '\naaa', { escaping : 1 } );
  var expected = true;
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid arguments count';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrIsSimpleElement( '1' );
    });

    test.case = 'second argument is not a object';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrIsSimpleElement( '1', 2 );
    });

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrIsSimpleElement();
    });

  }
}

//

function _toStrFromRoutine( test )
{
  test.case = 'routine test';
  var got = _._toStrFromRoutine( function a () {} );
  var expected = '[ routine a ]';
  test.identical( got,expected );

  test.case = 'routine without name';
  var got = _._toStrFromRoutine( function() {} );
  var expected = '[ routine without name ]';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromRoutine( '1' );
    });

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromRoutine();
    });

  }
}

//

function _toStrFromNumber( test )
{
  test.case = 'default options';
  var got = _._toStrFromNumber( 123, {} );
  var expected = '123';
  test.identical( got,expected );

  test.case = 'number precision test';
  var got = _._toStrFromNumber( 123, { precision : 2 } );
  var expected = '1.2e+2';
  test.identical( got,expected );

  test.case = 'number fixed test';
  var got = _._toStrFromNumber( 123, { fixed : 2 } );
  var expected = '123.00';
  test.identical( got,expected );

  test.case = 'invalid option type';
  var got = _._toStrFromNumber( 123, { fixed : '2' } );
  var expected = '123';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid first argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromNumber( '1',{} );
    });

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromNumber( 1, 2 );
    });

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromNumber();
    });

    test.case = 'precision out of range';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromNumber( 1, { precision : 22 });
    });

    test.case = 'fixed out of range';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromNumber( 1, { precision : 22 });
    });

  }
}

//

function _toStrFromNumber2( test )
{

  test.case = 'returns with precision until 5';
  var options = { precision : 5 };
  var got = _._toStrFromNumber( 3.123456, options );
  var expected = '3.1235';
  test.identical( got, expected );

  test.case = 'returns with precision until 2';
  var options = { precision : 2 };
  var got = _._toStrFromNumber( 3.123456, options );
  var expected = '3.1';
  test.identical( got, expected );

  test.case = 'is returned with four numbers after dot';
  var options = { fixed : 4 };
  var got = _._toStrFromNumber( 13.75, options );
  var expected = '13.7500';
  test.identical( got, expected );

  test.case = 'is returned the rounded number to the top';
  var options = { fixed : 0 };
  var got = _._toStrFromNumber( 13.50, options );
  var expected = '14';
  test.identical( got, expected );

  test.case = 'is returned the rounded number to the bottom';
  var options = { fixed : 0 };
  var got = _._toStrFromNumber( 13.49, options );
  var expected = '13';
  test.identical( got, expected );

  test.case = 'returns string';
  var options = {  };
  var got = _._toStrFromNumber( 13.75, options );
  var expected = '13.75';
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _._toStrFromNumber( );
  } );

  test.case = 'first argument is wrong';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _._toStrFromNumber( 'wrong argument', { fixed : 3 } );
  } );

  test.case = 'second argument is not provided';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _._toStrFromNumber( 13.75 );
  } );

  test.case = 'second argument is wrong precision must be between 1 and 21';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _._toStrFromNumber( 13.75, { precision : 0 } );
  } );

};

//

function _toStrIsSimpleElement2( test )
{

  test.case = 'argument\'s length is less than 40 symbols';
  var got = _._toStrIsSimpleElement( 'test' );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument is number';
  var got = _._toStrIsSimpleElement( 13 );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument is boolean';
  var got = _._toStrIsSimpleElement( true );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument is null';
  var got = _._toStrIsSimpleElement( null );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument is undefined';
  var got = _._toStrIsSimpleElement( undefined );
  var expected = true;
  test.identical( got, expected );

  test.case = 'argument\'s length is greater than 40 symbols';
  var got = _._toStrIsSimpleElement( 'test,test,test,test,test,test,test,test,test.' );
  var expected = false;
  test.identical( got, expected );

  test.case = 'argument is an object';
  var got = _._toStrIsSimpleElement( { a: 33 } );
  var expected = false;
  test.identical( got, expected );

  test.case = 'argument is an array';
  var got = _._toStrIsSimpleElement( [ 1, 2, 3 ] );
  var expected = false;
  test.identical( got, expected );

  test.case = 'argument is an array-like';
  var arrLike = ( function( ) { return arguments; } )( 1, 2, 3 );
  var got = _._toStrIsSimpleElement( arrLike );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  xxx

};

//

function _toStrFromStr( test )
{
  test.case = 'default options';
  var got = _._toStrFromStr( '123', {} );
  var expected = '123';
  test.identical( got,expected );

  test.case = 'escaping';
  var got = _._toStrFromStr( '\n123\u001b', { escaping : 1 } );
  var expected = '\\n123\\u001b';
  test.identical( got,expected );

  test.case = 'stringWrapper';
  var got = _._toStrFromStr( 'string', { stringWrapper : '"' } );
  var expected = '"string"';
  test.identical( got,expected );

  test.case = 'multilinedString';
  var got = _._toStrFromStr( 'string\nstring2', { stringWrapper : '`' } );
  var expected = "`string\nstring2`";
  test.identical( got,expected );


  /**/

  if( Config.debug )
  {

    test.case = 'invalid first argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromStr( 2, {} );
    });

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromStr( '1', 2 );
    });

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromStr();
    });

  }
}

//

function _toStrFromArray( test )
{

  test.case = 'default options';
  var got = _._toStrFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '   ', level : 1, comma : ', ', wrap : 1 } ).text;
  var expected = '[ 1, 2, 3 ]';
  test.identical( got,expected );

  test.case = 'wrap test';
  var got = _._toStrFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '   ', level : 1, comma : ', ', wrap : 0 } ).text;
  var expected = '   1, 2, 3';
  test.identical( got,expected );

  test.case = 'levels 0 test';
  var got = _._toStrFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '   ', level : 0, levels : 0, comma : ', ', wrap : 1 } ).text;
  var expected = '[ Array with 3 elements ]';
  test.identical( got,expected );

  test.case = 'dtab & multiline test';
  var got = _._toStrFromArray( [ 1, 2, 3 ], { tab : ' ', dtab: '-', level : 0, comma : ', ', wrap : 1, multiline : 1 } ).text;
  var expected =
  [
    '[',
    ' -1, ',
    ' -2, ',
    ' -3',
    ' ]',
  ].join( '\n' );
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid first argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromArray( 2, {} );
    });

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromArray( [], 2 );
    });

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromArray();
    });

  }
}

//

function _toStrFromObject( test )
{
  var def = { tab : ' ', dtab : '   ',level : 0, levels : 1, onlyEnumerable : 1, own : 1, colon : ' : ', comma : ', ', wrap : 1, noObject : 0, multiline : 0};

  test.case = 'default options';
  var got = _._toStrFromObject( { a : 1, b : 2 , c : 'text' }, def );
  var expected = '{ a : 1, b : 2, c : text }';
  test.identical( got.text,expected );

  test.case = 'levels 0 test';
  def.levels = 0;
  var got = _._toStrFromObject( { a : 1, b : 2 , c : 'text' }, def );
  var expected = '[ Object with 3 elements ]';
  test.identical( got.text,expected );

  test.case = 'wrap 0 test';
  def.levels = 1;
  def.wrap = 0;
  var got = _._toStrFromObject( { a : 1, b : 2, c : 'text' }, def );
  var expected = 'a : 1, b : 2, c : text';
  test.identical( got.text,expected );

  test.case = 'noObject test';
  def.noObject = 1;
  var got = _._toStrFromObject( { a : 1, b : 2, c : 'text' }, def );
  var expected = undefined;
  test.identical( got,expected );

  test.case = 'dtab & prependTab & multiline test';
  def.noObject = 0;
  def.dtab = '*';
  def.multiline  = 1;
  def.prependTab = 1;
  var got = _._toStrFromObject( { a : 1, b : 2, c : 'text' }, def );
  var expected =
  [
    ' *a : 1, ',
    ' *b : 2, ',
    ' *c : text',
  ].join( '\n' );
  test.identical( got.text,expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid first argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromObject( 1, {} );
    });

    test.case = 'empty options';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromObject( { a : 1 }, {} );
    });

    test.case = 'invalid second argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromObject( { a : 1 }, 2 );
    });

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromObject();
    });

  }
}

//

function _toStrFromContainer( test )
{
  var o = { tab : ' ', dtab : '   ',level : 0, levels : 1, onlyEnumerable : 1, own : 1, colon : ' : ', comma : ', ', wrap : 1, noObject : 0, multiline : 0, noSubObject : 0, prependTab : 1, jsonLike : 0, stringWrapper : '"' };
  var src = { a : 1, b : 2, c : 'text' };
  var names = _.mapOwnKeys( src );
  var optionsItem = null;

  function item_options()
  {
  optionsItem = _.mapExtend( {}, o);
  optionsItem.noObject = o.noSubObject ? 1 : 0;
  optionsItem.tab = o.tab + o.dtab;
  optionsItem.level = o.level + 1;
  optionsItem.prependTab = 0;
  };

  test.case = 'default options';
  item_options();
  var got = _._toStrFromContainer
  ({
    values : src,
    names,
    optionsContainer : o,
    optionsItem,
    simple : !o.multiline,
    prefix : '{',
    postfix : '}',
  });
  var expected = ' { a : 1, b : 2, c : "text" }';
  test.identical( got,expected );

  test.case = 'wrap 0,comma ,dtab, multiline test';

  o.wrap = 0;
  o.comma = '_';
  o.dtab = '*';
  o.colon = ' | ';
  o.multiline = 1;
  item_options();

  var got = _._toStrFromContainer
  ({
    values : src,
    names,
    optionsContainer : o,
    optionsItem,
    simple : !o.multiline,
    prefix : '{',
    postfix : '}',
  });
  var expected =
  [
    ' *a | 1_',
    ' *b | 2_',
    ' *c | "text"',
  ].join( '\n' );

  test.identical( got,expected );

  test.case = 'json test';

  o.wrap = 1;
  o.comma = ', ';
  o.dtab = '  ';
  o.multiline = 0;
  o.colon = ' : ';
  o.json = 1;
  o.levels = 256;
  item_options();

  var got = _._toStrFromContainer
  ({
    values : src,
    names,
    optionsContainer : o,
    optionsItem,
    simple : !o.multiline,
    prefix : '{',
    postfix : '}',
  });
  var expected = ' { "a" : 1, "b" : 2, "c" : "text" }';

  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.case = 'invalid  argument type';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromContainer( 1 );
    });

    test.case = 'empty object';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromContainer( { } );
    });

    test.case = 'no arguments';
    test.shouldThrowErrorOfAnyKind( function()
    {
      _._toStrFromContainer();
    });

  }

}

//

var Self =
{

  name : 'Tools.base.l4.String.2',
  silencing : 1,
  enabled : 0, // !!! refactoring

  tests :
  {

    toStrUnwrapped,
    toStrError,
    toStrArray,
    toStrObject,
    toStrJson,
    toStrJsonFromFileU,
    toStrJsonFromFileA,
    toStrstringWrapper,
    toStrLevel,
    toStrEnumerable,
    toStrEmptyArgs,
    toStrSymbol,
    toStrNumber,
    toStrString,
    toStrAtomic,
    toStrDate,
    toStrRoutine,
    toStrThrow,
    toStrLimitElements,

    toStrMethods,
    toStrFields,

    toStrShort,
    _toStrIsVisibleElement,
    _toStrIsSimpleElement,
    _toStrFromRoutine,
    _toStrFromNumber,
    _toStrFromNumber2,
    _toStrIsSimpleElement2,
    _toStrFromStr,
    _toStrFromArray,
    _toStrFromObject,
    _toStrFromContainer,

  }

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
