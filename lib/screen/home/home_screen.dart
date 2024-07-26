import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dameyu_project/model/artikel/artikel_model.dart';
import 'package:dameyu_project/screen/chatbot/chatbot_screen.dart';
import 'package:dameyu_project/services/home/artikel_api.dart';
import 'package:dameyu_project/screen/splash_screen/splash_screen.dart';
import 'package:dameyu_project/theme/theme_color.dart';
import 'package:dameyu_project/theme/theme_text_style.dart';
import 'package:dameyu_project/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArtikelModel> artikel = [];
  String _username = "";
  bool isLoading = true; // Tambahkan state isLoading

  @override
  void initState() {
    super.initState();
    _getUsername().then((username) {
      if (mounted) {
        setState(() {
          _username = username;
        });
      }
    });
    _getArtikelData();
  }

  Future<String> _getUsername() async {
    final username = await SharedPref().getToken();
    return username;
  }

  final ArtikelAPI _artikelAPI = ArtikelAPI();

  Future<void> _getArtikelData() async {
    try {
      final List<ArtikelModel> artikelList = await _artikelAPI.getArtikel();
      if (mounted) {
        setState(() {
          artikel = artikelList;
          isLoading = false; // Setelah selesai ambil data, matikan isLoading
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false; // Tangkap error, matikan isLoading
        });
      }
      print("Error fetching artikel: $error");
    }
  }

    void _showArtikelDetail(ArtikelModel artikel, String imagePath) {
  showModalBottomSheet(
    backgroundColor: const Color(0xFFFFA0B5),
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      artikel.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.istokWeb(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      imagePath,
                      width: 300,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    artikel.description,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.istokWeb(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}









  Widget getItemWidget(int index) {
    switch (index) {
      case 0:
        return Image.asset(
          'assets/pohon.png',
          fit: BoxFit.cover,
        );
      case 1:
        return Image.asset(
          'assets/panen.png',
          fit: BoxFit.cover,
        );
      default:
        return Container(
          color: const Color(0xFFF68787),
        );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor().whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: ThemeColor().pinkColor,
          centerTitle: true,
          title: Align(
  alignment: Alignment.centerLeft,
  child: Container(
    margin: const EdgeInsets.only(left: 20.0), // Adjust the value to move it to the right
    child: Image.asset(
      'assets/logo2.png',
    ),
  ),
),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: IconButton(
                icon: Image.asset('assets/chatbotbutton.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatBotScreen()),
                  );
                },
              ),
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Hi! $_username',
                style: ThemeTextStyle().welcomeUsername,
              ),
            ),
          ),

          const SizedBox(height: 30),
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   color: ThemeColor().pinkColor,
          //   onPressed: () async {
          //     Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(
          //         builder: (_) => const SplashScreen(),
          //       ),
          //       (route) => false,
          //     );
          //     await SharedPref().removeToken();
          //   },
          // ),
          SizedBox(
  width: double.infinity,
  child: CarouselSlider.builder(
    itemCount: 2,
    options: CarouselOptions(
      height: 160,
      autoPlay: true,
      viewportFraction: 0.63,
      enlargeCenterPage: true,
      pageSnapping: true,
      autoPlayCurve: Curves.fastOutSlowIn,
      autoPlayAnimationDuration: const Duration(seconds: 1),
    ),
    itemBuilder: (context, itemIndex, pageViewIndex) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          color: const Color(0xFFF68787),
          child: getItemWidget(itemIndex),
        ),
      );
    },
  ),
        
),



          const SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Article',
                style: ThemeTextStyle().artikel,
              ),
            ),
          ),
          
          Expanded(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: artikel.length,
              itemBuilder: (context, index) {
                final images = [
                  'assets/apple.png',
                  'assets/apple2.jpg',
                  'assets/apple3.jpg'
                ];
                final imageIndex = index % images.length;
                final selectedImage = images[imageIndex];

                return Card(
                  color: const Color(0xFFFFA0B5),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
                  child: InkWell(
                    onTap: () => _showArtikelDetail(artikel[index], selectedImage),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Image.asset(
                            selectedImage,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),

              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  artikel[index].title,
                  style: GoogleFonts.istokWeb(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
)

          ),
        ],
      ),
    );
  }
}
