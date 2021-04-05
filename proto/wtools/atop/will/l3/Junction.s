// ( function _Junction_s_( ) {
//
// 'use strict';
//
// // if( typeof junction !== 'undefined' )
// // {
// //
// //   require( '../IncludeBase.s' );
// //
// // }
//
// //
//
// const _ = _global_.wTools;
// const Parent = null;
// const Self = wWillJunction;
// function wWillJunction( o )
// {
//   return _.workpiece.construct( Self, this, arguments );
// }
//
// Self.shortName = 'Junction';
//
// // --
// // inter
// // --
//
// function finit()
// {
//   let junction = this;
//   // let sys = junction.sys;
//   _.assert( !junction.isFinited() );
//
//   let objects = junction.objects;
//
//   debugger;
//   _.each( objects, ( object ) => junction._moduleRemove( object ) );
//
//   debugger;
//   junction.ObjectsNames.forEach( ( name ) => /* xxx */
//   {
//     debugger;
//     _.assert( junction[ name ] === null );
//   });
//
//   // _.assert( junction.module === null );
//   // _.assert( junction.opener === null );
//   // _.assert( junction.relation === null );
//   // _.assert( junction.object === null );
//
//   // if( junction.peer )
//   // {
//   //   let peer = junction.peer;
//   //   _.assert( junction.peer.peer === junction )
//   //   peer.peer = null;
//   //   junction.peer = null;
//   //   if( !peer.isUsed() )
//   //   peer.finit();
//   // }
//
//   debugger;
//   for( let v in junction.junctionMap ) /* xxx */
//   {
//     if( junction.junctionMap[ v ] === junction )
//     delete junction.junctionMap[ v ];
//   }
//
//   return _.Copyable.prototype.finit.apply( junction, arguments );
// }
//
// //
//
// function init( o )
// {
//   let junction = this;
//   _.workpiece.initFields( junction );
//   Object.preventExtensions( junction );
//   // _.Will.ResourceCounter += 1;
//   // junction.id = _.Will.ResourceCounter;
//
//   if( o )
//   junction.copy( o );
//
//   if( o )
//   junction.ObjectsNames.forEach( ( name ) => /* xxx */
//   {
//     debugger;
//     if( o[ name ] !== undefined )
//     junction._add( o[ name ] );
//   });
//
//   // if( o.module )
//   // junction._moduleAdd( o.module );
//   // if( o.opener )
//   // junction._openerAdd( o.opener );
//   // if( o.relation )
//   // junction._relationAdd( o.relation );
//   // if( o.object )
//   // junction._add( o.object );
//
//   return junction;
// }
//
// //
//
// function reform()
// {
//   let junction = this;
//   return junction.reformAct();
// }
//
// //
//
// function reformAct()
// {
//   let junction = this;
//   _.assert( 0, 'abstract' );
// }
//
// //
//
// function mergeIn( junction2 )
// {
//   let junction = this;
//   return junction.mergeInAct( junction2 );
// }
//
// //
//
// function mergeInAct( junction2 )
// {
//   let junction = this;
//   _.assert( 0, 'abstract' );
// }
//
// //
//
// function mergeMaybe( usingPath )
// {
//   let junction = this;
//   let junction2;
//   let reset;
//
//   _.assert( arguments.length === 1 );
//
//   let merged = merge();
//
//   if( reset )
//   merge();
//
//   if( !merged && usingPath )
//   {
//
//     junction.localPaths.every( ( localPath ) =>
//     {
//       let junction3 = sys.junctionMap[ localPath ];
//       if( junction3 && junction3 !== junction )
//       {
//         junction.mergeIn( junction3 );
//         return false;
//       }
//       return true;
//     });
//
//     junction.remotePaths.every( ( remotePath ) =>
//     {
//       let junction3 = sys.junctionMap[ remotePath ];
//       if( junction3 && junction3 !== junction )
//       {
//         junction.mergeIn( junction3 );
//         return false;
//       }
//       return true;
//     });
//
//   }
//
//   _.assert( !reset );
//
//   return junction2 || false;
//
//   /* */
//
//   function merge()
//   {
//     reset = false;
//
//     if( objectsMergeMaybe( junction.modules ) )
//     return junction2;
//
//     if( objectsMergeMaybe( junction.openers ) )
//     return junction2;
//
//     if( objectsMergeMaybe( junction.relations ) )
//     return junction2;
//
//     if( objectsMergeMaybe( junction.AssociationsOf( junction.modules ) ) )
//     return junction2;
//
//     if( objectsMergeMaybe( junction.AssociationsOf( junction.openers ) ) )
//     return junction2;
//
//     if( objectsMergeMaybe( junction.AssociationsOf( junction.relations ) ) )
//     return junction2;
//
//     return false;
//   }
//
//
//   /* */
//
//   function objectsMergeMaybe( objects )
//   {
//     _.any( objects, ( object ) =>
//     {
//       junction2 = objectMergeMaybe( object );
//       if( junction2 )
//       return junction2;
//     });
//     return junction2;
//   }
//
//   /* */
//
//   function objectMergeMaybe( object )
//   {
//     let localPath, remotePath;
//
//     let paths = _.mapVals( junction.PathsOf( object ) );
//
//     paths.any( ( thePath ) =>
//     {
//       if( thePath )
//       {
//
//         let junction2 = sys.junctionMap[ thePath ];
//         if( junction2 && junction2 !== junction )
//         {
//           if( junction.mergeIn( junction2 ) )
//           return junction2;
//           return junction2;
//         }
//
//       }
//     });
//
//     let junction3 = sys.objectToJunctionHash.get( object );
//     _.assert( junction3 === undefined || junction3 === junction );
//
//     // {
//     //   let junction3 = sys.objectToJunctionHash.get( object );
//     //   if( junction3 && junction3 !== junction )
//     //   {
//     //     _.assert( 0, 'not tested' );
//     //     reset = 1;
//     //     junction3.mergeIn( junction );
//     //     return junction3;
//     //   }
//     // }
//
//   }
//
// }
//
// //
//
// function From( o )
// {
//   let cls = this;
//   let junction;
//   // let sys = o.sys;
//   // let junctionMap = sys.junctionMap;
//   // const fileProvider = sys.fileProvider;
//   // let path = fileProvider.path;
//   // let logger = sys.logger;
//   let made = false;
//   let changed = false;
//
//   _.assert( arguments.length === 1 );
//   _.assert( _.mapIs( o ) );
//   _.assert( _.mapIs( junctionMap ) );
//
//   if( !o.object )
//   o.object = o.module || o.opener || o.relation;
//
//   if( o.object && o.object instanceof Self )
//   {
//     junction = o.object;
//     return junction;
//   }
//   else if( _.mapIs( o.object ) )
//   {
//     debugger;
//     junction = Self( o.object );
//   }
//   else
//   {
//     junction = sys.objectToJunctionHash.get( o.object );
//     if( junction )
//     {
//       return junction;
//     }
//   }
//
//   if( !junction )
//   junction = junctionWithPath();
//
//   // xxx
//   // _.assert
//   // (
//   //   !o.relation || ( !!o.relation.opener && o.relation.opener.formed >= 2 ),
//   //   () => `Opener should be formed to level 2 or higher, but opener of ${o.relation.absoluteName} is not`
//   // )
//
//   if( junction )
//   junctionUpdate();
//
//   if( !junction )
//   {
//     made = true;
//     changed = true;
//     junction = Self( o );
//   }
//
//   _.assert( !!changed );
//   // if( changed ) /* xxx : switch on the optimization */
//   if( junction.formed !== -1 )
//   junction = junction.reform();
//
//   _.assert( !junction || !junction.isFinited() );
//
//   return junction;
//
//   /* */
//
//   function junctionUpdate()
//   {
//
//     junction.ObjectsNames.forEach( ( name ) => /* xxx */
//     {
//       if( o[ name ] && o[ name ] !== junction )
//       if( !junction.own( o[ name ] ) )
//       changed = junction._add( o[ name ] ) || changed;
//       delete o[ name ];
//     });
//
//     // if( o.object && o.object !== junction )
//     // if( !junction.own( o.object ) )
//     // changed = junction._add( o.object ) || changed;
//     // if( o.module )
//     // if( !junction.own( o.module ) )
//     // changed = junction._add( o.module ) || changed;
//     // if( o.opener )
//     // if( !junction.own( o.opener ) )
//     // changed = junction._add( o.opener ) || changed;
//     // if( o.relation )
//     // if( !junction.own( o.relation ) )
//     // changed = junction._add( o.relation ) || changed;
//     //
//     // delete o.object;
//     // delete o.module;
//     // delete o.opener;
//     // delete o.relation;
//
//     for( let f in o )
//     {
//       if( junction[ f ] !== o[ f ] )
//       {
//         debugger;
//         _.assert( 0, 'not tested' );
//         junction[ f ] = o[ f ];
//         changed = true;
//       }
//     }
//
//   }
//
//   /* */
//
//   function junctionWithPath()
//   {
//     // let paths = cls.PathsOf( o.object );
//     let paths = _.mapVals( cls.PathsOf( o.object ) );
//     return _.any( cls.JunctionWithPath( paths ) );
//     // let localPath, remotePath;
//     //
//     // [ localPath, remotePath ] = cls.PathsOf( o.object );
//     //
//     // if( junctionMap && junctionMap[ localPath ] )
//     // junction = junctionMap[ localPath ];
//     // else if( junctionMap && remotePath && junctionMap[ remotePath ] )
//     // junction = junctionMap[ remotePath ];
//   }
//
//   /* */
//
// }
//
// //
//
// function Reform( sys, o )
// {
//   let cls = this;
//   let result;
//
//   _.assert( arguments.length === 2 );
//   _.assert( !!o );
//
//   if( !_.mapIs( o ) )
//   o = { object : o }
//   if( !o.sys )
//   o.sys = sys;
//
//   let junction = sys.objectToJunctionHash.get( o.object ); /* xxx */
//   if( junction )
//   {
//     junction.reform();
//     return junction;
//   }
//
//   result = cls.From( o );
//
//   return result;
// }
//
// //
//
// function Reforms( sys, junctions )
// {
//   let cls = this;
//   _.assert( arguments.length === 2 );
//   if( _.arrayLike( junctions ) )
//   return _.filter_( null, junctions, ( junction ) => cls.Reform( sys, junction ) );
//   else
//   return cls.Reform( sys, junctions );
// }
//
// //
//
// function JunctionFrom( sys, object )
// {
//   let cls = this;
//   let result;
//
//   _.assert( arguments.length === 2 );
//   _.assert( !!object );
//
//   if( !_.mapIs( object ) )
//   object = { object : object }
//   if( !object.sys )
//   object.sys = sys;
//
//   result = sys.objectToJunctionHash.get( object );
//
//   if( result )
//   {
//     result.assertIntegrityVerify();
//     return result;
//   }
//
//   result = cls.From( object );
//
//   return result;
// }
//
// //
//
// function JunctionsFrom( sys, junctions )
// {
//   let cls = this;
//   _.assert( arguments.length === 2 );
//   if( _.arrayLike( junctions ) )
//   return _.filter_( null, junctions, ( junction ) => cls.JunctionFrom( sys, junction ) );
//   else
//   return cls.JunctionFrom( sys, junctions );
// }
//
// //
//
// function Of( sys, object )
// {
//   let cls = this;
//
//   _.assert( arguments.length === 2 );
//   _.assert( !!object );
//
//   if( object instanceof _.will.Junction )
//   return object;
//
//   let junction = sys.objectToJunctionHash.get( object );
//
//   if( Config.debug )
//   if( junction )
//   {
//     // let paths = cls.PathsOf( object );
//     let paths = _.mapVals( junction.PathsOf( object ) );
//     // let junction2 = _.any( paths, ( path ) => sys.junctionMap[ path ] );
//     let junction2 = _.any( cls.JunctionWithPath( sys, paths ) );
//     if( junction2 )
//     _.assert( _.all( paths, ( path ) => sys.junctionMap[ path ] === undefined || sys.junctionMap[ path ] === junction2 ) );
//     _.assert( junction === junction2 || !junction2 || !junction2.ownSomething() );
//   }
//
//   return junction;
// }
//
// //
//
// function Ofs( sys, junctions )
// {
//   let cls = this;
//   _.assert( arguments.length === 2 );
//   if( _.arrayLike( junctions ) )
//   return _.filter_( null, junctions, ( junction ) => cls.Of( sys, junction ) );
//   else
//   return cls.Of( sys, junctions );
// }
//
// //
//
// function JunctionWithPath( sys, object )
// {
//   let cls = this;
//
//   _.assert( arguments.length === 2 );
//   _.assert( !!object );
//
//   x
//
//   return junction;
// }
//
// //
//
// function JunctionsWithPaths( sys, paths )
// {
//   let cls = this;
//   _.assert( arguments.length === 2 );
//   if( _.arrayLike( paths ) )
//   return _.filter_( null, paths, ( path ) => cls.JunctionWithPath( sys, path ) );
//   else
//   return cls.JunctionWithPath( sys, paths );
// }
//
// //
//
// function PathsOf( object )
// {
//   let cls = this;
//   _.assert( !!object );
//   let result = cls.PathsOfAct( object );
//   _.assert( _.mapIs( result ) );
//   return result;
//
//   // let result = [];
//   // if( object instanceof Self )
//   // {
//   //   let localPath = object.localPath;
//   //   let remotePath = object.remotePath;
//   //   result.push( localPath );
//   //   result.push( remotePath );
//   // }
//   // else if( object instanceof _.will.Module )
//   // {
//   //   let localPath = object.localPath || object.commonPath;
//   //   let remotePath = object.remotePath;
//   //   result.push( localPath );
//   //   result.push( remotePath );
//   // }
//   // else if( object instanceof _.will.ModuleOpener )
//   // {
//   //   let localPath = object.localPath || object.commonPath;
//   //   let remotePath = object.remotePath;
//   //   result.push( localPath );
//   //   result.push( remotePath );
//   // }
//   // else if( object instanceof _.will.ModulesRelation )
//   // {
//   //   let path = object.module.sys.fileProvider.path;
//   //   let localPath = object.localPath;
//   //   let remotePath = object.remotePath;
//   //   result.push( localPath );
//   //   result.push( remotePath );
//   // }
//   // else _.assert( 0 );
//   //
//   // /* xxx */
//   // if( result[ 1 ] && _.strHas( result[ 1 ], 'hd://.' ) )
//   // result[ 1 ] = null;
//   //
//   // return result;
// }
//
// //
//
// function PathsOfAct( object )
// {
//   let cls = this;
//   _.assert( 0, 'abstract' );
//   return result;
// }
//
// // //
// //
// // function PathsOfAsMap( object )
// // {
// //   let result = Object.create( null );
// //
// //   _.assert( !!object );
// //
// //   if( object instanceof Self )
// //   {
// //     result.localPath = object.localPath;
// //     result.remotePath = object.remotePath;
// //   }
// //   else if( object instanceof _.will.Module )
// //   {
// //     result.localPath = object.localPath || object.commonPath;
// //     result.remotePath = object.remotePath;
// //   }
// //   else if( object instanceof _.will.ModuleOpener )
// //   {
// //     result.localPath = object.localPath || object.commonPath;
// //     result.remotePath = object.remotePath;
// //   }
// //   else if( object instanceof _.will.ModulesRelation )
// //   {
// //     let path = object.module.sys.fileProvider.path;
// //     result.localPath = object.localPath;
// //     result.remotePath = object.remotePath;
// //   }
// //   else _.assert( 0 );
// //
// //   return result;
// // }
//
// //
//
// function AssociationsOf( object )
// {
//   let cls = this;
//
//   if( _.arrayIs( object ) )
//   return _.longOnce( _.arrayFlatten( object.map( ( object ) => cls.AssociationsOf( object ) ) ) );
//
//   let result = cls.AssociationsOfAct( object );
//
//   _.assert( _.arrayIs( result ) );
//
//   // let result = [];
//   // if( object instanceof _.will.Module )
//   // {
//   //   return _.each( object.userArray, ( opener ) =>
//   //   {
//   //     if( opener instanceof _.will.ModuleOpener )
//   //     result.push( opener );
//   //   });
//   // }
//   // else if( object instanceof _.will.ModuleOpener )
//   // {
//   //   if( object.openedModule )
//   //   result.push( object.openedModule );
//   //   if( object.superRelation )
//   //   result.push( object.superRelation );
//   // }
//   // else if( object instanceof _.will.ModulesRelation )
//   // {
//   //   if( object.opener )
//   //   result.push( object.opener );
//   //   if( object.opener && object.opener.openedModule )
//   //   result.push( object.opener.openedModule );
//   // }
//   // else _.assert( 0 );
//
//   return result;
// }
//
// //
//
// function AssociationsOfAct()
// {
//   _.assert( 0, 'abstract' );
// }
//
// //
//
// function ObjectToOptionsMap( o )
// {
//   let cls = this;
//
//   if( _.mapIs( o ) )
//   return o;
//
//   _.assert( 0, 'not tested' );
//
//   for( let name in cls.ObjectsClassesMap )
//   {
//     let Node = cls.ObjectsClassesMap[ name ];
//     if( o instanceof Node )
//     return { [ name ] : o }
//   }
//
//   _.assert( 0, `Unknown type of node ${_.entity.strType( o )}` );
//   // if( o instanceof _.will.Module )
//   // {
//   //   return { module : o }
//   // }
//   // else if( o instanceof _.will.ModuleOpener )
//   // {
//   //   return { opener : o }
//   // }
//   // else if( o instanceof _.will.ModulesRelation )
//   // {
//   //   return { relation : o }
//   // }
//   // else _.assert( 0 );
// }
//
// //
//
// function _relationAdd( relation )
// {
//   let junction = this;
//   let sys = junction.sys;
//   let changed = false;
//
//   _.assert( relation instanceof _.will.ModulesRelation );
//
//   // if( !relation.enabled ) /* ttt */
//   // {
//   //   return false;
//   // }
//
//   if( !junction.relation )
//   {
//     junction.relation = relation;
//     changed = true;
//   }
//
//   changed = _.arrayAppendedOnce( junction.relations, relation ) > -1 || changed;
//
//   let junction2 = sys.objectToJunctionHash.get( relation );
//   _.assert( junction.formed === -1 || junction2 === junction || junction2 === undefined );
//   sys.objectToJunctionHash.set( relation, junction );
//
//   _.assert( junction.formed === -1 || changed || _.all( _.mapVals( junction.PathsOf( relation ) ), ( path ) =>
//   {
//     return _.assert( sys.junctionMap[ path ] === undefined || sys.junctionMap[ path ] === junction )
//   });
//
//   return changed;
// }
//
// //
//
// function _relationRemoveSingle( relation )
// {
//   let junction = this;
//   let sys = junction.sys;
//
//   _.assert( relation instanceof _.will.ModulesRelation );
//   _.arrayRemoveOnce( junction.relations, relation );
//
//   if( junction.relation === relation )
//   junction.relation = null;
//   if( junction.object === relation )
//   junction.object = null;
//
//   if( !junction.relation && junction.relations.length )
//   junction.relation = junction.relations[ 0 ];
//
//   let junction2 = sys.objectToJunctionHash.get( relation );
//   _.assert( junction2 === junction );
//   sys.objectToJunctionHash.delete( relation );
//
//   return true;
// }
//
// //
//
// function _relationRemove( relation )
// {
//   let junction = this;
//   let sys = junction.sys;
//
//   if( !_.longHas( junction.relations, relation ) )
//   return false;
//
//   junction._relationRemoveSingle( relation );
//
//   junction._remove( junction.AssociationsOf( relation ) );
//   return true;
// }
//
// //
//
// function _openerAdd( opener )
// {
//   let junction = this;
//   let sys = junction.sys;
//   let changed = false;
//
//   // if( opener.superRelation ) /* ttt */
//   // {
//   //   if( !opener.superRelation.enabled )
//   //   return false;
//   //   _.assert( !!opener.superRelation.enabled );
//   // }
//
//   _.assert( opener instanceof _.will.ModuleOpener );
//
//   if( !junction.opener )
//   {
//     junction.opener = opener;
//     changed = true;
//   }
//
//   changed = _.arrayAppendedOnce( junction.openers, opener ) > -1 || changed;
//
//   let junction2 = sys.objectToJunctionHash.get( opener );
//   _.assert( junction.formed === -1 || junction2 === junction || junction2 === undefined );
//   sys.objectToJunctionHash.set( opener, junction );
//
//   // _.assert( junction.formed === -1 || changed || _.all( junction.PathsOf( opener ), ( path ) => sys.junctionMap[ path ] === undefined || sys.junctionMap[ path ] === junction ) );
//
//   _.assert( junction.formed === -1 || changed || _.all( _.mapVals( junction.PathsOf( opener ) ), ( path ) =>
//   {
//     return _.assert( sys.junctionMap[ path ] === undefined || sys.junctionMap[ path ] === junction )
//   });
//
//   return changed;
// }
//
// //
//
// function _openerRemoveSingle( opener )
// {
//   let junction = this;
//   let sys = junction.sys;
//
//   _.assert( opener instanceof _.will.ModuleOpener );
//   _.arrayRemoveOnceStrictly( junction.openers, opener );
//
//   if( junction.opener === opener )
//   junction.opener = null;
//   if( junction.object === opener )
//   junction.object = null;
//
//   if( !junction.opener && junction.openers.length )
//   junction.opener = junction.openers[ 0 ];
//
//   let junction2 = sys.objectToJunctionHash.get( opener );
//   _.assert( junction2 === junction );
//   sys.objectToJunctionHash.delete( opener );
//
// }
//
// //
//
// function _openerRemove( opener )
// {
//   let junction = this;
//   let sys = junction.sys;
//
//   if( !_.longHas( junction.openers, opener ) )
//   return false;
//
//   junction._openerRemoveSingle( opener );
//
//   junction._remove( junction.AssociationsOf( opener ) );
//   return true;
// }
//
// //
//
// function _moduleAdd( module )
// {
//   let junction = this;
//   let sys = junction.sys;
//   let changed = false;
//
//   _.assert( module instanceof _.will.Module );
//
//   if( !junction.module )
//   {
//     junction.module = module;
//     changed = true;
//   }
//
//   changed = _.arrayAppendedOnce( junction.modules, module ) > -1 || changed;
//
//   let junction2 = sys.objectToJunctionHash.get( module );
//   _.assert( junction2 === junction || junction2 === undefined, 'Module can belong only to one junction' );
//   sys.objectToJunctionHash.set( module, junction );
//
//   // _.assert( junction.formed === -1 || changed || _.all( junction.PathsOf( module ), ( path ) => sys.junctionMap[ path ] === undefined || sys.junctionMap[ path ] === junction ) );
//
//   _.assert( junction.formed === -1 || changed || _.all( _.mapVals( junction.PathsOf( module ) ), ( path ) =>
//   {
//     return _.assert( sys.junctionMap[ path ] === undefined || sys.junctionMap[ path ] === junction )
//   });
//
//   return changed;
// }
//
// //
//
// function _moduleRemoveSingle( module )
// {
//   let junction = this;
//   let sys = junction.sys;
//
//   _.assert( module instanceof _.will.Module );
//   // _.assert( junction.module === module );
//   _.arrayRemoveOnceStrictly( junction.modules, module );
//
//   if( junction.module === module )
//   junction.module = null;
//   if( junction.object === module )
//   junction.object = null;
//
//   if( !junction.module && junction.modules.length )
//   junction.module = junction.modules[ 0 ];
//
//   let junction2 = sys.objectToJunctionHash.get( module );
//   _.assert( junction2 === junction );
//   sys.objectToJunctionHash.delete( module );
//
// }
//
// //
//
// function _moduleRemove( module )
// {
//   let junction = this;
//   let sys = junction.sys;
//
//   if( !_.longHas( junction.modules, module ) )
//   return false;
//
//   junction._moduleRemoveSingle( module );
//
//   junction._remove( junction.AssociationsOf( module ) );
//   return true;
// }
//
// //
//
// function _add( object )
// {
//   let junction = this;
//   let result;
//
//   if( _.arrayIs( object ) )
//   return _.any( _.map_( null, object, ( object ) => junction._add( object ) ) );
//
//   if( object instanceof _.will.ModulesRelation )
//   {
//     result = junction._relationAdd( object );
//   }
//   else if( object instanceof _.will.Module )
//   {
//     result = junction._moduleAdd( object );
//   }
//   else if( object instanceof _.will.ModuleOpener )
//   {
//     result = junction._openerAdd( object );
//   }
//   else _.assert( 0, `Unknown type of object ${_.entity.strType( object )}` );
//
//   return result;
// }
//
// //
//
// function add( object )
// {
//   let junction = this;
//   let result = junction._add( object );
//   junction.reform();
//   return result;
// }
//
// //
//
// function _remove( object )
// {
//   let junction = this;
//
//   if( _.arrayIs( object ) )
//   return _.any( _.map_( null, object, ( object ) => junction._remove( object ) ) );
//
//   if( object instanceof _.will.ModulesRelation )
//   {
//     return junction._relationRemove( object );
//   }
//   else if( object instanceof _.will.Module )
//   {
//     return junction._moduleRemove( object );
//   }
//   else if( object instanceof _.will.ModuleOpener )
//   {
//     return junction._openerRemove( object );
//   }
//   else _.assert( 0 );
//
// }
//
// //
//
// function remove( object )
// {
//   let junction = this;
//   junction._remove( object );
//   return junction.reform();
// }
//
// //
//
// function own( object )
// {
//   let junction = this;
//
//   _.assert( arguments.length === 1 );
//
//   if( object instanceof _.will.Module )
//   {
//     return _.longHas( junction.modules, object );
//   }
//   else if( object instanceof _.will.ModuleOpener )
//   {
//     return _.longHas( junction.openers, object );
//   }
//   else if( object instanceof _.will.ModulesRelation )
//   {
//     return _.longHas( junction.relations, object );
//   }
//   else _.assert( 0 );
//
// }
//
// //
//
// function ownSomething()
// {
//   let junction = this;
//
//   _.assert( arguments.length === 0, 'Expects no arguments' );
//
//   if( junction.modules.length )
//   return true;
//   if( junction.openers.length )
//   return true;
//   if( junction.relations.length )
//   return true;
//
//   return false;
// }
//
// //
//
// function isUsed()
// {
//   let junction = this;
//
//   _.assert( arguments.length === 0, 'Expects no arguments' );
//
//   if( junction.ownSomething() )
//   return true;
//
//   if( junction.peer )
//   if( junction.peer.ownSomething() )
//   return true;
//
//   return false;
// }
//
// //
//
// function submodulesJunctionsFilter( o )
// {
//   let junction = this;
//   let sys = junction.sys;
//   let result = [];
//
//   o = _.routineOptions( submodulesJunctionsFilter, arguments );
//
//   let filter = _.mapOnly_( null, o, sys.relationFit.defaults );
//
//   // if( _global_.debugger === 1 )
//   // debugger;
//
//   junctionLook( junction );
//
//   if( !junction.peer )
//   if( junction.module && junction.module.peerModule )
//   {
//     debugger;
//     junction.From({ module : junction.module.peerModule, sys : sys });
//     _.assert( _.longHas( junction.peer.modules, junction.module.peerModule ) );
//   }
//
//   if( o.withPeers )
//   if( junction.peer )
//   junctionLook( junction.peer );
//
//   // if( _global_.debugger === 1 )
//   // debugger;
//
//   if( o.withoutDuplicates )
//   result = result.filter( ( junction ) =>
//   {
//     return !junction.isOut || !_.longHas( result, junction.peer );
//   });
//
//   // if( _global_.debugger === 1 )
//   // debugger;
//
//   return result;
//
//   /* */
//
//   function junctionLook( junction )
//   {
//
//     // if( _global_.debugger )
//     // if( junction.id === 176 )
//     // debugger;
//
//     // if( junction.module )
//     junction.modules.forEach( ( module ) =>
//     {
//       for( let s in module.submoduleMap )
//       {
//         let relation = module.submoduleMap[ s ];
//
//         // let junction2 = junction.Of( sys, relation );
//         // if( !junction2 )
//         let junction2 = junction.From({ relation : relation, sys : sys });
//         _.assert( !!junction2 );
//
//         if( !junction2.peer )
//         if( junction2.module && junction2.module.peerModule )
//         {
//           debugger;
//           _.assert( 0, 'not tested' );
//           junction2.From({ module : junction2.module.peerModule, sys : sys });
//         }
//
//         /*
//         getting shadow sould go after setting up junction
//         */
//
//         // junction2 = junction2.shadow({ relation })
//         junctionAppendMaybe( junction2 );
//
//         if( o.withPeers )
//         if( junction2.peer )
//         junctionAppendMaybe( junction2.peer );
//
//       }
//     });
//
//   }
//
//   /* */
//
//   function junctionAppendMaybe( junction )
//   {
//
//     if( !sys.relationFit( junction, filter ) )
//     return;
//
//     _.assert( junction instanceof _.will.Junction );
//     _.arrayAppendOnce( result, junction );
//
//   }
//
//   /* */
//
// }
//
// submodulesJunctionsFilter.defaults =
// {
//
//   ... _.Will.RelationFilterDefaults,
//   withPeers : 1,
//   withoutDuplicates : 0,
//
// }
//
// //
//
// function shadow( o )
// {
//   let junction = this;
//   let sys = junction.sys;
//
//   if( !_.mapIs( o ) )
//   o = junction.ObjectToOptionsMap( o );
//
//   o = _.routineOptions( shadow, o );
//   _.assert( arguments.length === 1 );
//
//   let shadowMap = _.mapExtend( null, o );
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
//     shadowMap.peer = junction.Of( sys, peerModule );
//     if( !shadowMap.peer )
//     shadowMap.peer = junction.JunctionFrom( sys, peerModule );
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
// //
//
// function assertIntegrityVerify()
// {
//   let junction = this;
//   let sys = junction.sys;
//   let objects = junction.objects;
//
//   objects.forEach( ( object ) =>
//   {
//     _.assert( sys.objectToJunctionHash.get( object ) === junction, `Integrity of ${junction.nameWithLocationGet()} is broken. Another junction has this object.` );
//     _.assert( _.longHasAll( objects, junction.AssociationsOf( object ) ), `Integrity of ${junction.nameWithLocationGet()} is broken. One or several associations are no in the list.` );
//     let p = junction.PathsOfAsMap( object );
//     _.assert( !p.localPath || _.longHas( junction.localPaths, p.localPath ), `Integrity of ${junction.nameWithLocationGet()} is broken. Local path ${p.localPath} is not in the list` );
//     _.assert( !p.remotePath || _.longHas( junction.remotePaths, p.remotePath ), `Integrity of ${junction.nameWithLocationGet()} is broken. Remote path ${p.remotePath} is not in the list` );
//   });
//
//   return true;
// }
//
// //
//
// function toModule()
// {
//   let junction = this;
//   return junction.module;
// }
//
// //
//
// function toRelation()
// {
//   let junction = this;
//   return junction.relation;
// }
//
// //
//
// function toJunction()
// {
//   let junction = this;
//   return junction;
// }
//
// // --
// // export
// // --
//
// function exportString()
// {
//   let result = '';
//   let junction = this;
//
//   result += `junction:: : #${junction.id}\n`;
//
//   let lpl = ' ';
//   if( junction.localPaths.length > 1 )
//   lpl = ` ( ${junction.localPaths.length} ) `;
//   if( junction.localPath )
//   result += `  path::local${lpl}: ${junction.localPath}\n`;
//
//   let rpl = ' ';
//   if( junction.remotePaths.length > 1 )
//   rpl = ` ( ${junction.remotePaths.length} ) `;
//   if( junction.remotePath )
//   result += `  path::remote${rpl}: ${junction.remotePath}\n`;
//
//   if( junction.modules.length )
//   {
//     result += '  ' + junction.module.absoluteName + ' #' + junction.modules.map( ( m ) => m.id ).join( ' #' ) + '\n';
//   }
//   if( junction.opener )
//   {
//     result += '  ' + junction.opener.absoluteName + ' #' + junction.openers.map( ( m ) => m.id ).join( ' #' ) + '\n';
//   }
//   if( junction.relation )
//   {
//     result += '  ' + junction.relation.absoluteName + ' #' + junction.relations.map( ( m ) => m.id ).join( ' #' ) + '\n';
//   }
//   if( junction.peer )
//   {
//     result += `  peer::junction : #${junction.peer.id}\n`;
//   }
//
//   return result;
// }
//
// //
//
// function nameWithLocationGet()
// {
//   let junction = this;
//   let name = _.color.strFormat( junction.object.qualifiedName || junction.name, 'entity' );
//   let localPath = _.color.strFormat( junction.localPath, 'path' );
//   let result = `${name} at ${localPath}`;
//   return result;
// }
//
// // --
// // etc
// // --
//
// function moduleSet( module )
// {
//   let junction = this;
//   junction[ moduleSymbol ] = module;
//   return module;
// }
//
// //
//
// function dirPathGet()
// {
//   let junction = this;
//   if( !junction.localPath )
//   return null;
//   let sys = junction.sys;
//   const fileProvider = sys.fileProvider;
//   let path = fileProvider.path;
//   return path.detrail( path.dirFirst( junction.localPath ) );
// }
//
// //
//
// function enabledGet()
// {
//   let junction = this;
//   let result = null;
//
//   if( junction.module )
//   result = junction.module.about.enabled;
//   else if( junction.peer && junction.peer.module )
//   result = junction.peer.module.enabled;
//
//   _.assert( result === null || _.boolIs( result ) );
//   return result;
// }
//
// //
//
// function isRemoteGet()
// {
//   let junction = this;
//   let result = null;
//
//   if( junction.module && junction.module.repo )
//   result = junction.module.repo.isRemote;
//   else if( junction.opener && junction.opener.repo )
//   result = junction.opener.repo.isRemote;
//   else if( junction.peer && junction.peer.module && junction.peer.module.repo )
//   result = junction.peer.module.repo.isRemote;
//   else if( junction.peer && junction.peer.opener && junction.peer.opener.repo )
//   result = junction.peer.opener.repo.isRemote;
//
//   _.assert( result === null || _.boolIs( result ) );
//   return result;
// }
//
// //
//
// function objectsGet()
// {
//   let junction = this;
//   let result = [];
//
//   _.each( junction.modules, ( module ) => result.push( module ) );
//   _.each( junction.openers, ( opener ) => result.push( opener ) );
//   _.each( junction.relations, ( relation ) => result.push( relation ) );
//
//   return result;
// }
//
// // --
// // relations
// // --
//
// let moduleSymbol = Symbol.for( 'module' );
//
// let Composes =
// {
// }
//
// let Aggregates =
// {
// }
//
// let Associates =
// {
//
//   sys : null,
//
// }
//
// let Medials =
// {
//
//   module : null,
//   opener : null,
//   relation : null,
//   object : null,
//
// }
//
// let Restricts =
// {
//
//   name : null,
//   id : null,
//   isOut : null,
//   formed : 0,
//
//   localPath : null,
//   localPaths : _.define.own([]),
//   remotePath : null,
//   remotePaths : _.define.own([]),
//
//   module : null,
//   modules : _.define.own([]),
//   opener : null,
//   openers : _.define.own([]),
//   relation : null,
//   relations : _.define.own([]),
//   object : null,
//   peer : null,
//
// }
//
// let Statics =
// {
//
//   ObjectsClassesMap : null,
//   ObjectsNames : null,
//
//   From,
//   Reform,
//   Reforms,
//   JunctionFrom,
//   JunctionsFrom,
//   Of,
//   Ofs,
//
//   PathsOf,
//   PathsOfAct,
//   // PathsOfAsMap,
//
//   AssociationsOf,
//   AssociationsOfAct,
//   ObjectToOptionsMap,
// }
//
// let Forbids =
// {
//   recordsMap : 'recordsMap',
//   commonPath : 'commonPath',
//   nodesGroup : 'nodesGroup',
//   junctionMap : 'junctionMap',
// }
//
// let Accessors =
// {
//   dirPath : { get : dirPathGet, writable : 0 },
//   enabled : { get : enabledGet, writable : 0 },
//   isRemote : { get : isRemoteGet, writable : 0 },
//   objects : { get : objectsGet, writable : 0 },
// }
//
// // --
// // declare
// // --
//
// let Extension =
// {
//
//   // inter
//
//   finit,
//   init,
//   reform,
//   reformAct,
//   mergeIn,
//   mergeInAct,
//   mergeMaybe,
//
//   From,
//   Reform,
//   Reforms,
//   JunctionFrom,
//   JunctionsFrom,
//   Of,
//   Ofs,
//   JunctionWithPath,
//   JunctionsWithPaths,
//
//   PathsOf,
//   PathsOfAct,
//   // PathsOfAsMap, /* xxx : remove */
//
//   AssociationsOf,
//   AssociationsOfAct,
//   ObjectToOptionsMap,
//
//   _relationAdd,
//   _relationRemoveSingle,
//   _relationRemove,
//   _openerAdd,
//   _openerRemoveSingle,
//   _openerRemove,
//   _moduleAdd,
//   _moduleRemoveSingle,
//   _moduleRemove,
//
//   _add,
//   add,
//   _remove,
//   remove,
//   own,
//   ownSomething,
//   isUsed,
//   submodulesJunctionsFilter,
//   shadow,
//   assertIntegrityVerify,
//   toModule,
//   toRelation,
//   toJunction,
//
//   // export
//
//   exportString,
//   nameWithLocationGet,
//
//   // etc
//
//   moduleSet,
//   dirPathGet,
//   enabledGet,
//   isRemoteGet,
//   objectsGet,
//
//   // relation
//
//   Composes,
//   Aggregates,
//   Associates,
//   Medials,
//   Restricts,
//   Statics,
//   Forbids,
//   Accessors,
//
// }
//
// _.classDeclare
// ({
//   cls : Self,
//   parent : Parent,
//   extend : Extension,
// });
//
// _.Copyable.mixin( Self );
//
// if( typeof module !== 'undefined' )
// module[ 'exports' ] = _global_.wTools;
//
// _.will[ Self.shortName ] = Self;
//
// // _.staticDeclare
// // ({
// //   prototype : _.Will.prototype,
// //   name : Self.shortName,
// //   value : Self,
// // });
//
// })();
