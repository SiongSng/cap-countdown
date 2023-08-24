// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_filling.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoiceFilling _$ChoiceFillingFromJson(Map<String, dynamic> json) =>
    ChoiceFilling(
      highSchool: (json['high_school'] as List<dynamic>)
          .map((e) => ChoiceFillingData.fromJson(e as Map<String, dynamic>))
          .toList(),
      fiveYearCollege: ChoiceFillingData.fromJson(
          json['five_year_college'] as Map<String, dynamic>),
    );

ChoiceFillingData _$ChoiceFillingDataFromJson(Map<String, dynamic> json) =>
    ChoiceFillingData(
      name: json['name'] as String,
      link: json['link'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
    );
