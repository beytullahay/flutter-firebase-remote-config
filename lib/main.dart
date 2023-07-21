// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Hide the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Remote Config',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // renkleri direkt olarak background'a veremediğimiz için gelen renge göre Colors tipinde yazdırıyoruz
  final Map<String, dynamic> _availableBackgroundColors = {
    "pink": Colors.pink,
    "amber": Colors.amber,
    "red": Colors.red,
    "white": Colors.white,
    "blue": Colors.blue,
    "brown": Colors.brown,
    "green": Colors.green,
    "black": Colors.black,
  };

  final String _defaultBannerText = "İyi Günler";
  final String _defaultBackgroundColor = "white";

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1), // fetch, zaman aşımına uğramadan önce 10 saniyeye kadar bekler
      minimumFetchInterval: const Duration(seconds: 10), // minimum önbelleğe alma süresi
    ));

    _fetchConfig();
  }

// Uzak yapılandırmayı alma (Fetching), önbelleğe alma(caching) ve etkinleştirme(remote config)
  void _fetchConfig() async {
    await _remoteConfig.fetchAndActivate();
  }

  @override
  void initState() {
    _initConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _availableBackgroundColors[_remoteConfig.getString('background_color').isNotEmpty
          ? _remoteConfig.getString('background_color')
          : _defaultBackgroundColor],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('REMOTE CONFİG'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.network("https://www.converge.it/sites/default/files/novita-apple-2022.jpg"),
                  const Positioned(
                    top: 100,
                    right: 30,
                    child: Text(
                      'Apple Store',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                color: _availableBackgroundColors[_remoteConfig.getString('card_color').isNotEmpty
                    ? _remoteConfig.getString('card_color')
                    : _defaultBackgroundColor],
                elevation: 9,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _remoteConfig.getString('banner_text').isNotEmpty // boş değilse
                        ? _remoteConfig.getString('banner_text')
                        : _defaultBannerText,
                    style: TextStyle(
                      fontSize: _remoteConfig.getDouble('text_size'),
                    ),
                  ),
                ),
              ),

              // Sosyal Medya Row'u
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _remoteConfig.getString('youtube_link').isNotEmpty
                      ? GestureDetector(
                          child: Image.network(_remoteConfig.getString('youtube_image'), scale: 12),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_remoteConfig.getString('youtube_link')),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(width: 5),
                  _remoteConfig.getString('linkedin_link').isNotEmpty
                      ? GestureDetector(
                          child: Image.network(_remoteConfig.getString('linkedin_image'), scale: 20),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_remoteConfig.getString('linkedin_link')),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(width: 5),
                  _remoteConfig.getString('instagram_link').isNotEmpty
                      ? GestureDetector(
                          child: Image.network(_remoteConfig.getString('instagram_image'), scale: 16),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_remoteConfig.getString('instagram_link')),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(width: 5),
                  _remoteConfig.getString('telegram_link').isNotEmpty
                      ? GestureDetector(
                          child: Image.network(_remoteConfig.getString('telegram_image'), scale: 60),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_remoteConfig.getString('telegram_link')),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(width: 5),
                  _remoteConfig.getString('twitter_link').isNotEmpty
                      ? GestureDetector(
                          child: Image.network(_remoteConfig.getString('twitter_image'), scale: 70),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_remoteConfig.getString('twitter_link')),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
