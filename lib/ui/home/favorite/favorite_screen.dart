import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_shadow.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/models/book_data_res.dart';
import 'package:book_store_apps/models/format_res.dart';
import 'package:book_store_apps/ui/home/favorite/favorite_screen_provider.dart';
import 'package:book_store_apps/utils/favorite_helper.dart';
import 'package:book_store_apps/widgets/appbar/m_appbar.dart';
import 'package:book_store_apps/widgets/cache_image/m_cache_image.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteScreenProvider provider;

  @override
  void initState() {
    super.initState();

    provider = context.read<FavoriteScreenProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getFavoriteBooks();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.watch<FavoriteScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.n5,
      appBar: const MAppBar(
        title: 'Your Favorite Book',
        automaticallyImplyLeading: false,
      ),
      body: _BuildContentBody(provider: provider),
    );
  }
}

class _BuildContentBody extends StatelessWidget {
  const _BuildContentBody({required this.provider});

  final FavoriteScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * .2;

    if(provider.listOfFavorite.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size),
          FractionallySizedBox(
            widthFactor: .9,
            child: Image.asset('assets/images/books.png', height: 100),
          ),
          const SizedBox(height: 10),
          Text(
            'No favorite book!',
            style: MTypography.body1.copyWith(color: MColors.n1),
          )
        ],
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: AnimationLimiter(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: provider.listOfFavorite.map((book) {
            int position = provider.listOfFavorite.indexOf(book);
            return AnimationConfiguration.staggeredGrid(
              position: position,
              columnCount: provider.listOfFavorite.length,
              delay: const Duration(milliseconds: 200),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: _CardItem(provider: provider, book: book),
                ),
              ),
            );
          }).toList(),
        ),
      ),
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
  final FavoriteScreenProvider provider;

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
  final FavoriteScreenProvider provider;

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
