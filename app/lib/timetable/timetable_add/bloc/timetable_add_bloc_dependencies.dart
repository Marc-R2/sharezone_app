// Copyright (c) 2022 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:meta/meta.dart';
import 'package:sharezone/timetable/src/models/lesson_length/lesson_length_cache.dart';
import 'package:sharezone/util/api/timetable_gateway.dart';

class TimetableAddBlocDependencies {
  final TimetableGateway gateway;
  final LessonLengthCache lessonLengthCache;

  TimetableAddBlocDependencies({
    @required this.gateway,
    @required this.lessonLengthCache,
  });
}
