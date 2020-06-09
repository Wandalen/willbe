
let _ = require( `../../../dwtools/Tools.s` );
_.include( `wProcess` );
_.include( `wFiles` );

let execPath = _.path.nativize( _.path.join( __dirname, `../will/entry/Exec` ) );
let assetsOriginalPath = _.path.join( __dirname, `_asset` );
let repoDirPath = _.path.join( assetsOriginalPath, `_repo` );
let ready = new _.Consequence().take( null );
let start = _.process.starter
({
  currentPath : repoDirPath,
  outputCollecting : 1,
  ready : ready,
})

let will = _.process.starter
({
  currentPath : assetsOriginalPath,
  execPath : `node ` + execPath,
  outputCollecting : 1,
  outputGraying : 1,
  ready : ready,
  throwingExitCode : 0,
  deasync : 1,
})

let reposDownload = require( `./ReposDownload.s` );

ready.then( () => _.fileProvider.filesDelete( repoDirPath ) );
ready.then( () => reposDownload() );

var asset = `two-exported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub .export debug:0` );
will( `.with ${asset}/sub .export debug:1` );
will( `.with ${asset}/super .export debug:0` );
will( `.with ${asset}/super .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

var asset = `two-in-exported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub .export debug:0` );
will( `.with ${asset}/sub .export debug:1` );
will( `.with ${asset}/super .export debug:0` );
will( `.with ${asset}/super .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

var asset = `two-dotless-single-exported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub/ .export debug:0` );
will( `.with ${asset}/sub/ .export debug:1` );
will( `.with ${asset}/ .export debug:0` );
will( `.with ${asset}/ .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

var asset = `two-dotless-exported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub/ .export debug:0` );
will( `.with ${asset}/sub/ .export debug:1` );
will( `.with ${asset}/ .export debug:0` );
will( `.with ${asset}/ .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

var asset = `two-anon-exported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub/ .export debug:0` );
will( `.with ${asset}/sub/ .export debug:1` );
will( `.with ${asset}/ .export debug:0` );
will( `.with ${asset}/ .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

function del( filePath )
{
  return _.fileProvider.filesDelete( _.path.join( assetsOriginalPath, filePath ) ) || null;
}

function copy( dst, src )
{
  return _.fileProvider.filesReflect
  ({
    dst : _.path.join( assetsOriginalPath, dst ),
    src : _.path.join( assetsOriginalPath, src ),
  }) || null;
}
