import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/app_enums.dart';

part 'planner_form.freezed.dart';
part 'planner_form.g.dart';

@freezed
class PlannerForm with _$PlannerForm {
  const factory PlannerForm({
    required DateTime startDate,
    required DateTime endDate,
    required int travelersCount,
    required double budget,
    required TravelStyle travelStyle,
    required TravelTheme travelTheme,
    @JsonKey(name: 'preferred_regions')
    @Default(<String>[])
    List<String> preferredRegions,
    @JsonKey(name: 'activity_level') required ActivityLevel activityLevel,
  }) = _PlannerForm;

  factory PlannerForm.fromJson(Map<String, dynamic> json) =>
      _$PlannerFormFromJson(json);
}
