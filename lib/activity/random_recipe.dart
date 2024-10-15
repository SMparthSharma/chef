import 'dart:math';
List picPicker = [
  {
    "impUrl":
    "https://www.tastingtable.com/img/gallery/20-delicious-indian-dishes-you-have-to-try-at-least-once/intro-1645057933.webp",
    "headline": "Indian "
  },

  {
    "impUrl":
    "https://assets.clevelandclinic.org/transform/LargeFeatureImage/9cbcc77b-93b7-472e-838d-ec0d5f2f9fbd/heart-healthy-foods-1279763992",
    "headline": "Healthy",
  },
  {
    "impUrl":
    "https://www.dumplingconnection.com/wp-content/uploads/2019/07/Chinese-cusine-e1586208090905.jpg",
    "headline": "Chinese ",
  },
  {
    "impUrl":
    "https://hips.hearstapps.com/del.h-cdn.co/assets/15/24/1600x800/landscape-1433889344-del-milkshakes-index.jpg?resize=1200:*",
    "headline": "Shakes",
  },
  {
    "impUrl":
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU4RVhklejw3LtywA2YnTflm3fuEkbUsEyyw&s",
    "headline": "Street Food",
  },
  {
    "impUrl":
    "https://www.linsfood.com/wp-content/uploads/2021/04/Red-Chilli-Paste-LinsFoodjpg.jpg",
    "headline": "Chilli Food",
  },
  {
    "impUrl":
    "https://c4.wallpaperflare.com/wallpaper/626/14/515/dessert-sweet-food-cake-wallpaper-preview.jpg",
    "headline": "Sweet",
  },
  {
    "impUrl":
    "https://nutritionrefined.com/wp-content/uploads/2023/08/garden-salad.jpg",
    "headline": "Salad",
  },
  {
    "impUrl":
    "https://assets.rbl.ms/21919567/origin.jpg",
    "headline": "Ice Cream",
  },
  {
    "impUrl":
    "https://img.freepik.com/premium-photo/food-photos_662583-2610.jpg?w=740",
    "headline": "Fast",
  },
];
List randomList=[];
List random(int n)
{
  Random ran = Random();
  Set<int> selectedIndices = {};

  while (selectedIndices.length < n) {
    int randomIndex = ran.nextInt(picPicker.length);
    selectedIndices.add(randomIndex);
  }

  return randomList = selectedIndices.map((index) => picPicker[index]).toList();



}