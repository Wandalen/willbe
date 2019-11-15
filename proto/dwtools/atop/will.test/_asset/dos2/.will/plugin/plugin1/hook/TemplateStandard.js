
let _;
function onModule( it )
{
  let o = it.request.map;
  _ = it.tools;
  let logger = it.logger;

  if( !it.module.about )
  return;
  if( !it.module.about.name )
  return;

  if( o.verbosity )
  logger.log( `Applying template::Standard to ${it.junction.nameWithLocationGet()}` );

  if( o.dry )
  return;

  var writer = _.TemplateFileWriter
  ({
    resolver : _.TemplateTreeResolver(),
    dst : it.junction.dirPath,
    srcTemplatePath : __dirname + '/template/Standard.js',
    name : it.module.about.name,
    onConfigGet : () => onConfigGet( it ),
  });

  writer.form();

}

module.exports = onModule;

//

function onConfigGet( it )
{
  let result = Object.create( null );
  let name = it.module.about.name;
  let lowName = name.toLowerCase();
  let highName = name.toUpperCase();
  let shortName = name;
  if( /^w[A-Z]/.test( shortName ) )
  shortName = shortName.substring( 1 );

  let config = _.fileProvider.fileConfigUserRead();
  _.mapSupplementRecursive( result, config );

  result.package =
  {
    name : name,
    lowName : lowName,
    highName : highName,
    shortName : shortName,
    description : it.module.about.description || '',
    version : it.module.about.version || '0.3.0',
  };

  return result;
}
