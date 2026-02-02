import 'package:dio/dio.dart';

class ApiServices {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60), //change to 30
      receiveTimeout: const Duration(seconds: 60), //change to 30
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Response> post(
    String endpoint,
    List<dynamic>? data, {
    String? token,
  }) async {
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }

    print(' Data !!!!!: $data');
    print('token ############# : $token');
    print('endpoint ############# : $endpoint');
    return await _dio.get(endpoint, data: data ?? {});
  }

  Future<Response> get(
  String endpoint, {
  Map<String, dynamic>? queryParameters,
  String? token,
}) async {
  if (token != null && token.isNotEmpty) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  print('GET endpoint 🔗 : $endpoint');
  print('Query params 📦 : $queryParameters');
  print('Token 🔐 : $token');

  return await _dio.get(
    endpoint,
    queryParameters: queryParameters,
  );
}


  Future<Response> postMultipart(
    String endpoint,
    Map<String, dynamic> fields, {
    List<Map<String, dynamic>>? files,
    String? token,
  }) async {
    try {
      if (token != null) {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }

      FormData formData = FormData();

      fields.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      // Add files
      if (files != null) {
        for (var file in files) {
          formData.files.add(
            MapEntry(
              file['field'],
              await MultipartFile.fromFile(
                file['path'],
                filename: file['filename'],
              ),
            ),
          );
        }
      }

      return await _dio.post(endpoint, data: formData);
    } catch (e) {
      print('Error in postMultipart: $e');
      throw e;
    }
  }
}
