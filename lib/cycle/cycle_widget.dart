import '../components/cycle2_widget.dart';
import '../components/menstrual_flow_widget.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CycleWidget extends StatefulWidget {
  const CycleWidget({Key key}) : super(key: key);

  @override
  _CycleWidgetState createState() => _CycleWidgetState();
}

class _CycleWidgetState extends State<CycleWidget> {
  DateTimeRange calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Cycle2Widget(),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/No_way_for_Ambulance.png',
                      ).image,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 30),
                    child: FlutterFlowCalendar(
                      color: FlutterFlowTheme.tertiaryColor,
                      iconColor: Color(0xFFFEFEFE),
                      weekFormat: false,
                      weekStartsMonday: false,
                      onChange: (DateTimeRange newSelectedDate) {
                        setState(() => calendarSelectedDay = newSelectedDate);
                      },
                      titleStyle: TextStyle(
                        color: Color(0xFFFEFEFE),
                      ),
                      dayOfWeekStyle: TextStyle(
                        color: Color(0xFF52B1EF),
                      ),
                      dateStyle: TextStyle(
                        color: Color(0xFFFEFEFE),
                        fontWeight: FontWeight.w500,
                      ),
                      selectedDateStyle: TextStyle(
                        color: Color(0xC4050E6A),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
                      inactiveDateStyle: FlutterFlowTheme.subtitle1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF77BF18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                child: MenstrualFlowWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
