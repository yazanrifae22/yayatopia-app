import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yayatopia/blocs/home/picks/picks_cubit.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:yayatopia/pages/Main/app_bar/yayatopia_app_bar.dart';
import 'package:yayatopia/pages/Main/tabs/Home/widgets/circle.dart';

DateTime date1 = DateTime.now();
String f = DateFormat('MMM dd @ HH:MM a').format(date1);

class HomePage extends StatefulWidget {
  final BuildContext ctx;
  final VoidCallback openFilter;
  final VoidCallback openMenu;
  final Function search;

  const HomePage(
      {Key? key,
      required this.ctx,
      required this.openFilter,
      required this.openMenu,
      required this.search})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (BlocProvider.of<PicksCubit>(context).state is PicksInit)
      BlocProvider.of<PicksCubit>(context).getYayaTopPicks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Yayatopia_App_Bar(widget.ctx,
          openFilter: widget.openFilter,
          openMenu: widget.openMenu,
          search: widget.search),
      body: BlocConsumer<PicksCubit, PicksState>(
          builder: (context, state) {
            if (state is PicksLoading)
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.bluebuttons,
                ),
              );
            else if (state is PicksError)
              return Center(
                child: Text("Network Connection Error"),
              );
            else if (state is PicksFectched) {
              return SizedBox(
                  height: getProportionateScreenHeight(180) < 170
                      ? 170
                      : getProportionateScreenHeight(180),
                  child: Center(
                      child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.picks.length,
                    itemBuilder: (context, i) {
                      return Circol(
                        textunderimage: state.picks[i].title,
                        dateunderimage: state.picks[i].viewDate,
                        imagepath: state.picks[i].imageurl,
                        id: state.picks[i].activityId,
                      );
                    },
                  )));
            } else
              return SizedBox();
          },
          listener: (context, state) {}),
    );
  }
}
