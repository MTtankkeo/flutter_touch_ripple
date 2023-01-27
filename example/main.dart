import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/components/start_on_event.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(child: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double touchSlop = 3;

    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          gestureSettings: DeviceGestureSettings(touchSlop: touchSlop),
        ),
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              child: TouchRipple(
                onTap: () {},
                longPressLowerPercent: 0,
                startOnTap: const StartOnEvent(isWait: true),
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: const Text('ABCDEFG ABCDEFG ABCDEFG ABC', style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}