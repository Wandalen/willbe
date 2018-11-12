( function _PathObj_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}


//

let _ = wTools;
let Parent = _.Will.Inheritable;
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
  let inf = patho.inf;

  _.assert( module[ patho.MapName ][ patho.name ] === patho );
  if( inf )
  _.assert( inf[ patho.MapName ][ patho.name ] === patho );

  Parent.prototype.unform.apply( patho, arguments )

  delete module[ patho.MapName ][ patho.name ];
  if( inf )
  delete inf[ patho.MapName ][ patho.name ];

  delete module.pathMap[ patho.name ];
  if( inf )
  delete inf.pathMap[ patho.name ];

  return patho;
}

//

function form1()
{
  let patho = this;
  let module = patho.module;
  let inf = patho.inf;

  _.sure( !module[ patho.MapName ][ patho.name ], () => 'Module ' + module.dirPath + ' already has ' + patho.nickName );
  _.assert( !inf || !inf[ patho.MapName ][ patho.name ] );

  Parent.prototype.form1.apply( patho, arguments )

  module[ patho.MapName ][ patho.name ] = patho;
  if( inf )
  inf[ patho.MapName ][ patho.name ] = patho;

  module.pathMap[ patho.name ] = patho.path;
  if( inf )
  inf.pathMap[ patho.name ] = patho.path;

  _.sure( _.strIs( patho.path ) || _.arrayIs( patho.path ), 'Path resource should have "path" field' );
  // _.assert( _.strIs( patho.path ), 'not tested' );

  return patho;
}

//

function form3()
{
  let patho = this;
  let module = patho.module;
  let inf = patho.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( patho.formed === 2 );

  /* begin */


  /* end */

  _.sure( _.strIs( patho.path ) || _.arrayIs( patho.path ), 'Path resource should have "path" field' );
  // _.assert( _.strIs( patho.path ), 'not tested' );

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

  patho[ pathSymbol ] = src;
  if( module && patho.name )
  moduke.pathMap[ patho.name ] = src;
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

  OptionsFrom : OptionsFrom,

  unform : unform,
  form1 : form1,
  form3 : form3,

  // relation

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,
  Forbids : Forbids,
  Accessors : Accessors,

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
module[ 'exports' ] = wTools;

_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
