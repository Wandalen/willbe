
let _ = require( `../../Tools.s` );
_.include( `wAppBasic` );
_.include( `wFiles` );

let execPath = _.path.nativize( _.path.join( __dirname, `../will/Exec` ) );
let assetDirPath = _.path.join( __dirname, `_asset` );
let repoDirPath = _.path.join( assetDirPath, `_repo` );
let ready = new _.Consequence().take( null );
let start = _.process.starter
({
  currentPath : repoDirPath,
  outputCollecting : 1,
  ready : ready,
})

let will = _.process.starter
({
  currentPath : assetDirPath,
  execPath : `node ` + execPath,
  outputCollecting : 1,
  outputGraying : 1,
  ready : ready,
  throwingExitCode : 0,
})

let reposDownload = require( `./ReposDownload.s` );

ready.then( () => _.fileProvider.filesDelete( repoDirPath ) );
ready.then( () => reposRedownload() );

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

var asset = `${asset}`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub/ .export debug:0` );
will( `.with ${asset}/sub/ .export debug:1` );
will( `.with ${asset}/ .export debug:0` );
will( `.with ${asset}/ .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

function del( filePath )
{
  return _.fileProvider.filesDelete( _.path.join( assetDirPath, filePath ) ) || null;
}

function copy( dst, src )
{
  return _.fileProvider.filesReflect
  ({
    dst : _.path.join( assetDirPath, dst ),
    src : _.path.join( assetDirPath, src ),
  }) || null;
}
