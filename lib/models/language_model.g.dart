// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageModel _$LanguageModelFromJson(Map json) => $checkedCreate(
      'LanguageModel',
      json,
      ($checkedConvert) {
        final val = LanguageModel(
          code: $checkedConvert('code', (v) => v as String? ?? ''),
          name: $checkedConvert('name', (v) => v as String? ?? ''),
          flag: $checkedConvert('flag', (v) => v as String? ?? ''),
          englishName:
              $checkedConvert('englishName', (v) => v as String? ?? ''),
        );
        return val;
      },
    );

const _$LanguageModelFieldMap = <String, String>{
  'code': 'code',
  'name': 'name',
  'flag': 'flag',
  'englishName': 'englishName',
};

abstract final class _$LanguageModelJsonKeys {
  static const String code = 'code';
  static const String name = 'name';
  static const String flag = 'flag';
  static const String englishName = 'englishName';
}

// ignore: unused_element
abstract class _$LanguageModelPerFieldToJson {
  // ignore: unused_element
  static Object? code(String instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? flag(String instance) => instance;
  // ignore: unused_element
  static Object? englishName(String instance) => instance;
}

Map<String, dynamic> _$LanguageModelToJson(LanguageModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'flag': instance.flag,
      'englishName': instance.englishName,
    };
