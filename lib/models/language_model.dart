import 'package:json_annotation/json_annotation.dart';

part 'language_model.g.dart';

@JsonSerializable()
class LanguageModel {
  LanguageModel({
    this.code = '',
    this.name = '',
    this.flag = '',
    this.englishName = '',
    this.selected = false,
  });

  String code;

  String name;

  String flag;

  @JsonKey(name: 'englishName')
  String englishName;

  @JsonKey(includeFromJson: false)
  bool selected;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => _$LanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);

  LanguageModel copyWith({
    String? code,
    String? name,
    String? flag,
    String? englishName,
    bool? selected,
  }) {
    return LanguageModel(
      code: code ?? this.code,
      name: name ?? this.name,
      flag: flag ?? this.flag,
      englishName: englishName ?? this.englishName,
      selected: selected ?? this.selected,
    );
  }
}
