( function _FilesFind_Extract_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  require( './aTemplateFileWriter.test.s' );
}

//

var _ = _global_.wTools;
var Parent = wTests[ 'Tools/mid/l5.test/TemplateFileWriter/Abstract' ];

_.assert( !!Parent );

//

function onSuiteBegin( test )
{
  let context = this;
  Parent.onSuiteBegin.apply( this, arguments );
  context.provider = _.FileProvider.Extract({ usingExtraStat : 1, protocol : 'current' });
  let path = context.provider.path;
  context.suitePath = path.dirTempOpen( 'suite-TemplateFileWriter' );
  context.suitePath = context.provider.pathResolveLinkFull
  ({
    filePath : context.suitePath,
    resolvingSoftLink : 1,
    resolvingTextLink : 1,
  });
}

//

function onSuiteEnd()
{
  let context = this;
  let path = this.provider.path;
  return Parent.onSuiteEnd.apply( this, arguments );
}

//--
// tests
//--



// --
// declare
// --

var Proto =
{

  name : 'Tools.mid.l5.test.TemplateFileWriter.Extract',
  silencing : 1,
  abstract : 0,
  enabled : 1,

  onSuiteBegin,
  onSuiteEnd,

  tests :
  {
  },

}

//

var Self = new wTestSuite( Proto ).inherit( Parent );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
