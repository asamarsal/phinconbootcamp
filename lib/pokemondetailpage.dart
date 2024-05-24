import 'package:flutter/material.dart';
import 'package:page_route_transition/page_route_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({super.key});

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {

  String pokemonName = '';
  String pokemonImage = '';

  Future<void> _loadPokemonData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pokemonName = prefs.getString('pokemon_name') ?? 'Unknown';
      pokemonImage = prefs.getString('pokemon_image') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPokemonData();
  }

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
                              child: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 25.0),
                            ),
                            Text('Back', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text('Detail Pokemon', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          width: 200.0,
                          height: 200.0,
                          child: pokemonImage.isNotEmpty
                              ? Image.network(pokemonImage, fit: BoxFit.cover,)
                              : Image.asset('images/logopokeball.png'),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Nama Pokemon  :',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(
                                          pokemonName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Nama Pokemon  :',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(
                                          'Charizard',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Nama Pokemon  :',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(
                                          'Charizard',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Nama Pokemon  :',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Text(
                                          'Charizard',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
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
