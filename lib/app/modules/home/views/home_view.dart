import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_time/app/data/response/movie_list_response.dart';
import 'package:movie_time/app/theme.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Obx(
              () {
                final getStarted = controller.getStarted.value;
                if (controller.isLoading.value) {
                  return Center(child: const CircularProgressIndicator());
                } else {
                  if (getStarted == null) {
                    return buildHomeStarting(
                        controller.movieList.value, context);
                  } else {
                    return buildHome(controller.movieList.value, context);
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHomeStarting(List<Movie> items, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get Started',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Pilih satu film yang menurutmu menarik',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            physics: ClampingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return buildGridItem(item);
            },
          ),
        )
      ],
    );
  }

  Widget buildHome(List<Movie> items, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Berdasarkan referensi mu',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                controller.toProfile();
              },
              icon: Icon(Icons.account_circle),
              color: Colors.white,
              iconSize: 42,
            )
          ],
        ),
        SizedBox(height: 12),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            physics: ClampingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return buildGridItem(item);
            },
          ),
        )
      ],
    );
  }

  Widget buildGridItem(Movie item) {
    return GestureDetector(
      onTap: () {
        controller.toDetail(item.movieId, item.posterPath, item.movieName);
      },
      child: Container(
        width: 146,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.posterPath,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 267,
                      ),
                    );
                  },
                ),
              ),
            ),
            Text(
              item.movieName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
