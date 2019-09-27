// ( function _RemoteServlet_ss_() {
//
// 'use strict';  xxx
//
// if( typeof module !== 'undefined' )
// {
//
//   let _ = require( '../../../Tools.s' );
//
//   _.include( 'wFiles' );
//   _.include( 'wServlet' );
//   _.include( 'wCommunicator' );
//
//   let Https = require( 'https' );
//   let Http = require( 'http' );
//   let Express = require( 'express' );
//
//   Express.Logger = require( 'morgan' );
//   /* Express.Directory = require( 'serve-index' ); */
//
// }
// let _global = _global_;
// let _ = _global_.wTools;
//
// //
//
// let Parent = null;
// let Self = function wRemoteServerForFileProvider( o )
// {
//   return _.workpiece.construct( Self, this, arguments );
// }
//
// Self.shortName = 'RemoteServerForFileProvider';
//
// // --
// // inter
// // --
//
// function init( o )
// {
//   let self = this;
//
//   _.workpiece.initFields( self );
//
//   if( self.Self === Self )
//   Object.preventExtensions( self );
//
//   if( o )
//   self.copy( o );
//
// }
//
// //
//
// function form()
// {
//   let self = this;
//
//   _.assert( arguments.length === 0 );
//
//   if( !self.fileProvider )
//   self.fileProvider = _.fileProvider;
//
//   self.communicator = wCommunicator
//   ({
//     verbosity : 5,
//     isMaster : 1,
//     url : self.url,
//   })
//
//   self.communicator.form();
//
//   return self;
// }
//
// // function form()
// // {
// //   let self = this;
// //
// //   _.assert( arguments.length === 0 );
// //
// //   if( !self.fileProvider )
// //   self.fileProvider = _.fileProvider;
// //
// //   /* */
// //
// //   if( !self.express )
// //   self.express = Express();
// //   let express = self.express;
// //
// //   _.servlet.controlLoggingPre.call( self );
// //
// //   /* */
// //
// //   if( self.defaultMime )
// //   Express.static.mime.default_type = self.defaultMime;
// //
// //   /* */
// //
// //   _.servlet.controlPathesNormalize.call( self );
// //
// //   self.path = self.path.join( self.path.pathCurrent(),self.path );
// //
// //   /* */
// //
// //   if( self.port )
// //   express.use( _.routineJoin( self,self.requestPreHandler ) );
// //
// //   if( self.port )
// //   {
// //     if( Config.debug && self.verbosity )
// //     express.use( Express.Logger( 'dev' ) );
// //   }
// //
// //   // express.use( self.url,Express.static( self.path ) );
// //   // express.use( self.url,Express.Directory( self.path,self.directoryOptions ) );
// //
// //   express.use( _.routineJoin( self,self.requestHandler ) );
// //
// //   if( self.port )
// //   express.use( _.routineJoin( self,self.requestPostHandler ) );
// //
// //   /* */
// //
// //   _.servlet.controlLoggingPost.call( self );
// //   _.servlet.controlExpressStart.call( self );
// //
// //   /* */
// //
// //   return self;
// // }
//
// //
//
// function exec()
// {
//   _.assert( !_.instanceIs( this ) );
//
//   let self = new _.constructorOf( this )();
//   let args = _.process.args();
//
//   if( args.subject )
//   self.path = self.path.join( self.path.current(), args.subject );
//
//   return self.form();
// }
//
// // --
// //
// // --
//
// function requestPreHandler( request, response, next )
// {
//   let self = this;
//
//   _.servlet.controlRequestPreHandle.call( self, request, response, next );
//
//   next();
// }
//
// //
//
// function requestHandler( request, response, next )
// {
//   let self = this;
//
//   debugger;
//
// }
//
// //
//
// function requestPostHandler( request, response, next )
// {
//   let self = this;
//
//   _.servlet.controlRequestPostHandle.call( self, request, response, next );
//
// }
//
// // --
// // relationship
// // --
//
// let Composes =
// {
//   name : Self.name,
//   verbosity : 1,
//   path : '.',
//   url : 'tcp://127.0.0.1:61726',
//   // port : 0xF11E,
//   // usingHttps : 0,
//   // allowCrossDomain : 1,
// }
//
// let Aggregates =
// {
// }
//
// let Associates =
// {
//   fileProvider : null,
//   communicator : null,
//   // express : null,
//   // server : null,
// }
//
// let Restricts =
// {
// }
//
// let Statics =
// {
//   exec : exec,
// }
//
// // --
// // prototype
// // --
//
// let Proto =
// {
//
//   // inter
//
//   init : init,
//   form : form,
//   exec : exec,
//
//   requestPreHandler : requestPreHandler,
//   requestHandler : requestHandler,
//   requestPostHandler : requestPostHandler,
//
//   //
//
//
//   Composes : Composes,
//   Aggregates : Aggregates,
//   Associates : Associates,
//   Restricts : Restricts,
//   Statics : Statics,
//
// }
//
// //
//
// _.classDeclare
// ({
//   cls : Self,
//   parent : Parent,
//   extend : Proto,
// });
//
// _.Copyable.mixin( Self );
//
// //
//
// _global_[ Self.name ] = _[ Self.shortName ] = Self;
//
// if( typeof module !== 'undefined' && !module.parent )
// _global_.server = Self.exec();
//
// // --
// // export
// // --
//
// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }
//
// if( typeof module !== 'undefined' && module !== null )
// module[ 'exports' ] = Self;
//
// })();
