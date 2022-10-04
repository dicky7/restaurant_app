import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/ui/main/home/detail/detail_page.dart';

class CardRestaurantItem extends StatelessWidget{
  final Restaurant restaurant;

  const CardRestaurantItem({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.rootName, arguments: restaurant.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 22.0,
          vertical: 10.0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 18.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5.0,
              offset: const Offset(0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FittedBox(
                      child: Image.network(
                        ApiService().smallImage(restaurant.pictureId),
                        height: 70.0,
                        width: 80.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w500)
                      ),
                      Text(
                        restaurant.description,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Theme.of(context).colorScheme.secondary, thickness: 0.5),
            const SizedBox(height: 10),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}