import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swell_mobile_ui/models/thread.dart';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/screens/messages_screen.dart';
import 'package:swell_mobile_ui/components/profile.dart';



const BASE_URL = 'https://api.squarrin.com';


class ThreadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var api = Provider.of<ApiService>(context, listen: false);
    var user = Provider.of<User>(context, listen: false);
    return StreamProvider<List<Thread>>(
        create: (_) => api.allThreadStream(user.id),
        catchError: (context, error) {
          print("IN THREAD CATCH ERROR");
          print(error.toString());
          return null;
        },
        lazy: false,
        child: Scaffold(
            appBar: AppBar(title: Text("Messages"), centerTitle: true,),
            body: Consumer<List<Thread>>(builder: (context, threads, child) {
              if (threads == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (threads.isEmpty) {
                  return Center(child: Text("No messages"));
                } else {
                  return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.blueGrey,
                      ),
                      itemCount: threads.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => MessagesScreen(
                                  user.id,
                                  threads[index].avatar,
                                  threads[index].username,
                                  threads[index].id
                                )));
                          },
                          child: ListTile(
                              leading: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileWidget(threads[index].id)
                                      ));
                                },
                                child: CircleAvatar(
                                  backgroundImage: threads[index].avatar.isEmpty ? AssetImage('images/no_image.png') : NetworkImage("$BASE_URL/${threads[index].avatar}"),
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("${threads[index].username}"),
                                  Text("${threads[index].created_at.toString().substring(0, 19)}", style: TextStyle(fontSize: 10, color: Colors.grey),)
                                ],
                              ),
                              subtitle: Text("${threads[index].content}", overflow: TextOverflow.ellipsis,),
                              trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        );
                          //Text("${threads[index].content}");
                      });
                }
              }
            })));
  }
}
