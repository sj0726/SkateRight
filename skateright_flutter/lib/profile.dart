import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skateright_flutter/profile_form.dart';
import 'package:skateright_flutter/styles/skate_theme.dart';

class CompletedProfile extends StatefulWidget {
  const CompletedProfile({Key? key,
  this.name,
  this.username,
  this.pronouns,
  this.skillLevel,
  this.mostInterestedIn,
  this.goals,
  this.otherGoals,
  this.aboutYourself,
  this.skaterIcon,
  this.background}) : super(key: key);

  final String?
      name,
      username,
      pronouns,
      skillLevel,
      mostInterestedIn,
      goals,
      otherGoals,
      aboutYourself,
      skaterIcon,
      background;

  @override
  State<CompletedProfile> createState() => _CompletedProfile();
}

class _CompletedProfile extends State<CompletedProfile> {
  String? name, username, pronouns, skillLevel, mostInterestedIn, goals, otherGoals, aboutYourself, skaterIcon, background;
  String bg1 = "assets/backgrounds/bg1-rectangle.png";
  String bg2 = "assets/backgrounds/bg2-rectangle.png";
  String bg3 = "assets/backgrounds/bg3-rectangle.png";
  String bg4 = "assets/backgrounds/bg4-rectangle.png";
  String figure1 = "assets/figures/skater1-profile.png";
  String figure2 = "assets/figures/skater2-profile.png";
  String figure3 = "assets/figures/skater3-profile.png";
  String figure4 = "assets/figures/skater4-profile.png";
  String figure5 = "assets/figures/user_profile.png";

  @override
  void initState() {
    super.initState();
    name = widget.name;
    username = widget.username;
    pronouns = widget.pronouns;
    skillLevel = widget.skillLevel;
    mostInterestedIn = widget.mostInterestedIn;
    goals = widget.goals;
    otherGoals = widget.otherGoals;
    aboutYourself = widget.aboutYourself;
    skaterIcon = widget.skaterIcon;
    background = widget.background;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Image.asset(
                bg1,
                width: double.infinity,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                "@$username",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18.0,
                    fontFamily: 'RobotoMono',
                    color: Color(0xFFf0e6d0)
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                "$name",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                    fontFamily: 'RobotoMono',
                    color: Color(0xFFf0e6d0)
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Text(
                "$pronouns",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18.0, fontFamily: 'RobotoMono', color: Color(0xFF94B321)),),
            ),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                                "Skill Level",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontFamily: 'Karla', color: Color(0xFFEB001B), fontSize: 17.0),
                            ),
                        ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "$skillLevel",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontFamily: 'Roboto Mono', color: Color(0xFFf1c200), fontSize: 18.0),
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
                            style: TextStyle(fontFamily: 'Karla', color: Color(0xFFEB001B), fontSize: 17.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "  $mostInterestedIn",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontFamily: 'Roboto Mono', color: Color(0xFFf1c200), fontSize: 18.0),
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
                            style: TextStyle(fontFamily: 'Karla', color: Color(0xFFEB001B), fontSize: 17.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text( // TODO
                            "  Gain confidence\n  Skate in the bowl\n  $otherGoals",
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontFamily: 'Roboto Mono', color: Color(0xFFf1c200), fontSize: 18.0),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
            ),

            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                "About me",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto Mono',
                  color: Color(0xFFf0e6d0)
                ),
              ),
            ),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "$aboutYourself",
                style: const TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'Karla',
                  color: Color(0xFFf0e6d0)
                ),
              ),
            ),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: make this functionality work
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CreateProfileForm()));
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
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  primary: Color(0xFF141414),
                  textStyle: const TextStyle(fontFamily: 'Roboto Mono'),
                  alignment: Alignment.centerRight
                ),
              ),
            ),

            // Activity Section
            // Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            //             child: Text(
            //               "Reviews",
            //               style: TextStyle(fontFamily: 'Karla', fontSize: 17.0, color: Color(0xFFf0e6d0)),
            //             ),
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // )

          ],
        )
      )
    );
  }
}