import 'package:flutter/material.dart';
import 'package:page_route_transition/page_route_transition.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({super.key});

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SafeArea(
                  child: Align(
                  alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () async {
                        PageRouteTransition.effect = TransitionEffect.bottomToTop;
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 80,
                        color: Colors.transparent,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 25.0),
                            ),
                            Text('Back', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Detail Pokemon', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ]
          ),
        ),
    );
  }
}
