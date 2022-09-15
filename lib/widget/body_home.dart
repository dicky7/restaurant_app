import 'package:flutter/material.dart';
import 'package:restaurant_app/common/utils.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/ui/main/home/detail/detail_page.dart';

class BodyHome extends StatelessWidget{
  final String name;
  BodyHome({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _headerGreetings(context),
        const SizedBox(height: 15),
        Expanded(
          child: FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/restaurant.json"),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  // error widget
                  return const Text('fail get data');
                }
                final List<RestaurantElement> resto =
                    restaurantFromJson(snapshot.data.toString()).restaurants;
                return ListView.builder(
                    itemCount: resto.length,
                    itemBuilder: (context, index) {
                      return _cardRestaurantItem(resto[index], context);
                    });
              }),
        ),
      ],
    );
  }

  Widget _headerGreetings(BuildContext context) {
    int hour = DateTime.now().hour;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(
                top: 20,
                left: 24,
                right: 24
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (hour >= 0 && hour < 12)
                            ?"Good Morning $name"
                            :(hour >= 12 && hour <= 18)
                            ?"Good Afternoon $name"
                            :"Good Night $name",
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Container(
                          child: (hour >= 0 && hour < 12)
                              ?const Icon(Icons.cloud, size: 35, color: Colors.blue)
                              :(hour >= 12 && hour <= 18)
                              ?const Icon(Icons.sunny, size: 35, color: Colors.amber)
                              :const Icon(Icons.sunny_snowing, color: Colors.indigo, size: 35,)
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Lets Find Nearest Restaurant",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w700, color: secondaryColor,
                      height: 1.2,
                    ),
                  ),
                ]
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardRestaurantItem(RestaurantElement restaurant, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.rootName, arguments: restaurant);
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
                        restaurant.pictureId,
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
            Divider(color: Theme.of(context).colorScheme.secondary, thickness: 0.6),
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