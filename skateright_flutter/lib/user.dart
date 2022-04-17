import 'spot.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.reviews,
    required this.savedSpots,
    required this.profilePicture,
  });

  final String id;
  final String name;
  final List<Comment> reviews;
  final List<Spot> savedSpots;
  final String profilePicture;
}
