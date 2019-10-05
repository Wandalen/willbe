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
  if( o )
  record.copy( o );
  return record;
}

//

function reform()
{
  let record = this;
  let will = record.will;

  if( record.opener && record.opener.superRelation )
  record.relationAppend( record.opener.superRelation );
  if( record.relation && record.relation.opener && !record.opener )
  record.opener = record.relation.opener;

  let localPath, remotePath;
  if( record.module )
  {
    localPath = record.module.localPath || record.module.commonPath;
    remotePath = record.module.remotePath;
    record.object = record.module;
  }
  else if( record.opener )
  {
    if( record.opener.formed < 2 )
    record.opener.remoteForm();
    _.assert( record.opener.formed >= 2 );
    localPath = record.opener.localPath || record.opener.commonPath;
    remotePath = record.opener.remotePath;
    record.object = record.opener;
  }
  else if( record.relation )
  {
    localPath = record.relation.path;
    remotePath = record.relation.path;
    record.object = record.relation;
  }

  if( localPath && _.strHas( localPath, 'PathBasic' ) )
  debugger;

  _.assert( record.localPath === null || record.localPath === localPath );
  record.localPath = localPath;
  _.assert( record.remotePath === null || record.remotePath === remotePath );
  record.remotePath = remotePath;

  if( record.recordMap )
  {
    _.assert( record.recordMap[ localPath ] === undefined || record.recordMap[ localPath ] === record );
    record.recordMap[ localPath ] = record;
    if( remotePath )
    {
      _.assert( record.recordMap[ remotePath ] === undefined || record.recordMap[ remotePath ] === record );
      record.recordMap[ remotePath ] = record;
    }
  }

  if( record.nodesGroup )
  {
    record.nodesGroup._nodeAddOnce( record );
  }

  record.formed = 1;
  return record;
}

//

function From( o )
{
  let result;
  let made = false;
  let will = o.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) );
  _.assert( _.mapIs( o.recordMap ) );
  _.assert( o.nodesGroup instanceof _.graph.AbstractNodesGroup );

  if( !o.object )
  o.object = o.module || o.opener || o.relation;

  if( o.object && o.object instanceof Self )
  {
    debugger;
    result = o.object;
  }
  else if( _.mapIs( o.object ) )
  {
    debugger;
    result = Self( o.object );
  }
  else if( o.object instanceof _.Will.OpenedModule )
  {
    let localPath = o.object.localPath || o.object.commonPath;
    let remotePath = o.object.remotePath;
    if( o.recordMap && o.recordMap[ localPath ] )
    result = o.recordMap[ localPath ];
    else if( o.recordMap && remotePath && o.recordMap[ remotePath ] )
    result = o.recordMap[ remotePath ];
    else
    o.module = o.object;
  }
  else if( o.object instanceof _.Will.ModuleOpener )
  {
    debugger;
    let localPath = o.object.localPath || o.object.commonPath;
    let remotePath = o.object.remotePath;
    if( o.recordMap && o.recordMap[ o.object.commonPath ] )
    result = o.recordMap[ o.object.commonPath ];
    else if( o.recordMap && remotePath && o.recordMap[ remotePath ] )
    result = o.recordMap[ remotePath ];
    else
    o.opener = o.object;
  }
  else if( o.object instanceof _.Will.ModulesRelation )
  {
    /* xxx : use localPath / remotePath after introducing it */
    let localPath = o.object.path;
    let remotePath = o.object.path;
    if( localPath )
    localPath = path.join( o.object.module.inPath, localPath );
    if( remotePath )
    remotePath = path.join( o.object.module.inPath, localPath );
    if( o.recordMap && o.recordMap[ localPath ] )
    result = o.recordMap[ o.object.path ];
    else if( o.recordMap && remotePath && o.recordMap[ remotePath ] )
    result = o.recordMap[ remotePath ];
    else
    o.relation = o.object;
    if( result )
    result.relationAppend( o.object );
  }
  else _.assert( 0, `Not clear how to get graph record from ${_.strShort( o.object )}` );

  if( result )
  {
    delete o.object;
    if( !o.recordMap )
    delete o.recordMap;
    _.mapExtend( result, o );
  }

  if( !o.recordMap )
  o.recordMap = o.will.recordMap;
  if( !result )
  result = Self( o );

  result.reform();

  _.assert( !!result.object );

  return result;
}

//

function peerModuleGet()
{
  let record = this;
  if( record.object )
  return record.object.peerModule;
  return null;
}

//

function relationAppend( relation )
{
  let record = this;

  _.assert( relation instanceof _.Will.ModulesRelation );

  if( !record.relation )
  record.relation = relation;

  _.arrayAppendOnce( record.relations, relation );

}

//

function relationRemove( relation )
{
  let record = this;

  _.assert( relation instanceof _.Will.ModulesRelation );
  _.arrayRemoveOnce( record.relations, relation );

  if( record.relation === relation )
  record.relation = null;

  if( !record.relation && record.relations.length )
  record.relation = record.relations[ 0 ];

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

  // commonPath : null,
  localPath : null,
  remotePath : null,
  module : null,
  opener : null,
  relation : null,
  relations : _.define.own([]),
  object : null,
  // peerModule : null,

  will : null,
  recordMap : null,
  nodesGroup : null,

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
  commonPath : 'commonPath',
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
  relationAppend,
  relationRemove,

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

_.Copyable.mixin( Self );

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDeclare
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
