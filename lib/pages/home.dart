import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? pokemonData;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchPokemons();
    }
  }

  Future<void> fetchPokemons() async {
    var url = Uri.https('raw.githubusercontent.com',
        "/Biuni/PokemonGo-Pokedex/master/pokedex.json");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        pokemonData = jsonDecode(response.body)['pokemon'];
      });
      return;
    } else {
      setState(() {
        pokemonData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: const [
          Icon(Icons.list),
        ],
      ),
      body: pokemonData == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: pokemonData!.length,
              itemBuilder: (context, index) {
                String imageUrl = pokemonData![index]['img'];
                imageUrl = imageUrl.replaceFirst('http', 'https');
                // print(imageUrl);
                return Card(
                    color: Colors.green.shade300,
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/pokeball.png',
                          height: 120,
                        ),
                        Positioned(
                          top: 8,
                          right: 12,
                          child: Text(
                            "#${pokemonData![index]['num']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.green.shade500,
                            ),
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl: imageUrl,
                        ),
                      ],
                    ));
              },
            ),
    );
  }
}
