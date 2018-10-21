( function _Export_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( '../IncludeBase.s' );

}

//

let _ = wTools;
let Parent = null;
let Self = function wImExport( o )
{
  return _.instanceConstructor( Self, this, arguments );
}

Self.shortName = 'Export';

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let exp = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.instanceInit( exp );
  Object.preventExtensions( exp );

  if( o )
  exp.copy( o );

}

//

function unform()
{
  let exp = this;
  let module = exp.module;
  let inf = exp.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( exp.formed );
  _.assert( module.exportMap[ exp.name ] === exp );
  _.assert( !inf || inf.exportMap[ exp.name ] === exp );

  /* begin */

  delete module.exportMap[ exp.name ];
  if( inf )
  delete inf.exportMap[ exp.name ];

  /* end */

  exp.formed = 0;
  return exp;
}

//

function form1()
{
  let exp = this;
  let module = exp.module;
  let inf = exp.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( !exp.formed );
  _.assert( !module.exportMap[ exp.name ] );
  _.assert( !inf || !inf.exportMap[ exp.name ] );

  _.assert( !!will );
  _.assert( !!module );
  _.assert( !!fileProvider );
  _.assert( !!logger );
  _.assert( !!will.formed );
  _.assert( !inf || !!inf.formed );
  _.assert( _.strDefined( exp.name ) );

  /* begin */

  module.exportMap[ exp.name ] = exp;
  if( inf )
  inf.exportMap[ exp.name ] = exp;

  /* end */

  exp.formed = 1;
  return exp;
}

//

function inheritForm()
{
  let exp = this;
  _.assert( arguments.length === 0 );
  _.assert( exp.formed === 1 );

  /* begin */

  if( exp.inherit )
  exp._inheritForm({ visited : [] })

  /* end */

  exp.formed = 2;
  return exp;
}

//

function _inheritForm( o )
{
  let exp = this;
  let module = exp.module;
  let inf = exp.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 1 );
  _.assert( exp.formed === 1 );
  _.assert( _.arrayIs( exp.inherit ) );
  _.assertRoutineOptions( _inheritForm, arguments );

  /* begin */

  _.arrayAppendOnceStrictly( o.visited, exp.name );

  exp.inherit.map( ( name ) =>
  {
    exp._inheritFrom({ visited : o.visited, name : name });
  });

  /* end */

  return exp;
}

_inheritForm.defaults=
{
  visited : null,
}

//

function _inheritFrom( o )
{
  let exp = this;
  let module = exp.module;
  let inf = exp.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( _.strIs( o.name ) );
  _.assert( arguments.length === 1 );
  _.assert( exp.formed === 1 );
  _.assertRoutineOptions( _inheritFrom, arguments );

  let exp2 = module.exportMap[ o.name ];
  _.sure( _.objectIs( exp2 ), () => 'Export ' + _.strQuote( o.name ) + ' does not exist' );
  _.assert( !!exp2.formed );

  if( exp2.formed !== 2 )
  {
    _.sure( !_.arrayHas( o.visited, exp2.name ), () => 'Cyclic dependency exp ' + _.strQuote( exp.name ) + ' of ' + _.strQuote( exp2.name ) );
    exp2._inheritForm({ visited : o.visited });
  }

  let extend = _.mapOnly( exp2, _.mapNulls( exp ) );
  exp.copy( extend );

  if( exp2.settings )
  exp.settings = _.mapSupplement( exp.settings, exp2.settings );

}

_inheritFrom.defaults=
{
  name : null,
  visited : null,
}

//

function form3()
{
  let exp = this;
  let module = exp.module;
  let inf = exp.inf;
  let will = module.will;
  let fileProvider = will.fileProvider;
  let path = fileProvider.path;
  let logger = will.logger;

  _.assert( arguments.length === 0 );
  _.assert( exp.formed === 2 );

  /* begin */

  if( exp.default === null )
  exp.default = 0;

  if( exp.tar === null )
  exp.tar = 1;

  _.sure( _.strIs( module.strResolve( exp.files ) ), () => 'Expects path to files, but got ' + _.toStrShort( exp.files ) );

  // default : 1
  // files : path:out.debug
  // settings :
  //   debug : 1
  //   raw : 1

  /* end */

  exp.formed = 3;
  return exp;
}

//

function info()
{
  let exp = this;
  let result = '';
  let fields = _.mapOnly( exp, exp.Composes );
  fields = _.mapButNulls( fields );

  result += 'Export ' + exp.name + '\n';
  result += _.toStr( fields, { wrap : 0, levels : 2, multiline : 1 } ) + '\n';

  return result;
}

// --
// relations
// --

let Composes =
{
  name : null,
  default : null,
  tar : null,
  files : null,
  settings : null,
}

let Aggregates =
{
}

let Associates =
{
  module : null,
  inf : null,
}

let Restricts =
{
  formed : 0,
}

let Statics =
{
}

let Forbids =
{
}

let Accessors =
{
  inherit : { setter : _.accessor.setter.arrayCollection({ name : 'inherit' }) },
}

// --
// declare
// --

let Proto =
{

  // inter

  finit : finit,
  init : init,

  unform : unform,

  form1 : form1,
  inheritForm : inheritForm,
  _inheritForm : _inheritForm,
  _inheritFrom : _inheritFrom,
  form3 : form3,

  info : info,

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

/*_.Will[ Self.shortName ] = Self;*/
_.staticDecalre
({
  prototype : _.Will.prototype,
  name : Self.shortName,
  value : Self,
});

})();
