import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/views/camera_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [appBar()],
        body: ListView(
          children: [
            loginform(),
          ],
        ),
      ),
    );
  }

  late String? username;

  @override
  void initState() {
    super.initState();
  }

  SliverAppBar appBar() {
    return const SliverAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person),
          SizedBox(width: 10),
          Text('Perfil', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      snap: true,
      floating: true,
    );
  }

  // Future login() async {
  //   try {
  //     await AuthService().login(email.text, senha.text);
  //     print("${email.text}, ${senha.text}");
  //   } on AuthException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(e.message)),
  //     );
  //     print(e.message);
  //   }
  // }

  loginform() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      AuthService().usuario?.photoURL ??
                          'https://img.icons8.com/ios-glyphs/90/user-male-circle.png',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.6),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Trocar foto de perfil"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(),
                    fullscreenDialog: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: () => AuthService().logout(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Deslogar",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
