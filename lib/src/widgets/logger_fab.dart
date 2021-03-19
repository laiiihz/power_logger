import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:power_logger/src/power_logger_view.dart';

class LoggerFab extends StatefulWidget {
  LoggerFab({Key key}) : super(key: key);

  @override
  _LoggerFabState createState() => _LoggerFabState();
}

class _LoggerFabState extends State<LoggerFab>
    with SingleTickerProviderStateMixin {
  bool showSubPage = false;
  AnimationController _animationController;
  var _dragAlignment = Alignment.center;
  Animation<Alignment> _animation;
  final _spring =
      const SpringDescription(mass: 15, stiffness: 1000, damping: 0.7);

  double _normalizeVelocity(Offset velocity, Size size) {
    final normalizedVelocity = Offset(
      velocity.dx / size.width,
      velocity.dy / size.height,
    );
    return -normalizedVelocity.distance;
  }

  void _runAnimation(Offset velocity, Size size) {
    Alignment calcAlignment = _dragAlignment;
    if (_dragAlignment.x < 0) calcAlignment = Alignment(-0.9, calcAlignment.y);
    if (_dragAlignment.x >= 0) calcAlignment = Alignment(0.9, calcAlignment.y);
    if (_dragAlignment.y >= 0.9)
      calcAlignment = Alignment(calcAlignment.x, 0.9);
    if (_dragAlignment.y <= -0.9)
      calcAlignment = Alignment(calcAlignment.x, -0.9);
    _animation = _animationController.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: calcAlignment,
      ),
    );

    final simulation =
        SpringSimulation(_spring, 0, 1, _normalizeVelocity(velocity, size));

    _animationController.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this)
      ..addListener(() => setState(() => _dragAlignment = _animation.value));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: _dragAlignment,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: showSubPage ? 0 : 1,
        child: GestureDetector(
          onPanStart: (details) => _animationController.stop(canceled: true),
          onPanUpdate: (details) => setState(() => _dragAlignment += Alignment(
                details.delta.dx / (size.width / 2),
                details.delta.dy / (size.height / 2),
              )),
          onPanEnd: (details) =>
              _runAnimation(details.velocity.pixelsPerSecond, size),
          onTap: showSubPage
              ? null
              : () async {
                  showSubPage = true;
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PowerLoggerView()),
                  );
                  showSubPage = false;
                },
          child: const _FabButton(),
        ),
      ),
    );
  }
}

class _FabButton extends StatelessWidget {
  const _FabButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.4),
          borderRadius: BorderRadius.circular(25),
        ),
        height: 50,
        width: 50,
        child: Icon(
          Icons.code,
          color: Colors.white70,
        ),
      ),
    );
  }
}
