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
import 'package:movie_app/data/models/__mocks__/movie_details_model_mock.dart';
import 'package:movie_app/data/models/__mocks__/movie_model_mock.dart';

import '../../../mock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());

  late http.Client httpClient;
  late MovieRemoteDatasource movieRemoteDatasource;

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
        const String query = 'bat';
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode(mockSearchResultJson), 200),
        );

        // When
        final response = await movieRemoteDatasource.getMovieBySearch(query);

        //Then
        expect(response.length, 3);
        expect(response[0].title, 'Bat*21');
        expect(response[0].year, '1988');
        expect(response[0].type, 'movie');
      });
    });

    group('to get movie details by IMDB id', () {
      test('should cal http', () async {
        // Given
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode(mockMovieDetailsModel), 200),
        );

        // When
        final response =
            await movieRemoteDatasource.getMovieDetailsByImdbId('tt0372784');

        //Then
        expect(response.title, 'Batman Begins');
        expect(response.year, '2005');
        expect(response.type, 'movie');
        expect(response.imdbID, 'tt0372784');
      });
    });
  });
}
