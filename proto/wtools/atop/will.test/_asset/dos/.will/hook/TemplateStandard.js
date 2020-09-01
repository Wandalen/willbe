
let _;
function onModule( context )
{
  let o = context.request.map;
  _ = context.tools;
  let logger = context.logger;
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;

  if( !context.module.about )
  return;
  if( !context.module.about.name )
  return;

  if( o.verbosity )
  logger.log( `Applying template::Standard to ${context.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  if( !config )
  return null;
  if( !config.path )
  return null;
  if( !config.path.module || !config.path.module )
  return null;

  var writer = _.TemplateFileWriter
  ({
    // resolver : _.TemplateTreeResolver(),
    dst : context.junction.dirPath,
    srcTemplatePath : __dirname + '/template/Standard.js',
    name : context.module.about.name,
    onConfigGet : () => onConfigGet( context ),
    resolving : 0,
  });

  writer.form();

}

module.exports = onModule;

//

function onConfigGet( context )
{
  let fileProvider = context.will.fileProvider;
  let path = context.will.fileProvider.path;
  let result = Object.create( null );
  let name = context.module.about.name;
  let lowName = name.toLowerCase();
  let highName = name.toUpperCase();
  let shortName = _.strDesign( name );
  // let shortName = name;
  // if( /^w[A-Z]/.test( shortName ) )
  // shortName = shortName.substring( 1 );

  let config = fileProvider.configUserRead( _.censor.storageConfigPath );
  _.mapSupplementRecursive( result, config );

  result.package =
  {
    name,
    lowName,
    highName,
    shortName,
    description : context.module.about.description || '',
    version : context.module.about.version || '0.3.0',
  };

  return result;
}
