import 'package:json_annotation/json_annotation.dart';

part 'choice_filling.g.dart';

@JsonSerializable(createToJson: false)
class ChoiceFilling {
  @JsonKey(name: 'high_school')
  final List<ChoiceFillingData> highSchool;

  @JsonKey(name: 'five_year_college')
  final ChoiceFillingData fiveYearCollege;

  const ChoiceFilling({
    required this.highSchool,
    required this.fiveYearCollege,
  });

  factory ChoiceFilling.fromJson(Map<String, dynamic> json) =>
      _$ChoiceFillingFromJson(json);
}

@JsonSerializable(createToJson: false)
class ChoiceFillingData {
  final String name;
  final String link;

  @JsonKey(name: 'start_time')
  final DateTime startTime;

  @JsonKey(name: 'end_time')
  final DateTime endTime;

  const ChoiceFillingData({
    required this.name,
    required this.link,
    required this.startTime,
    required this.endTime,
  });

  factory ChoiceFillingData.fromJson(Map<String, dynamic> json) =>
      _$ChoiceFillingDataFromJson(json);
}
