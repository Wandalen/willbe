// (function _Encoder_s_(){

// 'use strict';

// /**
//  * @file EncoderStrategyStandanrd.s.
//  */

// if( typeof module !== 'undefined' )
// {

//   let _ = require( '../../Tools.s' );

// }

// let _global = _global_;
// let _ = _global_.wTools;
// let Self = _global_.wTools;


// // --
// // base64
// // --

// let base64ToBuffer =
// {
//   ext : [ 'base64' ],
//   in : [ 'string/base64' ],
//   out : [ 'buffer.bytes' ],

//   onEncode : function( op )
//   {
//     _.assert( _.strIs( op.in.data ) );
//     op.out.data = _base64ToBuffer( op.in.data, op.envMap.chunkSize )
//     op.out.format = 'buffer.bytes';
//   },
// }

// function _base64ToBuffer( base64, chunkSize )
// {

//   function base64ToWrdBits6( chr )
//   {

//     return chr > 64 && chr < 91 ?
//         chr - 65
//       : chr > 96 && chr < 123 ?
//         chr - 71
//       : chr > 47 && chr < 58 ?
//         chr + 4
//       : chr === 43 ?
//         62
//       : chr === 47 ?
//         63
//       :
//         0;

//   }

//   //var base64 = base64.replace( /[^0-9A-Za-z\+\/]/g, "" );

//   var srcSize = base64.length;
//   var dstSize = chunkSize ? Math.ceil( ( srcSize * 3 + 1 >> 2 ) / chunkSize ) * chunkSize : srcSize * 3 + 1 >> 2
//   var bytes = new Uint8Array( dstSize );

//   var factor3, factor4, wrd3 = 0, outIndex = 0;
//   for( var inIndex = 0; inIndex < srcSize; inIndex++ )
//   {

//     factor4 = inIndex & 3;
//     wrd3 |= base64ToWrdBits6( base64.charCodeAt( inIndex ) ) << 18 - 6 * factor4;
//     if ( factor4 === 3 || srcSize - inIndex === 1 )
//     {
//       for ( factor3 = 0; factor3 < 3 && outIndex < dstSize; factor3++, outIndex++ )
//       {
//         bytes[outIndex] = wrd3 >>> ( 16 >>> factor3 & 24 ) & 255;
//       }
//       wrd3 = 0;
//     }

//   }

//   return bytes;
// }

// //

// let base64FromBuffer =
// {
//   ext : [ 'base64' ],
//   in : [ 'buffer.bytes' ],
//   out : [ 'string/base64' ],

//   onEncode : function( op )
//   {
//     _.assert( _.bufferBytesIs( op.in.data ) );
//     op.out.data = _base64FromBuffer( op.in.data )
//     op.out.format = 'string/base64';
//   },
// }

// function _base64FromBuffer( byteBuffer )
// {

//   function wrdBits6ToBase64( wrdBits6 )
//   {

//     return wrdBits6 < 26 ?
//         wrdBits6 + 65
//       : wrdBits6 < 52 ?
//         wrdBits6 + 71
//       : wrdBits6 < 62 ?
//         wrdBits6 - 4
//       : wrdBits6 === 62 ?
//         43
//       : wrdBits6 === 63 ?
//         47
//       :
//         65;

//   }

//   _.assert( byteBuffer instanceof Uint8Array );

//   var factor3 = 2;
//   var result = '';
//   var size = byteBuffer.length;

//   for ( var l = size, wrd3 = 0, index = 0; index < l; index++ )
//   {

//     factor3 = index % 3;
//     //if ( index > 0 && ( index * 4 / 3 ) % 76 === 0 )
//     //{ result += "\r\n"; }

//     wrd3 |= byteBuffer[ index ] << ( 16 >>> factor3 & 24 );
//     if ( factor3 === 2 || l - index === 1 )
//     {

//       var a = wrdBits6ToBase64( wrd3 >>> 18 & 63 );
//       var b = wrdBits6ToBase64( wrd3 >>> 12 & 63 );
//       var c = wrdBits6ToBase64( wrd3 >>> 6 & 63 );
//       var d = wrdBits6ToBase64( wrd3 & 63 );
//       result += String.fromCharCode( a,b,c,d );
//       wrd3 = 0;

//     }

//   }

//   var postfix = ( factor3 === 2 ? '' : factor3 === 1 ? '=' : '==' );
//   return result.substr( 0, result.length - 2 + factor3 ) + postfix;
// }

// //

// let base64ToBlob =
// {
//   ext : [ 'blob' ],
//   in : [ 'string/base64' ],
//   out : [ 'blob' ],

//   onEncode : function( op )
//   {
//     _.assert( _.strIs( op.in.data ) );
//     op.out.data = _base64ToBlob( op.in.data, op.envMap.mime )
//     op.out.format = 'blob';
//   },
// }

// function _base64ToBlob( base64Data, mime )
// {
//   var mime = mime || 'application/octet-stream';
//   var buffer = _base64ToBuffer( base64Data );
//   return new Blob( buffer, { type: mime } );
// }

// //Vova : added opposite version of base64ToBlob, is it needed?

// // let base64FromBlob = null;
// // if( _.workerIs() )
// // base64FromBlob =
// // {
// //   ext : [ 'base64' ],
// //   in : [ 'blob' ],
// //   out : [ 'string/base64' ],

// //   onEncode : function( op )
// //   {
// //     op.out.data = _base64FromBlob( op.in.data )
// //     op.out.format = 'string/base64';
// //   },
// // }

// // function _base64FromBlob( blob )
// // {
// //   if( !_.workerIs() )
// //   return blob;

// //   let reader = new FileReaderSync();
// //   let result = reader.readAsText( blob );
// //   result = _base64FromUtf8( result );
// //   return result;
// // }

// // --
// // utf8
// // --

// let base64FromUtf8Slow =
// {
//   shortName : 'base64FromUtf8Slow',

//   ext : [ 'base64' ],
//   in : [ 'string/utf8' ],
//   out : [ 'string/base64' ],

//   onEncode : function( op )
//   {
//     _.assert( _.strIs( op.in.data ) );
//     op.out.data = _base64FromUtf8Slow( op.in.data )
//     op.out.format = 'string/base64';
//   },
// }

// function _base64FromUtf8Slow( string )
// {
//   var base64 = btoa( unescape( encodeURIComponent( string ) ) );
//   return base64;
// }

// //

// let base64FromUtf8 =
// {
//   shortName : 'base64FromUtf8',
//   default : 1,

//   ext : [ 'base64' ],
//   in : [ 'string/utf8' ],
//   out : [ 'string/base64' ],

//   onEncode : function( op )
//   {
//     _.assert( _.strIs( op.in.data ) );
//     op.out.data = _base64FromUtf8( op.in.data )
//     op.out.format = 'string/base64';
//   },
// }

// function _base64FromUtf8( string )
// {
//   var buffer = _utf8ToBuffer( string );
//   var result = _base64FromBuffer( buffer );
//   return result;
// }

// //

// let base64ToUtf8Slow =
// {
//   ext : [ 'utf8' ],
//   in : [ 'string/base64' ],
//   out : [ 'string/utf8' ],

//   onEncode : function( op )
//   {
//     _.assert( _.strIs( op.in.data ) );
//     op.out.data = _base64ToUtf8Slow( op.in.data )
//     op.out.format = 'string/utf8';
//   },
// }

// function _base64ToUtf8Slow( base64 )
// {
//   var result = atob( base64 )
//   return result;
// }

// //

// let base64ToUtf8 =
// {
//   shortName : 'base64ToUtf8',
//   default : 1,

//   ext : [ 'utf8' ],
//   in : [ 'string/base64' ],
//   out : [ 'string/utf8' ],

//   onEncode : function( op )
//   {
//     _.assert( _.strIs( op.in.data ) );
//     op.out.data = _base64ToUtf8( op.in.data )
//     op.out.format = 'string/utf8';
//   },
// }

// function _base64ToUtf8( base64 )
// {
//   var buffer = _base64ToBuffer( base64 );
//   let result = _utf8FromBuffer( buffer );
//   return result;
// }

// //

// let utf8FromBuffer =
// {
//   ext : [ 'utf8' ],
//   in : [ 'buffer.bytes' ],
//   out : [ 'string/utf8' ],

//   onEncode : function( op )
//   {
//     _.assert( _.bufferBytesIs( op.in.data ) );
//     op.out.data = _utf8FromBuffer( op.in.data )
//     op.out.format = 'string/utf8';
//   },
// }

// function _utf8FromBuffer( byteBuffer )
// {
//   var result = '';

//   _.assert( byteBuffer instanceof Uint8Array );

//   for ( var nPart, nLen = byteBuffer.length, index = 0; index < nLen; index++ )
//   {
//     nPart = byteBuffer[index];
//     result += String.fromCharCode(
//       nPart > 251 && nPart < 254 && index + 5 < nLen ?
//         ( nPart - 252 ) * 1073741824 + ( byteBuffer[++index] - 128 << 24 ) + ( byteBuffer[++index] - 128 << 18 ) + ( byteBuffer[++index] - 128 << 12 ) + ( byteBuffer[++index] - 128 << 6 ) + byteBuffer[++index] - 128
//       : nPart > 247 && nPart < 252 && index + 4 < nLen ?
//         ( nPart - 248 << 24 ) + ( byteBuffer[++index] - 128 << 18 ) + ( byteBuffer[++index] - 128 << 12 ) + ( byteBuffer[++index] - 128 << 6 ) + byteBuffer[++index] - 128
//       : nPart > 239 && nPart < 248 && index + 3 < nLen ?
//         ( nPart - 240 << 18 ) + ( byteBuffer[++index] - 128 << 12 ) + ( byteBuffer[++index] - 128 << 6 ) + byteBuffer[++index] - 128
//       : nPart > 223 && nPart < 240 && index + 2 < nLen ?
//         ( nPart - 224 << 12 ) + ( byteBuffer[++index] - 128 << 6 ) + byteBuffer[++index] - 128
//       : nPart > 191 && nPart < 224 && index + 1 < nLen ?
//         ( nPart - 192 << 6 ) + byteBuffer[++index] - 128
//       :
//         nPart
//     );
//   }

//   return result;
// }


// //

// let utf8ToBuffer =
// {
//   ext : [ 'bytes', 'buffer' ],
//   in : [ 'string/utf8' ],
//   out : [ 'buffer.bytes' ],

//   onEncode : function( op )
//   {
//     _.assert( _.strIs( op.in.data ) );
//     op.out.data = _utf8ToBuffer( op.in.data )
//     op.out.format = 'buffer.bytes';
//   },
// }

// function _utf8ToBuffer( str )
// {

//   var chr, nStrLen = str.length, size = 0;

//   //

//   for ( var index = 0; index < nStrLen; index++ )
//   {
//     chr = str.charCodeAt( index );
//     size += chr < 0x80 ? 1 : chr < 0x800 ? 2 : chr < 0x10000 ? 3 : chr < 0x200000 ? 4 : chr < 0x4000000 ? 5 : 6;
//   }

//   var byteBuffer = new Uint8Array( size );

//   //

//   for( var index = 0, nChrIdx = 0; index < size; nChrIdx++ )
//   {
//     chr = str.charCodeAt( nChrIdx );
//     if ( chr < 128 )
//     {
//       /* one byte */
//       byteBuffer[index++] = chr;
//     }
//     else if ( chr < 0x800 )
//     {
//       /* two bytes */
//       byteBuffer[index++] = 192 + ( chr >>> 6 );
//       byteBuffer[index++] = 128 + ( chr & 63 );
//     }
//     else if ( chr < 0x10000 )
//     {
//       /* three bytes */
//       byteBuffer[index++] = 224 + ( chr >>> 12 );
//       byteBuffer[index++] = 128 + ( chr >>> 6 & 63 );
//       byteBuffer[index++] = 128 + ( chr & 63 );
//     }
//     else if ( chr < 0x200000 )
//     {
//       /* four bytes */
//       byteBuffer[index++] = 240 + ( chr >>> 18 );
//       byteBuffer[index++] = 128 + ( chr >>> 12 & 63 );
//       byteBuffer[index++] = 128 + ( chr >>> 6 & 63 );
//       byteBuffer[index++] = 128 + ( chr & 63 );
//     }
//     else if ( chr < 0x4000000 )
//     {
//       /* five bytes */
//       byteBuffer[index++] = 248 + ( chr >>> 24 );
//       byteBuffer[index++] = 128 + ( chr >>> 18 & 63 );
//       byteBuffer[index++] = 128 + ( chr >>> 12 & 63 );
//       byteBuffer[index++] = 128 + ( chr >>> 6 & 63 );
//       byteBuffer[index++] = 128 + ( chr & 63 );
//     }
//     else /* if ( chr <= 0x7fffffff ) */
//     {
//       /* six bytes */
//       byteBuffer[index++] = 252 + ( chr / 1073741824 );
//       byteBuffer[index++] = 128 + ( chr >>> 24 & 63 );
//       byteBuffer[index++] = 128 + ( chr >>> 18 & 63 );
//       byteBuffer[index++] = 128 + ( chr >>> 12 & 63 );
//       byteBuffer[index++] = 128 + ( chr >>> 6 & 63 );
//       byteBuffer[index++] = 128 + ( chr & 63 );
//     }
//   }

//   return byteBuffer;
// }

// // --
// // declare
// // --

// var Proto =
// {

//   // base64

//   base64ToBuffer: _base64ToBuffer,
//   base64FromBuffer: _base64FromBuffer,
//   base64ToBlob: _base64ToBlob,
//   // base64FromBlob: _base64FromBlob,

//   base64FromUtf8Slow: _base64FromUtf8Slow,
//   base64FromUtf8: _base64FromUtf8,
//   base64ToUtf8Slow : _base64ToUtf8Slow,
//   base64ToUtf8: _base64ToUtf8,

//   // utf8

//   utf8FromBuffer: _utf8FromBuffer,
//   utf8ToBuffer: _utf8ToBuffer,

// }

// Self = _.encode = _.encode || Object.create( null );
// _.mapExtend( _.encode,Proto );


// // --
// // register
// // --

// _.Gdf([ base64ToBuffer, base64FromBuffer ]);
// _.Gdf([ base64ToBlob ]);
// _.Gdf([ base64FromUtf8Slow, base64ToUtf8Slow, base64FromUtf8, base64ToUtf8 ]);
// _.Gdf([ utf8FromBuffer, utf8ToBuffer ]);

// // --
// // export
// // --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

// if( typeof module !== 'undefined' && module !== null )
// module[ 'exports' ] = Self;

// })();
