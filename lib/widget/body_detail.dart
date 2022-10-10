import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/providers/database_provider.dart';
import 'package:restaurant_app/ui/main/home/addReview/add_review_page.dart';
import 'package:restaurant_app/ui/main/main_page.dart';

class BodyDetail extends StatelessWidget {
  final Restaurant restaurant;

  BodyDetail({Key? key, required this.restaurant}) : super(key: key);

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _buildImageStack(size, context),
                _buildDescription(size, context),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: () {
            Navigation.intentWithData(AddReviewPage.rootName,
                arguments: restaurant.id);
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget _buildImageStack(Size size, BuildContext context) {
    return Stack(children: <Widget>[
      Image.network(
        ApiService().mediumImage(restaurant.pictureId),
        height: size.height / 3,
        width: size.width,
        fit: BoxFit.cover,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigation.intentWithDataClearTop(MainPage.rootName);
                  }),
            ),
            _FavoriteButton(restaurant: restaurant),
          ],
        ),
      ),
    ]);
  }

  Container _buildDescription(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.29),
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(restaurant.name!,
                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w600)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${restaurant.city}",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
                const SizedBox(width: 40),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${restaurant.rating}",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 7),
          _buildMenu(context,
              label: "Food",
              menus: restaurant.menus!.foods!,
              colors: Colors.orange.shade300),
          const SizedBox(height: 7),
          _buildMenu(context,
              label: "Drinks",
              menus: restaurant.menus!.drinks!,
              colors: Colors.lightBlue.shade300),
          const SizedBox(height: 7),
          Container(
            margin: const EdgeInsets.only(top: 14),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text("Description",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w500)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 18),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ReadMoreText(
              restaurant.description!,
              trimLines: 4,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              colorClickableText: Colors.blue,
              style: const TextStyle(height: 1.5),
              moreStyle: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.blue),
            ),
          ),
          _buildReview(context, restaurant.customerReviews!),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context,
      {required String label,
      required List<Category> menus,
      required Color colors}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(label,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.w500)),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10, left: 14),
            height: 36,
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: menus.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: colors),
                  child: Center(
                    child: Text(menus[index].name!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.white)),
                  ),
                );
              },
            )),
      ],
    );
  }

  Widget _buildReview(BuildContext context, List<CustomerReview> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text("Customer Review (${reviews.length})",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: reviews.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(
                                      (math.Random().nextDouble() * 0xFFFFFF)
                                          .toInt())
                                  .withOpacity(1.0)),
                          height: 50,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviews[index].name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              reviews[index].date!,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              reviews[index].review!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  Restaurant restaurant;
  _FavoriteButton({required this.restaurant});

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(widget.restaurant.id!),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return  isBookmarked
            ? IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
              ),
              onPressed:() => provider.removeBookmarkById(widget.restaurant.id!)
             )
            : IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.red,
                size: 30,
              ),
              onPressed: () => provider.addBookmarks(widget.restaurant)
            );
          },
        );
      },
    );
  }
}
