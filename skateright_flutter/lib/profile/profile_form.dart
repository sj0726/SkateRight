import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skateright_flutter/profile/load_profile_page.dart';
import 'package:skateright_flutter/entities/user.dart';

class ProfileForm extends StatefulWidget {
  ProfileForm({Key? key, this.user}) : super(key: key);

  User? user;

  @override
  State<ProfileForm> createState() => _CreateProfileForm();
}

class _CreateProfileForm extends State<ProfileForm> {
  late TextEditingController name;
  late TextEditingController username;
  late TextEditingController pronouns;
  late TextEditingController otherGoal;
  late TextEditingController aboutYourself;
  List<String> skillLevel = [];
  List<String> mostInterestedIn = [];
  List<bool> goalIsChecked = [false, false, false, false, false, false];
  List<String> whichSkater = [];
  List<String> background = [];

  String figure1 = "assets/figures/skater1-cream.png";
  String figure2 = "assets/figures/skater2-cream.png";
  String figure3 = "assets/figures/skater3-cream.png";
  String figure4 = "assets/figures/skater4-cream.png";
  String figure5 = "assets/figures/user_profile.png";
  String bg1 = "assets/backgrounds/bg1.png";
  String bg2 = "assets/backgrounds/bg2.png";
  String bg3 = "assets/backgrounds/bg3.png";
  String bg4 = "assets/backgrounds/bg4.png";

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.user?.name);
    username = TextEditingController.fromValue(
        TextEditingValue(text: widget.user?.username ?? ''));
    pronouns = TextEditingController.fromValue(
        TextEditingValue(text: widget.user?.pronouns ?? ''));
    otherGoal = TextEditingController.fromValue(
        TextEditingValue(text: widget.user?.otherGoals ?? ''));
    aboutYourself = TextEditingController.fromValue(
        TextEditingValue(text: widget.user?.bio ?? ''));

    // TODO: init skill level and all the non-text-field shenanigans    
  }

  @override
  void dispose() {
    name.dispose();
    pronouns.dispose();
    otherGoal.dispose();
    aboutYourself.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
                // TODO: sharp corners
                controller: name,
                cursorColor: const Color(0xFF94B321),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFf0e6d0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF94B321)),
                      borderRadius: BorderRadius.zero),
                  border: OutlineInputBorder(),
                  labelText: "What's your name?",
                  labelStyle: TextStyle(color: Color(0xFFf0e6d0)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: username,
              cursorColor: const Color(0xFF94B321),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFf0e6d0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF94B321)),
                      borderRadius: BorderRadius.zero),
                  border: OutlineInputBorder(),
                  labelText: "Username?",
                  labelStyle: TextStyle(color: Color(0xFFf0e6d0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: pronouns,
              cursorColor: const Color(0xFF94B321),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFf0e6d0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF94B321)),
                      borderRadius: BorderRadius.zero),
                  border: OutlineInputBorder(),
                  labelText: "Pronouns?",
                  labelStyle: TextStyle(color: Color(0xFFf0e6d0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Skill level?",
                    style: TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      skillLevel.clear();
                      skillLevel.add("I'm new here");
                    },
                    child: const Text(
                      "I'm new here",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
                ElevatedButton(
                    onPressed: () {
                      skillLevel.clear();
                      skillLevel.add("Beginner");
                    },
                    child: const Text(
                      "Beginner",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
                ElevatedButton(
                    onPressed: () {
                      skillLevel.clear();
                      skillLevel.add("Intermediate");
                    },
                    child: const Text(
                      "Intermediate",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
                ElevatedButton(
                    onPressed: () {
                      skillLevel.clear();
                      skillLevel.add("Advanced");
                    },
                    child: const Text(
                      "Advanced",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
                ElevatedButton(
                    onPressed: () {
                      skillLevel.clear();
                      skillLevel.add("Basically a pro");
                    },
                    child: const Text(
                      "Basically a pro",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "What are you most interested in?",
                    style: TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      mostInterestedIn.clear();
                      mostInterestedIn.add("Street skating");
                    },
                    child: const Text(
                      "Street skating",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
                ElevatedButton(
                    onPressed: () {
                      mostInterestedIn.clear();
                      mostInterestedIn.add("Skating for transportation");
                    },
                    child: const Text(
                      "Skating for transportation",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
                ElevatedButton(
                    onPressed: () {
                      mostInterestedIn.clear();
                      mostInterestedIn.add("Learning new tricks");
                    },
                    child: const Text(
                      "Learning new tricks",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
                ElevatedButton(
                    onPressed: () {
                      mostInterestedIn.clear();
                      mostInterestedIn.add("Fun skate session");
                    },
                    child: const Text(
                      "Fun skate session",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
                ElevatedButton(
                    onPressed: () {
                      mostInterestedIn.clear();
                      mostInterestedIn.add("Meeting new people");
                    },
                    child: const Text(
                      "Meeting new people",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
                ElevatedButton(
                    onPressed: () {
                      mostInterestedIn.clear();
                      mostInterestedIn.add("Hanging out with friends");
                    },
                    child: const Text(
                      "Hanging out with friends",
                      style: TextStyle(color: Color(0xFF94B321)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Color(0xFF94B321)),
                        primary: Colors.transparent,
                        textStyle:
                            const TextStyle(fontFamily: 'Karla')) // style
                    ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "What are your goals?",
                  style: TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                ),
                ListTile(
                  title: const Text("Get on the board"),
                  leading: Checkbox(
                    checkColor: const Color(0xFF141414),
                    // TODO: figure out how to do fill color with type MaterialColor
                    side: const BorderSide(
                      color: Color(0xFF94B321),
                    ),
                    value: goalIsChecked[0],
                    onChanged: (bool? value) {
                      setState(() {
                        goalIsChecked[0] = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Gain confidence"),
                  leading: Checkbox(
                    checkColor: const Color(0xFF141414),
                    side: const BorderSide(
                      color: Color(0xFF94B321),
                    ),
                    value: goalIsChecked[1],
                    onChanged: (bool? value) {
                      setState(() {
                        goalIsChecked[1] = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Meet new skaters"),
                  leading: Checkbox(
                    checkColor: const Color(0xFF141414),
                    side: const BorderSide(
                      color: Color(0xFF94B321),
                    ),
                    value: goalIsChecked[2],
                    onChanged: (bool? value) {
                      setState(() {
                        goalIsChecked[2] = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Do an ollie"),
                  leading: Checkbox(
                    checkColor: const Color(0xFF141414),
                    side: const BorderSide(
                      color: Color(0xFF94B321),
                    ),
                    value: goalIsChecked[3],
                    onChanged: (bool? value) {
                      setState(() {
                        goalIsChecked[3] = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Do a kickflip"),
                  leading: Checkbox(
                    checkColor: const Color(0xFF141414),
                    side: const BorderSide(
                      color: Color(0xFF94B321),
                    ),
                    value: goalIsChecked[4],
                    onChanged: (bool? value) {
                      setState(() {
                        goalIsChecked[4] = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Find new skate spots"),
                  leading: Checkbox(
                    checkColor: const Color(0xFF141414),
                    side: const BorderSide(
                      color: Color(0xFF94B321),
                    ),
                    value: goalIsChecked[5],
                    onChanged: (bool? value) {
                      setState(() {
                        goalIsChecked[5] = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: otherGoal,
              cursorColor: const Color(0xFF94B321),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFf0e6d0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF94B321))),
                  border: OutlineInputBorder(),
                  labelText: "Other goal:",
                  labelStyle: TextStyle(color: Color(0xFFf0e6d0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: aboutYourself,
              cursorColor: const Color(0xFF94B321),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFf0e6d0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF94B321)),
                      borderRadius: BorderRadius.zero),
                  border: OutlineInputBorder(),
                  labelText: "Tell us about yourself!",
                  labelStyle: TextStyle(color: Color(0xFFf0e6d0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // gridDelegate: null,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Which skater are you?",
                    style: TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {
                            whichSkater.clear();
                            whichSkater.add("Skater 1");
                            setState(() {
                              figure1 = "assets/figures/skater1-green.png";
                              figure2 = "assets/figures/skater2-cream.png";
                              figure3 = "assets/figures/skater3-cream.png";
                              figure4 = "assets/figures/skater4-cream.png";
                              figure5 = "assets/figures/user_profile.png";
                            });
                          },
                          icon: Image.asset(figure1),
                          label: const Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              primary: Colors.transparent),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            whichSkater.clear();
                            whichSkater.add("Skater 2");
                            setState(() {
                              figure1 = "assets/figures/skater1-cream.png";
                              figure2 = "assets/figures/skater2-green.png";
                              figure3 = "assets/figures/skater3-cream.png";
                              figure4 = "assets/figures/skater4-cream.png";
                              figure5 = "assets/figures/user_profile.png";
                            });
                          },
                          icon: Image.asset(figure2),
                          label: const Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              primary: Colors.transparent),
                        ),
                      ],
                    ),
                  ),
                ),
                FittedBox(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {
                            whichSkater.clear();
                            whichSkater.add(figure3);
                            setState(() {
                              figure1 = "assets/figures/skater1-cream.png";
                              figure2 = "assets/figures/skater2-cream.png";
                              figure3 = "assets/figures/skater3-green.png";
                              figure4 = "assets/figures/skater4-cream.png";
                              figure5 = "assets/figures/user_profile.png";
                            });
                          },
                          icon: Image.asset('assets/figures/skater3-cream.png'),
                          label: const Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              primary: Colors.transparent),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            whichSkater.clear();
                            whichSkater.add("Skater 4");
                            setState(() {
                              figure1 = "assets/figures/skater1-cream.png";
                              figure2 = "assets/figures/skater2-cream.png";
                              figure3 = "assets/figures/skater3-cream.png";
                              figure4 = "assets/figures/skater4-green.png";
                              figure5 = "assets/figures/user_profile.png";
                            });
                          },
                          icon: Image.asset(figure4),
                          label: const Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              primary: Colors.transparent),
                        ),
                      ]),
                ),
                FittedBox(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {
                            whichSkater.clear();
                            whichSkater.add("Skater 5");
                            setState(() {
                              figure1 = "assets/figures/skater1-cream.png";
                              figure2 = "assets/figures/skater2-cream.png";
                              figure3 = "assets/figures/skater3-cream.png";
                              figure4 = "assets/figures/skater4-cream.png";
                              figure5 = "assets/figures/user_profile_green.png";
                            });
                          },
                          icon: Image.asset(figure5),
                          label: const Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              primary: Colors.transparent),
                        ),
                      ]),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Choose your favorite pattern",
                    style: TextStyle(fontFamily: 'RobotoMono', fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {
                            background.clear();
                            background.add("background 1");
                            setState(() {
                              bg1 = "assets/backgrounds/bg1_green.png";
                              bg2 = "assets/backgrounds/bg2.png";
                              bg3 = "assets/backgrounds/bg3.png";
                              bg4 = "assets/backgrounds/bg4.png";
                            });
                          },
                          icon: Image.asset(bg1),
                          label: const Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              primary: Colors.transparent),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            background.clear();
                            background.add("background 2");
                            setState(() {
                              bg1 = "assets/backgrounds/bg1.png";
                              bg2 = "assets/backgrounds/bg2_green.png";
                              bg3 = "assets/backgrounds/bg3.png";
                              bg4 = "assets/backgrounds/bg4.png";
                            });
                          },
                          icon: Image.asset(bg2),
                          label: const Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              primary: Colors.transparent),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {
                            background.clear();
                            background.add("background 3");
                            setState(() {
                              bg1 = "assets/backgrounds/bg1.png";
                              bg2 = "assets/backgrounds/bg2.png";
                              bg3 = "assets/backgrounds/bg3_green.png";
                              bg4 = "assets/backgrounds/bg4.png";
                            });
                          },
                          icon: Image.asset(bg3),
                          label: const Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              primary: Colors.transparent),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            background.clear();
                            background.add("background 4");
                            setState(() {
                              bg1 = "assets/backgrounds/bg1.png";
                              bg2 = "assets/backgrounds/bg2.png";
                              bg3 = "assets/backgrounds/bg3.png";
                              bg4 = "assets/backgrounds/bg4_green.png";
                            });
                          },
                          icon: Image.asset(bg4),
                          label: const Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              primary: Colors.transparent),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePage(User(
                                      name: name.text,
                                      username: username.text,
                                      pronouns: pronouns.text,
                                      skill: skillLevel[0],
                                      mostInterestedIn: mostInterestedIn[0],
                                      otherGoals: otherGoal.text,
                                      bio: aboutYourself.text,
                                      background: background[0],
                                      reviews: [],
                                      profilePicture: "",
                                      savedSpots: [])
                                  // name: name.text,
                                  // username: username.text,
                                  // pronouns: pronouns.text,
                                  // skillLevel: skillLevel[0],
                                  // mostInterestedIn: mostInterestedIn[0],
                                  // // TODO: goal checklist
                                  // otherGoals: otherGoal.text,
                                  // aboutYourself: aboutYourself.text,
                                  // // TODO: whichSkater
                                  // background: background[0],
                                  )));
                          // DatabaseReference _ref =
                          //     FirebaseDatabase.instance.ref().child("Profile");
                          // _ref.push().set({
                          //   "Name": name.text,
                          //   "Username": username.text,
                          //   "Pronouns": pronouns.text,
                          //   "Skill Level": skillLevel,
                          //   "Most Interested In": mostInterestedIn,
                          //   "Goals": goalIsChecked,
                          //   "Other Goals": otherGoal.text,
                          //   "About Yourself": aboutYourself.text,
                          //   "Which Skater": whichSkater,
                          //   "Background": background
                          // });
                          // firestoreInstance.collection("Profile").add({
                          //   "Name": name.text,
                          //   "Username": username.text,
                          //   "Pronouns": pronouns.text,
                          //   "Skill Level": skillLevel,
                          //   "Most Interested In": mostInterestedIn,
                          //   "Goals": goalIsChecked,
                          //   "Other Goals": otherGoal.text,
                          //   "About Yourself": aboutYourself.text,
                          //   "Which Skater": whichSkater,
                          //   "Background": background
                          // });
                          // TODO: link to completed profile page
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => const Profile()
                          //     )
                          // );
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(color: Color(0xFF141414)),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            primary: const Color(0xFFf1c200),
                            textStyle: const TextStyle(fontFamily: 'Karla')),
                      ))
                ]),
          )
        ],
      ),
    );
  }
}