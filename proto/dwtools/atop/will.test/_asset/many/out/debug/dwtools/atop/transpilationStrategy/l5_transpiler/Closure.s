( function _TranspilerClosure_s_() {

'use strict';

let Closure = require( 'google-closure-compiler-js' );

//

let _ = wTools;
let Parent = _.TranspilationStrategy.Transpiler.Abstract;
let Self = function wTsTranspilerClosure( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Closure';

// --
//
// --

/*
doc : https://github.com/google/closure-compiler-js#flags
*/

function _formAct()
{
  let self = this;
  let session = self.session;

  if( !self.settings )
  self.settings = {};
  let set = self.settings;

  set.languageIn = 'ECMASCRIPT6';
  // set.languageOut = 'ECMASCRIPT6';
  // set.compilationLevel = session.optimization < 8 ? 'SIMPLE' : 'ADVANCED';
  set.compilationLevel = 'SIMPLE';
  set.warningLevel = 'DEFAULT';
  set.env = 'CUSTOM';
  set.assumeFunctionWrapper = false;
  // set.preserveTypeAnnotations = !!session.pretty;
  set.preserveTypeAnnotations = false;

  return set;
}

//

function _performAct()
{
  let self = this;
  let session = self.session;
  let result = null;

  self.settings.jsCode = [{ src : self.input.code }];
  result = Closure.compile( self.settings );
  _.mapExtend( self.output,result );

  if( result.error )
  throw _.err( result.error );
  if( result.errors.length )
  throw _.err( result.errors[ result.errors.length-1 ] );

  self.output.code = self.output.compiledCode;

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
