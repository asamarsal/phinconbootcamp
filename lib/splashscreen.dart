import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:phinconbootcamp/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToDashboard();
  }

  _navigateToDashboard() async {
    await Future.delayed(Duration(milliseconds: 2000));
    // ignore: use_build_context_synchronously

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AnimateGradient(
              primaryColors: const [
                Color(0xFF4091FF),
                Color(0xFF4091FF),
                Color(0xFF4091FF),
              ],
              secondaryColors: const [
                Color(0xFFADCDFF),
                Color(0xFFADCDFF),
                Color(0xFFADCDFF),
              ],
              child: Container(
                decoration: const BoxDecoration(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'images/logopokeball.png',
                            width: 150,
                          ),
                          SizedBox(height: 80.0,),
                          const Text(
                            'Phincon',
                            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500,),
                          ),
                          const Text(
                            'Bootcamp',
                            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500,),
                          ),
                          SizedBox(height: 10.0,),
                          const Text(
                            '(Pokedex)',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400,),
                          ),
                        ]
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
