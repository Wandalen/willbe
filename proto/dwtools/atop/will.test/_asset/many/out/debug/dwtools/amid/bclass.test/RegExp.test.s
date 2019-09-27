( function _RegExp_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );

  require( '../bclass/RegexpObject.s' );

}

var _ = _global_.wTools;

// shared variables
var ArrOfRegx1 = [ /0/, /1/, /2/ ],
  ArrOfRegx2 = [ /3/, /4/, /5/ ],
  ArrOfRegx3 = [ /6/, /7/, /8/ ],
  ArrOfRegx4 = [ /9/, /10/, /11/ ],
  ArrOfRegx5 = [ /12/, /13/, /14/ ],
  ArrOfRegx6 = [ /14/, /16/, /17/ ],
  ArrOfRegx7 = [ /18/, /19/, /20/ ],
  ArrOfRegx8 = [ /21/, /22/, /23/ ],

  src1 =
  {
    includeAny : ArrOfRegx1,
    includeAll : ArrOfRegx2,
    excludeAny : ArrOfRegx3,
    excludeAll : ArrOfRegx4
  },
  src2 =
  {
    includeAny : ArrOfRegx5,
    includeAll : ArrOfRegx6,
    excludeAny : ArrOfRegx7,
    excludeAll : ArrOfRegx8
  },
  src3 =
  {
    includeAny : [ /a0/, /a1/, /a2/ ],
    includeAll : [ /b0/, /c1/, /c2/ ],
    excludeAny : [ /c0/, /c1/, /c2/ ],
    excludeAll : [ /d0/, /d1/, /d2/ ]
  },
  wrongSrc =
  {
    includeAny : ArrOfRegx5,
    includeAll : ArrOfRegx6,
    excludeAny : ArrOfRegx7,
    excludeAll : ArrOfRegx8,
    excludeSome : [ /[^a]/ ]
  };

//

function regexpEscape( test )
{
  var simpleStr = 'hello world',
    specialCharacters = '.*+?^=!:${}()|[]/\\',
    simpleSent = 'Hello. How are you?',
    empty = '';

  var expected1 = '\\.\\*\\+\\?\\^\\=\\!\\:\\$\\{\\}\\(\\)\\|\\[\\]\\/\\\\',
    expected2 = "Hello\\. How are you\\?"

  test.case = 'escape simple str without spec. characters';
  var got = _.regexpEscape( simpleStr );
  test.identical( got, simpleStr );

  test.case = 'escape special characters';
  var got = _.regexpEscape( specialCharacters );
  test.identical( got, expected1 );

  test.case = 'escape simple sentences';
  var got = _.regexpEscape( simpleSent );
  test.identical( got, expected2 );

  test.case = 'escape empty string';
  var got = _.regexpEscape( empty );
  test.identical( got, empty );
}

//

function regexpArrayMake( test )
{
  var arrOfStr = [ 'hello', 'world' ],
    singleStr = 'hello',
    singleReg = /world/,
    wrongParam1 = null,
    wrongParam2 = [ 3, 4 ],
    expectedArr1 = [ /hello/, /world/ ],
    expectedArr2 = [ /hello/ ],
    expectedArr3 = [ singleReg ];

  function getSource( v )
  {
    return v.source;
  }

  test.case = 'argument is array of string';
  var got = _.regexpArrayMake( arrOfStr );
  test.identical( got.map( getSource ), expectedArr1.map( getSource ) );

  test.case = 'argument is array of regexp';
  var got = _.regexpArrayMake( ArrOfRegx1 );
  test.identical( got, ArrOfRegx1 );

  test.case = 'argument is single string';
  var got = _.regexpArrayMake( singleStr );
  test.identical( got.map( getSource ), expectedArr2.map( getSource ) );

  test.case = 'argument is single regexp';
  var got = _.regexpArrayMake( singleReg );
  test.identical( got, expectedArr3 );

  test.case = 'argument is empty arr';
  var got = _.regexpArrayMake( [] );
  test.identical( got, [] );

  if( !Config.debug )
  return;

  test.case = 'call without arguments';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayMake();
  });

  test.case = 'call with wrong type argument';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayMake( wrongParam1 );
  });

  test.case = 'call with wrong type argument';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayMake( wrongParam2 );
  });

};

//

function regexpFrom( test )
{
  var simpleStr = 'hello',
    simpleReg = /world/,
    strWithSpChar = 'Hello. How are you?',
    wrongParam1 = null,
    expected1 = /hello/,
    expected2 = /Hello\. How are you\?/;


  test.case = 'argument is simple string';
  var got = _.regexpFrom( simpleStr );
  test.identical( got.source, expected1.source );

  test.case = 'argument is regexp';
  var got = _.regexpFrom( simpleReg );
  test.identical( got, simpleReg );

  test.case = 'argument is string with special characters';
  var got = _.regexpFrom( strWithSpChar );
  test.identical( got.source, expected2.source );

  if( !Config.debug )
  return;

  test.case = 'call without arguments';
  test.shouldThrowErrorSync( function()
  {
    _.regexpFrom();
  });

  test.case = 'call with wrong type argument';
  test.shouldThrowErrorSync( function()
  {
    _.regexpFrom( wrongParam1 );
  });

};

//

function regexpArrayAny( test )
{
  var strForTest1 = 'some text 5',
    wrongTypeArr = [ /a/, /b/, '5' ],
    expectedIndex = 2,
    defaultParam = true;

  test.case = 'regexp is found in str';
  var got = _.regexpArrayAny( ArrOfRegx2, strForTest1, false );
  test.identical( got, expectedIndex );

  test.case = 'regexp isn\'t found in str';
  var got = _.regexpArrayAny( ArrOfRegx3, strForTest1, false );
  test.identical( got, false );

  test.case = 'empty regexp array passed';
  var got = _.regexpArrayAny( [], strForTest1, defaultParam );
  test.identical( got, defaultParam );

  if( !Config.debug )
  return;

  test.case = 'missed all arguments';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayAny()
  });

  test.case = 'missed one of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayAny( ArrOfRegx2, strForTest1 )
  });

  test.case = 'first argument is not array';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayAny( 'hello', strForTest1, false );
  });

  test.case = 'element of array is not regexp';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayAny( wrongTypeArr, strForTest1, false );
  });

}

//

function regexpArrayAll( test )
{
  var strForTest1 = '012349',
    wrongTypeArr = [ /0/, /3/, '9' ],
    expectedIndex = 2,
    defaultParam = false;

  test.case = 'all regexp is found in str';
  var got = _.regexpArrayAll( ArrOfRegx1, strForTest1, false );
  test.identical( got, true );

  test.case = 'one of regexp isn\'t found in str';
  var got = _.regexpArrayAll( ArrOfRegx2, strForTest1, false );
  test.identical( got, expectedIndex );

  test.case = 'empty regexp array passed';
  var got = _.regexpArrayAll( [], strForTest1, defaultParam );
  test.identical( got, defaultParam );

  if( !Config.debug )
  return;

  test.case = 'missed all arguments';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayAll()
  });

  test.case = 'missed one of arguments';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayAll( ArrOfRegx2, strForTest1 )
  });

  test.case = 'first argument is not array';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayAll( 'hello', strForTest1, false );
  });

  test.case = 'element of array is not regexp';
  test.shouldThrowErrorSync( function()
  {
    _.regexpArrayAll( wrongTypeArr, strForTest1, false );
  });

}

//

function Test( test )
{
  var regexpObj1 =
    {
      includeAny : [ /2/, /6/, /7/ ],
      includeAll : [ /0/, /1/, /2/ ],
      excludeAny : [ /6/, /7/, /8/ ],
      excludeAll : [ /2/, /6/, /7/ ]
    },
    regexpObj2 =
    {
      includeAny : [ /9/, /6/, /7/ ], //
      includeAll : [ /0/, /1/, /2/ ],
      excludeAny : [ /6/, /7/, /8/ ],
      excludeAll : [ /2/, /6/, /7/ ]
    },
    regexpObj3 =
    {
      includeAny : [ /2/, /6/, /7/ ],
      includeAll : [ /0/, /6/, /2/ ], //
      excludeAny : [ /6/, /7/, /8/ ],
      excludeAll : [ /2/, /6/, /7/ ]
    },
    regexpObj4 =
    {
      includeAny : [ /2/, /6/, /7/ ],
      includeAll : [ /0/, /1/, /2/ ],
      excludeAny : [ /6/, /7/, /0/ ], //
      excludeAll : [ /2/, /6/, /7/ ]
    },
    regexpObj5 =
    {
      includeAny : [ /2/, /6/, /7/ ],
      includeAll : [ /0/, /1/, /2/ ],
      excludeAny : [ /6/, /7/, /8/ ],
      excludeAll : [ /0/, /1/, /2/ ] //
    },
    testStr = '012345';

  test.case = 'all regeps array are matched';
  var got = _.RegexpObject.Test( regexpObj1, testStr );
  test.identical( got, true );

  test.case = 'includeAny parameter do not contains any regexp that matches the string';
  var got = _.RegexpObject.Test( regexpObj2, testStr );
  test.identical( got, false );

  test.case = 'includeAll contains any regexp that do not matches the string';
  var got = _.RegexpObject.Test( regexpObj3, testStr );
  test.identical( got, false );

  test.case = 'excludeAny contains any regexp that matches the test string';
  var got = _.RegexpObject.Test( regexpObj4, testStr );
  test.identical( got, false );

  test.case = 'excludeAll contains regexps that all matches the test string';
  var got = _.RegexpObject.Test( regexpObj4, testStr );
  test.identical( got, false );

  test.case = 'null';
  var got = _.RegexpObject.Test( null, testStr );
  test.identical( got, true );

  /**/

  if( !Config.debug )
  return;

  test.case = 'missing arguments';
  test.shouldThrowErrorSync( function()
  {
    _.RegexpObject.Test();
  });

  test.case = 'missing string for testing';
  test.shouldThrowErrorSync( function()
  {
    _.RegexpObject.Test( regexpObj1 );
  });

  test.case = 'incorrect first argument';
  test.shouldThrowErrorSync( function()
  {
    _.RegexpObject.Test( 1, testStr );
  });

  test.case = 'second argument is not a string';
  test.shouldThrowErrorSync( function()
  {
    _.RegexpObject.Test( regexpObj1, 44 );
  });

}

//

function _Extend( test )
{
  var src1 =
      [
        {
          includeAny : ArrOfRegx1,
          includeAll : ArrOfRegx2,
          excludeAny : ArrOfRegx3,
          excludeAll : ArrOfRegx4
        }
      ],
    src2 =
      [
        {
          includeAny : ArrOfRegx1,
          includeAll : ArrOfRegx2,
          excludeAny : ArrOfRegx3,
          excludeAll : ArrOfRegx4
        },
        {
          includeAny : ArrOfRegx5,
          includeAll : ArrOfRegx6,
          excludeAny : ArrOfRegx7,
          excludeAll : ArrOfRegx8
        }
      ],

    wrongSrc1 =
    {
      includeAny : ArrOfRegx5,
      includeAll : ArrOfRegx6,
      excludeAny : ArrOfRegx7,
      excludeAll : ArrOfRegx8
    },
    wrongSrc2 = { includeAny : ArrOfRegx5 },
    wrongSrc3 =
      [
        {
          includeAny : ArrOfRegx5,
          includeAll : ArrOfRegx6,
          excludeAny : ArrOfRegx7,
          excludeAll : ArrOfRegx8,
          excludeSome : [ /[^a]/ ]
        }
      ],

    dst1 = {},
    dst2 =
    {
      includeAny : [ /a0/, /a1/, /a2/ ],
      includeAll : [ /b0/, /c1/, /c2/ ],
      excludeAny : [ /c0/, /c1/, /c2/ ],
      excludeAll : [ /d0/, /d1/, /d2/ ]
    },
    dst3 =
    {
      includeAny : [ /a0/, /a1/, /a2/ ],
      includeAll : [ /b0/, /c1/, /c2/ ],
      excludeAny : [ /c0/, /c1/, /c2/ ],
      excludeAll : [ /d0/, /d1/, /d2/ ]
    },

    expected1 = src1.slice().pop(),
    expected2 =
    {
      includeAny : src2[ 1 ].includeAny,
      includeAll : dst2.includeAll.concat( src2[ 0 ].includeAll, src2[ 1 ].includeAll ),
      excludeAny : dst2.excludeAny.concat( src2[ 0 ].excludeAny, src2[ 1 ].excludeAny ),
      excludeAll : src2[ 1 ].excludeAll
    },
    expected3 =
    {
      includeAny : dst3.includeAny.concat( src2[ 0 ].includeAny, src2[ 1 ].includeAny ),
      includeAll : dst3.includeAll.concat( src2[ 0 ].includeAll, src2[ 1 ].includeAll ),
      excludeAny : dst3.excludeAny.concat( src2[ 0 ].excludeAny, src2[ 1 ].excludeAny ),
      excludeAll : dst3.excludeAll.concat( src2[ 0 ].excludeAll, src2[ 1 ].excludeAll )
    },

    extendOpt1 =
    {
      dst : dst1,
      srcs : src1,
      mode : 'and',
    },
    extendOpt2 =
    {
      dst : dst2,
      srcs : src2,
      mode : 'and',
    },
    extendOpt3 =
    {
      dst : dst3,
      srcs : src2,
      mode : 'or',
    },

    wrongOpt1 =
    {
      dst : dst1,
      srcs : src1,
    },
    wrongOpt2 =
    {
      dst : null,
      srcs : src1,
      mode : 'or',
    },
    wrongOpt3 =
    {
      dst : dst3,
      srcs : wrongSrc1,
      mode : 'or',
    },
    wrongOpt4 =
    {
      dst : {},
      srcs : wrongSrc2,
      mode : 'or',
    },
    wrongOpt5 =
    {
      dst : {},
      srcs : wrongSrc3,
      mode : 'or',
    };

  test.case = 'simple regexp objects extend with anding';
  var got = wRegexpObject._Extend( extendOpt1 );
  test.contains( got, expected1 );

  test.case = 'regexp objects extend with anding';
  var got = wRegexpObject._Extend( extendOpt2 );
  test.contains( got, expected2 );

  test.case = 'regexp objects extend without anding';
  var got = wRegexpObject._Extend( extendOpt3 );
  test.contains( got, expected3 );

  test.case = 'regexp objects extend without anding';
  var got = _.RegexpObject._Extend( extendOpt3 );
  var expected = _.RegexpObject( expected3 );
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;


  // test.case = 'missing parameters in options argument';
  // test.shouldThrowErrorSync( function()
  // {
  //   debugger;
  //   wRegexpObject._Extend( wrongOpt1 );
  // });

  // test.case = 'options.dst is not object';
  // test.shouldThrowErrorSync( function()
  // {
  //   wRegexpObject._Extend( wrongOpt2 );
  // });

  test.case = 'options.srcs not wrapped into array';
  test.shouldThrowErrorSync( function()
  {
    wRegexpObject._Extend( wrongOpt3 );
  });

  test.case = 'element of options.srcs is not object';
  test.shouldThrowErrorSync( function()
  {
    debugger
    wRegexpObject._Extend( wrongOpt4 );
  });

  test.case = 'element of options.srcs has wrong format : (extra property)';
  test.shouldThrowErrorSync( function()
  {
    wRegexpObject._Extend( wrongOpt5 );
  });

}

//

function Or( test )
{
  var dst1 = {},
    dst2 =
    {
      includeAny : [ /a0/, /a1/, /a2/ ],
      includeAll : [ /b0/, /c1/, /c2/ ],
      excludeAny : [ /c0/, /c1/, /c2/ ],
      excludeAll : [ /d0/, /d1/, /d2/ ]
    },


    expected0 =
    {
      includeAny : [],
      includeAll : [],
      excludeAny : [],
      excludeAll : []
    },
    expected1 = src1,
    expected2 =
    {
      includeAny :  [ /a0/, /a1/, /a2/, /0/, /1/, /2/, /12/, /13/, /14/ ],
      includeAll :  [ /b0/, /c1/, /c2/, /3/, /4/, /5/, /14/, /16/, /17/ ],
      excludeAny :  [ /c0/, /c1/, /c2/, /6/, /7/, /8/, /18/, /19/, /20/ ],
      excludeAll :  [ /d0/, /d1/, /d2/, /9/, /10/, /11/, /21/, /22/, /23/ ]
    },
    expected3 =
    {
      excludeAll : [ /9/, /10/, /11/ ],
      excludeAny : [ /6/, /7/, /8/ ] ,
      includeAll : [ /3/, /4/, /5/ ],
      includeAny : [ /hello/, /0/, /1/, /2/ ]
    };

  test.case = 'empty RegexpObject object or nothing (missed source for RegexpObject extend)';
  var got = wRegexpObject.Or();
  test.contains( got, expected0 );

  test.case = 'empty RegexpObject object or nothing (missed source for RegexpObject extend)';
  var got = wRegexpObject.Or( {} );
  test.contains( got, expected0 );

  test.case = 'RegexpObjec with existing data or by other RegexpObject objects';
  var got = wRegexpObject.Or( dst2, src1, src2, src3 );
  test.contains( got, expected2 );

  test.case = 'String or by single object';
  var got = wRegexpObject.Or( 'hello', src1 );
  test.contains( got, expected3 );

  if( !Config.debug )
  return;

  // test.case = 'missed arguments';
  // test.shouldThrowErrorSync( function()
  // {
  //   wRegexpObject.Or();
  // });

  // test.case = 'result (first passed) parameter in not object';
  // test.shouldThrowErrorSync( function()
  // {
  //   wRegexpObject.Or( 'hello', src1 );
  // });

  test.case = 'source for RegexpObject extend has extra parameter';
  test.shouldThrowErrorSync( function()
  {
    wRegexpObject.Or( {}, wrongSrc );
  });

}

//

function And( test )
{
  var dst1 = {}
  var dst2 =
  {
    includeAny : [ /a0/, /a1/, /a2/ ],
    includeAll : [ /b0/, /c1/, /c2/ ],
    excludeAny : [ /c0/, /c1/, /c2/ ],
    excludeAll : [ /d0/, /d1/, /d2/ ]
  }
  var expected0 =
  {
    includeAny : [],
    includeAll : [],
    excludeAny : [],
    excludeAll : []
  }
  var expected1 = src1;
  var expected2 =
  {
    includeAny : src3.includeAny,
    includeAll : [ /b0/, /c1/, /c2/, /3/, /4/, /5/, /14/, /16/, /17/ ],
    excludeAny : [ /c0/, /c1/, /c2/, /6/, /7/, /8/, /18/, /19/, /20/ ],
    excludeAll : src3.excludeAll
  },
  expected3 =
  {
    excludeAll : [ /9/, /10/, /11/ ],
    excludeAny : [ /6/, /7/, /8/ ] ,
    includeAll : [ /hello/, /3/, /4/, /5/ ],
    includeAny : [ /0/, /1/, /2/ ]
  };

  test.case = 'no arguments';
  var got = _.RegexpObject.And();
  test.contains( got, expected0 );

  test.case = 'empty RegexpObject object or nothing (missed source for RegexpObject extend)';
  var got = _.RegexpObject.And( {} );
  test.contains( got, expected0 );

  test.case = 'empty RegexpObject object or by single object';
  var got = _.RegexpObject.And( dst1, src1 );
  test.contains( got, expected1 );

  test.case = 'RegexpObjec with existing data or by other RegexpObject objects';
  var got = _.RegexpObject.And( dst2, src1, src2, src3 );
  test.contains( got, expected2 );

  test.case = 'String or by by single object';
  var got = _.RegexpObject.And( 'hello', src1 );
  debugger
  test.contains( got, expected3 );

  if( !Config.debug )
  return;

  // test.case = 'missed arguments';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.RegexpObject.And();
  // });

  // test.case = 'result (first passed) parameter in not object';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.RegexpObject.And( 'hello', src1 );
  // });

  test.case = 'source for RegexpObject extend has extra parameter';
  test.shouldThrowErrorSync( function()
  {
    _.RegexpObject.And( {}, wrongSrc );
  });

};

//

var Self =
{

  name : 'Tools.mid.RegExp',
  silencing : 1,

  tests :
  {

    regexpEscape,
    regexpArrayMake,
    regexpFrom,
    regexpArrayAny,
    regexpArrayAll,

    Test,
    _Extend,
    Or,
    And,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})( );
