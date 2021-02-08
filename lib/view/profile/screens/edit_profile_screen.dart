import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/view/common/circle_photo.dart';
import 'package:min3_minstag_ram/view/common/confirm_dialog.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




/// [EDIT: ful]
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}




class _EditProfileScreenState extends State<EditProfileScreen> {
  String _photoUrl = "";
  bool _isImageFromFile = false;   /// [image from: network or deviceFile: 通常は(false)network]
  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final profileUser = profileViewModel.profileUser;
    _isImageFromFile = false;
    _photoUrl = profileUser.photoUrl;

    /// [name/bioのedit: TextField変更時のハンドリング]
    _nameController.text = profileUser.inAppUserName;
    _bioController.text = profileUser.bio;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(S.of(context).editProfile),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            /// onPressed: showConfirmDialog(   [()=>ERROR]
            onPressed: () => showConfirmDialog(
              context: context,
              title: S.of(context).editProfile,
              content: S.of(context).editProfileConfirm,
              onConfirmed: (isConfirmed) {
                if (isConfirmed){
                  _updateProfile(context);
                }
              },
            ),
          ),
        ],
      ),

      body: Consumer<ProfileViewModel>(   /// [Circular欲しいのでconsumer]
        builder: (_, model, child) {
          return model.isProcessing
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 16.0),
                        Center(
                          child: CirclePhoto(
                            photoUrl: _photoUrl,   /// [profileのphotoが欲しい -> ProfileViewModel]
                            radius: 60.0,
                            isImageFromFile: _isImageFromFile,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Center(
                          child: InkWell(
                            onTap: () => _pickNewFileImage(),
                            child: Text(
                              S.of(context).changeProfilePhoto,
                              style: changeProfilePhotoTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          // "name",
                          "name",
                          style: editProfileTitleTextStyle,
                        ),
                        TextField(
                          controller: _nameController,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          // "bio",
                          "bio",
                          style: editProfileTitleTextStyle,
                        ),
                        TextField(
                          controller: _bioController,
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }



  /// [PresentNoReturn, NoArgu, getFuture]
  /// [photo: ネットワークからorデバイスから]
  Future<void> _pickNewFileImage() async {
    _isImageFromFile = false;
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    _photoUrl = await profileViewModel.pickProfileImage();
    setState(() {
      _isImageFromFile = true;  /// [取得できなたらtrue]
    });
  }



  /// [PresentNoReturn, NoArgu, getFuture]
  void _updateProfile(BuildContext context) async {
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);

    await profileViewModel.updateProfile(   /// [profile更新の対象を引数に]
      _photoUrl,
      _isImageFromFile,
      _nameController.text,
      _bioController.text,
    );
    /// [処理後画面閉じる]
    Navigator.pop(context);
  }



}