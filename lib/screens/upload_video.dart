import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/models/video.dart';
import 'package:swell_mobile_ui/services/api_service.dart';

// TODO should check if register

class UploadScreen extends StatelessWidget {
  String filePath;

  UploadScreen(this.filePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<User>(
          builder: (context, profile, child) {
            if (profile != null) {
              return UploadVideoForm(filePath);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class UploadVideoForm extends StatefulWidget {
  final String filePath;

  UploadVideoForm(this.filePath);

  @override
  UploadVideoFormState createState() => UploadVideoFormState();
}

class UploadVideoFormState extends State<UploadVideoForm> {
  final _formKey = GlobalKey<FormState>();
  bool registered = false;
  final _titleController = TextEditingController();
  final _bioController = TextEditingController();
  final _priceController = TextEditingController();
  final _video = UploadVideo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  labelText: 'Enter video title',
                  isDense: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a video title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  labelText: 'Enter video description',
                  isDense: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a video description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: 'Price',
                  labelText: 'Enter a price',
                  isDense: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _video.localPath = widget.filePath;
                      _video.title = _titleController.text;
                      _video.bio = _bioController.text;
                      _video.price = int.parse(_priceController.text);
                      _video.ownerId =
                          Provider.of<User>(context, listen: false).id;

                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('upload in progress')));
                      _upload(context, _video);
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(widget.secret)));
                    }
                  },
                  child: Text('Upload'),
                ),
              ),
            ],
          )),
    );
  }

  _upload(BuildContext context, UploadVideo video) async {
    var api = Provider.of<ApiService>(context, listen: false);
    var res = await api.uploadVideo(video);
    /*Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));*/
    Navigator.pop(context);
  }
}
