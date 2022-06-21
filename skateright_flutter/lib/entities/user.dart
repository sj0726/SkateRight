import 'spot.dart';
import 'package:skateright_flutter/profile/load_profile_page.dart';

class User {
  User({
    this.id = '001',
    required this.name,
    required this.reviews,
    required this.savedSpots,
    required this.profilePicture,

    // Profile data
    this.username,
    this.pronouns,
    this.skill,
    this.mostInterestedIn,
    this.goals,
    this.otherGoals,
    this.bio,
    this.background,
  });

  final String id;
  final String name;
  final List<Comment> reviews;
  final List<Spot> savedSpots;
  final String profilePicture;

  // Profile data
  final String? username,
      pronouns,
      skill,
      mostInterestedIn,
      goals,
      otherGoals,
      bio,
      background;

  loadProfile() => ProfilePage(this);
}
