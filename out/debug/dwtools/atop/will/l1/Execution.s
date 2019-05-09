( function _Execution_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillParagraphExecution( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'ParagraphExecution';

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
  let execution = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( execution );
  Object.preventExtensions( execution );

  if( o )
  execution.copy( o );

}

//

function infoExport()
{
  let execution = this;
  let result = '';
  let fields = execution.dataExport();

  if( Object.keys( fields ).length === 0 )
  return result;

  result += 'Execution' + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } ) + '\n';
  result += '\n';

  return result;
}

//

function dataExport()
{
  let execution = this;
  let fields = execution.cloneData({ compact : 1, copyingAggregates : 0 });

  _.assert( !execution.scripts || execution.scripts !== fields.scripts );

  // if( fields.scripts )
  // fields.scripts = _.mapExtend( null, fields.scripts );

  return fields;
}

// --
// relations
// --

let Composes =
{

  scripts : null,

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

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
