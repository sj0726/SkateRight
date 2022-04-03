import 'dart:math';

import 'package:flutter/material.dart';
import 'package:map_app/styles/skate_theme.dart';
import '../spot.dart';

int maxSize = 50;

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
  late String previewText;
  late String hiddenText;
  late Comment review; // replaces widget.review with review... legibility
  bool expanded = false;

  @override
  void initState() {
    super.initState();
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
      leading: const CircleAvatar(
        backgroundColor: sCream,
      ),
      title: Text(
        review.user,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subtitle: hiddenText.isEmpty
          ? Text(previewText, style: Theme.of(context).textTheme.bodyText2, textAlign: TextAlign.start,)
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
