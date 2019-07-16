( function _Proto_test_s_( ) {

'use strict'; 

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wComparator' );

  require( '../../abase/l3/Proto.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// test
// --

function instanceIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.is( !_.instanceIs( Object.create( null ) ) );

  t.will = 'map';
  t.is( !_.instanceIs( {} ) );

  t.will = 'primitive';
  t.is( !_.instanceIs( 0 ) );
  t.is( !_.instanceIs( 1 ) );
  t.is( !_.instanceIs( '1' ) );
  t.is( !_.instanceIs( null ) );
  t.is( !_.instanceIs( undefined ) );

  t.will = 'routine';
  t.is( !_.instanceIs( Date ) );
  t.is( !_.instanceIs( Float32Array ) );
  t.is( !_.instanceIs( function(){} ) );
  t.is( !_.instanceIs( Self.constructor ) );

  t.will = 'long';
  t.is( _.instanceIs( [] ) );
  t.is( _.instanceIs( new Float32Array() ) );

  t.will = 'object-like';
  t.is( _.instanceIs( /x/ ) );
  t.is( _.instanceIs( new Date() ) );
  t.is( _.instanceIs( new (function(){})() ) );
  t.is( _.instanceIs( Self ) );

  t.will = 'object-like prototype';
  t.is( !_.instanceIs( Object.getPrototypeOf( [] ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( /x/ ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( new Date() ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( new Float32Array() ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.is( !_.instanceIs( Object.getPrototypeOf( Self ) ) );

}

//

function instanceIsStandard( t )
{
  var self = this;

  t.will = 'pure map';
  t.is( !_.instanceIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.is( !_.instanceIsStandard( {} ) );

  t.will = 'primitive';
  t.is( !_.instanceIsStandard( 0 ) );
  t.is( !_.instanceIsStandard( 1 ) );
  t.is( !_.instanceIsStandard( '1' ) );
  t.is( !_.instanceIsStandard( null ) );
  t.is( !_.instanceIsStandard( undefined ) );

  t.will = 'routine';
  t.is( !_.instanceIsStandard( Date ) );
  t.is( !_.instanceIsStandard( Float32Array ) );
  t.is( !_.instanceIsStandard( function(){} ) );
  t.is( !_.instanceIsStandard( Self.constructor ) );

  t.will = 'long';
  t.is( !_.instanceIsStandard( [] ) );
  t.is( !_.instanceIsStandard( new Float32Array() ) );

  t.will = 'object-like';
  t.is( !_.instanceIsStandard( /x/ ) );
  t.is( !_.instanceIsStandard( new Date() ) );
  t.is( !_.instanceIsStandard( new (function(){})() ) );
  t.is( _.instanceIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.is( !_.instanceIsStandard( Object.getPrototypeOf( [] ) ) );
  t.is( !_.instanceIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.is( !_.instanceIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.is( !_.instanceIsStandard( Object.getPrototypeOf( new Float32Array() ) ) );
  t.is( !_.instanceIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.is( !_.instanceIsStandard( Object.getPrototypeOf( Self ) ) );

}

//

function prototypeIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.is( !_.prototypeIs( Object.create( null ) ) );

  t.will = 'map';
  t.is( !_.prototypeIs( {} ) );

  t.will = 'primitive';
  t.is( !_.prototypeIs( 0 ) );
  t.is( !_.prototypeIs( 1 ) );
  t.is( !_.prototypeIs( '1' ) );
  t.is( !_.prototypeIs( null ) );
  t.is( !_.prototypeIs( undefined ) );

  t.will = 'routine';
  t.is( !_.prototypeIs( Date ) );
  t.is( !_.prototypeIs( Float32Array ) );
  t.is( !_.prototypeIs( function(){} ) );
  t.is( !_.prototypeIs( Self.constructor ) );

  t.will = 'object-like';
  t.is( !_.prototypeIs( [] ) );
  t.is( !_.prototypeIs( /x/ ) );
  t.is( !_.prototypeIs( new Date() ) );
  t.is( !_.prototypeIs( new Float32Array() ) );
  t.is( !_.prototypeIs( new (function(){})() ) );
  t.is( !_.prototypeIs( Self ) );

  t.will = 'object-like prototype';
  t.is( _.prototypeIs( Object.getPrototypeOf( [] ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( /x/ ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( new Date() ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( new Float32Array() ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.is( _.prototypeIs( Object.getPrototypeOf( Self ) ) );

}

//

function constructorIs( t )
{
  var self = this;

  t.will = 'pure map';
  t.is( !_.constructorIs( Object.create( null ) ) );

  t.will = 'map';
  t.is( !_.constructorIs( {} ) );

  t.will = 'primitive';
  t.is( !_.constructorIs( 0 ) );
  t.is( !_.constructorIs( 1 ) );
  t.is( !_.constructorIs( '1' ) );
  t.is( !_.constructorIs( null ) );
  t.is( !_.constructorIs( undefined ) );

  t.will = 'routine';
  t.is( _.constructorIs( Date ) );
  t.is( _.constructorIs( Float32Array ) );
  t.is( _.constructorIs( function(){} ) );
  t.is( _.constructorIs( Self.constructor ) );

  t.will = 'object-like';
  t.is( !_.constructorIs( [] ) );
  t.is( !_.constructorIs( /x/ ) );
  t.is( !_.constructorIs( new Date() ) );
  t.is( !_.constructorIs( new Float32Array() ) );
  t.is( !_.constructorIs( new (function(){})() ) );
  t.is( !_.constructorIs( Self ) );

  t.will = 'object-like prototype';
  t.is( !_.constructorIs( Object.getPrototypeOf( [] ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( /x/ ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( new Date() ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( new Float32Array() ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( new (function(){})() ) ) );
  t.is( !_.constructorIs( Object.getPrototypeOf( Self ) ) );

}

//

function prototypeIsStandard( t )
{
  var self = this;

  t.will = 'pure map';
  t.is( !_.prototypeIsStandard( Object.create( null ) ) );

  t.will = 'map';
  t.is( !_.prototypeIsStandard( {} ) );

  t.will = 'primitive';
  t.is( !_.prototypeIsStandard( 0 ) );
  t.is( !_.prototypeIsStandard( 1 ) );
  t.is( !_.prototypeIsStandard( '1' ) );
  t.is( !_.prototypeIsStandard( null ) );
  t.is( !_.prototypeIsStandard( undefined ) );

  t.will = 'routine';
  t.is( !_.prototypeIsStandard( Date ) );
  t.is( !_.prototypeIsStandard( Float32Array ) );
  t.is( !_.prototypeIsStandard( function(){} ) );
  t.is( !_.prototypeIsStandard( Self.constructor ) );

  t.will = 'object-like';
  t.is( !_.prototypeIsStandard( [] ) );
  t.is( !_.prototypeIsStandard( /x/ ) );
  t.is( !_.prototypeIsStandard( new Date() ) );
  t.is( !_.prototypeIsStandard( new Float32Array() ) );
  t.is( !_.prototypeIsStandard( new (function(){})() ) );
  t.is( !_.prototypeIsStandard( Self ) );

  t.will = 'object-like prototype';
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( [] ) ) );
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( /x/ ) ) );
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( new Date() ) ) );
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( new Float32Array() ) ) );
  t.is( !_.prototypeIsStandard( Object.getPrototypeOf( new (function(){})() ) ) );
  t.is( _.prototypeIsStandard( Object.getPrototypeOf( Self ) ) );

}

//

function accessor( test )
{

  test.case = 'setter'; /**/
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _aSet : function( src )
      {
        this[ Symbol.for( 'a' ) ] = src * 2;
      },
      Composes : {}
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 10;
  test.identical( got, expected );

  test.case = 'getter'; /**/
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] * 2;
      },
      Composes : {}
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 10;
  test.identical( got, expected );

  test.case = 'getter & setter'; /**/
  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend :
    {
      _aSet : function( src )
      {
        this[ Symbol.for( 'a' ) ] = src * 2;
      },
      _aGet : function()
      {
        return this[ Symbol.for( 'a' ) ] / 2;
      },
      Composes : {}
    }
  });
  _.accessor.declare( Alpha.prototype, { a : 'a' } );
  var x = new Alpha();
  x.a = 5;
  var got = x.a;
  var expected = 5;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'empty call'; /**/
  test.shouldThrowError( function()
  {
    _.accessor.declare( );
  });

  test.case = 'invalid first argument type'; /**/
  test.shouldThrowError( function()
  {
    _.accessor.declare( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type'; /**/
  test.shouldThrowError( function()
  {
    _.accessor.declare( {}, [] );
  });

  test.case = 'does not have Composes'; /**/
  test.shouldThrowError( function()
  {
    _.accessor.declare( { constructor : function(){}, },{ a : 'a' } );
  });

  test.case = 'does not have constructor'; /**/
  test.shouldThrowError( function()
  {
    _.accessor.declare( { Composes : {}, },{ a : 'a' } );
  });

}

//

function accessorIsClean( test )
{

  /* - */

  test.open( 'with class, readOnly:1' );

  test.case = 'setup';

  function BasicConstructor()
  {
    _.instanceInit( this );
  }

  var Accessors =
  {
    f1 : { readOnly : 1 },
  }

  var Extend =
  {
    Accessors : Accessors,
  }

  // Extend.constructor = BasicConstructor;

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extend,
  });

  debugger;
  var methods = Object.create( null );
  _.accessor.declare
  ({
    object : BasicConstructor.prototype,
    names : { f2 : { readOnly : 1 } },
    methods : methods,
  });
  debugger;

  var instance = new BasicConstructor();

  test.case = 'methods';

  debugger;
  test.is( _.routineIs( methods._f2Get ) );
  test.identical( _.mapKeys( methods ).length, 1 );

  test.case = 'inline no method';

  test.identical( instance._f1Get, undefined );
  test.identical( instance._f1Set, undefined );
  test.identical( BasicConstructor._f1Get, undefined );
  test.identical( BasicConstructor._f1Set, undefined );
  test.identical( BasicConstructor.prototype._f1Get, undefined );
  test.identical( BasicConstructor.prototype._f1Set, undefined );

  test.identical( instance._f2Get, undefined );
  test.identical( instance._f2Set, undefined );
  test.identical( BasicConstructor._f2Get, undefined );
  test.identical( BasicConstructor._f2Set, undefined );
  test.identical( BasicConstructor.prototype._f2Get, undefined );
  test.identical( BasicConstructor.prototype._f2Set, undefined );

  test.close( 'with class, readOnly:1' );

}

// accessorIsClean.timeOut = 300000;

//

function accessorForbid( test )
{

  test.case = 'accessor forbid getter&setter';
  var Alpha = { };
  _.accessor.forbid( Alpha, { a : 'a' } );
  try
  {
    Alpha.a = 5;
  }
  catch( err )
  {
    Alpha[ Symbol.for( 'a' ) ] = 5;
  }
  var got;
  try
  {
    got = Alpha.a;
  }
  catch( err )
  {
    got = Alpha[ Symbol.for( 'a' ) ];
  }
  var expected = 5;
  test.identical( got, expected );

  if( !Config.debug ) /* */
  return;

  test.case = 'forbid get';
  test.shouldThrowError( function()
  {
    var Alpha = { };
    _.accessor.forbid( Alpha, { a : 'a' } );
    Alpha.a;
  });

  test.case = 'forbid set';
  test.shouldThrowError( function()
  {
    var Alpha = { };
    _.accessor.forbid( Alpha, { a : 'a' } );
    Alpha.a = 5;
  });

  test.case = 'empty call';
  test.shouldThrowError( function()
  {
    _.accessor.forbid( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.accessor.forbid( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.accessor.forbid( {}, 1 );
  });

}

//

function accessorReadOnly( test )
{
  test.case = 'readOnly';

  var Alpha = function _Alpha(){}
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend : { Composes : { a : null } }
  });
  _.accessor.readOnly( Alpha.prototype,{ a : 'a' });
  var x = new Alpha();
  test.shouldThrowError( () => x.a = 1 );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha.prototype, 'a' );
  var got = descriptor.set ? true : false;
  var expected = false;
  test.identical( got, expected );

  test.case = 'saves field value';
  var Alpha = function _Alpha( a )
  {
    this[ Symbol.for( 'a' ) ] = a;
  }
  _.classDeclare
  ({
    cls : Alpha,
    parent : null,
    extend : { Composes : { a : 6 } }
  });
  _.accessor.readOnly( Alpha.prototype, { a : 'a' } );
  var x = new Alpha( 5 );
  test.shouldThrowError( () => x.a = 1 );
  var descriptor = Object.getOwnPropertyDescriptor( Alpha.prototype, 'a' );
  var got = !descriptor.set && x.a === 5;
  var expected = true;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.case = 'readonly';
  test.shouldThrowError( function()
  {
    var Alpha = { };
    _.accessor.readOnly( Alpha, { a : 'a' } );
    Alpha.a = 5;
  });

  test.case = 'setter defined';
  test.shouldThrowError( function()
  {
    var Alpha = { _aSet : function() { } };
    _.accessor.readOnly( Alpha, { a : 'a' } );
  });

  test.case = 'empty call';
  test.shouldThrowError( function()
  {
    _.accessor.readOnly( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.accessor.readOnly( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.accessor.readOnly( {}, [] );
  });

}

//

function forbids( test )
{

  test.open( 'pure map' );

  test.case = 'setup';

  var Forbids =
  {
    f1 : 'f1',
  }

  var instance = Object.create( null );

  _.accessor.forbid( instance, Forbids );

  test.case = 'inline no method';

  test.identical( instance._f1Get, undefined );
  test.identical( instance._f1Set, undefined );
  test.identical( _.mapProperties( instance ), Object.create( null ) );

  test.case = 'throwing';

  if( Config.debug )
  {
    test.shouldThrowError( () => instance.f1 );
  }

  test.close( 'pure map' );

  /* - */

  test.open( 'with class' );

  test.case = 'setup';

  function BasicConstructor()
  {
    _.instanceInit( this );
  }

  var Forbids =
  {
    f1 : 'f1',
  }

  var Extend =
  {
    Forbids : Forbids,
  }

  // Extend.constructor = BasicConstructor;

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extend,
  });

  var instance = new BasicConstructor();

  test.case = 'inline no method';

  test.identical( instance._f1Get, undefined );
  test.identical( instance._f1Set, undefined );
  test.identical( BasicConstructor._f1Get, undefined );
  test.identical( BasicConstructor._f1Set, undefined );
  test.identical( BasicConstructor.prototype._f1Get, undefined );
  test.identical( BasicConstructor.prototype._f1Set, undefined );

  test.case = 'throwing';

  if( Config.debug )
  {
    test.shouldThrowError( () => instance.f1 );
    test.shouldThrowError( () => BasicConstructor.prototype.f1 );
  }

  test.close( 'with class' );

}

// forbids.timeOut = 300000;

//

function constant( test )
{

  test.case = 'second argument is map';
  var dstMap = {};
  _.accessor.constant( dstMap, { a : 5 } );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 5 );

  test.case = 'rewrites existing field';
  var dstMap = { a : 5 };
  _.accessor.constant( dstMap, { a : 1 } );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 1 );

  test.case = '3 arguments';
  var dstMap = {};
  _.accessor.constant( dstMap, 'a', 5 );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 5 );

  test.case = '2 arguments, no value';
  var dstMap = {};
  _.accessor.constant( dstMap, 'a' );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, undefined );
  test.is( 'a' in dstMap );

  test.case = 'second argument is array';
  var dstMap = {};
  _.accessor.constant( dstMap, [ 'a' ], 5 );
  var descriptor = Object.getOwnPropertyDescriptor( dstMap, 'a' );
  test.identical( descriptor.writable, false );
  test.identical( dstMap.a, 5 );

  if( !Config.debug )
  return;

  test.case = 'empty call';
  test.shouldThrowError( function()
  {
    _.accessor.constant( );
  });

  test.case = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.accessor.constant( 1, { a : 'a' } );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.accessor.constant( {}, 13 );
  });

}

//

function classDeclare( test )
{
  var context = this;

  /* */

  test.case = 'first classDeclare';

  function C1()
  {
    this.instances.push( this );
  }
  var Statics1 =
  {
    instances : [],
    f1 : [],
    f2 : [],
    f3 : [],
  }
  var Extend1 =
  {
    Statics : Statics1,
    f1 : [],
    f2 : [],
    f4 : [],
  }
  var classMade = _.classDeclare
  ({
    cls : C1,
    parent : null,
    extend : Extend1,
  });

  test.identical( C1, classMade );
  test.is( C1.instances === Statics1.instances );

  test1({ Class : C1 });
  testFields( Statics1.f3 );

  /* */

  test.case = 'classDeclare with parent';

  function C2()
  {
    C1.call( this );
  }
  var classMade = _.classDeclare
  ({
    cls : C2,
    parent : C1,
  });

  test.identical( C2, classMade );

  test1({ Class : C1, Statics : Statics1 });

  test.is( C1.instances === Statics1.instances );
  test.is( C2.instances === C1.instances );

  test1({ Class : C2, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.case = 'classDeclare with supplement';

  function Csupplement()
  {
    C1.call( this );
  }
  var Statics2 =
  {
    instances : [],
  }
  var classMade = _.classDeclare
  ({
    cls : Csupplement,
    parent : C1,
    supplement : { Statics : Statics2 },
  });

  test.identical( Csupplement,classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1({ Class : Csupplement, Class0 : C1, Statics : Statics1, ownStatics : 0 });

  /* */

  test.case = 'classDeclare with extend';

  function C3()
  {
    C1.call( this );
  }
  var Associates =
  {
  }
  var Statics2 =
  {
    instances : [],
    f1 : [],
    f4 : [],
  }
  var Extend2 =
  {
    Statics : Statics2,
    Associates : Associates,
    f2 : [],
    f3 : [],
  }
  var classMade = _.classDeclare
  ({
    cls : C3,
    parent : C1,
    extend : Extend2,
    allowingExtendStatics : 1,
  });

  test.identical( C3, classMade );

  test1({ Class : C1, Statics : Statics1 });
  test1
  ({
    Class : C3,
    Class0 : C1,
    Statics : Statics2,
    Extend : Extend2,
    keys : [ 'instances', 'f1', 'f4', 'f2', 'f3' ],
    vals : [ C3.instances, C3.f1, C3.f4, C1.f2, C1.f3 ],
  });

  testFields( Extend2.f3 );
  testFields2();

  if( !Config.debug )
  return;

  test.case = 'attempt to extend statics without order';

  test.shouldThrowError( function()
  {

    function C3()
    {
      C1.call( this );
    }
    var Associates =
    {
    }
    var Statics2 =
    {
      instances : [],
      f1 : [],
      f4 : [],
    }
    var Extend2 =
    {
      Statics : Statics2,
      Associates : Associates,
      f2 : [],
      f3 : [],
    }
    var classMade = _.classDeclare
    ({
      cls : C3,
      parent : C1,
      extend : Extend2,
    });

  });

  /* */

  function test1( o )
  {

    if( o.ownStatics === undefined )
    o.ownStatics = 1;

    if( !o.Statics )
    o.Statics = Statics1;

    if( !o.Extend )
    o.Extend = Extend1;

    if( !o.keys )
    o.keys = _.mapKeys( o.Statics );

    if( !o.vals )
    o.vals = _.mapVals( o.Statics );

    var C0proto = null;
    if( !o.Class0 )
    {
      o.Class0 = Function.prototype;
    }
    else
    {
      C0proto = o.Class0.prototype;
    }

    test.case = 'presence of valid prototype and constructor fields on class and prototype';

    test.identical( o.Class, o.Class.prototype.constructor );
    test.identical( Object.getPrototypeOf( o.Class ), o.Class0 );
    test.identical( Object.getPrototypeOf( o.Class.prototype ), C0proto );

    test.case = 'presence of valid static field on class and prototype';

    test.identical( o.Class.instances, o.Class.prototype.instances );

    test.case = 'getting property descriptor of static field from constructor';

    var cd = Object.getOwnPropertyDescriptor( o.Class, 'instances' );
    if( !o.ownStatics )
    {
      test.identical( cd, undefined );
    }
    else
    {
      test.identical( cd.configurable, true );
      test.identical( cd.enumerable, true );
      test.is( !!cd.get );
      test.is( !!cd.set );
    }

    var pd = Object.getOwnPropertyDescriptor( o.Class.prototype, 'instances' );

    if( !o.ownStatics )
    {
      test.identical( pd, undefined );
    }
    else
    {
      test.identical( pd.configurable, true );
      test.identical( pd.enumerable, false );
      test.is( !!pd.get );
      test.is( !!pd.set );
    }

    test.case = 'making the first instance';

    var c1a = new o.Class();

    test.case = 'presence of valid static field on all';

    if( o.Class !== C1 && !o.ownStatics )
    test.is( o.Class.instances === C1.instances );
    test.is( o.Class.instances === o.Class.prototype.instances );
    test.is( o.Class.instances === c1a.instances );
    test.is( o.Class.instances === o.Statics.instances );
    test.identical( o.Class.instances.length, o.Statics.instances.length );
    test.identical( o.Class.instances[ o.Statics.instances.length-1 ], c1a );

    test.case = 'presence of valid prototype and constructor fields on instance';

    test.identical( Object.getPrototypeOf( c1a ), o.Class.prototype );
    test.identical( c1a.constructor, o.Class );

    test.case = 'presence of valid Statics descriptor';

    test.is( o.Statics !== o.Class.prototype.Statics );
    test.is( o.Statics !== c1a.Statics );

    test.identical( _.mapKeys( c1a.Statics ), o.keys );
    test.identical( _.mapVals( c1a.Statics ), o.vals );
    test.identical( o.Class.Statics, undefined );

    if( !C0proto )
    {
      var r = _.entityIdentical( o.Class.prototype.Statics, o.Statics );
      test.identical( o.Class.prototype.Statics, o.Statics );
      test.identical( c1a.Statics, o.Statics );
    }

    test.case = 'presence of conflicting fields';

    test.is( o.Class.prototype.f1 === c1a.f1 );
    test.is( o.Class.prototype.f2 === c1a.f2 );
    test.is( o.Class.prototype.f3 === c1a.f3 );
    test.is( o.Class.prototype.f4 === c1a.f4 );

    test.case = 'making the second instance';

    var c1b = new o.Class();
    test.identical( o.Class.instances, o.Class.prototype.instances );
    test.identical( o.Class.instances, c1a.instances );
    test.identical( o.Class.instances.length, o.Statics.instances.length );
    test.identical( o.Class.instances[ o.Statics.instances.length-2 ], c1a );
    test.identical( o.Class.instances[ o.Statics.instances.length-1 ], c1b );

    test.case = 'setting static field with constructor';

    o.Class.instances = o.Class.instances.slice();
    // test.is( o.Class === C1 || o.Class.instances !== C1.instances );
    debugger;
    test.is( o.Class.instances === C1.instances || _.mapOwnKey( o.Class.prototype.Statics, 'instances' ) );
    debugger;
    test.is( o.Class.instances === o.Class.prototype.instances );
    test.is( o.Class.instances === c1a.instances );
    test.is( o.Class.instances === c1b.instances );
    test.is( o.Class.instances !== o.Statics.instances );
    o.Class.instances = Statics1.instances;

    test.case = 'setting static field with prototype';

    o.Class.prototype.instances = o.Class.prototype.instances.slice();
    // if( o.Class !== C1 && !o.ownStatics )
    // test.is( o.Class === C1 || o.Class.instances !== C1.instances );
    test.is( o.Class.instances === C1.instances || _.mapOwnKey( o.Class.prototype.Statics, 'instances' ) );
    test.is( o.Class.instances === o.Class.prototype.instances );
    test.is( o.Class.instances === c1a.instances );
    test.is( o.Class.instances === c1b.instances );
    test.is( o.Class.instances !== o.Statics.instances );
    o.Class.instances = Statics1.instances;

    test.case = 'setting static field with instance';

    c1a.instances = o.Class.instances.slice();
    // if( o.Class !== C1 && !o.ownStatics )
    // test.is( o.Class === C1 || o.Class.instances !== C1.instances );
    test.is( o.Class.instances === C1.instances || _.mapOwnKey( o.Class.prototype.Statics, 'instances' ) );
    test.is( o.Class.instances === o.Class.prototype.instances );
    test.is( o.Class.instances === c1a.instances );
    test.is( o.Class.instances === c1b.instances );
    test.is( o.Class.instances !== o.Statics.instances );
    o.Class.instances = Statics1.instances;

  }

  /* */

  function testFields( f3 )
  {

    test.case = 'presence of conflicting fields in the first class';

    test.is( Statics1.f1 === C1.f1 );
    test.is( Extend1.f1 === C1.prototype.f1 );

    test.is( Statics1.f2 === C1.f2 );
    test.is( Extend1.f2 === C1.prototype.f2 );

    test.is( f3 === C1.f3 );
    test.is( f3 === C1.prototype.f3 );

    test.is( Statics1.f4 === undefined );
    test.is( Statics1.f4 === C1.f4 );
    test.is( Extend1.f4 === C1.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C1,'f1' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f1' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f2' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f2' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C1,'f3' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f3' );
    test.is( d.enumerable === false );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C1,'f4' );
    test.is( !d );

    var d = Object.getOwnPropertyDescriptor( C1.prototype,'f4' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

  }

  /* */

  function testFields2()
  {

    test.case = 'presence of conflicting fields in the second class';

    test.is( Statics2.f1 === C3.f1 );
    test.is( Statics2.f1 === C3.prototype.f1 );

    test.is( Statics1.f2 === C3.f2 );
    test.is( Extend2.f2 === C3.prototype.f2 );

    test.is( Extend2.f3 === C3.f3 );
    test.is( Extend2.f3 === C3.prototype.f3 );

    test.is( Statics2.f4 === C3.f4 );
    test.is( Statics2.f4 === C3.prototype.f4 );

    var d = Object.getOwnPropertyDescriptor( C3,'f1' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f1' );
    test.is( d.enumerable === false );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3,'f2' );
    test.is( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f2' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( d.writable === true );
    test.is( !!d.value );

    var d = Object.getOwnPropertyDescriptor( C3,'f3' );
    test.is( !d );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f3' );
    test.is( !d );

    var d = Object.getOwnPropertyDescriptor( C3,'f4' );
    test.is( d.enumerable === true );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    var d = Object.getOwnPropertyDescriptor( C3.prototype,'f4' );
    test.is( d.enumerable === false );
    test.is( d.configurable === true );
    test.is( !!d.get );
    test.is( !!d.set );

    test.case = 'assigning static fields';

    C1.f1 = 1;
    C1.f2 = 2;
    C1.f3 = 3;
    C1.f4 = 4;

    C1.prototype.f1 = 11;
    C1.prototype.f2 = 12;
    C1.prototype.f3 = 13;
    C1.prototype.f4 = 14;

    C2.f1 = 21;
    C2.f2 = 22;
    C2.f3 = 23;
    C2.f4 = 24;

    C2.prototype.f1 = 31;
    C2.prototype.f2 = 32;
    C2.prototype.f3 = 33;
    C2.prototype.f4 = 34;

    test.identical( C1.f1,1 );
    test.identical( C1.f2,2 );
    debugger;
    test.identical( C1.f3,33 );
    debugger;
    test.identical( C1.f4,4 );

    test.identical( C1.prototype.f1,11 );
    test.identical( C1.prototype.f2,12 );
    test.identical( C1.prototype.f3,33 );
    test.identical( C1.prototype.f4,14 );

    test.identical( C2.f1,21 );
    test.identical( C2.f2,22 );
    test.identical( C2.f3,33 );
    test.identical( C2.f4,24 );

    test.identical( C2.prototype.f1,31 );
    test.identical( C2.prototype.f2,32 );
    test.identical( C2.prototype.f3,33 );
    test.identical( C2.prototype.f4,34 );

  }

}

// classDeclare.timeOut = 300000;

//

function staticsDeclare( test )
{

  /* - */

  test.open( 'basic' );
  test.case = 'setup';

  function BasicConstructor()
  {
    _.instanceInit( this );
  }

  var Associates =
  {
    f2 : _.define.common( 'Associates' ),
  }

  var Statics =
  {
    f1 : [ 'Statics' ],
    f2 : [ 'Statics' ],
    f3 : [ 'Statics' ],
  }

  var Extend =
  {
    f3 : [ 'Extend' ],
    Associates : Associates,
    Statics : Statics,
  }

  // Extend.constructor = BasicConstructor;

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extend,
  });

  var instance = new BasicConstructor();

  test.case = 'f1';

  test.is( BasicConstructor.f1 === BasicConstructor.prototype.f1 );
  test.is( BasicConstructor.prototype.f1 === Statics.f1 );
  test.is( BasicConstructor.f1 === Statics.f1 );
  test.is( BasicConstructor.prototype.Statics.f1 === Statics.f1 );
  test.is( instance.f1 === Statics.f1 );

  test.case = 'set prototype.f1';

  var newF1 = [ 'newF1' ];
  BasicConstructor.prototype.f1 = newF1;
  var instance2 = new BasicConstructor();

  test.is( BasicConstructor.f1 === BasicConstructor.prototype.f1 );
  test.is( BasicConstructor.prototype.f1 === newF1 );
  test.is( BasicConstructor.f1 === newF1 );
  test.is( instance.f1 === newF1 );
  test.is( instance2.f1 === newF1 );

  test.case = 'set class.f1';

  var newF1 = [ 'newF1' ];
  BasicConstructor.f1 = newF1;
  var instance2 = new BasicConstructor();

  test.is( BasicConstructor.f1 === BasicConstructor.prototype.f1 );
  test.is( BasicConstructor.prototype.f1 === newF1 );
  test.is( BasicConstructor.f1 === newF1 );
  test.is( instance.f1 === newF1 );
  test.is( instance2.f1 === newF1 );

  test.case = 'f2';

  test.is( BasicConstructor.prototype.f2 === undefined );
  test.is( BasicConstructor.f2 === Statics.f2 );
  test.is( BasicConstructor.prototype.Statics.f2 === Statics.f2 );
  test.is( BasicConstructor.prototype.Associates.f2 === Associates.f2 );
  test.is( instance.f2 === Associates.f2.value );

  test.case = 'set prototype.f2';

  var newF2 = [ 'newF2' ];
  BasicConstructor.prototype.f2 = newF2;
  var instance2 = new BasicConstructor();

  test.is( BasicConstructor.f2 !== BasicConstructor.prototype.f2 );
  test.is( BasicConstructor.prototype.f2 === newF2 );
  test.is( BasicConstructor.f2 === Statics.f2 );
  test.is( instance.f2 === Associates.f2.value );
  test.is( instance2.f2 === Associates.f2.value );

  test.case = 'set constructor.f2';

  var newF2 = [ 'newF2' ];
  BasicConstructor.f2 = newF2;
  var instance2 = new BasicConstructor();

  test.is( BasicConstructor.f2 !== BasicConstructor.prototype.f2 );
  test.is( BasicConstructor.f2 === newF2 );
  test.is( instance.f2 === Associates.f2.value );
  test.is( instance2.f2 === Associates.f2.value );

  test.close( 'basic' );

  /* - */

}

// staticsDeclare.timeOut = 300000;

//

function staticsOverwrite( test )
{

  /* - */

  test.open( 'basic' );
  test.case = 'setup';

  function BasicConstructor()
  {
    _.instanceInit( this );
    this.instances.push( this );
  }

  var Statics =
  {
    instances : [],
  }

  var Extend =
  {
    Statics : Statics,
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extend,
  });

  var instance0 = new BasicConstructor();

  /* */

  function DerivedConstructor1()
  {
    _.instanceInit( this );
    this.instances.push( this );
  }

  var Statics =
  {
    instances : [],
  }

  var Extend =
  {
    Statics : Statics,
  }

  _.classDeclare
  ({
    parent : BasicConstructor,
    cls : DerivedConstructor1,
    extend : Extend,
  });

  var instance1 = new DerivedConstructor1();

  /* */

  function DerivedConstructor2()
  {
    _.instanceInit( this );
    this.instances.push( this );
  }

  var Statics =
  {
  }

  var Extend =
  {
    Statics : Statics,
  }

  // Extend.constructor = DerivedConstructor2;

  _.classDeclare
  ({
    parent : BasicConstructor,
    cls : DerivedConstructor2,
    extend : Extend,
  });

  var instance2 = new DerivedConstructor2();

  /* */

  test.case = 'f1';

  test.is( BasicConstructor.instances === BasicConstructor.prototype.instances );
  test.is( BasicConstructor.instances === DerivedConstructor2.instances );
  test.is( BasicConstructor.instances === DerivedConstructor2.prototype.instances );
  test.is( BasicConstructor.instances === instance0.instances );
  test.is( BasicConstructor.instances === instance2.instances );

  test.is( BasicConstructor.instances !== DerivedConstructor1.instances );
  test.is( BasicConstructor.instances !== instance1.instances );

  test.is( DerivedConstructor1.instances === DerivedConstructor1.prototype.instances );
  test.is( DerivedConstructor1.instances === instance1.instances );

  test.identical( instance0.instances.length, 2 );
  test.identical( instance1.instances.length, 1 );
  test.identical( instance2.instances.length, 2 );

  test.close( 'basic' );

  /* - */

}

//

function mixinStaticsWithDefinition( test )
{

  /* - */

  test.will = 'setup Mixin';

  function Mixin()
  {
  }

  Mixin.shortName = 'Mix';

  var wrap = [ 0 ];
  var array = [ wrap ];
  var map = { 0 : wrap };
  var Statics =
  {
    array : _.define.contained({ value : array, readOnly : 1, shallowCloning : 1 }),
    map : _.define.contained({ value : map, readOnly : 1, shallowCloning : 1 }),
    bool : _.define.contained({ value : 0 }),
    wrap : _.define.contained({ value : wrap }),
  }

  var Extend =
  {
    Statics : Statics,
  }

  _.classDeclare
  ({
    cls : Mixin,
    extend : Extend,
    withMixin : 1,
  });

  test.is( _.routineIs( Mixin.mixin ) );
  test.identical( Mixin.__mixin__.mixin, Mixin.mixin );
  test.identical( Mixin.__mixin__.name, 'Mixin' );
  test.identical( Mixin.__mixin__.shortName, 'Mix' );
  // test.identical( Mixin.__mixin__.prototype, undefined ); /* xxx */
  test.identical( Mixin.__mixin__.extend.constructor, undefined );

  /* */

  test.will = 'setup Class1';

  function Class1()
  {
    _.instanceInit( this );
  }

  _.classDeclare
  ({
    cls : Class1,
  });

  test.is( Class1.prototype.constructor === Class1 );

  Mixin.mixin( Class1 );

  var instance1 = new Class1();

  /* */

  test.will = 'setup Class2';

  function Class2()
  {
    _.instanceInit( this );
  }

  _.classDeclare
  ({
    cls : Class2,
  });

  Mixin.mixin( Class2 );

  var instance2 = new Class2();

  /* */

  test.case = 'clean';

  test.is( Mixin.wrapGet === undefined );
  test.is( Mixin._wrapGet === undefined );
  test.is( Mixin.prototype.wrapGet === undefined );
  test.is( Mixin.prototype._wrapGet === undefined );

  test.is( Class1.wrapGet === undefined );
  test.is( Class1._wrapGet === undefined );
  test.is( Class1.prototype.wrapGet === undefined );
  test.is( Class1.prototype._wrapGet === undefined );

  test.is( Class2.wrapGet === undefined );
  test.is( Class2._wrapGet === undefined );
  test.is( Class2.prototype.wrapGet === undefined );
  test.is( Class2.prototype._wrapGet === undefined );

  /* */

  test.case = 'wrap';

  test.is( wrap === Mixin.wrap );
  test.is( wrap === Mixin.prototype.Statics.wrap.value );
  test.is( wrap === Mixin.prototype.wrap );
  test.is( wrap === Class1.prototype.Statics.wrap.value );
  test.is( wrap === Class1.prototype.wrap );
  test.is( wrap === Class1.wrap );
  test.is( wrap === instance1.wrap );

  test.is( wrap === Class2.prototype.Statics.wrap.value );
  test.is( wrap === Class2.prototype.wrap );
  test.is( wrap === Class2.wrap );
  test.is( wrap === instance2.wrap );

  test.case = 'set Mixin.wrap';

  var wrap2 = Mixin.wrap = [ 'wrap2' ];

  test.is( wrap2 === Mixin.wrap );
  test.is( wrap == Mixin.prototype.Statics.wrap.value );
  test.is( wrap2 === Mixin.prototype.wrap );
  test.is( wrap === Class1.prototype.Statics.wrap.value );
  test.is( wrap === Class1.prototype.wrap );
  test.is( wrap === Class1.wrap );
  test.is( wrap === instance1.wrap );
  test.is( wrap == Class2.prototype.Statics.wrap.value );
  test.is( wrap == Class2.prototype.wrap );
  test.is( wrap == Class2.wrap );
  test.is( wrap == instance2.wrap );

  test.case = 'set Class1.wrap';

  var wrap3 = Class1.wrap = [ 'wrap3' ];

  test.is( wrap2 === Mixin.wrap );
  test.is( wrap === Mixin.prototype.Statics.wrap.value );
  test.is( wrap2 === Mixin.prototype.wrap );
  test.is( wrap === Class1.prototype.Statics.wrap.value );
  test.is( wrap3 === Class1.prototype.wrap );
  test.is( wrap3 === Class1.wrap );
  test.is( wrap3 === instance1.wrap );
  test.is( wrap === Class2.prototype.Statics.wrap.value );
  test.is( wrap === Class2.prototype.wrap );
  test.is( wrap === Class2.wrap );
  test.is( wrap === instance2.wrap );

  /* */

  test.case = 'array';

  test.is( array !== Mixin.array );
  test.is( array === Mixin.prototype.Statics.array.value );
  test.is( Mixin.array === Mixin.prototype.array );

  test.is( array === Class1.prototype.Statics.array.value );
  test.is( Class1.array === Class1.prototype.array );
  test.is( array !== Class1.array );
  test.is( Mixin.array !== Class1.array );
  test.is( Class1.array === instance1.array );

  test.is( array === Class2.prototype.Statics.array.value );
  test.is( Class2.array === Class2.prototype.array );
  test.is( array !== Class2.array );
  test.is( Mixin.array !== Class2.array );
  test.is( Class2.array === instance2.array );

  test.case = 'wrap in array';

  test.is( array[ 0 ] === Mixin.array[ 0 ] );
  test.is( array[ 0 ] === Mixin.prototype.Statics.array.value[ 0 ] );
  test.is( array[ 0 ] === Mixin.prototype.array[ 0 ] );
  test.is( array[ 0 ] === Class1.prototype.Statics.array.value[ 0 ] );
  test.is( array[ 0 ] === Class1.prototype.array[ 0 ] );
  test.is( array[ 0 ] === Class1.array[ 0 ] );
  test.is( array[ 0 ] === instance1.array[ 0 ] );
  test.is( array[ 0 ] === Class2.prototype.Statics.array.value[ 0 ] );
  test.is( array[ 0 ] === Class2.prototype.array[ 0 ] );
  test.is( array[ 0 ] === Class2.array[ 0 ] );
  test.is( array[ 0 ] === instance2.array[ 0 ] );

  /* */

  test.case = 'map';

  test.is( map !== Mixin.map );
  test.is( map === Mixin.prototype.Statics.map.value );
  test.is( Mixin.map === Mixin.prototype.map );

  test.is( map === Class1.prototype.Statics.map.value );
  test.is( Class1.map === Class1.prototype.map );
  test.is( map !== Class1.map );
  test.is( Mixin.map !== Class1.map );
  test.is( Class1.map === instance1.map );

  test.is( map === Class2.prototype.Statics.map.value );
  test.is( Class2.map === Class2.prototype.map );
  test.is( map !== Class2.map );
  test.is( Mixin.map !== Class2.map );
  test.is( Class2.map === instance2.map );

  test.case = 'wrap in map';

  test.is( map[ 0 ] === Mixin.map[ 0 ] );
  test.is( map[ 0 ] === Mixin.prototype.Statics.map.value[ 0 ] );
  test.is( map[ 0 ] === Mixin.prototype.map[ 0 ] );
  test.is( map[ 0 ] === Class1.prototype.Statics.map.value[ 0 ] );
  test.is( map[ 0 ] === Class1.prototype.map[ 0 ] );
  test.is( map[ 0 ] === Class1.map[ 0 ] );
  test.is( map[ 0 ] === instance1.map[ 0 ] );
  test.is( map[ 0 ] === Class2.prototype.Statics.map.value[ 0 ] );
  test.is( map[ 0 ] === Class2.prototype.map[ 0 ] );
  test.is( map[ 0 ] === Class2.map[ 0 ] );
  test.is( map[ 0 ] === instance2.map[ 0 ] );

  /* - */

  if( !Config.debug )
  return;

  test.will = 'constructor in extend';

  test.shouldThrowError( function()
  {

    function Mixin()
    {
    }

    var Extend =
    {
    }

    Extend.constructor = Mixin;

    _.classDeclare
    ({
      cls : Mixin,
      extend : Extend,
      withMixin : 1,
    });

  });

}

//

function customFieldsGroups( test )
{

  /* - */

  test.case = 'setup';

  function BasicConstructor(){}

  var Extend =
  {
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    extend : Extend,
  });

  /* */

  function DerivedConstructor1(){}

  var Groups =
  {
    Names : 'Names',
  }

  var Names1 =
  {
    a : [ 1 ],
    b : [ 1 ],
  }

  var Extend =
  {
    Names : Names1,
    Groups : Groups,
  }

  _.classDeclare
  ({
    parent : BasicConstructor,
    cls : DerivedConstructor1,
    extend : Extend,
  });

  /* */

  function DerivedConstructor2(){}

  var Names2 =
  {
    b : [ 2 ],
    c : [ 2 ],
  }

  var Extend =
  {
    Names : Names2,
  }

  _.classDeclare
  ({
    parent : DerivedConstructor1,
    cls : DerivedConstructor2,
    extend : Extend,
  });

  /* */

  function DerivedConstructor3(){}

  _.classDeclare
  ({
    parent : DerivedConstructor2,
    cls : DerivedConstructor3,
  });

  /* */

  var instance0 = new BasicConstructor();
  var instance1 = new DerivedConstructor1();
  var instance2 = new DerivedConstructor2();
  var instance3 = new DerivedConstructor3();

  test.will = 'check base class';

  test.is( !!instance0.Groups );
  // test.is( !!BasicConstructor.Groups ); /* xxx */
  test.is( !!BasicConstructor.prototype.Groups );
  // test.is( instance0.Groups === BasicConstructor.Groups );
  test.is( instance0.Groups === BasicConstructor.prototype.Groups );

  test.will = 'check dervied class1';

  test.is( !!instance1.Groups );
  // test.is( !!DerivedConstructor1.Groups );
  test.is( !!DerivedConstructor1.prototype.Groups );
  // test.is( instance1.Groups === DerivedConstructor1.Groups );
  test.is( instance1.Groups === DerivedConstructor1.prototype.Groups );
  test.is( instance1.Groups !== instance0.Groups );
  // test.is( DerivedConstructor1.Groups !== instance0.Groups );
  test.is( DerivedConstructor1.prototype.Groups !== instance0.Groups );
  test.is( instance1.Names.a === Names1.a );
  test.is( instance1.Names.b === Names1.b );
  test.is( instance1.Names.c === Names1.c );

  test.will = 'check dervied class2';

  test.is( !!instance2.Groups );
  // test.is( !!DerivedConstructor2.Groups );
  test.is( !!DerivedConstructor2.prototype.Groups );
  // test.is( instance2.Groups === DerivedConstructor2.Groups );
  test.is( instance2.Groups === DerivedConstructor2.prototype.Groups );
  test.is( instance2.Groups !== instance0.Groups );
  // test.is( DerivedConstructor2.Groups !== instance0.Groups );
  test.is( DerivedConstructor2.prototype.Groups !== instance0.Groups );
  test.is( instance2.Groups !== instance1.Groups );
  // test.is( DerivedConstructor2.Groups !== instance1.Groups );
  test.is( DerivedConstructor2.prototype.Groups !== instance1.Groups );
  test.is( instance2.Names.a === Names1.a );
  test.is( instance2.Names.b === Names2.b );
  test.is( instance2.Names.c === Names2.c );

  test.will = 'check dervied class3';

  test.is( !!instance3.Groups );
  // test.is( !!DerivedConstructor3.Groups );
  test.is( !!DerivedConstructor3.prototype.Groups );
  // test.is( instance3.Groups === DerivedConstructor3.Groups );
  test.is( instance3.Groups === DerivedConstructor3.prototype.Groups );
  test.is( instance3.Groups !== instance0.Groups );
  // test.is( DerivedConstructor3.Groups !== instance0.Groups );
  test.is( DerivedConstructor3.prototype.Groups !== instance0.Groups );
  test.is( instance3.Groups !== instance1.Groups );
  // test.is( DerivedConstructor3.Groups !== instance1.Groups );
  test.is( DerivedConstructor3.prototype.Groups !== instance1.Groups );
  test.is( instance3.Names.a === Names1.a );
  test.is( instance3.Names.b === Names2.b );
  test.is( instance3.Names.c === Names2.c );

}

//

function staticFieldsPreserving( test )
{

  function BasicConstructor(){}

  function init()
  {
  }

  function basicSet()
  {
    console.log( 'basicSet' )
  }

  var Extend =
  {
    init : init,
    Statics :
    {
      set : basicSet
    }
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    parent : null,
    extend : Extend,
  });

  /* */

  var DerivedConstructor1 = function DerivedConstructor1()
  {
    return _.instanceConstructor( DerivedConstructor1, this, arguments );
  }

  function derivedSet()
  {
    console.log( 'derivedSet' )
  }

  var Extend =
  {
    Statics :
    {
      set : derivedSet
    }
  }

  _.classDeclare
  ({
    parent : BasicConstructor,
    cls : DerivedConstructor1,
    extend : Extend,
  });

  /* problem */

  test.identical( BasicConstructor.prototype.set, basicSet );
  test.identical( DerivedConstructor1.prototype.set, derivedSet );

  debugger;
  var instance = DerivedConstructor1();
  debugger;

  test.identical( BasicConstructor.prototype.set, basicSet );
  test.identical( DerivedConstructor1.prototype.set, derivedSet );

  /* works fine with new */

  // var instance = new DerivedConstructor1();
  // test.identical( BasicConstructor.prototype.set, basicSet );

}

//

function instanceConstructor( test )
{

  function BasicConstructor()
  {
    return _.instanceConstructor( BasicConstructor, this, arguments );
  }

  function init()
  {
    counter += 1;
  }

  var counter = 0;
  var Extend =
  {
    init,
  }

  _.classDeclare
  ({
    cls : BasicConstructor,
    parent : null,
    extend : Extend,
  });

  // /* */
  //
  // test.case = 'no new';
  //
  // counter = 0;
  // var instance = BasicConstructor();
  // test.is( instance instanceof BasicConstructor );
  // test.is( instance.constructor === BasicConstructor );
  // test.is( instance.init === init );
  // test.identical( counter, 1 );
  //
  // var instance2 = BasicConstructor( instance );
  // test.is( instance2 instanceof BasicConstructor );
  // test.is( instance2.constructor === BasicConstructor );
  // test.is( instance2.init === init );
  // test.is( instance === instance2 );
  // test.identical( counter, 1 );
  //
  // /* */
  //
  // test.case = 'with new';
  //
  // counter = 0;
  // var instance = new BasicConstructor();
  // test.is( instance instanceof BasicConstructor );
  // test.is( instance.constructor === BasicConstructor );
  // test.is( instance.init === init );
  // test.identical( counter, 1 );
  //
  // var instance2 = new BasicConstructor( instance );
  // test.is( instance2 instanceof BasicConstructor );
  // test.is( instance2.constructor === BasicConstructor );
  // test.is( instance2.init === init );
  // test.is( instance !== instance2 );
  // test.identical( counter, 2 );

  /* */

  test.case = 'array';

  counter = 0;
  var instances = BasicConstructor([ 1,null,3 ]);
  test.identical( instances.length, 2 );
  test.is( instances[ 0 ] instanceof BasicConstructor );
  test.is( instances[ 0 ].constructor === BasicConstructor );
  test.is( instances[ 0 ].init === init );
  test.is( instances[ 1 ] instanceof BasicConstructor );
  test.is( instances[ 1 ].constructor === BasicConstructor );
  test.is( instances[ 1 ].init === init );
  test.identical( counter, 2 );

  var instances2 = BasicConstructor( instances );
  test.identical( instances2.length, 2 );
  test.is( instances2[ 0 ] instanceof BasicConstructor );
  test.is( instances2[ 0 ].constructor === BasicConstructor );
  test.is( instances2[ 0 ].init === init );
  test.is( instances2[ 1 ] instanceof BasicConstructor );
  test.is( instances2[ 1 ].constructor === BasicConstructor );
  test.is( instances2[ 1 ].init === init );
  test.is( instances2[ 0 ] === instances[ 0 ] );
  test.is( instances2[ 1 ] === instances[ 1 ] );
  test.identical( counter, 2 );

}

// --
// declare
// --

var Self =
{

  name : 'Tools/base/l3/proto',
  silencing : 1,
  // verbosity : 7,
  // routineTimeOut : 300000,

  tests :
  {

    instanceIs,
    instanceIsStandard,
    prototypeIs,
    constructorIs,
    prototypeIsStandard,

    accessor,
    accessorIsClean,

    accessorForbid,
    accessorReadOnly,
    forbids,

    constant,

    classDeclare,
    staticsDeclare,
    staticsOverwrite,
    mixinStaticsWithDefinition,

    customFieldsGroups,

    staticFieldsPreserving,
    instanceConstructor,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
