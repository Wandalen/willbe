( function  _FieldsStack_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wTesting' );
  _.include( 'wCopyable' );

  require( '../l7_mixin/FieldsStack.s' );

}

//

var _ = _global_.wTools.withArray.Float32;

function fieldPush( test )
{

  test.description = 'Compare two maps'; //

  var sample = this.declareMixinClass();
  var expected = sample.clone();
  test.is( sample.equivalentWith( expected ) );

  var newFields =
  {
    field0 : 1,
  }

  sample.fieldPush( newFields );
  _.mapExtend( sample.Associates, newFields );
  expected.fieldPush( newFields );
  _.mapExtend( expected.Associates, newFields );

  test.is( sample.equivalentWith( expected ) );

  sample.fieldPush( 'field0', 0 );
  test.is( !sample.equivalentWith( expected ) );

  test.description = 'Add fields map'; //

  var sample = this.declareMixinClass();
  var newFields =
  {
    field1 : null,
    field2 : null,
  }

  sample.fieldPush( newFields );

  var expected1 = null;
  test.identical( sample.field1, expected1 );

  var expected2 = null;
  test.identical( sample.field2, expected2 );

  var expected3 = undefined;
  test.identical( sample.field3, expected3 );

  test.description = 'Set fields map'; //

  var sample = this.declareMixinClass();
  var newFields =
  {
    field1 : 'first value',
    field2 : 'second value',
  }

  sample.fieldPush( newFields );

  var expected1 = 'first value';
  test.identical( sample.field1, expected1 );

  var expected2 = 'second value';
  test.identical( sample.field2, expected2 );

  test.description = 'Change fields map values'; //

  var sample = this.declareMixinClass();
  var newFields =
  {
    field1 : 'New first value',
    field2 : 'New second value',
  }

  sample.fieldPush( newFields );

  var expected1 = 'New first value';
  test.identical( sample.field1, expected1 );

  var expected2 = 'New second value';
  test.identical( sample.field2, expected2 );

  test.description = 'Add single field'; //

  var sample = this.declareMixinClass();
  var field3 = 'third field';

  sample.fieldPush( 'field3', field3 );

  var expected = 'third field';
  test.identical( sample.field3, expected );

  test.description = 'Change single field'; //

  var sample = this.declareMixinClass();
  var field3 = 'New third field';

  sample.fieldPush( 'field3', field3 );

  var expected = 'New third field';
  test.identical( sample.field3, expected );

  test.description = 'Change field to number'; //

  var sample = this.declareMixinClass();
  var field3 = 3;

  sample.fieldPush( 'field3', field3 );

  var expected = 3;
  test.identical( sample.field3, expected );

  test.description = 'Change field to array'; //

  var sample = this.declareMixinClass();
  var field3 = [ 0, 1, 2 ];

  sample.fieldPush( 'field3', field3 );

  var expected = [ 0, 1, 2 ];
  test.identical( sample.field3, expected );

  test.description = 'Change field to map'; //

  var sample = this.declareMixinClass();
  var field3 = { 'one' : 1, 'two' : 2, 'three' : 3, };

  sample.fieldPush( 'field3', field3 );

  var expected = { 'one' : 1, 'two' : 2, 'three' : 3, };
  test.identical( sample.field3, expected );

  test.description = 'Change field to null'; //

  var sample = this.declareMixinClass();
  var field3 = null;

  sample.fieldPush( 'field3', field3 );

  var expected = null;
  test.identical( sample.field3, expected );

  test.description = 'Change field to NaN'; //

  var sample = this.declareMixinClass();
  var field3 = NaN;

  sample.fieldPush( 'field3', field3 );

  var expected = NaN;
  test.identical( sample.field3, expected );

  /* */

  if( !Config.debug )
  return;

  var sample = this.declareMixinClass();
  test.shouldThrowErrorSync( () => sample.fieldPush( ));

  var newFields =
  {
    field1 : null,
    field2 : null,
  }
  test.shouldThrowErrorSync( () => sample.fieldPush( newFields, newFields ));
  test.shouldThrowErrorSync( () => sample.fieldPush( null ));
  test.shouldThrowErrorSync( () => sample.fieldPush( NaN ));
  test.shouldThrowErrorSync( () => sample.fieldPush( 3 ));
  test.shouldThrowErrorSync( () => sample.fieldPush( 'Fields' ));
  test.shouldThrowErrorSync( () => sample.fieldPush( null, 'Fields'));
  test.shouldThrowErrorSync( () => sample.fieldPush( NaN, 'Fields'));
  test.shouldThrowErrorSync( () => sample.fieldPush( 3, 'Fields'));
  test.shouldThrowErrorSync( () => sample.fieldPush( 'Fields', 'Value1', 'Value2' ));

}

//

function fieldPop( test )
{

  test.description = 'Add fields map and reset it'; //

  var sample = this.declareMixinClass();
  var newFields =
  {
    field1 : null,
    field2 : null,
  }

  sample.fieldPush( newFields );
  sample.fieldPop( newFields );

  var expected1 = undefined;
  test.identical( sample.field1, expected1 );

  var expected2 = undefined;
  test.identical( sample.field2, expected2 );

  var expected3 = undefined;
  test.identical( sample.field3, expected3 );

  test.description = 'Add fields map and reset just one value'; //

  var sample = this.declareMixinClass();
  var newFields =
  {
    field1 : 'first value',
    field2 : 'second value',
  }

  sample.fieldPush( newFields );

  var expected1 = 'first value';
  test.identical( sample.field1, expected1 );

  var expected2 = 'second value';
  test.identical( sample.field2, expected2 );

  sample.fieldPop( 'field1', 'first value' );

  var expected1 = undefined;
  test.identical( sample.field1, expected1 );

  var expected2 = 'second value';
  test.identical( sample.field2, expected2 )

  test.description = 'Set fields, change them and reset them twice'; //

  var sample = this.declareMixinClass();
  var newFields =
  {
    field1 : null,
    field2 : null,
  }
  sample.fieldPush( newFields );

  var expected1 = null;
  test.identical( sample.field1, expected1 );
  var expected2 = null;
  test.identical( sample.field2, expected2 );

  var newFields =
  {
    field1 : 'first value',
    field2 : 'second value',
  }
  sample.fieldPush( newFields );

  var expected1 = 'first value';
  test.identical( sample.field1, expected1 );
  var expected2 = 'second value';
  test.identical( sample.field2, expected2 );

  var newFields =
  {
    field1 : 1,
    field2 : 2,
  }
  sample.fieldPush( newFields );

  var expected1 = 1;
  test.identical( sample.field1, expected1 );
  var expected2 = 2;
  test.identical( sample.field2, expected2 );  // Fields changed twice

  sample.fieldPop( 'field1', 1 );           // Reset first value

  var expected1 = 'first value';
  test.identical( sample.field1, expected1 );
  var expected2 = 2;
  test.identical( sample.field2, expected2 );

  var fields =
  {
    field1 : 'first value',
    field2 : 2,
  }
  sample.fieldPop( fields );                  // Reset both values

  var expected1 = null;
  test.identical( sample.field1, expected1 );
  var expected2 = 'second value';
  test.identical( sample.field2, expected2 );

  sample.fieldPop( 'field2', 'second value' ); // Reset second value

  var expected1 = null;
  test.identical( sample.field1, expected1 );
  var expected2 = null;
  test.identical( sample.field2, expected2 );

  test.description = 'Reset field just by name'; //

  var sample = this.declareMixinClass();
  var newFields =
  {
    field1 : null,
    field2 : null,
  }
  sample.fieldPush( newFields );
  sample.fieldPush( 'field1', 'one' );

  var expected1 = 'one';
  test.identical( sample.field1, expected1 );
  var expected2 = null;
  test.identical( sample.field2, expected2 );

  sample.fieldPop( 'field1' );

  var expected1 = null;
  test.identical( sample.field1, expected1 );
  var expected2 = null;
  test.identical( sample.field2, expected2 );

  /* */

  if( !Config.debug )
  return;

  var sample = this.declareMixinClass();
  test.shouldThrowErrorSync( () => sample.fieldPop( ));

  var newFields =
  {
    field1 : null,
    field2 : null,
  }
  test.shouldThrowErrorSync( () => sample.fieldPop( newFields, newFields ));
  test.shouldThrowErrorSync( () => sample.fieldPop( null ));
  test.shouldThrowErrorSync( () => sample.fieldPop( NaN ));
  test.shouldThrowErrorSync( () => sample.fieldPop( 3 ));
  test.shouldThrowErrorSync( () => sample.fieldPop( 'Fields' ));
  test.shouldThrowErrorSync( () => sample.fieldPop( null, 'Fields'));
  test.shouldThrowErrorSync( () => sample.fieldPop( NaN, 'Fields'));
  test.shouldThrowErrorSync( () => sample.fieldPop( 3, 'Fields'));
  test.shouldThrowErrorSync( () => sample.fieldPop( 'Fields', 'Value1', 'Value2' ));

  var newFields =
  {
    field1 : null,
    field2 : null,
  }
  sample.fieldPush( newFields );
  test.shouldThrowErrorSync( () => sample.fieldPop( 'Field1', 'Value1' ));
  test.shouldThrowErrorSync( () => sample.fieldPop( 'Field1', 1 ));
  test.shouldThrowErrorSync( () => sample.fieldPop( 'Field2', 'Value2' ));
  test.shouldThrowErrorSync( () => sample.fieldPop( 'Field2', 2 ));
  test.shouldThrowErrorSync( () => sample.fieldPop( 'Field3' ));

}

//

function declareMixinClass()
{
  let _ = _global_.wTools.withArray.Float32;

  // Declare class
  let o =
  {
    storageFileName : null,
    storageLoaded : null,
    storageToSave : null,
    fields : null,
    fileProvider : null,
  }

  let Associates =
  {
    storageFileName : o.storageFileName,
    fileProvider : _.define.own( o.fileProvider ),
  }

  function SampleClass( o )
  {
    return _.workpiece.construct( SampleClass, this, arguments );
  }
  function init( o )
  {
    _.workpiece.initFields( this );
  }
  let Extend =
  {
    init,
    storageLoaded : o.storageLoaded,
    storageToSave : o.storageToSave,
    Composes : o.fields,
    Associates,
  }
  _.classDeclare
  ({
    cls : SampleClass,
    extend : Extend,
  });

  // Mixin
  _.Copyable.mixin( SampleClass );
  _.FieldsStack.mixin( SampleClass );

  let sample = new SampleClass();
  return sample;
}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.Mixin',
  silencing : 1,
  enabled : 1,
  // verbosity : 7,
  // debug : 1,
  // routine: 'frustumClosestPoint',

  context :
  {
    declareMixinClass,
  },

  tests :
  {

    fieldPush,
    fieldPop,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

} )( );
