import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:min3_minstag_ram/data_models/location.dart';
import 'package:min3_minstag_ram/model/database/database_manager.dart';
import 'package:min3_minstag_ram/model/location/location_manager.dart';
import 'package:min3_minstag_ram/util/constants.dart';




class PostRepository {

  final DatabaseManager dbManager;
  final LocationManager locationManager;
  PostRepository({this.dbManager, this.locationManager});


  Future<File> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();
    if(uploadType == UploadType.GALLERY) {
      // return await imagePicker.getImage(source: ImageSource.gallery);
      /// [A value of type 'PickedFile' can't be returned from method 'pickImage' because it has a return type of 'Future<File>'.]
      final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
      return File(pickedImage.path);
    } else {
      final pickedImage = await imagePicker.getImage(source: ImageSource.camera);
      return File(pickedImage.path);
    }


  }

  Future<Location> getCurrentLocation() async {
  // Future<void> getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }





}