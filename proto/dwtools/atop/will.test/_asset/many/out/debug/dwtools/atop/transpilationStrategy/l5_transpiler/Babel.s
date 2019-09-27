( function _TranspilerBabel_s_() {

'use strict';

let Babylon = require( 'babylon' );
let Babel = require( 'babel-core' );

//

let _ = wTools;
let Parent = _.TranspilationStrategy.Transpiler.Abstract;
let Self = function wTsTranspilerBabel( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Babel';

// --
//
// --

/*
doc : https://babeljs.io/docs/usage/api/#options
*/

function _formAct()
{
  let self = this;
  let session = self.session;

  _.assert( session.inputFilesPaths.length >= 1 );
  _.assert( arguments.length === 0 );

  /* */

  if( !self.settings )
  self.settings = {};
  let set = self.settings;

  let plugins =
  [
    'transform-runtime',
  ]

  let presets = [ 'es2015-without-strict','stage-0','stage-1','stage-2','stage-3', ];
  if( session.isServerSide )
  presets = [ 'node6-without-strict' ];
  presets = [];

  let parserOpts =
  {
    allowImportExportEverywhere : true,
    allowReturnOutsideFunction : true,
  }

  self.settings =
  {
    sourceType : 'script',
    filename : session.inputFilesPaths[ 0 ],
    ast : false,
    compact : !!session.minification,
    minified : !!session.minification,
    comments : !session.minification || !!session.debug,
    presets : presets,
    parserOpts : parserOpts,
    // loose : [ 'es6.modules' ],
    // blacklist : [ 'useStrict' ],
    // plugins : [ 'transform-class-properties' ],
    // plugins : plugins,
  }

  return set;
}

//

function _performAct()
{
  let self = this;
  let session = self.session;
  let result = null;

  try
  {
    result = Babel.transform( self.input.code , self.settings );
  }
  catch( err )
  {

    debugger;
    self.settings.sourceType = 'module';
    logger.log( 'failed, trying babel with { sourceType : "module" }' );
    logger.log( 'settings\n',self.settings );
    result = Babel.transform( self.input.code , self.settings );

  }

  _.assert( _.strIs( result.code ) );

  _.mapExtend( self.output,result );

  return result;
}

// --
// relationships
// --

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
}

// --
// prototype
// --

let Proto =
{

  _formAct,
  _performAct,

  /* */

  Composes,
  Aggregates,
  Associates,
  Restricts,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.TranspilationStrategy.Transpiler[ Self.shortName ] = Self;

})();
