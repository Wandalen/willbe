( function _HtmlDocument_s_() {

'use strict'; 

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../Tools.s' );
  if( !_.FileProvider )
  require( '../UseMid.s' );

}

let _global = _global_;
let _ = _global_.wTools;
let Abstract = _.FileProvider.Abstract;
let Partial = _.FileProvider.Partial;
let FileRecord = _.FileRecord;
let Find = _.FileProvider.Find;

_.assert( _.routineIs( _.FileRecord ) );
_.assert( _.routineIs( Abstract ) );
_.assert( _.routineIs( Partial ) );
_.assert( !!Find );
_.assert( !_.FileProvider.HtmlDocument );

//

let Parent = Partial;
let Self = function wFileProviderHtmlDocument( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'HtmlDocument';

// --
// inter
// --

function init( o )
{
  let self = this;
  Parent.prototype.init.call( self,o );

  if( self.filesTree === null )
  self.filesTree = Object.create( null );

}

// --
// path
// --

function pathCurrentAct()
{
  let self = this;
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( arguments.length === 1 && arguments[ 0 ] )
  {
    let path = arguments[ 0 ];
    _.assert( self.path.is( path ) );
    self._currentPath = path;
  }

  let result = self._currentPath;

  return result;
}

// --
// read
// --

function fileReadAct( o )
{
  let self = this;
  let con = new _.Consequence();
  let result = null;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertRoutineOptions( fileReadAct,o );
  _.assert( _.strIs( o.encoding ) );

  let encoder = fileReadAct.encoders[ o.encoding ];

  if( o.encoding )
  if( !encoder )
  return handleError( _.err( 'Encoding: ' + o.encoding + ' is not supported!' ) )

  /* exec */

  handleBegin();

  debugger; _.assert( 0, 'not implemented' );

  return handleEnd( result );

  /* begin */

  function handleBegin()
  {

    if( encoder && encoder.onBegin )
    _.sure( encoder.onBegin.call( self, { operation : o, encoder : encoder }) === undefined );

  }

  /* end */

  function handleEnd( data )
  {

    let context = { data : data, operation : o, encoder : encoder };
    if( encoder && encoder.onEnd )
    _.sure( encoder.onEnd.call( self,context ) === undefined );

    if( o.sync )
    {
      return context.data;
    }
    else
    {
      return con.take( context.data );
    }

  }

  /* error */

  function handleError( err )
  {

    debugger;

    if( encoder && encoder.onError )
    try
    {
      err = _._err
      ({
        args : [ stack,'\nfileReadAct( ',o.filePath,' )\n',err ],
        usingSourceCode : 0,
        level : 0,
      });
      err = encoder.onError.call( self,{ error : err, operation : o, encoder : encoder })
    }
    catch( err2 )
    {
      console.error( err2 );
      console.error( err.toString() + '\n' + err.stack );
    }

    if( o.sync )
    {
      throw err;
    }
    else
    {
      return con.error( err );
    }

  }

}

_.routineExtend( statReadAct, Parent.prototype.fileReadAct );

//

function statReadAct( o )
{
  let self = this;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assertRoutineOptions( statReadAct,o );

  /* */

  if( o.sync )
  {
    return _statReadAct( o.filePath );
  }
  else
  {
    return _.timeOut( 0, function()
    {
      return _statReadAct( o.filePath );
    })
  }

  function _statReadAct( filePath )
  {
    let result = null;

    debugger; _.assert( 0, 'not implemented' );

    return result;
  }

}

_.routineExtend( statReadAct, Parent.prototype.statReadAct );

// --
// encoders
// --

var encoders = Object.create( null );

fileReadAct.encoders = encoders;

//

encoders[ 'utf8' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'utf8' );
  },

  onEnd : function( e )
  {
    let result = e.data;

    if( !_.strIs( result ) )
    result = _.bufferToStr( result );

    _.assert( _.strIs( result ) );
    return result;
  },

}

//

encoders[ 'ascii' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'ascii' );
  },

  onEnd : function( e )
  {
    let result = e.data;
    _.assert( _.strIs( result ) );
    return result;
  },

}

//

encoders[ 'latin1' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'latin1' );
  },

  onEnd : function( e )
  {
    let result = e.data;

    if( !_.strIs( result ) )
    result = _.bufferToStr( result );

    _.assert( _.strIs( result ) );
    return result;
  },

}

//

encoders[ 'buffer.raw' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'buffer.raw' );
  },

  onEnd : function( e )
  {
    // _.assert( _.strIs( data ) );
    // let nodeBuffer = BufferNode.from( data )
    // let result = _.bufferRawFrom( nodeBuffer );

    let result = _.bufferRawFrom( e.data );

    _.assert( !_.bufferNodeIs( result ) );
    _.assert( _.bufferRawIs( result ) );

    // debugger;
    // let str = _.bufferToStr( result )
    // _.assert( str === data );
    // debugger;

    return result;
  },

}

//

encoders[ 'buffer.bytes' ] =
{

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'buffer.bytes' );
  },

  onEnd : function( e )
  {
    let result = _.bufferBytesFrom( e.data );
    return result;
  },

}

// --
// relationship
// --

let Composes =
{
  protocols : _.define.own([]),
  _currentPath : '/',
  safe : 0,
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{

  Path : _.uri.CloneExtending({ fileProvider : Self }),

}

// --
// declare
// --

let Proto =
{

  init : init,

  //path

  pathCurrentAct : pathCurrentAct,
  // pathResolveSoftLinkAct : pathResolveSoftLinkAct,
  // pathResolveHardLinkAct : pathResolveHardLinkAct,
  // softLinkReadAct : softLinkReadAct,

  // read

  fileReadAct : fileReadAct,
  // streamReadAct : null,
  // dirReadAct : dirReadAct,

  // read stat

  statReadAct : statReadAct,
  // fileExistsAct : fileExistsAct,

  // isTerminalAct : isTerminalAct,

  // isHardLink : isHardLink,
  // isSoftLink : isSoftLink,
  // filesAreHardLinkedAct : filesAreHardLinkedAct,

  // write

  // fileWriteAct : fileWriteAct,
  // streamWriteAct : null,
  // fileTimeSetAct : fileTimeSetAct,
  // fileDeleteAct : fileDeleteAct,
  // dirMakeAct : dirMakeAct,

  //link act

  // fileRenameAct : fileRenameAct,
  // fileCopyAct : fileCopyAct,
  // softLinkAct : softLinkAct,
  // hardLinkAct : hardLinkAct,
  // hardLinkBreakAct : hardLinkBreakAct,

  //

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.FileProvider.Find.mixin( Self );
_.FileProvider.Secondary.mixin( Self );

// --
// export
// --

_.FileProvider[ Self.shortName ] = Self;

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
