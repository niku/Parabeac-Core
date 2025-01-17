import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:parabeac_core/generation/generators/middleware/state_management/bloc_middleware.dart';
import 'package:parabeac_core/generation/generators/pb_generation_manager.dart';
import 'package:parabeac_core/generation/generators/pb_generator.dart';
import 'package:parabeac_core/generation/generators/util/pb_generation_project_data.dart';
import 'package:parabeac_core/generation/generators/util/pb_generation_view_data.dart';
import 'package:parabeac_core/generation/generators/value_objects/file_structure_strategy/flutter_file_structure_strategy.dart';
import 'package:parabeac_core/generation/generators/value_objects/generation_configuration/bloc_generation_configuration.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_context.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_intermediate_node_tree.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_project.dart';
import 'package:test/test.dart';
import 'provider_test.dart';

class MockPBGenerationManager extends Mock implements PBGenerationManager {}

class MockPBIntermediateNode extends Mock implements PBIntermediateNode {}

class MockContext extends Mock implements PBContext {}

class MockProject extends Mock implements PBProject {}

class MockPBGenerationProjectData extends Mock
    implements PBGenerationProjectData {}

class MockPBGenerationViewData extends Mock implements PBGenerationViewData {}

class MockPBGenerator extends Mock implements PBGenerator {}

class MockConfig extends Mock implements BLoCGenerationConfiguration {}

class MockFileStrategy extends Mock implements FlutterFileStructureStrategy {}

void main() {
  group('Middlewares Tests', () {
    var mockConfig = MockConfig();
    var mockPBGenerationManager = MockPBGenerationManager();
    var bLoCMiddleware = BLoCMiddleware(mockPBGenerationManager, mockConfig);
    var node = MockPBIntermediateNode();
    var node2 = MockPBIntermediateNode();
    var mockContext = MockContext();
    var mockProject = MockProject();
    var mockPBGenerationProjectData = MockPBGenerationProjectData();
    var mockPBGenerationViewData = MockPBGenerationViewData();
    var mockPBGenerator = MockPBGenerator();
    var mockFileStructureStrategy = MockFileStrategy();
    var mockIntermediateAuxiliaryData = MockIntermediateAuxiliaryData();
    var mockDirectedStateGraph = MockDirectedStateGraph();
    var mockIntermediateState = MockIntermediateState();
    var mockIntermediateVariation = MockIntermediateVariation();
    var tree = PBIntermediateTree('tree');

    setUp(() async {
      /// Set up nodes
      when(node.name).thenReturn('someElement/blue');
      when(node.generator).thenReturn(mockPBGenerator);
      when(node.managerData).thenReturn(mockPBGenerationViewData);
      when(node.currentContext).thenReturn(mockContext);
      when(node.auxiliaryData).thenReturn(mockIntermediateAuxiliaryData);
      // 2
      when(node2.name).thenReturn('someElement/green');
      when(node2.generator).thenReturn(mockPBGenerator);
      when(node2.currentContext).thenReturn(mockContext);

      /// IntermediateAuxiliaryData
      when(mockIntermediateAuxiliaryData.stateGraph)
          .thenReturn(mockDirectedStateGraph);

      /// DirectedStateGraph
      when(mockDirectedStateGraph.states).thenReturn([mockIntermediateState]);

      /// IntermediateState
      when(mockIntermediateState.variation)
          .thenReturn(mockIntermediateVariation);

      /// IntermediateVariation
      when(mockIntermediateVariation.node).thenReturn(node2);

      /// Context
      when(mockContext.project).thenReturn(mockProject);
      when(mockContext.tree).thenReturn(tree);

      // Tree
      tree.rootNode = node;

      /// Project
      when(mockProject.genProjectData).thenReturn(mockPBGenerationProjectData);
      when(mockProject.forest).thenReturn([]);
      when(mockConfig.fileStructureStrategy)
          .thenReturn(mockFileStructureStrategy);

      /// PBGenerationManager
      when(mockPBGenerationManager.generate(node)).thenReturn('codeForBlue\n');
      when(mockPBGenerationManager.generate(node2))
          .thenReturn('codeForGreen\n');

      /// PBGenerationProjectData
      when(mockPBGenerationProjectData.addDependencies(any, any))
          .thenReturn('mockDependency');
    });

    test('BLoC Strategy Test', () async {
      await mockFileStructureStrategy.setUpDirectories();
      var tempNode = await bLoCMiddleware.applyMiddleware(tree);
      expect(tempNode, isNull);

      var verification =
          verify(mockFileStructureStrategy.commandCreated(captureAny));

      expect(verification.captured[0].fileName, contains('state'));
      expect(verification.captured[1].fileName, contains('event'));
      expect(verification.captured[2].fileName, contains('bloc'));
    });
  });
}
