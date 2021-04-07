
const _ = require( `../../../node_modules/Tools` );
_.include( `wProcess` );
_.include( `wFiles` );

let execPath = _.path.nativize( _.path.join( __dirname, `../will/entry/Exec` ) );
let assetsOriginalPath = _.path.join( __dirname, `_asset` );
let repoDirPath = _.path.join( assetsOriginalPath, `-repo` );
let ready = _.take( null );
let start = _.process.starter
({
  currentPath : repoDirPath,
  outputCollecting : 1,
  ready,
})

let will = _.process.starter
({
  currentPath : assetsOriginalPath,
  execPath : `node ` + execPath,
  outputCollecting : 1,
  outputGraying : 1,
  ready,
  throwingExitCode : 0,
  deasync : 1,
})

let reposDownload = require( `./ReposDownload.s` );

ready.then( () => _.fileProvider.filesDelete( repoDirPath ) );
ready.then( () => reposDownload() );

var asset = `exportMultipleExported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/ .export debug:0` );
will( `.with ${asset}/ .export debug:1` );
will( `.with ${asset}/super .export debug:0` );
will( `.with ${asset}/super .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

var asset = `twoExported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub .export debug:0` );
will( `.with ${asset}/sub .export debug:1` );
will( `.with ${asset}/super .export debug:0` );
will( `.with ${asset}/super .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

var asset = `twoInExported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub .export debug:0` );
will( `.with ${asset}/sub .export debug:1` );
will( `.with ${asset}/super .export debug:0` );
will( `.with ${asset}/super .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

var asset = `twoDotlessSingleExported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub/ .export debug:0` );
will( `.with ${asset}/sub/ .export debug:1` );
will( `.with ${asset}/ .export debug:0` );
will( `.with ${asset}/ .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

var asset = `twoDotlessExported`;
del( `${asset}/*.out/**` );
will( `.with ${asset}/sub/ .export debug:0` );
will( `.with ${asset}/sub/ .export debug:1` );
will( `.with ${asset}/ .export debug:0` );
will( `.with ${asset}/ .export debug:1` );
copy( `${asset}/+sub.out`, `${asset}/sub.out` );
copy( `${asset}/+super.out`, `${asset}/super.out` );

var asset = `twoAnonExported`;
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
    verbosity : 5,
  }) || null;
}
