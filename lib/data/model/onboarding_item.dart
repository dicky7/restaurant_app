class OnBoardingData{
  final String image, tittle, description;

  OnBoardingData({
    required this.image,
    required this.tittle,
    required this.description
  });
}

final List<OnBoardingData> onBoardItem = [
  OnBoardingData(
      image: "images/food.png",
      tittle: "Looking For Food ?",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"
  ),
  OnBoardingData(
      image: "images/restaurant.png",
      tittle: "Find Near Restaurant",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"
  ),
  OnBoardingData(
      image: "images/grab food.png",
      tittle: "Grab Your Food",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"
  ),
];