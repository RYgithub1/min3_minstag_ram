import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:min3_minstag_ram/util/constants.dart';




class PostRepository {


  Future<File> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();
    if(uploadType == UploadType.GALLERY) {
      return File(  (await imagePicker.getImage(source: ImageSource.gallery)).path  );
    } else {
      return File( (await imagePicker.getImage(source: ImageSource.camera)).path  );


    }


  }





}