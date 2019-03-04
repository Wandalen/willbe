( function _Paths_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  require( '../l3/Path.s' );

}

var _global = _global_;
var _ = _global_.wTools;

//

function refine( test )
{

  var got;

  var cases =
  [
    {
      description : 'posix path',
      src :
      [
        '/foo/bar//baz/asdf/quux/..',
        '/foo/bar//baz/asdf/quux/../',
        '//foo/bar//baz/asdf/quux/..//',
        'foo/bar//baz/asdf/quux/..//.',
      ],
      expected :
      [
        '/foo/bar//baz/asdf/quux/..',
        '/foo/bar//baz/asdf/quux/..',
        '//foo/bar//baz/asdf/quux/..//',
        'foo/bar//baz/asdf/quux/..//.'
       ]
    },
    {
      description : 'winoows path',
      src :
      [
        'C:\\temp\\\\foo\\bar\\..\\',
        'C:\\temp\\\\foo\\bar\\..\\\\',
        'C:\\temp\\\\foo\\bar\\..\\\\.',
        'C:\\temp\\\\foo\\bar\\..\\..\\',
        'C:\\temp\\\\foo\\bar\\..\\..\\.'
      ],
      expected :
      [
        '/C/temp//foo/bar/..',
        '/C/temp//foo/bar/..//',
        '/C/temp//foo/bar/..//.',
        '/C/temp//foo/bar/../..',
        '/C/temp//foo/bar/../../.'
      ]
    },
    {
      description : 'empty path',
      src :
      [
        '',
        '/',
        '//',
        '///',
        '/.',
        '/./.',
        '.',
        './.'
      ],
      expected :
      [
        '.',
        '/',
        '//',
        '///',
        '/.',
        '/./.',
        '.',
        './.'
      ]
    },
    {
      description : 'path with "." in the middle',
      src :
      [
        'foo/./bar/baz',
        'foo/././bar/baz/',
        'foo/././bar/././baz/',
        '/foo/././bar/././baz/'
      ],
      expected :
      [
        'foo/./bar/baz',
        'foo/././bar/baz',
        'foo/././bar/././baz',
        '/foo/././bar/././baz'
      ]
    },
    {
      description : 'path with "." in the beginning',
      src :
      [
        './foo/bar',
        '././foo/bar/',
        './/.//foo/bar/',
        '/.//.//foo/bar/',
        '.x/foo/bar',
        '.x./foo/bar'
      ],
      expected :
      [
        './foo/bar',
        '././foo/bar',
        './/.//foo/bar',
        '/.//.//foo/bar',
        '.x/foo/bar',
        '.x./foo/bar'
      ]
    },
    {
      description : 'path with "." in the end',
      src :
      [
        'foo/bar.',
        'foo/.bar.',
        'foo/bar/.',
        'foo/bar/./.',
        'foo/bar/././',
        '/foo/bar/././'
      ],
      expected :
      [
        'foo/bar.',
        'foo/.bar.',
        'foo/bar/.',
        'foo/bar/./.',
        'foo/bar/./.',
        '/foo/bar/./.'
      ]
    },
    {
      description : 'path with ".." in the middle',
      src :
      [
        'foo/../bar/baz',
        'foo/../../bar/baz/',
        'foo/../../bar/../../baz/',
        '/foo/../../bar/../../baz/',
      ],
      expected :
      [
        'foo/../bar/baz',
        'foo/../../bar/baz',
        'foo/../../bar/../../baz',
        '/foo/../../bar/../../baz'
      ]
    },
    {
      description : 'path with ".." in the beginning',
      src :
      [
        '../foo/bar',
        '../../foo/bar/',
        '..//..//foo/bar/',
        '/..//..//foo/bar/',
        '..x/foo/bar',
        '..x../foo/bar'
      ],
      expected :
      [
        '../foo/bar',
        '../../foo/bar',
        '..//..//foo/bar',
        '/..//..//foo/bar',
        '..x/foo/bar',
        '..x../foo/bar'
      ]
    },
    {
      description : 'path with ".." in the end',
      src :
      [
        'foo/bar..',
        'foo/..bar..',
        'foo/bar/..',
        'foo/bar/../..',
        'foo/bar/../../',
        '/foo/bar/../../'
      ],
      expected :
      [
        'foo/bar..',
        'foo/..bar..',
        'foo/bar/..',
        'foo/bar/../..',
        'foo/bar/../..',
        '/foo/bar/../..'
      ]
    },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    test.case = c.description;
    test.identical( _.paths.refine( c.src ), c.expected );
  }
}

//

function normalize( test )
{
  var cases =
  [
    {
      description : 'posix path',
      src :
      [
        '/foo/bar//baz/asdf/quux/..',
        '/foo/bar//baz/asdf/quux/../',
        '//foo/bar//baz/asdf/quux/..//',
        'foo/bar//baz/asdf/quux/..//.'
      ],
      expected :
      [
        '/foo/bar//baz/asdf',
        '/foo/bar//baz/asdf',
        '//foo/bar//baz/asdf//',
        'foo/bar//baz/asdf//'
      ]
    },
    {
      description : 'winoows path',
      src :
      [
        'C:\\temp\\\\foo\\bar\\..\\',
        'C:\\temp\\\\foo\\bar\\..\\\\',
        'C:\\temp\\\\foo\\bar\\..\\\\',
        'C:\\temp\\\\foo\\bar\\..\\..\\',
        'C:\\temp\\\\foo\\bar\\..\\..\\.'
      ],
      expected :
      [
        '/C/temp//foo',
        '/C/temp//foo//',
        '/C/temp//foo//',
        '/C/temp//',
        '/C/temp//'
      ]
    },
    {
      description : 'empty path',
      src :
      [
        '',
        '/',
        '//',
        '///',
        '/.',
        '/./.',
        '.',
        './.'
      ],
      expected :
      [
        '.',
        '/',
        '//',
        '///',
        '/',
        '/',
        '.',
        '.'
      ]
    },
    {
      description : 'path with "." in the middle',
      src :
      [
        'foo/./bar/baz',
        'foo/././bar/baz/',
        'foo/././bar/././baz/',
        '/foo/././bar/././baz/',
        '/foo/.x./baz/'
      ],
      expected :
      [
        'foo/bar/baz',
        'foo/bar/baz',
        'foo/bar/baz',
        '/foo/bar/baz',
        '/foo/.x./baz'
      ]
    },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    test.case = c.description;
    test.identical( _.paths.normalize( c.src ), c.expected );
  }

}

//

function dot( test )
{
  test.case = 'add ./ prefix';

  var cases =
  [
    {
      src :  [ '', 'a', '.', '.a', './a', '..', '..a', '../a',  ],
      expected : [ './', './a', '.', './.a', './a', '..', './..a', '../a' ]
    },
    // {
    //   src :  _.arrayToMap( [ '', 'a', '.', '.a', './a', '..', '..a', '../a' ] ),
    //   expected : _.arrayToMap( [ './', './a', '.', './.a', './a', '..', './..a', '../a' ] )
    // },
    {
      src :  { '' : 1, 'a' : 1, '.' : 1, '.a': 1, './a': 1, '..': 1, '..a': 1, '../a': 1 },
      expected : { './' : 1, './a' : 1, '.' : 1, './.a' : 1, './a' : 1, '..' : 1, './..a' : 1, '../a' : 1 }
    },
    {
      src : [ 'a', './', '', '/' ],
      error : true
    },
    {
      src : [ 'b', './a', '../a', '/a' ],
      error : true
    },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    if( c.error )
    {
      if( !Config.debug )
      continue;
      test.shouldThrowError( () => _.paths.dot( c.src ) )
    }
    else
    {
      test.identical( _.paths.dot( c.src ), c.expected );
    }
  }

}

//

function undot( test )
{
  test.case = 'rm ./ prefix'
  var cases =
  [
    {
      src : [ './', './a', '.', './.a', './a', '..', './..a', '../a', 'a', '/a' ],
      expected :  [ '', 'a', '.', '.a', 'a', '..', '..a', '../a', 'a', '/a' ]
    },
    // {
    //   src : _.arrayToMap( [ './', './a', '.', './.a', './a', '..', './..a', '../a', 'a', '/a' ] ),
    //   expected :  _.arrayToMap( [ '', 'a', '.', '.a', 'a', '..', '..a', '../a', 'a', '/a' ] )
    // },
    {
      src : { './' : 1, './a' : 1, '.' : 1, './.a' : 1, './a' : 1, '..' : 1, './..a' : 1, '../a' : 1 },
      expected :  { '' : 1, 'a' : 1, '.' : 1, '.a': 1, '..': 1, '..a': 1, '../a': 1 }
    },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    if( c.error )
    {
      if( !Config.debug )
      continue;
      test.shouldThrowError( () => _.paths.undot( c.src ) )
    }
    else
    test.identical( _.paths.undot( c.src ), c.expected );
  }
}

//

function join( test )
{
  test.case = 'join windows os paths';

  var got = _.paths.join( '/a', [ 'c:\\', 'foo\\', 'bar\\' ] );
  var expected = [ '/c', '/a/foo', '/a/bar' ];
  test.identical( got, expected );

  var got = _.paths.join( '/a', [ 'c:\\', 'foo\\', 'bar\\' ], 'd' );
  var expected = [ '/c/d', '/a/foo/d', '/a/bar/d' ];
  test.identical( got, expected );

  var got = _.paths.join( 'c:\\', [ 'a', 'b', 'c' ], 'd' );
  var expected = [ '/c/a/d', '/c/b/d', '/c/c/d' ];
  test.identical( got, expected );

  var got = _.paths.join( 'c:\\', [ '../a', './b', '..c' ] );
  var expected = [ '/a', '/c/b', '/c/..c' ];
  test.identical( got, expected );

  test.case = 'join unix os paths';

  var got = _.paths.join( '/a', [ 'b', 'c' ], 'd', 'e' );
  var expected = [ '/a/b/d/e', '/a/c/d/e' ];
  test.identical( got, expected );

  var got = _.paths.join( [ '/a', '/b', '/c' ], 'e' );
  var expected = [ '/a/e', '/b/e', '/c/e' ];
  test.identical( got, expected );

  var got = _.paths.join( [ '/a', '/b', '/c' ], [ '../a', '../b', '../c' ], [ './a', './b', './c' ] );
  var expected = [ '/a/a', '/b/b', '/c/c' ];
  test.identical( got, expected );

  var got = _.paths.join( [ 'a', 'b', 'c' ], [ 'a1', 'b1', 'c1' ], [ 'a2', 'b2', 'c2' ] );
  var expected = [ 'a/a1/a2', 'b/b1/b2', 'c/c1/c2' ];
  test.identical( got, expected );

  var got = _.paths.join( [ '/a', '/b', '/c' ], [ '../a', '../b', '../c' ], [ './a', './b', './c' ] );
  var expected = [ '/a/a', '/b/b', '/c/c' ];
  test.identical( got, expected );

  var got = _.paths.join( [ '/', '/a', '//a' ], [ '//', 'a//', 'a//a' ], 'b' );
  var expected = [ '//b', '/a/a//b', '//a/a//a/b' ];
  test.identical( got, expected );

  //

  test.case = 'works like join'

  var got = _.paths.join( '/a' );
  var expected = _.path.join( '/a' );
  test.identical( got, expected );

  var got = _.paths.join( '/a', 'd', 'e' );
  var expected = _.path.join( '/a', 'd', 'e' );
  test.identical( got, expected );

  var got = _.paths.join( '/a', '../a', './c' );
  var expected = _.path.join( '/a', '../a', './c' );
  test.identical( got, expected );

  //

  test.case = 'scalar + array with single argument'

  var got = _.paths.join( '/a', [ 'b' ] );
  var expected = [ '/a/b' ];
  test.identical( got, expected );

  test.case = 'array + array with single arguments'

  var got = _.paths.join( [ '/a' ], [ 'b' ] );
  var expected = [ '/a/b' ];
  test.identical( got, expected );

  //

  if( !Config.debug )
  return;

  test.case = 'arrays with different length'
  test.shouldThrowError( function()
  {
    _.paths.join( [ '/b', '.c' ], [ '/b' ] );
  });

  test.case = 'nothing passed';
  test.shouldThrowErrorSync( function()
  {
    _.paths.join();
  });

  // test.case = 'object passed';
  // test.shouldThrowErrorSync( function()
  // {
  //   _.paths.join( {} );
  // });

  test.case = 'inner arrays'
  test.shouldThrowError( function()
  {
    _.paths.join( [ '/b', '.c' ], [ '/b', [ 'x' ] ] );
  });
}

//

function reroot( test )
{

  test.case = 'paths reroot';

  var got = _.paths.reroot( 'a', [ '/a', 'b' ] );
  var expected = [ 'a/a', 'a/b' ];
  test.identical( got, expected );

  var got = _.paths.reroot( [ '/a', '/b' ], [ '/a', '/b' ] );
  var expected = [ '/a/a', '/b/b' ];
  test.identical( got, expected );

  var got = _.paths.reroot( '../a', [ '/b', '.c' ], './d' );
  var expected = [ '../a/b/d', '../a/.c/d' ]
  test.identical( got, expected );

  var got = _.paths.reroot( [ '/a' , '/a' ] );
  var expected = [ '/a' , '/a' ];
  test.identical( got, expected );

  var got = _.paths.reroot( '.', '/', './', [ 'a', 'b' ] );
  var expected = [ './a', './b' ];
  test.identical( got, expected );

  //

  test.case = 'scalar + scalar'

  var got = _.paths.reroot( '/a', '/a' );
  var expected = '/a/a';
  test.identical( got, expected );

  test.case = 'scalar + array with single argument'

  var got = _.paths.reroot( '/a', [ '/b' ] );
  var expected = [ '/a/b' ];
  test.identical( got, expected );

  test.case = 'array + array with single arguments'

  var got = _.paths.reroot( [ '/a' ], [ '/b' ] );
  var expected = [ '/a/b' ];
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'arrays with different length'
  test.shouldThrowError( function()
  {
    _.paths.reroot( [ '/b', '.c' ], [ '/b' ] );
  });

  test.case = 'inner arrays'
  test.shouldThrowError( function()
  {
    _.paths.reroot( [ '/b', '.c' ], [ '/b', [ 'x' ] ] );
  });
}

//

function resolve( test )
{
  test.case = 'paths resolve';

  var current = _.path.current();

  var got = _.paths.resolve( 'c', [ '/a', 'b' ] );
  var expected = [ '/a', _.path.join( current, 'c/b' ) ];
  test.identical( got, expected );

  var got = _.paths.resolve( [ '/a', '/b' ], [ '/a', '/b' ] );
  var expected = [ '/a', '/b' ];
  test.identical( got, expected );

  var got = _.paths.resolve( '../a', [ 'b', '.c' ] );
  var expected = [ _.path.dir( current ) + '/a/b', _.path.dir( current ) + '/a/.c' ]
  test.identical( got, expected );

  var got = _.paths.resolve( '../a', [ '/b', '.c' ], './d' );
  var expected = [ '/b/d', _.path.dir( current ) + '/a/.c/d' ];
  test.identical( got, expected );

  var got = _.paths.resolve( [ '/a', '/a' ],[ 'b', 'c' ] );
  var expected = [ '/a/b' , '/a/c' ];
  test.identical( got, expected );

  var got = _.paths.resolve( [ '/a', '/a' ],[ 'b', 'c' ], 'e' );
  var expected = [ '/a/b/e' , '/a/c/e' ];
  test.identical( got, expected );

  var got = _.paths.resolve( [ '/a', '/a' ],[ 'b', 'c' ], '/e' );
  var expected = [ '/e' , '/e' ];
  test.identical( got, expected );

  var got = _.paths.resolve( '.', '../', './', [ 'a', 'b' ] );
  var expected = [ _.path.dir( current ) + '/a', _.path.dir( current ) + '/b' ];
  test.identical( got, expected );

  //

  test.case = 'works like resolve';

  var got = _.paths.resolve( '/a', 'b', 'c' );
  var expected = _.path.resolve( '/a', 'b', 'c' );
  test.identical( got, expected );

  var got = _.paths.resolve( '/a', 'b', 'c' );
  var expected = _.path.resolve( '/a', 'b', 'c' );
  test.identical( got, expected );

  var got = _.paths.resolve( '../a', '.c' );
  var expected = _.path.resolve( '../a', '.c' );
  test.identical( got, expected );

  var got = _.paths.resolve( '/a' );
  var expected = _.path.resolve( '/a' );
  test.identical( got, expected );

  var got = _.paths.resolve( 'b' );
  var expected = _.path.join( current, 'b' );
  test.identical( got, expected );

  var got = _.paths.resolve( './b' );
  var expected = _.path.join( current, 'b' );
  test.identical( got, expected );

  var got = _.paths.resolve( '../b' );
  var expected = _.path.join( _.path.dir( current ), 'b' );
  test.identical( got, expected );

  var got = _.paths.resolve( '..' );
  var expected = _.path.dir( current )
  test.identical( got, expected );

  //

  test.case = 'scalar + array with single argument'

  var got = _.paths.resolve( '/a', [ 'b/..' ] );
  var expected = [ '/a' ];
  test.identical( got, expected );

  test.case = 'array + array with single arguments'

  var got = _.paths.resolve( [ '/a' ], [ 'b/../' ] );
  var expected = [ '/a' ];
  test.identical( got, expected );

  test.case = 'single array';

  var got = _.paths.resolve( [ '/a', 'b', './b', '../b', '..' ] );
  var expected =
  [
    '/a',
    _.path.join( current, 'b' ),
    _.path.join( current, 'b' ),
    _.path.join( _.path.dir( current ), 'b' ),
    _.path.dir( current )
  ];
  test.identical( got, expected );

  //

  if( !Config.debug )
  return

  test.case = 'arrays with different length'
  test.shouldThrowError( function()
  {
    _.paths.resolve( [ '/b', '.c' ], [ '/b' ] );
  });

  test.shouldThrowError( function()
  {
    _.paths.resolve();
  });

  test.case = 'inner arrays'
  test.shouldThrowError( function()
  {
    _.paths.resolve( [ '/b', '.c' ], [ '/b', [ 'x' ] ] );
  });
}

//

function dir( test )
{
  var cases =
  [
    {
      description : 'simple absolute path',
      src : [ '/foo' ],
      expected : [ '/' ]
    },
    {
      description : 'absolute path : nested dirs',
      src :
      [
        '/foo/bar/baz/text.txt',
        '/aa/bb',
        '/aa/bb/',
        '/aa',
        '/'
      ],
      expected :
      [
        '/foo/bar/baz',
        '/aa',
        '/aa/bb',
        '/',
        '/..'
      ]
    },
    {
      description : 'relative path : nested dirs',
      src :
      [
        'aa/bb',
        'aa',
        '.',
        '..'
      ],
      expected :
      [
        'aa',
        '.',
        '..',
        '../..'
      ]
    },
    {
      description : 'incorrect path type',
      src : [  'aa/bb',  1  ],
      error : true
    }
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    if( c.error )
    {
      if( !Config.debug )
      continue;
      test.shouldThrowError( () => _.paths.dir( c.src ) )
    }
    else
    {
      test.identical( _.paths.dir( c.src ), c.expected );
    }
  }

}

//

function ext( test )
{
  var cases =
  [
    {
      description : 'absolute path : nested dirs',
      src :
      [
        'some.txt',
        '/foo/bar/baz.asdf',
        '/foo/bar/.baz',
        '/foo.coffee.md',
        '/foo/bar/baz'
      ],
      expected :
      [
        'txt',
        'asdf',
        '',
        'md',
        ''
      ]
    },
    {
      description : 'incorrect path type',
      src : [  'aa/bb',  1  ],
      error : true
    }
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    if( c.error )
    {
      if( !Config.debug )
      continue;
      test.shouldThrowError( () => _.paths.ext( c.src ) )
    }
    else
    test.identical( _.paths.ext( c.src ), c.expected );
  }
}

//

function prefixGet( test )
{
  var cases =
  [
    {
      description : 'get path without ext',
      src :
      [
        '',
        'some.txt',
        '/foo/bar/baz.asdf',
        '/foo/bar/.baz',
        '/foo.coffee.md',
        '/foo/bar/baz'
      ],
      expected :
      [
        '',
        'some',
        '/foo/bar/baz',
        '/foo/bar/',
        '/foo',
        '/foo/bar/baz'
      ]
    },
    {
      description : 'incorrect path type',
      src : [  'aa/bb',  1  ],
      error : true
    }
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    if( c.error )
    {
      if( !Config.debug )
      continue;
      test.shouldThrowError( () => _.paths.prefixGet( c.src ) )
    }
    else
    test.identical( _.paths.prefixGet( c.src ), c.expected );
  }
}

//

function name( test )
{
  var cases =
  [
    {
      description : 'get paths name',
      withExtension : 0,
      src :
      [
        '',
        'some.txt',
        '/foo/bar/baz.asdf',
        '/foo/bar/.baz',
        '/foo.coffee.md',
        '/foo/bar/baz'
      ],
      expected :
      [
        '',
        'some',
        'baz',
        '',
        'foo.coffee',
        'baz'
      ]
    },
    {
      description : 'get paths name with extension',
      withExtension : 1,
      src :
      [
        '',
        'some.txt',
        '/foo/bar/baz.asdf',
        '/foo/bar/.baz',
        '/foo.coffee.md',
        '/foo/bar/baz'
      ],
      expected :
      [
        '',
        'some.txt',
        'baz.asdf',
        '.baz',
        'foo.coffee.md',
        'baz'
      ]
    },
    {
      description : 'incorrect path type',
      src : [  'aa/bb',  1  ],
      error : true
    }
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    test.case = c.description;

    if( c.error )
    {
      if( !Config.debug )
      continue;
      test.shouldThrowError( () => _.paths.name( c.src ) );
    }
    else
    {
      var args = c.src.slice();

      if( c.withExtension )
      {
        for( var j = 0; j < args.length; j++ )
        args[ j ] = { path : args[ j ], withExtension : 1 };
      }

      test.identical( _.paths.name( args ), c.expected );
    }
  }
};

//

function withoutExt( test )
{

  var cases =
  [
    {
      description : ' get paths without extension ',
      src :
      [
        '',
        'some.txt',
        '/foo/bar/baz.asdf',
        '/foo/bar/.baz',
        '/foo.coffee.md',
        '/foo/bar/baz',
        './foo/.baz',
        './.baz',
        '.baz.txt',
        './baz.txt',
        './foo/baz.txt',
        './foo/',
        'baz',
        'baz.a.b'
      ],
      expected :
      [
        '',
        'some',
        '/foo/bar/baz',
        '/foo/bar/.baz',
        '/foo.coffee',
        '/foo/bar/baz',
        './foo/.baz',
        './.baz',
        '.baz',
        './baz',
        './foo/baz',
        './foo/',
        'baz',
        'baz.a'
      ]
    },
    {
      description : 'incorrect path type',
      src : [  'aa/bb',  1  ],
      error : true
    }
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    test.case = c.description;

    if( c.error )
    {
      if( !Config.debug )
      continue;
      test.shouldThrowError( () => _.paths.withoutExt( c.src ) );
    }
    else
    test.identical( _.paths.withoutExt( c.src ), c.expected );
  }
};

//

function changeExt( test )
{
  var cases =
  [
    {
      description : 'change paths extension ',
      path :
      [
        'some.txt',
        'some.txt',
        '/foo/bar/baz.asdf',
        '/foo/bar/.baz',
        '/foo.coffee.md',
        '/foo/bar/baz',
        '/foo/baz.bar/some.md',
        './foo/.baz',
        './.baz',
        '.baz',
        './baz',
        './foo/baz',
        './foo/'
      ],
      ext :
      [
        '',
        'json',
        'txt',
        'sh',
        'min',
        'txt',
        'txt',
        'txt',
        'txt',
        'txt',
        'txt',
        'txt',
        'txt'
      ],
      expected :
      [
        'some',
        'some.json',
        '/foo/bar/baz.txt',
        '/foo/bar/.baz.sh',
        '/foo.coffee.min',
        '/foo/bar/baz.txt',
        '/foo/baz.bar/some.txt',
        './foo/.baz.txt',
        './.baz.txt',
        '.baz.txt',
        './baz.txt',
        './foo/baz.txt',
        './foo/.txt'
      ]
    },
    // {
    //   description : 'element must be array',
    //   src : [  'aa/bb' ],
    //   error : true
    // },
    // {
    //   description : 'element length must be 2',
    //   src : [ [ 'abc' ] ],
    //   error : true
    // }
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];

    test.case = c.description;

    if( c.error )
    {
      if( !Config.debug )
      continue;
      test.shouldThrowError( () => _.paths.changeExt( c.src ) );
    }
    else
    test.identical( _.paths.changeExt( c.path, c.ext ), c.expected );
  }
};

//

function relative( test )
{
  var from =
  [
    '/aa/bb/cc',
    '/aa/bb/cc/',
    '/aa/bb/cc',
    '/aa/bb/cc/',
    '/foo/bar/baz/asdf/quux',
    '/foo/bar/baz/asdf/quux',
    '/foo/bar/baz/asdf/quux',
    '/foo/bar/baz/asdf/quux/dir1/dir2',
    '/abc',
    '/abc/def',
    '/',
    '/',
    '/',
    'd:/',
    '/a/b/xx/yy/zz',
  ];
  var to =
  [
    [ '/aa/bb/cc', '/aa/bb/cc/' ],
    [ '/aa/bb/cc', '//aa/bb/cc/' ],
    [ '/aa/bb', '/aa/bb/' ],
    [ '/aa/bb', '//aa/bb/' ],
    '/foo/bar/baz/asdf/quux',
    '/foo/bar/baz/asdf/quux/new1',
    '/foo/bar/baz/asdf',
    [
      '/foo/bar/baz/asdf/quux/dir1/dir2',
      '/foo/bar/baz/asdf/quux/dir1/',
      '/foo/bar/baz/asdf/quux/',
      '/foo/bar/baz/asdf/quux/dir1/dir2/dir3',
    ],
    '/a/b/z',
    '/a/b/z',
    '/a/b/z',
    '/a',
    '/',
    'c:/x/y',
    '/a/b/files/x/y/z.txt',
  ];

  var expected =
  [
    [ '.', '.' ],
    [ '.', '../../..//aa/bb/cc' ],
    [ '..', '..' ],
    [ '..', '../../..//aa/bb' ],
    '.',
    'new1',
    '..',
    [ '.', '..', '../..', 'dir3' ],
    '../a/b/z',
    '../../a/b/z',
    'a/b/z',
    'a',
    '.',
    '../c/x/y',
    '../../../files/x/y/z.txt',
  ];

  var allArrays = [];
  var allObjects = [];
  var allExpected = [];

  for( var i = 0; i < from.length; i++ )
  {
    var relative = from[ i ];
    var path = to[ i ];
    var exp = expected[ i ];

    test.case = 'single pair inside array'
    var got = _.paths.relative( relative, path );
    test.identical( got, exp );

    // test.case = 'as single object'
    // var o =
    // {
    //   relative : relative,
    //   path : path
    // }
    // allObjects.push( o );
    // var got = _.paths.relative( o );
    // test.identical( got, exp );
  }

  test.case = 'relative to array of paths'; /* */
  var from4 = '/foo/bar/baz/asdf/quux/dir1/dir2';
  var to4 =
  [
    '/foo/bar/baz/asdf/quux/dir1/dir2',
    '/foo/bar/baz/asdf/quux/dir1/',
    '/foo/bar/baz/asdf/quux/',
    '/foo/bar/baz/asdf/quux/dir1/dir2/dir3',
  ];
  var expected4 = [ '.', '..', '../..', 'dir3' ];
  var got = _.paths.relative( from4, to4);
  test.identical( got, expected4 );

  test.case = 'relative to array of paths, one of paths is relative, resolving off'; /* */
  var from4 = '/foo/bar/baz/asdf/quux/dir1/dir2';
  var to4 =
  [
    '/foo/bar/baz/asdf/quux/dir1/dir2',
    '/foo/bar/baz/asdf/quux/dir1/',
    './foo/bar/baz/asdf/quux/',
    '/foo/bar/baz/asdf/quux/dir1/dir2/dir3',
  ];
  test.shouldThrowErrorSync( function()
  {
    _.paths.relative( from4, to4 );
  })

  // test.case = 'both relative, long, not direct,resolving 1'; /* */
  // var from = 'a/b/xx/yy/zz';
  // var to = 'a/b/files/x/y/z.txt';
  // var expected = '../../../files/x/y/z.txt';
  // var o =
  // {
  //   relative :  from,
  //   path : to,
  //   resolving : 1
  // }
  // var got = _.paths.relative( o );
  // test.identical( got, expected );

  //

  test.case = 'works like relative';

  var got = _.paths.relative( '/aa/bb/cc', '/aa/bb/cc' );
  var expected = _.path.relative( '/aa/bb/cc', '/aa/bb/cc' );
  test.identical( got, expected );

  var got = _.paths.relative( '/foo/bar/baz/asdf/quux', '/foo/bar/baz/asdf/quux/new1' );
  var expected = _.path.relative( '/foo/bar/baz/asdf/quux', '/foo/bar/baz/asdf/quux/new1' );
  test.identical( got, expected );

  //

  if( !Config.debug )
  return;

  test.case = 'only relative';
  test.shouldThrowErrorSync( function()
  {
    _.paths.relative( '/foo/bar/baz/asdf/quux' );
  })

  /**/

  test.shouldThrowErrorSync( function()
  {
    _.paths.relative
    ({
      relative : '/foo/bar/baz/asdf/quux'
    });
  })

  // test.case = 'two relative, long, not direct'; /* */
  // var from = 'a/b/xx/yy/zz';
  // var to = 'a/b/files/x/y/z.txt';
  // var o =
  // {
  //   relative :  from,
  //   path : to,
  //   resolving : 0
  // }
  // var expected = '../../../files/x/y/z.txt';
  // var got = _.paths.relative( o );
  // test.identical( got, expected );

  // test.case = 'relative to array of paths, one of paths is relative, resolving off'; /* */
  // var from = '/foo/bar/baz/asdf/quux/dir1/dir2';
  // var to =
  // [
  //   '/foo/bar/baz/asdf/quux/dir1/dir2',
  //   '/foo/bar/baz/asdf/quux/dir1/',
  //   './foo/bar/baz/asdf/quux/',
  //   '/foo/bar/baz/asdf/quux/dir1/dir2/dir3',
  // ];
  // test.shouldThrowErrorSync( function()
  // {
  //   _.paths.relative([ { relative : from, path : to } ]);
  // })

  // test.case = 'one relative, resolving 0'; /* */
  // var from = 'c:/x/y';
  // var to = 'a/b/files/x/y/z.txt';
  // var o =
  // {
  //   relative :  from,
  //   path : to,
  //   resolving : 0
  // }
  // test.shouldThrowErrorSync( function()
  // {
  //   _.paths.relative( o );
  // })

  test.case = 'different length'; /* */
  test.shouldThrowErrorSync( function()
  {
    _.paths.relative( [ '/a1/b' ], [ '/a1','/a2' ] );
  })

}

//

function common( test )
{
  var cases =
  [
    {
      description : 'simple',
      src : [ '/a1/b2', '/a1/b' , '/a1/b2/c' ],
      expected : '/a1/'
    },
    {
      description : 'with array',
      src : [ '/a1/b2', [ '/a1/b' , '/a1/b2/c' ] ],
      expected : [ '/a1/' , '/a1/b2' ]
    },
    {
      description : 'two arrays',
      src : [ [ '/a1/b' , '/a1/b2/c' ], [ '/a1/b' , '/a1/b2/c' ] ],
      expected : [ '/a1/b' , '/a1/b2/c' ]
    },
    {
      description : 'mixed',
      src : [ '/a1', [ '/a1/b' , '/a1/b2/c' ], [ '/a1/b1' , '/a1/b2/c' ], '/a1' ],
      expected : [ '/a1' , '/a1' ]
    },
    {
      description : 'arrays with different length',
      src : [ [ '/a1/b' , '/a1/b2/c' ], [ '/a1/b1'  ] ],
      error : true
    },
    // {
    //   description : 'incorrect argument',
    //   src : 'abc',
    //   error : true
    // },
    // {
    //   description : 'incorrect arguments length',
    //   src : [ 'abc', 'x' ],
    //   error : true
    // },
  ]

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    test.case = c.description;
    if( c.error )
    {
      if( !Config.debug )
      continue;
      test.shouldThrowError( () => _.paths.common.apply( _.paths, c.src ) );
    }
    else
    {
      test.identical( _.paths.common.apply( _.paths, c.src ), c.expected );
    }
  }

}

// --
// declare
// --

var Self =
{

  name : 'Tools/base/l3/path/S',
  silencing : 1,
  // verbosity : 7,
  // routine : 'relative',

  tests :
  {

    refine,
    normalize,

    dot,
    undot,

    join,
    reroot,
    resolve,

    dir,
    ext,
    prefixGet,
    name,
    withoutExt,
    changeExt,

    relative,

    common,

  },
}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
