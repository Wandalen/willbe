( function _About_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillParagraphAbout( o )
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

function infoExport()
{
  let about = this;
  let result = '';
  let fields = about.dataExport();

  if( Object.keys( fields ).length === 0 )
  return result;

  result += 'About' + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } ) + '\n';
  result += '\n';

  return result;
}

//

// function dataExport()
// {
//   let about = this;
//   let fields = _.mapOnly( about, about.Composes );
//   fields = _.mapButNulls( fields );
//   return fields;
// }

function dataExport()
{
  let about = this;
  let fields = about.cloneData({ compact : 1, copyingAggregates : 0 });
  return fields;
}
// --
// relations
// --

let Composes =
{

  name : null,
  description : null,
  version : null,
  enabled : 1,
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

  finit,
  init,

  infoExport,
  dataExport,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

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
module[ 'exports' ] = _global_.wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
