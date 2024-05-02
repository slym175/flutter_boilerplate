import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:metalbox/screens/login_page.dart';
import 'package:metalbox/utils/extensions/ext_number.dart';

extension ExtContext on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this)!;

  Size get sizeOf => MediaQuery.of(this).size;

  EdgeInsets get padding => MediaQuery.of(this).padding;

  void requestFocus({FocusNode? focus}) {
    FocusScope.of(this).requestFocus(focus);
  }

  void unFocus({FocusNode? focus}) {
    if (focus != null) {
      focus.unfocus();
    } else {
      FocusScope.of(this).unfocus();
    }
  }

  dynamic nextPage(
    Widget page, {
    bool isNewTask = false,
    bool login = false,
    PageRouteAnimation? pageRouteAnimation,
    Duration? duration,
  }) async {
    final Widget child = login ? const LoginPage() : page;
    if (isNewTask) {
      return await Navigator.of(this).pushAndRemoveUntil(
        _router(
          child,
          duration: duration,
          pageRouteAnimation: pageRouteAnimation,
        ),
        (route) => false,
      );
    } else {
      return await Navigator.of(this).push(
        _router(
          child,
          duration: duration,
          pageRouteAnimation: pageRouteAnimation,
        ),
      );
    }
  }

  Future<dynamic> modalBottomSheet(
    Widget child, {
    bool isScrollControlled = true,
    bool useSafeArea = true,
  }) {
    return showModalBottomSheet(
      context: this,
      builder: (context) => child,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      backgroundColor: Colors.transparent,
      //shape: RoundedRectangleBorder(borderRadius: 20.radiusTop),
    );
  }

  Future<dynamic> dialog(Widget child) {
    return showDialog(
      context: this,
      builder: (context) => child,
    );
  }

  dynamic back({dynamic result}) async {
    Navigator.pop(this, result);
  }

  PageRouteBuilder<void> _router(
    Widget child, {
    PageRouteAnimation? pageRouteAnimation,
    Duration? duration,
  }) {
    if (pageRouteAnimation != null) {
      if (pageRouteAnimation == PageRouteAnimation.fade) {
        return PageRouteBuilder(
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return FadeTransition(opacity: anim, child: child);
          },
          transitionDuration: duration ?? 400.milliseconds,
        );
      } else if (pageRouteAnimation == PageRouteAnimation.rotate) {
        return PageRouteBuilder(
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return RotationTransition(
              turns: ReverseAnimation(anim),
              child: child,
            );
          },
          transitionDuration: duration ?? 400.milliseconds,
        );
      } else if (pageRouteAnimation == PageRouteAnimation.scale) {
        return PageRouteBuilder(
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return ScaleTransition(scale: anim, child: child);
          },
          transitionDuration: duration ?? 400.milliseconds,
        );
      } else if (pageRouteAnimation == PageRouteAnimation.slide) {
        return PageRouteBuilder(
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            );
          },
          transitionDuration: duration ?? 400.milliseconds,
        );
      } else if (pageRouteAnimation == PageRouteAnimation.slideBottomTop) {
        return PageRouteBuilder(
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            );
          },
          transitionDuration: duration ?? 400.milliseconds,
        );
      }
    }
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => child,
      transitionsBuilder: (c, anim, a2, child) {
        return FadeTransition(opacity: anim, child: child);
      },
      transitionDuration: duration ?? 400.milliseconds,
    );
  }
}

enum PageRouteAnimation { fade, scale, rotate, slide, slideBottomTop }
