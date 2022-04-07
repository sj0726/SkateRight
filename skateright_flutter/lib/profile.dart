import 'package:flutter/material.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Make New Profile',
      home: const Scaffold(
        body:
        CreateProfileForm(),
      ),
      theme: ThemeData(
          backgroundColor: const Color.fromARGB(255, 20, 20, 20)
      )
    );
  }
}

enum SkillLevel {beginner, intermediate, advanced, pro}
enum MostInterestedIn {streetSkating, learningTricks, justHangingOut, vibes}

class CreateProfileForm extends StatefulWidget {
  const CreateProfileForm({Key? key}) : super(key: key);

  @override
  State<CreateProfileForm> createState() => _CreateProfileForm();
}

class _CreateProfileForm extends State<CreateProfileForm> {
  SkillLevel? _skillLevel = SkillLevel.beginner;
  MostInterestedIn? _mostInterestedIn = MostInterestedIn.streetSkating;
  List<bool> goalIsChecked = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "What's your name?"
              )
          ),
        ),

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Pronouns?"
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("What's your skill level?"),
              ListTile(
                title: const Text("I'm new here"),
                leading: Radio<SkillLevel> (
                  value: SkillLevel.beginner,
                  groupValue: _skillLevel,
                  onChanged: (SkillLevel? value) {
                    setState(() {
                      _skillLevel = value;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text("Intermediate"),
                leading: Radio<SkillLevel> (
                  value: SkillLevel.intermediate,
                  groupValue: _skillLevel,
                  onChanged: (SkillLevel? value) {
                    setState(() {
                      _skillLevel = value;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text("Advanced"),
                leading: Radio<SkillLevel> (
                  value: SkillLevel.advanced,
                  groupValue: _skillLevel,
                  onChanged: (SkillLevel? value) {
                    setState(() {
                      _skillLevel = value;
                    });
                  },
                ),
              ),
              
              ListTile(
                title: const Text("Basically a pro"),
                leading: Radio<SkillLevel> (
                  value: SkillLevel.pro,
                  groupValue: _skillLevel,
                  onChanged: (SkillLevel? value) {
                    setState(() {
                      _skillLevel = value;
                    });
                  },
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
              const Text("What are you most interested in?"),
              ListTile(
                title: const Text("Street skating"),
                leading: Radio<MostInterestedIn> (
                  value: MostInterestedIn.streetSkating,
                  groupValue: _mostInterestedIn,
                  onChanged: (MostInterestedIn? value) {
                    setState(() {
                      _mostInterestedIn = value;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text("Learning tricks"),
                leading: Radio<MostInterestedIn> (
                  value: MostInterestedIn.learningTricks,
                  groupValue: _mostInterestedIn,
                  onChanged: (MostInterestedIn? value) {
                    setState(() {
                      _mostInterestedIn = value;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text("Just hanging out"),
                leading: Radio<MostInterestedIn> (
                  value: MostInterestedIn.justHangingOut,
                  groupValue: _mostInterestedIn,
                  onChanged: (MostInterestedIn? value) {
                    setState(() {
                      _mostInterestedIn = value;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text("I'm here for the vibes"),
                leading: Radio<MostInterestedIn> (
                  value: MostInterestedIn.vibes,
                  groupValue: _mostInterestedIn,
                  onChanged: (MostInterestedIn? value) {
                    setState(() {
                      _mostInterestedIn = value;
                    });
                  },
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
              const Text("What are your goals?"),
              ListTile(
                title: const Text("Get on the board"),
                leading: Checkbox(
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
                  value: goalIsChecked[5],
                  onChanged: (bool? value) {
                    setState(() {
                      goalIsChecked[5] = value!;
                    });
                  },
                ),
              )
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Add a bit about yourself"
            ),
          ),
        )
      ]
    );
  }
}