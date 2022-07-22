import 'package:firebase/registerpage.dart';
import 'package:firebase/storagepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

//
// void main() {
//   runApp(MaterialApp(
//     home: frbase(),
//   ));
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MaterialApp(
    home: frbase(),
  ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class frbase extends StatefulWidget {
  const frbase({Key? key}) : super(key: key);

  @override
  State<frbase> createState() => _frbaseState();
}

class _frbaseState extends State<frbase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WELCOME TO MY APP"), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/pic111.jpg"), fit: BoxFit.fill)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    labelText: "ENTER UR EMAIL", hintText: "ENTER EMAIL"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    labelText: "ENTER UR PASSWORD", hintText: "ENTER PASSWORD"),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text.trim(),
                      password: password.text.trim(),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }

                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return registerpage();
                    },
                  ));
                },
                icon: Icon(Icons.pending_actions),
                label: Text("register")),
            ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                icon: Icon(Icons.login),
                label: Text("LOGIN")),
            ElevatedButton.icon(
                onPressed: () {
                  signInWithGoogle().then((value) {
                    print(value);
                  });
                },
                icon: Icon(Icons.phonelink_lock),
                label: Text("link with google")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return storagepage();
                    },
                  ));
                },
                child: Center(child: Text("img")))
          ],
        ),
      ),
    );
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
