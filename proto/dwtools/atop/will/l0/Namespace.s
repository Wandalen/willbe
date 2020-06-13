( function _Main_s_( ) {

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

Command routines list

Without selectors :

commandVersion
commandVersionCheck
commandSubmodulesFixate
commandSubmodulesUpgrade
commandSubmodulesVersionsDownload
commandSubmodulesVersionsUpdate
commandSubmodulesVersionsVerify
commandSubmodulesVersionsAgree
commandHooksList
commandClean
commandSubmodulesClean
commandModulesTree

With resource selector :

commandResourcesList
commandPathsList
commandSubmodulesList
commandReflectorsList
commandStepsList
commandBuildsList
commandExportsList
commandAboutList
commandModulesList
commandModulesTopologicalList
commandSubmodulesAdd
commandGitPreservingHardLinks

With selector of build :

commandBuild
commandExport
commandExportPurging
commandExportRecursive

With other selectors :

commandHelp
commandImply,
commandModuleNew
commandModuleNewWith
commandWith
commandEach
commandPackageInstall
commandPackageLocalVersions
commandPackageRemoteVersions
commandPackageVersion

commandShell
commandDo
commandHookCall

*/

// --
// relations
// --

let _ = _global_.wTools;
let Self = _.will = _.will || Object.create( null );
let ModuleVariant = [ '/', '*/object', '*/module', '*/relation', '*/handle' ];

// --
// declare
// --

let Extend = /* xxx : rename */
{

  ModuleVariant,

}

_.mapExtend( Self, Extend );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
