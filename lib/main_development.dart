// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/bootstrap.dart';
import 'package:movie_app/common/injector/injector.dart';
import 'package:movie_app/presentation/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.setup();
  await dotenv.load(fileName: '.env');
  await bootstrap(() => const App());
}
