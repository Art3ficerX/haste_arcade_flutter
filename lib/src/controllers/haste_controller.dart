library haste_arcade_flutter;

import 'package:nonce/nonce.dart';
import 'package:url_launcher/url_launcher.dart';

import '../consts/haste_configs.dart';
import '../services/http.dart';

class HasteArcadeFlutter {
  final HttpService _httpService = HttpService();

  Future<dynamic> init(
      {required String clientId, required String clientSecret}) async {
    Map<String, String> body = {
      "clientId": clientId,
      "clientSecret": clientSecret,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var response = await _httpService.post(
        uri: "$apiServerEndpoint/oauth/writetoken",
        jsonBody: body,
        headers: headers);
    return response;
  }

  Future<Map<String, dynamic>> initAuth() async {
    Map<String, String> body = {
      "description": Nonce.generate(),
    };
    Map<String, String> headers0 = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var response0 = await _httpService.post(
        uri: "$authServerEndpoint/cli", jsonBody: body, headers: headers0);
    Uri url = Uri.parse("$authClientEndpoint${response0["browserUrl"]}");
    launchUrl(url);
    Map<String, String> headers1 = {
      'authorization': "Bearer ${response0['token']}",
    };
    var response1 = await _httpService.get(
        uri: "$authServerEndpoint/cli/${response0['requestorId']}",
        headers: headers1);

    return response1;
  }

  Future<Map<String, dynamic>> getLeaderboards(
      {required String accessTokenArcade,
      required String arcadeId,
      required String gameId}) async {
    Map<String, String> body = {
      "arcadeId": arcadeId,
      "gameId": gameId,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessTokenArcade',
    };
    var response = await _httpService.post(
        uri: "$apiServerEndpoint/arcades/$arcadeId/developergames/$gameId",
        jsonBody: body,
        headers: headers);
    return response;
  }

  Future<Map<String, dynamic>> initPlay(
      {required String accessTokenArcade,
      required String leaderboardId,
      required String arcadeId,
      required String gameId,
      required String playerId}) async {
    Map<String, String> body = {
      "playerId": playerId,
      "leaderboardId": leaderboardId,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessTokenArcade',
    };
    var response = await _httpService.post(
        uri: "$apiServerEndpoint/arcades/$arcadeId/games/$gameId/play",
        jsonBody: body,
        headers: headers);
    return response;
  }

  Future<Map<String, dynamic>> submitScore(
      {required String accessTokenArcade,
      required String arcadeId,
      required String gameId,
      required String playId,
      required double score,
      required String leaderboardId}) async {
    Map<String, String> body = {
      "score": score.toString(),
      "playId": playId,
      "leaderboardId": leaderboardId,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessTokenArcade',
    };
    var response = await _httpService.post(
        uri: "$apiServerEndpoint/arcades/$arcadeId/games/$gameId/score",
        jsonBody: body,
        headers: headers);
    return response;
  }

  Future<Map<String, dynamic>> getLeaders(
      {required String accessTokenArcade,
      required String arcadeId,
      required String gameId,
      required String leaderboardId}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessTokenArcade',
    };
    var response = await _httpService.get(
        uri:
            "$apiServerEndpoint/arcades/$arcadeId/games/$gameId/leaders/$leaderboardId",
        headers: headers);
    return response;
  }

  Future<Map<String, dynamic>> getTopScore(
      {required String accessTokenArcade,
      required String arcadeId,
      required String gameId,
      required String playerId,
      required String leaderboardId}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessTokenArcade',
    };
    var response = await _httpService.get(
        uri:
            "$apiServerEndpoint/arcades/$arcadeId/games/$gameId/topscore/$leaderboardId/$playerId",
        headers: headers);
    return response;
  }

  Future<Map<String, dynamic>> getPayoutInfo(
      {required String accessTokenArcade,
      required String arcadeId,
      required String gameId,
      required String playerId}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessTokenArcade',
    };
    var response = await _httpService.get(
        uri:
            "$apiServerEndpoint/arcades/$arcadeId/games/$gameId/payouts/$playerId",
        headers: headers);
    return response;
  }
}
