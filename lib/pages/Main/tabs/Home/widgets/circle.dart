import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yayatopia/blocs/home/activities/cubit/activities_cubit.dart';
import 'package:yayatopia/config/colors.dart';
import 'package:yayatopia/config/size_config.dart';
import 'package:yayatopia/pages/Main/tabs/Home/activity_detail_page.dart';
import 'package:yayatopia/pages/Main/tabs/Home/widgets/edited_dashed_circle.dart';

// ignore: must_be_immutable
class Circol extends StatefulWidget {
  String textunderimage;
  String dateunderimage;
  String imagepath;
  int id;
  Circol({
    required this.imagepath,
    required this.dateunderimage,
    required this.textunderimage,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _CircolState createState() => _CircolState();
}

class _CircolState extends State<Circol> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> base;

  late Animation<double> inverted;

  late Animation<double> gap;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    inverted = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 5.0, bottom: 2.0, right: 25.0, left: 25.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform.scale(
                    scale: 1.1,
                    child: CachedNetworkImage(
                      placeholder: (context, i) {
                        return Container(
                            width: getProportionateScreenHeight(70),
                            height: getProportionateScreenHeight(70),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('assets/axa2.png'),
                                    fit: BoxFit.fill)));
                      },
                      imageUrl: widget.imagepath,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                            width: getProportionateScreenHeight(70),
                            height: getProportionateScreenHeight(70),
                            decoration: BoxDecoration(

                                shape: BoxShape.circle,
                                image: DecorationImage(

                                    image: imageProvider, 
                                    fit: BoxFit.fitHeight
                                )));
                      },
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (BuildContext ctx) => ActivitiesCubit(),
                              child: ActivityPage(widget.id),
                            ),
                          ));
                    },
                    child: Container(
                      width: getProportionateScreenHeight(70),
                      height: getProportionateScreenHeight(70),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: RotationTransition(
                        turns: inverted,
                        child: DashedCircle(
                          strokeWidth: 0,
                          color: Colors.white,
                          child: RotationTransition(
                            turns: inverted,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
            width: getProportionateScreenWidth(95),
            child: Text(
              widget.textunderimage,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: getProportionateScreenWidth(12),
                  color: AppColors.black3,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
            )),
        SizedBox(
          // width: getProportionateScreenWidth(80),
          child: Text(
            widget.dateunderimage,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: getProportionateScreenWidth(10),
                fontWeight: FontWeight.bold,
                color: AppColors.bluebuttons),
          ),
        ),
      ],
    );
  }
}
