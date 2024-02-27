import 'package:flutter/material.dart';
import 'package:flutter_app/modules/bottomBar/data/bloc/bottombar_bloc.dart';
import 'package:flutter_app/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  BottomBarScreenState createState() => BottomBarScreenState();
}

class BottomBarScreenState extends State<BottomBarScreen> {
  final _appColor = AppColors();
  final iconSize = 30.00;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomBarBloc(),
      child: BlocBuilder<BottomBarBloc, BottomBarState>(
        builder: (context, state) {
          return Scaffold(
            body: BlocProvider.of<BottomBarBloc>(context).screenList[
                BlocProvider.of<BottomBarBloc>(context).selectedTabindex],
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(8),
              color: _appColor.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      size: iconSize,
                      color: BlocProvider.of<BottomBarBloc>(context)
                                  .selectedTabindex ==
                              0
                          ? _appColor.purple
                          : null,
                    ),
                    onPressed: () {
                      context
                          .read<BottomBarBloc>()
                          .add(const ChangeBottomBarTabEvent(0));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.explore,
                      size: iconSize,
                      color: BlocProvider.of<BottomBarBloc>(context)
                                  .selectedTabindex ==
                              1
                          ? _appColor.purple
                          : null,
                    ),
                    onPressed: () {
                      context
                          .read<BottomBarBloc>()
                          .add(const ChangeBottomBarTabEvent(1));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.fiber_smart_record_sharp,
                      size: iconSize,
                      color: BlocProvider.of<BottomBarBloc>(context)
                                  .selectedTabindex ==
                              2
                          ? _appColor.purple
                          : null,
                    ),
                    onPressed: () {
                      context
                          .read<BottomBarBloc>()
                          .add(const ChangeBottomBarTabEvent(2));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      size: iconSize,
                      color: BlocProvider.of<BottomBarBloc>(context)
                                  .selectedTabindex ==
                              3
                          ? _appColor.purple
                          : null,
                    ),
                    onPressed: () {
                      context
                          .read<BottomBarBloc>()
                          .add(const ChangeBottomBarTabEvent(3));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
