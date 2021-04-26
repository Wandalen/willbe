( function _Basic_s_()
{

'use strict';

/*
= Principles
- Willbe prepends all relative paths by path::in. path::out and path::temp are prepended by path::in as well.
- Willbe prepends path::in by module.dirPath, a directory which has the willfile.
- Major difference between generated out-willfiles and manually written willfile is section exported. out-willfiles has such section, manually written willfile does not.
- Output files are generated and input files are for manual editing, but the utility can help with it.
*/

/*
= Requested features
- Command .submodules.update should change back manually updated fixated submodules.
- Faster loading, perhaps without submodules
- Timelapse for transpilation
- Reflect submodules into dir with the same name as submodule
*/

/*

qqq : make working command `will .with file1 file2 file3.will.yml`
- for example `will .with file1 file2 file3.will.yml .clean`

*/

const _ = _global_.wTools;
const Self = _.will = _.will || Object.create( null );

// --
// implementation
// --


// --
// declare
// --

const ResourceKind = new Set
([
  'submodule',
  'step',
  'path',
  'reflector',
  'build',
  'about',
  'execution',
  'exported',
]);

// --
// declare
// --

let Extension =
{

  ResourceKind,

}

_.props.extend( Self, Extension );

})();
