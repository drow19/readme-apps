import 'dart:io';

import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_shadow.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/models/book_data_res.dart';
import 'package:book_store_apps/models/format_res.dart';
import 'package:book_store_apps/ui/home/home/home_screen_provider.dart';
import 'package:book_store_apps/utils/favorite_helper.dart';
import 'package:book_store_apps/widgets/cache_image/m_cache_image.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:book_store_apps/widgets/input_field/m_text_field.dart';
import 'package:book_store_apps/widgets/shimmer/m_shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/m';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenProvider provider;

  @override
  void initState() {
    super.initState();

    provider = context.read<HomeScreenProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.initial(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.watch<HomeScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: RefreshIndicator(
        onRefresh: () async => provider.refreshPage(context),
        notificationPredicate: (notification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            if (!provider.isLoading && provider.hasNext) {
              provider.page++;
              provider.getTrendingBook(context);
            }
          }

          return false;
        },
        child: Scaffold(
          backgroundColor: MColors.n5,
          appBar: _SearchBar(provider),
          body: SingleChildScrollView(
            controller: provider.scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BuildCarousel(provider),
                Text(
                  provider.isSearch ? 'Result' : 'Trending',
                  style: MTypography.body1.copyWith(color: MColors.p1),
                ),
                const SizedBox(height: 10),
                AnimationLimiter(
                  child: provider.isLoading
                      ? _loading()
                      : StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: provider.listOfTrending.map((book) {
                            int position =
                                provider.listOfTrending.indexOf(book);
                            return AnimationConfiguration.staggeredGrid(
                              position: position,
                              columnCount: provider.listOfTrending.length,
                              delay: const Duration(milliseconds: 200),
                              child: SlideAnimation(
                                verticalOffset: 50,
                                child: FadeInAnimation(
                                  child:
                                      _CardItem(provider: provider, book: book),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(6, (index) => const MShimmer()),
    );
  }
}

class _SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const _SearchBar(this.provider);

  final HomeScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    bool ios = Platform.isIOS;
    return Container(
      color: MColors.p1,
      padding: EdgeInsets.only(left: 20, top: ios ? 70 : 40, right: 20),
      child: Stack(
        children: [
          Positioned(
            child: MTextField(
              controller: provider.searchController,
              placeHolderText: 'Search',
              onChanged: (v) => provider.updateIsSearch(),
              onSubmitted: (v) {
                provider.page = 1;
                provider.listOfTrending.clear();
                provider.updateLoadingState(true);
                provider.getTrendingBook(context);
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 20,
            child: IconButton(
              onPressed: () {
                if (provider.searchController.text.isNotEmpty) {
                  provider.searchController.clear();
                }
                provider.updateIsSearch();
              },
              icon: provider.isSearch
                  ? const MIcon(Icons.clear, color: MColors.red)
                  : const MIcon(Icons.search),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _BuildCarousel extends StatelessWidget {
  const _BuildCarousel(this.provider);

  final HomeScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    if(provider.isLoading || provider.listOfPopular.isEmpty) {
      return const SizedBox();
    }

    if(provider.isSearch) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Most Popular Books",
          style: MTypography.body1.copyWith(color: MColors.p1),
        ),
        const SizedBox(height: 10),
        CarouselSlider.builder(
          itemCount: provider.listOfPopular.length > 10
              ? 10
              : provider.listOfPopular.length,
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 20),
          ),
          itemBuilder: (context, index, _) {
            final book = provider.listOfPopular[index];
            return InkWell(
              onTap: () => provider.goToDetail(context, book),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(book.format?.image ?? ''),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: MColors.p1.withOpacity(.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}



class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.data});

  final FormatRes data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        constraints: const BoxConstraints(minHeight: 200),
        child: MCacheImage(imagePath: data.image ?? ''),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({required this.book, required this.provider});

  final BookDataRes book;
  final HomeScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => provider.goToDetail(context, book),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            _CoverImage(data: book.format!),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: MColors.p1.withOpacity(.4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Text(
                book.title ?? '',
                style: MTypography.title,
              ),
            ),
            Positioned(
              top: 12,
              right: 10,
              child: _FavoriteButton(book, provider),
            )
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton(this.book, this.provider);

  final BookDataRes book;
  final HomeScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => provider.addToFavorite(book),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: [MShadow.p3Shadow1],
        ),
        child: MIcon(
          FavoriteHelper.updateFavIconColor(book)
              ? Icons.favorite
              : Icons.favorite_border,
          color: FavoriteHelper.updateFavIconColor(book)
              ? MColors.warning
              : MColors.n6,
        ),
      ),
    );
  }
}
