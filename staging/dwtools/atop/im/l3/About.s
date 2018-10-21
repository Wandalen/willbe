( function _About_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wImParagraphAbout( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'ParagraphAbout';

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let about = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( about );
  Object.preventExtensions( about );

  if( o )
  about.copy( o );

}

//

function info()
{
  let about = this;
  let result = '';
  let fields = _.mapOnly( about, about.Composes );
  fields = _.mapButNulls( fields );

  if( Object.keys( fields ).length === 0 )
  return result;

  result += 'About' + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } ) + '\n';
  result += '\n';

  return result;
}

// --
// relations
// --

let Composes =
{

  name : null,
  description : null,
  version : null,
  interpreters : null,
  keywords : null,

}

let Aggregates =
{
}

let Associates =
{
  module : null,
}

let Restricts =
{
}

let Statics =
{
  formed : 0,
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

  finit : finit,
  init : init,

  info : info,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = wTools;

_.staticDecalre
({
  prototype : _.Im.prototype,
  name : Self.shortName,
  value : Self,
});

})();
