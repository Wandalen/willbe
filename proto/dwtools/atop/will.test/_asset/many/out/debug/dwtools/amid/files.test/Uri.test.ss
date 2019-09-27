( function _FileProvider_Url_test_ss_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './aFileProvider.test.s' );

}

//

var _ = _global_.wTools;
var Parent = wTests[ 'Tools.mid.files.fileProvider.Abstract' ];
var HardDrive = _.FileProvider.HardDrive();

_.assert( !!Parent );

//

function onSuiteBegin( test )
{
  var self = this;
  self.suitePath = _.path.dirTempOpen( _.path.join( __dirname, '../..'  ), 'Provider/Url' );
}

//

function onSuiteEnd()
{
  var self = this;
  _.assert( _.strEnds( self.suitePath, 'Provider/Url' ) );
  _.path.pathDirTempClose( this.suitePath );
}

//

function fileRead( test )
{
  var con = new _.Consequence().take( null )

  .finally( () =>
  {
    test.case = 'unavailbe path';

    var o = { filePath : this.testFile + 'xxx', sync : 0 };
    var got = this.provider.fileRead( o );
    return test.shouldThrowErrorOfAnyKind( got );
  })

  .finally( () =>
  {
    test.case = 'get a avaible path';

    var o = { filePath : this.testFile, sync : 0 };
    return this.provider.fileRead( o )
    .finally( ( err, got ) =>
    {
      test.is( _.strHas( got, '# wTools' ) )
    })
  })

  .finally( () =>
  {
    test.case = 'get a avaible path';

    var url = 'https://www.npmjs.com/search?q=wTools'
    var o = { filePath : url, sync : 0 };
    return this.provider.fileRead( o )
    .finally( ( err, got ) =>
    {
      test.is( _.strBegins( got, '<!DOCTYPE' ) )
    })
  })

  return con;
}

//

function fileCopyToHardDrive( test )
{
  var filePath = _.path.join( this.suitePath, test.name, _.path.name( this.testFile ) );
  var con = new _.Consequence().take( null )

  //

  .finally( () =>
  {
    test.case = 'unavailable url';
    var o =
    {
      url : 'abc',
      filePath,
    }
    var got = this.provider.fileCopyToHardDrive( o );
    return test.shouldThrowErrorOfAnyKind( got );
  })

  //

  .finally( () =>
  {
    test.case = 'save file from the url to a hard drive';
    var o =
    {
      url : this.testFile,
      filePath,
    }
    return this.provider.fileCopyToHardDrive( o )
    .finally( ( err, got ) =>
    {
      var file = HardDrive.fileRead( got );

      o =
      {
        filePath : this.testFile,
        sync : 0
      }

      return this.provider.fileRead( o )
      .finally( ( err, got ) => test.identical( got, file ) )
    })
  })

  return con;
}


// --
// declare
// --

var Proto =
{

  name : 'Tools.mid.files.fileProvider.UrlServer',
  silencing : 1,
  abstract : 0,
  enabled : 0, // !!! experimental

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    provider : _.FileProvider.Http(),
    testFile : 'https://raw.githubusercontent.com/Wandalen/wTools/master/README.md',
  },

  tests :
  {
    fileRead,
    fileCopyToHardDrive
  },

}

//

// debugger;
// if( typeof module !== 'undefined' )
// var Self = new wTestSuite( Parent ).extendBy( Proto );

var Self = new wTestSuite( Proto ).inherit( Parent );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

// if( 0 )
// {
//   Self = new wTestSuite( Parent ).extendBy( Self );
//   wTester.test( Self.name );
// }

})( );
