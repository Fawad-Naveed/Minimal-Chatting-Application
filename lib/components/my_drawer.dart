import 'package:flutter/material.dart';
import 'package:chatting/pages/settingsPage.dart';
import 'package:chatting/services/auth/auth_service.dart';
class my_drawer  extends StatelessWidget {
  const my_drawer ({super.key});
  void signout()
  {
    final _signout_auth=AuthService();
    _signout_auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //logo
            Theme(
            data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(color: Colors.transparent),
            ),
            child: DrawerHeader(
              decoration: BoxDecoration(), // Remove the default shadow/border
              child: Center(
              child: Column(
                children: [
                  Icon(Icons.all_inclusive_outlined,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text("YapYap",
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
                
            ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                //home list tile
                Padding(padding: EdgeInsets.only(left:10),
                child: ListTile(
                  leading: Icon(Icons.home,color: Theme.of(context).colorScheme.primary,),
                  title: Text("Home", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ),
                //setting list tile
                Padding(padding: EdgeInsets.only(left:10,),
                  child: ListTile(
                    leading: Icon(Icons.settings,color: Theme.of(context).colorScheme.primary,),
                    title: Text("Settings",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                    },
                  ),
                ),
              ],
            ),
          ),
          //logout list tile
          Padding(padding: EdgeInsets.only(left:10,bottom: 10),
            child: ListTile(
              leading: Icon(Icons.logout,color: Theme.of(context).colorScheme.primary,),
              title: Text("Logout",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              onTap: () {
                signout();
              },
            ),
          )
        ],
      )
    );
  }
}