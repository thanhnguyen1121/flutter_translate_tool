import 'package:json_annotation/json_annotation.dart';

part 'demo_model.g.dart';

@JsonSerializable()
class DemoModel {
  String name;

  DemoModel({
    required this.name,
  });

  factory DemoModel.fromJson(Map<String, dynamic> json) => _$DemoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DemoModelToJson(this);
}
