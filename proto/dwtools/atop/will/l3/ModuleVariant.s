( function _ModuleVariant_s_( ) {

'use strict';

if( typeof variant !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wWillModuleVariant( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ModuleVariant';

// --
// inter
// --

function finit()
{
  let variant = this;
  let will = variant.will;
  _.assert( !variant.finitedIs() );

  _.each( variant.modules, ( module ) => variant.moduleRemove( module ) );
  _.each( variant.openers, ( opener ) => variant.moduleRemove( opener ) );
  _.each( variant.relations, ( relation ) => variant.moduleRemove( relation ) );

  _.assert( variant.module === null );
  _.assert( variant.opener === null );
  _.assert( variant.relation === null );
  _.assert( variant.object === null );

  for( let v in will.variantMap )
  {
    if( will.variantMap[ v ] === variant )
    delete will.variantMap[ v ];
  }

  return _.Copyable.prototype.finit.apply( variant, arguments );
}

//

function init( o )
{
  let variant = this;
  _.workpiece.initFields( variant );
  Object.preventExtensions( variant );
  _.Will.ResourceCounter += 1;
  variant.id = _.Will.ResourceCounter;

  if( o )
  variant.copy( o );

  if( o.module )
  variant.moduleAdd( o.module );
  if( o.opener )
  variant.openerAdd( o.opener );
  if( o.relation )
  variant.relationAdd( o.relation );
  if( o.object )
  variant._add( o.object );

  return variant;
}

//

function reform()
{
  let variant = this;
  let will = variant.will;

  _.assert( !variant.finitedIs() );

  if( !variant.opener && !variant.module && !variant.relation )
  {
    // debugger;
    variant.finit();
    return false;
  }

  // if( variant.id === 58 )
  // debugger;

  if( variant.relation && variant.relation.opener && !variant.opener )
  variant.openerAdd( variant.relation.opener );
  if( variant.opener && variant.opener.openedModule )
  variant.moduleAdd( variant.opener.openedModule );
  if( variant.opener && variant.opener.superRelation )
  variant.relationAdd( variant.opener.superRelation );

  // variant.opener = variant.relation.opener;
  if( variant.module && !variant.opener )
  _.any( variant.module.userArray, ( opener ) =>
  {
    if( opener instanceof _.Will.ModuleOpener )
    {
      variant.openerAdd( opener );
      // variant.opener = opener;
      // return true;
    }
  });

  let localPath, remotePath;
  if( variant.module )
  {
    localPath = variant.module.localPath || variant.module.commonPath;
    remotePath = variant.module.remotePath;
    variant.object = variant.module;
  }
  else if( variant.opener )
  {
    if( variant.opener.formed < 2 )
    variant.opener.remoteForm();
    _.assert( variant.opener.formed >= 2 );
    localPath = variant.opener.localPath || variant.opener.commonPath;
    remotePath = variant.opener.remotePath;
    variant.object = variant.opener;
  }
  else if( variant.relation )
  {
    localPath = variant.relation.path;
    remotePath = variant.relation.path;
    variant.object = variant.relation;
  }

  if( variant.localPath && localPath && variant.localPath !== localPath )
  {
    _.assert( will.variantMap[ localPath ] === undefined || will.variantMap[ localPath ] === variant );
    delete will.variantMap[ localPath ];
    variant.localPath = localPath;
  }

  if( variant.module )
  _.assert( !variant.module.finitedIs() );
  if( variant.opener )
  _.assert( !variant.opener.finitedIs() );
  if( variant.relation )
  _.assert( !variant.relation.finitedIs() );

  _.assert( _.strDefined( localPath ), () => `${variant.object.absoluteName} does not have defined local path` );
  _.assert
  (
    !variant.opener || variant.opener.formed >= 2,
    () => `Opener should be formed to level 2 or higher, but ${variant.opener.absoluteName} is not`
  )

  _.assert( variant.localPath === null || variant.localPath === localPath );
  variant.localPath = localPath;
  _.assert( variant.remotePath === null || variant.remotePath === remotePath );
  variant.remotePath = remotePath;

  if( will.variantMap )
  {
    _.assert( will.variantMap[ localPath ] === undefined || will.variantMap[ localPath ] === variant );
    will.variantMap[ localPath ] = variant;
    if( remotePath )
    {
      _.assert( will.variantMap[ remotePath ] === undefined || will.variantMap[ remotePath ] === variant );
      will.variantMap[ remotePath ] = variant;
    }
  }

  // if( variant.nodesGroup )
  // {
  //   variant.nodesGroup._nodeAddOnce( variant );
  // }

  variant.formed = 1;
  return variant;
}

//

function From( o )
{
  let result;
  let will = o.will;
  let variantMap = will.variantMap;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let made = false;
  let changed = false;

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) );
  _.assert( _.mapIs( variantMap ) );
  // _.assert( o.nodesGroup instanceof _.graph.AbstractNodesGroup );

  if( !o.object )
  o.object = o.module || o.opener || o.relation;

  // if( o.object && o.object.id === 38 )
  // debugger;

  if( o.object && o.object instanceof Self )
  {
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
    let remotePath = o.object.remotePath
    o.module = o.object;
    if( variantMap && variantMap[ localPath ] )
    result = variantMap[ localPath ];
    else if( variantMap && remotePath && variantMap[ remotePath ] )
    result = variantMap[ remotePath ];
  }
  else if( o.object instanceof _.Will.ModuleOpener )
  {
    // debugger;
    let localPath = o.object.localPath || o.object.commonPath;
    let remotePath = o.object.remotePath;
    o.opener = o.object;
    if( variantMap && variantMap[ o.object.commonPath ] )
    result = variantMap[ o.object.commonPath ];
    else if( variantMap && remotePath && variantMap[ remotePath ] )
    result = variantMap[ remotePath ];
  }
  else if( o.object instanceof _.Will.ModulesRelation )
  {
    /* xxx : use localPath / remotePath after introducing it */
    let localPath = o.object.path;
    let remotePath = o.object.path;
    o.relation = o.object;
    if( localPath )
    localPath = path.join( o.object.module.inPath, localPath );
    if( remotePath )
    remotePath = path.join( o.object.module.inPath, localPath );
    if( variantMap && variantMap[ localPath ] )
    result = variantMap[ localPath ];
    else if( variantMap && remotePath && variantMap[ remotePath ] )
    result = variantMap[ remotePath ];
  }
  else _.assert( 0, `Not clear how to get graph variant from ${_.strShort( o.object )}` );

  _.assert
  (
    !o.relation || ( !!o.relation.opener && o.relation.opener.formed >= 2 ),
    () => `Relation should be formed to level 3 or higher, but ${o.relation.absoluteName} is not`
  )

  if( result )
  {
    // _.assert( !variantMap || variantMap === result.variantMap );

    if( o.module )
    changed = result.add( o.module ) || changed;
    if( o.opener )
    changed = result.add( o.opener ) || changed;
    if( o.relation )
    changed = result.add( o.relation ) || changed;

    // delete o.variantMap;
    delete o.object;
    delete o.module;
    delete o.opener;
    delete o.relation;

    _.mapExtend( result, o );
  }

  // if( !o.variantMap )
  // o.variantMap = o.will.variantMap;
  if( !result )
  {
    made = true;
    changed = true;
    result = Self( o );
  }

  result.reform();

  _.assert( !!result.object );

  return result;
}

//

function PathsOf( object )
{
  let result = [];

  _.assert( !!object );

  if( object instanceof Self )
  {
    let localPath = object.localPath;
    let remotePath = object.remotePath;
    if( localPath )
    result.push( localPath );
    if( remotePath )
    result.push( remotePath );
  }
  else if( object instanceof _.Will.OpenedModule )
  {
    let localPath = object.localPath || object.commonPath;
    let remotePath = object.remotePath;
    if( localPath )
    result.push( localPath );
    if( remotePath )
    result.push( remotePath );
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    let localPath = object.localPath || object.commonPath;
    let remotePath = object.remotePath;
    if( localPath )
    result.push( localPath );
    if( remotePath )
    result.push( remotePath );
  }
  else if( object instanceof _.Will.ModulesRelation )
  {
    let path = object.module.will.fileProvider.path;
    let localPath = object.path;
    let remotePath = object.path;
    if( localPath )
    {
      localPath = path.join( object.module.inPath, localPath );
      result.push( localPath );
    }
    if( remotePath )
    {
      remotePath = path.join( object.module.inPath, localPath );
      result.push( remotePath );
    }
  }
  else _.assert( 0 );

  return result;
}

//

function peerModuleGet()
{
  let variant = this;
  if( variant.object )
  return variant.object.peerModule;
  return null;
}

//

function relationAdd( relation )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  // if( relation.id === 300 )
  // debugger;

  _.assert( relation instanceof _.Will.ModulesRelation );

  if( !variant.relation )
  {
    variant.relation = relation;
    changed = true;
  }

  changed = _.arrayAppendedOnce( variant.relations, relation ) > -1 || changed;

  let variant2 = will.objectToVariantHash.get( relation );
  _.assert( variant2 === variant || variant2 === undefined );
  will.objectToVariantHash.set( relation, variant );

  return changed;
}

//

function relationRemove( relation )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  // if( relation.id === 300 )
  // debugger;

  _.assert( relation instanceof _.Will.ModulesRelation );
  _.arrayRemoveOnce( variant.relations, relation );

  if( variant.relation === relation )
  variant.relation = null;
  if( variant.object === relation )
  variant.object = null;

  if( !variant.relation && variant.relations.length )
  variant.relation = variant.relations[ 0 ];

  let variant2 = will.objectToVariantHash.get( relation );
  _.assert( variant2 === variant );
  will.objectToVariantHash.delete( relation );

}

//

function openerAdd( opener )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  if( opener.id === 210 )
  debugger;

  _.assert( opener instanceof _.Will.ModuleOpener );

  if( !variant.opener )
  {
    variant.opener = opener;
    changed = true;
  }

  changed = _.arrayAppendedOnce( variant.openers, opener ) > -1 || changed;

  let variant2 = will.objectToVariantHash.get( opener );
  _.assert( variant2 === variant || variant2 === undefined );
  will.objectToVariantHash.set( opener, variant );

  return changed;
}

//

function openerRemove( opener )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  if( opener.id === 210 )
  debugger;

  _.assert( opener instanceof _.Will.ModuleOpener );
  _.arrayRemoveOnceStrictly( variant.openers, opener );
  _.assert( !variant.relation || variant.relation.opener !== opener );

  if( variant.opener === opener )
  variant.opener = null;
  if( variant.object === opener )
  variant.object = null;

  if( !variant.opener && variant.openers.length )
  variant.opener = variant.openers[ 0 ];

  let variant2 = will.objectToVariantHash.get( opener );
  _.assert( variant2 === variant );
  will.objectToVariantHash.delete( opener );

}

//

function moduleAdd( module )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  // if( module.id === 131 || !module.willfilesPath )
  // debugger;

  // if( variant.id === 49 )
  // debugger;
  // if( module.id === 435 )
  // debugger;

  _.assert( module instanceof _.Will.OpenedModule );

  if( !variant.module )
  {
    variant.module = module;
    changed = true;
  }

  changed = _.arrayAppendedOnce( variant.modules, module ) > -1 || changed;

  let variant2 = will.objectToVariantHash.get( module );
  _.assert( variant2 === variant || variant2 === undefined );
  will.objectToVariantHash.set( module, variant );

  return changed;
}

//

function moduleRemove( module )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  // if( variant.id === 49 )
  // debugger;
  // if( module.id === 435 )
  // debugger;

  // if( module.id === 131 || !module.willfilesPath )
  // debugger;

  _.assert( module instanceof _.Will.OpenedModule );
  _.assert( variant.module === module );
  _.arrayRemoveOnceStrictly( variant.modules, module );
  _.assert( !variant.opener || variant.opener.openedModule !== module );

  if( variant.module === module )
  variant.module = null;
  if( variant.object === module )
  variant.object = null;

  if( !variant.module && variant.modules.length )
  variant.module = variant.modules[ 0 ];

  let variant2 = will.objectToVariantHash.get( module );
  _.assert( variant2 === variant );
  will.objectToVariantHash.delete( module );

}

//

function _add( object )
{
  let variant = this;
  let result;

  if( object instanceof _.Will.ModulesRelation )
  {
    result = variant.relationAdd( object );
  }
  else if( object instanceof _.Will.OpenedModule )
  {
    result = variant.moduleAdd( object );
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    result = variant.openerAdd( object );
  }
  else _.assert( 0 );

  return result;
}

//

function add( object )
{
  let variant = this;
  let result = variant._add( object );
  variant.reform();
  return result;
}

//

function _remove( object )
{
  let variant = this;

  // if( variant.id === 58 )
  // debugger;

  if( object instanceof _.Will.ModulesRelation )
  {
    variant.relationRemove( object );
  }
  else if( object instanceof _.Will.OpenedModule )
  {
    variant.moduleRemove( object );
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    variant.openerRemove( object );
  }
  else _.assert( 0 );

  // if( variant.id === 58 )
  // debugger;

}

//

function remove( object )
{
  let variant = this;
  variant._remove( object );
  return variant.reform();
}

//

function moduleSet( module )
{
  let variant = this;
  // if( variant.id === 49 && !module )
  // debugger;
  variant[ moduleSymbol ] = module;
  return module;
}

// --
// relations
// --

let moduleSymbol = Symbol.for( 'module' );

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{

  localPath : null,
  remotePath : null,

  will : null,
  // variantMap : null,
  // nodesGroup : null,

}

let Medials =
{

  module : null,
  opener : null,
  relation : null,
  object : null,

}

let Restricts =
{

  id : null,
  formed : 0,

  module : null,
  modules : _.define.own([]),
  opener : null,
  openers : _.define.own([]),
  relation : null,
  relations : _.define.own([]),
  object : null,

}

let Statics =
{
  From,
  PathsOf,
}

let Forbids =
{
  recordsMap : 'recordsMap',
  commonPath : 'commonPath',
  nodesGroup : 'nodesGroup',
  variantMap : 'variantMap',
}

let Accessors =
{
  // module : { setter : moduleSet },
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
  PathsOf,

  peerModuleGet,

  relationAdd,
  relationRemove,
  openerAdd,
  openerRemove,
  moduleAdd,
  moduleRemove,

  _add,
  add,
  _remove,
  remove,

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
