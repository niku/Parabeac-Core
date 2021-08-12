// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inherited_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InheritedText _$InheritedTextFromJson(Map<String, dynamic> json) {
  return InheritedText(
    json['UUID'] as String,
    DeserializedRectangle.fromJson(
        json['boundaryRectangle'] as Map<String, dynamic>),
    name: json['name'],
    isTextParameter: json['isTextParameter'] as bool ?? false,
    prototypeNode: PrototypeNode.prototypeNodeFromJson(
        json['prototypeNodeUUID'] as String),
    text: json['content'] as String,
  )
    ..parent = json['parent'] == null
        ? null
        : PBIntermediateNode.fromJson(json['parent'] as Map<String, dynamic>)
    ..treeLevel = json['treeLevel'] as int
    ..subsemantic = json['subsemantic'] as String
    ..size = json['size'] as Map<String, dynamic>
    ..auxiliaryData = json['style'] == null
        ? null
        : IntermediateAuxiliaryData.fromJson(
            json['style'] as Map<String, dynamic>)
    ..type = json['type'] as String;
}

Map<String, dynamic> _$InheritedTextToJson(InheritedText instance) =>
    <String, dynamic>{
      'parent': instance.parent,
      'treeLevel': instance.treeLevel,
      'subsemantic': instance.subsemantic,
      'UUID': instance.UUID,
      'boundaryRectangle': DeserializedRectangle.toJson(instance.frame),
      'size': instance.size,
      'style': instance.auxiliaryData,
      'name': instance.name,
      'isTextParameter': instance.isTextParameter,
      'prototypeNodeUUID': instance.prototypeNode,
      'type': instance.type,
      'content': instance.text,
    };
