import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Raizz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int wt = 65;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Text(
        //   widget.title,
        //   style: const TextStyle(color: Colors.white),
        // ),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.arrow_back),
                  const SizedBox(width: 50),
                  SizedBox(
                    height: 10,
                    width: 200,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      value: 0.5,
                      minHeight: 5,
                      color: const Color(0xff5440ff),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    '1/4',
                    style: TextStyle(
                        color: Color(0xff5440ff), fontWeight: FontWeight.bold),
                  )
                ],
              )),
          const SizedBox(
            height: 25,
          ),
          const Text(
            'What\'s your weight?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text('You can always change it later',
              style: TextStyle(color: Colors.grey)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Text(wt.toString() + 'kg',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5440ff))),
                // Slider(
                //   min: 0,
                //   max: 100,
                //   value: 45,
                //   activeColor: const Color(0xff5440ff),
                //   onChanged: (value) {
                //     setState(() {
                //       // _value = value;
                //     });
                //   },
                // ),
                SlidingRuler(),
                Expanded(child: Container())
              ],
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.only(left: 7, right: 7),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 2.0,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white60,
                  offset: Offset(0, 4),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff5440ff)),
              ),
              onPressed: () {},
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class SlidingRuler extends StatefulWidget {
  @override
  _SlidingRulerState createState() => _SlidingRulerState();
}

class _SlidingRulerState extends State<SlidingRuler> {
  double _offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _offset += details.delta.dx;
        });
      },
      child: CustomPaint(
        size: Size(double.infinity, 100),
        painter: RulerPainter(offset: _offset),
      ),
    );
  }
}

class RulerPainter extends CustomPainter {
  final double offset;

  RulerPainter({required this.offset});

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    double center = 0;
    double scaleInterval = 10.0; // Distance between each scale mark
    int divisions = (width / scaleInterval).ceil();

    Paint linePaint = Paint()
      ..color = Color(0xff5440ff)
      ..strokeWidth = 2.0;

    for (int i = 0; i <= divisions; i++) {
      double x = center + (i * scaleInterval) + offset % scaleInterval;
      double y = height / 2;
      if ((i + (offset / scaleInterval).floor()).abs() % 10 == 0) {
        // Draw longer lines for major scales
        canvas.drawLine(Offset(x, y - 20), Offset(x, y + 20), linePaint);
        TextSpan span = TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 12.0),
          text: ((i + (offset / scaleInterval).floor()) * 1).toString(),
        );
        TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        // tp.layout();
        // tp.paint(canvas, Offset(x - tp.width / 2, y + 25));
      } else {
        // Draw shorter lines for minor scales
        canvas.drawLine(Offset(x, y - 10), Offset(x, y + 10), linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(RulerPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}
