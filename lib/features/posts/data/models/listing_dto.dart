import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing_dto.freezed.dart';
part 'listing_dto.g.dart';

@Freezed(genericArgumentFactories: true)
class ListingDto<T> with _$ListingDto<T> {
  const factory ListingDto({
    required List<T> children,
  }) = _ListingDto<T>;

  factory ListingDto.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ListingDtoFromJson(json, fromJsonT);
}
