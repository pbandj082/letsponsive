import 'package:flutter/material.dart';

import './orientation.dart';

class LetsponsiveScope extends InheritedWidget {
  const LetsponsiveScope({
    Key? key,
    required this.orientation,
    required Widget child,
  }) : super(key: key, child: child);

  final LetsponsiveOrientation orientation;

  @override
  bool updateShouldNotify(LetsponsiveScope oldWidget) {
    return oldWidget.orientation != orientation;
  }
}

class Letsponsive extends StatefulWidget {
  const Letsponsive({
    Key? key,
    this.mobileMaxWidth,
    this.portraitMaxWidth,
    this.mobileTextScaleFactor,
    this.portraitTextScaleFactor,
    this.landscapeTextScaleFactor,
    required this.child,
  }) : super(key: key);

  final double? mobileMaxWidth;
  final double? portraitMaxWidth;
  final double? mobileTextScaleFactor;
  final double? portraitTextScaleFactor;
  final double? landscapeTextScaleFactor;
  final Widget child;

  static LetsponsiveOrientation of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LetsponsiveScope>()!
        .orientation;
  }

  @override
  _LetsponsiveState createState() => _LetsponsiveState();
}

class _LetsponsiveState extends State<Letsponsive> {
  late MediaQueryData _media;

  double get _mediaWidth => _media.size.width;
  double get _mobileMaxWidth => widget.mobileMaxWidth ?? 700.0;
  double get _portraitMaxWidth => widget.portraitMaxWidth ?? 1300.0;
  LetsponsiveOrientation get _orientation {
    if (_mediaWidth > _portraitMaxWidth) {
      return LetsponsiveOrientation.landscape;
    }
    if (_mediaWidth > _mobileMaxWidth) {
      return LetsponsiveOrientation.portrait;
    }
    return LetsponsiveOrientation.mobile;
  }

  double? get _textScaleFactor {
    switch (_orientation) {
      case LetsponsiveOrientation.landscape:
        return widget.landscapeTextScaleFactor;
      case LetsponsiveOrientation.portrait:
        return widget.portraitTextScaleFactor;
      case LetsponsiveOrientation.mobile:
        return widget.mobileTextScaleFactor;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _media = MediaQuery.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return LetsponsiveScope(
      orientation: _orientation,
      child: MediaQuery(
        data: _media.copyWith(textScaleFactor: _textScaleFactor),
        child: widget.child,
      ),
    );
  }
}
