import 'package:attendance_management/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _Model extends ChangeNotifier {
  _Model({
    this.locator,
  });

  Locator locator;

  AuthService get auth => locator();
}

class SettingsProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_Model>(
      create: (_context) => _Model(locator: context.read),
      child: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  static String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  buildImageBox(context),
                  const SizedBox(height: 10),
                  Text(
                    'kou 127',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          UserSettingButton(
                            title: 'Logout',
                            buttonPosition: ButtonPosition.top,
                            onTap: () {
                              context.read<AuthService>().signOut();
                            },
                          ),
                          UserSettingButton(
                            title: '',
                          ),
                          UserSettingButton(
                            title: '',
                          ),
                          UserSettingButton(
                            title: '',
                            buttonPosition: ButtonPosition.bottom,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageBox(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        height: 55,
        width: 55,
        child: ColoredBox(
          color: Theme.of(context).accentColor,
          child: Icon(
            Icons.account_circle,
            size: 55,
          ),
        ),
      ),
    );
  }
}

enum ButtonPosition {
  top,
  center,
  bottom,
}

extension ButtonPositionEx on ButtonPosition {
  borderRadius() {
    switch (this) {
      case ButtonPosition.top:
        return const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        );
      case ButtonPosition.bottom:
        return const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        );
      default:
        return const BorderRadius.only();
    }
  }
}

class UserSettingButton extends StatelessWidget {
  const UserSettingButton({
    Key key,
    this.buttonPosition,
    this.title,
    this.onTap,
  }) : super(key: key);

  final ButtonPosition buttonPosition;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: buttonPosition.borderRadius(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 18),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 23,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}