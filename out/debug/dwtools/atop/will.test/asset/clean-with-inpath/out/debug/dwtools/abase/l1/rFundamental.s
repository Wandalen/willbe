// ( function _aFundamental_s_() {
//
// 'use strict';
//
// // fast access
//
// let _global = _global_;
// let _ = _global_.wTools;
// let Self = _global_.wTools;
//
// let _ArrayIndexOf = Array.prototype.indexOf;
// let _ArrayLastIndexOf = Array.prototype.lastIndexOf;
// let _ArraySlice = Array.prototype.slice;
// let _ArraySplice = Array.prototype.splice;
// let _FunctionBind = Function.prototype.bind;
// let _ObjectToString = Object.prototype.toString;
// let _ObjectHasOwnProperty = Object.hasOwnProperty;
// let _propertyIsEumerable = Object.propertyIsEnumerable;
// let _ceil = Math.ceil;
// let _floor = Math.floor;
//
// // --
// // meta
// // --
//
// _.Later = function Later()
// {
//   let d = Object.create( null );
//   d.args = arguments;
//   _.Later._lates.push( d );
//   return d;
// }
//
// //
//
// _.Later.replace = function replace( container )
// {
//   if( arguments.length !== 1 || !container )
//   throw Error( 'Expects single argument {-container-}' );
//   if( !_.Later._lates.length )
//   throw Error( 'No late was done' );
//
//   // debugger;
//   let descriptors = _.Later._associatedMap.get( container ) || [];
//   _.Later._associatedMap.set( container, descriptors );
//   _.Later._lates.forEach( ( d ) =>
//   {
//     d.container = container;
//     // _.Later._associatedLates.push( d );
//     descriptors.push( d );
//   });
//   _.Later._lates = [];
//   // debugger;
//
// }
//
// //
//
// _.Later.for = function for_( container )
// {
//   if( arguments.length !== 1 || !container )
//   throw Error( 'Expects single argument {-container-}' );
//
//   let descriptors = _.Later._associatedMap.get( container );
//   _.Later._associatedMap.delete( container );
//
//   if( !descriptors )
//   throw Error( 'No laters for {-container-} was made' );
//
//   // debugger;
//
//   for( let k in container )
//   {
//     let d = container[ k ];
//     let i = descriptors.indexOf( d );
//     if( i !== -1 )
//     {
//       descriptors.splice( i,1 );
//       _.Later._for( k,d );
//     }
//   }
//
//   // debugger;
//
//   if( descriptors.length )
//   throw Error( 'Some laters was not found in the {-container-}' );
//
// }
//
// //
//
// _.Later._for = function _for( key, descriptor )
// {
//
//   if( descriptor.args.length === 3 )
//   if( !_.arrayIs( descriptor.args[ 2 ] ) )
//   descriptor.args[ 2 ] = [ descriptor.args[ 2 ] ];
//
//   // debugger;
//   descriptor.container[ key ] = _.routineCall.apply( _, descriptor.args );
//   // debugger;
//
// }
//
// //
//
// _.Later._lates = [];
// _.Later._associatedMap = new Map();
//
// // --
// // fields
// // --
//
// let Fields =
// {
// }
//
// // --
// // routines
// // --
//
// let Routines =
// {
//
// }
//
// //
//
// Object.assign( Self, Routines );
// Object.assign( Self, Fields );
//
// _.assert( !Self.Array );
//
// // _.assert( !Self.array );
// // _.assert( !Self.withArray );
// // _.assert( _.objectIs( _.strIsolateBeginOrAll ) )
// // _.assert( _.objectIs( _.regexpsEscape ) );
//
// // _.Later.replace( Self );
//
// // --
// // export
// // --
//
// if( typeof module !== 'undefined' )
// if( _global.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }
//
// if( typeof module !== 'undefined' && module !== null )
// module[ 'exports' ] = Self;
//
// })();
