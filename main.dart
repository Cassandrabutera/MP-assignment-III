import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'calculator.dart';
import 'contacts.dart';
import 'authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), 
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool _isDarkModeEnabled;
  late IconData _connectivityIcon;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); 
    _isDarkModeEnabled = false;
    _connectivityIcon = Icons.signal_wifi_off;

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityIcon = result == ConnectivityResult.none ? Icons.signal_wifi_off : Icons.wifi;

        Fluttertoast.showToast(
          msg: result == ConnectivityResult.none ? 'No internet connection' : 'Connected to the internet',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Fluttertoast.showToast(
                msg: _connectivityIcon == Icons.signal_wifi_off ? 'No internet connection' : 'Connected to the internet',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Color.fromARGB(255, 247, 14, 162),
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            child: Row(
              children: [
                Icon(_connectivityIcon),
                SizedBox(width: 8),
                Text(
                  'CassandraApp',
                  style: TextStyle(color: _isDarkModeEnabled ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
          backgroundColor: _isDarkModeEnabled ? Colors.black : Theme.of(context).primaryColor,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.calculate), text: 'Calculator'),
              Tab(icon: Icon(Icons.contact_mail), text: 'Contacts'),
              // Removed the Authentication tab
            ],
          ),
        ),
        drawer: Drawer(
          child: DrawerContent(
            tabController: _tabController,
            isDarkModeEnabled: _isDarkModeEnabled,
            toggleDarkMode: _toggleDarkMode,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Center(child: Text('Home Screen')),
            CalculatorApp(),
            ContactUsPage(),
            // Removed the Authentication tab
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleDarkMode() async {
    bool newValue = !_isDarkModeEnabled;
    setState(() {
      _isDarkModeEnabled = newValue;
    });
  }
}

class DrawerContent extends StatelessWidget {
  final TabController tabController;
  final bool isDarkModeEnabled;
  final Function toggleDarkMode;

  const DrawerContent({
    required this.tabController,
    required this.isDarkModeEnabled,
    required this.toggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: isDarkModeEnabled ? Colors.black : Theme.of(context).primaryColor,
          ),
          child: UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: isDarkModeEnabled ? Colors.black : Theme.of(context).primaryColor),
            accountName: Text("Cassandra Butera", style: TextStyle(fontSize: 18)),
            accountEmail: Text("cassandrabutera01@gmail.com"),
            currentAccountPictureSize: Size.square(50),
            currentAccountPicture: CircleAvatar(backgroundColor: Color.fromARGB(255, 248, 181, 244)),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            tabController.animateTo(0);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.calculate),
          title: Text('Calculator'),
          onTap: () {
            tabController.animateTo(1);
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_mail),
          title: Text('Contacts'),
          onTap: () {
            tabController.animateTo(2);
            Navigator.pop(context);
          },
        ),
        // Removed the Authentication option from the Drawer
        ListTile(
          leading: Icon(Icons.brightness_4),
          title: Text('Toggle Dark Mode'),
          onTap: () {
            toggleDarkMode();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
