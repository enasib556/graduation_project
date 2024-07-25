class Team {

  List<Player> players;

  Team({

    required this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    var playersList = json['result'][0]['players'] as List;
    //??
    List<Player> players = playersList.map((playerJson) => Player.fromJson(playerJson)).toList();

    return Team(

      players: players,
    );
  }
}

class Player {
  int ?playerKey;
    String ?playerImage;
  String playerName;

  String ?playerType;

  String? playerAge;
  String ?playerYellowCards;
  String ?playerRedCards;
  String ?playerNumber;

  String ?playerGoals;
  String ?playerAssists;
  // String playerCountery;
  String ?playerCountry;


  Player({
     this.playerKey,
     this.playerImage,
   required this.playerName,
    this.playerType,
     this.playerAge,
     this.playerAssists,

     this.playerGoals,
    this.playerNumber,
    this.playerRedCards,
    this.playerYellowCards,
    // required this.playerCountery,
     this.playerCountry,

    // Add more fields as needed
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerKey: json['player_key'],
      playerImage: json['player_image'],
      playerName: json['player_name'],
      playerType: json['player_type'],
      playerAge: json['player_age'],
      playerAssists: json['player_assists'],
      playerGoals: json['player_goals'],
      playerNumber: json['player_number'],
      playerRedCards: json['player_red_cards'],
      playerYellowCards: json['player_yellow_cards'],
      playerCountry: json['player_country']
      // playerCountery: json['player_country']
      // Add more fields as needed
    );
  }
}
