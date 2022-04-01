import 'package:flutter/material.dart';
import 'package:map_app/styles/skate_theme.dart';
import 'spot.dart';

class SpotPopupCard extends StatelessWidget {
  const SpotPopupCard({Key? key, required this.spot}) : super(key: key);
  final Spot spot;

  @override
  Widget build(BuildContext context) {
    /// TODO: Find a way to add a RectTween to hero to get an animation to play
    /// Possible solution - wrap [_SpotPopupCard] in a Gesture widget
    ///   set onTap: this, child: rectTween
    return FractionallySizedBox(
      alignment: Alignment.bottomCenter,
      heightFactor: .85,
      child: Hero(
        tag: spot.id,
        child: Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 32.0,
              left: 16.0,
              right: 16.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                // Begin Spot info widgets
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DetailsAndPhoto(spot: spot), // Contains title + photo stack or row
                  // const SizedBox(height: 12),

                  const _Interactions(),
                  const SizedBox(height: 12),

                  _Obstacles(), // Call with spot.obstacles
                  const SizedBox(height: 12),

                  _SpotComments(comments: spot.comments!),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsAndPhoto extends StatelessWidget {
  const _DetailsAndPhoto({Key? key, required this.spot}) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
            child: _SpotTitle(
              title: spot.title,
            ),
            flex: 3),
        if (spot.pictures != null) ...[
          Flexible(
            flex: 2,
            child: Padding(
              // Consider changing padding scheme to flexible + middle child in row
              padding: const EdgeInsets.only(left: 32),
              child: _SpotPhoto(spot: spot),
            ),
          ),
        ],
      ],
    );
  }
}

class _SpotTitle extends StatelessWidget {
  const _SpotTitle({Key? key, required this.title}) : super(key: key);

  final String title;
  final TextStyle style = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.white,
      fontStyle: FontStyle.normal);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.left,
        ),
        Text(
          'Type of location',
          // style: 
          style: Theme.of(context).textTheme.headline2!.copyWith(color: sYellow),
          textAlign: TextAlign.left,
        ),
        Text(
          "Address",
          style: Theme.of(context).textTheme.bodyText1,
          
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class _SpotPhoto extends StatelessWidget {
  const _SpotPhoto({Key? key, required this.spot}) : super(key: key);

  final Spot spot; // Guaranteed non-null due to check in caller

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {Navigator.of(context).pop()},
        child: Image(
          image: NetworkImage(spot.pictures![0]),
          fit: BoxFit.cover,
        ));
  }
}


class _Interactions extends StatelessWidget {
  const _Interactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.favorite_border_outlined, color: Colors.red),
        const SizedBox(width: 12),
        const Icon(Icons.star_border_outlined, color: Colors.green),
        const SizedBox(width: 12),
        const Icon(Icons.photo_camera_outlined, color: Colors.grey)
      ],
    );
  }
}


class _Obstacles extends StatelessWidget {
  const _Obstacles({Key? key}) : super(key: key);

  // final List<String> obstacles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Obstacles',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.access_alarm, color: Colors.blueAccent),
            const SizedBox(width: 12),
            const Icon(
              Icons.square_outlined,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 12),
            const Icon(Icons.circle_outlined, color: Colors.blueAccent)
          ],
        ),
      ],
    );
  }
}

/// Formats comments/reviews
class _SpotComments extends StatelessWidget {
  const _SpotComments({Key? key, required this.comments}) : super(key: key);

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (final cmnt in comments) _SpotCommentTile(comment: cmnt),
    ]);
  }
}

/// Formats individual comments as they appear in the list of comments
/// Called by [_SpotComments]
class _SpotCommentTile extends StatelessWidget {
  const _SpotCommentTile({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    Icon trailing = const Icon(Icons.favorite, color: Colors.transparent);
    if (comment.isReview) {
      trailing = const Icon(Icons.favorite, color: Colors.red);
    }

    return ListTile(
      leading: const Icon(Icons.person, color: Colors.blue),
      trailing: trailing,
      title: Text(comment.user),
      subtitle: Text(comment.description),
      // tileColor: Colors.grey[300],
      minVerticalPadding: 13,
    );
  }
}

