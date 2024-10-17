
class PlayerData {
  final int playerKey;
  final String playerName;
  final dynamic playerNumber;
  final dynamic playerCountry;
  final String playerType;
  final dynamic playerAge;
  final dynamic playerMatchPlayed;
  final dynamic playerGoals;
  final dynamic playerYellowCards;
  final dynamic playerRedCards;
  final dynamic playerMinutes;
  final String playerInjured;
  final dynamic playerSubstituteOut;
  final dynamic playerSubstitutesOnBench;
  final dynamic playerAssists;
  final String playerIsCaptain;
  final dynamic playerShotsTotal;
  final dynamic playerGoalsConceded;
  final dynamic playerFoulsCommited;
  final dynamic playerTackles;
  final dynamic playerBlocks;
  final dynamic playerCrossesTotal;
  final dynamic playerInterceptions;
  final dynamic playerClearances;
  final dynamic playerDispossesed;
  final dynamic playerSaves;
  final dynamic playerInsideBoxSaves;
  final dynamic playerDuelsTotal;
  final dynamic playerDuelsWon;
  final dynamic playerDribbleAttempts;
  final dynamic playerDribbleSucc;
  final dynamic playerPenComm;
  final dynamic playerPenWon;
  final dynamic playerPenScored;
  final dynamic playerPenMissed;
  final dynamic playerPasses;
  final dynamic playerPassesAccuracy;
  final dynamic playerKeyPasses;
  final dynamic playerWoodworks;
  final dynamic playerRating;
  final String teamName;
  final int teamKey;
  final dynamic playerImage;

  PlayerData({
    required this.playerKey,
    required this.playerName,
    this.playerNumber,
    this.playerCountry,
    required this.playerType,
    this.playerAge,
    this.playerMatchPlayed,
    this.playerGoals,
    this.playerYellowCards,
    this.playerRedCards,
    this.playerMinutes,
    required this.playerInjured,
    this.playerSubstituteOut,
    this.playerSubstitutesOnBench,
    this.playerAssists,
    required this.playerIsCaptain,
    this.playerShotsTotal,
    this.playerGoalsConceded,
    this.playerFoulsCommited,
    this.playerTackles,
    this.playerBlocks,
    this.playerCrossesTotal,
    this.playerInterceptions,
    this.playerClearances,
    this.playerDispossesed,
    this.playerSaves,
    this.playerInsideBoxSaves,
    this.playerDuelsTotal,
    this.playerDuelsWon,
    this.playerDribbleAttempts,
    this.playerDribbleSucc,
    this.playerPenComm,
    this.playerPenWon,
    this.playerPenScored,
    this.playerPenMissed,
    this.playerPasses,
    this.playerPassesAccuracy,
    this.playerKeyPasses,
    this.playerWoodworks,
    this.playerRating,
    required this.teamName,
    required this.teamKey,
    this.playerImage,
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      playerKey: json['player_key'] as int,
      playerName: json['player_name'] as String,
      playerNumber: json['player_number'],
      playerCountry: json['player_country'],
      playerType: json['player_type'] as String,
      playerAge: json['player_age'],
      playerMatchPlayed: json['player_match_played'],
      playerGoals: json['player_goals'],
      playerYellowCards: json['player_yellow_cards'],
      playerRedCards: json['player_red_cards'],
      playerMinutes: json['player_minutes'],
      playerInjured: json['player_injured'] as String,
      playerSubstituteOut: json['player_substitute_out'],
      playerSubstitutesOnBench: json['player_substitutes_on_bench'],
      playerAssists: json['player_assists'],
      playerIsCaptain: json['player_is_captain'] as String,
      playerShotsTotal: json['player_shots_total'],
      playerGoalsConceded: json['player_goals_conceded'],
      playerFoulsCommited: json['player_fouls_commited'],
      playerTackles: json['player_tackles'],
      playerBlocks: json['player_blocks'],
      playerCrossesTotal: json['player_crosses_total'],
      playerInterceptions: json['player_interceptions'],
      playerClearances: json['player_clearances'],
      playerDispossesed: json['player_dispossesed'],
      playerSaves: json['player_saves'],
      playerInsideBoxSaves: json['player_inside_box_saves'],
      playerDuelsTotal: json['player_duels_total'],
      playerDuelsWon: json['player_duels_won'],
      playerDribbleAttempts: json['player_dribble_attempts'],
      playerDribbleSucc: json['player_dribble_succ'],
      playerPenComm: json['player_pen_comm'],
      playerPenWon: json['player_pen_won'],
      playerPenScored: json['player_pen_scored'],
      playerPenMissed: json['player_pen_missed'],
      playerPasses: json['player_passes'],
      playerPassesAccuracy: json['player_passes_accuracy'],
      playerKeyPasses: json['player_key_passes'],
      playerWoodworks: json['player_woordworks'],
      playerRating: json['player_rating'],
      teamName: json['team_name'] as String,
      teamKey: json['team_key'] as int,
      playerImage: json['player_image'],
    );
  }
  // static List<PlayerData> fromJsonList(List<dynamic> jsonList) {
  //   return jsonList.map((json) => PlayerData.fromJson(json)).toList();
}
