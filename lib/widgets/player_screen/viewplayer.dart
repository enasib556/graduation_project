import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project_iti/widgets/player_screen/dialog.dart';
import 'package:share_plus/share_plus.dart';



class ViewPlayer extends StatelessWidget {


   ViewPlayer({
     super.key,
    this.img,
     this.type,
    required this.name,
     this.playerAge,
     this.playerAssists,
     this.playerGoals,
     this.playerNumber,
     this.playerRedCards,
     this.playerYellowCards,
     this.playerCountery,
  });

    String  ?img;
    String ?type;
    final String name;
    String ?playerAge;
    String ?playerYellowCards;
    String ?playerRedCards;
    String ?playerNumber;
    String? playerCountery;
    String ?playerGoals;
    String ?playerAssists;


  @override
  Widget build(BuildContext context) {

    return Column(
        children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 120,
              width: 350,
              decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.5, 2.0],
    colors: [Color(0xff1F211E),
      Color(0xff3b672a)]),
                borderRadius: BorderRadius.circular(16),
              border: Border.all(


                color: Color(0xff596456), // Change the color of the border
                width: 2.0, )// Set the width of the border in pixels
                  ),

                  ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl:img ??'assets/images/user.png',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Optional: Clip image to a circle
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover, // Adjust as per your requirement
                          ),
                        ),
                      ),

                      // placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Container(
                              width: 120.0,
                              height: 120.0,
                              child:
                              Image(image: AssetImage('assets/images/user.png'))),
                    ),

                    Container(
                      padding: EdgeInsets.only(top:40),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 20),
                              width:210,
                              child: Text(name,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white
                              ),
                              ),
                            ),

                            Container(
                              width: 10,
                             
                              decoration: BoxDecoration(
                                // color: Color(0xff96D173),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: IconButton(onPressed: (){

                                showPlayerDetailsDialogg(context,
                                img??"",
                                type??"",
                                name,
                                playerAge??"",
                                playerYellowCards??"",
                                playerRedCards??"",
                                playerNumber??"",
                                playerCountery??"",
                                playerGoals??"",
                                playerAssists??""
                                  
                                );
                              }, icon: Icon(
                                Icons.arrow_forward_ios_outlined,

                                size: 25,
                                color: Color(0xffCAF4B4),
                              )),
                            )
                          ],
                        )),


                        Container(
                            //margin: EdgeInsets.only(left: 100),
                            child: Text(type!,
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white
                            ),
                            )),


                      ],
                      ),
                    )
                  ],
                ),


              ],
            ),


          ],
        ),
      )
        ],

    );
  }



}