import '../entities/spot.dart';

final _comments = [
  Comment(
      id: "0000",
      user: "Grapple",
      description: "Great place.",
      isReview: true,
      score: 5),
  Comment(
    id: "0001",
    user: "AppleSeed",
    description: "Haven't been, seems cool.",
    isReview: true,
    score: 4,
  ),
  Comment(
    id: "0005",
    user: "Johnny",
    description:
        "One of the greatest places I've ever been in my life. If you haven't checked it out you honestly have to the food here is amazing and all that but what really sets it apart is the ambiance, honestly a hidden gem.",
    isReview: true,
    score: 4,
  ),
  Comment(id: "0002", user: "user2", description: "Haven't been, seems cool."),
  Comment(id: "0003", user: "user3", description: "Haven't been, seems cool."),
  Comment(id: "0004", user: "user4", description: "Haven't been, seems cool."),
];

final _picsGSU = [
  'assets/images/gsu1.jpg',
  'assets/images/gsu2.jpg',
  'assets/images/gsu3.jpg',
  'assets/images/gsu4.jpg',
  // 'https://www.bu.edu/meetatbu/files/2014/07/503678580503_0_bg.jpg',
  // 'https://www.bu.edu/files/2020/11/resized-20-1472-GSURRENO-074.jpg',
  // 'https://i0.wp.com/bunewsservice.com/wp-content/uploads/2019/01/shadow-boxes-Ann-9.jpg?resize=810%2C608',
  // 'https://www.bu.edu/cpo/files/2010/10/GSU_After_1.jpg',
];

final fakeSpot1 = Spot(
  id: "GSU",
  title: "George Sherman Union",
  score: 5.0,
  comments: _comments,
  pictures: _picsGSU,
  obstacles: ["ramp", "rail", "bump", "flat"],
  latitude: 42.350669405851505,
  longitude: -71.11207366936073,
);

final fakeSpot = Spot(
  id: "LFS",
  title: 'Lynch Family Skatepark',
  score: 5.0,
  comments: _comments,
  pictures: _picsLFS,
  obstacles: ["ramp", "rail", "bump", "flat"],
  latitude: 42.35111488978059,
  longitude: -71.10889075787007,
);

final _picsLFS = [
  'assets/images/lynch1.jpg',
  'assets/images/lynch2.jpg',
  'assets/images/lynch3.jpg',
  'assets/images/lynch4.jpg',
  'assets/images/lynch5.jpg',

  // "https://345v4845f1o72rvbx12u5xsh-wpengine.netdna-ssl.com/wp-content/uploads/2016/07/0706PeoplePlace_LynchFamilySkateparkPC.jpg",
  // "https://i.pinimg.com/originals/c3/3e/9f/c33e9fe702f6ea33833539dea774b60f.jpg",
  // "https://i.ytimg.com/vi/JDfUfrI_EFI/maxresdefault.jpg",
  // "https://images.squarespace-cdn.com/content/v1/54543035e4b0b65b3fa91f52/1447728417023-7ST26WFKKQTJD9MT67XZ/3C4A9308.jpg",
  // "https://blog.skateboard.com.au/images/lynchfamily1.jpg",
];
