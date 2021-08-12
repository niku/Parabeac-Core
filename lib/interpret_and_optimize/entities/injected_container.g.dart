// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injected_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InjectedContainer _$InjectedContainerFromJson(Map<String, dynamic> json) {
  return InjectedContainer(
    json['UUID'],
    DeserializedRectangle.fromJson(
        json['boundaryRectangle'] as Map<String, dynamic>),
    name: json['name'] as String,
    prototypeNode:
        PrototypeNode.prototypeNodeFromJson(json['prototypeNode'] as String),
    type: json['type'] as String,
  )
    ..parent = json['parent'] == null
        ? null
        : PBIntermediateNode.fromJson(json['parent'] as Map<String, dynamic>)
    ..treeLevel = json['treeLevel'] as int
    ..subsemantic = json['subsemantic'] as String
    ..children = (json['children'] as List)
        ?.map((e) => e == null
            ? null
            : PBIntermediateNode.fromJson(e as Map<String, dynamic>))
        ?.toList()
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
            json['style'] as Map<String, dynamic>);
}

Map<String, dynamic> _$InjectedContainerToJson(InjectedContainer instance) =>
    <String, dynamic>{
      'parent': instance.parent,
      'treeLevel': instance.treeLevel,
      'subsemantic': instance.subsemantic,
      'UUID': instance.UUID,
      'children': instance.children,
      'child': instance.child,
      'topLeftCorner': PBPointLegacyMethod.toJson(instance.topLeftCorner),
      'bottomRightCorner':
          PBPointLegacyMethod.toJson(instance.bottomRightCorner),
      'boundaryRectangle': DeserializedRectangle.toJson(instance.frame),
      'size': instance.size,
      'style': instance.auxiliaryData,
      'name': instance.name,
      'prototypeNode': instance.prototypeNode,
      'type': instance.type,
    };
