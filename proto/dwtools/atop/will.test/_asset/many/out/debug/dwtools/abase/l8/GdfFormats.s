(function _EncoderStrategyStandanrd_s_() {

'use strict';

/**
 * @file EncoderStrategyStandanrd.s.
 */

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

}

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;

// --
// json
// --

let jsonSupported =
{
  primitive : 1,
  regexp : 0,
  buffer : 0,
  structure : 2
}

let readJson =
{

  ext : [ 'json' ],
  in : [ 'string' ],
  out : [ 'structure' ],

  supported : jsonSupported,

  onEncode : function( op )
  {

    try
    {
      op.out.data = JSON.parse( op.in.data );
    }
    catch( err )
    {
      let src = op.in.data;
      let position = /at position (\d+)/.exec( err.message );
      if( position )
      position = Number( position[ 1 ] );
      let first = 0;
      if( !isNaN( position ) )
      {
        let nearest = _.strLinesNearest( src, position );
        first = _.strLinesCount( src.substring( 0, nearest.spans[ 0 ] ) );
        src = nearest.splits.join( '' );
      }
      let err2 = _.err( 'Error parsing JSON\n', err, '\n', _.strLinesNumber( src, first ) );
      throw err2;
    }

    // op.out.data = _.jsonParse( op.in.data );
    op.out.format = 'structure';

  },

}

let writeJsonMin =
{
  default : 1,
  ext : [ 'json.min', 'json' ],
  shortName : 'json.min',
  in : [ 'structure' ],
  out : [ 'string' ],

  supported : jsonSupported,

  onEncode : function( op )
  {
    op.out.data = JSON.stringify( op.in.data );
    op.out.format = 'string';
  }

}

let writeJsonFine =
{

  shortName : 'json.fine',
  ext : [ 'json.fine', 'json' ],
  in : [ 'structure' ],
  out : [ 'string' ],

  supported : jsonSupported,

  onEncode : function( op )
  {
    op.out.data = _.cloneData({ src : op.in.data });
    op.out.data = _.toJson( op.out.data, { cloning : 0 } );
    op.out.format = 'string';
  }

}

// --
// js
// --

let ProcessBasic;
try
{
  ProcessBasic = _.include( 'wAppBasic' );
}
catch( err )
{
}

let jsSupported =
{
  primitive : 3,
  regexp : 2,
  buffer : 3,
  structure : 2
}

let readJsStructure = null;
if( ProcessBasic )
readJsStructure =
{

  forConfig : 0,
  ext : [ 'js.structure', 'js','s','ss','jstruct', 'jslike' ],
  in : [ 'string' ],
  out : [ 'structure' ],

  supported : jsSupported,

  onEncode : function( op )
  {
    op.out.format = 'string';
  },

  onEncode : function( op )
  {
    op.out.data = _.exec({ code : op.in.data, filePath : op.envMap.filePath, prependingReturn : 1 });
    op.out.format = 'structure';
  },

}

//

// let readJsNode =
// {
//
//   forConfig : 0,
//   ext : [ 'js','s','ss','jstruct', 'jslike' ],
//   in : [ 'string' ],
//   out : [ 'structure' ],
//
//   onEncode : function( op )
//   {
//     op.out.data = require( _.fileProvider.path.nativize( op.envMap.filePath ) );
//     op.out.format = 'structure';
//   },
//
// }
//
// //
//
// let readJsSmart =
// {
//
//   ext : [ 'js','s','ss','jstruct', 'jslike' ],
//   in : [ 'string' ],
//   out : [ 'structure' ],
//
//   onEncode : function( op )
//   {
//
//     // qqq
//     // if( typeof process !== 'undefined' && typeof require !== 'undefined' )
//     // if( _.FileProvider.HardDrive && op.envMap.provider instanceof _.FileProvider.HardDrive )
//     // {
//     //   op.out.data = require( _.fileProvider.path.nativize( op.envMap.filePath ) );
//     //   op.out.format = 'structure';
//     //   return;
//     // }
//
//     op.out.data = _.exec
//     ({
//       code : op.in.data,
//       filePath : op.envMap.filePath,
//       prependingReturn : 1,
//     });
//
//     op.out.format = 'structure';
//
//   },
//
// }

//

let writeJsStrcuture =
{

  ext : [ 'js.structure','js','s','ss','jstruct', 'jslike' ],
  in : [ 'structure' ],
  out : [ 'string' ],

  supported : jsSupported,

  onEncode : function( op )
  {
    op.out.data = _.toJs( op.in.data );
    op.out.format = 'string';
  }

}

// --
// coffee
// --

let Coffee;
try
{
  Coffee = require( 'coffeescript' );
}
catch( err )
{
}

let csonSupported =
{
  primitive : 1,
  regexp : 2,
  buffer : 3,
  structure : 2
}

let readCoffee = null;
if( Coffee )
readCoffee =
{

  ext : [ 'coffee', 'cson' ],
  in : [ 'string' ],
  out : [ 'structure' ],

  supported : csonSupported,

  onEncode : function( op )
  { 
    let o = Object.create( null );
    
    if( op.envMap.filePath )
    o.filename = _.fileProvider.path.nativize( op.envMap.filePath )
    
    op.out.data = Coffee.eval( op.in.data, o );
    op.out.format = 'structure'; 
  },

}

//

let Js2coffee;
try
{
  Js2coffee = require( 'js2coffee' );
}
catch( err )
{
}

let writeCoffee = null;
if( Js2coffee )
writeCoffee =
{

  ext : [ 'coffee', 'cson' ],
  in : [ 'structure' ],
  out : [ 'string' ],

  supported : csonSupported,

  onEncode : function( op )
  {
    let data = _.toStr( op.in.data, { jsLike : 1, keyWrapper : '' } );
    if( _.mapIs( op.in.data ) )
    data = '(' + data + ')';
    op.out.data = Js2coffee( data );
  },

}

// --
// yaml
// --

let Yaml;
try
{
  Yaml = require( 'js-yaml' );
}
catch( err )
{
}

let ymlSupported =
{
  primitive : 2,
  regexp : 2,
  buffer : 1,
  structure : 3
}

let readYml = null;
if( Yaml )
readYml =
{

  ext : [ 'yaml','yml' ],
  in : [ 'string' ],
  out : [ 'structure' ],

  supported : ymlSupported,

  onEncode : function( op )
  { 
    let o = Object.create( null );
    
    if( op.envMap.filePath )
    o.filename = _.fileProvider.path.nativize( op.envMap.filePath )
    
    op.out.data = Yaml.load( op.in.data, o );
    op.out.format = 'structure';
  },

}

let writeYml = null;
if( Yaml )
writeYml =
{

  ext : [ 'yaml','yml' ],
  in : [ 'structure' ],
  out : [ 'string' ],

  supported : ymlSupported,

  onEncode : function( op )
  {
    op.out.data = Yaml.dump( op.in.data );
    op.out.format = 'string';
  },

}

// --
// bson
// --

let Bson;
try
{
  Bson = require( 'bson' );
  Bson.setInternalBufferSize( 1 << 30 );
}
catch( err )
{
}

let bsonSupported =
{
  primitive : 2,
  regexp : 2,
  buffer : 0,
  structure : 2
}

let readBson = null;
if( Bson )
readBson =
{

  ext : [ 'bson' ],
  in : [ 'buffer.node' ],
  out : [ 'structure' ],

  supported : bsonSupported,

  onEncode : function( op )
  {
    _.assert( _.bufferNodeIs( op.in.data ) );
    op.out.data = Bson.deserialize( op.in.data );
    op.out.format = 'structure';
  },

}

let writeBson = null;
if( Bson )
writeBson =
{

  ext : [ 'bson' ],
  in : [ 'structure' ],
  out : [ 'buffer.node' ],

  supported : bsonSupported,

  onEncode : function( op )
  {
    _.assert( _.mapIs( op.in.data ) );
    op.out.data = Bson.serialize( op.in.data );
    op.out.format = 'buffer.node';
  },

}

// --
// cbor
// --

let Cbor;
try
{
  Cbor = require( 'cbor' );
}
catch( err )
{
}

let cborSupported =
{
  primitive : 3,
  regexp : 1,
  buffer : 1,
  structure : 2
}

let readCbor = null;
if( Cbor )
readCbor =
{

  ext : [ 'cbor' ],
  in : [ 'buffer.node' ],
  out : [ 'structure' ],

  supported : cborSupported,

  onEncode : function( op )
  {
    _.assert( _.bufferNodeIs( op.in.data ) );
    op.out.data = Cbor.decodeFirstSync( op.in.data, { bigint : true } );
    op.out.format = 'structure';
  },

}

let writeCbor = null;
if( Cbor )
writeCbor =
{

  ext : [ 'cbor' ],
  in : [ 'structure' ],
  out : [ 'buffer.node' ],

  supported : cborSupported,

  onEncode : function( op )
  {
    _.assert( _.mapIs( op.in.data ) );

    let encoder = new Cbor.Encoder({ highWaterMark: 1 << 30 });
    encoder.write( op.in.data );
    op.out.data = encoder.read();

    _.assert( _.bufferNodeIs( op.out.data ) );

    op.out.format = 'buffer.node';
  },

}

// --
// Msgpack-lite
// --

let MsgpackLite;
try
{
  MsgpackLite = require( 'msgpack-lite' );
}
catch( err )
{
}

let readMsgpackLite = null;
if( MsgpackLite )
readMsgpackLite =
{

  ext : [ 'msgpack.lite' ],
  in : [ 'buffer.node' ],
  out : [ 'structure' ],

  onEncode : function( op )
  {
    _.assert( _.bufferNodeIs( op.in.data ) );
    op.out.data = MsgpackLite.decode( op.in.data );
    op.out.format = 'structure';
  },

}

let writeMsgpackLite = null;
if( MsgpackLite )
writeMsgpackLite =
{

  ext : [ 'msgpack.lite' ],
  in : [ 'structure' ],
  out : [ 'buffer.node' ],

  onEncode : function( op )
  {
    _.assert( _.mapIs( op.in.data ) );
    op.out.data = MsgpackLite.encode( op.in.data );
    op.out.format = 'buffer.node';
  },

}

// --
// Msgpack-wtp
// --

let MsgpackWtp;
try
{
  MsgpackWtp = require( 'what-the-pack' );
}
catch( err )
{
}

let readMsgpackWtp = null;
if( MsgpackWtp )
readMsgpackWtp =
{

  ext : [ 'msgpack.wtp' ],
  in : [ 'buffer.node' ],
  out : [ 'structure' ],

  onEncode : function( op )
  {
    _.assert( _.bufferNodeIs( op.in.data ) );

    if( !MsgpackWtp.decode )
    MsgpackWtp = MsgpackWtp.initialize( 2**27 ); //134 MB

    op.out.data = MsgpackWtp.decode( op.in.data );
    op.out.format = 'structure';
  },

}

let writeMsgpackWtp = null;
if( MsgpackWtp )
writeMsgpackWtp =
{

  ext : [ 'msgpack.wtp' ],
  in : [ 'structure' ],
  out : [ 'buffer.node' ],

  onEncode : function( op )
  {
    _.assert( _.mapIs( op.in.data ) );

    if( !MsgpackWtp.encode )
    MsgpackWtp = MsgpackWtp.initialize( 2**27 ); //134 MB

    op.out.data = MsgpackWtp.encode( op.in.data );
    op.out.format = 'buffer.node';
  },

}

// --
// base64
// --

let base64ToBuffer =
{
  ext : [ 'base64' ],
  in : [ 'string/base64' ],
  out : [ 'buffer.bytes' ],

  onEncode : function( op )
  {
    _.assert( _.strIs( op.in.data ) );
    op.out.data = _base64ToBuffer( op.in.data, op.envMap.chunkSize )
    op.out.format = 'buffer.bytes';
  },
}

function _base64ToBuffer( base64, chunkSize )
{

  function base64ToWrdBits6( chr )
  {

    return chr > 64 && chr < 91 ?
        chr - 65
      : chr > 96 && chr < 123 ?
        chr - 71
      : chr > 47 && chr < 58 ?
        chr + 4
      : chr === 43 ?
        62
      : chr === 47 ?
        63
      :
        0;

  }

  //var base64 = base64.replace( /[^0-9A-Za-z\+\/]/g, "" );

  var srcSize = base64.length;
  var dstSize = chunkSize ? Math.ceil( ( srcSize * 3 + 1 >> 2 ) / chunkSize ) * chunkSize : srcSize * 3 + 1 >> 2
  var bytes = new Uint8Array( dstSize );

  var factor3, factor4, wrd3 = 0, outIndex = 0;
  for( var inIndex = 0; inIndex < srcSize; inIndex++ )
  {

    factor4 = inIndex & 3;
    wrd3 |= base64ToWrdBits6( base64.charCodeAt( inIndex ) ) << 18 - 6 * factor4;
    if ( factor4 === 3 || srcSize - inIndex === 1 )
    {
      for ( factor3 = 0; factor3 < 3 && outIndex < dstSize; factor3++, outIndex++ )
      {
        bytes[outIndex] = wrd3 >>> ( 16 >>> factor3 & 24 ) & 255;
      }
      wrd3 = 0;
    }

  }

  return bytes;
}

//

let base64FromBuffer =
{
  ext : [ 'base64' ],
  in : [ 'buffer.bytes' ],
  out : [ 'string/base64' ],

  onEncode : function( op )
  {
    _.assert( _.bufferBytesIs( op.in.data ) );
    op.out.data = _base64FromBuffer( op.in.data )
    op.out.format = 'string/base64';
  },
}

function _base64FromBuffer( byteBuffer )
{

  function wrdBits6ToBase64( wrdBits6 )
  {

    return wrdBits6 < 26 ?
        wrdBits6 + 65
      : wrdBits6 < 52 ?
        wrdBits6 + 71
      : wrdBits6 < 62 ?
        wrdBits6 - 4
      : wrdBits6 === 62 ?
        43
      : wrdBits6 === 63 ?
        47
      :
        65;

  }

  _.assert( byteBuffer instanceof Uint8Array );

  var factor3 = 2;
  var result = '';
  var size = byteBuffer.length;

  for ( var l = size, wrd3 = 0, index = 0; index < l; index++ )
  {

    factor3 = index % 3;
    //if ( index > 0 && ( index * 4 / 3 ) % 76 === 0 )
    //{ result += "\r\n"; }

    wrd3 |= byteBuffer[ index ] << ( 16 >>> factor3 & 24 );
    if ( factor3 === 2 || l - index === 1 )
    {

      var a = wrdBits6ToBase64( wrd3 >>> 18 & 63 );
      var b = wrdBits6ToBase64( wrd3 >>> 12 & 63 );
      var c = wrdBits6ToBase64( wrd3 >>> 6 & 63 );
      var d = wrdBits6ToBase64( wrd3 & 63 );
      result += String.fromCharCode( a,b,c,d );
      wrd3 = 0;

    }

  }

  var postfix = ( factor3 === 2 ? '' : factor3 === 1 ? '=' : '==' );
  return result.substr( 0, result.length - 2 + factor3 ) + postfix;
}

//

let base64ToBlob =
{
  ext : [ 'blob' ],
  in : [ 'string/base64' ],
  out : [ 'blob' ],

  onEncode : function( op )
  {
    _.assert( _.strIs( op.in.data ) );
    op.out.data = _base64ToBlob( op.in.data, op.envMap.mime )
    op.out.format = 'blob';
  },
}

function _base64ToBlob( base64Data, mime )
{
  var mime = mime || 'application/octet-stream';
  var buffer = _base64ToBuffer( base64Data );
  return new Blob( buffer, { type: mime } );
}

//Vova : added opposite version of base64ToBlob, is it needed?

// let base64FromBlob = null;
// if( _.workerIs() )
// base64FromBlob =
// {
//   ext : [ 'base64' ],
//   in : [ 'blob' ],
//   out : [ 'string/base64' ],

//   onEncode : function( op )
//   {
//     op.out.data = _base64FromBlob( op.in.data )
//     op.out.format = 'string/base64';
//   },
// }

// function _base64FromBlob( blob )
// {
//   if( !_.workerIs() )
//   return blob;

//   let reader = new FileReaderSync();
//   let result = reader.readAsText( blob );
//   result = _base64FromUtf8( result );
//   return result;
// }

// --
// utf8
// --

let base64FromUtf8Slow =
{
  shortName : 'base64FromUtf8Slow',

  ext : [ 'base64' ],
  in : [ 'string/utf8' ],
  out : [ 'string/base64' ],

  onEncode : function( op )
  {
    _.assert( _.strIs( op.in.data ) );
    op.out.data = _base64FromUtf8Slow( op.in.data )
    op.out.format = 'string/base64';
  },
}

function _base64FromUtf8Slow( string )
{
  var base64 = btoa( unescape( encodeURIComponent( string ) ) );
  return base64;
}

//

let base64FromUtf8 =
{
  shortName : 'base64FromUtf8',
  default : 1,

  ext : [ 'base64' ],
  in : [ 'string/utf8' ],
  out : [ 'string/base64' ],

  onEncode : function( op )
  {
    _.assert( _.strIs( op.in.data ) );
    op.out.data = _base64FromUtf8( op.in.data )
    op.out.format = 'string/base64';
  },
}

function _base64FromUtf8( string )
{
  var buffer = _utf8ToBuffer( string );
  var result = _base64FromBuffer( buffer );
  return result;
}

//

let base64ToUtf8Slow =
{
  ext : [ 'utf8' ],
  in : [ 'string/base64' ],
  out : [ 'string/utf8' ],

  onEncode : function( op )
  {
    _.assert( _.strIs( op.in.data ) );
    op.out.data = _base64ToUtf8Slow( op.in.data )
    op.out.format = 'string/utf8';
  },
}

function _base64ToUtf8Slow( base64 )
{
  var result = atob( base64 )
  return result;
}

//

let base64ToUtf8 =
{
  shortName : 'base64ToUtf8',
  default : 1,

  ext : [ 'utf8' ],
  in : [ 'string/base64' ],
  out : [ 'string/utf8' ],

  onEncode : function( op )
  {
    _.assert( _.strIs( op.in.data ) );
    op.out.data = _base64ToUtf8( op.in.data )
    op.out.format = 'string/utf8';
  },
}

function _base64ToUtf8( base64 )
{
  var buffer = _base64ToBuffer( base64 );
  let result = _utf8FromBuffer( buffer );
  return result;
}

//

let utf8FromBuffer =
{
  ext : [ 'utf8' ],
  in : [ 'buffer.bytes' ],
  out : [ 'string/utf8' ],

  onEncode : function( op )
  {
    _.assert( _.bufferBytesIs( op.in.data ) );
    op.out.data = _utf8FromBuffer( op.in.data )
    op.out.format = 'string/utf8';
  },
}

function _utf8FromBuffer( byteBuffer )
{
  var result = '';

  _.assert( byteBuffer instanceof Uint8Array );

  for ( var nPart, nLen = byteBuffer.length, index = 0; index < nLen; index++ )
  {
    nPart = byteBuffer[index];
    result += String.fromCharCode(
      nPart > 251 && nPart < 254 && index + 5 < nLen ?
        ( nPart - 252 ) * 1073741824 + ( byteBuffer[++index] - 128 << 24 ) + ( byteBuffer[++index] - 128 << 18 ) + ( byteBuffer[++index] - 128 << 12 ) + ( byteBuffer[++index] - 128 << 6 ) + byteBuffer[++index] - 128
      : nPart > 247 && nPart < 252 && index + 4 < nLen ?
        ( nPart - 248 << 24 ) + ( byteBuffer[++index] - 128 << 18 ) + ( byteBuffer[++index] - 128 << 12 ) + ( byteBuffer[++index] - 128 << 6 ) + byteBuffer[++index] - 128
      : nPart > 239 && nPart < 248 && index + 3 < nLen ?
        ( nPart - 240 << 18 ) + ( byteBuffer[++index] - 128 << 12 ) + ( byteBuffer[++index] - 128 << 6 ) + byteBuffer[++index] - 128
      : nPart > 223 && nPart < 240 && index + 2 < nLen ?
        ( nPart - 224 << 12 ) + ( byteBuffer[++index] - 128 << 6 ) + byteBuffer[++index] - 128
      : nPart > 191 && nPart < 224 && index + 1 < nLen ?
        ( nPart - 192 << 6 ) + byteBuffer[++index] - 128
      :
        nPart
    );
  }

  return result;
}


//

let utf8ToBuffer =
{
  ext : [ 'bytes', 'buffer' ],
  in : [ 'string/utf8' ],
  out : [ 'buffer.bytes' ],

  onEncode : function( op )
  {
    _.assert( _.strIs( op.in.data ) );
    op.out.data = _utf8ToBuffer( op.in.data )
    op.out.format = 'buffer.bytes';
  },
}

function _utf8ToBuffer( str )
{

  var chr, nStrLen = str.length, size = 0;

  //

  for ( var index = 0; index < nStrLen; index++ )
  {
    chr = str.charCodeAt( index );
    size += chr < 0x80 ? 1 : chr < 0x800 ? 2 : chr < 0x10000 ? 3 : chr < 0x200000 ? 4 : chr < 0x4000000 ? 5 : 6;
  }

  var byteBuffer = new Uint8Array( size );

  //

  for( var index = 0, nChrIdx = 0; index < size; nChrIdx++ )
  {
    chr = str.charCodeAt( nChrIdx );
    if ( chr < 128 )
    {
      /* one byte */
      byteBuffer[index++] = chr;
    }
    else if ( chr < 0x800 )
    {
      /* two bytes */
      byteBuffer[index++] = 192 + ( chr >>> 6 );
      byteBuffer[index++] = 128 + ( chr & 63 );
    }
    else if ( chr < 0x10000 )
    {
      /* three bytes */
      byteBuffer[index++] = 224 + ( chr >>> 12 );
      byteBuffer[index++] = 128 + ( chr >>> 6 & 63 );
      byteBuffer[index++] = 128 + ( chr & 63 );
    }
    else if ( chr < 0x200000 )
    {
      /* four bytes */
      byteBuffer[index++] = 240 + ( chr >>> 18 );
      byteBuffer[index++] = 128 + ( chr >>> 12 & 63 );
      byteBuffer[index++] = 128 + ( chr >>> 6 & 63 );
      byteBuffer[index++] = 128 + ( chr & 63 );
    }
    else if ( chr < 0x4000000 )
    {
      /* five bytes */
      byteBuffer[index++] = 248 + ( chr >>> 24 );
      byteBuffer[index++] = 128 + ( chr >>> 18 & 63 );
      byteBuffer[index++] = 128 + ( chr >>> 12 & 63 );
      byteBuffer[index++] = 128 + ( chr >>> 6 & 63 );
      byteBuffer[index++] = 128 + ( chr & 63 );
    }
    else /* if ( chr <= 0x7fffffff ) */
    {
      /* six bytes */
      byteBuffer[index++] = 252 + ( chr / 1073741824 );
      byteBuffer[index++] = 128 + ( chr >>> 24 & 63 );
      byteBuffer[index++] = 128 + ( chr >>> 18 & 63 );
      byteBuffer[index++] = 128 + ( chr >>> 12 & 63 );
      byteBuffer[index++] = 128 + ( chr >>> 6 & 63 );
      byteBuffer[index++] = 128 + ( chr & 63 );
    }
  }

  return byteBuffer;
}

// --
// declare
// --

var Proto =
{

  // base64

  base64ToBuffer: _base64ToBuffer,
  base64FromBuffer: _base64FromBuffer,
  base64ToBlob: _base64ToBlob,
  // base64FromBlob: _base64FromBlob,

  base64FromUtf8Slow: _base64FromUtf8Slow,
  base64FromUtf8: _base64FromUtf8,
  base64ToUtf8Slow : _base64ToUtf8Slow,
  base64ToUtf8: _base64ToUtf8,

  // utf8

  utf8FromBuffer: _utf8FromBuffer,
  utf8ToBuffer: _utf8ToBuffer,

}

Self = _.encode = _.encode || Object.create( null );
_.mapExtend( _.encode,Proto );

// --
// register
// --

_.Gdf([ readJson, writeJsonMin, writeJsonFine ]);
_.Gdf([ readJsStructure, /*readJsNode, readJsSmart,*/ writeJsStrcuture ]);
_.Gdf([ readYml, writeYml ]);
_.Gdf([ readCoffee, writeCoffee ]);
_.Gdf([ readBson, writeBson ]);
_.Gdf([ readCbor, writeCbor ]);
_.Gdf([ readMsgpackLite, writeMsgpackLite, readMsgpackWtp, writeMsgpackWtp ]);

_.Gdf([ base64ToBuffer, base64FromBuffer ]);
_.Gdf([ base64ToBlob ]);
_.Gdf([ base64FromUtf8Slow, base64ToUtf8Slow, base64FromUtf8, base64ToUtf8 ]);
_.Gdf([ utf8FromBuffer, utf8ToBuffer ]);

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
