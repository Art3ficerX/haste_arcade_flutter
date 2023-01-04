library haste_arcade_flutter;

import 'package:nonce/nonce.dart';

import '../consts/haste_configs.dart';
import '../services/http.dart';

class HasteArcadeFlutter {
  final HttpService _httpService = HttpService();

  Future<Map<String, dynamic>> initAuth() async {
    Map<String, String> body = {
      "description": Nonce.generate(),
    };
    Map<String, String> headers0 = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var response = await _httpService.post(
        uri: "$authServerEndpoint/cli", jsonBody: body, headers: headers0);
    return response;
  }

  Future<Map<String, dynamic>> getAccessToken(
      String bearerToken, String requestorId) async {
    Map<String, String> headers0 = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $bearerToken",
    };
    var response = await _httpService.get(
        uri: "$authServerEndpoint/cli/$requestorId", headers: headers0);
    return response;
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
