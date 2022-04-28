import 'dart:math';

import 'package:flutter/material.dart';

/* Should be stored in a config file which loads from db on app start, see search_bar.dart */
final List<String> obstacles = ['Park', 'Street', 'Ramps', 'Flat', 'Rails'];
final obSelects = {};

class ObstacleSelection extends StatelessWidget {
  const ObstacleSelection({
    Key? key,
  }) : super(key: key);

  // Converts options list into a map... note: bad for desired stair implementation

  void _initSelections() {
    // obSelects ??= {};

    for (var opt in obstacles) {
      if (!obSelects.containsKey(opt)) {
        obSelects[opt] = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    List<IconData> iconics = [
      Icons.square_outlined,
      Icons.circle_outlined,
      Icons.polyline,
      Icons.landscape_outlined,
      Icons.crop_square,
      Icons.texture_outlined,
      Icons.bar_chart_outlined,
    ];
    _initSelections();
    var size = MediaQuery.of(context).size;
    return StatefulBuilder(
      builder: ((context, setState) {
        return GridView.count(
          // mainAxisSpacing: size.height / 20,
          crossAxisCount: 3,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: obSelects.keys.map((key) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  key,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                IconButton(
                  icon: Icon(iconics[random.nextInt(iconics.length)],
                      size: 30, color: Colors.white),
                  onPressed: () => setState(() => (obSelects[key] == 1)
                      ? obSelects[key] = 0
                      : obSelects[key] = 1),
                ),
                Checkbox(
                  value: obSelects[key] == 1 ? true : false,
                  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                  checkColor: Colors.transparent,
                  onChanged: (flag) {
                    setState(
                      () => obSelects[key] = flag! ? 1 : 0,
                    );
                  },
                ),
              ],
            );
          }).toList(),
        );
      }),
    );
  }
}

//   return CheckboxListTile(
//     title: Text(key),
//     value: obSelects[key] == 1 ? true : false,
//     onChanged: (flag) {
//       setState(
//         () => obSelects[key] = flag! ? 1 : 0,
//       );
//     },
//     controlAffinity: ListTileControlAffinity.,
//   );
// },
