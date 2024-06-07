import 'package:age_calculator/age_calculator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/cubit/people_cubit.dart';
import 'package:movie_app/pages/settings.dart';
import 'package:url_launcher/url_launcher.dart';

class PeopleDetailsPage extends StatefulWidget {
    final int castId;
   const PeopleDetailsPage({Key? key,required this.castId}) : super(key: key);

  @override
  State<PeopleDetailsPage> createState() => _PeopleDetailsPageState();
}

class _PeopleDetailsPageState extends State<PeopleDetailsPage> {
  bool hasBiography = true;
  bool hasKnownForDepartment = true;
  bool hasHomePage = true;
  late DateDuration age ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPeople();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocBuilder<PeopleCubit, PeopleState>(builder: (context, state){
        if(state is PeopleLoadingInProgress){
          return CircularProgressIndicator();

        }
        else if(state is PeopleLoadingSucceeded) {
          var person = state.people;

          var dateOfBirth = DateTime.tryParse( person.birthday);



          SchedulerBinding.instance.addPostFrameCallback((_) {

            setState(() {
              age = AgeCalculator.age(dateOfBirth!);
            });

            if(person.biography == null){
              setState(() {
                hasBiography = false;
              });
            }
            if(person.homepage == null){
              setState(() {
                hasHomePage = false;
              });
            }
            if(person.knownForDepartment == null){
              setState(() {
                hasKnownForDepartment = false;
              });
            }
            // add your code here.


          });



          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 450,
                  width: double.infinity,
                  // color: Colors.blue,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55)),
                    child:
                    CachedNetworkImage(
                      imageUrl:"$imageBaseUrl/${person
                          .profilePath}",
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,

                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:16.0, top: 8),
                      child: Text("${person.name}",style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),),
                    ),



                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Chip(
                        label: hasKnownForDepartment ? Text(person.knownForDepartment,style: GoogleFonts.poppins()) : Text(""),
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left:16.0, bottom: 16),
                  child: hasHomePage ? InkWell(
                      onTap: () => launch(person.homepage),
                      child: Text("Homepage: ${person.homepage}",style: GoogleFonts.poppins(fontSize: 16,),)) : Text(""),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:16.0, bottom: 8),
                  child:  Container(
                    child:   Text("Place of birth: ${person.placeOfBirth}", style: GoogleFonts.poppins(fontSize: 16, )) ,
                  ) ,
                ),

                Padding(
                  padding: const EdgeInsets.only(left:16.0, bottom: 8),
                  child:  Container(
                    child:   Text("Date of birth: ${person.birthday} (${age.years}years)", style: GoogleFonts.poppins(fontSize: 16, )) ,
                  ) ,
                ),



                Padding(
                  padding: const EdgeInsets.only(left:16.0, bottom: 0),
                  child:  Container(
                    child: Text("Biography", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold )) ,
                  ) ,
                ),

                Padding(
                      padding: const EdgeInsets.only(left:16.0, right: 16.0, top: 8),
                      child: hasBiography ? Container(
                        child:   Text(person.biography, style: GoogleFonts.poppins(fontSize: 16,)) ,
                      ) : Container(),
                    ) // child widget, replace with your own


                // child widget, replace with your own


              ]
              ),


          );
        }
        return Center(child: CircularProgressIndicator());
      }),
      // body:
    );
  }

  void _loadPeople() {
    BlocProvider.of<PeopleCubit>(context).loadPeople(widget.castId);

  }
}

