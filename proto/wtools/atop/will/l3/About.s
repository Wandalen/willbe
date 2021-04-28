( function _About_s_()
{

'use strict';

/**
 * @classdesc Class wWillParagraphAbout provides initializing and handling data in section about of willfile.
 * @class wWillParagraphAbout
 * @module Tools/atop/willbe
 */

// if( typeof module !== 'undefined' )
// {
//
//   require( '../IncludeBase.s' );
//
// }

//

const _ = _global_.wTools;
const Parent = null;
const Self = wWillParagraphAbout;
function wWillParagraphAbout( o )
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
  about.values.org = 'noorg';

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
    _.props.extend( about.values, o.values );

  }
  else
  {

    let values = _.mapBut_( null, o, about.FieldsOfCopyableGroups );
    let o2 = _.mapOnly_( null, o, about.FieldsOfCopyableGroups );
    _.Copyable.prototype.copy.call( about, o2 );
    _.props.extend( about.values, values );

  }

}

//

let _nameGetterSetter = _.accessor.suite.alias({ container : 'values', originalName : 'name' });
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

let _orgGetterSetter = _.accessor.suite.alias({ container : 'values', originalName : 'org' });
let orgGetterSetter =
{
  get : _orgGetterSetter.get,
  set : function()
  {
    let result = _orgGetterSetter.set.apply( this, arguments );
    if( this.module )
    this.module._nameChanged();
    return result;
  }
}

//

function exportString()
{
  let about = this;
  let fields = about.exportStructure();

  if( Object.keys( fields ).length === 0 )
  return '';

  let result = '';
  // result += _.color.strFormat( 'About', 'highlighted' );
  result += '\n' + _.entity.exportString( fields, { wrap : 0, levels : 4, multiline : 1 } );

  result += '\n\n';

  return result;
}

//

function exportStructure()
{
  let about = this;
  let fields = about.cloneData({ compact : 1, copyingAggregates : 0 });
  _.props.extend( fields, about.values );
  return fields;
}

// --
// relations
// --

let Composes =
{

  name : null,
  org : 'noorg',
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
  name : { suite : nameGetterSetter },
  org : { suite : orgGetterSetter },
  enabled : { suite : _.accessor.suite.alias({ container : 'values', originalName : 'enabled' }) },
}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,
  copy,

  exportString,
  exportStructure,

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
  extend : Extension,
});

_.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();
