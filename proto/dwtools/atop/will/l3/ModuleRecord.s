( function _ModuleRecord_s_( ) {

'use strict';

if( typeof record !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillModuleRecord( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ModuleRecord';

// --
// inter
// --

function finit()
{
  let record = this;
  let will = record.will;
  _.assert( !record.finitedIs() );
  return Parent.prototype.finit.apply( record, arguments );
}

//

function init( o )
{
  let record = this;
  _.workpiece.initFields( record );
  Object.preventExtensions( record );
  _.Will.ResourceCounter += 1;
  record.id = _.Will.ResourceCounter;
}

//

function reform()
{
  let record = this;
  let will = record.will;

  if( record.opener && record.opener.superRelation && !record.relation )
  record.relation = record.opener.superRelation;
  if( record.relation && record.relation.opener && !record.opener )
  record.opener = record.relation.opener;

  let commonPath;
  if( record.module )
  {
    commonPath = record.module.commonPath;
    record.object = record.module;
  }
  else if( record.opener )
  {
    commonPath = record.opener.commonPath;
    record.object = record.opener;
  }
  else if( record.relation )
  {
    commonPath = record.relation.path;
    record.object = record.relation;
  }

  // if( record.object.peerModule )
  // record.peerModule = record.object.peerModule;

  _.assert( record.commonPath === null || record.commonPath === commonPath );
  record.commonPath = commonPath;

  if( record.recordMap )
  {
    _.assert( record.recordMap[ commonPath ] === undefined || record.recordMap[ commonPath ] === record );
    record.recordMap[ commonPath ] = record;
  }

  record.formed = 1;
  return record;
}

//

function From( o )
{
  let result;
  let made = false;

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) );
  _.assert( _.mapIs( o.recordMap ) );

  if( !o.object )
  o.object = o.module || o.opener || o.relation;

  if( !o.recordMap )
  o.recordMap = o.will.recordMap;

  if( o.object && o.object instanceof Self )
  {
    debugger;
    result = o.object;
    delete o.object;
    _.mapExtend( result, o );
  }
  else if( _.mapIs( o.object ) )
  {
    debugger;
    // _.assertMapHasOnly( o.object, Record  );
    // _.assertMapHasAll( o.object, Record );
    // result = o.object;
    result = Self( o.object );
  }
  else if( o.object instanceof _.Will.OpenedModule )
  {
    if( o.recordMap && o.recordMap[ o.object.commonPath ] )
    result = o.recordMap[ o.object.commonPath ];
    else
    result = Self( o );
    _.assert( !result.module || result.module === o.object );
    result.module = o.object;
  }
  else if( o.object instanceof _.Will.ModuleOpener )
  {
    debugger;
    if( o.recordMap && o.recordMap[ o.object.commonPath ] )
    result = o.recordMap[ o.object.commonPath ];
    else
    result = Self( o );
    result.opener = o.object;
  }
  else if( o.object instanceof _.Will.ModulesRelation )
  {
    if( o.recordMap && o.recordMap[ o.object.path ] )
    debugger;
    if( o.recordMap && o.recordMap[ o.object.path ] )
    result = o.recordMap[ o.object.path ];
    else
    result = Self( o );
    result.relation = o.object;
  }
  else _.assert( 0, `Not clear how to get graph record from ${_.strShort( o.object )}` );

  result.reform();

  return result;

  // function make()
  // {
  //   let record = _.mapExtend( null, Record );
  //   made = true;
  //   return record;
  // }

}

//

function peerModuleGet()
{
  let record = this;
  if( record.object )
  record.object.peerModule;
  return null;
}

// --
// relations
// --

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{

  commonPath : null,
  module : null,
  opener : null,
  relation : null,
  object : null,
  // peerModule : null,

  will : null,
  recordMap : null,

}

let Medials =
{
}

let Restricts =
{

  id : null,
  formed : 0,

}

let Statics =
{
  From,
}

let Forbids =
{
  recordsMap : 'recordsMap',
}

let Accessors =
{
  peerModule : { getter : peerModuleGet, readOnly : 1 },
}

// --
// declare
// --

let Extend =
{

  // inter

  finit,
  init,
  reform,

  From,

  peerModuleGet,

  // relation

  Composes,
  Aggregates,
  Associates,
  Medials,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
