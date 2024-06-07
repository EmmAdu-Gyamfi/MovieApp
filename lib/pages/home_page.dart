import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/pages/popular_movies_page.dart';
import 'package:movie_app/pages/tv_series_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black26,
          title: Text("Movies Hub"),
          titleTextStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.normal),
          bottom: TabBar(

            labelStyle: GoogleFonts.poppins(),
            tabs: [
              Tab(
                  icon: FaIcon(FontAwesomeIcons.youtube),
                   text: "Movies"
                  ),

              Tab(
               icon: FaIcon(FontAwesomeIcons.film),
               text: "Tv Series"
                ),
            ],
            )
          ),

        body: TabBarView(
          children: [
            MoviesPage(),
            TvSeriesPage(),
          ],

        )

      ),
    );
  }
}
