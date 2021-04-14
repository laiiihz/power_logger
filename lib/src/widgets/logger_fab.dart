import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:power_logger/power_logger.dart';
import 'package:power_logger/src/power_logger_view.dart';

class LoggerFab extends StatefulWidget {
  final Alignment initAlignment;
  LoggerFab({Key? key, this.initAlignment = Alignment.center})
      : super(key: key);

  @override
  LoggerFabState createState() => LoggerFabState();
}

class LoggerFabState extends State<LoggerFab>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Alignment _dragAlignment;
  late Animation<Alignment> _animation;
  final _spring =
      const SpringDescription(mass: 15, stiffness: 1000, damping: 0.7);
  Alignment get alignment => _dragAlignment;

  bool opened = false;

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
    _animation = _animationController!.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: calcAlignment,
      ),
    );

    final simulation =
        SpringSimulation(_spring, 0, 1, _normalizeVelocity(velocity, size));

    _animationController!.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _dragAlignment = widget.initAlignment;
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
      child: GestureDetector(
        onPanStart: (details) => _animationController!.stop(canceled: true),
        onPanUpdate: (details) => setState(() => _dragAlignment += Alignment(
              details.delta.dx / (size.width / 2),
              details.delta.dy / (size.height / 2),
            )),
        onPanEnd: (details) =>
            _runAnimation(details.velocity.pixelsPerSecond, size),
        onTap: () async {
          if (!opened) {
            opened = true;
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PowerLoggerView()),
            );
            opened = false;
          } else {
            opened = false;
            Navigator.pop(context);
          }
        },
        child: const _FabButton(),
      ),
    );
  }
}

class _FabButton extends StatelessWidget {
  const _FabButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            color: Colors.black12,
            blurRadius: 4,
          )
        ],
      ),
      height: 48,
      width: 48,
      child: Icon(
        Icons.code,
        color: Colors.white70,
      ),
    );
  }
}
