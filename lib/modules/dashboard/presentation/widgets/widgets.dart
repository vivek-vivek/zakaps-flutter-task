import 'package:flutter/material.dart';
import 'package:flutter_app/modules/login/presentation/screens/login_screens.dart';
import 'package:flutter_app/utils/app_colors.dart';
import 'package:flutter_app/utils/shared_prefrence.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/dashboard_bloc.dart';
import '../../data/models/locatiion_model.dart';

final class DashboardCustomeWidgets {
  final _appColors = AppColors();

  void showLogoutConfirmationDialog(BuildContext parrentContext) {
    showDialog(
      context: parrentContext,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false on cancel
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true); // Return true on confirmation
                await SharedPreferencesHelper().clearSharedPrefrence();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreens()),
                    (Route<dynamic> route) => false);
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  Widget headingText(BuildContext context, String title) {
    return Positioned(
      left: MediaQuery.sizeOf(context).width * 0.15,
      right: MediaQuery.sizeOf(context).width * 0.1,
      top: MediaQuery.sizeOf(context).height * 0.17,
      bottom: BlocProvider.of<DashboardBloc>(context).screenName == "screen-1"
          ? 5
          : null,
      child: BlocProvider.of<DashboardBloc>(context).screenName == "screen-1"
          ? Text(
              (BlocProvider.of<DashboardBloc>(context).locations.isNotEmpty
                  ? title
                  : ""),
              style: TextStyle(
                  fontSize: 40,
                  color: _appColors.white,
                  fontWeight: FontWeight.w800),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Location 1",
                  style: TextStyle(
                      color: _appColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: _appColors.white,
                ),
                Text(
                  "Location 1",
                  style: TextStyle(
                      color: _appColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
    );
  }

  // Ccureved backgoround container for the dashbord screen - 1
  Widget backgroundContainerCurved(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.4,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: _appColors.purple,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        const Expanded(child: SizedBox())
      ],
    );
  }

  Positioned buildLocationList(
      BuildContext parrentContext, GlobalKey<FormState> formKey) {
    return Positioned(
      left: MediaQuery.sizeOf(parrentContext).width * 0.1,
      right: MediaQuery.sizeOf(parrentContext).width * 0.1,
      top: MediaQuery.sizeOf(parrentContext).height * 0.25,
      bottom: 5,
      child: SizedBox(
        width: MediaQuery.sizeOf(parrentContext).width * 0.8,
        child: BlocProvider.of<DashboardBloc>(parrentContext).locations.isEmpty
            ? const Center(
                child: Text("No locations found !"),
              )
            : ListView.separated(
                itemBuilder: (context, i) => locationCard(
                  parrentContext,
                  BlocProvider.of<DashboardBloc>(parrentContext).locations[i],
                  formKey,
                  i,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: BlocProvider.of<DashboardBloc>(parrentContext)
                    .locations
                    .length,
              ),
      ),
    );
  }

  Widget locationCard(BuildContext context, LocationModel location,
      GlobalKey<FormState> formKey, id) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.2,
          width: MediaQuery.sizeOf(context).width * 0.8,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _appColors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // showAddLocationBottomSheet(context, formKey, id);
                  context
                      .read<DashboardBloc>()
                      .add(const ChangeScreenEvent(screenName: "screen-2"));
                },
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          locationIconWithText(
                            context: context,
                            color: Colors.green,
                            title: "From",
                            data: location.fromLocation ?? "N/A",
                            id: id,
                          ),
                          locationIconWithText(
                            context: context,
                            color: _appColors.purple,
                            title: "To",
                            data: location.toLocation ?? "N/A",
                            id: id,
                          )
                        ],
                      ),
                    ),
                    if (BlocProvider.of<DashboardBloc>(context).screenName ==
                        "screen-1") ...[
                      CircleAvatar(
                        backgroundColor: _appColors.purple,
                        radius: 25.0,
                        child: const Center(
                          child: Icon(Icons.mode_of_travel_sharp),
                        ),
                      ),
                    ] else if (BlocProvider.of<DashboardBloc>(context)
                            .screenName ==
                        "screen-2") ...[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "From location ",
                              style: TextStyle(
                                  color: _appColors.black, fontSize: 10),
                              children: [
                                TextSpan(
                                  text: "Kollam",
                                  style: TextStyle(
                                    color: _appColors.green,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              text: "Departed ",
                              style: TextStyle(
                                  color: _appColors.black, fontSize: 10),
                              children: [
                                TextSpan(
                                  text: "today",
                                  style: TextStyle(
                                    color: _appColors.green,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              text: "Price ",
                              style: TextStyle(
                                  color: _appColors.black, fontSize: 10),
                              children: [
                                TextSpan(
                                  text: "\$1,50",
                                  style: TextStyle(
                                    color: _appColors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 30,
                            width: MediaQuery.sizeOf(context).width * 0.25,
                            decoration: BoxDecoration(
                                color: _appColors.purple,
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                              child: Text(
                                "Book Ticket",
                                style: TextStyle(
                                    color: _appColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      )
                    ]
                  ],
                ),
              ),
              if (BlocProvider.of<DashboardBloc>(context).screenName ==
                  "screen-1")
                Positioned(
                  right: 0,
                  child: IconButton(
                    color: Colors.red.withOpacity(0.3),
                    onPressed: () {
                      context
                          .read<DashboardBloc>()
                          .add(RemoveLocationEvent(id: id));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Row locationIconWithText({
    required BuildContext context,
    required Color color,
    required String title,
    required String data,
    required int id,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 15.0,
          child: Center(
            child: Icon(
              Icons.location_on,
              color: _appColors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: TextStyle(
                color: _appColors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.3,
              child: Text(
                data,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _appColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Custom App bar
  Widget buildAppBar(
      BuildContext parrentContext, GlobalKey<FormState> formKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side button
          BlocProvider.of<DashboardBloc>(parrentContext).screenName ==
                  "screen-2"
              ? IconButton(
                  onPressed: () {
                    parrentContext
                        .read<DashboardBloc>()
                        .add(const ChangeScreenEvent(screenName: "screen-1"));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: _appColors.white,
                    size: 30,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    showLogoutConfirmationDialog(parrentContext);
                  },
                  icon: Icon(
                    Icons.more_horiz_sharp,
                    color: _appColors.white,
                    size: 45,
                  ),
                ),

          // Right side button
          BlocProvider.of<DashboardBloc>(parrentContext).screenName ==
                  "screen-2"
              ? IconButton(
                  onPressed: () {
                    showAddLocationBottomSheet(parrentContext, formKey);
                  },
                  icon: Icon(
                    Icons.more_horiz_sharp,
                    color: _appColors.white,
                    size: 45,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    showAddLocationBottomSheet(parrentContext, formKey);
                  },
                  icon: Icon(
                    Icons.add_circle_rounded,
                    color: _appColors.white,
                    size: 35,
                  ),
                )
        ],
      ),
    );
  }

  // dialog for aading a new location
  Future<dynamic> showAddLocationBottomSheet(
      BuildContext parrentContext, formkey,
      [id]) {
    final TextEditingController fromLocation = TextEditingController();
    final TextEditingController toLocation = TextEditingController();

    // For only data update purposes
    if (id != null) {
      fromLocation.text = BlocProvider.of<DashboardBloc>(parrentContext)
              .locations[id]
              .fromLocation ??
          "";
      toLocation.text = BlocProvider.of<DashboardBloc>(parrentContext)
              .locations[id]
              .toLocation ??
          "";
    }

    return showModalBottomSheet(
      context: parrentContext,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _appColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: MediaQuery.sizeOf(context).height * 0.5,
          width: MediaQuery.sizeOf(context).width,
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // From Location
                TextFormField(
                  controller: fromLocation,
                  style: TextStyle(color: _appColors.black, fontSize: 18),
                  decoration: inputDecoration("From Location"),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter from location";
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: toLocation,
                  style: TextStyle(color: _appColors.black, fontSize: 18),
                  decoration: inputDecoration("To Location"),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter to location";
                    }
                    return null;
                  },
                ),

                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      if (id != null) {
                        // UPDATEING
                        parrentContext.read<DashboardBloc>().add(
                            UpdateLocationEvent(
                                id: id,
                                fromLocation: fromLocation.text.trim(),
                                toLocation: toLocation.text.trim()));
                      } else {
                        parrentContext.read<DashboardBloc>().add(
                            AddLocationEvent(
                                fromLocation: fromLocation.text.trim(),
                                toLocation: toLocation.text.trim()));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: _appColors.purple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Add location",
                        style: TextStyle(
                          color: _appColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Common input decoration
  InputDecoration inputDecoration(hint) {
    return InputDecoration(
      focusColor: _appColors.purple,
      hintText: hint,
      hintStyle: TextStyle(
        color: _appColors.purple,
        fontSize: 18,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _appColors.purple),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _appColors.purple),
      ),
    );
  }
}
