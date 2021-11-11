// Mocks generated by Mockito 5.0.16 from annotations
// in tv_series/test/presentation/bloc/tv_series_detail_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_series/domain/entities/tv_series_entities/tv_series_detail.dart'
    as _i7;
import 'package:tv_series/domain/repositories/tv_series_repositories/tv_series_repository.dart'
    as _i2;
import 'package:tv_series/domain/usecases/tv_series_usecases/get_tv_series_detail.dart'
    as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTVSeriesRepository_0 extends _i1.Fake
    implements _i2.TVSeriesRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTVSeriesDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVSeriesDetail extends _i1.Mock implements _i4.GetTVSeriesDetail {
  MockGetTVSeriesDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository_0()) as _i2.TVSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TVSeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue:
                  Future<_i3.Either<_i6.Failure, _i7.TVSeriesDetail>>.value(
                      _FakeEither_1<_i6.Failure, _i7.TVSeriesDetail>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.TVSeriesDetail>>);
  @override
  // ignore: unnecessary_overrides
  String toString() => super.toString();
}
