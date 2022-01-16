import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RecordAnimationWidget extends StatefulWidget {
  const RecordAnimationWidget({Key key}) : super(key: key);

  @override
  _RecordAnimationWidgetState createState() => _RecordAnimationWidgetState();
}

class _RecordAnimationWidgetState extends State<RecordAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Lottie.asset(
                'assets/lottie_animations/2887-listen-state.json',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
                repeat: false,
                animate: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
