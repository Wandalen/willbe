function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  if( o.v !== null && o.v !== undefined )
  o.verbosity = o.v;
  _.routine.options( onModule, o );

  let config = _.censor.configRead();
  if( !config )
  return exit( 'No censor config' );
  if( !config.path )
  return exit( 'Censor config does not have either path::proto or path::module' );
  if( !config.path.proto || !config.path.module )
  return exit( 'Censor config does not have either path::proto or path::module' );

  let protoPath = config.path.proto;
  if( !fileProvider.fileExists( protoPath ) )
  return exit( `${protoPath} does not exist` );

  let isProto = path.begins( context.junction.dirPath, config.path.proto );
  if( isProto )
  return null;

  let verbosity = 0;
  if( o.verbosity )
  verbosity = o.verbosity >= 2 ? 5 : 1;

  /* */

  let excludeAny =
  [
    /\.git$/,
    /\.svn$/,
    /\.hg$/,
    /\.tmp($|\/)/,
    /\.DS_Store$/,
    /(^|\/)-/,
  ]

  let maskAll = _.RegexpObject( excludeAny, 'excludeAny' );

  /* */

  let moduleProtoPath = path.join( context.junction.dirPath, 'proto' );
  if( fileProvider.fileExists( moduleProtoPath ) )
  {
    let reocrds = fileProvider.filesReflect
    ({
      filter : { filePath : { [ moduleProtoPath ] : protoPath }, maskAll },
      dstRewritingOnlyPreserving : !o.force,
      breakingSrcHardLink : 1,
      breakingDstHardLink : 0,
      linkingAction : 'hardLink',
      verbosity
    });
  }

  let moduleStepPath = path.join( context.junction.dirPath, 'step' );
  if( fileProvider.fileExists( moduleStepPath ) )
  {
    fileProvider.filesReflect
    ({
      filter : { filePath : { [ moduleStepPath ] : path.join( protoPath, 'common/step' ) }, maskAll },
      dstRewritingOnlyPreserving : !o.force,
      breakingSrcHardLink : 1,
      breakingDstHardLink : 0,
      linkingAction : 'hardLink',
      verbosity
    });
  }

  let moduleWorkflowsPath = path.join( context.junction.dirPath, '.github/workflows' );
  if( fileProvider.fileExists( moduleWorkflowsPath ) )
  {
    fileProvider.filesReflect
    ({
      filter : { filePath : { [ moduleWorkflowsPath ] : path.join( protoPath, 'common/github/workflows' ) }, maskAll },
      dstRewritingOnlyPreserving : !o.force,
      breakingSrcHardLink : 1,
      breakingDstHardLink : 0,
      linkingAction : 'hardLink',
      verbosity
    });
  }

  let circleciPath = path.join( context.junction.dirPath, '.circleci' );
  if( fileProvider.fileExists( circleciPath ) )
  {
    fileProvider.filesReflect
    ({
      filter : { filePath : { [ circleciPath ] : path.join( protoPath, 'common/circleci' ) }, maskAll },
      dstRewritingOnlyPreserving : !o.force,
      breakingSrcHardLink : 1,
      breakingDstHardLink : 0,
      linkingAction : 'hardLink',
      verbosity
    });
  }

  function exit( msg )
  {
    console.error( msg );
    return; null
  }

}

var defaults = ( onModule.defaults = Object.create( null ) );
defaults.v = null;
defaults.verbosity = 3;
defaults.force = 0;

module.exports = onModule;
