// ( function _RemoteClient_s_() {
//
// 'use strict'; 
//
// if( typeof module !== 'undefined' )
// {
//
//   let _ = require( '../../../Tools.s' );
//
//   _.include( 'wFiles' );
//   _.include( 'wCommunicator' );
//
// }
//
// let _global = _global_;
// let _ = _global_.wTools;
// let FileRecord = _.FileRecord;
//
// //
//
// let Parent = _.FileProvider.Partial;
// let Self = function wFileProviderRemote( o )
// {
//   return _.workpiece.construct( Self, this, arguments );
// }
//
// Self.shortName = 'Remote';
//
// // --
// // inter
// // --
//
// function init( o )
// {
//   let self = this;
//   Parent.prototype.init.call( self,o );
// }
//
// //
//
// function form()
// {
//   let self = this;
//
//   _.assert( self.serverUrl,'needs field { serverUrl }' );
//
//   self.communicator = wCommunicator
//   ({
//     verbosity : 5,
//     isMaster : 0,
//     url : self.serverUrl,
//   });
//
//   self.communicator.form();
//
//   return self;
// }
//
// //
//
// function exec()
// {
//   let self = new Self
//   ({
//     serverUrl : 'tcp://127.0.0.1:61726',
//   });
//
//   self.form();
//
//   return self;
//
//   self.fileRead({ filePath : './builder/Clean', sync : 0 }).finally( function( err,arg )
//   {
//     if( err )
//     throw _.errLogOnce( err );
//     logger.log( 'fileRead',arg );
//   });
//
//   return self;
// }
//
// // --
// // adapter
// // --
//
// function localFromGlobal( url )
// {
//   let self = this;
//
//   if( _.strIs( url ) )
//   url = _.uri.parse( url );
//
//   _.assert( _.mapIs( url ) ) ;
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( url.localPath );
//
//   return url.localPath;
// }
//
// // --
// // read
// // --
//
// function fileReadAct( o )
// {
//   let self = this;
//   let con;
//   let stack = '';
//   let result = null;
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.routineOptions( fileReadAct,o );
//   _.assert( !o.sync );
//
//   if( 0 )
//   if( Config.debug )
//   stack = _._err({ usingSourceCode : 0, args : [] });
//
//   let encoder = fileReadAct.encoders[ o.encoding ];
//
//   /* exec */
//
//   handleBegin();
//
//   o.sync = 0;
//
//   let result = self.fileProvider.fileReadAct( o );
//
//   return result;
//
//   /* begin */
//
//   function handleBegin()
//   {
//
//     if( encoder && encoder.onBegin )
//     _.sure( encoder.onBegin.call( self,{ operation : o, encoder : encoder }) === undefined );
//
//   }
//
//   /* end */
//
//   function handleEnd( data )
//   {
//
//     if( encoder && encoder.onEnd )
//     _.sure( encoder.onEnd.call( self,{ data : data, operation : o, encoder : encoder }) === undefined ); // xxx
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
// }
//
// fileReadAct.defaults = {};
// fileReadAct.defaults.__proto__ = Parent.prototype.fileReadAct.defaults;
//
// //
//
// function streamReadAct( o )
// {
//   if( _.strIs( o ) )
//   o = { filePath : o };
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( o.filePath ) );
//
//   let o = _.routineOptions( streamReadAct, o );
//   let stream = null;
//
//   if( o.sync )
//   {
//     try
//     {
//       stream = File.createReadStream( o.filePath );
//     }
//     catch( err )
//     {
//       throw _.err( err );
//     }
//     return stream;
//   }
//   else
//   {
//     let con = new _.Consequence();
//     try
//     {
//       stream = File.createReadStream( o.filePath );
//       con.take( stream );
//     }
//     catch( err )
//     {
//       con.error( err );
//     }
//     return con;
//   }
//
// }
//
// streamReadAct.defaults = {};
// streamReadAct.defaults.__proto__ = Parent.prototype.streamReadAct.defaults;
//
// //
//
// function statReadAct( o )
// {
//
//   if( _.strIs( o ) )
//   o = { filePath : o };
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( o.filePath ) );
//
//   let o = _.routineOptions( statReadAct,o );
//   let result = null;
//
//   /* */
//
//   if( o.sync )
//   {
//     try
//     {
//       if( o.resolvingSoftLink )
//       result = File.statSync( o.filePath );
//       else
//       result = File.lstatSync( o.filePath );
//     }
//     catch ( err )
//     {
//       if( o.throwing )
//       throw err;
//     }
//     return result;
//   }
//   else
//   {
//     let con = new _.Consequence();
//
//     function handleEnd( err, stats )
//     {
//       if( err )
//       {
//         if( o.throwing )
//         con.error( err );
//         else
//         con.take( result );
//       }
//       else
//       con.take( stats );
//     }
//
//     if( o.resolvingSoftLink )
//     File.stat( o.filePath,handleEnd );
//     else
//     File.lstat( o.filePath,handleEnd );
//
//     return con;
//   }
//
// }
//
// statReadAct.defaults = {};
// statReadAct.defaults.__proto__ = Parent.prototype.statReadAct.defaults;
//
// //
//
// let hashReadAct = ( function()
// {
//
//   let crypto;
//
//   return function hashReadAct( o )
//   {
//     let result = NaN;
//     let self = this;
//
//     if( _.strIs( o ) )
//     o = { filePath : o };
//
//     _.routineOptions( hashReadAct,o );
//     _.assert( _.strIs( o.filePath ) );
//     _.assert( arguments.length === 1, 'Expects single argument' );
//
//     /* */
//
//     if( !crypto )
//     crypto = require( 'crypto' );
//     let md5sum = crypto.createHash( 'md5' );
//
//     /* */
//
//     if( o.sync )
//     {
//
//       try
//       {
//         let read = File.readFileSync( o.filePath );
//         md5sum.update( read );
//         result = md5sum.digest( 'hex' );
//       }
//       catch( err )
//       {
//         if( o.throwing )
//         throw err;
//         result = NaN;
//       }
//
//       return result;
//
//     }
//     else
//     {
//
//       let con = new _.Consequence();
//       let stream = File.ReadStream( o.filePath );
//
//       stream.on( 'data', function( d )
//       {
//         md5sum.update( d );
//       });
//
//       stream.on( 'end', function()
//       {
//         let hash = md5sum.digest( 'hex' );
//         con.take( hash );
//       });
//
//       stream.on( 'error', function( err )
//       {
//         if( o.throwing )
//         con.error( _.err( err ) );
//         else
//         con.take( NaN );
//       });
//
//       return con;
//     }
//
//   }
//
// })();
//
// hashReadAct.defaults = {};
// hashReadAct.defaults.__proto__ = Parent.prototype.hashReadAct.defaults;
//
// //
//
// function dirReadAct( o )
// {
//   let self = this;
//
//   if( _.strIs( o ) )
//   o =
//   {
//     filePath : arguments[ 0 ],
//   }
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.routineOptions( dirReadAct,o );
//
//   let result = null;
//
//   /* sort */
//
//   function handleEnd( result )
//   {
//     // for( let r = 0 ; r < result.length ; r++ )
//     // result[ r ] = self.path.refine( result[ r ] ); // output should be covered by test
//     // result.sort( function( a, b )
//     // {
//     //   a = a.toLowerCase();
//     //   b = b.toLowerCase();
//     //   if( a < b ) return -1;
//     //   if( a > b ) return +1;
//     //   return 0;
//     // });
//   }
//
//   /* read dir */
//
//   if( o.sync )
//   {
//     try
//     {
//       let stat = self.fileStat
//       ({
//         filePath : o.filePath,
//         throwing : 1
//       });
//       if( stat.isDirectory() )
//       {
//         result = File.readdirSync( o.filePath );
//         handleEnd( result );
//       }
//       else
//       {
//         result = [ self.path.name({ path : self.path.refine( o.filePath ), full : 1 }) ];
//       }
//     }
//     catch ( err )
//     {
//       if( o.throwing )
//       throw _.err( err );
//       result = null;
//     }
//
//     return result;
//   }
//   else
//   {
//     let con = new _.Consequence();
//
//     self.fileStat
//     ({
//       filePath : o.filePath,
//       sync : 0,
//       throwing : 1,
//     })
//     .give( function( err, stat )
//     {
//       if( err )
//       {
//         if( o.throwing )
//         con.error( _.err( err ) );
//         else
//         con.take( result );
//       }
//       else if( stat.isDirectory() )
//       {
//         File.readdir( o.filePath, function( err, files )
//         {
//           if( err )
//           {
//             if( o.throwing )
//             con.error( _.err( err ) );
//             else
//             con.take( result );
//           }
//           else
//           {
//             handleEnd( files );
//             con.take( files || null );
//           }
//         });
//       }
//       else
//       {
//         result = [ self.path.name({ path : self.path.refine( o.filePath ), full : 1 }) ];
//         con.take( result );
//       }
//     });
//
//     return con;
//   }
//
// }
//
// dirReadAct.defaults = {};
// dirReadAct.defaults.__proto__ = Parent.prototype.dirReadAct.defaults;
//
// // --
// // write
// // --
//
// function streamWriteAct( o )
// {
//   if( _.strIs( o ) )
//   o = { filePath : o };
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( o.filePath ) );
//
//   let o = _.routineOptions( streamWriteAct, o );
//   let stream = null;
//
//   if( o.sync )
//   {
//     try
//     {
//       stream = File.createWriteStream( o.filePath );
//     }
//     catch( err )
//     {
//       throw _.err( err );
//     }
//     return stream;
//   }
//   else
//   {
//     let con = new _.Consequence();
//     try
//     {
//       stream = File.createWriteStream( o.filePath );
//       con.take( stream );
//     }
//     catch( err )
//     {
//       con.error( _.err( err ) );
//     }
//     return con;
//   }
// }
//
// streamWriteAct.defaults = {};
// streamWriteAct.defaults.__proto__ = Parent.prototype.streamWriteAct.defaults;
//
// //
//
// function fileWriteAct( o )
// {
//   let self = this;
//
//   if( arguments.length === 2 )
//   {
//     o = { filePath : arguments[ 0 ], data : arguments[ 1 ] };
//   }
//   else
//   {
//     o = arguments[ 0 ];
//     _.assert( arguments.length === 1, 'Expects single argument' );
//   }
//
//   _.routineOptions( fileWriteAct,o );
//   _.assert( _.strIs( o.filePath ) );
//   _.assert( self.WriteMode.indexOf( o.writeMode ) !== -1 );
//
//   /* data conversion */
//
//   if( _.bufferTypedIs( o.data ) || _.bufferRawIs( o.data ) )
//   o.data = _.bufferNodeFrom( o.data );
//
//   _.assert( _.strIs( o.data ) || _.bufferNodeIs( o.data ),'Expects string or node buffer, but got',_.strTypeOf( o.data ) );
//
//   /* write */
//
//   if( o.sync )
//   {
//
//       if( o.writeMode === 'rewrite' )
//       File.writeFileSync( o.filePath, o.data );
//       else if( o.writeMode === 'append' )
//       File.appendFileSync( o.filePath, o.data );
//       else if( o.writeMode === 'prepend' )
//       {
//         let data;
//         try
//         {
//           data = File.readFileSync( o.filePath )
//         }
//         catch ( err ){ }
//
//         if( data )
//         o.data = o.data.concat( data )
//         File.writeFileSync( o.filePath, o.data );
//       }
//       else throw _.err( 'not implemented write mode',o.writeMode );
//
//   }
//   else
//   {
//     let con = _.Consequence();
//
//     function handleEnd( err )
//     {
//       // log();
//       //if( err && !o.silentError )
//       if( err )
//       return con.error(  _.err( err ) );
//       return con.take();
//     }
//
//     if( o.writeMode === 'rewrite' )
//     File.writeFile( o.filePath, o.data, handleEnd );
//     else if( o.writeMode === 'append' )
//     File.appendFile( o.filePath, o.data, handleEnd );
//     else if( o.writeMode === 'prepend' )
//     {
//       File.readFile( o.filePath, function( err,data )
//       {
//         // throw _.err( 'not tested' );
//         // if( err )
//         // return handleEnd( err );
//         if( data )
//         o.data = o.data.concat( data );
//         File.writeFile( o.filePath, o.data, handleEnd );
//       });
//
//     }
//     else handleEnd( _.err( 'not implemented write mode',o.writeMode ) );
//
//     return con;
//   }
//
// }
//
// fileWriteAct.defaults = {};
// fileWriteAct.defaults.__proto__ = Parent.prototype.fileWriteAct.defaults;
//
// fileWriteAct.isWriter = 1;
//
// //
//
// /**
//  * Delete file of directory. Accepts path string or options object. Returns wConsequence instance.
//  * @example
//  * let fs = require('fs');
//
//   let fileProvider = _.FileProvider.Default();
//
//    let path = 'tmp/fileSize/data',
//    textData = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
//    delOptions =
//   {
//      filePath : path,
//      sync : 0
//    };
//
//    fileProvider.fileWrite( { filePath : path, data : textData } ); // create test file
//
//    console.log( fs.existsSync( path ) ); // true (file exists)
//    let con = fileProvider.fileDelete( delOptions );
//
//    con.give( function(err)
//    {
//      console.log( fs.existsSync( path ) ); // false (file does not exist)
//    } );
//
//  * @param {string|Object} o - options object.
//  * @param {string} o.filePath path to file/directory for deleting.
//  * @param {boolean} [o.force=false] if sets to true, method remove file, or directory, even if directory has
//     content. Else when directory to remove is not empty, wConsequence returned by method, will rejected with error.
//  * @param {boolean} [o.sync=true] If set to false, method will remove file/directory asynchronously.
//  * @returns {wConsequence}
//  * @throws {Error} If missed argument, or pass more than 1.
//  * @throws {Error} If filePath is not string.
//  * @throws {Error} If options object has unexpected property.
//  * @method fileDeleteAct
//  * @memberof wTools
//  */
//
// function fileDeleteAct( o )
// {
//
//   if( _.strIs( o ) )
//   o = { filePath : o };
//
//   let o = _.routineOptions( fileDeleteAct,o );
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( o.filePath ) );
//   let self = this;
//   let stat;
//
//   let stat = self.statReadAct( o.filePath );
//   if( stat && stat.isSymbolicLink() )
//   {
//     debugger;
//     //return handleError( _.err( 'not tested' ) );
//     return _.err( 'not tested' );
//   }
//
//   if( o.sync )
//   {
//
//     if( stat && stat.isDirectory() )
//     File.rmdirSync( o.filePath );
//     else
//     File.unlinkSync( o.filePath );
//
//   }
//   else
//   {
//     let con = new _.Consequence();
//
//     if( stat && stat.isDirectory() )
//     File.rmdir( o.filePath,function( err,data ){ con.take( err,data ) } );
//     else
//     File.unlink( o.filePath,function( err,data ){ con.take( err,data ) } );
//
//     return con;
//   }
//
// }
//
// fileDeleteAct.defaults = {};
// fileDeleteAct.defaults.__proto__ = Parent.prototype.fileDeleteAct.defaults;
//
// //
//
// /**
//  * Delete file of directory. Accepts path string or options object. Returns wConsequence instance.
//  * @example
//  * let fs = require('fs');
//
//   let fileProvider = _.FileProvider.Default();
//
//    let path = 'tmp/fileSize/data',
//    textData = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
//    delOptions =
//   {
//      filePath : path,
//      sync : 0
//    };
//
//    fileProvider.fileWrite( { filePath : path, data : textData } ); // create test file
//
//    console.log( fs.existsSync( path ) ); // true (file exists)
//    let con = fileProvider.fileDelete( delOptions );
//
//    con.give( function(err)
//    {
//      console.log( fs.existsSync( path ) ); // false (file does not exist)
//    } );
//
//  * @param {string|Object} o - options object.
//  * @param {string} o.filePath path to file/directory for deleting.
//  * @param {boolean} [o.force=false] if sets to true, method remove file, or directory, even if directory has
//     content. Else when directory to remove is not empty, wConsequence returned by method, will rejected with error.
//  * @param {boolean} [o.sync=true] If set to false, method will remove file/directory asynchronously.
//  * @returns {wConsequence}
//  * @throws {Error} If missed argument, or pass more than 1.
//  * @throws {Error} If filePath is not string.
//  * @throws {Error} If options object has unexpected property.
//  * @method fileDelete
//  * @memberof wTools
//  */
//
// function fileDelete( o )
// {
//   let self = this;
//
//   if( _.strIs( o ) )
//   o = { filePath : o };
//
//   let o = _.routineOptions( fileDelete,o );
//   let optionsAct = _.mapOnly( o, self.fileDeleteAct.defaults );
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.assert( _.strIs( o.filePath ) );
//
//   o.filePath = self.path.nativize( o.filePath );
//
//   // if( _.files.usingReadOnly )
//   // return o.sync ? undefined : con.take();
//
//   let stat;
//   if( o.sync )
//   {
//
//     if( !o.force )
//     {
//       return self.fileDeleteAct( optionsAct );
//     }
//     else
//     {
//       File.removeSync( o.filePath );
//     }
//
//   }
//   else
//   {
//     let con = new _.Consequence();
//
//     if( !o.force )
//     {
//       self.fileDeleteAct( optionsAct ).finally( con );
//     }
//     else
//     {
//       File.remove( o.filePath,function( err ){ con.take( err,null ) } );
//     }
//
//     return con;
//   }
//
// }
//
// fileDelete.defaults = {}
// fileDelete.defaults.__proto__ = Parent.prototype.fileDelete.defaults;
//
// //
//
// function fileCopyAct( o )
// {
//   let self = this;
//
//   // if( arguments.length === 2 )
//   // o =
//   // {
//   //   dstPath : arguments[ 0 ],
//   //   srcPath : arguments[ 1 ],
//   // }
//   // else
//   // {
//   //   _.assert( arguments.length === 1, 'Expects single argument' );
//   // }
//
//   _.assert( arguments.length === 1, 'Expects single argument' );
//   _.routineOptions( fileCopyAct,o );
//
//   if( !self.fileIsTerminal( o.srcPath ) )
//   {
//     let err = _.err( o.srcPath,' is not a terminal file!' );
//     if( o.sync )
//     throw err;
//     return new _.Consequence().error( err );
//   }
//
//   /* */
//
//   if( o.sync )
//   {
//     File.copySync( o.srcPath, o.dstPath );
//   }
//   else
//   {
//     let con = new _.Consequence();
//     File.copy( o.srcPath, o.dstPath, function( err, data )
//     {
//       con.take( err, data );
//     });
//     return con;
//   }
//
// }
//
// fileCopyAct.defaults = {};
// fileCopyAct.defaults.__proto__ = Parent.prototype.fileCopyAct.defaults;
//
// //
//
// function fileRenameAct( o )
// {
//
//   if( arguments.length === 2 )
//   o =
//   {
//     dstPath : arguments[ 0 ],
//     srcPath : arguments[ 1 ],
//   }
//   else
//   {
//     _.assert( arguments.length === 1, 'Expects single argument' );
//   }
//
//   _.routineOptions( fileRenameAct,o );
//
//   if( o.sync )
//   {
//     File.renameSync( o.srcPath, o.dstPath );
//   }
//   else
//   {
//     let con = new _.Consequence();
//     File.rename( o.srcPath, o.dstPath, function( err,data )
//     {
//       con.take( err,data );
//     });
//     return con;
//   }
//
// }
//
// fileRenameAct.defaults = {};
// fileRenameAct.defaults.__proto__ = Parent.prototype.fileRenameAct.defaults;
//
// //
//
// function fileTimeSetAct( o )
// {
//
//   if( arguments.length === 3 )
//   o =
//   {
//     filePath : arguments[ 0 ],
//     atime : arguments[ 1 ],
//     mtime : arguments[ 2 ],
//   }
//   else
//   {
//     _.assert( arguments.length === 1, 'Expects single argument' );
//   }
//
//   _.routineOptions( fileTimeSetAct,o );
//
//   File.utimesSync( o.filePath, o.atime, o.mtime );
//
// }
//
// fileTimeSetAct.defaults = {};
// fileTimeSetAct.defaults.__proto__ = Parent.prototype.fileTimeSetAct.defaults;
//
// //
//
// function dirMakeAct( o )
// {
//
//   if( _.strIs( o ) )
//   o =
//   {
//     filePath : arguments[ 0 ],
//   }
//   else
//   {
//     _.assert( arguments.length === 1, 'Expects single argument' );
//   }
//
//   _.routineOptions( dirMakeAct,o );
//
//   let stat;
//
//   if( o.sync )
//   {
//
//     File.mkdirSync( o.filePath );
//
//   }
//   else
//   {
//     let con = new _.Consequence();
//
//     File.mkdir( o.filePath, function( err, data ){ con.take( err, data ); } );
//
//     return con;
//   }
//
// }
//
// dirMakeAct.defaults = {};
// dirMakeAct.defaults.__proto__ = Parent.prototype.dirMakeAct.defaults;
//
// //
//
// /**
//  * dirMake options
//  * @typedef { object } wTools~dirMakeOptions
//  * @property { string } [ o.filePath=null ] - Path to new directory.
//  * @property { boolean } [ o.rewriting=false ] - Deletes files that prevents folder creation if they exists.
//  * @property { boolean } [ o.force=true ] - Makes parent directories to complete path( o.filePath ) if they needed.
//  * @property { boolean } [ o.sync=true ] - Runs method in synchronously. Otherwise asynchronously and returns wConsequence object.
//  */
//
// /**
//  * Creates directory specified by path( o.filePath ).
//  * If( o.rewritingTerminal ) mode is enabled method deletes any file that prevents dir creation. Otherwise throws an error.
//  * If( o.force ) mode is enabled it creates folders filesTree to complete path( o.filePath ) if needed. Otherwise tries to make
//  * dir and throws error if directory already exists or one dir is not enough to complete path( o.filePath ).
//  * Can be called in two ways:
//  *  - First by passing only destination directory path and use default options;
//  *  - Second by passing options object( o ).
//  *
//  * @param { wTools~dirMakeOptions } o - options { @link wTools~dirMakeOptions }.
//  *
//  * @example
//  * let fileProvider = _.FileProvider.Default();
//  * fileProvider.dirMake( 'directory' );
//  * let stat = fileProvider.statReadAct( 'directory' );
//  * console.log( stat.isDirectory() ); // returns true
//  *
//  * @method dirMake
//  * @throws { exception } If no argument provided.
//  * @throws { exception } If ( o.rewriting ) is false and any file prevents making dir.
//  * @throws { exception } If ( o.force ) is false and one dir is not enough to complete folders structure or folder already exists.
//  * @memberof wTools
//  */
//
// function dirMake( o )
// {
//   let self = this;
//
//   if( _.strIs( o ) )
//   o =
//   {
//     filePath : arguments[ 0 ],
//   }
//   else
//   {
//     _.assert( arguments.length === 1, 'Expects single argument' );
//   }
//
//   _.routineOptions( dirMake,o );
//   o.filePath = self.path.nativize( o.filePath );
//
//   if( o.rewritingTerminal )
//   if( self.fileIsTerminal( o.filePath ) )
//   {
//     // debugger;
//     self.fileDelete( o.filePath );
//   }
//
//   if( o.sync )
//   {
//
//     if( o.force )
//     File.mkdirsSync( o.filePath );
//     else
//     File.mkdirSync( o.filePath );
//
//   }
//   else
//   {
//     let con = new _.Consequence();
//
//     // throw _.err( 'not tested' );
//
//     if( o.force )
//     File.mkdirs( o.filePath, function( err, data )
//     {
//       con.take( err, data )
//     });
//     else
//     File.mkdir( o.filePath, function( err, data )
//     {
//       con.take( err, data );
//     });
//
//     return con;
//   }
//
// }
//
// dirMake.defaults = Parent.prototype.dirMake.defaults;
//
// //
//
// function softLinkAct( o )
// {
//   let self = this;
//   o = self._linkPre( softLinkAct,arguments );
//
//   /* */
//
//   if( o.sync )
//   {
//     if( self.fileStat( o.dstPath ) )
//     throw _.err( 'softLinkAct',o.dstPath,'already exists' );
//
//     File.symlinkSync( o.srcPath,o.dstPath );
//   }
//   else
//   {
//     // throw _.err( 'not tested' );
//     let con = new _.Consequence();
//     self.fileStat
//     ({
//       filePath : o.dstPath,
//       sync : 0
//     })
//     .give( function( err, stat )
//     {
//       if( stat )
//       return con.error ( _.err( 'softLinkAct',o.dstPath,'already exists' ) );
//       File.symlink( o.srcPath, o.dstPath, function( err )
//       {
//         return con.take( err, null )
//       });
//     });
//     return con;
//   }
//
// }
//
// softLinkAct.defaults = {};
// softLinkAct.defaults.__proto__ = Parent.prototype.softLinkAct.defaults;
//
// //
//
// function hardLinkAct( o )
// {
//   let self = this;
//
//   o = self._linkPre( hardLinkAct,arguments );
//
//   /* */
//
//   if( o.sync )
//   {
//
//     if( o.dstPath === o.srcPath )
//     return true;
//
//     try
//     {
//
//       self.fileStat
//       ({
//         filePath : o.srcPath,
//         throwing : 1
//       });
//
//       if( self.fileStat( o.dstPath ) )
//       throw _.err( 'hardLinkAct',o.dstPath,'already exists' );
//
//       File.linkSync( o.srcPath,o.dstPath );
//       return true;
//     }
//     catch ( err )
//     {
//       throw _.err( err );
//     }
//
//   }
//   else
//   {
//     let con = new _.Consequence();
//
//     if( o.dstPath === o.srcPath )
//     return con.take( true );
//
//     self.fileStat
//     ({
//       filePath : o.srcPath,
//       sync : 0,
//       throwing : 1
//     })
//     .ifNoErrorThen( function()
//     {
//       return self.fileStat
//       ({
//         filePath : o.dstPath,
//         sync : 0,
//         throwing : 0
//       });
//     })
//     .give( function( err,stat )
//     {
//       if( err )
//       return con.error( err );
//
//       if( stat )
//       return con.error( _.err( 'hardLinkAct',o.dstPath,'already exists' ) );
//
//       File.link( o.srcPath,o.dstPath, function( err )
//       {
//         return con.take( err,null );
//       });
//     })
//
//     return con;
//   }
// }
//
// hardLinkAct.defaults = {};
// hardLinkAct.defaults.__proto__ = Parent.prototype.hardLinkAct.defaults;
//
// // --
// // encoders
// // --
//
// var encoders = {};
//
// encoders[ 'json' ] =
// {
//
//   onBegin : function( e )
//   {
//     throw _.err( 'not tested' );
//     _.assert( e.operation.encoding === 'json' );
//     e.operation.encoding = 'utf8';
//   },
//
//   onEnd : function( e )
//   {
//     throw _.err( 'not tested' );
//     _.assert( _.strIs( e.data ) );
//     let result = JSON.parse( e.data );
//     return result;
//   },
//
// }
//
// encoders[ 'arraybuffer' ] =
// {
//
//   onBegin : function( e )
//   {
//     debugger;
//     _.assert( e.operation.encoding === 'arraybuffer' );
//     e.operation.encoding = 'buffer';
//   },
//
//   onEnd : function( e )
//   {
//
//     _.assert( _.bufferNodeIs( e.data ) || _.bufferTypedIs( e.data ) || _.bufferRawIs( e.data ) );
//
//     // _.assert( _.bufferNodeIs( e.data ) );
//     // _.assert( !_.bufferTypedIs( e.data ) );
//     // _.assert( !_.bufferRawIs( e.data ) );
//
//     let result = _.bufferRawFrom( e.data );
//
//     _.assert( !_.bufferNodeIs( result ) );
//     _.assert( _.bufferRawIs( result ) );
//
//     return result;
//   },
//
// }
//
// fileReadAct.encoders = encoders;
//
// // --
// // relationship
// // --
//
// let Composes =
// {
//   // originPath : null,
//   protocols : null,
//   serverUrl : null,
// }
//
// let Aggregates =
// {
// }
//
// let Associates =
// {
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
// // declare
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
//
//   // adapter
//
//   localFromGlobal : localFromGlobal,
//
//
//   // read
//
//   fileReadAct : fileReadAct,
//   streamReadAct : streamReadAct,
//   statReadAct : statReadAct,
//   hashReadAct : hashReadAct,
//
//   dirReadAct : dirReadAct,
//
//
//   // write
//
//   streamWriteAct : streamWriteAct,
//
//   fileWriteAct : fileWriteAct,
//
//   fileDeleteAct : fileDeleteAct,
//   fileDelete : fileDelete,
//
//   fileCopyAct : fileCopyAct,
//   fileRenameAct : fileRenameAct,
//
//   fileTimeSetAct : fileTimeSetAct,
//
//   dirMakeAct : dirMakeAct,
//   dirMake : dirMake,
//
//   softLinkAct : softLinkAct,
//   hardLinkAct : hardLinkAct,
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
// if( typeof module !== 'undefined' && !module.parent )
// _.FileProvider.Remote.exec();
//
// // --
// // export
// // --
//
// // if( typeof module !== 'undefined' )
// // if( _global_.WTOOLS_PRIVATE )
// // delete require.cache[ module.id ];
//
// if( typeof module !== 'undefined' && module !== null )
// module[ 'exports' ] = Self;
//
// })();
