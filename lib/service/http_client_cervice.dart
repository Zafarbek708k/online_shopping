import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

@immutable
final class HttpClientService {

  static const String _baseUrl = "https://65ca48bb3b05d29307e0172d.mockapi.io";
  static const String baseApiGet = "/product/product";
  static const String baseApiBasket = "/product/basket";

  const HttpClientService._internal(); // pravice constructor

  static const HttpClientService _service =
  HttpClientService._internal(); // pravitedan obyekt olindi

  factory HttpClientService() {
    return _service;
  }

  static Future<String?> getData({required String api}) async {
    HttpClient httpClient = HttpClient();
    try {
      Uri url = Uri.parse("$_baseUrl$api");
      log(url.toString());
      HttpClientRequest request = await httpClient.getUrl(url);

      HttpClientResponse response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        String result = await response.transform(utf8.decoder).join();
        return result;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    } finally {
      httpClient.close();
    }
  }

  /// function of the post
  static Future<String?> postData({ required String api, required Map<String, dynamic> data}) async {
    HttpClient httpClient = HttpClient();
    try {
      Uri url = Uri.parse("$_baseUrl$api");
      HttpClientRequest request = await httpClient.postUrl(url);
      request.headers.set("Content-Type", "application/json");
      request.add(utf8.encode(jsonEncode(data)));
      HttpClientResponse response = await request.close();
      if (response.statusCode == HttpStatus.created) {
        String result = await response.transform(utf8.decoder).join();
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      httpClient.close();
    }
  }

  /// function of the update
  static Future<String?> putData({ required String api, required Map<String, Object?> data}) async {
    HttpClient httpClient = HttpClient();
    try {
      Uri url = Uri.parse('$_baseUrl/$api');
      HttpClientRequest request = await httpClient.putUrl(url);
      request.headers.set('Content-Type', 'application/json');
      request.add(utf8.encode(jsonEncode(data)));
      HttpClientResponse response = await request.close();
      if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
        String responseBody = await response.transform(utf8.decoder).join();
        return responseBody;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    } finally {
      httpClient.close();
    }
  }


  /// function of the delete
  static Future<String?> deleteData({required String api, required String id}) async {
    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();
    try {
      // url yasab olinayabdi
      Uri url = Uri.parse('$_baseUrl/$api/$id');
      // delete methodi orqali so'rov jo'natilayabdi
      HttpClientRequest request = await httpClient.deleteUrl(url);
      // jo'natilgan so'rov close qilib yopilayabdi
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode == HttpStatus.noContent || response.statusCode == HttpStatus.ok) {
        return responseBody;
      } else {
        throw Exception('Failed to delete resource: ${response.statusCode}, $responseBody');
      }
    } finally {
      httpClient.close();
    }
  }


}
