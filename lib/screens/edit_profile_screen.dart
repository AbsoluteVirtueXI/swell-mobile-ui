import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/models/video.dart';
import 'package:swell_mobile_ui/screens/take_picture_screen.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/models/product.dart';
import 'package:image_picker/image_picker.dart';


const BASE_URL = 'https://api.squarrin.com';


class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen(this.user);
  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool registered = false;
  bool _isUploading = false;
  final _bioController = TextEditingController();
  String _avatarPath;
  String _bio;


  @override
  void initState() {
    _isUploading = false;
    _avatarPath = widget.user.avatar.isEmpty ? 'images/no_image.png' : '${BASE_URL}/${widget.user.avatar}';
    _bio = widget.user.bio;
    _bioController.text = _bio;
  }

  callback(newPath) {
    setState(
        () {
          _avatarPath = newPath;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit profile"), centerTitle: true,),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _avatarPath.startsWith('https') ? Image.network(_avatarPath) : Image.asset(_avatarPath) ,
              RaisedButton(child: Text("Change picutre"), onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TakePictureScreen(callback)));
              },),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  hintText: 'Bio',
                  labelText: 'Enter something about you',
                  isDense: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a video description';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: _isUploading ? CircularProgressIndicator() : RaisedButton(

                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _bio = _bioController.text;

                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('update in progress')));
                      _upload(context, _avatarPath, _bio);
                      setState(() {
                        _isUploading = true;
                      });


                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(widget.secret)));
                    }
                  },
                  child: Text('Update'),
                ),
              ),
            ],
          )),
    );
  }

  _upload(BuildContext context, String avatar, String bio) async {
    if(_isUploading == true) {
      return null;
    }
    var api = Provider.of<ApiService>(context, listen: false);
    var user = Provider.of<User>(context, listen: false);
    var res = await api.updateProfile(user.id, avatar, bio);
    Navigator.pop(context);
  }
}