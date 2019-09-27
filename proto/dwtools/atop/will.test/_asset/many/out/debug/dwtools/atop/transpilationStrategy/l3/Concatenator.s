( function _Concatenator_s_() {

'use strict';

let Zlib;

//

let _ = wTools;
let Parent = null;
let Self = function wTsConcatenatorAbstract( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Abstract';

// --
// inter
// --

function finit()
{
  let self = this;
  Parent.prototype.finit.call( self );
}

//

function init( o )
{
  let self = this;
  _.Copyable.prototype.init.call( self, o );
  Object.preventExtensions( self );
  return self;
}

//

function form()
{
  let self = this;
  let sys = self.sys;

  _.assert( arguments.length === 0 );
  _.assert( self.formed === 0 );

  self.ext = _.arrayAs( self.ext );

  self._formAct();

  _.assert( _.strsAreAll( self.ext ) );
  _.assert( self.ext.length > 0 );

  _.arrayAppendOnceStrictly( sys.concatenators, self );

  self.ext.forEach( ( ext ) =>
  {
    _.assert( sys.extToConcatenatorMap[ ext ] === undefined, () => 'Concatenator associated with extension ' + _.strQuote( ext ) + ' was already registered' );
    sys.extToConcatenatorMap[ ext ] = self;
  });

  self.formed = 1;
  return self;
}

//

function _formAct()
{
  let self = this;
  let sys = self.sys;
}

//

function perform( single )
{
  let self = this;
  let sys = self.sys;

  _.assert( arguments.length === 1 );

  let result = self._performAct( single );

  _.assert( _.strIs( result ), () => 'Concatenator should return string, but got ' + _.strType( result ) );

  return result;
}

// --
// relationships
// --

let Composes =
{
  ext : null,
}

let Aggregates =
{

}

let Associates =
{
  sys : null,
}

let Restricts =
{
  formed : 0,
}

let Forbids =
{

}

let Accessors =
{

}

// --
// prototype
// --

let Proto =
{

  finit,
  init,

  form,
  _formAct,
  perform,
  _performAct : null,

  /* */

  Composes,
  Aggregates,
  Associates,
  Restricts,

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
module[ 'exports' ] = Self;

_.TranspilationStrategy.Concatenator[ Self.shortName ] = Self;

})();
