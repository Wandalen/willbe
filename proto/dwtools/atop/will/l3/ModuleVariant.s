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
  variant.formed = -1;

  _.assert( !variant.finitedIs() );

  // if( variant.id === 2 )
  // {
  //   logger.log( '>', variant.infoExport() );
  //   debugger;
  // }

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

  // finitedRemove();
  // if( !variant.opener && !variant.module && !variant.relation )
  if( !variant.isUsed() )
  {
    variant.finit();
    return false;
  }

  {
    let variant2 = variantMergeTry( variant );
    if( variant2 )
    return variant2;
  }

  associationsAdd();

  // let localPath, remotePath;
  objectFind();
  // [ localPath, remotePath ] = variant.PathsOf( variant.object );

  {
    let variant2 = variantMergeTry( variant );
    if( variant2 )
    return variant2;
  }

  if( variant.id === 83 && !variant.ownSomething() )
  debugger;

  localPathsForm();

  verify();

  // variant.localPath = variant.localPaths[ 0 ];
  // variant.remotePath = remotePath;

  register();
  peerForm();
  nameForm();
  isOutForm();

  // if( variant.id === 83 || variant.id === 259 )
  // if( variant.id === 83 || variant.id === 129 )
  // if( variant.id === 83 )
  // if( variant.id === 209 || variant.id === 259 )
  // if( variant.id === 209 )
  // {
  //   logger.log( '<', variant.infoExport() );
  //   debugger;
  // }

  // if( variant.id === 2 )
  // {
  //   logger.log( '<', variant.infoExport() );
  //   debugger;
  // }

  variant.formed = 1;
  return variant;

  /* */

  function variantMergeTry( variant )
  {
    let variant2;

    _.any( variant.modules, ( object ) =>
    {
      variant2 = objectMergeTry( object );
      if( variant2 )
      return variant2;
    });

    _.any( variant.openers, ( object ) =>
    {
      variant2 = objectMergeTry( object );
      if( variant2 )
      return variant2;
    });

    _.any( variant.openers, ( object ) =>
    {
      variant2 = objectMergeTry( object );
      if( variant2 )
      return variant2;
    });

    _.any( variant.relations, ( module ) =>
    {
      variant2 = objectMergeTry( module );
      if( variant2 )
      return variant2;
    });

    return variant2 || false;
  }

  /* */

  function objectMergeTry( object )
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
      }

    }

    if( remotePath )
    {

      let variant2 = will.variantMap[ remotePath ];
      if( variant2 && variant2 !== variant )
      {
        if( variant.mergeIn( variant2 ) )
        return variant2;
      }

    }

  }

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
    if( variant.localPaths.length > 1 )
    debugger;

    if( remotePath )
    {
      _.assert( variant.remotePath === null || variant.remotePath === remotePath );
      variant.remotePath = remotePath;
    }

  }

  /* */

  function pathFromPeerAdd( object )
  {
    let peerWillfilesPath = object.pathMap[ 'module.peer.willfiles' ];
    if( !peerWillfilesPath )
    return;
    _.assert( !!peerWillfilesPath );
    let localPath = _.Will.AbstractModule.CommonPathFor( peerWillfilesPath );
    _.assert( !_.path.isGlobal( localPath ) );
    _.arrayAppendOnce( variant.localPaths, localPath );
    if( variant.localPath === null )
    variant.localPath = localPath;
    if( variant.localPaths.length !== 1 )
    debugger;
  }

  /* */

  function localPathsForm()
  {
    variant.localPaths.splice( 0, variant.localPaths.length );
    // variant.localPath = null;

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

    variant.relations.forEach( ( relation ) =>
    {
      if( relation && relation.opener )
      variant._openerAdd( relation.opener );
    });

    variant.openers.forEach( ( opener ) =>
    {
      if( opener && opener.openedModule )
      variant._moduleAdd( opener.openedModule );
      if( opener && opener.superRelation )
      variant._relationAdd( opener.superRelation );
    });

    variant.modules.forEach( ( module ) =>
    {
      _.each( module.userArray, ( opener ) =>
      {
        if( opener instanceof _.Will.ModuleOpener )
        variant._openerAdd( opener );
      });
    });

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

    // _.assert( localPath === null || localPath === variant.localPaths[ 0 ] );
    // localPath = variant.localPaths[ 0 ];

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

  function peerFrom( object )
  {
    let peerModule = object.peerModule;

    if( !peerModule )
    return;

    if( variant.id === 209 )
    debugger;

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

    _.assert( !variant.finitedIs() );
    variant.peer = _.Will.ModuleVariant.From({ object : peerModule, will : will });
    _.assert( !variant.finitedIs() );
    _.assert( variant.peer.peer === variant || variant.peer.peer === null );

    if( variant.peer.finitedIs() )
    {
      variant.peer = null;
    }
    else
    {
      variant.peer.peer = variant;
    }

  }

  /* */

  function peerForm()
  {

    variant.openers.forEach( ( object ) => peerFrom( object ) );
    variant.modules.forEach( ( object ) => peerFrom( object ) );

  }

  /* */

  function nameForm()
  {
    if( variant.object )
    variant.name = variant.object.absoluteName;
    else if( variant.peer )
    variant.name = variant.peer.name + ' / f::peer';
    // else
    // variant.name = null;
  }

  /* */

  function isOutForm()
  {
    if( variant.object && _.boolLike( variant.object.isOut ) )
    variant.isOut = !!variant.object.isOut;
    else if( variant.peer && variant.peer.object && _.boolLike( variant.peer.object.isOut ) )
    variant.isOut = !variant.peer.object.isOut;
    else
    variant.isOut = _.Will.AbstractModule.PathIsOut( variant.localPath || variant.remotePath );
  }

  /* */

}

//

function mergeIn( variant2 )
{
  let variant = this;

  _.assert( !variant.finitedIs() );
  _.assert( !variant2.finitedIs() );

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
    let localPath, remotePath;
    // [ localPath, remotePath ] = variant.PathsOf( object );
    // if( ( localPath && localPath === variant2.localPath ) || ( remotePath && remotePath === variant2.remotePath ) )
    {
      variant._remove( object );
      variant2._add( object );
    }
    return object;
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

  // if( o.object && o.object.id === 128 )
  // debugger;

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

    // _.assert( localPath === null || variant.localPath === null || variant.localPath === localPath );
    _.assert( remotePath === null || variant.remotePath === null || variant.remotePath === remotePath );
  }

  // if( o.object && o.object.id === 475 )
  // debugger;

  if( !variant )
  variantWithPath();

  _.assert
  (
    !o.relation || ( !!o.relation.opener && o.relation.opener.formed >= 2 ),
    () => `Opener should be formed to level 2 or higher, but opener of ${o.relation.absoluteName} is not`
  )

  // let variant2 = will.objectToVariantHash.get( o.object );
  // if( variant2 && variant2 !== variant )
  // {
  //   _.assert( !!variant2.localPath );
  //   _.assert( !!o.object.localPath );
  //   _.assert( o.object.localPath !== variant2.localPath );
  //   variant2.remove( o.object );
  // }

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

  // _.assert( !!variant.object || variant.finitedIs() );
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
  return will.VariantFrom( variant );
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
    let variant2 = _.any( paths, ( path ) => will.variantMap[ path ] ) || null;
    if( variant2 )
    _.assert( _.all( paths, ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant2 ) );
    _.assert( variant === variant2 );
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

function _relationAdd( relation )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  _.assert( relation instanceof _.Will.ModulesRelation );

  if( !relation.enabled ) /* ttt */
  {
    return false;
  }

  if( !variant.relation )
  {
    variant.relation = relation;
    changed = true;
  }

  changed = _.arrayAppendedOnce( variant.relations, relation ) > -1 || changed;

  let variant2 = will.objectToVariantHash.get( relation );
  _.assert( variant2 === variant || variant2 === undefined );
  will.objectToVariantHash.set( relation, variant );

  let paths = variant.PathsOf( relation );
  _.assert( _.all( paths, ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant ) );

  return changed;
}

//

function relationRemove( relation )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  // _.assert( !!relation.enabled );
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

function _openerAdd( opener )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

  if( opener.superRelation ) /* ttt */
  {
    if( !opener.superRelation.enabled )
    return false;
    _.assert( !!opener.superRelation.enabled );
  }

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

  let paths = variant.PathsOf( opener );
  _.assert( _.all( paths, ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant ) );

  return changed;
}

//

function openerRemove( opener )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

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

  let paths = variant.PathsOf( module );
  _.assert( _.all( paths, ( path ) => will.variantMap[ path ] === undefined || will.variantMap[ path ] === variant ) );

  return changed;
}

//

function moduleRemove( module )
{
  let variant = this;
  let will = variant.will;
  let changed = false;

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

  // if( variant.id === 2 )
  // debugger;

  append( variant );

  if( !variant.peer )
  if( variant.module && variant.module.peerModule )
  {
    debugger;
    _.assert( 0, 'not tested' );
    variant.From({ module : variant2.module.peerModule, will : will });
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

  if( variant.localPath )
  result += `  path::local : ${variant.localPath}\n`;
  if( variant.remotePath )
  result += `  path::remote : ${variant.remotePath}\n`;

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

// --
// etc
// --

function moduleSet( module )
{
  let variant = this;
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

  From,
  PathsOf,
  PathsOfAsMap,
  VariantFrom,
  VariantsFrom,
  VariantOf,
  VariantsOf,

  _relationAdd,
  relationRemove,
  _openerAdd,
  openerRemove,
  _moduleAdd,
  moduleRemove,

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

  // etc

  moduleSet,

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
