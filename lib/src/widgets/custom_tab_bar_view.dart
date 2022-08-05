import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class CustomTabBarView extends StatefulWidget {
  final List<String> tabs_titles_list;
  final TabController tabController;
  final List<Widget> tab_children_layouts;
  final BorderRadiusGeometry? borderRadius;
  final bool? showTopShadow;
  final bool? isScrollable;
  final bool? removePadding;

  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();

  CustomTabBarView(
      {
      required this.tabs_titles_list,
      required this.tabController,
      required this.tab_children_layouts,
      this.borderRadius,
      this.showTopShadow,
      this.isScrollable,
      this.removePadding});
}

class _CustomTabBarViewState extends State<CustomTabBarView> with TickerProviderStateMixin {

  @override
  void initState() {
    int length = widget.tabController.length;
    if (widget.tabs_titles_list.length != widget.tab_children_layouts.length){
      throw 'Tab layouts and titles must of same lengths';
    }
    else if (widget.tab_children_layouts.length != length || widget.tabs_titles_list.length != length){
      throw 'TabController length is not equal to length of provided tabs list';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TabBar(
            // indicator: BoxDecoration(
            //     color: Colors.redAccent,
            //     borderRadius: BorderRadius.circular(50)),
            controller: widget.tabController,
            unselectedLabelColor: Colors.grey,
            isScrollable: widget.isScrollable ?? false,
            labelColor: appPrimaryColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, fontFamily: "Outfit"),
            indicatorColor: appPrimaryColor,
            physics: BouncingScrollPhysics(),
            tabs: getTabBarTitlesToTabs(widget.tabs_titles_list),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: widget.borderRadius,
            boxShadow: (widget.showTopShadow == null || widget.showTopShadow == true) ? [BoxShadow(blurRadius: 10, color: Color(0x414D5678))] : null,
          ),
        ),
        Expanded(
          child: Container(
            padding: (widget.removePadding != null && widget.removePadding == true) ? EdgeInsets.zero : EdgeInsets.all(8),
            child: TabBarView(
              controller: widget.tabController,
              children: widget.tab_children_layouts,
            ),
          ),
        )
      ],
    );
  }
}

List<Widget> getTabBarTitlesToTabs(List<String> tabBarTitles) {
  return tabBarTitles
      .map((e) => Tab(
            text: e,
          ))
      .toList();
}
