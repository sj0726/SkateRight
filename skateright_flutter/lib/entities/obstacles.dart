import 'package:flutter/material.dart';

List<String> validObstacles = [
    'bank',
    'bowl',
    'bump',
    'flat_rail',
    'gap',
    'half_pipe',
    'hand_rail',
    'ledge',
    'man_pad',
    'quart_pipe',
    'spine',
    'stairs'
  ];

class Obstacles {
  
  String path = 'assets/obstacles/';
  Widget? loadObstacle(String obstacle) {
    if (!validObstacles.contains(obstacle)) return null;
    return Column(children:[ Image.asset(path + obstacle + '.png'), 
      Text(obstacle[0].toUpperCase() + obstacle.replaceAll('_', ' ').substring(1).toLowerCase(),)
    ]);
  }
}
