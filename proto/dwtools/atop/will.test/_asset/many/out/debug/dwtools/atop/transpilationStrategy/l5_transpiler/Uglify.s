( function _TranspilerUglify_s_() {

'use strict';

let Uglify = require( 'uglify-es' );

//

let _ = wTools;
let Parent = _.TranspilationStrategy.Transpiler.Abstract;
let Self = function wTsTranspilerUglify( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Uglify';

// --
//
// --

/*
doc : https://github.com/mishoo/UglifyJS2/tree/harmony
*/

function _formAct( stage )
{
  let self = this;
  let sys = stage.sys;
  let single = stage.single;
  let multiple = stage.multiple;
  let fileProvider = multiple.fileProvider;
  let path = fileProvider.path;

  // let stage = self.stage;

  _.assert( arguments.length === 1 );
  _.assert( stage instanceof sys.Stage );
  _.assert( stage.formed === 0 );

  if( !stage.settings )
  stage.settings = Object.create( null );
  let set = stage.settings;

  // debugger;
  if( set.sourceMap === undefined )
  {
    _.assert( _.strIs( single.outPath ) );
    _.assert( _.strIs( single.sourceMapPath ) );
    set.sourceMap = Object.create( null );
    set.sourceMap.filename = single.sourceMapPath;
    // set.sourceMap.filename = path.join( single.outPath + '.map' );
    // stage.mapFilePath = set.sourceMap.filename; // xxx
  }

  set.sourceMap = false;

  if( set.warnings === undefined ) set.warnings = !!stage.verbosity;
  set.warnings = false;

  // set.toplevel = false;

  /* parse */

  set.parse = Object.create( null );
  set.parse.ecma = 8;
  set.parse.shebang = true;

  /* mangle */

  let defMangle =
  {
    ie8         : false,
    toplevel    : false,
    eval        : false,
    keep_fnames : true,
    keep_classnames : true,
  }

  let mangle = set.mangle = set.mangle || Object.create( null );
  _.mapSupplement( mangle, defMangle );

  set.mangle.toplevel = multiple.minification >= 8;

  if( multiple.minification === 0 )
  {
    set.mangle = false;
  }
  else
  {
    // set.mangle.toplevel = true;
    // intrusive !
    // let properties = set.mangle.properties = set.mangle.properties || Object.create( null );
    // properties.keep_quoted = true;
  }

  /* compress */

/*
ie8           : false, // ie8 unsafe
sequences     : true,  // join consecutive statemets with the “comma operator”
properties    : true,  // optimize property access : a["foo"] → a.foo
dead_code     : true,  // discard unreachable code
drop_debugger : true,  // discard "debugger" statements
drop_console  : true,  // discard "console" statements
unsafe        : false, // some unsafe optimizations (see below)
conditionals  : true,  // optimize if-s and conditional expressions
comparisons   : true,  // optimize comparisons
evaluate      : true,  // evaluate constant expressions
booleans      : true,  // optimize boolean expressions
loops         : true,  // optimize loops
unused        : true,  // drop unused variables/functions
hoist_funs    : true,  // hoist function declarations
hoist_vars    : false, // hoist variable declarations
if_return     : true,  // optimize if-s followed by return/continue
join_vars     : true,  // join let declarations
cascade       : true,  // try to cascade `right` into `left` in sequences
side_effects  : true,  // drop side-effect-free statements
warnings      : true,  // warn about potentially dangerous optimizations/code
global_defs   : {}     // global definitions

*/

  let defCompress =
  {
    ie8 : false,
    sequences : true,
    dead_code : true,
    drop_console : false,
    drop_debugger : false,
    comparisons : false,
    evaluate : false,
    arrows : false,
    booleans : false,
    loops : true,
    unused : true,
    unsafe : false,
    hoist_funs : false,
    join_vars : false,
    // cascade : true, /* removed? */
    keep_fnames : true,
    keep_infinity : true,
    negate_iife : false,
    toplevel : false,
    passes : 1,
    // ecma : 6, /* problematic */
  }

  if( set.compress === undefined )
  set.compress = Object.create( null );
  let compress = set.compress;

  if( compress )
  {

    if( compress.passes === undefined ) compress.passes = ( multiple.optimization > 7 || multiple.minification > 7 ) ? 2 : 1;
    if( compress.unused === undefined ) compress.unused = !!multiple.optimization;

    if( compress.booleans === undefined ) compress.booleans = !!multiple.minification;
    if( compress.reduce_vars === undefined ) compress.reduce_vars = multiple.optimization > 4;
    if( compress.collapse_vars === undefined ) compress.collapse_vars = multiple.optimization > 7;
    if( compress.hoist_funs === undefined ) compress.hoist_funs = !!multiple.minification;
    if( compress.join_vars === undefined ) compress.join_vars = !!multiple.minification;
    if( compress.inline === undefined ) compress.inline = _.numberClamp( Math.floor( multiple.optimization / 3 ), [ 0, 3 ] );
    if( compress.if_return === undefined ) compress.if_return = !!multiple.optimization;
    if( compress.conditionals === undefined ) compress.conditionals = !!multiple.optimization;
    if( compress.comparisons === undefined ) compress.comparisons = !!multiple.optimization;
    // if( compress.top_retain === undefined ) compress.top_retain = multiple.minification < 5; /* it should be function or string */
    if( compress.evaluate === undefined ) compress.evaluate = !!multiple.optimization;
    if( compress.negate_iife === undefined ) compress.negate_iife = !!multiple.optimization;

    // if( compress.arrows === undefined ) compress.arrows = !!multiple.optimization;
    if( compress.toplevel === undefined ) compress.toplevel = multiple.optimization > 7;
    if( compress.drop_debugger === undefined ) compress.drop_debugger = !!multiple.minification && !multiple.diagnosing && !multiple.beautifing;
    if( compress.drop_console === undefined ) compress.drop_console = !!multiple.minification && !multiple.diagnosing && !multiple.beautifing;

    if( compress.global_defs === undefined ) compress.global_defs =
    {
      'DEBUG' : !!multiple.diagnosing,
      'Config.debug' : !!multiple.diagnosing,
      'Config.release' : !multiple.diagnosing,
    }

    _.mapSupplement( compress, defCompress );

    // if( compress.top_retain )
    // compress.top_retain = function( a, b, c )
    // {
    //   debugger;
    //   console.log( a, b, c )
    // }

  }

  /* output */

  if( set.output === undefined ) set.output = Object.create( null );
  let output = set.output;
  let defOutput =
  {
    beautify : !multiple.beautifing,
    comments : !multiple.beautifing,
    indent_level : !multiple.beautifing ? 2 : undefined,
    keep_quoted_props : !multiple.beautifing ? true : false,
    max_line_len : !multiple.beautifing ? 160 : 65535,
    source_map : null,
    // ecma : 6, /* problematic */
  }

  _.mapSupplement( output, defOutput );

  stage.formed = 1;
  return stage;
}

//

function _performAct( stage )
{
  let self = this;
  let sys = stage.sys;
  let single = stage.single;
  let multiple = stage.multiple;
  let fileProvider = multiple.fileProvider;
  let path = fileProvider.path;

  _.assert( arguments.length === 1 );
  _.assert( stage instanceof sys.Stage );
  _.assert( stage.formed === 1 );

  stage.rawData = Uglify.minify( stage.input.data, stage.settings );

  if( stage.rawData.error )
  throw stage.errorHandle( stage.rawData.error );

  _.assert( _.strIs( stage.rawData.code ), 'Output should be string' );

  stage.data = stage.rawData.code;

  stage.formed = 2;
  return stage;
}

// --
// relationships
// --

let Composes =
{
  fileProvider : _.define.own( new _.FileProvider.HardDrive({ encoding : 'utf8' }) )
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

// --
// prototype
// --

let Proto =
{

  _formAct,
  _performAct,

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

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

_.TranspilationStrategy.Transpiler[ Self.shortName ] = Self;
if( !_.TranspilationStrategy.Transpiler.Default )
_.TranspilationStrategy.Transpiler.Default = Self;

})();
