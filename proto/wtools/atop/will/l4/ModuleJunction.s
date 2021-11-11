( function _ModuleJunction_s_()
{

'use strict';

/**
 * @classdesc Class wWillModuleJunction implements interface that allows different interfaces : module, relation, opener, object as single instance.
 * @class wWillModuleJunction
 * @module Tools/atop/willbe
 */

const _ = _global_.wTools;
const Parent = _.will.AbstractJunction;
// const Parent = null;
const Self = wWillModuleJunction;
function wWillModuleJunction( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'ModuleJunction';

/* zzz : multiple inheritance should be here from AbstractModule1 an AbstractJunction */

// --
// inter
// --

function finit()
{
  let junction = this;
  let will = junction.will;
  _.assert( !junction.isFinited() );

  _.each( junction.modules, ( module ) => junction._moduleRemove( module ) );
  _.each( junction.openers, ( opener ) => junction._moduleRemove( opener ) );
  _.each( junction.relations, ( relation ) => junction._moduleRemove( relation ) );

  _.assert( junction.module === null );
  _.assert( junction.opener === null );
  _.assert( junction.relation === null );
  _.assert( junction.object === null );

  if( junction.peer )
  {
    let peer = junction.peer;
    _.assert( junction.peer.peer === junction )
    peer.peer = null;
    junction.peer = null;
    if( !peer.isUsed() )
    peer.finit();
  }

  for( let v in will.junctionMap )
  {
    if( will.junctionMap[ v ] === junction )
    delete will.junctionMap[ v ];
  }

  return _.Copyable.prototype.finit.apply( junction, arguments );
}

//

function init( o )
{
  let junction = this;
  _.workpiece.initFields( junction );
  Object.preventExtensions( junction );
  _.Will.ResourceCounter += 1;
  junction.id = _.Will.ResourceCounter;

  if( o )
  junction.copy( o );

  if( o.module )
  junction._moduleAdd( o.module );
  if( o.opener )
  junction._openerAdd( o.opener );
  if( o.relation )
  junction._relationAdd( o.relation );
  if( o.object )
  junction._add( o.object );

  return junction;
}

//

function reform()
{
  let junction = this;
  let will = junction.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;

  if( junction.formed === -1 )
  return;

  junction.formed = -1;

  _.assert( !junction.isFinited() );

  if( junction.isFinited() )
  return;

  associationsAdd(); /* xxx : optimize? */
  objectFind();
  pathsForm();

  junction.mergeMaybe( 1 );
  if( junction.isFinited() )
  {
    return false;
  }
  if( !junction.isUsed() )
  {
    junction.finit();
    return false;
  }

  verify();
  register();
  peerForm();
  nameForm();
  isOutForm();

  junction.assertIntegrityVerify();

  junction.formed = 1;
  return junction;

  /* */

  function pathAdd( object )
  {
    let localPath, remotePath;
    [ localPath, remotePath ] = junction.PathsOf( object );

    if( localPath )
    {
      _.arrayAppendOnce( junction.localPaths, localPath );
      if( junction.localPath === null )
      junction.localPath = localPath;
    }

    if( remotePath )
    {
      _.arrayAppendOnce( junction.remotePaths, remotePath );
      junction.remotePath = remotePath;
    }

  }

  /* */

  function pathFromPeerAdd( object )
  {

    let localPath = object.peerLocalPathGet();
    if( localPath )
    _.arrayAppendOnce( junction.localPaths, localPath );
    if( junction.localPath === null )
    junction.localPath = localPath;
    _.assert( localPath === null || _.strIs( localPath ) );

    let remotePath = object.peerRemotePathGet();
    if( remotePath )
    _.arrayAppendOnce( junction.remotePaths, remotePath );
    if( junction.remotePath === null )
    junction.remotePath = remotePath;
    _.assert( remotePath === null || _.strIs( remotePath ) );

  }

  /* */

  function pathsForm()
  {

    junction.localPaths.splice( 0, junction.localPaths.length );
    junction.remotePaths.splice( 0, junction.remotePaths.length );

    junction.modules.forEach( ( object ) => pathAdd( object ) );
    junction.openers.forEach( ( object ) => pathAdd( object ) );
    junction.relations.forEach( ( object ) => pathAdd( object ) );

    if( junction.peer )
    junction.peer.modules.forEach( ( object ) => pathFromPeerAdd( object ) );

    if( junction.localPaths.length && !_.longHas( junction.localPaths, junction.localPath ) )
    junction.localPath = junction.localPaths[ 0 ];
    if( junction.remotePaths.length && !_.longHas( junction.remotePaths, junction.remotePath ) )
    junction.remotePath = junction.remotePaths[ 0 ];

    _.assert( !junction.localPaths.length || _.longHas( junction.localPaths, junction.localPath ) );
    _.assert( !junction.remotePaths.length || _.longHas( junction.remotePaths, junction.remotePath ) );

  }

  /* */

  function objectFind()
  {
    if( junction.module )
    {
      junction.object = junction.module;
    }
    else if( junction.opener )
    {
      _.assert( junction.opener.formed >= 2 || junction.opener.formed === -1 );
      junction.object = junction.opener;
    }
    else if( junction.relation )
    {
      junction.object = junction.relation;
    }
  }

  /* */

  function associationsAdd()
  {

    /* yyy */
    junction._add( junction.AssociationsAliveOf( junction.relations ) );
    junction._add( junction.AssociationsAliveOf( junction.openers ) );
    junction._add( junction.AssociationsAliveOf( junction.modules ) );

  }

  /* */

  function finitedRemove()
  {
    if( junction.module && junction.module.isFinited() )
    junction._remove( junction.module );
    if( junction.opener && junction.opener.isFinited() )
    junction._remove( junction.opener );
    if( junction.relation && junction.relation.isFinited() )
    junction._remove( junction.relation );

  }

  /* */

  function verify()
  {

    if( junction.module )
    _.assert( !junction.module.isFinited() );
    if( junction.opener )
    _.assert( !junction.opener.isFinited() );
    if( junction.relation )
    _.assert( !junction.relation.isFinited() );

    _.assert
    (
      _.strDefined( junction.localPath ) || _.strDefined( junction.remotePath ),
      () => `${junction.name} does not have defined local path, neither remote path`
    );
    _.assert
    (
      !junction.opener || junction.opener.formed >= 2 || junction.opener.formed === -1,
      () => `Opener should be formed to level 2 or higher, but ${junction.opener.absoluteName} is not`
    );

  }

  /* */

  function register()
  {
    if( will.junctionMap )
    {
      if( junction.localPath )
      {
        junction.localPaths.forEach( ( localPath ) =>
        {
          _.assert( will.junctionMap[ localPath ] === undefined || will.junctionMap[ localPath ] === junction );
          _.assert( _.strDefined( localPath ) );
          will.junctionMap[ localPath ] = junction;
        });
      }
      if( junction.remotePath )
      {
        _.assert( will.junctionMap[ junction.remotePath ] === undefined || will.junctionMap[ junction.remotePath ] === junction );
        _.assert( _.strDefined( junction.remotePath ) );
        will.junctionMap[ junction.remotePath ] = junction;
      }
    }
  }

  /* */

  function peerFromModule( module )
  {
    _.assert( module instanceof _.will.Module );
    _.assert( !module.peerModule );

    let localPath = module.peerLocalPathGet();
    if( !localPath )
    return;

    if( will.junctionMap[ localPath ] )
    {
      let junction2 = will.junctionMap[ localPath ];
      peerAssign( junction, junction2 );
      return junction2;
    }

    _.assert( !will.junctionMap[ localPath ] );

    let junction2 = new _.will.ModuleJunction({ will });
    junction2.localPaths.push( localPath );
    junction2.localPath = localPath;
    peerAssign( junction, junction2 );
    junction2.reform();

    return junction2;
  }

  /* */

  function peerFrom( object )
  {
    let peerModule = object.peerModule;

    if( !peerModule )
    return;

    if( !peerModule.isPreformed() )
    return;

    if( junction.peer )
    {
      _.assert( junction.peer.peer === junction );
      if( !object.peerModule )
      return junction.peer;
      let junction2 = _.will.ModuleJunction._Of({ object : object.peerModule, will });
      if( junction2 && junction2.peer === junction )
      return junction.peer;
    }

    // debugger; /* xxx */
    let junction2 = _.will.ModuleJunction._Of({ object : peerModule, will });
    peerAssign( junction, junction2 );

    return junction2;
  }

  /* */

  function peerAssign( junction, junction2 )
  {
    _.assert( !junction.isFinited() );
    _.assert( !!junction2 );

    if( junction2.peer && junction2.peer !== junction )
    {
      if( junction2.peer.ownSomething() )
      junction2.peer.mergeIn( junction );
      else
      junction2.peer.finit();
      // if( !junction2.peer.ownSomething() )
      // {
      //   junction2.peer.finit();
      // }
      // else
      // {
      //   junction2.peer.mergeIn( junction );
      // }
    }

    if( junction.peer && junction.peer !== junction2 )
    {
      if( junction.peer.ownSomething() )
      {
        junction2.mergeIn( junction.peer );
        return;
      }
      else
      {
        junction.peer.finit();
      }
      // if( !junction.peer.ownSomething() )
      // {
      //   junction.peer.finit();
      // }
      // else
      // {
      //   junction2.mergeIn( junction.peer );
      //   return;
      // }
    }

    assign();

    function assign()
    {
      _.assert( junction.peer === junction2 || junction.peer === null );
      _.assert( junction2.peer === junction || junction2.peer === null );
      _.assert( !junction.isFinited() );
      _.assert( !junction2.isFinited() );
      junction.peer = junction2;
      junction2.peer = junction;
      return;
    }
  }

  /* */

  function peerForm()
  {

    junction.openers.forEach( ( object ) => peerFrom( object ) );
    junction.modules.forEach( ( object ) => peerFrom( object ) );

    if( !junction.peer )
    junction.modules.forEach( ( object ) => peerFromModule( object ) );

  }

  /* */

  function nameForm()
  {
    if( junction.object )
    junction.name = junction.object.absoluteName;
    else if( junction.peer )
    junction.name = junction.peer.name + ' / f::peer';
  }

  /* */

  function isOutForm()
  {
    if( junction.object && _.boolLike( junction.object.isOut ) )
    junction.isOut = !!junction.object.isOut;
    else if( junction.peer && junction.peer.object && _.boolLike( junction.peer.object.isOut ) )
    junction.isOut = !junction.peer.object.isOut;
    else
    junction.isOut = _.will.filePathIsOut( junction.localPath || junction.remotePath );
  }

  /* */

}

//

function mergeIn( junction2 )
{
  let junction = this;
  let will = junction.will;
  let objects = [];

  _.assert( !junction.isFinited() );
  _.assert( !junction2.isFinited() );
  _.assert( arguments.length === 1 );

  /* xxx : use junction.objects */
  junction.relations.slice().forEach( ( object ) => objects.push( object ) );
  junction.openers.slice().forEach( ( object ) => objects.push( object ) );
  junction.modules.slice().forEach( ( object ) => objects.push( object ) );

  objects.forEach( ( object ) => junction._remove( object ) );
  objects.forEach( ( object ) => junction2._add( object ) );

  if( junction.peer )
  {
    let peer = junction.peer;
    _.assert( !peer.isFinited() );
    junction.peer = null;
    peer.peer = null;

    if( junction2.peer === null )
    {
      junction2.peer = peer;
      peer.peer = junction2;
    }
    else
    {
      peer.mergeIn( junction2.peer );
      _.assert( peer.isFinited() );
      _.assert( peer.peer === null );
    }

  }

  _.assert( !junction.isFinited() );
  _.assert( !junction2.isFinited() );

  junction.reform();

  if( junction.ownSomething() )
  {
    _.assert( 'not tested' );
  }
  else
  {
    if( !junction.isFinited() )
    junction.finit();
  }

  _.assert( junction.isFinited() );
  _.assert( !junction2.isFinited() );

  junction2.reform();

  if( junction.isFinited() )
  return true;
  return false;
}

//

function mergeMaybe( usingPath )
{
  let junction = this;
  let will = junction.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let junction2, reset;

  _.assert( arguments.length === 1 );

  let merged = merge();

  if( reset )
  merge();

  if( !merged && usingPath )
  {

    junction.localPaths.every( ( localPath ) =>
    {
      let junction3 = will.junctionMap[ localPath ];
      if( junction3 && junction3 !== junction )
      {
        junction.mergeIn( junction3 );
        return false;
      }
      return true;
    });

    junction.remotePaths.every( ( remotePath ) =>
    {
      let junction3 = will.junctionMap[ remotePath ];
      if( junction3 && junction3 !== junction )
      {
        junction.mergeIn( junction3 );
        return false;
      }
      return true;
    });

  }

  _.assert( !reset );
  _.assert( !junction2 || !junction2.isFinited() );

  if( !junction.isFinited() )
  junction.assertIntegrityVerify();
  if( junction2 && !junction2.isFinited() )
  junction2.assertIntegrityVerify();

  return junction2 || false;

  /* */

  function merge()
  {
    reset = false;

    if( objectsMergeMaybe( junction.modules ) )
    return junction2;

    if( objectsMergeMaybe( junction.openers ) )
    return junction2;

    if( objectsMergeMaybe( junction.relations ) )
    return junction2;

    if( objectsMergeMaybe( junction.AssociationsOf( junction.modules ) ) )
    return junction2;

    if( objectsMergeMaybe( junction.AssociationsOf( junction.openers ) ) )
    return junction2;

    if( objectsMergeMaybe( junction.AssociationsOf( junction.relations ) ) )
    return junction2;

    return false;
  }


  /* */

  function objectsMergeMaybe( objects )
  {
    _.any( objects, ( object ) =>
    {
      junction2 = objectMergeMaybe( object );
      if( junction2 )
      return junction2;
    });
    return junction2;
  }

  /* */

  function objectMergeMaybe( object )
  {
    let localPath, remotePath;

    [ localPath, remotePath ] = junction.PathsOf( object );

    if( localPath )
    {

      let junction2 = will.junctionMap[ localPath ];
      if( junction2 && junction2 !== junction )
      {
        if( junction.mergeIn( junction2 ) )
        return junction2;
        return junction2;
      }

    }

    if( remotePath )
    {

      let junction2 = will.junctionMap[ remotePath ];
      if( junction2 && junction2 !== junction )
      {
        if( junction.mergeIn( junction2 ) )
        return junction2;
        return junction2;
      }

    }

    {
      let junction3 = will.objectToJunctionHash.get( object );
      if( junction3 && junction3 !== junction )
      {
        _.assert( 0, 'not tested' );
        reset = 1;
        junction3.mergeIn( junction );
        return junction3;
      }
    }

  }

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
    result.push( localPath );
    result.push( remotePath );
  }
  else if( object instanceof _.will.Module )
  {
    let localPath = object.localPath || object.commonPath;
    let remotePath = object.remotePath;
    result.push( localPath );
    result.push( remotePath );
  }
  else if( object instanceof _.will.ModuleOpener )
  {
    let localPath = object.localPath || object.commonPath;
    let remotePath = object.remotePath;
    result.push( localPath );
    result.push( remotePath );
  }
  else if( object instanceof _.will.ModulesRelation )
  {
    let localPath = object.localPath;
    let remotePath = object.remotePath;
    result.push( localPath );
    result.push( remotePath );
  }
  else _.assert( 0 );

  /* xxx */
  if( result[ 1 ] && _.strHas( result[ 1 ], 'hd://.' ) )
  result[ 1 ] = null;

  return result;
}

//

function PathsOfAsMap( object )
{
  let result = Object.create( null );

  _.assert( !!object );

  if( object instanceof Self )
  {
    result.localPath = object.localPath;
    result.remotePath = object.remotePath;
  }
  else if( object instanceof _.will.Module )
  {
    result.localPath = object.localPath || object.commonPath;
    result.remotePath = object.remotePath;
  }
  else if( object instanceof _.will.ModuleOpener )
  {
    result.localPath = object.localPath || object.commonPath;
    result.remotePath = object.remotePath;
  }
  else if( object instanceof _.will.ModulesRelation )
  {
    result.localPath = object.localPath;
    result.remotePath = object.remotePath;
  }
  else _.assert( 0 );

  return result;
}

//

function _From( o )
{
  let cls = this;
  let junction;
  let will = o.will;
  let junctionMap = will.junctionMap;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.transaction.logger;
  let made = false;
  let changed = false;

  _.assert( arguments.length === 1 );
  _.assert( _.mapIs( o ) );
  _.assert( _.mapIs( junctionMap ) );

  if( !o.object )
  o.object = o.module || o.opener || o.relation;

  if( o.object && o.object instanceof Self )
  {
    junction = o.object;
    return junction;
  }
  else if( _.mapIs( o.object ) )
  {
    junction = Self( o.object );
  }
  else
  {
    junction = will.objectToJunctionHash.get( o.object );
    if( junction )
    {
      return junction;
    }
  }

  if( !junction )
  junctionWithPath();

  _.assert
  (
    !o.relation || ( !!o.relation.opener && o.relation.opener.formed >= 2 ),
    () => `Opener should be formed to level 2 or higher, but opener of ${o.relation.absoluteName} is not`
  )

  if( junction )
  junctionUpdate();

  if( !junction )
  {
    made = true;
    changed = true;
    junction = Self( o );
  }

  if( junction.formed !== -1 )
  junction = junction.reform();

  _.assert( !junction || !junction.isFinited() );

  return junction;

  /* */

  function junctionUpdate()
  {

    if( o.object && o.object !== junction )
    if( !junction.own( o.object ) )
    changed = junction._add( o.object ) || changed;
    if( o.module )
    if( !junction.own( o.module ) )
    changed = junction._add( o.module ) || changed;
    if( o.opener )
    if( !junction.own( o.opener ) )
    changed = junction._add( o.opener ) || changed;
    if( o.relation )
    if( !junction.own( o.relation ) )
    changed = junction._add( o.relation ) || changed;

    delete o.object;
    delete o.module;
    delete o.opener;
    delete o.relation;

    for( let f in o )
    {
      if( junction[ f ] !== o[ f ] )
      {
        _.assert( 0, 'not tested' );
        junction[ f ] = o[ f ];
        changed = true;
      }
    }

  }

  /* */

  function junctionWithPath()
  {
    let localPath, remotePath;

    [ localPath, remotePath ] = cls.PathsOf( o.object );

    if( junctionMap && junctionMap[ localPath ] )
    junction = junctionMap[ localPath ];
    else if( junctionMap && remotePath && junctionMap[ remotePath ] )
    junction = junctionMap[ remotePath ];

  }

  /* */

}

//

function Reform( object, will )
{
  let cls = this;
  let result;

  _.assert( arguments.length === 2 );

  let o = object;
  if( !_.mapIs( o ) )
  o = { object }
  if( !o.will )
  o.will = will;

  let junction = cls._Of( o );
  if( junction )
  {
    junction.reform();
    return junction;
  }

  result = cls._From( o );

  return result;
}

//

function Reforms( junctions, will )
{
  let cls = this;
  _.assert( arguments.length === 2 );
  if( _.argumentsArray.like( junctions ) )
  return _.filter_( null, junctions, ( junction ) => cls.Reform( junction, will ) );
  else
  return cls.Reform( junctions, will );
}

//

function JunctionFrom( object, will )
{
  let cls = this;

  let o = object;
  if( !_.mapIs( o ) )
  o = { object }
  if( !o.will )
  o.will = will;

  _.assert( arguments.length === 2 );

  let junction = cls._Of( o );

  if( junction )
  {
    junction.assertIntegrityVerify();
    junction.assertObjectRelationVerify( o.object );
    return junction;
  }

  junction = cls._From( o );

  return junction;
}

//

function JunctionsFrom( junctions, will )
{
  let cls = this;
  _.assert( arguments.length === 2 );
  if( _.argumentsArray.like( junctions ) )
  return _.filter_( null, junctions, ( junction ) => cls.JunctionFrom( junction, will ) );
  else
  return cls.JunctionFrom( junctions, will );
}

//

function _Of( o )
{
  let cls = this;

  _.routine.assertOptions( _Of, arguments );
  _.assert( arguments.length === 1 );
  _.assert( !!o.object );

  let junction = o.will.objectToJunctionHash.get( o.object );

  // if( junction )
  // {
  //   // junction.assertIntegrityVerify();
  //   // junction.assertObjectRelationVerify( o.object );
  // }

  return junction;
}

_Of.defaults =
{
  will : null,
  object : null,
}

//

function Of( object, will )
{
  let cls = this;

  _.assert( arguments.length === 2 );

  let o = object;
  if( !_.mapIs( o ) )
  o = { object }
  if( !o.will )
  o.will = will;

  let junction = cls._Of( o );

  if( junction )
  {
    junction.assertIntegrityVerify();
    junction.assertObjectRelationVerify( o.object );
  }

  return junction;
}

//

function Ofs( junctions, will )
{
  let cls = this;
  _.assert( arguments.length === 2 );
  if( _.argumentsArray.like( junctions ) )
  return _.filter_( null, junctions, ( junction ) => cls.Of( junction, will ) );
  else
  return cls.Of( junctions, will );
}

//

function AssociationsOf( object )
{
  let cls = this;

  if( _.arrayIs( object ) )
  return _.longOnce( _.arrayFlatten( object.map( ( object ) => cls.AssociationsOf( object ) ) ) );

  let result = [];
  if( object instanceof _.will.Module )
  {
    return _.each( object.userArray, ( opener ) =>
    {
      if( opener instanceof _.will.ModuleOpener )
      result.push( opener );
    });
  }
  else if( object instanceof _.will.ModuleOpener )
  {
    if( object.openedModule )
    result.push( object.openedModule );
    if( object.superRelation )
    result.push( object.superRelation );
  }
  else if( object instanceof _.will.ModulesRelation )
  {
    if( object.opener )
    result.push( object.opener );
    if( object.opener && object.opener.openedModule )
    result.push( object.opener.openedModule );
  }
  else _.assert( 0 );

  return result;
}

//

function AssociationsAliveOf( object )
{
  let cls = this;
  let result = cls.AssociationsOf( object );

  if( _.arrayIs( result ) )
  return _.filter_( null, result, ( association ) =>
  {
    return association.isAliveGet() ? association : undefined;
  });

  if( result.isAliveGet() )
  return result;

}

//

function ObjectToOptionsMap( o )
{
  if( _.mapIs( o ) )
  return o;
  if( o instanceof _.will.Module )
  {
    return { module : o }
  }
  else if( o instanceof _.will.ModuleOpener )
  {
    return { opener : o }
  }
  else if( o instanceof _.will.ModulesRelation )
  {
    return { relation : o }
  }
  else _.assert( 0 );
}

//

function _relationAdd( relation )
{
  let junction = this;
  let will = junction.will;
  let changed = false;

  _.assert( relation instanceof _.will.ModulesRelation );
  if( !relation.isAliveGet() ) /* yyy */
  {
    return false
  }
  // if( _.longHas( junction.relations, relation ) ) /* xxx */
  // {
  //   _.assert( will.objectToJunctionHash.get( relation ) === junction );
  //   return changed;
  // }

  if( !junction.relation )
  {
    junction.relation = relation;
    changed = true;
  }

  changed = _.arrayAppendedOnce( junction.relations, relation ) > -1 || changed;

  let junction2 = will.objectToJunctionHash.get( relation );
  _.assert( junction.formed === -1 || junction2 === junction || junction2 === undefined );
  will.objectToJunctionHash.set( relation, junction );

  _.assert
  (
    junction.formed === -1
    || changed
    || _.all( junction.PathsOf( relation ),
      ( path ) => will.junctionMap[ path ] === undefined || will.junctionMap[ path ] === junction )
  );

  return changed;
}

//

function _relationRemoveSingle( relation )
{
  let junction = this;
  let will = junction.will;

  _.assert( relation instanceof _.will.ModulesRelation );
  _.arrayRemoveOnce( junction.relations, relation );

  if( junction.relation === relation )
  junction.relation = null;
  if( junction.object === relation )
  junction.object = null;

  if( !junction.relation && junction.relations.length )
  junction.relation = junction.relations[ 0 ];

  let junction2 = will.objectToJunctionHash.get( relation );
  _.assert( junction2 === junction );
  will.objectToJunctionHash.delete( relation );

  return true;
}

//

function _relationRemove( relation )
{
  let junction = this;
  let will = junction.will;

  if( !_.longHas( junction.relations, relation ) )
  return false;

  junction._relationRemoveSingle( relation );

  // junction._remove( junction.AssociationsOf( relation ) ); // yyy
  return true;
}

//

function _openerAdd( opener )
{
  let junction = this;
  let will = junction.will;
  let changed = false;

  _.assert( opener instanceof _.will.ModuleOpener );
  if( !opener.isAliveGet() ) /* yyy */
  {
    return false
  }
  // if( _.longHas( junction.openers, opener ) ) /* xxx */
  // {
  //   _.assert( will.objectToJunctionHash.get( opener ) === junction );
  //   return changed;
  // }

  if( !junction.opener )
  {
    junction.opener = opener;
    changed = true;
  }

  changed = _.arrayAppendedOnce( junction.openers, opener ) > -1 || changed;

  if( Config.debug )
  {
    let junction2 = will.objectToJunctionHash.get( opener );
    _.assert( junction.formed === -1 || junction2 === junction || junction2 === undefined );
    will.objectToJunctionHash.set( opener, junction );
    _.assert
    (
      junction.formed === -1
      || changed
      || _.all( junction.PathsOf( opener ),
        ( path ) => will.junctionMap[ path ] === undefined || will.junctionMap[ path ] === junction )
    );
  }
  else
  {
    will.objectToJunctionHash.set( opener, junction );
  }

  return changed;
}

//

function _openerRemoveSingle( opener )
{
  let junction = this;
  let will = junction.will;

  _.assert( opener instanceof _.will.ModuleOpener );
  _.arrayRemoveOnceStrictly( junction.openers, opener );

  if( junction.opener === opener )
  junction.opener = null;
  if( junction.object === opener )
  junction.object = null;

  if( !junction.opener && junction.openers.length )
  junction.opener = junction.openers[ 0 ];

  let junction2 = will.objectToJunctionHash.get( opener );
  _.assert( junction2 === junction );
  will.objectToJunctionHash.delete( opener );

  // console.log( ` !! removed opener#${opener.id} ${opener.commonPath}` );

}

//

function _openerRemove( opener )
{
  let junction = this;
  let will = junction.will;

  if( !_.longHas( junction.openers, opener ) )
  return false;

  junction._openerRemoveSingle( opener );

  // junction._remove( junction.AssociationsOf( opener ) ); // yyy
  return true;
}

//

function _moduleAdd( module )
{
  let junction = this;
  let will = junction.will;
  let changed = false;

  _.assert( module instanceof _.will.Module );
  if( !module.isAliveGet() ) /* yyy */
  {
    // debugger; /* xxx : enter? */
    return false
  }
  // if( _.longHas( junction.modules, module ) ) /* xxx */
  // {
  //   _.assert( will.objectToJunctionHash.get( module ) === junction );
  //   return changed;
  // }

  if( !junction.module )
  {
    junction.module = module;
    changed = true;
  }

  changed = _.arrayAppendedOnce( junction.modules, module ) > -1 || changed;

  let junction2 = will.objectToJunctionHash.get( module );
  _.assert( junction2 === junction || junction2 === undefined, 'Module can belong only to one junction' );
  will.objectToJunctionHash.set( module, junction );

  _.assert
  (
    junction.formed === -1
    || changed
    || _.all( junction.PathsOf( module ),
      ( path ) => will.junctionMap[ path ] === undefined || will.junctionMap[ path ] === junction )
  );

  return changed;
}

//

function _moduleRemoveSingle( module )
{
  let junction = this;
  let will = junction.will;

  _.assert( module instanceof _.will.Module );
  _.arrayRemoveOnceStrictly( junction.modules, module );

  if( junction.module === module )
  junction.module = null;
  if( junction.object === module )
  junction.object = null;

  if( !junction.module && junction.modules.length )
  junction.module = junction.modules[ 0 ];

  let junction2 = will.objectToJunctionHash.get( module );
  _.assert( junction2 === junction );

  will.objectToJunctionHash.delete( module );

}

//

function _moduleRemove( module )
{
  let junction = this;
  let will = junction.will;

  if( !_.longHas( junction.modules, module ) )
  return false;

  junction._moduleRemoveSingle( module );

  // junction._remove( junction.AssociationsOf( module ) ); // yyy
  return true;
}

//

function _add( object )
{
  let junction = this;
  let result;

  if( _.arrayIs( object ) )
  return _.any( _.container.map_( null, object, ( object ) => junction._add( object ) ) );

  // _.assert( _.numberIs( object.formed ) ); /* yyy */
  // if( object.formed <= 0 )
  // {
  //   return false
  // }

  if( object instanceof _.will.ModulesRelation )
  {
    result = junction._relationAdd( object );
  }
  else if( object instanceof _.will.Module )
  {
    result = junction._moduleAdd( object );
  }
  else if( object instanceof _.will.ModuleOpener )
  {
    result = junction._openerAdd( object );
  }
  else _.assert( 0, `Unknown type of object ${_.entity.strType( object )}` );

  return result;
}

//

function add( object )
{
  let junction = this;
  let result = junction._add( object );
  junction.reform();
  return result;
}

//

function _remove( object )
{
  let junction = this;

  if( _.arrayIs( object ) )
  return _.any( _.container.map_( null, object, ( object ) => junction._remove( object ) ) );

  if( object instanceof _.will.ModulesRelation )
  {
    return junction._relationRemove( object );
  }
  else if( object instanceof _.will.Module )
  {
    return junction._moduleRemove( object );
  }
  else if( object instanceof _.will.ModuleOpener )
  {
    return junction._openerRemove( object );
  }
  else _.assert( 0 );

}

//

function remove( object )
{
  let junction = this;
  junction._remove( object );
  return junction.reform();
}

//

function own( object )
{
  let junction = this;

  _.assert( arguments.length === 1 );

  if( object instanceof _.will.Module )
  {
    return _.longHas( junction.modules, object );
  }
  else if( object instanceof _.will.ModuleOpener )
  {
    return _.longHas( junction.openers, object );
  }
  else if( object instanceof _.will.ModulesRelation )
  {
    return _.longHas( junction.relations, object );
  }
  else _.assert( 0 );

}

//

function ownSomething()
{
  let junction = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  if( junction.modules.length )
  return true;
  if( junction.openers.length )
  return true;
  if( junction.relations.length )
  return true;

  return false;
}

//

function isUsed()
{
  let junction = this;

  _.assert( arguments.length === 0, 'Expects no arguments' );

  if( junction.ownSomething() )
  return true;

  if( junction.peer )
  if( junction.peer.ownSomething() )
  return true;

  return false;
}

//

function submodulesJunctionsFilter( o )
{
  let junction = this;
  let will = junction.will;
  let result = [];

  o = _.routine.options_( submodulesJunctionsFilter, arguments );

  let filter = _.mapOnly_( null, o, will.relationFit.defaults );

  junctionLook( junction );

  if( !junction.peer )
  if( junction.module && junction.module.peerModule )
  {
    junction._From
    ({
      module : junction.module.peerModule,
      will,
    });
    _.assert( _.longHas( junction.peer.modules, junction.module.peerModule ) );
  }

  if( o.withPeers )
  if( junction.peer )
  junctionLook( junction.peer );

  if( o.withoutDuplicates )
  result = result.filter( ( junction ) =>
  {
    return !junction.isOut || !_.longHas( result, junction.peer );
  });

  return result;

  /* */

  function junctionLook( junction )
  {

    junction.modules.forEach( ( module ) =>
    {
      for( let s in module.submoduleMap )
      {
        let relation = module.submoduleMap[ s ];

        let junction2 = junction._From({ relation, will });
        _.assert( !!junction2 );

        if( !junction2.peer )
        if( junction2.module && junction2.module.peerModule )
        {
          _.assert( 0, 'not tested' );
          junction2._From
          ({
            module : junction2.module.peerModule,
            will,
          });
        }

        /*
        getting shadow sould go after setting up junction
        */

        junctionAppendMaybe( junction2 );

        if( o.withPeers )
        if( junction2.peer )
        junctionAppendMaybe( junction2.peer );

      }
    });

  }

  /* */

  function junctionAppendMaybe( junction )
  {

    if( !will.relationFit( junction, filter ) )
    return;

    _.assert( junction instanceof _.will.ModuleJunction );
    _.arrayAppendOnce( result, junction );

  }

  /* */

}

submodulesJunctionsFilter.defaults =
{

  ... _.Will.RelationFilterDefaults,
  withPeers : 1,
  withoutDuplicates : 0,

}

//

// function shadow( o )
// {
//   let junction = this;
//   let will = junction.will;
//
//   if( !_.mapIs( o ) )
//   o = junction.ObjectToOptionsMap( o );
//
//   o = _.routine.options_( shadow, o );
//   _.assert( arguments.length === 1 );
//
//   let shadowMap = _.props.extend( null, o );
//   shadowMap.localPath = _.unknown;
//   shadowMap.remotePath = _.unknown;
//
//   let shadowProxy = _.proxyShadow
//   ({
//     back : junction,
//     front : shadowMap,
//   });
//
//   pathsDeduce();
//   peerDeduce();
//   associationsFill();
//   peerDeduce();
//   pathsDeduce();
//
//   for( let s in shadowMap )
//   if( shadowMap[ s ] === _.unknown )
//   delete shadowMap[ s ];
//
//   return shadowProxy;
//
//   function associationsFill()
//   {
//     if( defined( shadowMap.module ) )
//     objectAssociationsAppend( shadowMap.module );
//     if( defined( shadowMap.opener ) )
//     objectAssociationsAppend( shadowMap.opener );
//     if( defined( shadowMap.relation ) )
//     objectAssociationsAppend( shadowMap.relation );
//   }
//
//   function objectAssociationsAppend( object )
//   {
//     junction.AssociationsOf( object ).forEach( ( object ) =>
//     {
//       if( object instanceof _.will.Module )
//       {
//         if( shadowMap.module === _.unknown )
//         shadowMap.module = object;
//       }
//       else if( object instanceof _.will.ModuleOpener )
//       {
//         if( shadowMap.opener === _.unknown )
//         shadowMap.opener = object;
//       }
//       else if( object instanceof _.will.ModulesRelation )
//       {
//         if( shadowMap.relation === _.unknown )
//         shadowMap.relation = object;
//       }
//       else _.assert( 0 );
//     });
//   }
//
//   function pathsFrom( object )
//   {
//     let paths = junction.PathsOfAsMap( object );
//     if( paths.localPath && shadowMap.localPath === _.unknown )
//     shadowMap.localPath = paths.localPath;
//     if( paths.remotePath && shadowMap.remotePath === _.unknown )
//     shadowMap.remotePath = paths.remotePath;
//   }
//
//   function pathsDeduce()
//   {
//     if( shadowMap.localPath !== _.unknown && shadowMap.remotePath !== _.unknown )
//     return true;
//     if( defined( shadowMap.module ) )
//     pathsFrom( shadowMap.module );
//     if( shadowMap.localPath !== _.unknown && shadowMap.remotePath !== _.unknown )
//     return true;
//     if( defined( shadowMap.opener ) )
//     pathsFrom( shadowMap.opener );
//     if( shadowMap.localPath !== _.unknown && shadowMap.remotePath !== _.unknown )
//     return true;
//     if( defined( shadowMap.relation ) )
//     pathsFrom( shadowMap.relation );
//     if( shadowMap.localPath !== _.unknown && shadowMap.remotePath !== _.unknown )
//     return true;
//     return false;
//   }
//
//   function peerDeduce()
//   {
//     if( shadowMap.peer !== _.unknown )
//     return true;
//
//     if( shadowMap.module && shadowMap.module.peerModule )
//     peerFrom( shadowMap.module.peerModule );
//     else if( shadowMap.opener && shadowMap.opener.peerModule )
//     peerFrom( shadowMap.opener.peerModule );
//
//     if( shadowMap.peer !== _.unknown )
//     return true;
//     return false;
//   }
//
//   function peerFrom( peerModule )
//   {
//     _.assert( peerModule instanceof _.will.Module );
//     _.assert( shadowMap.peer === _.unknown );
//     shadowMap.peer = junction.Of( peerModule, will );
//     if( !shadowMap.peer )
//     shadowMap.peer = junction.JunctionFrom( peerModule, will );
//     shadowMap.peer = shadowMap.peer.shadow({ module : peerModule, peer : shadowProxy });
//   }
//
//   function defined( val )
//   {
//     return !!val && ( val !== _.unknown );
//   }
//
// }
//
// shadow.defaults =
// {
//   module : _.unknown,
//   relation : _.unknown,
//   opener : _.unknown,
//   peer : _.unknown,
// }

//

function assertObjectRelationVerify( object )
{
  let junction = this;
  let will = junction.will;
  let objects = junction.objects;

  if( !Config.debug )
  return true;

  let paths = junction.PathsOf( object );
  let junction2 = _.any( paths, ( path ) => will.junctionMap[ path ] );
  if( junction2 )
  _.assert
  (
    junction2.formed !== 1
    || _.all( paths, ( path ) => will.junctionMap[ path ] === undefined || will.junctionMap[ path ] === junction2 )
  );
  _.assert( junction === junction2 || !junction2 || !junction2.ownSomething() );
  _.assert( arguments.length === 1 );

  return true;
}

//

function assertIntegrityVerify()
{
  let junction = this;
  let will = junction.will;
  let objects = junction.objects;

  if( !Config.debug )
  return true;

  objects.forEach( ( object ) =>
  {
    _.assert
    (
      will.objectToJunctionHash.get( object ) === junction,
      () => `Integrity of ${junction.nameWithLocationGet()} is broken. Another junction has this object.`
    );
    _.assert
    (
      _.longHasAll( objects, junction.AssociationsAliveOf( object ) ),
      () => `Integrity of ${junction.nameWithLocationGet()} is broken. One or several associations are no in the list.`
    );
    let p = junction.PathsOfAsMap( object );
    _.assert
    (
      !p.localPath || _.longHas( junction.localPaths, p.localPath ),
      () => `Integrity of ${junction.nameWithLocationGet()} is broken.`
          + `\nLocal path ${_.ct.format( p.localPath, 'path' )} is not in the list.`
          + `\n  ` + _.ct.format( junction.localPaths, 'path' ).join( '\n  ' )
    );
    _.assert
    (
      !p.remotePath || _.longHas( junction.remotePaths, p.remotePath ),
      () => `Integrity of ${junction.nameWithLocationGet()} is broken.`
          + `\nRemote path ${_.ct.format( p.remotePath, 'path' )} is not in the list.`
          + `\n  ` + _.ct.format( junction.remotePaths, 'path' ).join( '\n  ' )
    );
  });

  _.assert( arguments.length === 0 );

  return true;
}

// --
// coercer
// --

function toModuleForResolver()
{
  let junction = this;
  return junction.module;
}

//

function toModule()
{
  let junction = this;
  return junction.module;
}

//

function toOpener()
{
  let junction = this;
  return junction.opener;
}

//

function toRelation()
{
  let junction = this;
  return junction.relation;
}

//

function toJunction()
{
  let junction = this;
  return junction;
}

// --
// export
// --

function exportString()
{
  let result = '';
  let junction = this;

  result += `junction:: : #${junction.id}\n`;

  let lpl = ' ';
  if( junction.localPaths.length > 1 )
  lpl = ` ( ${junction.localPaths.length} ) `;
  if( junction.localPath )
  result += `  path::local${lpl}: ${junction.localPath}\n`;

  let rpl = ' ';
  if( junction.remotePaths.length > 1 )
  rpl = ` ( ${junction.remotePaths.length} ) `;
  if( junction.remotePath )
  result += `  path::remote${rpl}: ${junction.remotePath}\n`;

  if( junction.modules.length )
  {
    result += '  ' + junction.module.absoluteName + ' #' + junction.modules.map( ( m ) => m.id ).join( ' #' ) + '\n';
  }
  if( junction.opener )
  {
    result += '  ' + junction.opener.absoluteName + ' #' + junction.openers.map( ( m ) => m.id ).join( ' #' ) + '\n';
  }
  if( junction.relation )
  {
    result += '  ' + junction.relation.absoluteName + ' #' + junction.relations.map( ( m ) => m.id ).join( ' #' ) + '\n';
  }
  if( junction.peer )
  {
    result += `  peer::junction : #${junction.peer.id}\n`;
  }

  return result;
}

//

function nameWithLocationGet()
{
  let junction = this;
  let name = ( junction.object ? junction.object.qualifiedName : junction.name ) || junction.name;
  name = _.color.strFormat( name, 'entity' );
  let localPath = _.color.strFormat( junction.localPath, 'path' );
  let result = `${name} at ${localPath}`;
  return result;
}

//

function qualifiedNameGet()
{
  let junction = this;
  let name = junction.name;
  return `junction::( ${name} )`;
}

// --
// accessor
// --

function moduleSet( module )
{
  let junction = this;
  junction[ moduleSymbol ] = module;
  return module;
}

//

function dirPathGet()
{
  let junction = this;
  if( !junction.localPath )
  return null;
  let will = junction.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.detrail( path.dirFirst( junction.localPath ) );
}

//

function enabledGet()
{
  let junction = this;
  let result = null;

  if( junction.module )
  result = junction.module.about.enabled;
  else if( junction.peer && junction.peer.module )
  result = junction.peer.module.enabled;

  _.assert( result === null || _.boolIs( result ) );
  return result;
}

//

function isRemoteGet()
{
  let junction = this;
  let result = null;

  if( junction.module && junction.module.repo )
  result = junction.module.repo.isRemote;
  else if( junction.opener && junction.opener.repo )
  result = junction.opener.repo.isRemote;
  else if( junction.peer && junction.peer.module && junction.peer.module.repo )
  result = junction.peer.module.repo.isRemote;
  else if( junction.peer && junction.peer.opener && junction.peer.opener.repo )
  result = junction.peer.opener.repo.isRemote;

  _.assert( result === null || _.boolIs( result ) );
  return result;
}

//

function objectsGet()
{
  let junction = this;
  let result = [];

  _.each( junction.modules, ( module ) => result.push( module ) );
  _.each( junction.openers, ( opener ) => result.push( opener ) );
  _.each( junction.relations, ( relation ) => result.push( relation ) );

  return result;
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

  will : null,

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

  name : null,
  id : null,
  isOut : null,
  formed : 0,

  localPath : null,
  localPaths : _.define.own([]),
  remotePath : null,
  remotePaths : _.define.own([]),

  module : null,
  modules : _.define.own([]),
  opener : null,
  openers : _.define.own([]),
  relation : null,
  relations : _.define.own([]),
  object : null,
  peer : null,

}

let Statics =
{
  PathsOf,
  PathsOfAsMap,
  _From,
  Reform,
  Reforms,
  JunctionFrom, /* rename to From? */
  JunctionsFrom,
  _Of,
  Of,
  Ofs,
  AssociationsOf,
  AssociationsAliveOf,
  ObjectToOptionsMap,
}

let Forbids =
{
  recordsMap : 'recordsMap',
  commonPath : 'commonPath',
  nodesGroup : 'nodesGroup',
  junctionMap : 'junctionMap',
}

let Accessors =
{

  dirPath : { get : dirPathGet, writable : 0 },
  enabled : { get : enabledGet, writable : 0 },
  isRemote : { get : isRemoteGet, writable : 0 },
  objects : { get : objectsGet, writable : 0 },

  qualifiedName : { get : qualifiedNameGet, writable : 0 },
  __ : { get : _.accessor.getter.withSymbol, writable : 0, strict : 0 },

}

// --
// declare
// --

let Extension =
{

  // inter

  finit,
  init,
  reform,
  mergeIn,
  mergeMaybe,

  PathsOf,
  PathsOfAsMap,
  _From,
  Reform,
  Reforms,
  JunctionFrom,
  JunctionsFrom,
  _Of,
  Of,
  Ofs,
  AssociationsOf,
  AssociationsAliveOf,
  ObjectToOptionsMap,

  _relationAdd,
  _relationRemoveSingle,
  _relationRemove,
  _openerAdd,
  _openerRemoveSingle,
  _openerRemove,
  _moduleAdd,
  _moduleRemoveSingle,
  _moduleRemove,

  _add,
  add,
  _remove,
  remove,
  own,
  ownSomething,
  isUsed,
  submodulesJunctionsFilter,
  // shadow,
  assertObjectRelationVerify,
  assertIntegrityVerify,

  // coercer

  toModuleForResolver,
  toModule,
  toOpener,
  toRelation,
  toJunction,

  // export

  exportString,
  nameWithLocationGet,
  qualifiedNameGet,

  // accessor

  moduleSet,
  dirPathGet,
  enabledGet,
  isRemoteGet,
  objectsGet,

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
  extend : Extension,
});

_.Copyable.mixin( Self );
_.will[ Self.shortName ] = Self;

})();
