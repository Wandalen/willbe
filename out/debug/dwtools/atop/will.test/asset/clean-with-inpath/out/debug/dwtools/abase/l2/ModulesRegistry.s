( function _ModulesRegistry_s_() {

'use strict';

let _global = _global_;
let _ = _global.wTools;
if( !Object.hasOwnProperty.call( _global, 'ModuleRegistry' ) )
_global.ModulesRegistry = Object.create( null );
let Self = _global.ModulesRegistry;

/**
 * @typedef {Object} ModulesRegistry - Map that contains info about modules, is uses by {@link wTools.include}.
 * @memberof wTools
 */

// --
// helper
// --

function includeAny( filePath, name )
{
  _.assert( arguments.length === 2 );
  return [ '../../' + filePath, filePath, name ];
}

// --
// include map
// --

// base / l3

// let wNameTools =
// {
//   includeAny : includeAny( 'abase/l3/NameTools.s', 'wNameTools' ),
//   isIncluded : function(){ return !!_global.wTools && !!_global.wTools.idWithInt; },
// }

let wEntityFundamentals =
{
  includeAny : includeAny( 'abase/l3/Entity.s', 'wentityfundamentals' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.entityVals; },
}

let wLooker =
{
  includeAny : includeAny( 'abase/l3/Looker.s', 'wlooker' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.look; },
}

let wPathFundamentals =
{
  includeAny : includeAny( 'abase/l3/Path.s', 'wpathfundamentals' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.path },
}

let wRoutineFundamentals =
{
  includeAny : includeAny( 'abase/l3/RoutineFundamentals.s', 'wroutinefundamentals' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.exec },
}

let wProto =
{
  includeAny : includeAny( 'abase/l3/Proto.s', 'wProto' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.mixinDelcare },
}

let wStringer =
{
  includeAny : includeAny( 'abase/l3/Stringer.s', 'wstringer' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Stringer; },
}

// base / l4

let wReplicator =
{
  includeAny : includeAny( 'abase/l4/Replicator.s', 'wreplicator' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.replicate; },
}

let wLookerExtra =
{
  includeAny : includeAny( 'abase/l4/LookerExtra.s', 'wlookerextra' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.entitySearch },
}

let wArraySorted =
{
  includeAny : includeAny( 'abase/l4/ArraySorted.s', 'warraysorted' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.sorted },
}

let wArraySparse =
{
  includeAny : includeAny( 'abase/l4/ArraySparse.s', 'warraysparse' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.sparse },
}

let wExternalFundamentals =
{
  includeAny : includeAny( 'abase/l4/External.s', 'wexternalfundamentals' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.shell },
}

let wUriFundamentals =
{
  includeAny : includeAny( 'abase/l4/Uri.s', 'wurifundamentals' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.uri },
}

let wTraverser =
{
  includeAny : includeAny( 'abase/l4/Traverser.s', 'wtraverser' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools._traverse },
}

let wRoutineTransform =
{
  includeAny : includeAny( 'abase/l4/RoutineTransform.s', 'wroutinetransform' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.routineNew },
}

// base / l5

let wSelector =
{
  includeAny : includeAny( 'abase/l5/Selector.s', 'wselector' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.select; },
}

let wWebUriFundamentals =
{
  includeAny : includeAny( 'abase/l5/WebUri.s', 'wweburifundamentals' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.weburi },
}

let wCloner =
{
  includeAny : includeAny( 'abase/l5/Cloner.s', 'wcloner' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools._clone },
}

let wStringsExtra =
{
  includeAny : includeAny( 'abase/l5/StringTools.s', 'wstringsextra' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.strSorterParse; },
}

// base / l6

let wComparator =
{
  includeAny : includeAny( 'abase/l6/LookerComparator.s', 'wcomparator' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.entityIdentical },
}

let wSelectorExtra =
{
  includeAny : includeAny( 'abase/l6/SelectorExtra.s', 'wselectorextra' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.entityProbe; },
}

// base / l7_mixin

let wConsequizer =
{
  includeAny : includeAny( 'abase/l7_mixin/Consequizer.', 'wconsequizer' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Consequizer; },
}

let wCopyable =
{
  includeAny : includeAny( 'abase/l7_mixin/Copyable.s', 'wCopyable' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Copyable; },
}

let wInstancing =
{
  includeAny : includeAny( 'abase/l7_mixin/Instancing.s', 'winstancing' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Instancing; },
}

let wEventHandler =
{
  includeAny : includeAny( 'abase/l7_mixin/EventHandler.s', 'wEventHandler' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.EventHandler; },
}

let wFieldsStack =
{
  includeAny : includeAny( 'abase/l7_mixin/FieldsStack.s', 'wfieldsstack' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.FieldsStack; },
}

// base / l8

let wProcedure =
{
  includeAny : includeAny( 'abase/l8/Procedure.s', 'wprocedure' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.procedure },
}

let wGdfStrategy =
{
  includeAny : includeAny( 'abase/l8/GdfConverter.s', 'wgdfstrategy' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Gdf },
}

let wBaseEncoder =
{
  includeAny : includeAny( 'abase/l4/Encoder.s', 'wbaseencoder' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.encode },
}

// base / l9

let wLogger =
{
  includeAny : includeAny( 'abase/l9/printer/top/Logger.s', 'wLogger' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Logger; },
}

let wPrinterToFile =
{
  includeAny : includeAny( 'abase/l9/printer/top/ToFile.ss', 'wloggertofile' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.PrinterToFile; },
}

let wPrinterToJs =
{
  includeAny : includeAny( 'abase/l9/printer/top/ToJstructure.s', 'wloggertojs' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.PrinterToJs; },
}

let wConsequence =
{
  includeAny : includeAny( 'abase/l9/consequence/Consequence.s', 'wConsequence' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Consequence; },
}

// abase_dom

let wDomBaseLayer1 =
{
  includeAny : includeAny( 'abase_dom/l1/Common.js', 'wdombaselayer1' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools._domBaselayer1Loaded },
}

let wDomBaseLayer3 =
{
  includeAny : includeAny( 'abase_dom/l3/Common.js', 'wdombaselayer3' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools._domBaselayer3Loaded },
}

let wDomBaseLayer5 =
{
  includeAny : includeAny( 'abase_dom/l5/Common.js', 'wdombasel5' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools._domBasel5Loaded },
}

// amid

let wRegexpObject =
{
  includeAny : includeAny( 'amid/bclass/RegexpObject.s', 'wRegexpObject' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.RegexpObject; },
}

let wColor =
{
  includeAny : includeAny( 'amid/color/Color.s', 'wColor' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.ColorMap },
}

let wColor256 =
{
  includeAny : includeAny( 'amid/color/Color256.s', 'wColor256' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.ColorMap && Object.keys( _global.wTools.ColorMap ).length > 100 },
}

let wChangeTransactor =
{
  includeAny : includeAny( 'amid/changes/ChangeTransactor.s', 'wChangeTransactor' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.ChangeTransactor },
}

let wVocabulary =
{
  includeAny : includeAny( 'amid/bclass/Vocabulary.s', 'wvocabulary' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Vocabulary },
}

let wCommandsAggregator =
{
  includeAny : includeAny( 'amid/l7/Commands/CommandsAggregator.s', 'wcommandsaggregator' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.CommandsAggregator },
}

let wCommandsConfig =
{
  includeAny : includeAny( 'amid/l7/commands/mixin/CommandsConfig.s', 'wcommandsconfig' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.CommandsConfig },
}

let wFiles =
{
  includeAny : includeAny( 'amid/files/UseTop.s', 'wFiles' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.fileProvider },
}

let wFilesArchive =
{
  includeAny : includeAny( 'amid/files/IncludeArchive.s', 'wfilesarchive' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.FilesArchive },
}

let wFilesEncoders =
{
  includeAny : includeAny( 'amid/files/l1/EncodersExtended.s', 'wfilesencoders' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.FileReadEncoders && !!_global.wTools.FileReadEncoders.yml },
}

let wFilesSvn =
{
  includeAny : includeAny( 'amid/files/fprovider/pSvn.ss', 'wFilesSvn' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.fileProvider.Svn },
}

let wTimeMarker =
{
  includeAny : includeAny( 'amid/amixin/TimeMarker.s', 'wtimemarker' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.TimeMarker },
}

let wVerbal =
{
  includeAny : includeAny( 'amid/amixin/Verbal.s', 'wverbal' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Verbal },
}

let wStateStorage =
{
  includeAny : includeAny( 'amid/amixin/aStateStorage.s', 'wstatestorage' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.StateStorage },
}

let wStateSession =
{
  includeAny : includeAny( 'amid/amixin/StateSession.s', 'wstatesession' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.StateSession },
}

let wStager =
{
  includeAny : includeAny( 'amid/l3/stager/Stager.s', 'wstager' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Stager },
}

let wFileExecutor =
{
  includeAny : includeAny( 'amid/l7/executor/FileExecutor.s', 'wFileExecutor' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.wFileExecutor },
}

let wFileExecutorHtmlFormatters =
{
  includeAny : includeAny( 'amid/l7/executor/HtmlFormatters.s', 'wFileExecutorHtmlFormatters' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.FileExecutorHtmlFormatters },
}

let wPathTranslator =
{
  includeAny : includeAny( 'amid/l5_mapper/PathTranslator.s', 'wpathtranslator' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.PathTranslator },
}

let wNameMapper =
{
  includeAny : includeAny( 'amid/l5_mapper/NameMapper.s', 'wnamemapper' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.NameMapper },
}

let wTemplateTreeResolver =
{
  includeAny : includeAny( 'amid/l5_mapper/TemplateTreeAresolver.s', 'wtemplatetreeresolver' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.TemplateTreeResolver },
}

let wTemplateTreeEnvironment =
{
  includeAny : includeAny( 'amid/l5_mapper/TemplateTreeEnvironment.s', 'wtemplatetreeenvironment' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.TemplateTreeEnvironment },
}

let wTemplateFileWriter =
{
  includeAny : includeAny( 'amid/l5_mapper/TemplateFileWriter.s', 'wtemplatefilewriter' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.TemplateFileWriter },
}

let wGraph =
{
  includeAny : includeAny( 'amid/agraph/UseTop.s', 'wgraphbase' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.graph },
}

let wGraphLive =
{
  includeAny : includeAny( 'amid/agraph/UseLive.s', 'wgraphlive' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.LiveSystem },
}

let wSchema =
{
  includeAny : includeAny( 'amid/schema/Top.s', 'wSchema' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.schema },
}

let wScriptLauncher =
{
  includeAny : includeAny( 'amid/launcher/ScriptLauncher.s', 'wscriptlauncher' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.ScriptLauncher },
}

let wExchangePoint =
{
  includeAny : includeAny( 'amid/exchangePoint/ExchangePoint.s', 'wExchangePoint' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.ExchangePoint },
}

let wCommunicator =
{
  includeAny : includeAny( 'amid/communicator/Communicator.s', 'wCommunicator' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Communicator },
}

let wIncubator =
{
  includeAny : includeAny( 'amid/worker/Incubator.s', 'wIncubator' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Incubator },
}

let wCollectionOfInstances =
{
  includeAny : includeAny( 'amid/container/CollectionOfInstances.s', 'wcollectionofinstances' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.CollectionOfInstances },
}

let wStarterMaker =
{
  includeAny : includeAny( 'amid/starter/StarterMaker.s', 'wstartermaker' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.StarterMaker },
}

// amid / l5

let wBitmask =
{
  includeAny : includeAny( 'amid/l5_mapper/Bitmask.s', 'wBitmask' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Bitmask },
}

// math

let wMathScalar =
{
  includeAny : includeAny( 'amath/l1/Scalar.s', 'wmathscalar' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.clamp },
}

let wMathVector =
{
  includeAny : includeAny( 'amath/l3_vector/Main.s', 'wmathvector' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.vector },
}

let wMathSpace =
{
  includeAny : includeAny( 'amath/l5_space/Main.s', 'wmathspace' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Space },
}

let wMathConcepts =
{
  includeAny : includeAny( 'amath/l8/Concepts.ss', 'wmathconcepts' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.box },
}

// top

let wTesting =
{
  includeAny : includeAny( 'atop/tester/MainTop.s', 'wTesting' ),
  isIncluded : function(){ return _realGlobal_.wTester && _realGlobal_.wTester._isReal_; },
}

let wTranspilationStrategy =
{
  includeAny : includeAny( 'atop/transpilationStrategy/MainBase.s', 'wtranspilationstrategy' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.TranspilationStrategy },
}

let wFilesOperationsDirector =
{
  includeAny : includeAny( 'atop/files/OperationsDirector.s', 'wfilesoperationsdirector' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.FilesOperationsDirector },
}

let wFilesLinker =
{
  includeAny : includeAny( 'atop/files/Linker.s', 'wfileslinker' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.FilesLinker },
}

let wBaker =
{
  includeAny : includeAny( 'atop/baker/Baker.s', 'wBaker' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Baker },
}

let wBakerWithFileExecutor =
{
  includeAny : includeAny( 'atop/baker/BakerWithFileExecutor.s', 'wBakerWithFileExecutor' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.wBakerWithFileExecutor },
}

let wMaker =
{
  includeAny : includeAny( 'atop/maker/Maker.s', 'wMaker' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.Maker },
}

let wServlet =
{
  includeAny : includeAny( 'atop/servlet/Servlet.ss', 'wServlet' ),
  isIncluded : function(){ return !!_global.wTools && !!_global.wTools.servlet },
}

// --
// declare
// --

let Extend =
{

  // base / l3

  wLooker,
  wPathFundamentals,
  wRoutineFundamentals,
  wProto,

  // base / l4

  wReplicator,
  wLookerExtra,
  wArraySorted,
  wArraySparse,
  wExternalFundamentals,
  wUriFundamentals,
  wTraverser,
  wStringer,
  wRoutineTransform,

  // base / l5

  wSelector,
  wWebUriFundamentals,
  wCloner,
  wStringsExtra,

  // base / l6

  wComparator,
  wSelectorExtra,

  // base / l7_mixin

  wConsequizer,
  wCopyable,
  wInstancing,
  wEventHandler,
  wFieldsStack,

  // base / l8

  wProcedure,
  wGdfStrategy,
  wBaseEncoder,

  // base / l9

  wLogger,
  wPrinterToFile,
  wPrinterToJs,
  wConsequence,

  // base_dom

  wDomBaseLayer1,
  wDomBaseLayer3,
  wDomBaseLayer5,

  // mid

  wRegexpObject,
  wColor,
  wColor256,
  wChangeTransactor,
  wVocabulary,
  wCommandsAggregator,
  wCommandsConfig,
  wFiles,
  wFilesArchive,
  wFilesEncoders,
  wFilesSvn,
  wTimeMarker,
  wVerbal,
  wStateStorage,
  wStateSession,
  wStager,
  wFileExecutor,
  wFileExecutorHtmlFormatters,

  wPathTranslator,
  wNameMapper,
  wTemplateTreeResolver,
  wTemplateTreeEnvironment,
  wTemplateFileWriter,

  wGraph,
  wGraphLive,
  wSchema,
  wScriptLauncher,
  wExchangePoint,
  wCommunicator,
  wIncubator,
  wCollectionOfInstances,
  wStarterMaker,

  // amid / l5

  wBitmask,

  // math

  wMathScalar,
  wMathVector,
  wMathSpace,
  wMathConcepts,

  // top

  wTesting,
  wTranspilationStrategy,
  wFilesOperationsDirector,
  wFilesLinker,
  wBaker,
  wBakerWithFileExecutor,
  wMaker,
  wServlet,

}

Object.assign( Self, Extend );

// --
// export
// --

// if( typeof module !== 'undefined' )
// if( _global_.WTOOLS_PRIVATE )
// { /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
