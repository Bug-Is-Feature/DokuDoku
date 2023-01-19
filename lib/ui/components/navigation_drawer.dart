import 'package:dokudoku/enums/NavigationItem.dart';
import 'package:flutter/material.dart';
import 'package:dokudoku/res/AppContextExtension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../provider/navigation_provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});
  static final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: context.resources.color.colorLighter,
        child: SingleChildScrollView(
          child: Container(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                buildMenuItems(context, NavigationItem.profile, 'Profile LV.2',
                    FontAwesomeIcons.userCircle),
                const SizedBox(height: 24),
                buildMenuItems(context, NavigationItem.achievements,
                    'Achievements', FontAwesomeIcons.star),
                const SizedBox(height: 24),
                buildMenuItems(context, NavigationItem.notesHistory,
                    'Note History', FontAwesomeIcons.history),
                const SizedBox(height: 24),
                buildMenuItems(context, NavigationItem.weeklyPlan,
                    'Weekly Plan', FontAwesomeIcons.calendarCheck),
                const SizedBox(height: 24),
                buildMenuItems(context, NavigationItem.settings, 'Setting',
                    Icons.settings_outlined),
                const SizedBox(height: 24),
                Divider(color: context.resources.color.colorDarkest),
                const SizedBox(height: 24),
                buildMenuItems(context, NavigationItem.settings,
                    'Setting Notification', Icons.settings_outlined),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
    );
  }

  Widget buildMenuItems(
      BuildContext context, NavigationItem item, String text, IconData icon) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: isSelected,
        selectedTileColor: context.resources.color.colorLightest,
        leading: Icon(icon, color: context.resources.color.colorDarkest),
        title: Text(text, style: Theme.of(context).textTheme.subtitle1),
        onTap: () {},
      ),
    );
  }
}
