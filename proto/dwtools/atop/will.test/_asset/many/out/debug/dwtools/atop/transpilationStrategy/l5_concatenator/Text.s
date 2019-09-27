( function _Text_s_() {

'use strict';

//

let _ = wTools;
let Parent = _.TranspilationStrategy.Concatenator.Abstract;
let Self = function wTsConcatenatorText( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Text';

// --
// routines
// --

function init()
{
  let self = Parent.prototype.init.apply( this, arguments );
  return self;
}

//

function _performAct( single )
{
  let self = this;
  let sys = self.sys;
  let result = '';
  let files = single.dataMap;
  let multiple = single.multiple;

  _.assert( _.mapIs( files ) );
  _.assert( arguments.length === 1 );
  _.assert( single instanceof sys.Single );

  /* */

  result = _.mapVals( files ).join( '\n' );

  return result;
}

// --
// relationships
// --

let Composes =
{
  ext : _.define.own([ 'txt', '' ]),
}

let Associates =
{
  starter : null,
}

let Restricts =
{
}

// --
// prototype
// --

let Proto =
{

  init,

  _performAct,

  /* */

  Composes,
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

_.TranspilationStrategy.Concatenator[ Self.shortName ] = Self;

})();
