import 'dart:math';

import 'package:flutter/material.dart';
import 'package:map_app/styles/skate_theme.dart';
import '../spot.dart';

int maxSize = 80; // Max char length of review text preview

// Stateful required for "tap to see more"... expanding to read full review
class ReviewCard extends StatefulWidget {
  const ReviewCard({Key? key, required this.review, this.tile = false})
      : super(key: key);

  final Comment review;
  final bool tile; // marks if displayed in generic info page

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  final double _profileRadius = 26.0;
  late String previewText;
  late String hiddenText;
  late Comment review; // replaces widget.review with review... legibility
  bool expanded = false;

  final _random = new Random();
  List<Color> colors = [sCream, sLightGreen, sYellow, sDarkGreen,];
  List<Image> profilePics = [];

  Color _chooseColor() {
    return colors[_random.nextInt(colors.length)];
  }

  Image _chooseProfilePic() {
    return profilePics[_random.nextInt(profilePics.length)];
  }

  void _loadProfilePics() {
    profilePics.add(Image.asset(
      'assets/figures/skater1.png',
      height: 28 * 1.5,
    ));
    profilePics
        .add(Image.asset('assets/figures/skater2.png', height: _profileRadius * 1.60));
    profilePics
        .add(Image.asset('assets/figures/skater3.png', height: _profileRadius * 1.60));
    profilePics
        .add(Image.asset('assets/figures/skater4.png', height: _profileRadius * 1.60));
  }

  @override
  void initState() {
    super.initState();

    _loadProfilePics();

    review = widget.review;

    if (review.description.length > maxSize) {
      previewText = review.description.substring(0, maxSize);
      hiddenText =
          review.description.substring(maxSize, review.description.length);
      expanded = true;
    } else {
      previewText = review.description;
      hiddenText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: sBlack,
      leading: CircleAvatar(
        radius: _profileRadius,
        backgroundColor: _chooseColor(),
        child: ClipOval(
          child: _chooseProfilePic(),
        ),
      ),
      title: Text(
        review.user,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subtitle: hiddenText.isEmpty
          ? Text(
              previewText,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.start,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  expanded ? (previewText + "...") : (previewText + hiddenText),
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.start,
                ),
                InkWell(
                  // Nest in row for end axis alignment?
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        expanded ? "show more" : "show less",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(
                      () {
                        expanded = !expanded;
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }
}
