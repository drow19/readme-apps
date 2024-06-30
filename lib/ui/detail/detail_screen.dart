import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_shadow.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/ui/detail/detail_screen_provider.dart';
import 'package:book_store_apps/utils/favorite_helper.dart';
import 'package:book_store_apps/widgets/button/m_button.dart';
import 'package:book_store_apps/widgets/button/m_small_button.dart';
import 'package:book_store_apps/widgets/cache_image/m_cache_image.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  static const String routeName = '/detail';

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailScreenProvider provider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider.initial(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.watch<DetailScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Material(
          color: MColors.n6,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: _PersistentHeader(provider),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.book.title ?? '-',
                        style: MTypography.title.copyWith(
                          color: MColors.p1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'By  ${provider.book.authors?.first.name ?? '-'}',
                          style:
                              MTypography.caption1.copyWith(color: MColors.n2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (provider.book.bookShelves != null &&
                          (provider.book.bookShelves?.isNotEmpty ?? false)) ...[
                        _BuildLabel(
                          title: 'Book Shelves',
                          list: provider.book.bookShelves ?? [],
                        ),
                        const SizedBox(height: 20),
                      ],
                      if (provider.book.languages != null &&
                          (provider.book.languages?.isNotEmpty ?? false)) ...[
                        _BuildLabel(
                          title: 'Available Language',
                          list: provider.book.languages ?? [],
                        ),
                        const SizedBox(height: 20),
                      ],
                      if (provider.book.subjects != null &&
                          (provider.book.subjects?.isNotEmpty ?? false)) ...[
                        _BuildLabel(
                          title: 'Topics',
                          list: provider.book.subjects ?? [],
                        ),
                        const SizedBox(height: 20),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Total downloaded : ${provider.book.downloadCount ?? 0}',
                            style: MTypography.caption2
                                .copyWith(color: MColors.n2),
                          ),
                          const SizedBox(width: 10),
                          MSmallButton(
                            onPressed: () => provider.download(context),
                            title: 'Download',
                            typeButton: MTypeButton.filled,
                            buttonColor: MColors.p1,
                            disable: provider.isDownloading,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'People also read this book',
                        style: MTypography.body3.copyWith(
                          color: MColors.p1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _BuildSimilarList(provider: provider),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildSimilarList extends StatelessWidget {
  const _BuildSimilarList({required this.provider});

  final DetailScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: provider.listOfSimilar.length > 10
                  ? 10
                  : provider.listOfSimilar.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) => InkWell(
                onTap: () => provider.goToDetail(
                  context,
                  provider.listOfSimilar[index],
                ),
                child: Container(
                  width: 130,
                  margin: const EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                    color: MColors.n6,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [MShadow.p3Shadow3],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: MCacheImage(
                            imagePath:
                                provider.listOfSimilar[index].format?.image ??
                                    '',
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: MColors.p1.withOpacity(.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildLabel extends StatelessWidget {
  const _BuildLabel({required this.title, required this.list});

  final String title;
  final List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: MTypography.caption1.copyWith(color: MColors.n2),
        ),
        const SizedBox(height: 8),
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: list
              .map(
                (element) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: MColors.p1.withOpacity(.7),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [MShadow.p3Shadow1],
                  ),
                  child: Text(
                    element,
                    style: MTypography.caption2.copyWith(color: MColors.n6),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _PersistentHeader extends SliverPersistentHeaderDelegate {
  _PersistentHeader(this.provider);

  double headerHeight = 300.0;
  final floatingHeight = 86.0;

  final DetailScreenProvider provider;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final floatingTop = headerHeight - floatingHeight / 2;
    final percentage = (headerHeight - shrinkOffset) / headerHeight;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        MCacheImage(
          imagePath: provider.book.format?.image ?? '',
          boxFit: BoxFit.fill,
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Container(
            height: kToolbarHeight + 30,
            color: percentage == 0 ? MColors.n5 : Colors.transparent,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: MColors.n6,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const MIcon(
                            Icons.arrow_back,
                            color: MColors.p1,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: MColors.n6,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () => provider.addToFavorite(),
                          icon: MIcon(
                            FavoriteHelper.updateFavIconColor(provider.book)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                FavoriteHelper.updateFavIconColor(provider.book)
                                    ? MColors.warning
                                    : MColors.p1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
