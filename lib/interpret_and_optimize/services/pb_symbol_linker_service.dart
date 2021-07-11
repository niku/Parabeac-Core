import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_instance.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_master_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_layout_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_visual_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_symbol_storage.dart';
import 'package:parabeac_core/interpret_and_optimize/services/pb_shared_aggregation_service.dart';
import 'package:path/path.dart';

class PBSymbolLinkerService {
  PBSymbolStorage _symbolStorage;
  PBSharedInterAggregationService _aggregationService;

  PBSymbolLinkerService() {
    _symbolStorage = PBSymbolStorage();
    _aggregationService = PBSharedInterAggregationService();
  }

// /Linking [PBSharedMasterNode] and [PBSharedInstanceIntermediateNode] together; linking its
// /parameter and values.
  Future<PBIntermediateNode> linkSymbols(PBIntermediateNode rootNode) async {
    if (rootNode == null) {
      return rootNode;
    }

    var stack = <PBIntermediateNode>[];
    PBIntermediateNode rootIntermediateNode;
    stack.add(rootNode);

    while (stack.isNotEmpty) {
      var currentNode = stack.removeLast();
      if (currentNode is PBLayoutIntermediateNode) {
        currentNode.children.forEach(stack.add);
      } else if (currentNode is PBVisualIntermediateNode &&
          currentNode.child != null) {
        stack.add(currentNode.child);
      }

      if (currentNode is PBSharedMasterNode) {
        await _symbolStorage.addSharedMasterNode(currentNode);
        _aggregationService.gatherSharedParameters(
            currentNode, currentNode.child);

        /// If this shared master is not the root node, we must swap this now for a instance node.
        /// For more info: https://www.notion.so/parabeac/Figma-Symbol-Instances-Parameters-4c1b11bbc1454f11a481574b4a5fc8bd
        if (currentNode != rootNode) {
          /// Swap current node with instance node.
          var instanceNode = PBSharedInstanceIntermediateNode(
              (currentNode as PBSharedMasterNode).originalRef,
              (currentNode as PBSharedMasterNode).SYMBOL_ID,
              currentContext: currentNode.currentContext,
              sharedParamValues: [/* Is this fine @Eddie / @IvanV */]);
          currentNode = instanceNode;
        }
      } else if (currentNode is PBSharedInstanceIntermediateNode) {
        await _symbolStorage.addSharedInstance(currentNode);
        _aggregationService.gatherSharedValues(currentNode);
      }

      rootIntermediateNode ??= currentNode;
    }
    return rootIntermediateNode;
  }
}
