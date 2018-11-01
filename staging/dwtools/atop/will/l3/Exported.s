( function _Exported_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillParagraphExported( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'ParagraphExported';

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
  let exported = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( exported );
  Object.preventExtensions( exported );

  if( o )
  exported.copy( o );

}

//

function infoExport()
{
  let exported = this;
  let result = '';
  let fields = exported.dataExport();

  if( Object.keys( fields ).length === 0 )
  return result;

  result += exported.constructor.shortName + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } ) + '\n';
  result += '\n';

  return result;
}

//

function dataExport()
{
  let exported = this;
  let fields = exported.cloneData({ compact : 1, copyingAggregates : 0 });
  return fields;
}

// --
// relations
// --

let Composes =
{
  formatVersion : null,
  version : null,
  files : null,
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

  infoExport : infoExport,
  dataExport : dataExport,

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
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
