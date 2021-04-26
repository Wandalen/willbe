
function onModule( context )
{
  let o = context.request.map;
  let _ = context.tools;
  let module = context.junction.module;

  _.routine.options( onModule, o );

  o.verbosity = o.v !== undefined && o.v !== null ? o.v : o.verbosity;

  let commonPath = module.commonPath + _.strCommonLeft( ... _.paths.name( module.willfilesPath ) );

  module.willfileExtendWillfile
  ({
    request : `${ commonPath } was.package.json`,
    format : 'willfile',
    onSection : _.mapExtend,
    ... _.mapOnly_( null, o, module.willfileExtendWillfile.defaults ),
  })
}

onModule.defaults =
{
  submodulesDisabling : 0,
  verbosity : 3,
  v : null,
}

module.exports = onModule;
