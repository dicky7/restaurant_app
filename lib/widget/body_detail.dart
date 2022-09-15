
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/common/utils.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';

class BodyDetail extends StatelessWidget {
  final RestaurantElement restaurant;
  BodyDetail({Key? key, required this.restaurant}) : super(key: key);

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Stack(
                  children: <Widget>[
                    Image.network(restaurant.pictureId),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }
                            ),
                          ),
                          _favoriteButton(),
                        ],
                      ),
                    ),
                  ]
              ),

              /**
               * Description
               */
              Container(
                margin: EdgeInsets.only(top: size.height * 0.29),
                padding: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        restaurant.name,
                        style: GoogleFonts.poppins(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                        )
                      ),
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
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
                                child: const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                restaurant.city,
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                          const SizedBox(width: 40),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.amber),
                                child: const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                restaurant.rating.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          )

                        ],
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      margin: const EdgeInsets.only(top: 14),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                          "Makanan",
                          style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w500)
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 14),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final list in restaurant.menus.foods)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange
                                ),
                                child: Text(
                                    list.name,
                                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white)
                                ),
                              )
                          ]
                        ),
                      )
                    ),
                    const SizedBox(height: 7),
                    Container(
                      margin: const EdgeInsets.only(top: 14),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                          "Minuman",
                          style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w500)
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, left: 14),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: [
                                for (final list in restaurant.menus.drinks)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.indigo
                                    ),
                                    child: Text(
                                        list.name,
                                        style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white)
                                    ),
                                  )
                              ]
                          ),
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 18),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ReadMoreText(
                        restaurant.description,
                        trimLines: 4,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        colorClickableText: Colors.blue,
                        style: const TextStyle(height: 1.5),
                        moreStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _favoriteButton extends StatefulWidget{
  @override
  State<_favoriteButton> createState() => _favoriteButtonState();
}

class _favoriteButtonState extends State<_favoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}