import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medvarsity_task/view/auth/login.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:medvarsity_task/helper/shared-pref.dart';
import 'package:medvarsity_task/helper/util.dart';
import 'package:medvarsity_task/service/user.dart';

class RegisterController extends GetxController {
  var appLocale = 'en';
  SharedPref sharedPref = SharedPref();
  RxString passwordHideShow = "hide".obs;
  RxString cnfPasswordHideShow = "hide".obs;
  RxString name = ''.obs;
  RxString mobile = ''.obs;
  RxString email = ''.obs;
  RxString base64Image=''.obs;
  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;
  RxBool submitBtnCheck = false.obs;
  RxBool indicatorLoader = false.obs;
  var isLoader = false.obs;
  RxString photoPath=''.obs;
  RxString imageShow = '1'.obs;
  @override
  void onInit() {

    super.onInit();
  }

  imgCompress(path) async {
    var path2 = await FlutterAbsolutePath.getAbsolutePath(path);
    Uri myUri = Uri.parse(path);
    File audioFile = new File.fromUri(myUri);
    Uint8List bytes = audioFile.readAsBytesSync();
    final buffer = bytes.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/file_01.jpg';
    File(filePath).writeAsBytes(
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

    var result = await FlutterImageCompress.compressAndGetFile(
      path2,
      filePath,
      quality: 70,
    );
    print(result.lengthSync());

    print("real Image" + result.path);
    if (result.path != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: result.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Color(0xFFe03552),
            toolbarTitle: "Crop Image",
            statusBarColor: Color(0xFFe03552),
            backgroundColor: Colors.white,
          ));

      photoPath.value = cropped.path;
      final bytes1 = File(cropped.path).readAsBytesSync();
      base64Image.value = base64Encode(bytes1);
    }

    // if (kIsWeb) {
    //
    //   _selectedImage = Image.network(path,
    //       width: 100, height: 100, fit: BoxFit.cover);
    // } else {
    //   _selectedImage = Image.file(File(path),
    //       width: 100, height: 100, fit: BoxFit.cover);
    // }
  }

  Future getPhoto(_source) async {
    final pickedFile = await ImagePicker().getImage(source: _source);
    if (pickedFile != null) {
      imgCompress(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  // for hide showing the password
  void toggle(String val) {
    if (passwordHideShow.value == "hide") {
      passwordHideShow.value = "show";
    } else {
      passwordHideShow.value = "hide";
    }
  }

  // for checking the username and password length

  // this function is use for check all validation then it enable the login button

  // this function is use authentication form server
  Future userLogin() async {
    indicatorLoader.value = true;
    Map<String, dynamic> map = {
      "number": mobile.value,
      "password": password.value,
    };
    dynamic userData = await UserApiServices.getUserLogin(map);
    dynamic data = json.decode(userData.data);
    if (userData != null) {
      if (data['status'] == true) {
        indicatorLoader.value = false;
        sharedPref.save("userData", userData.data, false);
        print("sksk"+data["sk"]);
        showSnackBar("Success", data['message'], Colors.green);

      } else {
        indicatorLoader.value = false;
        showSnackBar("Error", data['message'], Colors.redAccent);
      }
    } else {
      indicatorLoader.value = false;
      showSnackBar("Error", data['message'], Colors.redAccent);
    }
  }



  Future addPhoto(_source) async {
    final pickedFile = await ImagePicker().getImage(source: _source);


    if (pickedFile != null) {

      imgCompress(pickedFile.path);
    } else {
      print('No image selected.');
    }

  }


    validation() async{
    if (name.value.length == 0) {
      showSnackBar("Error",  "Enter yor name", Colors.redAccent);
      return false;
    }
    if (mobile.value.length == 0) {
      showSnackBar("Error",  "Enter the mobile number", Colors.redAccent);
      return false;
    }
    if (confirmPassword.value.length<5   ) {
      showSnackBar("Error",  "Minimum password length should be 5 ", Colors.redAccent);
      return false;
    }
    if (confirmPassword.value!=password.value) {
      showSnackBar("Error",  "Please check your password", Colors.redAccent);
      return false;
    }
    if (base64Image.value.length == 0) {
      showSnackBar("Error",  "Please Select Image", Colors.redAccent);
      return false;
    }
    userRegister();
  }



  Future userRegister() async {
    indicatorLoader.value = true;
    Map<String, dynamic> map = {
      "number": mobile.value,
      "name": name.value,
      "password": password.value,
      "photo": base64Image.value
    };
    dynamic userData = await UserApiServices.userRegister(map);
    dynamic data = json.decode(userData.data);
    if (userData != null) {
      if (data['status'] == true) {
        indicatorLoader.value = false;
        Get.offAll(UserLogin());
        showSnackBar("Success", data['message'], Colors.green);
      } else {
        indicatorLoader.value = false;
        showSnackBar("Error", data['message'], Colors.redAccent);
      }
    } else {
      indicatorLoader.value = false;
      showSnackBar("Error", data['message'], Colors.redAccent);
    }
  }
}
