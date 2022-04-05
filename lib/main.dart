import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;

  Future picImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }

      final imagePath = File(image.path);
      setState(() {
        this.image = imagePath;
      });
    } on PlatformException catch (e) {
      print(e);
      print('Failed to open camera');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Setting'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('My App'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.camera,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Choose option",
                    style: TextStyle(color: Colors.blue),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        const Divider(
                          height: 1,
                          color: Colors.blue,
                        ),
                        ListTile(
                          onTap: () async {
                            await picImage(ImageSource.gallery);
                            Navigator.pop(context);
                          },
                          title: const Text("Gallery"),
                          leading: const Icon(
                            Icons.account_box,
                            color: Colors.blue,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.blue,
                        ),
                        ListTile(
                          onTap: () async {
                            await picImage(ImageSource.camera);
                            Navigator.pop(context);
                          },
                          title: const Text("Camera"),
                          leading: const Icon(
                            Icons.camera,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // const Spacer(),
            image != null
                ? Image.file(image!)
                : Container(
                    color: Colors.red,
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo : add func to the increment button
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
