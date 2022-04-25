import 'dart:ui';
import 'package:flutter/material.dart';

/**
 * Sets a bunch of defaults for consistent animation + popup layouts  
 * Used in map_page onTap() to display details on skate spots
 */

/// Custom [PageRoute] that creates an overlay dialog (popup effect).
///
/// Best used with a [Hero] animation.
/// {@endtemplate}
class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false; // Allows background to be visible

  @override
  bool get barrierDismissible => true; // Tapping away from popup closes it

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => false; // ?:Keep popup state in memory

  @override
  Color get barrierColor => Colors.black54; // black54 = translucent black

  @override
  /* Simple slide-up animation */
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
    // return super.buildTransitions(context, animation, secondaryAnimation, child);
    // return child; // adds no animation
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}
