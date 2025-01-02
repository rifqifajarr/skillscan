import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_time/app/data/preferences/session_controller.dart';
import 'package:movie_time/app/data/response/movie_list_response.dart';
import 'package:movie_time/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/constant.dart';

class HomeController extends GetxController {
  final sessionController = SessionController();
  final Rxn<int> userId = Rxn<int>();
  final Rxn<bool> getStarted = Rxn<bool>();

  final isLoading = (false).obs;

  final Rx<List<Movie>> movieList = Rx<List<Movie>>([]);

  @override
  void onInit() {
    super.onInit();
    checkSession();
  }

  Future<void> checkSession() async {
    userId.value = await sessionController.getUserId();
    getStarted.value = await sessionController.getStartedStatus();

    if (userId.value == null) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      fetchData();
    }
  }

  fetchData() async {
    try {
      isLoading.value = true;
      if (getStarted.value == null) {
        final response = await getTopMovie();
        movieList.value = response.result;
      } else {
        final response = await getMovieRecommendation(userId.value ?? 0);
        movieList.value = response.result;
      }
    } catch (e) {
      Get.snackbar(
        'Failed to get data',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<MovieResponse> getMovieRecommendation(int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recommend'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          'user_id': userId,
        },
      ),
    );

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<MovieResponse> getTopMovie() async {
    final response = await http.get(
      Uri.parse('$baseUrl/topmovie'),
    );

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get data');
    }
  }

  toDetail(int id, String? image, String movieName) {
    if (image != null) {
      if (!getStarted.value.isNull) {
        Get.toNamed(Routes.DETAIL,
            arguments: {'id': id, 'image': image, 'name': movieName});
      } else {
        Get.toNamed(Routes.REVIEW,
            arguments: {'id': id, 'image': image, 'name': movieName});
      }
    }
  }

  toProfile() {
    Get.toNamed(Routes.PROFILE);
  }
}
