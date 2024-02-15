import 'package:explore_o_mundo/pages/destinations_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:explore_o_mundo/buttonSection.dart';
import 'package:explore_o_mundo/pages/about_us_page.dart';
import 'package:explore_o_mundo/pages/contact_page.dart';
import 'package:explore_o_mundo/pages/destinationsDetailPage.dart';
import 'package:explore_o_mundo/pages/travel_packages_page.dart';
import 'package:explore_o_mundo/textSection.dart';
import 'package:explore_o_mundo/title_section.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Mundo',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/destinations': (context) => DestinationsPage(),
        '/travel_packages': (context) => TravelPackagesPage(),
        '/contact': (context) => ContactPage(),
        '/about_us': (context) => AboutUsPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CarouselController _imageCarouselController = CarouselController();
  final CarouselController _titleCarouselController = CarouselController();
  final CarouselController _textCarouselController = CarouselController();

  final List<String> images = [
    'images/lake.jpeg',
    'images/buzios.webp',
    'images/patagonia.jpeg',
  ];

  final List<String> titles = [
    'Oeschinen Lake Campground',
    'Búzios, Brasil',
    'Patagônia, Argentina',
  ];

  final List<String> subtitles = [
    'Kandersteg, Switzerland',
    'Praias deslumbrantes',
    'Natureza deslumbrante',
  ];

  final List<String> descriptions = [
    'O Lago Oeschinen fica aos pés do Blüemlisalp nos Alpes Berneses. Situado a 1.578 metros acima do nível do mar, é um dos lagos alpinos mais amplos. Um passeio de teleférico a partir de Kandersteg, seguido por meia hora de caminhada por pastagens e floresta de pinheiros, leva você ao lago, que aquece até 20 graus Celsius no verão. As atividades desfrutadas aqui incluem remo e andar no tobogã de verão.',
    'Búzios é uma península com oito quilômetros de extensão e 23 praias, cada uma com um estilo único. Algumas são ideais para nadar, enquanto outras são conhecidas por suas ondas e são ideais para surfistas. A Rua das Pedras é uma famosa rua de paralelepípedos com lojas e restaurantes sofisticados.',
    'A Patagônia Argentina é uma vasta região que se estende até o extremo sul da América do Sul, compartilhada pelo Chile. É conhecida por suas vastas planícies, montanhas dos Andes e glaciares. O Parque Nacional Los Glaciares, na região de Santa Cruz, é famoso pelo gigantesco Glaciar Perito Moreno, além do Fitz Roy, um pico montanhoso que atrai alpinistas.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Mundo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.place),
            onPressed: () {
              Navigator.pushNamed(context, '/destinations');
            },
          ),
          IconButton(
            icon: const Icon(Icons.airplanemode_active),
            onPressed: () {
              Navigator.pushNamed(context, '/travel_packages');
            },
          ),
          IconButton(
            icon: const Icon(Icons.contact_mail),
            onPressed: () {
              Navigator.pushNamed(context, '/contact');
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.pushNamed(context, '/about_us');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          CarouselSlider.builder(
            carouselController: _imageCarouselController,
            itemCount: images.length,
            options: CarouselOptions(
              height: 200.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                _titleCarouselController.animateToPage(index);
                _textCarouselController.animateToPage(index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return buildCarouselItem(
                context,
                images[index],
                titles[index],
                subtitles[index],
                descriptions[index],
                index,
              );
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: CarouselSlider.builder(
              carouselController: _titleCarouselController,
              itemCount: titles.length,
              options: CarouselOptions(
                height: 50.0,
                enableInfiniteScroll: true,
                autoPlay: false,
                viewportFraction: 1.0,
              ),
              itemBuilder: (context, index, realIndex) {
                return TitleSection(
                  title: titles[index],
                  subtitle: subtitles[index],
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: CarouselSlider.builder(
              carouselController: _textCarouselController,
              itemCount: descriptions.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.5,
                enableInfiniteScroll: true,
                autoPlay: false,
                viewportFraction: 1.0,
              ),
              itemBuilder: (context, index, realIndex) {
                return TextSection(description: descriptions[index]);
              },
            ),
          ),
          ButtonSection(),
        ],
      ),
    );
  }

  Widget buildCarouselItem(
    BuildContext context,
    String imagePath,
    String title,
    String subtitle,
    String description,
    int index,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailPage(
              imagePath: imagePath,
              title: title,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
