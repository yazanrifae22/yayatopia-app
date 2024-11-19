import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:yayatopia/pages/Main/sheets/filter_sheet_content.dart';
import 'package:yayatopia/pages/Main/tabs/Activity/activity_page.dart';
import 'package:yayatopia/pages/Main/tabs/Home/home_page.dart';
import 'package:yayatopia/pages/Main/tabs/Profile/profile_view.dart';
import 'bottom_bar/fancy_bottom_navigation.dart';
import 'sheets/menu_sheet_content.dart';
import 'sheets/sheet_grabbing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  static String routeName = 'main';
  MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final SnappingSheetController menuSheetController = SnappingSheetController();

  final ScrollController menuScrollController = ScrollController();

  final SnappingSheetController filterSheetController =
      SnappingSheetController();
  String searchText = '';
  bool tr = false;
  final ScrollController filterScrollController = ScrollController();
  int selectedItem = 0;
  int previousItem = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  // Nav Keys
  final GlobalKey<NavigatorState> profileNavigatorKey =
      GlobalKey<NavigatorState>();

  search(value) {
    setState(() {
      selectedItem = 2;
      (bottomNavigationKey.currentState as FancyBottomNavigationState)
          .setPage(2);
      searchText = value;
    });
  }

  closeMenu() {
    menuSheetController.snapToPosition(
      SnappingPosition.factor(
        grabbingContentOffset: GrabbingContentOffset.top,
        positionFactor: 1.0,
      ),
    );
  }

  openMenu() {
    menuSheetController.snapToPosition(
      SnappingPosition.factor(
        grabbingContentOffset: GrabbingContentOffset.bottom,
        positionFactor: 0.15,
      ),
    );
  }

  openFilter() {
    filterSheetController.snapToPosition(
      SnappingPosition.factor(
        grabbingContentOffset: GrabbingContentOffset.bottom,
        positionFactor: 1.0,
      ),
    );
    tr = true;
  }

  closeFilter() {
    filterSheetController.snapToPosition(SnappingPosition.factor(
      grabbingContentOffset: GrabbingContentOffset.bottom,
      positionFactor: 0.0,
    ));
    tr = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        if (selectedItem == 3)
          return !await profileNavigatorKey.currentState!.maybePop();
        return true;
      },
      child: SnappingSheet(
        lockOverflowDrag: false,
        snappingPositions: [
          SnappingPosition.factor(
            grabbingContentOffset: GrabbingContentOffset.top,
            positionFactor: 1.0,
          ),
          SnappingPosition.factor(
            positionFactor: 0.15,
            grabbingContentOffset: GrabbingContentOffset.bottom,
          ),
        ],
        controller: menuSheetController,
        grabbingHeight: MediaQuery.of(context).size.height * 0.15,
        sheetAbove: SnappingSheetContent(
            childScrollController: menuScrollController,
            draggable: true,
            child: MenuSheetContent(
              scrollController: menuScrollController,
            )),
        grabbing: GestureDetector(
            onTap: () {
              closeMenu();
            },
            child: SheetGrabbing(
              reverse: false,
            )),
        child: Scaffold(
          bottomNavigationBar: FancyBottomNavigation(
            barBackgroundColor: AppColors.white,
            circleColor: AppColors.bluebuttons,
            inactiveIconColor: AppColors.orange,
            textColor: AppColors.bluebuttons,
            tabs: [
              TabData(
                title: AppLocalizations.of(context)!.home,
                iconData: Icons.home,
              ),
              TabData(
                  title: AppLocalizations.of(context)!.explore,
                  iconData: FontAwesomeIcons.globeAmericas),
              TabData(
                  title: AppLocalizations.of(context)!.favorites,
                  iconData: Icons.favorite),
              TabData(
                title: AppLocalizations.of(context)!.profile,
                iconData: Icons.person_pin_circle_rounded,
              ),
            ],
            initialSelection: 0,
            key: bottomNavigationKey,
            onTabChangedListener: (int i) {
              setState(() {
                selectedItem = i;
              });
            },
          ),
          body: SnappingSheet(
            controller: filterSheetController,
            grabbing: SheetGrabbing(
              reverse: true,
            ),
            grabbingHeight: MediaQuery.of(context).size.height * 0.2,
            lockOverflowDrag: false,
            snappingPositions: [
              SnappingPosition.factor(
                grabbingContentOffset: GrabbingContentOffset.bottom,
                positionFactor: 0.0,
              ),
              SnappingPosition.factor(
                positionFactor: 1.0,
                grabbingContentOffset: GrabbingContentOffset.bottom,
              ),
            ],
            sheetBelow: SnappingSheetContent(
                childScrollController: filterScrollController,
                draggable: true,
                child: FilterSheetContent(
                  scrollController: filterScrollController,
                )),
            child: Scaffold(
              body: _getpage(selectedItem),
            ),
          ),
        ),
      ),
    );
  }

  _getpage(int selectedItem) {
    switch (selectedItem) {
      case 0:
        previousItem = 0;
        if (tr) closeFilter();
        return HomePage(
            search: search,
            ctx: context,
            openFilter: openFilter,
            openMenu: openMenu);
      case 1:
        if (previousItem != 1) openFilter();
        previousItem = 1;
        return HomePage(
            search: search,
            ctx: context,
            openFilter: openFilter,
            openMenu: openMenu);

      case 2:
        previousItem = 2;
        if (tr) closeFilter();
        return activity_page(
          searchText: searchText,
          ctx: context,
          openFilter: openFilter,
          openMenu: openMenu,
        );
      case 3:
        previousItem = 3;
        if (tr) closeFilter();
        return ProfileView(
          navigatorKey: profileNavigatorKey,
        );
    }
  }
}
