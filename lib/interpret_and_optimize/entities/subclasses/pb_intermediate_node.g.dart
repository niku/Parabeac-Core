// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pb_intermediate_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PBIntermediateNodeToJson(PBIntermediateNode instance) =>
    <String, dynamic>{
      'subsemantic': instance.subsemantic,
      'UUID': instance.UUID,
      'children': instance.children?.map((e) => e?.toJson())?.toList(),
      'child': instance.child?.toJson(),
      'topLeftCorner': PBPointLegacyMethod.toJson(instance.topLeftCorner),
      'bottomRightCorner':
          PBPointLegacyMethod.toJson(instance.bottomRightCorner),
      'boundaryRectangle': DeserializedRectangle.toJson(instance.frame),
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
      'style': instance.auxiliaryData?.toJson(),
      'name': instance.name,
    };
