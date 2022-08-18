// ignore_for_file: omit_local_variable_types, unnecessary_type_check

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movie_app/common/__mocks__/http_mock.dart';
import 'package:movie_app/data/datasources/remote/movie_remote_datasource.dart';
import 'package:movie_app/data/models/__mocks__/movie_details_model_mock.dart';
import 'package:movie_app/data/models/__mocks__/movie_model_mock.dart';

import '../../../mock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());

  late Client httpClient;
  late MovieRemoteDatasource movieRemoteDatasource;

  setUp(() {
    httpClient = MockHttpClient();
    movieRemoteDatasource = MovieRemoteDatasource(httpClient);

    registerFallbackValue(FakeUri());
  });

  tearDownAll(() {});

  group('Movie remote datasource', () {
    group('getMovieBySearch() when call http', () {
      test('should get valid data', () async {
        // Given
        const String query = 'bat';
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => Response(jsonEncode(mockSearchResultJson), 200),
        );

        // When
        final response = await movieRemoteDatasource.getMovieBySearch(query);

        //Then
        expect(response.length, 3);
        expect(response[0].title, 'Bat*21');
        expect(response[0].year, '1988');
        expect(response[0].type, 'movie');
      });

      test('throw Exception', () async {
        // Given
        String error = '';
        when(() => httpClient.get(any())).thenThrow(Exception(''));

        // When
        try {
          
              await movieRemoteDatasource.getMovieBySearch('bat');
        } catch (e) {
          error = e.toString();
        }

        //Then
        expect(error is String, true);
        expect(error.isNotEmpty, true);
        expect(error, 'Exception: Exception: ');
      });
    });

    group('getMovieDetailsByImdbId() when call http request ', () {
      test('return valid data', () async {
        // Given
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => Response(jsonEncode(mockMovieDetailsModel), 200),
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

      test('return Exception()', () async {
        // Given
        String error = '';
        when(() => httpClient.get(any())).thenThrow(Exception(''));

        // When
        try {
          
              await movieRemoteDatasource.getMovieDetailsByImdbId('tt0372784');
        } catch (e) {
          error = e.toString();
        }

        //Then
        expect(error is String, true);
        expect(error.isNotEmpty, true);
        expect(error, 'Exception: Exception: ');
      });
    });
  });
}
