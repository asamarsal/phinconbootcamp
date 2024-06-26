import 'package:audioplayers/audioplayers.dart';
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
  String pokemonWeight = '';
  String pokemonHeight = '';
  String pokemonVoice = '';
  String pokemonVoicetwo = '';

  Future<void> _loadPokemonData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pokemonName = prefs.getString('pokemon_name') ?? 'Unknown';
      pokemonWeight = prefs.getString('pokemon_weight') ?? 'Unknown';
      pokemonHeight = prefs.getString('pokemon_height') ?? 'Unknown';
      pokemonVoice = prefs.getString('pokemon_voice') ?? 'Unknown';
      pokemonVoicetwo = prefs.getString('pokemon_voicetwo') ?? 'Unknown';
      pokemonImage = prefs.getString('pokemon_image') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPokemonData();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playNetworkAudio() {
    _audioPlayer.play(
      UrlSource(pokemonVoice),
    );
  }

  void _playNetworkAudiotwo() {
    _audioPlayer.play(
      UrlSource(pokemonVoicetwo),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.lightBlue.shade500,
                                  Colors.lightBlue.shade200,
                                  Colors.lightBlue.shade50,
                                  Colors.lightBlue.shade200,
                                  Colors.lightBlue.shade500
                                ]
                            ),
                          ),
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
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: const Text(
                                            'Nama Pokemon  :',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: Text(
                                            pokemonName,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Berat Pokemon  :',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: Text(
                                            '${pokemonWeight} pounds',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Tinggi Pokemon  :',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                            child: Text(
                                              '${pokemonHeight}0 cm',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                              ),
                                            ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.0,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                              color: Colors.lightBlue.shade100,
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Suara Pokemon  :',
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0,),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8)
                                              ),
                                            ),
                                            onPressed: _playNetworkAudio,
                                            child: const Text('Suara 1'),
                                          ),
                                          SizedBox(width: 10.0,),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                            ),
                                            onPressed: _playNetworkAudiotwo,
                                            child: const Text('Suara 2'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
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
