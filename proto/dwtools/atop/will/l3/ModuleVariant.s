( function _ModuleVariant_s_( ) {

'use strict';

if( typeof variant !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = _global_.wTools;
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

  _.each( variant.modules, ( module ) => variant._moduleRemove( module ) );
  _.each( variant.openers, ( opener ) => variant._moduleRemove( opener ) );
  _.each( variant.relations, ( relation ) => variant._moduleRemove( relation ) );

  _.assert( variant.module === null );
  _.assert( variant.opener === null );
  _.assert( variant.relation === null );
  _.assert( variant.object === null );

  if( variant.peer )
  {
    let peer = variant.peer;
    _.assert( variant.peer.peer === variant )
    peer.peer = null;
    variant.peer = null;
    if( !peer.isUsed() )
    peer.finit();
  }

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
  variant._moduleAdd( o.module );
  if( o.opener )
  variant._openerAdd( o.opener );
  if( o.relation )
  variant._relationAdd( o.relation );
  if( o.object )
  variant._add( o.object );

  return variant;
}

//

function reform()
{
  let variant = this;
  let will = variant.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  // let remotePaths = [];

  if( variant.formed === -1 )
  return;

  // if( variant )
  // logger.log( `Reforming variant::${variant.name}#${variant.id} at ${variant.localPath}` );
  // if( variant.id === 109 )
  // debugger;

  variant.formed = -1;

  _.assert( !variant.finitedIs() );

  // if( variant.id === 83 || variant.id === 259 )
  // if( variant.id === 83 )
  // if( variant.id === 83 || variant.id === 129 )
  // if( variant.id === 209 || variant.id === 259 )
  // if( variant.id === 209 )
  // {
  //   logger.log( '>', variant.exportInfo() );
  //   debugger;
  // }

  // if( !variant.opener && !variant.module && !variant.relation )
  // debugger;

  if( variant.finitedIs() )
  return;

  // if( variant.module && variant.opener && variant.peer )
  // if( variant.id === 583 )
  // debugger;

  // if( variant.id === 282 )
  // {
  //   logger.log( variant.exportInfo() );
  //   debugger;
  // }

  // if( variant.id === 3 && will.variantWithId( 1722 ) )
  // debugger;
  //
  // variant.mergeMaybe();
  // _.assert( !variant.finitedIs() );
  // if( !variant.isUsed() )
  // {
  //   variant.finit();
  //   return false;
  // }

  // {
  //   let variant2 = variant.mergeMaybe();
  //   if( variant2 )
  //   return variant2;
  // }

  associationsAdd();
  objectFind();

  // {
  //   let variant2 = variant.mergeMaybe();
  //   if( variant2 )
  //   return variant2;
  // }

  // if( variant.id === 83 && !variant.ownSomething() )
  // debugger;

  pathsForm();

  // if( variant.id === 3 && will.variantWithId( 1722 ) )
  // debugger;

  variant.mergeMaybe();
  // _.assert( !variant.finitedIs() );
  if( variant.finitedIs() )
  {
    return false;
  }
  if( !variant.isUsed() )
  {
    variant.finit();
    return false;
  }

  verify();
  register();
  peerForm();
  nameForm();
  isOutForm();

  variant.formed = 1;
  return variant;

  /* */

  function pathAdd( object )
  {
    let localPath, remotePath;
    [ localPath, remotePath ] = variant.PathsOf( object );

    if( localPath )
    {
      _.arrayAppendOnce( variant.localPaths, localPath );
      if( variant.localPath === null )
      variant.localPath = localPath;
    }

    if( remotePath )
    {
      _.arrayAppendOnce( variant.remotePaths, remotePath );
      variant.remotePath = remotePath;
      // _.assert( variant.remotePaths.length <= 1, `Remote paths collision: ${variant.remotePaths.join( ' ' )}` );
    }

  }

  /* */

  function pathFromPeerAdd( object )
  {

    let localPath = object.peerLocalPathGet();
    if( localPath )
    _.arrayAppendOnce( variant.localPaths, localPath );
    if( variant.localPath === null )
    variant.localPath = localPath;
    _.assert( localPath === null || _.strIs( localPath ) );

    let remotePath = object.peerRemotePathGet();
    if( remotePath )
    _.arrayAppendOnce( variant.remotePaths, remotePath );
    if( variant.remotePath === null )
    variant.remotePath = remotePath;
    _.assert( remotePath === null || _.strIs( remotePath ) );

  }

  /* */

  function pathsForm()
  {

    variant.localPaths.splice( 0, variant.localPaths.length );
    variant.remotePaths.splice( 0, variant.remotePaths.length );

    variant.modules.forEach( ( object ) => pathAdd( object ) );
    variant.openers.forEach( ( object ) => pathAdd( object ) );
    variant.relations.forEach( ( object ) => pathAdd( object ) );

    if( variant.peer )
    variant.peer.modules.forEach( ( object ) => pathFromPeerAdd( object ) );

    if( variant.localPaths.length && !_.longHas( variant.localPaths, variant.localPath ) )
    variant.localPath = variant.localPaths[ 0 ];
    if( variant.remotePaths.length && !_.longHas( variant.remotePaths, variant.remotePath ) )
    variant.remotePath = variant.remotePaths[ 0 ];

    _.assert( !variant.localPaths.length || _.longHas( variant.localPaths, variant.localPath ) );
    _.assert( !variant.remotePaths.length || _.longHas( variant.remotePaths, variant.remotePath ) );

  }

  /* */

  function objectFind()
  {
    if( variant.module )
    {
      variant.object = variant.module;
    }
    else if( variant.opener )
    {
      _.assert( variant.opener.formed >= 2 );
      variant.object = variant.opener;
    }
    else if( variant.relation )
    {
      variant.object = variant.relation;
    }
  }

  /* */

  function associationsAdd()
  {

    variant._add( variant.AssociationsOf( variant.relations ) );
    variant._add( variant.AssociationsOf( variant.openers ) );
    variant._add( variant.AssociationsOf( variant.modules ) );

  }

  /* */

  function finitedRemove()
  {

    if( variant.module && variant.module.finitedIs() )
    debugger;
    if( variant.module && variant.module.finitedIs() )
    variant._remove( variant.module );
    if( variant.opener && variant.opener.finitedIs() )
    debugger;
    if( variant.opener && variant.opener.finitedIs() )
    variant._remove( variant.opener );
    if( variant.relation && variant.relation.finitedIs() )
    variant._remove( variant.relation );

  }

  /* */

  function verify()
  {

    if( variant.module )
    _.assert( !variant.module.finitedIs() );
    if( variant.opener )
    _.assert( !variant.opener.finitedIs() );
    if( variant.relation )
    _.assert( !variant.relation.finitedIs() );

    _.assert
    (
      _.strDefined( variant.localPath ) || _.strDefined( variant.remotePath ),
      () => `${variant.name} does not have defined local path, neither remote path`
    );
    _.assert
    (
      !variant.opener || variant.opener.formed >= 2,
      () => `Opener should be formed to level 2 or higher, but ${variant.opener.absoluteName} is not`
    );

  }

  /* */

  function register()
  {
    if( will.variantMap )
    {
      if( variant.localPath )
      {
        variant.localPaths.forEach( ( localPath ) =>
        {
          _.assert( will.variantMap[ localPath ] === undefined || will.variantMap[ localPath ] === variant );
          _.assert( _.strDefined( localPath ) );
          will.variantMap[ localPath ] = variant;
        });
      }
      if( variant.remotePath )
      {
        _.assert( will.variantMap[ variant.remotePath ] === undefined || will.variantMap[ variant.remotePath ] === variant );
        _.assert( _.strDefined( variant.remotePath ) );
        will.variantMap[ variant.remotePath ] = variant;
      }
    }
  }

  /* */

  function peerFromModule( module )
  {
    _.assert( module instanceof _.Will.Module );
    _.assert( !module.peerModule );

    // let peerWillfilesPath = module.pathMap[ 'module.peer.willfiles' ];
    // if( !peerWillfilesPath )
    // return;
    // _.assert( !!peerWillfilesPath );
    // let localPath = _.Will.CommonPathFor( peerWillfilesPath );

    let localPath = module.peerLocalPathGet();
    if( !localPath )
    return;

    if( will.variantMap[ localPath ] )
    {
      let variant2 = will.variantMap[ localPath ];
      peerAssign( variant, variant2 );
      // variant2.reform(); // xxx
      return variant2;
    }

    _.assert( !will.variantMap[ localPath ] );

    let variant2 = new _.Will.ModuleVariant({ will : will });
    variant2.localPaths.push( localPath );
    variant2.localPath = localPath;
    peerAssign( variant, variant2 );
    variant2.reform();

    return variant2;
  }

  /* */

  function peerFrom( object )
  {
    let peerModule = object.peerModule;

    if( !peerModule )
    return;

    if( !peerModule.isPreformed() )
    return;

    if( variant.peer )
    {
      _.assert( variant.peer.peer === variant );
      if( !object.peerModule )
      return variant.peer;

      let variant2 = variant.VariantOf( will, object.peerModule );
      if( variant2 && variant2.peer === variant )
      return variant.peer;
      // else
      // {
      //   debugger;
      //   // _.assert( 0, 'not tested' );
      // }
    }

    // let variant2 = _.Will.ModuleVariant.From({ object : peerModule, will : will }); // yyy
    let variant2 = _.Will.ModuleVariant.VariantOf( will, peerModule );
    peerAssign( variant, variant2 );

    // _.assert( !variant.finitedIs() );
    // variant.peer = _.Will.ModuleVariant.From({ object : peerModule, will : will });
    // _.assert( !variant.finitedIs() );
    // if( variant.peer.peer && variant.peer.peer !== variant )
    // {
    //   if( !variant.peer.peer.ownSomething() )
    //   {
    //     debugger;
    //     variant.peer.peer.finit();
    //   }
    //   else
    //   {
    //     debugger;
    //     variant.peer.peer = null;
    //   }
    // }
    // _.assert( variant.peer.peer === variant || variant.peer.peer === null );
    //
    // if( variant.peer.finitedIs() )
    // {
    //   variant.peer = null;
    // }
    // else
    // {
    //   variant.peer.peer = variant;
    // }

    return variant2;
  }

  /* */

  function peerAssign( variant, variant2 )
  {
    _.assert( !variant.finitedIs() );

    // if( variant2.peer === variant || variant2.peer === null )
    // assign();

    if( variant2.peer && variant2.peer !== variant )
    {
      if( !variant2.peer.ownSomething() )
      {
        debugger;
        variant2.peer.finit();
      }
      else
      {
        debugger;
        // variant2.peer = null;
        variant2.peer.mergeIn( variant );
      }
    }

    if( variant.peer && variant.peer !== variant2 )
    {
      if( !variant.peer.ownSomething() )
      {
        debugger;
        variant.peer.finit();
      }
      else
      {
        // debugger;
        // variant.peer = null;
        variant2.mergeIn( variant.peer );
        return;
      }
    }

    assign();

    // if( variant2.finitedIs() )
    // {
    //   variant.peer = null;
    // }
    // else
    // {
    //   variant2.peer = variant;
    // }

    function assign()
    {
      _.assert( variant.peer === variant2 || variant.peer === null );
      _.assert( variant2.peer === variant || variant2.peer === null );
      _.assert( !variant.finitedIs() );
      _.assert( !variant2.finitedIs() );
      variant.peer = variant2;
      variant2.peer = variant;
      return;
    }
  }

  /* */

  function peerForm()
  {

    variant.openers.forEach( ( object ) => peerFrom( object ) );
    variant.modules.forEach( ( object ) => peerFrom( object ) );

    if( !variant.peer )
    variant.modules.forEach( ( object ) => peerFromModule( object ) );

  }

  /* */

  function nameForm()
  {
    if( variant.object )
    variant.name = variant.object.absoluteName;
    else if( variant.peer )
    variant.name = variant.peer.name + ' / f::peer';
  }

  /* */

  function isOutForm()
  {
    if( variant.object && _.boolLike( variant.object.isOut ) )
    variant.isOut = !!variant.object.isOut;
    else if( variant.peer && variant.peer.object && _.boolLike( variant.peer.object.isOut ) )
    variant.isOut = !variant.peer.object.isOut;
    else
    variant.isOut = _.Will.PathIsOut( variant.localPath || variant.remotePath );
  }

  /* */

}

//

function mergeIn( variant2 )
{
  let variant = this;
  let will = variant.will;
  let objects = [];

  _.assert( !variant.finitedIs() );
  _.assert( !variant2.finitedIs() );
  _.assert( arguments.length === 1 );

  variant.relations.slice().forEach( ( object ) => objects.push( object ) );
  variant.openers.slice().forEach( ( object ) => objects.push( object ) );
  variant.modules.slice().forEach( ( object ) => objects.push( object ) );

  // variant.relations.slice().forEach( ( object ) => variant._remove( object ) );
  // variant.openers.slice().forEach( ( object ) => variant._remove( object ) );
  // variant.modules.slice().forEach( ( object ) => variant._remove( object ) );

  objects.forEach( ( object ) => variant._remove( object ) );
  objects.forEach( ( object ) => variant2._add( object ) );

  // _.assert( variant.peer === null || variant2.peer === null || variant.peer === variant2.peer, 'not implemented' );
  if( variant.peer )
  {
    let peer = variant.peer;
    _.assert( !peer.finitedIs() );
    variant.peer = null;
    peer.peer = null;

    if( variant2.peer === null )
    {
      debugger;
      variant2.peer = peer;
      peer.peer = variant2;
    }
    else
    {
      // debugger;
      peer.mergeIn( variant2.peer );
      _.assert( peer.finitedIs() );
      _.assert( peer.peer === null );
    }

  }

  _.assert( !variant.finitedIs() );
  _.assert( !variant2.finitedIs() );

  variant.reform();

  if( variant.ownSomething() )
  {
    _.assert( 'not tested' );
  }
  else
  {
    if( !variant.finitedIs() )
    variant.finit();
  }

  _.assert( variant.finitedIs() );
  _.assert( !variant2.finitedIs() );

  variant2.reform(); /* yyy */

  if( variant.finitedIs() )
  return true;
  return false;

  // function move( object )
  // {
  //   variant._remove( object );
  //   variant2._add( object );
  //   return object;
  // }

}

//

function mergeMaybe()
{
  let variant = this;
  let will = variant.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;
  let variant2;
  let reset;

  _.assert( arguments.length === 0 );

  merge();

  if( reset )
  merge();

  _.assert( !reset );

  return variant2 || false;

  /* */

  function merge()
  {
    reset = false;

    if( objectsMergeMaybe( variant.modules ) )
    return variant2;

    if( objectsMergeMaybe( variant.openers ) )
    return variant2;

    if( objectsMergeMaybe( variant.relations ) )
    return variant2;

    if( objectsMergeMaybe( variant.AssociationsOf( variant.modules ) ) )
    return variant2;

    if( objectsMergeMaybe( variant.AssociationsOf( variant.openers ) ) )
    return variant2;

    if( objectsMergeMaybe( variant.AssociationsOf( variant.relations ) ) )
    return variant2;

    return false;
  }


  /* */

  function objectsMergeMaybe( objects )
  {
    _.any( objects, ( object ) =>
    {
      variant2 = objectMergeMaybe( object );
      if( variant2 )
      return variant2;
    });
    return variant2;
  }

  /* */

  function objectMergeMaybe( object )
  {
    let localPath, remotePath;

    [ localPath, remotePath ] = variant.PathsOf( object );

    if( localPath )
    {

      let variant2 = will.variantMap[ localPath ];
      if( variant2 && variant2 !== variant )
      {
        if( variant.mergeIn( variant2 ) )
        return variant2;
        return variant2;
      }

    }

    if( remotePath )
    {

      let variant2 = will.variantMap[ remotePath ];
      if( variant2 && variant2 !== variant )
      {
        if( variant.mergeIn( variant2 ) )
        return variant2;
        return variant2;
      }

    }

    {
      let variant3 = will.objectToVariantHash.get( object );
      if( variant3 && variant3 !== variant )
      {
        reset = 1;
        variant3.mergeIn( variant );
        return variant3;
      }
    }

  }

}

//

function From( o )
{
  let cls = this;
  let variant;
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

  if( !o.object )
  o.object = o.module || o.opener || o.relation;

  if( o.object && o.object instanceof Self )
  {
    variant = o.object;
  }
  else if( _.mapIs( o.object ) )
  {
    debugger;
    variant = Self( o.object );
  }
  else
  {
    variant = will.objectToVariantHash.get( o.object );
  }

  if( variant && variant.object ) /* xxx : remove ? */
  {
    let localPath, remotePath;
    [ localPath, remotePath ] = variant.PathsOf( variant.object );

    if( localPath !== variant.localPath )
    changed = true;
    if( remotePath !== variant.remotePath )
    changed = true;

  }

  if( !variant )
  variantWithPath();

  _.assert
  (
    !o.relation || ( !!o.relation.opener && o.relation.opener.formed >= 2 ),
    () => `Opener should be formed to level 2 or higher, but opener of ${o.relation.absoluteName} is not`
  )

  if( variant )
  variantUpdate();

  if( !variant )
  {
    made = true;
    changed = true;
    variant = Self( o );
  }

  // if( changed ) /* xxx : switch on the optimization */
  if( variant.formed !== -1 )
  variant = variant.reform();

  _.assert( !variant || !variant.finitedIs() );

  return variant;

  /* */

  function variantUpdate()
  {

    if( o.object && o.object !== variant )
    if( !variant.own( o.object ) )
    changed = variant._add( o.object ) || changed;
    if( o.module )
    if( !variant.own( o.module ) )
    changed = variant._add( o.module ) || changed;
    if( o.opener )
    if( !variant.own( o.opener ) )
    changed = variant._add( o.opener ) || changed;
    if( o.relation )
    if( !variant.own( o.relation ) )
    changed = variant._add( o.relation ) || changed;

    delete o.object;
    delete o.module;
    delete o.opener;
    delete o.relation;

    for( let f in o )
    {
      if( variant[ f ] !== o[ f ] )
      {
        debugger;
        _.assert( 0, 'not tested' );
        variant[ f ] = o[ f ];
        changed = true;
      }
    }

  }

  /* */

  function variantWithPath()
  {
    let localPath, remotePath;

    [ localPath, remotePath ] = cls.PathsOf( o.object );

    if( variantMap && variantMap[ localPath ] )
    variant = variantMap[ localPath ];
    else if( variantMap && remotePath && variantMap[ remotePath ] )
    variant = variantMap[ remotePath ];

  }

  /* */

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
  else if( object instanceof _.Will.Module )
  {
    let localPath = object.localPath || object.commonPath;
    let remotePath = object.remotePath;
    result.push( localPath );
    result.push( remotePath );
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    let localPath = object.localPath || object.commonPath;
    let remotePath = object.remotePath;
    result.push( localPath );
    result.push( remotePath );
  }
  else if( object instanceof _.Will.ModulesRelation )
  {
    let path = object.module.will.fileProvider.path;
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
  else if( object instanceof _.Will.Module )
  {
    result.localPath = object.localPath || object.commonPath;
    result.remotePath = object.remotePath;
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    result.localPath = object.localPath || object.commonPath;
    result.remotePath = object.remotePath;
  }
  else if( object instanceof _.Will.ModulesRelation )
  {
    let path = object.module.will.fileProvider.path;
    result.localPath = object.localPath;
    result.remotePath = object.remotePath;
  }
  else _.assert( 0 );

  return result;
}

//

function VariantReform( will, object )
{
  let cls = this;
  let result;

  _.assert( arguments.length === 2 );
  _.assert( !!object );

  if( !_.mapIs( object ) )
  object = { object : object }
  if( !object.will )
  object.will = will;

  result = cls.From( object );

  return result;
}

//

function VariantsReform( will, variants )
{
  let cls = this;
  _.assert( arguments.length === 2 );
  if( _.arrayLike( variants ) )
  return _.filter( variants, ( variant ) => cls.VariantReform( will, variant ) );
  else
  return cls.VariantReform( will, variants );
}

//

function VariantFrom( will, object )
{
  let cls = this;
  let result;

  _.assert( arguments.length === 2 );
  _.assert( !!object );

  if( !_.mapIs( object ) )
  object = { object : object }
  if( !object.will )
  object.will = will;

  // xxx : swtich on
  result = will.objectToVariantHash.get( object );
  if( result )
  return result;

  result = cls.From( object );

  return result;
}

//

function VariantsFrom( will, variants )
{
  let cls = this;
  _.assert( arguments.length === 2 );
  if( _.arrayLike( variants ) )
  return _.filter( variants, ( variant ) => cls.VariantFrom( will, variant ) );
  else
  return cls.VariantFrom( will, variants );
}

//

function VariantOf( will, object )
{
  let cls = this;

  _.assert( arguments.length === 2 );
  _.assert( !!object );

  if( object instanceof _.Will.ModuleVariant )
  return object;

  let variant = will.objectToVariantHash.get( object );

  if( Config.debug )
  if( variant )
  {
    let paths = cls.PathsOf( object );
    let variant2 = _.any( paths, ( path ) => will.variantMap[ path ] );
    if( variant2 )
    _.assert( _.all( paths, ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant2 ) );
    _.assert( variant === variant2 || !variant2 || !variant2.ownSomething() );
  }

  return variant;
}

//

function VariantsOf( will, variants )
{
  let cls = this;
  _.assert( arguments.length === 2 );
  if( _.arrayLike( variants ) )
  return _.filter( variants, ( variant ) => cls.VariantOf( will, variant ) );
  else
  return cls.VariantOf( will, variant );
}

//

function AssociationsOf( object )
{
  let cls = this;

  if( _.arrayIs( object ) )
  return _.longOnce( _.arrayFlatten( object.map( ( object ) => cls.AssociationsOf( object ) ) ) );

  let result = [];
  if( object instanceof _.Will.Module )
  {
    return _.each( object.userArray, ( opener ) =>
    {
      if( opener instanceof _.Will.ModuleOpener )
      result.push( opener );
    });
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    if( object.openedModule )
    result.push( object.openedModule );
    if( object.superRelation )
    result.push( object.superRelation );
  }
  else if( object instanceof _.Will.ModulesRelation )
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

function ObjectToOptionsMap( o )
{
  if( _.mapIs( o ) )
  return o;
  if( o instanceof _.Will.Module )
  {
    return { module : o }
  }
  else if( o instanceof _.Will.ModuleOpener )
  {
    return { opener : o }
  }
  else if( o instanceof _.Will.ModulesRelation )
  {
    return { relation : o }
  }
  else _.assert( 0 );
}

//

function _relationAdd( relation )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  _.assert( relation instanceof _.Will.ModulesRelation );

  // if( !relation.enabled ) /* ttt */
  // {
  //   return false;
  // }

  if( !variant.relation )
  {
    variant.relation = relation;
    changed = true;
  }

  changed = _.arrayAppendedOnce( variant.relations, relation ) > -1 || changed;

  let variant2 = will.objectToVariantHash.get( relation );
  _.assert( variant2 === variant || variant2 === undefined );
  will.objectToVariantHash.set( relation, variant );

  _.assert( variant.formed === -1 || changed || _.all( variant.PathsOf( relation ), ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant ) );

  return changed;
}

//

function _relationRemoveSingle( relation )
{
  let variant = this;
  let will = variant.will;

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

  return true;
}

//

function _relationRemove( relation )
{
  let variant = this;
  let will = variant.will;

  if( !_.longHas( variant.relations, relation ) )
  return false;

  variant._relationRemoveSingle( relation );

  variant._remove( variant.AssociationsOf( relation ) );
  return true;
}

//

function _openerAdd( opener )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  // if( opener.superRelation ) /* ttt */
  // {
  //   if( !opener.superRelation.enabled )
  //   return false;
  //   _.assert( !!opener.superRelation.enabled );
  // }

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

  _.assert( variant.formed === -1 || changed || _.all( variant.PathsOf( opener ), ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant ) );

  return changed;
}

//

function _openerRemoveSingle( opener )
{
  let variant = this;
  let will = variant.will;

  _.assert( opener instanceof _.Will.ModuleOpener );
  _.arrayRemoveOnceStrictly( variant.openers, opener );

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

function _openerRemove( opener )
{
  let variant = this;
  let will = variant.will;

  if( !_.longHas( variant.openers, opener ) )
  return false;

  variant._openerRemoveSingle( opener );

  variant._remove( variant.AssociationsOf( opener ) );
  return true;
}

//

function _moduleAdd( module )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  _.assert( module instanceof _.Will.Module );

  if( !variant.module )
  {
    variant.module = module;
    changed = true;
  }

  changed = _.arrayAppendedOnce( variant.modules, module ) > -1 || changed;

  let variant2 = will.objectToVariantHash.get( module );
  _.assert( variant2 === variant || variant2 === undefined, 'Module can belong only to one variant' );
  will.objectToVariantHash.set( module, variant );

  _.assert( variant.formed === -1 || changed || _.all( variant.PathsOf( module ), ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant ) );

  return changed;
}

//

function _moduleRemoveSingle( module )
{
  let variant = this;
  let will = variant.will;

  _.assert( module instanceof _.Will.Module );
  // _.assert( variant.module === module );
  _.arrayRemoveOnceStrictly( variant.modules, module );

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

function _moduleRemove( module )
{
  let variant = this;
  let will = variant.will;

  if( !_.longHas( variant.modules, module ) )
  return false;

  variant._moduleRemoveSingle( module );

  variant._remove( variant.AssociationsOf( module ) );
  return true;
}

//

function _add( object )
{
  let variant = this;
  let result;

  if( _.arrayIs( object ) )
  return _.any( _.map( object, ( object ) => variant._add( object ) ) );

  if( object instanceof _.Will.ModulesRelation )
  {
    result = variant._relationAdd( object );
  }
  else if( object instanceof _.Will.Module )
  {
    result = variant._moduleAdd( object );
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    result = variant._openerAdd( object );
  }
  else _.assert( 0, `Unknown type of object ${_.strType( object )}` );

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

  if( _.arrayIs( object ) )
  return _.any( _.map( object, ( object ) => variant._remove( object ) ) );

  if( object instanceof _.Will.ModulesRelation )
  {
    return variant._relationRemove( object );
  }
  else if( object instanceof _.Will.Module )
  {
    return variant._moduleRemove( object );
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    return variant._openerRemove( object );
  }
  else _.assert( 0 );

}

//

function remove( object )
{
  let variant = this;
  variant._remove( object );
  return variant.reform();
}

//

function own( object )
{
  let variant = this;

  _.assert( arguments.length === 1 );

  if( object instanceof _.Will.Module )
  {
    return _.longHas( variant.modules, object );
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    return _.longHas( variant.openers, object );
  }
  else if( object instanceof _.Will.ModulesRelation )
  {
    return _.longHas( variant.relations, object );
  }
  else _.assert( 0 );

}

//

function ownSomething()
{
  let variant = this;

  _.assert( arguments.length === 0 );

  if( variant.modules.length )
  return true;
  if( variant.openers.length )
  return true;
  if( variant.relations.length )
  return true;

  return false;
}

//

function isUsed()
{
  let variant = this;

  _.assert( arguments.length === 0 );

  if( variant.ownSomething() )
  return true;

  if( variant.peer )
  if( variant.peer.ownSomething() )
  return true;

  return false;
}

//

// function submodulesRelationsFilter( o )
// {
//   let variant = this;
//   let will = variant.will;
//   let result = [];
//
//   o = _.routineOptions( submodulesRelationsFilter, arguments );
//
//   let filter = _.mapOnly( o, will.relationFit.defaults );
//
//   variantLook( variant );
//
//   if( !variant.peer )
//   if( variant.module && variant.module.peerModule )
//   {
//     debugger;
//     variant.From({ module : variant.module.peerModule, will : will });
//     _.assert( _.longHas( variant.peer.modules, variant.module.peerModule ) );
//   }
//
//   if( o.withPeers )
//   if( variant.peer )
//   variantLook( variant.peer );
//
//   if( o.withoutDuplicates )
//   result = result.filter( ( variant ) =>
//   {
//     return !variant.isOut || !_.longHas( result, variant.peer );
//   });
//
//   return result;
//
//   /* */
//
//   function variantLook( variant )
//   {
//
//     if( variant.module )
//     for( let s in variant.module.submoduleMap )
//     {
//       let relation = variant.module.submoduleMap[ s ];
//
//       let variant2 = variant.VariantOf( will, relation );
//       if( !variant2 )
//       variant2 = variant.From({ relation : relation, will : will });
//       _.assert( !!variant2 );
//
//       if( !variant2.peer )
//       if( variant2.module && variant2.module.peerModule )
//       {
//         debugger;
//         _.assert( 0, 'not tested' );
//         variant2.From({ module : variant2.module.peerModule, will : will });
//       }
//
//       /*
//       getting shadow sould go after setting up variant
//       */
//
//       // variant2 = variant2.shadow({ relation })
//       variantAppendMaybe( variant2 );
//
//       if( o.withPeers )
//       if( variant2.peer )
//       variantAppendMaybe( variant2.peer );
//
//     }
//
//   }
//
//   /* */
//
//   function variantAppendMaybe( variant )
//   {
//
//     if( !will.relationFit( variant, filter ) )
//     return;
//
//     _.assert( variant instanceof _.Will.ModuleVariant );
//     _.arrayAppendOnce( result, variant );
//
//   }
//
//   /* */
//
// }
//
// submodulesRelationsFilter.defaults =
// {
//
//   ... _.Will.RelationFilterDefaults,
//   withPeers : 1,
//   withoutDuplicates : 0,
//
// }

//

function submodulesVariantsFilter( o )
{
  let variant = this;
  let will = variant.will;
  let result = [];

  o = _.routineOptions( submodulesVariantsFilter, arguments );

  let filter = _.mapOnly( o, will.relationFit.defaults );

  // if( _global_.debugger === 1 )
  // debugger;

  variantLook( variant );

  if( !variant.peer )
  if( variant.module && variant.module.peerModule )
  {
    debugger;
    variant.From({ module : variant.module.peerModule, will : will });
    _.assert( _.longHas( variant.peer.modules, variant.module.peerModule ) );
  }

  if( o.withPeers )
  if( variant.peer )
  variantLook( variant.peer );

  // if( _global_.debugger === 1 )
  // debugger;

  if( o.withoutDuplicates )
  result = result.filter( ( variant ) =>
  {
    return !variant.isOut || !_.longHas( result, variant.peer );
  });

  // if( _global_.debugger === 1 )
  // debugger;

  return result;

  /* */

  function variantLook( variant )
  {

    if( variant.module )
    for( let s in variant.module.submoduleMap )
    {
      let relation = variant.module.submoduleMap[ s ];

      let variant2 = variant.VariantOf( will, relation );
      if( !variant2 )
      variant2 = variant.From({ relation : relation, will : will });
      _.assert( !!variant2 );

      if( !variant2.peer )
      if( variant2.module && variant2.module.peerModule )
      {
        debugger;
        _.assert( 0, 'not tested' );
        variant2.From({ module : variant2.module.peerModule, will : will });
      }

      /*
      getting shadow sould go after setting up variant
      */

      // variant2 = variant2.shadow({ relation })
      variantAppendMaybe( variant2 );

      if( o.withPeers )
      if( variant2.peer )
      variantAppendMaybe( variant2.peer );

    }

  }

  /* */

  function variantAppendMaybe( variant )
  {

    if( !will.relationFit( variant, filter ) )
    return;

    _.assert( variant instanceof _.Will.ModuleVariant );
    _.arrayAppendOnce( result, variant );

  }

  /* */

}

submodulesVariantsFilter.defaults =
{

  ... _.Will.RelationFilterDefaults,
  withPeers : 1,
  withoutDuplicates : 0,

}

//

function shadow( o )
{
  let variant = this;
  let will = variant.will;

  if( !_.mapIs( o ) )
  o = variant.ObjectToOptionsMap( o );

  o = _.routineOptions( shadow, o );
  _.assert( arguments.length === 1 );

  let shadowMap = _.mapExtend( null, o );
  shadowMap.localPath = _.unknown;
  shadowMap.remotePath = _.unknown;

  let shadowProxy = _.proxyShadow
  ({
    back : variant,
    front : shadowMap,
  });

  pathsDeduce();
  peerDeduce();
  associationsFill();
  peerDeduce();
  pathsDeduce();

  for( let s in shadowMap )
  if( shadowMap[ s ] === _.unknown )
  delete shadowMap[ s ];

  return shadowProxy;

  function associationsFill()
  {
    if( defined( shadowMap.module ) )
    objectAssociationsAppend( shadowMap.module );
    if( defined( shadowMap.opener ) )
    objectAssociationsAppend( shadowMap.opener );
    if( defined( shadowMap.relation ) )
    objectAssociationsAppend( shadowMap.relation );
  }

  function objectAssociationsAppend( object )
  {
    variant.AssociationsOf( object ).forEach( ( object ) =>
    {
      if( object instanceof _.Will.Module )
      {
        if( shadowMap.module === _.unknown )
        shadowMap.module = object;
      }
      else if( object instanceof _.Will.ModuleOpener )
      {
        if( shadowMap.opener === _.unknown )
        shadowMap.opener = object;
      }
      else if( object instanceof _.Will.ModulesRelation )
      {
        if( shadowMap.relation === _.unknown )
        shadowMap.relation = object;
      }
      else _.assert( 0 );
    });
  }

  function pathsFrom( object )
  {
    let paths = variant.PathsOfAsMap( object );
    if( paths.localPath && shadowMap.localPath === _.unknown )
    shadowMap.localPath = paths.localPath;
    if( paths.remotePath && shadowMap.remotePath === _.unknown )
    shadowMap.remotePath = paths.remotePath;
  }

  function pathsDeduce()
  {
    if( shadowMap.localPath !== _.unknown && shadowMap.remotePath !== _.unknown )
    return true;
    if( defined( shadowMap.module ) )
    pathsFrom( shadowMap.module );
    if( shadowMap.localPath !== _.unknown && shadowMap.remotePath !== _.unknown )
    return true;
    if( defined( shadowMap.opener ) )
    pathsFrom( shadowMap.opener );
    if( shadowMap.localPath !== _.unknown && shadowMap.remotePath !== _.unknown )
    return true;
    if( defined( shadowMap.relation ) )
    pathsFrom( shadowMap.relation );
    if( shadowMap.localPath !== _.unknown && shadowMap.remotePath !== _.unknown )
    return true;
    return false;
  }

  function peerDeduce()
  {
    if( shadowMap.peer !== _.unknown )
    return true;

    if( shadowMap.module && shadowMap.module.peerModule )
    peerFrom( shadowMap.module.peerModule );
    else if( shadowMap.opener && shadowMap.opener.peerModule )
    peerFrom( shadowMap.opener.peerModule );

    if( shadowMap.peer !== _.unknown )
    return true;
    return false;
  }

  function peerFrom( peerModule )
  {
    _.assert( peerModule instanceof _.Will.Module );
    _.assert( shadowMap.peer === _.unknown );
    shadowMap.peer = variant.VariantOf( will, peerModule );
    if( !shadowMap.peer )
    shadowMap.peer = variant.VariantFrom( will, peerModule );
    shadowMap.peer = shadowMap.peer.shadow({ module : peerModule, peer : shadowProxy });
  }

  function defined( val )
  {
    return !!val && ( val !== _.unknown );
  }

}

shadow.defaults =
{
  module : _.unknown,
  relation : _.unknown,
  opener : _.unknown,
  peer : _.unknown,
}

//

function toModule()
{
  let variant = this;
  return variant.module;
}

//

function toRelation()
{
  let variant = this;
  return variant.relation;
}

// --
// export
// --

function exportInfo()
{
  let result = '';
  let variant = this;

  result += `variant:: : #${variant.id}\n`;

  let lpl = ' ';
  if( variant.localPaths.length > 1 )
  lpl = ` ( ${variant.localPaths.length} ) `;
  if( variant.localPath )
  result += `  path::local${lpl}: ${variant.localPath}\n`;

  let rpl = ' ';
  if( variant.remotePaths.length > 1 )
  rpl = ` ( ${variant.remotePaths.length} ) `;
  if( variant.remotePath )
  result += `  path::remote${rpl}: ${variant.remotePath}\n`;

  if( variant.modules.length )
  {
    result += '  ' + variant.module.absoluteName + ' #' + variant.modules.map( ( m ) => m.id ).join( ' #' ) + '\n';
  }
  if( variant.opener )
  {
    result += '  ' + variant.opener.absoluteName + ' #' + variant.openers.map( ( m ) => m.id ).join( ' #' ) + '\n';
  }
  if( variant.relation )
  {
    result += '  ' + variant.relation.absoluteName + ' #' + variant.relations.map( ( m ) => m.id ).join( ' #' ) + '\n';
  }
  if( variant.peer )
  {
    result += `  peer::variant : #${variant.peer.id}\n`;
  }

  return result;
}

//

function nameWithLocationGet()
{
  let variant = this;
  let name = _.color.strFormat( variant.object.qualifiedName || variant.name, 'entity' );
  let localPath = _.color.strFormat( variant.localPath, 'path' );
  let result = `${name} at ${localPath}`;
  return result;
}

// --
// etc
// --

function moduleSet( module )
{
  let variant = this;
  variant[ moduleSymbol ] = module;
  return module;
}

//

function dirPathGet()
{
  let variant = this;
  if( !variant.localPath )
  return null;
  let will = variant.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  return path.detrail( path.dirFirst( variant.localPath ) );
}

//

function enabledGet()
{
  let variant = this;
  let result = null;

  if( variant.module )
  result = variant.module.about.enabled;
  else if( variant.peer && variant.peer.module )
  result = variant.peer.module.enabled;

  _.assert( result === null || _.boolIs( result ) );
  return result;
}

//

function isRemoteGet()
{
  let variant = this;
  let result = null;

  if( variant.module && variant.module.repo )
  result = variant.module.repo.isRemote;
  else if( variant.opener && variant.opener.repo )
  result = variant.opener.repo.isRemote;
  else if( variant.peer && variant.peer.module && variant.peer.module.repo )
  result = variant.peer.module.repo.isRemote;
  else if( variant.peer && variant.peer.opener && variant.peer.opener.repo )
  result = variant.peer.opener.repo.isRemote;

  _.assert( result === null || _.boolIs( result ) );
  return result;
}

//

function objectsGet()
{
  let variant = this;
  let result = [];

  _.each( variant.modules, ( module ) => result.push( module ) );
  _.each( variant.openers, ( opener ) => result.push( opener ) );
  _.each( variant.relations, ( relation ) => result.push( relation ) );

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
  From,
  PathsOf,
  PathsOfAsMap,
  VariantReform,
  VariantsReform,
  VariantFrom,
  VariantsFrom,
  VariantOf,
  VariantsOf,
  AssociationsOf,
  ObjectToOptionsMap,
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
  dirPath : { getter : dirPathGet, readOnly : 1 },
  enabled : { getter : enabledGet, readOnly : 1 },
  isRemote : { getter : isRemoteGet, readOnly : 1 },
  objects : { getter : objectsGet, readOnly : 1 },
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
  mergeIn,
  mergeMaybe,

  From,
  PathsOf,
  PathsOfAsMap,
  VariantReform,
  VariantsReform,
  VariantFrom,
  VariantsFrom,
  VariantOf,
  VariantsOf,
  AssociationsOf,
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
  submodulesVariantsFilter,
  shadow,
  toModule,
  toRelation,

  // export

  exportInfo,
  nameWithLocationGet,

  // etc

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
