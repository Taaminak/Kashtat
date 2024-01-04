import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveDemoHomePage extends StatefulWidget {
  const WaveDemoHomePage({Key? key}) : super(key: key);


  @override
  _WaveDemoHomePageState createState() => _WaveDemoHomePageState();
}

class _WaveDemoHomePageState extends State<WaveDemoHomePage> {
  _buildCard({
    required Config config,
    Color? backgroundColor = Colors.transparent,
    DecorationImage? backgroundImage,
    double height = 280.0,
  }) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: WaveWidget(
        config: config,
        backgroundColor: backgroundColor,
        backgroundImage: backgroundImage,
        size: const Size(double.infinity, double.infinity),
        waveAmplitude: 10,

      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          _buildCard(
            backgroundColor: Colors.transparent,
            config: CustomConfig(
              gradients: [
                [Color(0xffC04B3E), Color(0xff724FAA)],
                [Color(0xffC04B3E), Color(0x77E57373)],
                [Color(0xffE8470A), Color(0xff7950B9)],
                [Color(0xffC04B3E), Color(0xff2A1B8C)]
              ],
              durations: [35000, 19440, 10800, 6000],
              heightPercentages: [0.10, 0.14, 0.15, 0.15],
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
          ),
        ],
      ),
    );
  }
}