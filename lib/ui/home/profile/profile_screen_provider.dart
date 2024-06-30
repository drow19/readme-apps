import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:book_store_apps/data/local/shared_preferences.dart';
import 'package:book_store_apps/models/book_data_res.dart';
import 'package:book_store_apps/models/user_model.dart';
import 'package:book_store_apps/ui/detail/detail_screen.dart';
import 'package:book_store_apps/ui/introduction/login/login_screen.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreenProvider extends ChangeNotifier {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  ProfileScreenProvider(this._sharedPreferencesHelper);

  final _picker = ImagePicker();
  File avatar = File('');

  UserModel user = const UserModel();

  List<BookDataRes> listOfBooks = List<BookDataRes>.empty(growable: true);

  Future<void> initial() async {
    Future.wait([
      fetchUserData(),
      fetchBooks(),
    ]);
  }

  Future<void> fetchUserData() async {
    final int userLogin = _sharedPreferencesHelper.savedLogin;
    final String userData = _sharedPreferencesHelper.userData;

    // Return an empty list if user data is empty
    if (userData.isEmpty) return;

    try {
      List<dynamic> data = jsonDecode(userData);
      List<UserModel> listUser =
          data.map((item) => UserModel.fromJson(item)).toList();

      if (userData.isNotEmpty) {
        try {
          List<dynamic> data = jsonDecode(userData);
          listUser = data.map((item) => UserModel.fromJson(item)).toList();
        } catch (e) {
          debugPrint('error decoding user data : $e');
          return;
        }
      }

      // find the current user
      final UserModel? sameUser =
          listUser.firstWhereOrNull((user) => user.userId == userLogin);

      if (sameUser == null) return;

      user = sameUser;
      updateAvatar(File(sameUser.avatar ?? ''));
    } catch (e) {
      debugPrint('Error decoding user data: $e');
      return;
    }

    notifyListeners();
  }

  Future<void> fetchBooks() async {
    String bookData = _sharedPreferencesHelper.seenBook;

    // Decode the saved book data if it's not empty
    if (bookData.isNotEmpty) {
      try {
        List<dynamic> data = jsonDecode(bookData);
        listOfBooks = data.map((item) => BookDataRes.fromJson(item)).toList();
      } catch (e) {
        debugPrint('Error decoding books data: $e');
        return;
      }
    }

    notifyListeners();
  }

  void updateAvatar(File file) {
    avatar = file;
    saveAvatar();

    notifyListeners();
  }

  void saveAvatar() {
    final int userLogin = _sharedPreferencesHelper.savedLogin;
    final String userData = _sharedPreferencesHelper.userData;

    List<UserModel> listUser = List<UserModel>.empty(growable: true);

    if (userData.isNotEmpty) {
      try {
        List<dynamic> data = jsonDecode(userData);
        listUser = data.map((item) => UserModel.fromJson(item)).toList();
      } catch (e) {
        debugPrint('error decoding user data : $e');
        return;
      }
    }

    // find the current user
    final UserModel? sameUser =
        listUser.firstWhereOrNull((user) => user.userId == userLogin);

    if (sameUser == null) return;

    // create an updated user model with the new avatar
    UserModel updateUser = sameUser.copyWith(avatar: avatar.path);

    int userIndex = listUser.indexOf(sameUser);
    listUser[userIndex] = updateUser;

    _sharedPreferencesHelper.saveUserData(listUser);
  }

  switchAttachment(String value) {
    switch (value) {
      case 'camera':
        _openCamera();
        break;
      case 'gallery':
        _openGallery();
        break;
      case 'document':
        onFilePicker();
        break;
    }
  }

  //OPEN GALLERY FOR ATTACHMENT
  _openGallery() {
    _picker.pickImage(source: ImageSource.gallery).then((imageFile) {
      if (imageFile != null) {
        _processFile(imageFile.path);
      }
    });
  }

  //OPEN CAMERA FOR ATTACHMENT
  _openCamera() {
    _picker.pickImage(source: ImageSource.camera).then((imageFile) {
      if (imageFile != null) {
        _processFile(imageFile.path);
      }
    });
  }

  //OPEN FILE PICKER FOR ATTACHMENT
  void onFilePicker() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ["jpg", "jpeg", "png"]);
    if (result != null) {
      if (result.files.first.extension == "jpg") {
        _processFile(result.files.first.path!);
      } else {
        updateAvatar(File(result.files.first.path!));
      }
    }
  }

  File _createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  _processFile(String imagePath) async {
    var imageFile = File(imagePath);
    var imageSize = imageFile.lengthSync();
    if (imageSize > 204800) {
      var tempDir = await getTemporaryDirectory();
      var tempPath = '${tempDir.absolute.path}/${getRandomName()}.jpg';
      _createFile(tempPath);
      FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        tempPath,
        quality: 50,
      ).then((compressedFile) {
        updateAvatar(File(compressedFile!.path));
      }).onError((error, stackTrace) {
        debugPrint('$error');
      });
    } else {
      updateAvatar(File(imagePath));
    }
  }

  void goToDetailBooks(BuildContext context, BookDataRes book) {
    Navigator.pushNamed(context, DetailScreen.routeName,
        arguments: {'argument': book});
  }

  void signOut(BuildContext context) {
    Future.wait([
      _sharedPreferencesHelper.deleteSeenBook(),
      _sharedPreferencesHelper.logout(),
    ]);
    Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.routeName, (route) => false)
        .then((value) async {});
  }
}

String getRandomName({int length = 10}) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
    ),
  );
}
