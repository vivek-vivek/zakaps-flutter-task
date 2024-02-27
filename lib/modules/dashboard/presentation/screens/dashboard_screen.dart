import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/modules/dashboard/data/bloc/dashboard_bloc.dart';
import 'package:flutter_app/modules/dashboard/data/models/locatiion_model.dart';
import 'package:flutter_app/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _appColors = AppColors();
  final _widgets = DashboardCustomeWidgets();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: _appColors.background,
                body: SafeArea(
                  child: Stack(
                    children: [
                      _widgets.backgroundContainerCurved(context),
                      _widgets.buildAppBar(context, _formKey),
                      _widgets.headingText(context, "Bus"),
                      _widgets.buildLocationList(context, _formKey)
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
