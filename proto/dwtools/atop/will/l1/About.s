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

  about.values = Object.create( null );
  about.values.enabled = 1;
  about.values.name = null;

  _.instanceInit( about );
  Object.preventExtensions( about );

  if( o )
  about.copy( o );

}

//

function copy( o )
{
  let about = this;

  // debugger;
  // about.name = 'xxx';
  // about.enabled = 3;
  // debugger;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _.instanceIs( o ) )
  {

    _.Copyable.prototype.copy.call( about, o );
    _.mapExtend( about.values, o.values );

  }
  else
  {

    let values = _.mapBut( o, about.FieldsOfCopyableGroups );
    let o2 = _.mapOnly( o, about.FieldsOfCopyableGroups );
    _.Copyable.prototype.copy.call( about, o2 );
    _.mapExtend( about.values, values );

  }

  // debugger;
}

//

function infoExport()
{
  let about = this;
  let fields = about.dataExport();

  if( Object.keys( fields ).length === 0 )
  return '';

  let result = _.color.strFormat( 'About', 'highlighted' );
  result += '\n' + _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } );

  result += '\n\n';

  return result;
}

//

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
  enabled : 1,
  version : null,
  values : null,

  // interpreters : null,
  // keywords : null,


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
  name : { getterSetter : _.accessor.accessor.alias({ containerName : 'values', originalName : 'name' }) },
  enabled : { getterSetter : _.accessor.accessor.alias({ containerName : 'values', originalName : 'enabled' }) },
  // name : { setter : _.accessor.setter.alias({ containerName : 'values', original : 'name', alias : 'name' }), getter : _.accessor.getter.alias({ containerName : 'values', original : 'name', alias : 'name' }) },
  // enabled : { setter : _.accessor.setter.alias({ containerName : 'values', original : 'enabled', alias : 'enabled' }), getter : _.accessor.getter.alias({ containerName : 'values', original : 'enabled', alias : 'enabled' }) },
}

// --
// declare
// --

let Proto =
{

  // inter

  finit,
  init,
  copy,

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
