// ignore_for_file: avoid_dynamic_calls

import 'package:movie_app/domain/entities/rating_entity.dart';

class RatingModel extends RatingEntity {
  RatingModel({
    required super.source,
    required super.value,
  });

  factory RatingModel.fromJson(dynamic json) => RatingModel(
        source: json['Source'] as String,
        value: json['Value'] as String,
      );
}
