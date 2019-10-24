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
  let remotePaths = [];

  if( variant.formed === -1 )
  return;

  variant.formed = -1;

  _.assert( !variant.finitedIs() );

  // if( variant.id === 83 || variant.id === 259 )
  // if( variant.id === 83 )
  // if( variant.id === 83 || variant.id === 129 )
  // if( variant.id === 209 || variant.id === 259 )
  // if( variant.id === 209 )
  // {
  //   logger.log( '>', variant.infoExport() );
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
  //   logger.log( variant.infoExport() );
  //   debugger;
  // }

  variant.mergeMaybe();

  _.assert( !variant.finitedIs() );

  if( !variant.isUsed() )
  {
    variant.finit();
    return false;
  }

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

  if( variant.id === 83 && !variant.ownSomething() )
  debugger;

  pathsForm();

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

    // if( variant.localPaths.length > 1 )
    // debugger;

    if( remotePath )
    {
      _.arrayAppendOnce( remotePaths, remotePath );
      variant.remotePath = remotePath;
      _.assert( remotePaths.length <= 1, `Remote paths collision: ${remotePaths.join( ' ' )}` );
    }

  }

  /* */

  function pathFromPeerAdd( object )
  {
    // let peerWillfilesPath = object.pathMap[ 'module.peer.willfiles' ];
    // if( !peerWillfilesPath )
    // return;
    // _.assert( !!peerWillfilesPath );
    // let localPath = _.Will.CommonPathFor( peerWillfilesPath );
    // _.assert( !_.path.isGlobal( localPath ) );
    let localPath = object.peerLocalPathGet();
    if( !localPath )
    return;
    _.arrayAppendOnce( variant.localPaths, localPath );
    if( variant.localPath === null )
    variant.localPath = localPath;
    // if( variant.localPaths.length !== 1 )
    // debugger;
  }

  /* */

  function pathsForm()
  {
    variant.localPaths.splice( 0, variant.localPaths.length );

    variant.modules.forEach( ( object ) => pathAdd( object ) );
    variant.openers.forEach( ( object ) => pathAdd( object ) );
    variant.relations.forEach( ( object ) => pathAdd( object ) );

    if( variant.peer )
    variant.peer.modules.forEach( ( object ) => pathFromPeerAdd( object ) );

    if( variant.localPaths.length && !_.arrayHas( variant.localPaths, variant.localPath ) )
    variant.localPath = variant.localPaths[ 0 ];

    _.assert( !variant.localPaths.length || _.arrayHas( variant.localPaths, variant.localPath ) );
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
    _.assert( module instanceof _.Will.OpenedModule );
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
      else
      {
        debugger;
        _.assert( 0, 'not tested' );
      }
    }

    let variant2 = _.Will.ModuleVariant.From({ object : peerModule, will : will });
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

    if( variant2.peer === variant || variant2.peer === null )
    assign();

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
        variant2.peer = null;
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

  _.assert( !variant.finitedIs() );
  _.assert( !variant2.finitedIs() );
  _.assert( arguments.length === 1 );

  variant.relations.slice().forEach( ( object ) => move( object ) );
  variant.openers.slice().forEach( ( object ) => move( object ) );
  variant.modules.slice().forEach( ( object ) => move( object ) );

  _.assert( !variant.finitedIs() );
  _.assert( !variant2.finitedIs() );

  variant.reform();
  if( variant.finitedIs() )
  return true;
  return false;

  function move( object )
  {
    variant._remove( object );
    variant2._add( object );
    return object;
  }
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

  if( variant && variant.object )
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
    if( !variant.has( o.object ) )
    changed = variant._add( o.object ) || changed;
    if( o.module )
    if( !variant.has( o.module ) )
    changed = variant._add( o.module ) || changed;
    if( o.opener )
    if( !variant.has( o.opener ) )
    changed = variant._add( o.opener ) || changed;
    if( o.relation )
    if( !variant.has( o.relation ) )
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
  else if( object instanceof _.Will.OpenedModule )
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
  else if( object instanceof _.Will.OpenedModule )
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

function VariantFrom( will, object )
{
  let cls = this;

  _.assert( arguments.length === 2 );
  _.assert( !!object );

  if( !_.mapIs( object ) )
  object = { object : object }

  object.will = will;

  let result = cls.From( object );

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
  return will.VariantFrom( variants );
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
    _.assert( variant === variant2 || !variant2 );
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
  if( object instanceof _.Will.OpenedModule )
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
  }
  else _.assert( 0 );

  return result;
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

  _.assert( changed || _.all( variant.PathsOf( relation ), ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant ) );

  return changed;
}

//

function _relationRemoveAct( relation )
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

  if( !_.arrayHas( variant.relations, relation ) )
  return false;

  variant._relationRemoveAct( relation );

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

  _.assert( changed || _.all( variant.PathsOf( opener ), ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant ) );

  return changed;
}

//

function _openerRemoveAct( opener )
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

  if( !_.arrayHas( variant.openers, opener ) )
  return false;

  variant._openerRemoveAct( opener );

  variant._remove( variant.AssociationsOf( opener ) );
  return true;
}

//

function _moduleAdd( module )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  _.assert( module instanceof _.Will.OpenedModule );

  if( !variant.module )
  {
    variant.module = module;
    changed = true;
  }

  changed = _.arrayAppendedOnce( variant.modules, module ) > -1 || changed;

  let variant2 = will.objectToVariantHash.get( module );
  _.assert( variant2 === variant || variant2 === undefined, 'Module can belong only to one variant' );
  will.objectToVariantHash.set( module, variant );

  _.assert( changed || _.all( variant.PathsOf( module ), ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant ) );

  return changed;
}

//

function _moduleRemoveAct( module )
{
  let variant = this;
  let will = variant.will;

  _.assert( module instanceof _.Will.OpenedModule );
  _.assert( variant.module === module );
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

  if( !_.arrayHas( variant.modules, module ) )
  return false;

  variant._moduleRemoveAct( module );

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
  else if( object instanceof _.Will.OpenedModule )
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
  else if( object instanceof _.Will.OpenedModule )
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

function has( object )
{
  let variant = this;

  _.assert( arguments.length === 1 );

  if( object instanceof _.Will.OpenedModule )
  {
    return _.arrayHas( variant.modules, object );
  }
  else if( object instanceof _.Will.ModuleOpener )
  {
    return _.arrayHas( variant.openers, object );
  }
  else if( object instanceof _.Will.ModulesRelation )
  {
    return _.arrayHas( variant.relations, object );
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

function submodulesGet( o )
{
  let variant = this;
  let will = variant.will;
  let result = [];

  o = _.routineOptions( submodulesGet, arguments );

  append( variant );

  if( !variant.peer )
  if( variant.module && variant.module.peerModule )
  {
    debugger;
    // _.assert( 0, 'not tested' );
    variant.From({ module : variant.module.peerModule, will : will });
    _.assert( _.arrayHas( variant.peer.modules, variant.module.peerModule ) );
  }

  if( o.withPeers )
  if( variant.peer )
  append( variant.peer );

  return result;

  /* */

  function append( variant )
  {

    if( variant.module )
    for( let s in variant.module.submoduleMap )
    {
      let relation = variant.module.submoduleMap[ s ];

      if( !o.withDisabled )
      if( !relation.enabled )
      continue;

      if( !o.withEnabled )
      if( relation.enabled )
      continue;

      let variant2 = variant.From({ relation : relation, will : will });;
      if( variant2 )
      variantAppendMaybe( variant2 );

      if( !variant2.peer )
      if( variant2.module && variant2.module.peerModule )
      {
        debugger;
        _.assert( 0, 'not tested' );
        variant2.From({ module : variant2.module.peerModule, will : will });
      }

      if( o.withPeers )
      if( variant2.peer )
      variantAppendMaybe( variant2.peer );

    }

  }

  /* */

  function variantAppendMaybe( variant )
  {

    if( !o.withOut )
    if( variant.isOut )
    return;

    if( !o.withIn )
    if( !variant.isOut )
    return;

    _.assert( variant instanceof _.Will.ModuleVariant );
    _.arrayAppendOnce( result, variant );

  }

  /* */

}

submodulesGet.defaults =
{
  withPeers : 1,
  withOut : 1,
  withIn : 1,
  withEnabled : 1,
  withDisabled : 0,
}

// --
// export
// --

function infoExport()
{
  let result = '';
  let variant = this;

  result += `variant:: : #${variant.id}\n`;

  let lpl = '';
  if( variant.localPaths.length > 1 )
  lpl = `( ${variant.localPaths.length} )`;
  if( variant.localPath )
  result += `  path::local ${lpl} : ${variant.localPath}\n`;

  let rpl = '';
  if( variant.remotePaths.length > 1 )
  rpl = `( ${variant.remotePaths.length} )`;
  if( variant.remotePath )
  result += `  path::remote ${rpl} : ${variant.remotePath}\n`;

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
  VariantFrom,
  VariantsFrom,
  VariantOf,
  VariantsOf,
  AssociationsOf,
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
  dirPath : { getter : dirPathGet, readOnly : 1 }
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
  VariantFrom,
  VariantsFrom,
  VariantOf,
  VariantsOf,
  AssociationsOf,

  _relationAdd,
  _relationRemoveAct,
  _relationRemove,
  _openerAdd,
  _openerRemoveAct,
  _openerRemove,
  _moduleAdd,
  _moduleRemoveAct,
  _moduleRemove,

  _add,
  add,
  _remove,
  remove,
  has,
  ownSomething,
  isUsed,
  submodulesGet,

  // export

  infoExport,
  nameWithLocationGet,

  // etc

  moduleSet,
  dirPathGet,

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
