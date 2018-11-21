( function _Stager_s_( ) {

'use strict';

if( typeof self !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  _.include( 'wCopyable' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wStager( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Stager';

// --
// inter
// --

function init( o )
{
  let self = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( self );
  Object.preventExtensions( self );

  if( o )
  self.copy( o );

  _.assert( _.arrayIs( self.stageNames ) );
  _.assert( _.arrayIs( self.consequenceNames ) );
  _.assert( _.arrayIs( self.finals ) );
  _.assert( self.stageNames.length === self.consequenceNames.length );
  _.assert( self.stageNames.length === self.finals.length );
  _.assert( _.strsAre( self.stageNames ) );
  _.assert( _.strsAre( self.consequenceNames ) );
  _.assert( _.numbersAre( self.finals ) );
  _.assert( _.objectIs( self.object ) );

  Object.freeze( self );
}

//

function stage( stageName, number )
{
  let self = this;
  let object = self.object;
  let l = self.stageNames.length;
  let stage = self.stageNames.indexOf( stageName );
  let consequence = object[ self.consequenceNames[ stage ] ];
  let isFinal = number === self.finals[ stage ];

  if( Config.debug )
  for( let s = 0 ; s < stage ; s++ )
  {
    _.assert( object[ self.stageNames[ s ] ] > 0, () => 'For ' + object.nickName + ' states preceding ' + _.strQuote( stageName ) + ' should be greater than zero, but ' + _.strQuote( self.stageNames[ s ] ) + ' is not' );
  }

  if( Config.debug )
  for( let s = stage+1 ; s < l ; s++ )
  {
    _.assert( object[ self.stageNames[ s ] ] <= 1, () => 'States following ' + _.strQuote( stageName ) + ' should be zero or one, but ' + _.strQuote( self.stageNames[ s ] ) + ' is ' + object[ self.stageNames[ s ] ] );
    _.assert( !consequence.resourcesHas(), () => 'Consequences following ' + _.strQuote( self.consequenceNames[ s ] ) + ' should have no resource' );
  }

  _.assert( arguments.length === 2 );
  _.assert( _.consequenceIs( consequence ) );
  _.assert( stage >= 0, () => 'Unknown stage ' + _.strQuote( stageName ) );
  _.assert( _.numberIs( number ) && number <= self.finals[ stage ], () => 'Stage ' + _.strQuote( stageName ) + ' should be in range ' + _.rangeToStr([ 0, self.finals[ stage ] ]) );
  _.assert( object[ stageName ]+1 === number, () => 'Stage ' + _.strQuote( stageName ) + ' has value ' + object[ stageName ] + ' so the next value should be ' + object[ stageName ] + 'attempt to set ' + number );
  _.assert( !consequence.resourcesHas(), () => 'Consequences ' + _.strQuote( self.consequenceNames[ stage ] ) + ' of the current stage ' + _.strQuote( stageName ) + ' should have no resource' );

  // if( isFinal )
  // if( stageName === 'willFilesOpened' )
  // debugger;

  if( isFinal )
  _.timeOut( 1, () => consequence.give( null ) );

  object[ stageName ] = number;

  if( self.verbosity )
  console.log( ' s', object.nickName, stageName, number );

  return isFinal;
}

// --
// relations
// --

let Composes =
{
  stageNames : null,
  consequenceNames : null,
  finals : null,
  verbosity : 0,
}

let Aggregates =
{
}

let Associates =
{
  object : null,
}

let Restricts =
{
}

let Statics =
{
}

let Forbids =
{
}

let Accessors =
{
}

// --
// declare
// --

let Proto =
{

  // inter

  init : init,
  stage : stage,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );
_[ Self.shortName ] = Self;

if( typeof self !== 'undefined' && self !== null )
self[ 'exports' ] = wTools;

})();
