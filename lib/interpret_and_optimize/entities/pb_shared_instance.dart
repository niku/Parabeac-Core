import 'package:parabeac_core/design_logic/design_node.dart';
import 'package:parabeac_core/generation/generators/symbols/pb_instancesym_gen.dart';
import 'package:parabeac_core/generation/generators/util/pb_input_formatter.dart';
import 'package:parabeac_core/generation/prototyping/pb_prototype_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/interfaces/pb_inherited_intermediate.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_visual_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/abstract_intermediate_node_factory.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_context.dart';
import 'package:parabeac_core/interpret_and_optimize/value_objects/pb_symbol_instance_overridable_value.dart';
import 'package:parabeac_core/interpret_and_optimize/value_objects/point.dart';
import 'package:parabeac_core/input/sketch/helper/symbol_node_mixin.dart';
import 'alignments/injected_align.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pb_shared_instance.g.dart';

@JsonSerializable(ignoreUnannotated: true, explicitToJson: true)

/// As some nodes are shared throughout the project, shared instances are pointers to shared master nodes with overridable properties.
/// Superclass: PBSharedIntermediateNode

@JsonSerializable(ignoreUnannotated: true)
class PBSharedInstanceIntermediateNode extends PBVisualIntermediateNode
    implements PBInheritedIntermediate, IntermediateNodeFactory {
  @JsonKey()
  final String SYMBOL_ID;

  ///The parameters that are going to be overriden in the [PBSharedMasterNode].

  @JsonKey(name: 'overrideValues')
  List<PBSharedParameterValue> sharedParamValues;

  ///The name of the function call that the [PBSharedInstanceIntermediateNode] is
  ///going to use; the name of the [PBSharedMasterNode].
  String functionCallName;

  bool foundMaster = false;
  bool isMasterState = false;

  @override
  var originalRef;

  @override
  @JsonKey(fromJson: PrototypeNode.prototypeNodeFromJson)
  PrototypeNode prototypeNode;

  @override
  @JsonKey()
  String type = 'symbol_instance';

  @override
  @JsonKey(fromJson: Point.topLeftFromJson)
  Point topLeftCorner;
  @override
  @JsonKey(fromJson: Point.bottomRightFromJson)
  Point bottomRightCorner;

  List<PBSymbolInstanceOverridableValue> overrideValues;
  // quick lookup based on UUID_type
  Map<String, PBSymbolInstanceOverridableValue> overrideValuesMap = {};

  PBSharedInstanceIntermediateNode(
    this.originalRef,
    this.SYMBOL_ID, {
    this.sharedParamValues,
    Point topLeftCorner,
    Point bottomRightCorner,
    PBContext currentContext,
  }) : super(
            Point(originalRef.boundaryRectangle.x,
                originalRef.boundaryRectangle.y),
            Point(
                (originalRef.boundaryRectangle.x +
                    originalRef.boundaryRectangle.width),
                (originalRef.boundaryRectangle.y +
                    originalRef.boundaryRectangle.height)),
            currentContext,
            originalRef.name,
            UUID: originalRef.UUID) {
    if (originalRef is DesignNode && originalRef.prototypeNodeUUID != null) {
      prototypeNode = PrototypeNode(originalRef?.prototypeNodeUUID);
    }
    generator = PBSymbolInstanceGenerator();

    overrideValues = sharedParamValues.map((v) {
      var symOvrValue =
          PBSymbolInstanceOverridableValue(v.UUID, v.value, v.type);
      overrideValuesMap[v.overrideName] = symOvrValue;
      return symOvrValue;
    }).toList()
      ..removeWhere((v) => v == null || v.value == null);
  }

  @override
  void addChild(PBIntermediateNode node) {}

  @override
  void alignChild() {
    if (child != null) {
      var align =
          InjectedAlign(topLeftCorner, bottomRightCorner, currentContext, '');
      align.addChild(child);
      align.alignChild();
      child = align;
    }
  }

  @override
  PBIntermediateNode fromJson(Map<String, dynamic> json) =>
      _$PBSharedInstanceIntermediateNodeFromJson(json);
}

class PBSharedParameterValue {
  final Type _type;
  Type get type => _type;
  set type(Type type) => _type;

  final dynamic _value;
  dynamic get value => _value;

  final String _UUID;
  String get UUID => _UUID;

  final String _overrideName;
  String get overrideName => _overrideName;

  String get name =>
      SN_UUIDtoVarName[PBInputFormatter.findLastOf(_overrideName, '/')];

  PBSharedParameterValue(
    this._type,
    this._value,
    this._UUID,
    this._overrideName,
  );
}
