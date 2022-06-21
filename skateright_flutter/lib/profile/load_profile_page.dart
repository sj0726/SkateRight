import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skateright_flutter/profile/profile_form1.dart';
import 'package:skateright_flutter/styles/skate_theme.dart';

import 'package:skateright_flutter/entities/user.dart';

whichBackground(String backgroundChoice) {
  String bg1 = "assets/backgrounds/bg1-rectangle.png";
  String bg2 = "assets/backgrounds/bg2-rectangle.png";
  String bg3 = "assets/backgrounds/bg3-rectangle.png";
  String bg4 = "assets/backgrounds/bg4-rectangle.png";
  if (backgroundChoice == "background 1") {
    return bg1;
  }
  if (backgroundChoice == "background 2") {
    return bg2;
  }
  if (backgroundChoice == "background 3") {
    return bg3;
  }
  if (backgroundChoice == "background 1") {
    return bg4;
  } else {
    return bg1;
  }
}

class ProfileData extends InheritedWidget {
  const ProfileData({Key? key, required this.myProfile, required Widget child})
      : super(key: key, child: child);

  final User myProfile;

  static ProfileData of(BuildContext context) {
    final ProfileData? result =
        context.dependOnInheritedWidgetOfExactType<ProfileData>();
    assert(result != null, 'No Profile found in context');
    return result!;
  }

  @override

  /// Comparing every single editable attribute :)
  /// Negative: full page is reloaded on change
  bool updateShouldNotify(ProfileData old) =>
      myProfile.bio != old.myProfile.bio ||
      myProfile.background != old.myProfile.background ||
      myProfile.goals != old.myProfile.goals ||
      myProfile.otherGoals != old.myProfile.otherGoals ||
      myProfile.mostInterestedIn != old.myProfile.mostInterestedIn ||
      myProfile.skill != old.myProfile.skill ||
      myProfile.pronouns != old.myProfile.pronouns ||
      myProfile.profilePicture != old.myProfile.profilePicture;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage(this.user, {Key? key, this.isMe = false}) : super(key: key);

  final User user;
  final bool isMe;

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  late User user;
  bool isMe = false;
  // String bg1 = "assets/backgrounds/bg1-rectangle.png";
  // String bg2 = "assets/backgrounds/bg2-rectangle.png";
  // String bg3 = "assets/backgrounds/bg3-rectangle.png";
  // String bg4 = "assets/backgrounds/bg4-rectangle.png";
  String figure1 = "assets/figures/skater1-profile.png";
  String figure2 = "assets/figures/skater2-profile.png";
  String figure3 = "assets/figures/skater3-profile.png";
  String figure4 = "assets/figures/skater4-profile.png";
  String figure5 = "assets/figures/user_profile.png";

  @override
  void initState() {
    super.initState();
    user = widget.user;
    // TODO: figure out how to set/accesses global <app_user> variable
    isMe = widget.isMe;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: <Widget>[
              user.background == null
                  ? Image.asset(
                      whichBackground("${user.background}"),
                      width: double.infinity,
                    )
                  : Text('Add Image'),
              SizedBox(height: 16),
              Text(
                "@${user.name}",
                // textAlign: TextAlign.left,
                // style: const TextStyle(
                //     fontSize: 18.0,
                //     fontFamily: 'RobotoMono',
                //     color: Color(0xFFf0e6d0)),
              ),

              SizedBox(height: 8),
              Text(
                "${user.name}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'RobotoMono',
                    color: Color(0xFFf0e6d0)),
              ),

              Text(
                "${user.pronouns}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'RobotoMono',
                    color: Color(0xFF94B321)),
              ),
              SizedBox(height: 16),
              // ins column
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Skill Level",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Karla',
                          color: Color(0xFFEB001B),
                          fontSize: 17.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "${user.skill}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Roboto Mono',
                          color: Color(0xFFf1c200),
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Interests",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Karla',
                          color: Color(0xFFEB001B),
                          fontSize: 17.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "  ${user.mostInterestedIn}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Roboto Mono',
                          color: Color(0xFFf1c200),
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "My goals",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Karla',
                          color: Color(0xFFEB001B),
                          fontSize: 17.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      // TODO
                      "  Gain confidence\n  Skate in the bowl\n  ${user.otherGoals}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontFamily: 'Roboto Mono',
                          color: Color(0xFFf1c200),
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  "About me",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Roboto Mono',
                      color: Color(0xFFf0e6d0)),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  "${user.bio}",
                  style: const TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Karla',
                      color: Color(0xFFf0e6d0)),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: make this functionality work
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileForm(user: user)));
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontFamily: 'Roboto Mono',
                      fontSize: 17.0,
                      color: Color(0xFF94B321),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      primary: Color(0xFF141414),
                      textStyle: const TextStyle(fontFamily: 'Roboto Mono'),
                      alignment: Alignment.centerRight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
