( function _PathObj_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

// xxx

let _ = wTools;
let Parent = _.Will.Resource;
let Self = function wWillPathObj( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'PathObj';

// --
// inter
// --

function OptionsFrom( o )
{
  _.assert( arguments.length === 1 );
  if( _.strIs( o ) || _.arrayIs( o ) )
  return { path : o }
  return o;
}

//

function unform()
{
  let patho = this;
  let module = patho.module;
  let willf = patho.willf;

  _.assert( module[ patho.MapName ][ patho.name ] === patho );
  if( willf )
  _.assert( willf[ patho.MapName ][ patho.name ] === patho );

  Parent.prototype.unform.apply( patho, arguments )

  delete module[ patho.MapName ][ patho.name ];
  if( willf )
  delete willf[ patho.MapName ][ patho.name ];

  delete module.pathMap[ patho.name ];
  if( willf )
  delete willf.pathMap[ patho.name ];

  return patho;
}

//

function form1()
{
  let patho = this;
  let module = patho.module;
  let willf = patho.willf;

  _.sure( !module[ patho.MapName ][ patho.name ], () => 'Module ' + module.dirPath + ' already has ' + patho.nickName );
  _.assert( !willf || !willf[ patho.MapName ][ patho.name ] );

  Parent.prototype.form1.apply( patho, arguments )

  module[ patho.MapName ][ patho.name ] = patho;
  if( willf )
  willf[ patho.MapName ][ patho.name ] = patho;

  module.pathMap[ patho.name ] = patho.path;
  if( willf )
  willf.pathMap[ patho.name ] = patho.path;

  return patho;
}

//

function form3()
{
  let patho = this;
  let module = patho.module;
  let willf = patho.willf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( patho.formed === 2 );

  /* begin */

  /* end */

  _.sure( _.strIs( patho.path ) || _.arrayIs( patho.path ), 'Path resource should have "path" field' );
  _.assert
  (
    _.all( patho.path, ( p ) => path.isRelative( p ) || path.isGlobal( p ) ),
    () => patho.nickName + ' should not have absolute paths, but have ' + _.toStr( patho.path )
  );

  patho.formed = 3;
  return patho;
}

//

function _pathSet( src )
{
  let patho = this;
  let module = patho.module;

  _.assert( src === null || _.strIs( src ) || _.arrayLike( src ) );

  if( _.arrayLike( src ) )
  src = _.arraySlice( src );

  if( patho.path )
  debugger;
  // if( src )
  // debugger;

  if( module && patho.name )
  {
    // debugger;
    _.assert( module.pathMap[ patho.name ] === patho.path );
    delete module.pathMap[ patho.name ];
  }

  patho[ pathSymbol ] = src;

  if( module && patho.name )
  {
    // debugger;
    _.assert( module.pathMap[ patho.name ] === undefined );
    module.pathMap[ patho.name ] = patho.path;
  }

}

// --
// relations
// --

let pathSymbol = Symbol.for( 'path' );

let Composes =
{

  path : null,
  description : null,
  criterion : null,
  inherit : _.define.own([]),

}

let Aggregates =
{
  name : null,
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  OptionsFrom : OptionsFrom,
  MapName : 'pathObjMap',
  PoolName : 'path',
}

let Forbids =
{
}

let Accessors =
{

  path : { setter : _pathSet },

}

// --
// declare
// --

let Proto =
{

  // inter

  OptionsFrom,

  unform,
  form1,
  form3,

  // relation

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Accessors,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _global_.wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
