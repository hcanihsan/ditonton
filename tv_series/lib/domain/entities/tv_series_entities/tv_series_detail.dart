import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TVSeriesDetail extends Equatable {
  const TVSeriesDetail({
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<dynamic> createdBy;
  final List<int> episodeRunTime;
  final List<Genre> genres;
  final String? homepage;
  final int? id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final String? name;
  final List<String> originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<dynamic> productionCompanies;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        createdBy,
        episodeRunTime,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
