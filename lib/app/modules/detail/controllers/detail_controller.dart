import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_time/app/data/response/movie_detail_response.dart';
import 'package:movie_time/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/constant.dart';

class DetailController extends GetxController {
  final image = Get.arguments['image'];
  final movieId = Get.arguments['id'];
  final movieName = Get.arguments['name'];

  final isLoading = (false).obs;

  final rating = 0.obs;
  final desc = ('').obs;

  Future<MovieDetail> getMovieDetail(int movieId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/getmovie?movie_id=$movieId'));

    if (response.statusCode == 200) {
      return MovieDetail.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Movie not found');
    } else {
      throw Exception('Failed to get data');
    }
  }

  fetchData() async {
    try {
      isLoading.value = true;
      final response = await getMovieDetail(movieId);
      rating.value = response.rating.toInt();
      desc.value = response.desc;
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

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  addReview() {
    Get.toNamed(Routes.REVIEW,
        arguments: {'id': movieId, 'image': image, 'name': movieName});
  }
}
