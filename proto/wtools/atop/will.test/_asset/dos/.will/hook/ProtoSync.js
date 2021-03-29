function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  const fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  // debugger;
  // console.log( 'xxx : proto sync' );

  if( o.v !== null && o.v !== undefined ) o.verbosity = o.v;
  _.routineOptions( onModule, o );

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.path )
  return null;
  if( !config.path.proto || !config.path.module )
  return null;

  let protoPath = config.path.proto;
  if( !fileProvider.fileExists( protoPath ) )
  return null;

  let isProto = path.begins( context.junction.dirPath, config.path.proto );
  if( isProto )
  return null;

  let verbosity = 0;
  if( o.verbosity )
  verbosity = o.verbosity >= 2 ? 5 : 1;

  let moduleProtoPath = path.join( context.junction.dirPath, 'proto' );
  if( fileProvider.fileExists( moduleProtoPath ) )
  {
    return fileProvider.filesReflect
    ({
      filter : { filePath : { [ moduleProtoPath ] : protoPath } },
      dstRewritingOnlyPreserving : 1,
      breakingSrcHardLink : 1,
      breakingDstHardLink : 0,
      linking : 'hardLink',
      verbosity
    });
  }

  let moduleStepPath = path.join( context.junction.dirPath, 'step' );
  if( fileProvider.fileExists( moduleStepPath ) )
  {
    return fileProvider.filesReflect
    ({
      filter : { filePath : { [ moduleStepPath ] : path.join( protoPath, 'step' ) } },
      dstRewritingOnlyPreserving : 1,
      breakingSrcHardLink : 1,
      breakingDstHardLink : 0,
      linking : 'hardLink',
      verbosity
    });
  }

}

var defaults = ( onModule.defaults = Object.create( null ) );
defaults.v = null;
defaults.verbosity = 3;

module.exports = onModule;
