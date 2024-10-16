import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'image.dart';

void showPlayerDetailsDialogg(BuildContext context,
 String  ?img,
 String ?type,
 String name,
 String ?playerAge,
  String ?playerYellowCards,
  String ?playerRedCards,
  String ?playerNumber,
String? playerCountery,
 String ?playerGoals,
 String ?playerAssists,
    ) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Color(0xff212320),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color:Color(0xff364133), width: 3),
      ),
      title: Text(name, style: const TextStyle(color: Colors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PlayerImage(imageUrl: img??'asset/image/user (1).png'),
          Text('Number: ${playerNumber}', style: const TextStyle(color: Colors.white, fontSize:20,fontStyle: FontStyle.italic)),
          Text('Country: ${playerCountery}', style: const TextStyle(color: Colors.white, fontSize:20, fontStyle: FontStyle.italic)),
          Text('Type: ${type}', style: const TextStyle(color: Colors.white,  fontSize:20,fontStyle: FontStyle.italic)),
          Text('Age: ${playerAge}', style: const TextStyle(color: Colors.white, fontSize:20, fontStyle: FontStyle.italic)),
          Text('Yellow Cards: ${playerYellowCards}', style: const TextStyle(color: Colors.white, fontSize:20)),
          Text('Red Cards: ${playerRedCards}', style: const TextStyle(color: Colors.white, fontSize:20, fontStyle: FontStyle.italic)),
          Text('Goals: ${playerGoals}', style: const TextStyle(color: Colors.white, fontSize:20, fontStyle: FontStyle.italic)),
          Text('Assists: ${playerAssists}', style: const TextStyle(color: Colors.white, fontSize:20, fontStyle: FontStyle.italic)),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:  Color(0xffCAF4B4),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
              textStyle: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            onPressed: () {
              Share.share('The player: ${name} from ${playerCountery}!');
            },
            child: const Text('Share Player',style: TextStyle(
              fontSize: 25
            ),),
          ),
        ],
      ),
    ),
  );
}