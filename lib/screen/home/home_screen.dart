import 'package:carousel_slider/carousel_slider.dart';
import 'package:dameyu_project/screen/chatbot/chatbot_screen.dart';
import 'package:dameyu_project/services/artikel_api.dart';
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
  List<Map<String, dynamic>> artikel = [];
 
  String _username = "";

  @override
  void initState() {
    super.initState();
    _getUsername().then((username) {
      setState(() {
        _username = username;
      });
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
      final artikel = await _artikelAPI.getArtikel();
    
      setState(() {
        this.artikel = artikel;
      });

      
    } catch (error) {
   
    print("Error fetching artikel: $error");
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
            child: Image.asset(
              'assets/logo2.png',
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Image.asset('assets/chatbotbutton.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatBotScreen()),
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
            const SizedBox(height: 10),
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
            IconButton(
              icon: const Icon(Icons.logout),
              color: ThemeColor().pinkColor,
              onPressed: () async {
              Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SplashScreen(),
                    ),
                    (route) => false);
                await SharedPref().removeToken();
            }
          ),

          SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: 10,
                options: CarouselOptions(
                  height: 130,
                  autoPlay: true,
                  viewportFraction: 0.70,
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
                    ),
                  );
                },
              ),
            ),

             const SizedBox(height: 80),
              Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: Text(
                  'Artikel',
                  style: ThemeTextStyle().artikel,
                ),
              ),
            ),
             
            Expanded(
              
              child: ListView.builder(
                itemCount: artikel.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFFFFFFFF), 
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 13.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            artikel[index]["title"],
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF646E82),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
}