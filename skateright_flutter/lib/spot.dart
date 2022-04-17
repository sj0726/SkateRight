import 'package:meta/meta.dart';

/// Model for a skate spot. Can contain an optional list of [Comment]s
/// if users have submitted comments on the spot
///
/// Used in building spot card popups in map icon onTap()
class Spot {
  const Spot({
    this.id = "0", // TODO: Set to required once infrastructure in place
    required this.title,
    // required this.address,
    required this.latitude,
    required this.longitude,
    this.isPark = true,
    required this.pictures,
    this.score,
    required this.comments,
    required this.obstacles,
  });

  final String id;
  final String title;
  final double latitude;
  final double longitude;
  final bool isPark;

  // final String address;
  final List<String> pictures;

  /// Nullable & optional
  final double? score;
  final List<Comment> comments;
  final List<String> obstacles;

  List<Comment> getComments() {
    return comments;
  }
}

/// An individual review model, used within a [Spot].
class Comment {
  /// {@macro item}
  Comment(
      {required this.id,
      required this.user,
      this.description = '',
      this.isReview = false, // Post is default a comment
      this.score // Nullable
      });

  /// The id of the comment itself
  final String id;

  /// The id of the user who posted
  final String user;

  /// Text value of comment (what the user is saying about the spot)
  final String description;

  /// Indicates whether the comment on the spot contains a /5 score
  final bool isReview;

  /// Score if isReview
  final int? score;
}
