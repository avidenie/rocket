import 'package:dio/dio.dart';

import '../models/listing_dto.dart';
import '../models/post_dto.dart';
import 'post_data_source.dart';

class PostDataSourceImpl implements PostDataSource {
  PostDataSourceImpl({Dio? dio})
      : dio = dio ?? Dio(BaseOptions(baseUrl: 'https://www.reddit.com'));

  final Dio dio;

  @override
  Future<List<PostDto>> getPopularPosts() async {
    final response = await dio.get(
      '/r/popular.json',
      queryParameters: {'raw_json': 1},
    );
    return ListingDto.fromJson(
      response.data!['data'],
      (json) => PostDto.fromJson((json as Map<String, dynamic>)['data']),
    ).children;
  }
}
