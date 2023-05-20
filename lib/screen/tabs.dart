import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favourite_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screen/category.dart';
import 'package:meals/screen/filter.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int page =0;
  void _selectedPage(int i){
    setState(() {
      page = i;
    });

  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    var activePageTitle = 'Categories';

    Widget currentScreen = CategoryScreen(availableMeals: availableMeals,);
    if( page == 1){

      final favoriteMeals = ref.watch(favoriteMealsProvider);
      currentScreen = MealScreen(
        meals: favoriteMeals,
      );

      activePageTitle = 'Your Favourite';
    }

    return Scaffold(
    appBar: AppBar(title: Text(activePageTitle),),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
  body: currentScreen,
  bottomNavigationBar: BottomNavigationBar(
  onTap: _selectedPage,
  currentIndex: page,
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories'),
  BottomNavigationBarItem(
  icon: Icon(Icons.star),
  label: 'Favorites',
  ),
  ],
  ),
    );
  }

}

