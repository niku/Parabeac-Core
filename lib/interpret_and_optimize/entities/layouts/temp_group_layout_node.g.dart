// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_group_layout_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempGroupLayoutNode _$TempGroupLayoutNodeFromJson(Map<String, dynamic> json) {
  return TempGroupLayoutNode(
    json['UUID'] as String,
    DeserializedRectangle.fromJson(
        json['boundaryRectangle'] as Map<String, dynamic>),
    name: json['name'] as String,
    prototypeNode: PrototypeNode.prototypeNodeFromJson(
        json['prototypeNodeUUID'] as String),
  )
    ..subsemantic = json['subsemantic'] as String
    ..child = json['child'] == null
        ? null
        : PBIntermediateNode.fromJson(json['child'] as Map<String, dynamic>)
    ..topLeftCorner = PBPointLegacyMethod.topLeftFromJson(
        json['topLeftCorner'] as Map<String, dynamic>)
    ..bottomRightCorner = PBPointLegacyMethod.bottomRightFromJson(
        json['bottomRightCorner'] as Map<String, dynamic>)
    ..size = json['size'] as Map<String, dynamic>
    ..auxiliaryData = json['style'] == null
        ? null
        : IntermediateAuxiliaryData.fromJson(
            json['style'] as Map<String, dynamic>)
    ..type = json['type'] as String;
}

Map<String, dynamic> _$TempGroupLayoutNodeToJson(
        TempGroupLayoutNode instance) =>
    <String, dynamic>{
      'subsemantic': instance.subsemantic,
      'UUID': instance.UUID,
      'child': instance.child?.toJson(),
      'topLeftCorner': PBPointLegacyMethod.toJson(instance.topLeftCorner),
      'bottomRightCorner':
          PBPointLegacyMethod.toJson(instance.bottomRightCorner),
      'boundaryRectangle': DeserializedRectangle.toJson(instance.frame),
      'size': instance.size,
      'style': instance.auxiliaryData?.toJson(),
      'name': instance.name,
      'prototypeNodeUUID': instance.prototypeNode?.toJson(),
      'type': instance.type,
    };
