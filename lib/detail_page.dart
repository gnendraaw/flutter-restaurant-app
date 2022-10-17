import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            color: Colors.grey,
          ),
        ),
      ),
      body: Body(restaurant: restaurant),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(restaurant.pictureId),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading(),
              description(),
              foods(),
              drinks(),
            ],
          ),
        ],
      ),
    );
  }

  Container drinks() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Text('Drinks',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      restaurant.menus.drinks[index].name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column foods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: const Text('Foods',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: restaurant.menus.foods.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    restaurant.menus.foods[index].name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container description() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 4,
          ),
          Text(restaurant.description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
              )),
        ],
      ),
    );
  }

  Container heading() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(restaurant.city,
              style: const TextStyle(
                fontSize: 16,
              )),
          Row(children: [
            const Icon(Icons.star, color: Colors.orange),
            const SizedBox(
              width: 6,
            ),
            Text(restaurant.rating.toString(),
                style: const TextStyle(
                  fontSize: 16,
                )),
          ]),
        ],
      ),
    );
  }
}
