// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemoModel _$DemoModelFromJson(Map json) => $checkedCreate(
      'DemoModel',
      json,
      ($checkedConvert) {
        final val = DemoModel(
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

const _$DemoModelFieldMap = <String, String>{
  'name': 'name',
};

abstract final class _$DemoModelJsonKeys {
  static const String name = 'name';
}

// ignore: unused_element
abstract class _$DemoModelPerFieldToJson {
  // ignore: unused_element
  static Object? name(String instance) => instance;
}

Map<String, dynamic> _$DemoModelToJson(DemoModel instance) => <String, dynamic>{
      'name': instance.name,
    };
