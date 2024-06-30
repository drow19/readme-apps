import 'dart:io';

import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_shadow.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/ui/home/user/user_screen_provider.dart';
import 'package:book_store_apps/widgets/appbar/m_appbar.dart';
import 'package:book_store_apps/widgets/cache_image/m_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_store_apps/utils/extention/extention.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/user';

  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserScreenProvider provider;

  @override
  void initState() {
    super.initState();

    provider = context.read<UserScreenProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchUser();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.watch<UserScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    const defaultAvatar =
        'https://st.depositphotos.com/2101611/4338/v/450/depositphotos_43381243-stock-illustration-male-avatar-profile-picture.jpg';

    return Scaffold(
      appBar: const MAppBar(title: 'List Of User'),
      body: provider.listOfUser.isNotEmpty
          ? ListView(
              padding: const EdgeInsets.all(20),
              children: provider.listOfUser
                  .map(
                    (user) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: MColors.n6,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [MShadow.p3Shadow3]),
                      child: ListTile(
                        leading: (user.avatar?.isEmpty ?? false) ||
                                user.avatar == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child:
                                    const MCacheImage(imagePath: defaultAvatar),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  File(user.avatar ?? ''),
                                ),
                              ),
                        title: Text(user.username?.capitalize() ?? '-'),
                        titleTextStyle: MTypography.caption1.copyWith(
                          color: MColors.p1,
                        ),
                        subtitle: Text(
                          "This user have ${user.favorite?.length ?? 0} favorite book's",
                        ),
                        subtitleTextStyle: MTypography.caption1.copyWith(
                          color: MColors.p1,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          : Text("There is no account has registered"),
    );
  }
}
