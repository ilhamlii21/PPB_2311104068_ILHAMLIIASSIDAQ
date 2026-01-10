import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/post_model.dart';

class PostController extends GetxController {
  var posts = <PostModel>[].obs; 
  var isLoading = false.obs;
  final ApiService _apiService = ApiService();


  void _showSuccess(String msg) {
    Get.snackbar("Sukses", msg, snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> fetchPosts() async {
    try {
      isLoading(true);
      final result = await _apiService.fetchPosts();
      posts.assignAll(result);
      _showSuccess("Data berhasil diambil!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> createPost() async {
    try {
      isLoading(true);
      final newPost = PostModel(
        title: "New Post",
        body: "This is a new post created via API",
        userId: 1,
      );
      await _apiService.createPost(newPost);

      final result = await _apiService.fetchPosts();
      posts.assignAll(result);
      _showSuccess("Data berhasil ditambahkan!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      isLoading(true);
      await _apiService.deletePost(postId);
      posts.removeWhere((post) => post.id == postId);
      _showSuccess("Data berhasil dihapus!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
