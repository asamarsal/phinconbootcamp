import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Map<String, dynamic>? dataResponse;

class _HomePageState extends State<HomePage> {

  Color mainColor = const Color(0xFF3E90FF);
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: const [
          PokemonlistPage(),
          MypokemonPage(),
          PokemondetailPage(),
        ],
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style3,

      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.arrow_2_circlepath_circle),
        title: ("Pokemon List"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.antenna_radiowaves_left_right),
        title: ("Pokemon Detail"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.arrow_up_bin),
        title: ("My Pokemon"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}

class PokemonlistPage extends StatefulWidget {
  const PokemonlistPage({super.key});

  @override
  State<PokemonlistPage> createState() => _PokemonlistPageState();
}
class _PokemonlistPageState extends State<PokemonlistPage> {

  List<String> dropdownItems = [];
  List<Map<String, dynamic>> listViewItems = [];
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  bool isLoadingDropdown = true;
  bool isLoadingListView = true;

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
    fetchListViewData();
  }

  Future<void> fetchDropdownData() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50')); // Change limit as per your requirement

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> dropdownPokemonList = List<String>.from(data['results'].map((pokemon) => pokemon['name']));
      setState(() {
        dropdownItems = dropdownPokemonList;
        isLoadingDropdown = false;
      });
    } else {
      throw Exception('Failed to load Pokemon data for dropdown');
    }
  }

  Future<void> fetchListViewData() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50')); // Change limit as per your requirement

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> listViewPokemonList = List<Map<String, dynamic>>.from(data['results']);
      setState(() {
        listViewItems = listViewPokemonList;
        isLoadingListView = false;
      });
    } else {
      throw Exception('Failed to load Pokemon data for list view');
    }
  }

  Future<String> fetchPokemonImageUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['sprites']['front_default'];
    } else {
      throw Exception('Failed to load Pokemon image');
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              //Text Atas
              Container(
                color: Colors.transparent,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 80.0,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan teks ke kiri
                  children: [
                    Text(
                      'Cari Informasi Tentang',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      'Semua Pokemon',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.blue,
                child: isLoadingDropdown
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(
                          'Pilih Pokemon',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: dropdownItems
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // ListView
              const SizedBox(height: 20), // Add spacing between dropdown and list view
              Expanded(
                child: isLoadingListView
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: listViewItems.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<String>(
                      future: fetchPokemonImageUrl(listViewItems[index]['url']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListTile(
                            title: Text(listViewItems[index]['name']),
                            leading: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            title: Text(listViewItems[index]['name']),
                            leading: Icon(Icons.error),
                          );
                        } else {
                          return ListTile(
                            title: Text(listViewItems[index]['name']),
                            leading: Image.network(snapshot.data ?? ''),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PokemondetailPage extends StatefulWidget {
  const PokemondetailPage({super.key});

  @override
  State<PokemondetailPage> createState() => _PokemondetailPageState();
}
class _PokemondetailPageState extends State<PokemondetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child:
        Column(
          children: [
            const Text('Back', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        ),
      ),
    );
  }
}

class MypokemonPage extends StatefulWidget {
  const MypokemonPage({super.key});

  @override
  State<MypokemonPage> createState() => _MypokemonPageState();
}
class _MypokemonPageState extends State<MypokemonPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child:
        Column(
          children: [
            const Text('Back', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        ),
      ),
    );
  }
}