// ( function _Svn_ss_() {
//
// 'use strict'; 
//
// if( typeof module !== 'undefined' )
// {
//   let _global = _global_;
//   let _ = _global_.wTools;
//
//   if( !_.FileProvider )
//   require( '../UseMid.s' );
//
//   let Svn;
//
// }
// let _global = _global_;
// let _ = _global_.wTools;
// let FileRecord = _.FileRecord;
//
// //
//
// let Parent = _.FileProvider.Partial;
// let Self = function wFileProviderSvn( o )
// {
//   return _.workpiece.construct( Self, this, arguments );
// }
//
// Self.shortName = 'Svn';
//
// // --
// // inter
// // --
//
// function init( o )
// {
//   let self = this;
//   Parent.prototype.init.call( self,o );
//   self.form();
// }
//
// //
//
// function finit( o )
// {
//   let self = this;
//   self.unform();
//   Parent.prototype.finit.call( self,o );
// }
//
// //
//
// function form( o )
// {
//   let self = this;
//
//   if( !Svn )
//   Svn = require( 'node-svn-ultimate' );
//
//   self.tempPath = self.path.dirTempAtOpen();
//
//   if( !self.hardDrive )
//   self.hardDrive = new _.FileProvider.HardDrive();
//
//   _.assert( self.hardDrive instanceof _.FileProvider.HardDrive )
//
// }
//
// //
//
// function unform( o )
// {
//   let self = this;
//
//   if( self.tempPath )
//   {
//     _.fileProvider.filesDelete( self.tempPath );
//     self.tempPath = null;
//   }
//
// }
//
// // --
// // adapter
// // --
//
// // function localFromGlobal( url )
// // {
// //   let self = this;
// //
// //   if( _.strIs( url ) )
// //   return url;
// //
// //   _.assert( _.mapIs( url ) ) ;
// //   _.assert( arguments.length === 1, 'Expects single argument' );
// //
// //   return _.uri.str( url );
// // }
//
// // --
// // read
// // --
//
// function _fileDownload( filePath )
// {
//   let self = this;
//   let con = new _.Consequence();
//
//   let remoteUrl = _.uri.join( remoteUrl, filePath );
//   let tempPath = self.path.join( self.tempPath, filePath );
//
//   Svn.commands.checkout( remoteUrl, tempPath, function( err )
//   {
//     if( err )
//     con.error( _.err( err ) );
//   });
//
//   con.ifNoErrorThen( function( arg )
//   {
//     return tempPath;
//   });
//
//   return con;
// }
//
// //
//
// function fileReadAct( o )
// {
//   let self = this;
//   let stack = '';
//   let result = null;
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.routineOptions( fileReadAct,o );
//   _.assert( !o.sync,'not implemented' );
//
//   if( 0 )
//   if( Config.debug )
//   stack = _._err({ usingSourceCode : 0, args : [] });
//
//   let encoder = fileReadAct.encoders[ o.encoding ];
//
//   /* begin */
//
//   function handleBegin()
//   {
//
//     if( encoder && encoder.onBegin )
//     _.sure( encoder.onBegin.call( self,{ operation : o, encoder : encoder }) === undefined ); // xxx
//
//   }
//
//   /* end */
//
//   function handleEnd( data )
//   {
//
//     if( encoder && encoder.onEnd )
//     data = encoder.onEnd.call( self,{ data : data, operation : o, encoder : encoder })
//
//     if( o.sync )
//     return data;
//     else
//     return con.take( data );
//
//   }
//
//   /* error */
//
//   function handleError( err )
//   {
//
//     if( encoder && encoder.onError )
//     try
//     {
//       err = _._err
//       ({
//         args : [ stack,'\nfileReadAct( ',o.filePath,' )\n',err ],
//         usingSourceCode : 0,
//         level : 0,
//       });
//       err = encoder.onError.call( self,{ error : err, operation : o, encoder : encoder })
//     }
//     catch( err2 )
//     {
//       console.error( err2 );
//       console.error( err.toString() + '\n' + err.stack );
//     }
//
//     if( o.sync )
//     throw err;
//     else
//     return con.error( err );
//
//   }
//
//   /* exec */
//
//   handleBegin();
//
//   if( o.sync )
//   {
//
//     result = File.readFileSync( o.filePath,o.encoding === 'buffer' ? undefined : o.encoding );
//
//     return handleEnd( result );
//   }
//   else
//   {
//     let con = self._fileDownload( o.filePath );
//
//     con.ifNoErrorThen( function( filePath )
//     {
//       let options = _.mapExtend( null,o );
//       o.filePath = filePath;
//       return self.hardDrive.fileRead( o );
//     });
//
//     return con;
//   }
//
// }
//
// fileReadAct.defaults = {};
// fileReadAct.defaults.__proto__ = Parent.prototype.fileReadAct.defaults;
// fileReadAct.isOriginalReader = 1;
//
// //
//
// function statReadAct( o )
// {
//   let self = this;
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( o.filePath ) );
//   _.assert( !o.sync,'not implemented' );
//
//   o = _.routineOptions( statReadAct,o );
//   let result = null;
//
//   /* */
//
//   debugger;
//
//   let stat = Object.create( null );
//   stat.ino = 0;
//   stat.dev = 0;
//   stat.nlink = 1;
//
//   result = self._fileDownload.ifNoErrorThen( function( filePath )
//   {
//     let localStat = self.hardDrive.statResolvedRead({ filePath : filePath });
//     stat.size = localStat.size;
//     return stat;
//   });
//
//   // dev: 2114,
//   // ino: 48064969,
//   // mode: 33188,
//   // nlink: 1,
//   // uid: 85,
//   // gid: 100,
//   // rdev: 0,
//   // size: 527,
//   // blksize: 4096,
//   // blocks: 8,
//   // atimeMs: 1318289051000.1,
//   // mtimeMs: 1318289051000.1,
//   // ctimeMs: 1318289051000.1,
//   // birthtimeMs: 1318289051000.1,
//   // atime: Mon, 10 Oct 2011 23:24:11 GMT,
//   // mtime: Mon, 10 Oct 2011 23:24:11 GMT,
//   // ctime: Mon, 10 Oct 2011 23:24:11 GMT,
//   // birthtime: Mon, 10 Oct 2011 23:24:11 GMT
//
//   debugger;
//
//   return stat;
// }
//
// statReadAct.defaults = {};
// statReadAct.defaults.__proto__ = Parent.prototype.statReadAct.defaults;
//
// //
//
// function dirReadAct( o )
// {
//   let self = this;
//   o = _.routineOptions( dirReadAct,o );
//
//   _.assert( o.sync );
//
//   debugger; xxx
//
//   let result = Svn.commands.list();
//
//   return result;
// }
//
// dirReadAct.defaults = {};
// dirReadAct.defaults.__proto__ = Parent.prototype.dirReadAct.defaults;
//
// // --
// // encoder
// // --
//
// var encoders = {};
// fileReadAct.encoders = encoders;
//
// // --
// // relationship
// // --
//
// let Composes =
// {
//   protocols : [ 'svn' ],
//   // define classcols : [ 'svn' ],
//   // originPath : null,
//   remoteUrl : null,
//   tempPath : null
// }
//
// let Aggregates =
// {
// }
//
// let Associates =
// {
//   hardDrive : null,
// }
//
// let Restricts =
// {
// }
//
// let Statics =
// {
// }
//
// // --
// // declare
// // --
//
// let Proto =
// {
//
//   // inter
//
//   init : init,
//   finit : finit,
//
//   form : form,
//   unform : unform,
//
//
//   // adapter
//
//   localFromGlobal : localFromGlobal,
//
//
//   // read
//
//   _fileDownload : _fileDownload,
//
//   fileReadAct : fileReadAct,
//   streamReadAct : null,
//   statReadAct : statReadAct,
//
//   dirReadAct : dirReadAct,
//
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
// _.FileProvider.Find.mixin( Self );
// _.FileProvider.Secondary.mixin( Self );
// // if( _.FileProvider.Path )
// // _.FileProvider.Path.mixin( Self );
//
// //
//
// _.FileProvider[ Self.shortName ] = Self;
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
