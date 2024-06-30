import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_shadow.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/ui/home/profile/profile_screen_provider.dart';
import 'package:book_store_apps/ui/home/user/user_screen.dart';
import 'package:book_store_apps/utils/extention/extention.dart';
import 'package:book_store_apps/widgets/button/m_button.dart';
import 'package:book_store_apps/widgets/button/m_large_button.dart';
import 'package:book_store_apps/widgets/cache_image/m_cache_image.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileScreenProvider provider;

  @override
  void initState() {
    super.initState();

    provider = context.read<ProfileScreenProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.initial();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.watch<ProfileScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _PersistentHeader(provider),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 80,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      provider.user.username?.capitalize() ?? '-',
                      style: MTypography.body3.copyWith(color: MColors.p1),
                    ),
                  ),
                  if(provider.listOfBooks.isNotEmpty) ... [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "You've seen this book",
                        style: MTypography.body3.copyWith(color: MColors.p1),
                      ),
                    ),
                    ListView.builder(
                      itemCount: provider.listOfBooks.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final book = provider.listOfBooks[index];

                        return ListTile(
                          onTap: () => provider.goToDetailBooks(context, book),
                          tileColor: MColors.n6,
                          title: Text(
                            book.title ?? '-',
                            style:
                            MTypography.caption1.copyWith(color: MColors.p1),
                          ),
                          leading: const Icon(Icons.book),
                        );
                      },
                    ),
                  ] else ... [
                    Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Look like you have not read any books :(',
                        style: MTypography.caption1.copyWith(color: MColors.n1),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FractionallySizedBox(
        widthFactor: .9,
        child: MLargeButton(
          onPressed: () => provider.signOut(context),
          title: 'Sign Out',
          buttonColor: MColors.red,
          typeButton: MTypeButton.filled,
        ),
      ),
    );
  }
}

class _PersistentHeader extends SliverPersistentHeaderDelegate {
  _PersistentHeader(this.provider);

  double headerHeight = 250.0;
  final floatingHeight = 150.0;
  final ProfileScreenProvider provider;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final floatingTop = headerHeight - floatingHeight / 2;
    final percentage = (headerHeight - shrinkOffset) / headerHeight;

    const backgroundImg =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAF3jvkhiHrC4W-Vu9J_0A1kvni4C5qZrj1w&s';
    const defaultAvatar =
        'https://st.depositphotos.com/2101611/4338/v/450/depositphotos_43381243-stock-illustration-male-avatar-profile-picture.jpg';

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        MCacheImage(
          imagePath: backgroundImg,
          errorWidget: (context, val, w) => const MCacheImage(
            imagePath: backgroundImg,
          ),
        ),
        Positioned(
          top: floatingTop - shrinkOffset,
          right: 40,
          child: Opacity(
            opacity: percentage,
            child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: MColors.n6,
                shape: BoxShape.circle,
                boxShadow: [MShadow.p3Shadow3],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      provider.avatar.path.isEmpty || provider.avatar.path == ''
                          ? const NetworkImage(defaultAvatar) as ImageProvider
                          : FileImage(provider.avatar),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Container(
            height: kToolbarHeight + 50,
            color: percentage == 0 ? MColors.n5 : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _popupMenu(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showModalDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Image From',
            style: MTypography.title.copyWith(color: MColors.p1),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                onTap: () {
                  provider.switchAttachment('camera');
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  'Take a photo',
                  style: MTypography.caption1.copyWith(color: MColors.p1),
                ),
              ),
              ListTile(
                onTap: () {
                  provider.switchAttachment('gallery');
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo_library),
                title: Text(
                  'Choose from gallery',
                  style: MTypography.caption1.copyWith(color: MColors.p1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _popupMenu(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 16,
      offset: const Offset(-10.0, 20.0),
      icon: const MIcon(Icons.more_vert, color: MColors.n6),
      shadowColor: MColors.p3.withOpacity(0.5),
      onSelected: (val) {
        if (val == 0) {
          _showModalDialog(context);
        } else {
          Navigator.pushNamed(context, UserScreen.routeName);
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            textStyle: MTypography.body1.copyWith(color: MColors.p1),
            child: Row(
              children: [
                const MIcon(Icons.camera_alt, size: 22, color: MColors.p1),
                const SizedBox(width: 10.0),
                Text(
                  'Change Avatar',
                  style: MTypography.body3.copyWith(color: MColors.p1),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 1,
            textStyle: MTypography.body1.copyWith(color: MColors.p1),
            child: Row(
              children: [
                const MIcon(Icons.person, size: 22, color: MColors.p1),
                const SizedBox(width: 10.0),
                Text(
                  'List Users',
                  style: MTypography.body3.copyWith(color: MColors.p1),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }

  @override
  double get maxExtent => headerHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.4;
}
