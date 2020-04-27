( function _ModulesRegistry_s_() {

'use strict';

let _global = _global_;
let _ = _global.wModuleForTesting1 = _global.wModuleForTesting1 || Object.create( null );
_.module = _.module || Object.create( null );
_.module.lateModules = _.module.lateModules || Object.create( null );
let Self = _.module.lateModules;

/*
  Temporary solution.
*/

/**
 * @typedef {Object} ModulesRegistry - Map that contains info about modules, is uses by {@link wModuleForTesting1.include}.
 * @namespace ModuleForTesting1
 */

// --
// helper
// --

function sourcePath( filePath, name )
{
  _.assert( arguments.length === 2 );
  return [ '../../' + filePath, filePath, name ];
}

// --
// include map
// --

// base / l1

let wModuleForTesting1 =
{
  sourcePath : sourcePath( 'abase/Layer1.s', 'wModuleForTesting1' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.longHas },
}

// base / l2

let wBlueprint =
{
  sourcePath : sourcePath( 'abase/l2_blueprint/Include.s', 'wblueprint' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.blueprint },
}

let wEntityBasic =
{
  sourcePath : sourcePath( 'abase/l2/EntityBasic.s', 'wentitybasic' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.entityVals; },
}

let wLooker =
{
  sourcePath : sourcePath( 'abase/l2/Looker.s', 'wlooker' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.look; },
}

let wModuleForTesting2 =
{
  sourcePath : sourcePath( 'abase/l3/PathsBasic.s', 'wpathbasic' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.path && !!_global.wModuleForTesting1.path.s },
}

let wRoutineBasic =
{
  sourcePath : sourcePath( 'abase/l2/RoutineBasic.s', 'wroutinebasic' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.exec },
}

// base / l3

let wModuleForTesting12 =
{
  sourcePath : sourcePath( 'abase/l3_proto/Include.s', 'wModuleForTesting12' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.mixinDelcare },
}

let wStringer =
{
  sourcePath : sourcePath( 'abase/l3/Stringer.s', 'wstringer' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Stringer; },
}

// base / l4

let wReplicator =
{
  sourcePath : sourcePath( 'abase/l4/Replicator.s', 'wreplicator' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.replicate; },
}

let wLookerExtra =
{
  sourcePath : sourcePath( 'abase/l4/LookerExtra.s', 'wlookerextra' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.entitySearch },
}

let wArraySorted =
{
  sourcePath : sourcePath( 'abase/l4/ArraySorted.s', 'warraysorted' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.sorted && !!_global.wModuleForTesting1.sorted.lookUp },
}

let wArraySparse =
{
  sourcePath : sourcePath( 'abase/l4/ArraySparse.s', 'warraysparse' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.sparse },
}

let wAppBasic =
{
  sourcePath : sourcePath( 'abase/l4_process/Basic.s', 'wappbasic' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.process && !!_global.wModuleForTesting1.process.start },
}

let wModuleForTesting2b =
{
  sourcePath : sourcePath( 'abase/l5/Uris.s', 'wuribasic' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.uri && !!_global.wModuleForTesting1.uri.s && !!_global.wModuleForTesting1.uri.s.parse },
}

let wTraverser =
{
  sourcePath : sourcePath( 'abase/l4/Traverser.s', 'wtraverser' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.traverse },
}

let wBaseEncoder =
{
  sourcePath : sourcePath( 'abase/l4/Encoder.s', 'wbaseencoder' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.encode },
}

// base / l5

let wModuleForTesting1 =
{
  sourcePath : sourcePath( 'abase/l5/ModuleForTesting1.s', 'wpathtools' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.path && !!_global.wModuleForTesting1.path.mapExtend },
}

let wSelector =
{
  sourcePath : sourcePath( 'abase/l5/Selector.s', 'wselector' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.select; },
}

let wWebModuleForTesting2b =
{
  sourcePath : sourcePath( 'abase/l5/WebUri.s', 'wweburibasic' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.weburi },
}

let wCloner =
{
  sourcePath : sourcePath( 'abase/l5/Cloner.s', 'wcloner' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1._clone },
}

let wStringsExtra =
{
  sourcePath : sourcePath( 'abase/l5/StringModuleForTesting1.s', 'wstringsextra' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.strSorterParse; },
}

let wProcessWatcher =
{
  sourcePath : sourcePath( 'abase/l5/ProcessWatcher.s', 'wprocesswatcher' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.process && !!_global.wModuleForTesting1.process.watchMaking; },
}

// base / l6

let wResolver =
{
  sourcePath : sourcePath( 'abase/l6/Resolver.s', 'wresolver' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.resolver; },
}

let wEqualer =
{
  sourcePath : sourcePath( 'abase/l6/Equaler.s', 'wequaler' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1._equalIt },
}

let wSelectorExtra =
{
  sourcePath : sourcePath( 'abase/l6/SelectorExtra.s', 'wselectorextra' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.entityProbe; },
}

// base / l7

let wResolverExtra =
{
  sourcePath : sourcePath( 'abase/l7/ResolverExtra.s', 'wresolverextra' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.resolver && !!_global.wModuleForTesting1.resolveQualified; },
}

// base / l7_mixin

let wConsequizer =
{
  sourcePath : sourcePath( 'abase/l7_mixin/Consequizer.', 'wconsequizer' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Consequizer; },
}

let wCopyable =
{
  sourcePath : sourcePath( 'abase/l7_mixin/Copyable.s', 'wCopyable' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Copyable; },
}

let wInstancing =
{
  sourcePath : sourcePath( 'abase/l7_mixin/Instancing.s', 'winstancing' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Instancing; },
}

let wEventHandler =
{
  sourcePath : sourcePath( 'abase/l7_mixin/EventHandler.s', 'wEventHandler' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.EventHandler; },
}

let wFieldsStack =
{
  sourcePath : sourcePath( 'abase/l7_mixin/FieldsStack.s', 'wfieldsstack' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.FieldsStack; },
}

// base / l8

let wModuleForTesting12ab =
{
  sourcePath : sourcePath( 'abase/l8_procedure/Include.s', 'wprocedure' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.procedure },
}

let wGdfStrategy =
{
  sourcePath : sourcePath( 'abase/l8_gdf/GdfConverter.s', 'wgdfstrategy' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Gdf },
}

// base / l9

let wLogger =
{
  sourcePath : sourcePath( 'abase/l9/printer/top/Logger.s', 'wLogger' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Logger; },
}

let wPrinterToFile =
{
  sourcePath : sourcePath( 'abase/l9/printer/top/ToFile.ss', 'wloggertofile' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.PrinterToFile; },
}

let wPrinterToJs =
{
  sourcePath : sourcePath( 'abase/l9/printer/top/ToJstructure.s', 'wloggertojs' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.PrinterToJs; },
}

let wConsequence =
{
  sourcePath : sourcePath( 'abase/l9/consequence/Consequence.s', 'wConsequence' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Consequence; },
}

// abase_dom

let wDomBaseLayer1 =
{
  sourcePath : sourcePath( 'abase_dom/l1/Common.js', 'wdombaselayer1' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1._domBaselayer1Loaded },
}

let wDomBaseLayer3 =
{
  sourcePath : sourcePath( 'abase_dom/l3/Common.js', 'wdombaselayer3' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1._domBaselayer3Loaded },
}

let wDomBaseLayer5 =
{
  sourcePath : sourcePath( 'abase_dom/l5/Common.js', 'wdombasel5' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1._domBasel5Loaded },
}

// amid

// amid / l1

let wGraphBasic =
{
  sourcePath : sourcePath( 'amid/l1/graphBasic/IncludeTop.s', 'wgraphbasic' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.graph && !!_global.wModuleForTesting1.graph.AbstractGraphSystem },
}

let wGraphModuleForTesting1 =
{
  sourcePath : sourcePath( 'amid/l1/graphModuleForTesting1/IncludeTop.s', 'wgraphtools' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.graph && !!_global.wModuleForTesting1.graph.GraphSystem },
}

// let wGraphLive =
// {
//   sourcePath : sourcePath( 'amid/l1/graphModuleForTesting1/IncludeLive', 'wgraphlive' ),
//   isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.LiveSystem },
// }

let wSchema =
{
  sourcePath : sourcePath( 'amid/l1/schema/IncludeMid.s', 'wSchema' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.schema },
}

let wStxt =
{
  sourcePath : sourcePath( 'amid/l1/stxt/Include.s', 'wstxtparser' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.stxt && !!_global.wModuleForTesting1.stxt.Parser },
}

let wLoggerSocket =
{
  sourcePath : sourcePath( 'amid/l1_logger/Socket.s', 'wloggersocket' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.LoggerSocketReceiver },
}

// mid / l3

let wStager =
{
  sourcePath : sourcePath( 'amid/l3/stager/Stager.s', 'wstager' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Stager },
}

let wIntrospector =
{
  sourcePath : sourcePath( 'amid/l3/introspector/module/Full.s', 'wintrospector' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.introspector && !!_global.wModuleForTesting1.thisFile },
}

let wPersistent =
{
  sourcePath : sourcePath( 'amid/l3/persistent/Include.s', 'wpersistent' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.persistent },
}

let wRemote =
{
  sourcePath : sourcePath( 'amid/l3/remote/Include.s', 'wremote' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.remote },
}

let wGitModuleForTesting1 =
{
  sourcePath : sourcePath( 'amid/l3/git/IncludeMid.s', 'wgittools' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.git },
}

let wNpmModuleForTesting1 =
{
  sourcePath : sourcePath( 'amid/l3/npm/IncludeMid.s', 'wnpmtools' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.npm },
}

let wYamlModuleForTesting1 =
{
  sourcePath : sourcePath( 'amid/l3/yaml/IncludeMid.s', 'wyamltools' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.yaml },
}

//

let wRegexpObject =
{
  sourcePath : sourcePath( 'amid/bclass/RegexpObject.s', 'wRegexpObject' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.RegexpObject; },
}

let wModuleForTesting1a =
{
  sourcePath : sourcePath( 'amid/color/ModuleForTesting1a.s', 'wModuleForTesting1a' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.color && !!_global.wModuleForTesting1.color.ModuleForTesting1aMap },
}

let wModuleForTesting1a256 =
{
  sourcePath : sourcePath( 'amid/color/ModuleForTesting1a256.s', 'wModuleForTesting1a256' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.color && !!_global.wModuleForTesting1.color.ModuleForTesting1aMap && Object.keys( _global.wModuleForTesting1.color.ModuleForTesting1aMap ).length > 100 },
}

let wChangeTransactor =
{
  sourcePath : sourcePath( 'amid/changes/ChangeTransactor.s', 'wChangeTransactor' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.ChangeTransactor },
}

let wVocabulary =
{
  sourcePath : sourcePath( 'amid/bclass/Vocabulary.s', 'wvocabulary' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Vocabulary },
}

let wCommandsAggregator =
{
  sourcePath : sourcePath( 'amid/l7/Commands/CommandsAggregator.s', 'wcommandsaggregator' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.CommandsAggregator },
}

let wCommandsConfig =
{
  sourcePath : sourcePath( 'amid/l7/commands/mixin/CommandsConfig.s', 'wcommandsconfig' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.CommandsConfig },
}

let wFiles =
{
  sourcePath : sourcePath( 'amid/files/UseTop.s', 'wFiles' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.fileProvider },
}

let wFilesArchive =
{
  sourcePath : sourcePath( 'amid/files/IncludeArchive.s', 'wfilesarchive' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.FilesArchive },
}

let wFilesEncoders =
{
  sourcePath : sourcePath( 'amid/files/l1/EncodersExtended.s', 'wfilesencoders' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.FileReadEncoders && !!_global.wModuleForTesting1.FileReadEncoders.yml },
}

let wFilesSvn =
{
  sourcePath : sourcePath( 'amid/files/fprovider/pSvn.ss', 'wFilesSvn' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.fileProvider.Svn },
}

let wFileExecutor =
{
  sourcePath : sourcePath( 'amid/l7/executor/FileExecutor.s', 'wFileExecutor' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.wFileExecutor },
}

let wFileExecutorHtmlFormatters =
{
  sourcePath : sourcePath( 'amid/l7/executor/HtmlFormatters.s', 'wFileExecutorHtmlFormatters' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.FileExecutorHtmlFormatters },
}

let wPathTranslator =
{
  sourcePath : sourcePath( 'amid/l5_mapper/PathTranslator.s', 'wpathtranslator' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.PathTranslator },
}

let wTimeMarker =
{
  sourcePath : sourcePath( 'amid/amixin/TimeMarker.s', 'wtimemarker' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.TimeMarker },
}

let wVerbal =
{
  sourcePath : sourcePath( 'amid/amixin/Verbal.s', 'wverbal' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Verbal },
}

let wStateStorage =
{
  sourcePath : sourcePath( 'amid/amixin/aStateStorage.s', 'wstatestorage' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.StateStorage },
}

let wStateSession =
{
  sourcePath : sourcePath( 'amid/amixin/StateSession.s', 'wstatesession' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.StateSession },
}

let wNameMapper =
{
  sourcePath : sourcePath( 'amid/l5_mapper/NameMapper.s', 'wnamemapper' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.NameMapper },
}

let wTemplateTreeResolver =
{
  sourcePath : sourcePath( 'amid/l5_mapper/TemplateTreeAresolver.s', 'wtemplatetreeresolver' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.TemplateTreeResolver },
}

let wTemplateTreeResolver2 =
{
  sourcePath : sourcePath( 'amid/l5_mapper/TemplateTreeResolver2.s', 'wtemplatetreeresolver2' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.TemplateTreeResolver2 },
}

let wTemplateTreeEnvironment =
{
  sourcePath : sourcePath( 'amid/l5_mapper/TemplateTreeEnvironment.s', 'wtemplatetreeenvironment' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.TemplateTreeEnvironment },
}

let wTemplateFileWriter =
{
  sourcePath : sourcePath( 'amid/l5_mapper/TemplateFileWriter.s', 'wtemplatefilewriter' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.TemplateFileWriter },
}

let wScriptLauncher =
{
  sourcePath : sourcePath( 'amid/launcher/ScriptLauncher.s', 'wscriptlauncher' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.ScriptLauncher },
}

let wExchangePoint =
{
  sourcePath : sourcePath( 'amid/exchangePoint/ExchangePoint.s', 'wExchangePoint' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.ExchangePoint },
}

let wCommunicator =
{
  sourcePath : sourcePath( 'amid/communicator/Communicator.s', 'wCommunicator' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Communicator },
}

let wIncubator =
{
  sourcePath : sourcePath( 'amid/worker/Incubator.s', 'wIncubator' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Incubator },
}

let wCollectionOfInstances =
{
  sourcePath : sourcePath( 'amid/container/CollectionOfInstances.s', 'wcollectionofinstances' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.CollectionOfInstances },
}

// mid

let wServletModuleForTesting1 =
{
  sourcePath : sourcePath( 'amid/servlet/ServletModuleForTesting1.ss', 'wservlettools' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.servlet },
}

// mid / l5

let wBitmask =
{
  sourcePath : sourcePath( 'amid/l5_mapper/Bitmask.s', 'wBitmask' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Bitmask },
}

// math

let wMathScalar =
{
  sourcePath : sourcePath( 'amath/l1/Scalar.s', 'wmathscalar' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.math && !!_global.wModuleForTesting1.math.clamp },
}

let wMathVector =
{
  sourcePath : sourcePath( 'amath/l3_vector/Include.s', 'wmathvector' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.avector && !!_global.wModuleForTesting1.avector.abs },
}

let wMathMatrix =
{
  sourcePath : sourcePath( 'amath/l5_matrix/module/full/Include.s', 'wmathmatrix' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Space },
}

let wMathGeometric =
{
  sourcePath : sourcePath( 'amath/l6/Geometric.s', 'wmathgeometric' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.math.d2TriPointInside },
}

let wMathConcepts =
{
  sourcePath : sourcePath( 'amath/l8/Concepts.s', 'wmathconcepts' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.box },
}

// top

let willbe =
{
  sourcePath : sourcePath( 'atop/will/MainTop.s', 'willbe' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Will },
}

let wStarter =
{
  sourcePath : sourcePath( 'atop/starter/Main.s', 'wstarter' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.StarterMaker },
}

let wTesting =
{
  sourcePath : sourcePath( 'atop/tester/Main.s', 'wTesting' ),
  isIncluded : function(){ return _realGlobal_.wTester && _realGlobal_.wTester._isReal_; },
}

let wTranspilationStrategy =
{
  sourcePath : sourcePath( 'atop/transpilationStrategy/MainBase.s', 'wtranspilationstrategy' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.TranspilationStrategy },
}

let wFilesOperationsDirector =
{
  sourcePath : sourcePath( 'atop/files/OperationsDirector.s', 'wfilesoperationsdirector' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.FilesOperationsDirector },
}

let wFilesLinker =
{
  sourcePath : sourcePath( 'atop/files/Linker.s', 'wfileslinker' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.FilesLinker },
}

let wBaker =
{
  sourcePath : sourcePath( 'atop/baker/Baker.s', 'wBaker' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Baker },
}

let wBakerWithFileExecutor =
{
  sourcePath : sourcePath( 'atop/baker/BakerWithFileExecutor.s', 'wBakerWithFileExecutor' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.wBakerWithFileExecutor },
}

let wMaker =
{
  sourcePath : sourcePath( 'atop/maker/Maker.s', 'wMaker' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.Maker },
}

let wPuppet =
{
  sourcePath : sourcePath( 'atop/puppet/Main.s', 'wpuppet' ),
  isIncluded : function(){ return !!_global.wModuleForTesting1 && !!_global.wModuleForTesting1.puppet },
}

// --
// declare
// --

let Modules =
{

  // base / l1

  wModuleForTesting1,

  // base / l2

  wBlueprint,
  wEntityBasic,
  wLooker,
  wModuleForTesting2,
  wRoutineBasic,

  // base / l3

  wModuleForTesting12,
  wStringer,

  // base / l4

  wReplicator,
  wLookerExtra,
  wArraySorted,
  wArraySparse,
  wAppBasic,
  wModuleForTesting2b,
  wTraverser,
  wBaseEncoder,

  // base / l5

  wModuleForTesting1,
  wSelector,
  wWebModuleForTesting2b,
  wCloner,
  wStringsExtra,
  wProcessWatcher,

  // base / l6

  wResolver,
  wEqualer,
  wSelectorExtra,

  // base / l7

  wResolverExtra,

  // base / l7_mixin

  wConsequizer,
  wCopyable,
  wInstancing,
  wEventHandler,
  wFieldsStack,

  // base / l8

  wModuleForTesting12ab,
  wGdfStrategy,

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

  // mid / l1

  wGraphBasic,
  wGraphModuleForTesting1,
  wSchema,
  wStxt,

  wLoggerSocket,

  // mid / l3

  wStager,
  wIntrospector,
  wPersistent,
  wRemote,
  wGitModuleForTesting1,
  wNpmModuleForTesting1,
  wYamlModuleForTesting1,

  //

  wRegexpObject,
  wModuleForTesting1a,
  wModuleForTesting1a256,
  wChangeTransactor,
  wVocabulary,
  wCommandsAggregator,
  wCommandsConfig,

  wFiles,
  wFilesArchive,
  wFilesEncoders,
  wFilesSvn,
  wFileExecutor,
  wFileExecutorHtmlFormatters,
  wPathTranslator,

  wTimeMarker,
  wVerbal,
  wStateStorage,
  wStateSession,

  wNameMapper,
  wTemplateTreeResolver,
  wTemplateTreeResolver2,
  wTemplateTreeEnvironment,
  wTemplateFileWriter,

  wScriptLauncher,
  wExchangePoint,
  wCommunicator,
  wIncubator,
  wCollectionOfInstances,

  // amid / l5

  wServletModuleForTesting1,
  wBitmask,

  // math

  wMathScalar,
  wMathVector,
  wMathMatrix,
  wMathGeometric,
  wMathConcepts,

  // top

  willbe,
  wStarter,
  wTesting,
  wTranspilationStrategy,
  wFilesOperationsDirector,
  wFilesLinker,
  wBaker,
  wBakerWithFileExecutor,
  wMaker,
  wPuppet,

}

Object.assign( _.module.lateModules, Modules );
if( _.module.declareAll )
_.module.declareAll( _.module.lateModules );

/*
xxx : remove isIncluded
*/

// _.mapSupplement( _global.ModulesRegistry, Modules );
// if( _.module )
// _.module.registerKnown( _global.ModulesRegistry );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();

/* xxx : rename
- wequaler -> wequaler
- wpathbasic -> wpathbasic
- wuribasic -> wuribasic
- wappbasic -> wappbasic
- wentitybasic -> wentitybasic
- wweburibasic -> wweburibasic
- wroutinebasic -> wroutinebasic
- wdombasic -> wdombasic

- wEqualer -> wEqualer
- wModuleForTesting2 -> wModuleForTesting2
- wModuleForTesting2b -> wModuleForTesting2b
- wAppBasic -> wProcessBasic
- wEntityBasic -> wEntityBasic
- wWebModuleForTesting2b -> wWebModuleForTesting2b
- wRoutineBasic -> wRoutineBasic
- wDomBasic -> wDomBasic
*/
