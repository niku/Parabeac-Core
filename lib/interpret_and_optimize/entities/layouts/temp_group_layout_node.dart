import 'dart:math';

import 'package:parabeac_core/generation/prototyping/pb_prototype_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/interfaces/pb_inherited_intermediate.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_constraints.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_layout_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pbdl_constraints.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/align_strategy.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/abstract_intermediate_node_factory.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_context.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:parabeac_core/interpret_and_optimize/state_management/intermediate_auxillary_data.dart';

part 'temp_group_layout_node.g.dart';

@JsonSerializable(ignoreUnannotated: true, explicitToJson: true)

/// A temporary node that must be removed
class TempGroupLayoutNode extends PBLayoutIntermediateNode
    implements PBInheritedIntermediate, IntermediateNodeFactory {
  @override
  @JsonKey(
      fromJson: PrototypeNode.prototypeNodeFromJson, name: 'prototypeNodeUUID')
  PrototypeNode prototypeNode;

  @override
  @JsonKey()
  String type = 'group';

  @override
  Map<String, dynamic> originalRef;

  TempGroupLayoutNode(
    String UUID,
    Rectangle frame, {
    this.originalRef,
    PBContext currentContext,
    String name,
    this.prototypeNode,
  }) : super(UUID, frame, [], [], currentContext, name);

  @override
  void addChild(node) {
    addChildToLayout(node);
  }

  @override
  bool satisfyRules(
      PBIntermediateNode currentNode, PBIntermediateNode nextNode) {
    assert(false, 'Attempted to satisfyRules for class type [$runtimeType]');
    return null;
  }

  @override
  PBLayoutIntermediateNode generateLayout(List<PBIntermediateNode> children,
      PBContext currentContext, String name) {
    assert(false, 'Attempted to generateLayout for class type [$runtimeType]');
    return null;
  }

  static PBIntermediateNode fromJson(Map<String, dynamic> json) {
    var tempGroup = _$TempGroupLayoutNodeFromJson(json)
      // ..frame.topLeft = Point.topLeftFromJson(json)
      // ..frame.bottomRight = Point.bottomRightFromJson(json)
      ..originalRef = json;

    tempGroup.mapRawChildren(json);

    return tempGroup;
  }

  @override
  PBIntermediateNode createIntermediateNode(Map<String, dynamic> json) =>
      (TempGroupLayoutNode.fromJson(json) as TempGroupLayoutNode)
        ..originalRef = json;
}
