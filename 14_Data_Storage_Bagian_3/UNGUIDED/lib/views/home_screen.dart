import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';

class HomeScreen extends StatelessWidget {
  // Inisialisasi Controller
  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("REST API GetX")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: controller.fetchPosts,
                child: Text("GET"),
              ),
              ElevatedButton(
                onPressed: controller.createPost,
                child: Text("POST"),
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              // Widget Reaktif
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  final postId =
                      controller.posts[index].id; // Ambil ID postingan
                  return Card(
                    child: ListTile(
                      title: Text(controller.posts[index].title),
                      subtitle: Text(controller.posts[index].body),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (postId != null) {
                            controller.deletePost(postId!);
                          } else {
                            Get.snackbar("Error", "ID postingan kosong");
                          }
                        },
                        child: Text("DELETE"),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
