(function _Color_s_() {

'use strict';

/**
 * Collection of routines to operate colors conveniently. Color provides functions to convert color from one color space to another color space, from name to color and from color to the closest name of a color. The module does not introduce any specific storage format of color what is a benefit. Color has a short list of the most common colors. Use the module for formatted colorful output or other sophisticated operations with colors.
  @module Tools/mid/Color
*/

/**
 * @file Color.s.
 */

/**
 * @summary Collection of routines to operate colors conveniently.
 * @namespace "wTools.color"
 * @memberof module:Tools/mid/Color
*/

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

}

var _ = _global_.wTools;

//

/**
 * @summary Returns rgb value for color with provided `name`.
 * @param {String} name Target color name.
 * @param {} def Default value. Is used if nothing was found.
 * @example
 * _.color.rgbFromName( 'black' );
 * @example
 * _.color.rgbFromName( 'black', [ 0,0,0 ] );
 * @throws {Error} If no arguments provided.
 * @function rgbFromName
 * @memberof module:Tools/mid/Color.wTools.color
 */

function rgbFromName( name,def )
{
  var o = _.routineOptionsFromThis( rgbFromName,this,Self );

  _.routineOptions( rgbFromName,o );

  var result;
  if( !o.colorMap )
  o.colorMap = Self.ColorMap;

  _.assert( arguments.length <= 2 );
  _.assert( _.strIs( name ) );

  name = name.toLowerCase();
  name = name.trim();

  return _rgbFromName( name,def,o.colorMap );
}

rgbFromName.defaults =
{
  colorMap : null,
}

//

function _rgbFromName( name,def,map )
{
  var result = map[ name ];

  if( !result )
  result = def;

  return result;
}

//

/**
 * @summary Gets rgb values from bitmask `src`.
 * @param {Number} src Source bitmask.
 * @example
 * _.color.rgbByBitmask( 0xff00ff );
 * //[1, 0, 1]
 * @throws {Error} If no arguments provided.
 * @function rgbFromName
 * @memberof module:Tools/mid/Color.wTools.color
 */

function rgbByBitmask( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.numberIs( src ) );

  return _rgbByBitmask( src );
}

//

function _rgbByBitmask( src )
{
  var result = [];

  result[ 0 ] = ( ( src >> 16 ) & 0xff ) / 255;
  result[ 1 ] = ( ( src >> 8 ) & 0xff ) / 255;
  result[ 2 ] = ( ( src >> 0 ) & 0xff ) / 255;

  return result;
}

//

function _rgbaFromNotName( src )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.numberIs( src ) || _.longIs( src ) || _.mapIs( src ) );

  if( _.mapIs( src ) )
  {
    var result = [];
    result[ 0 ] = src.r === undefined ? 1 : src.r;
    result[ 1 ] = src.g === undefined ? 1 : src.g;
    result[ 2 ] = src.b === undefined ? 1 : src.b;
    result[ 3 ] = src.a === undefined ? 1 : src.a;
    return result;
  }

  if( _.numberIs( src ) )
  {
    result = _rgbByBitmask( src );
    return _.arrayGrow( result,0,4,1 );
  }

  var result = [];

  /* */

  for( var r = 0 ; r < src.length ; r++ )
  result[ r ] = Number( src[ r ] );

  if( result.length < 4 )
  result[ 3 ] = 1;

  /* */

  return result;
}

//

/**
 * @summary Returns rgba color values for provided entity `src`.
 * @param {Number|Array|String|Object} src Source entity.
 * @example
 * _.color.rgbaFrom( 0xFF0080 );
 * //[ 1, 0, 0.5, 1 ]
 *
 * @example
 * _.color.rgbaFrom( { r : 0 } );
 * //[ 0, 1, 1, 1 ]
 *
 * @example
 * _.color.rgbaFrom( 'white' );
 * //[ 1, 1, 1, 1 ]
 *
 * @example
 * _.color.rgbaFrom( '#ffffff );
 * //[ 1, 1, 1, 1 ]
 *
 * @example
 * _.color.rgbaFrom( [ 1,1,1 ] );
 * //[ 1, 1, 1, 1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function rgbaFrom
 * @memberof module:Tools/mid/Color.wTools.color
 */

function rgbaFrom( src )
{
  var result;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.numberIs( src ) || _.longIs( src ) || _.mapIs( src ) )
  return _rgbaFromNotName( src );

  /* */

  if( _.strIs( src ) )
  result = rgbFromName.call( this,src );

  if( result )
  {
    if( result.length !== 4 )
    result = _.arrayGrow( result,0,4,1 );
    return result;
  }

  /* */

  if( _.strIs( src ) )
  result = _.color.hexToColor( src );

  if( result )
  {
    if( result.length !== 4 )
    result = _.arrayGrow( result,0,4,1 );

    return result;
  }

  /* */

  _.assertWithoutBreakpoint( 0, 'Unknown color', _.strQuote( src ) );
}

rgbaFrom.defaults =
{
  colorMap : null,
}

//

/**
 * @summary Short-cut for {@link module:Tools/mid/Color.wTools.color.rgbaFrom}.
 * @description Returns rgb color values for provided entity `src`.
 * @param {Number|Array|String|Object} src Source entity.
 * @example
 * _.color.rgbFrom( 0xFF0080 );
 * //[ 1, 0, 0.5 ]
 *
 * @example
 * _.color.rgbFrom( { r : 0 } );
 * //[ 0, 1, 1 ]
 *
 * @example
 * _.color.rgbFrom( 'white' );
 * //[ 1, 1, 1 ]
 *
 * @example
 * _.color.rgbFrom( '#ffffff );
 * //[ 1, 1, 1 ]
 *
 * @example
 * _.color.rgbFrom( [ 1,1,1 ] );
 * //[ 1, 1, 1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function rgbFrom
 * @memberof module:Tools/mid/Color.wTools.color
 */

function rgbFrom( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.longIs( src ) )
  return _.longSlice( src,0,3 );

  var result = rgbaFrom.call( this,src );

  return _.longSlice( result,0,3 );
}

rgbFrom.defaults =
{
}

rgbFrom.defaults.__proto__ = rgbaFrom.defaults;

//

/**
 * @summary Short-cut for {@link module:Tools/mid/Color.wTools.color.rgbaFrom}.
 * @description Returns rgba color values for provided entity `src` or default value if nothing was found.
 * @param {Number|Array|String|Object} src Source entity.
 * @param {Array} def Default value.
 *
 * @example
 * _.color.rgbaFrom( 'some_color', [ 1, 0, 0.5, 1 ] );
 * //[ 1, 0, 0.5, 1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function rgbaFromTry
 * @memberof module:Tools/mid/Color.wTools.color
 */

function rgbaFromTry( src,def )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  try
  {
    return rgbaFrom.call( this,src );
  }
  catch( err )
  {
    return def;
  }

}

rgbaFromTry.defaults =
{
}

rgbaFromTry.defaults.__proto__ = rgbaFrom.defaults;

//

/**
 * @summary Short-cut for {@link module:Tools/mid/Color.wTools.color.rgbaFrom}.
 * @description Returns rgb color values for provided entity `src` or default value if nothing was found.
 * @param {Number|Array|String|Object} src Source entity.
 * @param {Array} def Default value.
 *
 * @example
 * _.color.rgbFrom( 'some_color', [ 1, 0, 0.5 ] );
 * //[ 1, 0, 0.5 ]
 *
 * @throws {Error} If no arguments provided.
 * @function rgbFromTry
 * @memberof module:Tools/mid/Color.wTools.color
 */

function rgbFromTry( src,def )
{

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  try
  {
    return rgbFrom.call( this,src );
  }
  catch( err )
  {
    return def;
  }

}

rgbFromTry.defaults =
{
}

rgbFromTry.defaults.__proto__ = rgbaFrom.defaults;

//

function _colorDistance( c1, c2 )
{
  _.assert( _.longIs( c1 ) );
  _.assert( _.longIs( c2 ) );

  var a = c1.slice();
  var b = c2.slice();

  // function _definedIs( src )
  // {
  //   return src !== undefined && src !== null && !isNaN( src )
  // }

  for( var  i = 0 ; i < 4 ; i++ )
  {
    if( !_.numberIsFinite( a[ i ] ) )
    // a[ i ] = _definedIs( b[ i ] ) ? b[ i ] : 1;
    a[ i ] = 1;

    if( !_.numberIsFinite( b[ i ] ) )
    // b[ i ] = _definedIs( a[ i ] ) ? a[ i ] : 1;
    b[ i ] = 1;
  }

  // a[ 3 ] = _definedIs( a[ 3 ] ) ? a[ i ] : 1;
  // b[ 3 ] = _definedIs( b[ 3 ] ) ? b[ i ] : 1;

  return  Math.pow( a[ 0 ] - b[ 0 ], 2 ) +
          Math.pow( a[ 1 ] - b[ 1 ], 2 ) +
          Math.pow( a[ 2 ] - b[ 2 ], 2 ) +
          Math.pow( a[ 3 ] - b[ 3 ], 2 )
}

//

function _colorNameNearest( color, map )
{
  var self = this;

  _.assert( arguments.length === 1 || arguments.length === 2 );

  if( arguments.length === 1 )
  map = _.color.ColorMap;

  _.assert( _.objectIs( map ) );

  if( _.strIs( color ) )
  {
    _.assertWithoutBreakpoint( map[ color ], 'Unknown color', _.strQuote( color ) );

    if( _.objectLike( map[ color ] ) )
    {
      _.assert( map[ color ].name );
      return self._colorNameNearest( map[ color ].name, map );
    }

    return color;
  }

  color = _rgbaFromNotName( color );

  _.assert( color.length === 4 );

  for( var r = 0 ; r < 4 ; r++ )
  {
    color[ r ] = Number( color[ r ] );
    if( color[ r ] < 0 )
    color[ r ] = 0;
    else if( color[ r ] > 1 )
    color[ r ] = 1;
  }

  // if( color[ 3 ] === undefined )
  // color[ 3 ] = 1;

  /* */

  var names = Object.keys( map );
  var nearest = names[ 0 ];
  var max = _colorDistance( map[ names[ 0 ] ], color );

  if( max === 0 )
  return nearest;

  for( var i = 1; i <= names.length - 1; i++ )
  {
    var d = _colorDistance( map[ names[ i ] ], color );
    if( d < max )
    {
      max = d;
      nearest = names[ i ];
    }

    if( d === 0 )
    return names[ i ];
  }

  return nearest;
}

//

/**
 * @summary Returns name of color that is nearest to provided `color`.
 * @param {Number|Array|String|Object} color Source color.
 *
 * @example
 * _.color.colorNameNearest( [ 1, 1, 1, 0.8 ] );
 * //'white'
 *
 * @example
 * _.color.colorNameNearest( [ 1, 1, 1, 0.3 ] );
 * //'transparent'
 *
 * @throws {Error} If no arguments provided.
 * @function colorNameNearest
 * @memberof module:Tools/mid/Color.wTools.color
 */

function colorNameNearest( color )
{
  var self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( color ) )
  {
    var color2 = _.color.hexToColor( color );
    if( color2 )
    color = color2;
  }

  try
  {
    return self._colorNameNearest( color );
  }
  catch( err )
  {
    return;
  }

}

//

function colorNearestCustom( o )
{
  var self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );

  _.routineOptions( colorNearestCustom, o );

  if( _.strIs( o.color ) )
  {
    var _color = _.color.hexToColor( o.color );
    if( _color )
    o.color = _color;
  }

  try
  {
    var name = self._colorNameNearest( o.color, o.colorMap );
    return o.colorMap[ name ];
  }
  catch( err )
  {
    return;
  }
}

colorNearestCustom.defaults =
{
  color : null,
  colorMap : null
}

//

/**
 * @summary Returns value of color that is nearest to provided `color`.
 * @param {Number|Array|String|Object} color Source color.
 *
 * @example
 * _.color.colorNearest( [ 1, 1, 1, 0.8 ] );
 * //[ 1,1,1,1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function colorNameNearest
 * @memberof module:Tools/mid/Color.wTools.color
 */

function colorNearest( color )
{
  var self = this;

  var name = self.colorNameNearest( color );
  if( name )
  return self.ColorMap[ name ];
}

//

/**
 * @summary Returns hex value for provided color `rgb`.
 * @param {Number|Array|String|Object} color Source color.
 * @param {Array} def Default value.
 *
 * @example
 * _.color.colorToHex( [ 1, 0, 1 ] );
 * //'#ff00ff'
 *
 * @throws {Error} If no arguments provided.
 * @function colorToHex
 * @memberof module:Tools/mid/Color.wTools.color
 */

function colorToHex( rgb, def )
{

  _.assert( arguments.length === 1 || arguments.length === 2 )

  // if( arguments.length === 3 )
  // {
  //   return "#" + ( ( 1 << 24 ) + ( Math.floor(rgb*255) << 16) + ( Math.floor( g*255 ) << 8 ) + Math.floor( b*255 ) ).toString( 16 ).slice( 1 );
  // }
  // else

  if( _.arrayIs( rgb ) )
  {
    // throw _.err( 'not tested' );
    return "#" + ( ( 1 << 24 ) + ( Math.floor( rgb[ 0 ]*255 ) << 16 ) + ( Math.floor( rgb[ 1 ]*255 ) << 8 ) + Math.floor( rgb[ 2 ]*255 ) )
    .toString( 16 ).slice( 1 );
  }
  else if( _.numberIs( rgb ) )
  {
    // throw _.err( 'not tested' );
    var hex = Math.floor( rgb ).toString( 16 );
    return '#' + _.strDup( '0', 6 - hex.length  ) + hex;
  }
  else if( _.objectIs( rgb ) )
  {
    // throw _.err( 'not tested' );
    return "#" + ( ( 1 << 24 ) + ( Math.floor( rgb.r*255 ) << 16 ) + ( Math.floor( rgb.g*255 ) << 8 ) + Math.floor( rgb.b*255 ) )
    .toString( 16 ).slice( 1 );
  }
  else if( _.strIs( rgb ) )
  {
    // throw _.err( 'not tested' );
    if( !rgb.length )
    return def;
    else if( rgb[ 0 ] == '#' )
    return rgb;
    else
    return '#' + rgb;
  }

  return def;
}

//

/**
 * @summary Returns rgb value for provided `hex` value.
 * @param {String} hex Source color.
 *
 * @example
 * _.color.colorToHex( '#ff00ff' );
 * //[ 1, 0, 1 ]
 *
 * @throws {Error} If no arguments provided.
 * @function hexToColor
 * @memberof module:Tools/mid/Color.wTools.color
 */

function hexToColor( hex )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( hex ) );

  var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
  hex = hex.replace( shorthandRegex, function( m, r, g, b )
  {
    return r + r + g + g + b + b;
  });

  var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec( hex );
  if( !result )
  return null;

  result =
  [
    parseInt( result[ 1 ], 16 ) / 255,
    parseInt( result[ 2 ], 16 ) / 255,
    parseInt( result[ 3 ], 16 ) / 255,
  ]

  return result;
}

//

function colorToRgbHtml( src )
{
  var result = '';

  _.assert( _.strIs( src ) || _.objectIs( src ) || _.arrayIs( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );


  if( _.strIs( src ) )
  return src;

  if( _.objectIs( src ) )
  src = [ src.r,src.g,src.b,src.a ];

  if( _.arrayIs( src ) )
  {
    for( var i = 0; i < 3; i++ )
    _.assert( src[ i ] >= 0 && src[ i ] <= 1 )

    result += 'rgb( ';
    result += String( Math.floor( src[ 0 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 1 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 2 ]*255 ) );
    result += ' )';
  }
  else result = src;

  //console.log( 'colorHtmlToRgbHtml',result );

  return result;
}

//

function colorToRgbaHtml( src )
{
  var result = '';

  _.assert( _.strIs( src ) || _.objectIs( src ) || _.arrayIs( src ) || _.numberIs( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.strIs( src ) )
  return src;

  if( _.objectIs( src ) )
  src = [ src.r,src.g,src.b,src.a ];

  if( _.arrayIs( src ) )
  {
    for( var i = 0; i < 3; i++ )
    _.assert( src[ i ] >= 0 && src[ i ] <= 1 )

    result += 'rgba( ';
    result += String( Math.floor( src[ 0 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 1 ]*255 ) ) + ', ';
    result += String( Math.floor( src[ 2 ]*255 ) );
    if( src[ 3 ] !== undefined )
    result += ', ' + String( src[ 3 ] );
    else
    result += ', ' + '1';
    result += ' )';
  }
  else if( _.numberIs( src ) )
  {
    result = colorToRgbaHtml
    ({
      r : ( ( src >> 16 ) & 0xff ) / 255,
      g : ( ( src >> 8 ) & 0xff ) / 255,
      b : ( ( src ) & 0xff ) / 255
    });
  }
  else result = src;

  return result;
}

//

function mulSaturation( rgb,factor )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( factor >= 0 );

  var hsl = rgbToHsl( rgb );

  hsl[ 1 ] *= factor;

  var result = hslToRgb( hsl );

  if( rgb.length === 4 )
  result[ 3 ] = rgb[ 3 ];

  return result;
}

//

function brighter( rgb,factor )
{
  if( factor === undefined )
  factor = 0.1;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( factor >= 0 );

  return mulSaturation( rgb,1 + factor );
}

//

/*
  ( 1+factor ) * c2 = c1
  ( 1-efactor ) * c1 = c2

  ( 1-efactor ) * ( 1+factor ) = 1
  1+factor-efactor-efactor*factor = 1
  factor-efactor-efactor*factor = 0
  -efactor( 1+factor ) = factor
  efactor = - factor / ( 1+factor )
*/

function paler( rgb,factor )
{
  if( factor === undefined )
  factor = 0.1;

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( 0 <= factor && factor <= 1 );

  var efactor = factor / ( 1+factor );

  return mulSaturation( rgb,1 - efactor );
}

//

// --
// int
// --

function colorWidthForExponential( width )
{

  return 1 + 63 * width;

}

//

function rgbWithInt( srcInt )
{
  var result = [];

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.numberIs( srcInt ),'rgbWithInt :','Expects srcInt' );

  /* eval degree */

  var degree = 1;
  var left = srcInt;

  if( left >= 6 )
  {

    left -= 6;
    degree = 2;
    var n = 6;
    var d = 0;

    while( left >= n )
    {
      left -= n;
      degree += 1;
      d += 1;
      n *= degree;
      n /= d;
    }

  }

  /* compose set of elements */

  var set = [ 0.1 ];
  var e = 0.95;
  if( degree >= 2 ) e = 0.8;
  do
  {
    set.push( e );
    //e /= 2;

    if( set.length === 2 )
    {
      e = 0.5;
    }
    else if( set.length === 3 )
    {
      e = 0.35;
    }
    else if( set.length === 4 )
    {
      e = 0.75;
    }
    else
    {
      e *= 0.5;
    }

  }
  while( set.length <= degree );
  var last = set.length - 1;

  /* fill routine */

  function fillWithElements( i1,i2,i3 )
  {
    result[ left ] = set[ i1 ];
    result[ ( left+1 )%3 ] = set[ i2 ];
    result[ ( left+2 )%3 ] = set[ i3 ];

    return result;
  }

  /* fill result vector */

  if( degree === 1 )
  {

    if( left < 3 )
    return fillWithElements( last,0,0 );
    left -= 3;

    if( left < 3 )
    return fillWithElements( 0,last,last );
    left -= 3;

  }

  /* */

  for( var c1 = set.length - 2 ; c1 >= 0 ; c1-- )
  {

    for( var c2 = c1 - 1 ; c2 >= 0 ; c2-- )
    {

      if( left < 3 )
      return fillWithElements( last,c1,c2 );
      left -= 3;

      if( left < 3 )
      return fillWithElements( last,c2,c1 );
      left -= 3;

    }

  }

  /* */

  throw _.err( 'rgbWithInt :','No color for',srcInt );
}

//

function _rgbWithInt( srcInt )
{
  var result;

  _.assert( _.numberIs( srcInt ),'rgbWithInt :','Expects srcInt' );

  var c = 9;

  srcInt = srcInt % c;
  srcInt -= 0.3;
  if( srcInt < 0 ) srcInt += c;
  //result = hslToRgb([ srcInt / 11, 1, 0.5 ]);

  result = hslToRgb([ srcInt / c, 1, 0.5 ]);

  return result;
}

// --
// hsl
// --

function hslToRgb( hsl,result )
{
  var result = result || [];
  var h = hsl[ 0 ];
  var s = hsl[ 1 ];
  var l = hsl[ 2 ];

  if( s === 0 )
  {
    result[ 0 ] = 1;
    result[ 1 ] = 1;
    result[ 2 ] = 1;
    return result;
  }

  function get( a, b, h )
  {

    if( h < 0 ) h += 1;
    if( h > 1 ) h -= 1;

    if( h < 1 / 6 ) return b + ( a - b ) * 6 * h;
    if( h < 1 / 2 ) return a;
    if( h < 2 / 3 ) return b + ( a - b ) * 6 * ( 2 / 3 - h );

    return b;
  }

  var a = l <= 0.5 ? l * ( 1 + s ) : l + s - ( l * s );
  var b = ( 2 * l ) - a;

  result[ 0 ] = get( a, b, h + 1 / 3 );
  result[ 1 ] = get( a, b, h );
  result[ 2 ] = get( a, b, h - 1 / 3 );

  return result;
}

//

function rgbToHsl( rgb,result )
{
  var result = result || [];
  var hue, saturation, lightness;
  var r = rgb[ 0 ];
  var g = rgb[ 1 ];
  var b = rgb[ 2 ];

  var max = Math.max( r, g, b );
  var min = Math.min( r, g, b );

  lightness = ( min + max ) / 2.0;

  if( min === max )
  {

    hue = 0;
    saturation = 0;

  }
  else
  {

    var diff = max - min;

    if( lightness <= 0.5 )
    saturation = diff / ( max + min );
    else
    saturation = diff / ( 2 - max - min );

    switch( max )
    {
      case r : hue = ( g - b ) / diff + ( g < b ? 6 : 0 ); break;
      case g : hue = ( b - r ) / diff + 2; break;
      case b : hue = ( r - g ) / diff + 4; break;
    }

    hue /= 6;

  }

  result[ 0 ] = hue;
  result[ 1 ] = saturation;
  result[ 2 ] = lightness;

  return result;
}

// --
// random
// --

function randomHsl( s,l )
{

  _.assert( arguments.length <= 2 );

  if( s === undefined )
  s = 1.0;
  if( l === undefined )
  l = 0.5;

  var hsl = [ Math.random(), s, l ];

  return hsl;
}

//

function randomRgbWithSl( s,l )
{

  _.assert( arguments.length <= 2 );

  if( s === undefined )
  s = 1.0;
  if( l === undefined )
  l = 0.5;

  var rgb = hslToRgb([ Math.random(), s, l ]);

  return rgb;
}

// --
// etc
// --

function gammaToLinear( dst )
{

  if( Object.isFrozen( dst ) )
  debugger;

  _.assert( dst.length === 3 || dst.length === 4 );

  dst[ 0 ] = dst[ 0 ]*dst[ 0 ];
  dst[ 1 ] = dst[ 1 ]*dst[ 1 ];
  dst[ 2 ] = dst[ 2 ]*dst[ 2 ];

  return dst;
}

//

function linearToGamma( dst )
{

  _.assert( dst.length === 3 || dst.length === 4 );

  dst[ 0 ] = _.sqrt( dst[ 0 ] );
  dst[ 1 ] = _.sqrt( dst[ 1 ] );
  dst[ 2 ] = _.sqrt( dst[ 2 ] );

  return dst;
}

// --
// str
// --

// function strFormatBackground( str, color )
// {
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   if( arguments[ 1 ] === undefined )
//   return _strDirectiveBackgroundFor( arguments[ 0 ] );
//   else
//   return strFormatBackground( arguments[ 0 ],arguments[ 1 ] );
// }

//

function _strDirectiveBackgroundFor( color )
{
  var result = Object.create( null );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( color ) );

  result.pre = `#background : ${color}#`;
  result.post = `#background : default#`;

  return result;
}

//

function strFormatBackground( srcStr, color )
{

  if( _.numberIs( color ) )
  color = _.color.colorNameNearest( color );

  _.assert( arguments.length === 2,'Expects 2 arguments' );
  _.assert( _.strIs( srcStr ) );
  _.assert( _.strIs( color ) );

  return `#background : ${color}#${srcStr}#background : default#`;
}

//

// function strFormatForeground( str, color )
// {
//   _.assert( arguments.length === 1 || arguments.length === 2 );
//   if( arguments[ 1 ] === undefined )
//   return _strDirectiveForegroundFor( arguments[ 0 ] );
//   else
//   return strFormatForeground( arguments[ 0 ],arguments[ 1 ] );
// }

//

function _strDirectiveForegroundFor( color )
{
  var result = Object.create( null );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( color ) );

  result.pre = `#foreground : ${color}#`;
  result.post = `#foreground : default#`;

  return result;
}

//

function strFormatForeground( srcStr, color )
{

  if( _.numberIs( color ) )
  color = _.color.colorNameNearest( color );

  _.assert( arguments.length === 2,'Expects 2 arguments' );
  _.assert( _.strIs( srcStr ),'Expects string {-src-}' );
  _.assert( _.strIs( color ),'Expects string {-color-}' );

  return `#foreground : ${color}#${srcStr}#foreground : default#`;
}

//

function _strFormat( srcStr, style )
{
  var result = srcStr;

  if( _.numberIs( result ) )
  result = result + '';
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( result ), 'Expects string got', _.strType( result ) );

  var r = this.strDirectivesFor( style );

  result = r.pre + result + r.post;

  return result;
}

//

var strFormatEach = _.routineVectorize_functor( _strFormat );
var strFormat = strFormatEach;

//

function _strEscape( srcStr )
{
  var result = srcStr;
  if( _.numberIs( result ) )
  result = result + '';
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( result ), 'Expects string got',_.strType( result ) );
  return '#inputRaw:1#' + srcStr + '#inputRaw:0#'
}

var strEscape = _.routineVectorize_functor( _strEscape );

//

function _strUnescape( srcStr )
{
  var result = srcStr;
  if( _.numberIs( result ) )
  result = result + '';
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.strIs( result ), 'Expects string got',_.strType( result ) );
  return '#inputRaw:0#' + srcStr + '#inputRaw:1#'
}

var strUnescape = _.routineVectorize_functor( _strUnescape );

//

function strDirectivesFor( style )
{
  var result = Object.create( null );
  result.pre = '';
  result.post = '';

  var StyleObjectOptions =
  {
    fg : null,
    bg : null,
  }

  var style = _.arrayAs( style );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.arrayIs( style ) ,'Expects string or array of strings ( style )' );

  function join()
  {
    for( var a = 1 ; a < arguments.length ; a++ )
    {
      arguments[ 0 ].pre = arguments[ a ].pre + arguments[ 0 ].pre;
      arguments[ 0 ].post = arguments[ 0 ].post + arguments[ a ].post;
    }
    return arguments[ 0 ];
  }

  for( var s = 0 ; s < style.length ; s++ )
  {

    if( _.objectIs( style[ s ] ) )
    {
      var obj = style[ s ];
      _.assertMapHasOnly( obj,StyleObjectOptions );
      if( obj.fg )
      result = join( result, _.color._strDirectiveForegroundFor( obj.fg ) );
      if( obj.bg )
      result = join( result, _.color._strDirectiveBackgroundFor( obj.bg ) );
      continue;
    }

    _.assert( _.strIs( style[ s ] ) ,'Expects string or array of strings { style }' );

    var styleObject = this.strColorStyle( style[ s ] );

    _.assert( !!styleObject, 'Unknown style', _.strQuote( style[ s ] ) );

    if( styleObject.fg )
    result = join( result, _.color._strDirectiveForegroundFor( styleObject.fg ) );

    if( styleObject.bg )
    result = join( result, _.color._strDirectiveBackgroundFor( styleObject.bg ) );

  }

  return result;
}

//

function strColorStyle( style )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.strIs( style ),'Expects string got',_.strType( style ) );

  var result = this.Style[ style ];

  return result;
}

//

/*
qqq : cover routine strStrip
*/

function strStrip( srcStr )
{
  let result = '';

  _.assert( _.strIs( srcStr ) );

  let splitted = _.strExtractInlined
  ({
    src : srcStr,
    // onInlined : onInlined,
    preservingEmpty : 0,
    stripping : 0,
  });

  for( let i = 0 ; i < splitted.length ; i++ )
  {
    if( _.strIs( splitted[ i ] ) )
    result += splitted[ i ];
  }

  // function onInlined( split )
  // {
  //   let parts = split.split( ':' );
  //   if( parts.length === 2 )
  //   {
  //     parts[ 0 ] = parts[ 0 ].trim();
  //     return parts;
  //   }
  // }

  return result;
}

// --
// var
// --

var ColorMap =
{

  'invisible'       : [ 0.0,0.0,0.0,0.0 ],
  'transparent'     : [ 1.0,1.0,1.0,0.5 ],

  'cyan'            : [ 0.0,1.0,1.0 ],
  'magenta'         : [ 1.0,0.0,1.0 ],
  'maroon'          : [ 0.5,0.0,0.0 ],
  'dark green'      : [ 0.0,0.5,0.0 ],
  'navy'            : [ 0.0,0.0,0.5 ],
  'olive'           : [ 0.5,0.5,0.0 ],
  'teal'            : [ 0.0,0.5,0.5 ],
  'bright green'    : [ 0.5,1.0,0.0 ],
  'spring green'    : [ 0.0,1.0,0.5 ],
  'pink'            : [ 1.0,0.0,0.5 ],
  'dark orange'     : [ 1.0,0.5,0.0 ],
  'azure'           : [ 0.0,0.5,1.0 ],
  'dark blue'       : [ 0.0,0.0,0.63 ],
  'brown'           : [ 0.65,0.16,0.16 ],

}

//

var ColorMapGreyscale =
{

  'white'           : [ 1.0,1.0,1.0 ],
  'smoke'           : [ 0.9,0.9,0.9 ],
  'silver'          : [ 0.75,0.75,0.75 ],
  'gray'            : [ 0.5,0.5,0.5 ],
  'dim'             : [ 0.35,0.35,0.35 ],
  'black'           : [ 0.0,0.0,0.0 ],

}

//

var ColorMapDistinguishable =
{

  'yellow'          : [ 1.0,1.0,0.0 ],
  'purple'          : [ 0.5,0.0,0.5 ],
  'orange'          : [ 1.0,0.65,0.0 ],
  'bright blue'     : [ 0.68,0.85,0.9 ],
  'red'             : [ 1.0,0.0,0.0 ],
  'buff'            : [ 0.94,0.86,0.51 ],
  'gray'            : [ 0.5,0.5,0.5 ],
  'green'           : [ 0.0,1.0,0.0 ],
  'purplish pink'   : [ 0.96,0.46,0.56 ],
  'blue'            : [ 0.0,0.0,1.0 ],
  'yellowish pink'  : [ 1.0,0.48,0.36 ],
  'violet'          : [ 0.5,0.0,1.0 ],
  'orange yellow'   : [ 1.0,0.56,0.0 ],
  'purplish red'    : [ 0.7,0.16,0.32 ],
  'greenish yellow' : [ 0.96,0.78,0.0 ],
  'reddish brown'   : [ 0.5,0.1,0.05 ],
  'yellow green'    : [ 0.57,0.6,0.0 ],
  'yellowish brown' : [ 0.34,0.2,0.08 ],
  'reddish orange'  : [ 0.95,0.23,0.07 ],
  'olive green'     : [ 0.14,0.17,0.09 ],

}

//

var ColorMapShell =
{
  'white'           : [ 1.0,1.0,1.0 ],
  'black'           : [ 0.0,0.0,0.0 ],
  'green'           : [ 0.0,1.0,0.0 ],
  'red'             : [ 1.0,0.0,0.0 ],
  'yellow'          : [ 1.0,1.0,0.0 ],
  'blue'            : [ 0.0,0.0,1.0 ],
  'cyan'            : [ 0.0,1.0,1.0 ],
  'magenta'         : [ 1.0,0.0,1.0 ],

  'bright black'    : [ 0.5,0.5,0.5 ],

  'dark yellow'     : [ 0.5,0.5,0.0 ],
  'dark red'        : [ 0.5,0.0,0.0 ],
  'dark magenta'    : [ 0.5,0.0,0.5 ],
  'dark blue'       : [ 0.0,0.0,0.5 ],
  'dark cyan'       : [ 0.0,0.5,0.5 ],
  'dark green'      : [ 0.0,0.5,0.0 ],
  'dark white'      : [ 0.9,0.9,0.9 ],

  'bright white'    : [ 1.0,1.0,1.0 ], /* white */
  'bright green'    : [ 0.0,1.0,0.0 ], /* green */
  'bright red'      : [ 1.0,0.0,0.0 ], /* red */
  'bright yellow'   : [ 1.0,1.0,0.0 ], /* yellow */
  'bright blue'     : [ 0.0,0.0,1.0 ], /* blue */
  'bright cyan'     : [ 0.0,1.0,1.0 ], /* cyan */
  'bright magenta'  : [ 1.0,0.0,1.0 ], /* magenta */

  'dark black'      : [ 0.0,0.0,0.0 ], /* black */

  'silver'          : [ 0.9,0.9,0.9 ] /* dark white */
}

var Style =
{

  'positive' : { fg : 'green' },
  'negative' : { fg : 'red' },

  'path' : { fg : 'dark cyan' },
  'code' : { fg : 'dark green' },
  'entity' : { fg : 'blue' },

  'topic.up' : { fg : 'white', bg : 'dark blue' },
  'topic.down' : { fg : 'dark black', bg : 'dark blue' },

  'head' : { fg : 'dark black', bg : 'white' },
  'tail' : { fg : 'white', bg : 'dark black' },

  'highlighted' : { fg : 'white', bg : 'dark black' },
  'selected' : { fg : 'dark yellow', bg : 'dark blue' },
  'neutral' : { fg : 'smoke', bg : 'dim' },

  // 'pipe.neutral' : { fg : 'dark black', bg : 'dark yellow' },
  // 'pipe.negative' : { fg : 'dark red', bg : 'dark yellow' },

  'pipe.neutral' : { fg : 'dark magenta' },
  'pipe.negative' : { fg : 'dark red' },

  'exclusiveOutput.neutral' : { fg : 'dark black', bg : 'dark yellow' },
  'exclusiveOutput.negative' : { fg : 'dark red', bg : 'dark yellow' },

  'info.neutral' : { fg : 'white', bg : 'magenta' },
  'info.negative' : { fg : 'dark red', bg : 'magenta' },

}

// --
// declare
// --

var Self =
{

  //

  rgbFromName : rgbFromName,
  _rgbFromName : _rgbFromName,

  rgbByBitmask : rgbByBitmask,
  _rgbByBitmask : _rgbByBitmask,

  _rgbaFromNotName : _rgbaFromNotName,

  rgbaFrom : rgbaFrom,
  rgbFrom : rgbFrom,

  rgbaFromTry : rgbaFromTry,
  rgbFromTry : rgbFromTry,

  _colorDistance : _colorDistance,

  _colorNameNearest : _colorNameNearest,
  colorNameNearest : colorNameNearest,

  colorNearestCustom : colorNearestCustom,
  colorNearest : colorNearest,

  colorToHex : colorToHex,
  hexToColor : hexToColor,

  colorToRgbHtml : colorToRgbHtml,
  colorToRgbaHtml : colorToRgbaHtml,

  mulSaturation : mulSaturation,
  brighter : brighter,
  paler : paler,

  // int

  colorWidthForExponential : colorWidthForExponential,
  rgbWithInt : rgbWithInt,
  _rgbWithInt : _rgbWithInt,

  // hsl

  hslToRgb : hslToRgb,
  rgbToHsl : rgbToHsl,

  // random

  randomHsl : randomHsl,
  randomRgb : randomRgbWithSl,
  randomRgbWithSl : randomRgbWithSl,

  // etc

  gammaToLinear : gammaToLinear,
  linearToGamma : linearToGamma,

  // str

  _strDirectiveBackgroundFor : _strDirectiveBackgroundFor,
  strFormatBackground : strFormatBackground,
  strBg : strFormatBackground,

  _strDirectiveForegroundFor : _strDirectiveForegroundFor,
  strFormatForeground : strFormatForeground,
  strFg : strFormatForeground,

  strFormat : strFormat,
  strFormatEach : strFormatEach,

  strEscape : strEscape,
  strUnescape : strUnescape,
  strDirectivesFor : strDirectivesFor,
  strColorStyle : strColorStyle,

  strStrip : strStrip,

  // var

  ColorMap : ColorMap,
  ColorMapGreyscale : ColorMapGreyscale,
  ColorMapDistinguishable : ColorMapDistinguishable,
  ColorMapShell : ColorMapShell,
  Style : Style,

}

if( !_.color )
{
  _.color = Self;
}
else
{

  _.mapSupplement( _.color,Self );
  _.mapSupplement( _.color.ColorMap,ColorMap );
  _.mapSupplement( _.color.ColorMapGreyscale,ColorMapGreyscale );
  _.mapSupplement( _.color.ColorMapDistinguishable,ColorMapDistinguishable );
  _.mapSupplement( _.color.ColorMapShell,ColorMapShell );

}

_.mapSupplement( _.color.ColorMap,ColorMapGreyscale );
_.mapSupplement( _.color.ColorMap,ColorMapDistinguishable );
_.mapSupplement( _.color.ColorMap,ColorMapShell );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
