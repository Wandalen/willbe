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
  return _.workpiece.construct( Self, this, arguments );
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

  _.workpiece.initFields( about );
  Object.preventExtensions( about );

  if( o && o.module )
  about.module = o.module;

  if( o )
  about.copy( o );

}

//

function copy( o )
{
  let about = this;

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

}

//

let _nameGetterSetter = _.accessor.suite.alias({ containerName : 'values', originalName : 'name' });
let nameGetterSetter =
{
  get : _nameGetterSetter.get,
  set : function()
  {
    let result = _nameGetterSetter.set.apply( this, arguments );
    if( this.module )
    this.module._nameChanged();
    return result;
  }
}

//

function infoExport()
{
  let about = this;
  let fields = about.dataExport();

  if( Object.keys( fields ).length === 0 )
  return '';

  let result = '';
  // result += _.color.strFormat( 'About', 'highlighted' );
  result += '\n' + _.toStr( fields, { wrap : 0, levels : 4, multiline : 1 } );

  result += '\n\n';

  return result;
}

//

function dataExport()
{
  let about = this;
  let fields = about.cloneData({ compact : 1, copyingAggregates : 0 });
  _.mapExtend( fields, about.values );
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

}

let Aggregates =
{
  values : null,
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
  name : { getterSetter : nameGetterSetter },
  enabled : { getterSetter : _.accessor.suite.alias({ containerName : 'values', originalName : 'enabled' }) },
}

// --
// declare
// --

let Extend =
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
  extend : Extend,
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
