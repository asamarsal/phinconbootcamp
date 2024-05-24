import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:http/http.dart' as http;
import 'package:phinconbootcamp/pokemondetailpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1000')); // Change limit as per your requirement

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
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1000'));

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

  Future<String> fetchPokemonWeights(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['weight'].toString();
    } else {
      throw Exception('Failed to load Pokemon weight');
    }
  }
  Future<String> fetchPokemonHeights(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['height'].toString();
    } else {
      throw Exception('Failed to load Pokemon weight');
    }
  }

  Future<void> savePokemonData(String name, String imageUrl, String weight, String height) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pokemon_name', name);
    await prefs.setString('pokemon_image', imageUrl);
    await prefs.setString('pokemon_weight', weight);
    await prefs.setString('pokemon_height', height);

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
                child: isLoadingDropdown
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                    children: [
                      Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
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
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 50,
                              width: double.infinity,
                            ),
                            dropdownStyleData: const DropdownStyleData(
                              maxHeight: 240,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Cari Pokemon Anda...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return item.value.toString().contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  'Nama Pokemon',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Expanded(
              child: isLoadingListView
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    itemCount: listViewItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {

                          String name = listViewItems[index]['name'];
                          String imageUrl = await fetchPokemonImageUrl(listViewItems[index]['url']);
                          String weight = await fetchPokemonWeights(listViewItems[index]['url']);
                          String height = await fetchPokemonHeights(listViewItems[index]['url']);

                          await savePokemonData(name, imageUrl, weight, height);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PokemonDetail()
                            ),
                          );
                        },

                        child: Container(
                          height: 70.0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.lightBlue.shade100,
                                    Colors.lightBlue.shade500,
                                    Colors.lightBlue.shade900
                                  ]
                              ),
                          ),
                          child: FutureBuilder<String>(
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
                                  title: Row(
                                    children: [
                                      Image.network(
                                        snapshot.data ?? '',
                                        width: 50,
                                        height: 50,
                                      ),
                                      Spacer(),
                                      Text(
                                        listViewItems[index]['name'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
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