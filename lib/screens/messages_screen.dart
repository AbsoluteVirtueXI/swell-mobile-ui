import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/models/message.dart';

const BASE_URL = 'https://api.squarrin.com';

class MessagesScreen extends StatelessWidget {
  final int myId;
  final int otherId;
  final String otherAvatar;
  final String otherUsername;

  const MessagesScreen(
      this.myId, this.otherAvatar, this.otherUsername, this.otherId);

  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
                backgroundImage: otherAvatar.isEmpty
                    ? AssetImage('images/no_image.png')
                    : NetworkImage("$BASE_URL/${otherAvatar}")),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
            ),
            Text('${otherUsername}'),
          ],
        ),
      ),
      body: StreamProvider<List<Message>>(
        create: (_) => api.allMessageStream(myId, otherId),
        catchError: (context, error) {
          print("IN Message CATCH ERROR");
          print(error.toString());
          return null;
        },
        lazy: false,
        child: Consumer<List<Message>>(builder: (context, messages, child) {
          if (messages == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      messages[index].sender == myId
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        constraints: BoxConstraints.loose(
                                            MediaQuery.of(context).size * 0.8),
                                        child: Text(
                                          "${messages[index].content}",
                                          softWrap: true,
                                        ))
                                  ],
                                )),
                          );
                        }),
                  ),
                  SendMessageBar(myId, otherId),
                ],
              );

          }
        }),
      ),
    );
  }
}

class SendMessageBar extends StatefulWidget {
  final int myId;
  final int otherId;

  SendMessageBar(this.myId, this.otherId);

  @override
  _SendMessageBarState createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar> {
  final _textController = TextEditingController();
  bool _showMic = true;

  _handleSubmittedLocal() async {
    final text = _textController.text;

    // deal with parent later
    var api = Provider.of<ApiService>(context, listen: false);
    var res = await api.sendMessage(widget.myId, widget.otherId, text);
    FocusScope.of(context).unfocus();
    _textController.clear();

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RoundInput(
              textController: _textController,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          GestureDetector(
            onTap: _handleSubmittedLocal,
            child: CircleAvatar(
              child: Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundInput extends StatelessWidget {
  final Color _color;
  final TextEditingController _textController;

  RoundInput({
    @required TextEditingController textController,
    color,
  })  : _textController = textController,
        _color = color ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: _color,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 8.0,
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 22.0, color: Colors.black),
                decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    focusedBorder: InputBorder.none),
                controller: _textController,
              ),
            ),
            Icon(
              Icons.attach_file,
              size: 30.0,
              color: Theme.of(context).hintColor,
            ),
            SizedBox(
              width: 8.0,
            ),
            Icon(
              Icons.camera_alt,
              size: 30.0,
              color: Theme.of(context).hintColor,
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
