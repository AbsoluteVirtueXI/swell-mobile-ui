import 'package:flutter/material.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/screens/play_video.dart';
import 'package:swell_mobile_ui/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/models/video.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/models/product.dart';

// TODO should check if register

class UploadScreen extends StatelessWidget {
  final String filePath;
  final String media_type;

  UploadScreen(this.filePath, this.media_type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<User>(
          builder: (context, profile, child) {
            if (profile != null) {
              return UploadProductForm(filePath, media_type);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class UploadProductForm extends StatefulWidget {
  final String filePath;
  final String media_type;

  UploadProductForm(this.filePath, this.media_type);

  @override
  UploadProductFormState createState() => UploadProductFormState();
}

class UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  bool registered = false;
  final _bioController = TextEditingController();
  final _priceController = TextEditingController();
  final _video = UploadProduct();

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
                      _video.description = _bioController.text;
                      _video.price = int.parse(_priceController.text);
                      _video.seller_id =
                          Provider.of<User>(context, listen: false).id;
                      _video.media_type =  widget.media_type;
                      _video.product_type = "REAL";

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

  _upload(BuildContext context, UploadProduct product) async {
    var api = Provider.of<ApiService>(context, listen: false);
    var res = await api.uploadProduct(product);
    /*Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));*/
    Navigator.pop(context);
  }
}
