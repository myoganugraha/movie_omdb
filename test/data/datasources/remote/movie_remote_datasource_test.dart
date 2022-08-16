// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:movie_app/common/__mocks__/http_mock.dart';
import 'package:movie_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:movie_app/data/models/__mocks__/movie_model_mock.dart';

import '../../../mock.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());

  late http.Client httpClient;
  late MovieRemoteDatasource movieRemoteDatasource;

  final Map<String, dynamic> mockResponse = {
    'Search': mockMovieListModelJson['Search'],
    'Response': 'True'
  };

  const String query = 'batman';

  setUp(() {
    httpClient = MockHttpClient();
    movieRemoteDatasource = MovieRemoteDatasource(httpClient: httpClient);

    registerFallbackValue(FakeUri());
  });

  tearDownAll(() {});

  group('Movie remote datasource', () {
    group('to search movie', () {
      test('should call http', () async {
        // Given
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200),
        );

        // When
        final response = await movieRemoteDatasource.getMovieBySearch(query);

        //Then
        expect(response.length, 3);
        expect(response[0].title, 'Batman: Under the Red Hood');
        expect(response[0].year, '2010');
        expect(response[0].type, 'movie');
      });
    });
  });
}
