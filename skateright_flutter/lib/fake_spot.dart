import 'spot.dart';

final _comments = [
  Comment(
      id: "0000",
      user: "Grapple",
      description: "Great place.",
      isReview: true,
      score: 5),
  Comment(id: "0001", user: "AppleSeed", description: "Haven't been, seems cool."),
  Comment(id: "0001", user: "AppleSeed", description: "Haven't been, seems cool."),
  Comment(id: "0001", user: "AppleSeed", description: "Haven't been, seems cool."),
  Comment(id: "0001", user: "AppleSeed", description: "Haven't been, seems cool."),

];

final _pictures = [
 'https://www.bu.edu/meetatbu/files/2014/07/503678580503_0_bg.jpg',
  'https://www.bu.edu/files/2020/11/resized-20-1472-GSURRENO-074.jpg',
  'https://i0.wp.com/bunewsservice.com/wp-content/uploads/2019/01/shadow-boxes-Ann-9.jpg?resize=810%2C608',
  'https://www.bu.edu/cpo/files/2010/10/GSU_After_1.jpg',
];

final fakeSpot = Spot(
  id: "GSU",
  title: "George Sherman Union",
  score: 5.0,
  comments: _comments,
  pictures: _pictures,
  obstacles: ["ramp", "rail", "bump", "flat"],
);
