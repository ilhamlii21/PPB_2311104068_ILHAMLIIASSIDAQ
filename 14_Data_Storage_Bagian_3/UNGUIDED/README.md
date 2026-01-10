# Flutter REST API dengan GetX

## 📋 Deskripsi Program

Aplikasi Flutter ini adalah contoh implementasi **REST API** menggunakan **GetX** untuk state management. Aplikasi ini melakukan operasi **CRUD (Create, Read, Delete)** terhadap data postingan melalui API JSONPlaceholder. Program ini dirancang untuk demonstrasi penggunaan GetX sebagai state management solution dalam aplikasi Flutter yang berinteraksi dengan REST API.

## ✨ Fitur-Fitur

1. **GET** - Mengambil daftar postingan dari API
2. **POST** - Membuat postingan baru
3. **DELETE** - Menghapus postingan berdasarkan ID
4. **State Management** - Menggunakan GetX untuk manajemen state reaktif
5. **Loading Indicator** - Menampilkan indikator loading selama proses API
6. **Snackbar Notifikasi** - Memberikan feedback sukses/error kepada pengguna

## 🏗️ Struktur Proyek

```
lib/
├── controllers/
│   └── post_controller.dart      # Controller GetX untuk logika bisnis
├── models/
│   └── post_model.dart            # Model data Post
├── services/
│   └── api_service.dart           # Service untuk komunikasi API
├── views/
│   └── home_screen.dart           # UI utama aplikasi
└── main.dart                      # Entry point aplikasi
```

## 🛠️ Teknologi yang Digunakan

- **Flutter SDK** - Framework UI untuk pengembangan aplikasi mobile
- **GetX (v4.7.3)** - State management, dependency injection, dan route management
- **HTTP (v1.6.0)** - Package untuk melakukan HTTP requests
- **JSONPlaceholder API** - REST API mock untuk testing (https://jsonplaceholder.typicode.com)

## 📦 Instalasi dan Setup

### Prasyarat
- Flutter SDK versi 3.9.2 atau lebih tinggi
- Dart SDK
- Android Studio / VS Code dengan Flutter extension
- Emulator atau perangkat fisik untuk testing

### Langkah Instalasi

1. **Clone atau download repository**
   ```bash
   cd unguidedempatbelas
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

## 📚 Penjelasan Komponen

### 1. **main.dart**
Entry point aplikasi. File ini melakukan:
- Inisialisasi aplikasi Flutter
- Konfigurasi `GetMaterialApp` (menggantikan `MaterialApp` untuk menggunakan GetX)
- Setting tema aplikasi
- Menampilkan `HomeScreen` sebagai halaman utama

**Fitur Utama:**
- Menggunakan `GetMaterialApp` untuk integrasi GetX
- Theme dengan Material 3 design
- Debug banner dinonaktifkan

### 2. **models/post_model.dart**
Model data untuk representasi objek Post. Berisi:
- **Properties:**
  - `id` (int?) - ID unik postingan (nullable)
  - `title` (String) - Judul postingan
  - `body` (String) - Isi konten postingan
  - `userId` (int) - ID pengguna yang membuat postingan

- **Methods:**
  - `PostModel.fromJson()` - Factory constructor untuk parsing JSON ke objek
  - `toJson()` - Method untuk konversi objek ke JSON format

### 3. **services/api_service.dart**
Service layer untuk komunikasi dengan REST API. Menggunakan HTTP package untuk:
- **fetchPosts()** - GET request untuk mengambil semua postingan
  - Endpoint: `GET /posts`
  - Return: List<PostModel>
  - Status code: 200 (success)

- **createPost(PostModel post)** - POST request untuk membuat postingan baru
  - Endpoint: `POST /posts`
  - Body: JSON dari PostModel
  - Headers: Content-Type: application/json
  - Status code: 201 (created)

- **deletePost(int postId)** - DELETE request untuk menghapus postingan
  - Endpoint: `DELETE /posts/{postId}`
  - Status code: 200 (success)

**Error Handling:**
- Melempar Exception jika request gagal
- Pesan error spesifik untuk setiap operasi

### 4. **controllers/post_controller.dart**
Controller GetX yang mengelola state dan logika bisnis. Menggunakan:
- **Reactive Variables (`.obs`):**
  - `posts` - Observable list untuk menyimpan daftar postingan
  - `isLoading` - Observable boolean untuk status loading

- **Methods:**
  - `fetchPosts()` - Mengambil data postingan dari API
    - Set `isLoading = true` sebelum request
    - Panggil `_apiService.fetchPosts()`
    - Update `posts` dengan hasil
    - Tampilkan snackbar sukses/error
    - Set `isLoading = false` setelah selesai

  - `createPost()` - Membuat postingan baru
    - Buat objek PostModel baru dengan data default
    - Panggil `_apiService.createPost()`
    - Refresh list dengan `fetchPosts()`
    - Tampilkan snackbar konfirmasi

  - `deletePost(int postId)` - Menghapus postingan
    - Panggil `_apiService.deletePost(postId)`
    - Hapus item dari list lokal menggunakan `removeWhere()`
    - Tampilkan snackbar konfirmasi

- **Helper Methods:**
  - `_showSuccess(String msg)` - Menampilkan snackbar sukses di bagian bawah layar

### 5. **views/home_screen.dart**
User Interface utama aplikasi. Mengimplementasikan:
- **Widget Structure:**
  - `Scaffold` dengan AppBar
  - `Column` layout utama
  - `Row` untuk tombol-tombol aksi (GET, POST)
  - `Expanded` dengan `Obx` untuk list reaktif

- **Reactive UI dengan GetX:**
  - `Obx()` widget untuk auto-rebuild ketika state berubah
  - Menggunakan `controller.isLoading.value` untuk kondisi loading
  - Menggunakan `controller.posts` untuk menampilkan data

- **Components:**
  - **Buttons:**
    - GET button - Memanggil `controller.fetchPosts()`
    - POST button - Memanggil `controller.createPost()`
    - DELETE button - Memanggil `controller.deletePost()` untuk setiap item

  - **Loading State:**
    - Menampilkan `CircularProgressIndicator` saat `isLoading = true`

  - **List View:**
    - `ListView.builder` untuk menampilkan daftar postingan
    - `Card` dengan `ListTile` untuk setiap item
    - Menampilkan `title` dan `body` dari postingan
    - Tombol DELETE untuk setiap item dengan validasi ID

- **Error Handling UI:**
  - Snackbar untuk error jika ID postingan kosong saat delete

## 🔄 Alur Aplikasi

1. **Aplikasi Dimulai:**
   - `main()` → `MyApp` → `HomeScreen`
   - `PostController` diinisialisasi dengan `Get.put()`

2. **User Klik GET:**
   - `fetchPosts()` dipanggil
   - `isLoading` menjadi `true` → UI menampilkan loading indicator
   - Request API → Parse response → Update `posts`
   - `isLoading` menjadi `false` → UI update otomatis via `Obx()`
   - Snackbar sukses ditampilkan

3. **User Klik POST:**
   - `createPost()` dipanggil
   - Postingan baru dibuat dengan data default
   - Request API untuk create
   - Refresh list dengan `fetchPosts()`
   - Snackbar konfirmasi ditampilkan

4. **User Klik DELETE:**
   - `deletePost(postId)` dipanggil dengan ID spesifik
   - Request API untuk delete
   - Item dihapus dari list lokal
   - UI update otomatis (item hilang dari list)
   - Snackbar konfirmasi ditampilkan

## 🎯 Konsep GetX yang Digunakan

1. **Reactive Variables (`.obs`):**
   - Variabel yang otomatis trigger rebuild ketika nilainya berubah
   - Contoh: `var posts = <PostModel>[].obs`

2. **Obx Widget:**
   - Widget yang otomatis rebuild ketika reactive variables di dalamnya berubah
   - Lebih efisien daripada `setState()`

3. **Get.put():**
   - Dependency injection untuk membuat instance controller
   - Controller tersedia secara global dan persistent

4. **Get.snackbar():**
   - Utility GetX untuk menampilkan snackbar notification
   - Lebih mudah digunakan daripada `ScaffoldMessenger`

## 🚀 Cara Penggunaan

1. **Mengambil Data (GET):**
   - Klik tombol "GET" di bagian atas
   - Tunggu loading indicator selesai
   - List postingan akan ditampilkan

2. **Menambah Data (POST):**
   - Klik tombol "POST" di bagian atas
   - Postingan baru akan dibuat dengan data:
     - Title: "New Post"
     - Body: "This is a new post created via API"
     - UserId: 1
   - List akan otomatis ter-refresh

3. **Menghapus Data (DELETE):**
   - Klik tombol "DELETE" pada item postingan yang ingin dihapus
   - Item akan langsung hilang dari list
   - Pesan konfirmasi akan ditampilkan

## 🔍 Catatan Penting

- API yang digunakan adalah **JSONPlaceholder** (mock API), sehingga:
  - Data yang di-POST tidak benar-benar tersimpan di server
  - Data yang di-DELETE tidak benar-benar terhapus
  - GET akan selalu mengembalikan data dummy yang sama

- **GetX Controller:**
  - Controller dibuat dengan `Get.put()` yang berarti singleton
  - State akan persist selama aplikasi berjalan
  - Tidak perlu dispose manual untuk simple use case

- **Error Handling:**
  - Setiap method di controller menggunakan try-catch
  - Error ditampilkan melalui snackbar
  - Loading state selalu di-reset di finally block

## 📝 Penutup

Aplikasi ini adalah contoh sederhana namun komprehensif tentang:
- Integrasi REST API dengan Flutter
- Penggunaan GetX untuk state management
- Arsitektur MVC/MVP dengan separation of concerns
- Reactive programming dengan observables
- Error handling dan user feedback

Dapat digunakan sebagai referensi untuk pengembangan aplikasi Flutter yang lebih kompleks dengan kebutuhan state management dan API integration.

## 👨‍💻 Pengembang

Aplikasi ini dikembangkan sebagai contoh pembelajaran implementasi REST API dengan GetX pada Flutter.

---

**Versi:** 1.0.0  
**Flutter SDK:** 3.9.2+  
**Dibuat dengan:** Flutter & GetX
