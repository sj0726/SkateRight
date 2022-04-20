import 'package:flutter/material.dart';
import 'package:skateright_flutter/styles/skate_theme.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Make New Profile',
      theme: skateTheme,
      home: const Scaffold(
        body: CreateProfileForm(),
        backgroundColor: Color(0xFF141414), // skate_theme.dart sBlack
      ),
    );
  }
}

// enum SkillLevel {beginner, intermediate, advanced, pro}
// enum MostInterestedIn {streetSkating, learningTricks, justHangingOut, vibes}

class CreateProfileForm extends StatefulWidget {
  const CreateProfileForm({Key? key}) : super(key: key);

  @override
  State<CreateProfileForm> createState() => _CreateProfileForm();
}

class _CreateProfileForm extends State<CreateProfileForm> {
  List<bool> goalIsChecked = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF94B321))
              ),
          border: OutlineInputBorder(),
                labelText: "What's your name?",
                labelStyle: TextStyle(
                  color: Color(0xFFf0e6d0)
                ),
              )
          ),
        ),

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF94B321))
              ),
              border: OutlineInputBorder(),
              labelText: "Pronouns?",
              labelStyle: TextStyle(
                color: Color(0xFFf0e6d0)
              )
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Skill level?",
                style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 18
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                    "I'm new here",
                  style: TextStyle(color: Color(0xFF94B321)),
                ),
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Color(0xFF94B321)),
                    primary: Colors.transparent,
                    textStyle: const TextStyle(
                    fontFamily: 'Karla'
                  )
                ) // style
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Beginner",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Intermediate",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Advanced",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Basically a pro",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
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
                  "What are you most interested in?",
                style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 18
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Street skating",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Skating for transportation",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Learning new tricks",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Fun skate session",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Meeting new people",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Hanging out with friends",
                    style: TextStyle(color: Color(0xFF94B321)),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFF94B321)),
                      primary: Colors.transparent,
                      textStyle: const TextStyle(
                          fontFamily: 'Karla'
                      )
                  ) // style
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
                style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 18
                ),
              ),
              ListTile(
                title: const Text("Get on the board"),
                leading: Checkbox(
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
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF94B321))
                ),
                border: OutlineInputBorder(),
                labelText: "Other goal:",
                labelStyle: TextStyle(
                    color: Color(0xFFf0e6d0)
                )
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF94B321))
                ),
                border: OutlineInputBorder(),
              labelText: "Tell us about yourself!",
              labelStyle: TextStyle(
                color: Color(0xFFf0e6d0)
              )
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Which skater are you?",
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 18
                ),
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('assets/figures/skater1-white.png'),
                  label: const Text(""),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  side: const BorderSide(
                    color: Color(0xFFf0e6d0)
                  ),
                  primary: Colors.transparent
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/figures/skater2-white.png'),
                label: const Text(""),
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: const BorderSide(
                        color: Color(0xFFf0e6d0)
                    ),
                    primary: Colors.transparent
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/figures/skater3-white.png'),
                label: const Text(""),
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: const BorderSide(
                        color: Color(0xFFf0e6d0)
                    ),
                    primary: Colors.transparent
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/figures/skater4-white.png'),
                label: const Text(""),
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: const BorderSide(
                        color: Color(0xFFf0e6d0)
                    ),
                    primary: Colors.transparent
                ),
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
                "Choose your favorite pattern",
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 18
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/backgrounds/background1.png'),
                label: const Text(""),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                    primary: Colors.transparent
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/backgrounds/background2.png'),
                label: const Text(""),
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    primary: Colors.transparent
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/backgrounds/background3.png'),
                label: const Text(""),
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    primary: Colors.transparent
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/backgrounds/background4.png'),
                label: const Text(""),
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    primary: Colors.transparent
                ),
              ),
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
                      onPressed: () {},
                      child: const Text(
                          "Done",
                        style: TextStyle(color: Color(0xFF141414)),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFf1c200),
                        textStyle: const TextStyle(fontFamily: 'Karla')
                      ),
                    )
                )
              ]
          ),
        )

      ]
    );
  }
}

// ElevatedButton(
// onPressed: () {},
// child: const Text(
// "Meeting new people",
// style: TextStyle(color: Color(0xFF94B321)),
// ),
// style: ElevatedButton.styleFrom(
// shape: const StadiumBorder(),
// side: const BorderSide(color: Color(0xFF94B321)),
// primary: Colors.transparent,
// textStyle: const TextStyle(
// fontFamily: 'Karla'
// )
// ) // style
// )