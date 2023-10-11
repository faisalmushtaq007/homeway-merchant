part of 'package:homemakers_merchant/app/features/menu/index.dart';

final localListOfCategories = <Category>[
  Category(
    title: 'Classic',
    subCategory: [
      Category(
        categoryId: '1001',
        title: 'Hummus – Chickpeas Dip With Olive Oil',
        subCategory: [],
      ),
      Category(
        categoryId: '101',
        title: 'Asida/ Aseeda',
        subCategory: [],
      ),
    ],
  ),
  Category(
    categoryId: '1',
    title: 'Traditional',
    subCategory: [
      Category(
        categoryId: '101',
        title: 'Tharid',
        subCategory: [],
      ),
      Category(
        categoryId: '102',
        title: 'Harees',
        subCategory: [],
      ),
      Category(
        categoryId: '103',
        title: 'Kabsa',
        subCategory: [],
      ),
    ],
  ),
  Category(
    categoryId: '2',
    title: 'Chinese food',
    subCategory: [],
  ),
  Category(
    categoryId: '3',
    title: 'Fast food',
    subCategory: [],
  ),
  Category(
    categoryId: '4',
    title: 'Bread',
    subCategory: [],
  ),
  Category(
    categoryId: '5',
    title: 'House Special',
    subCategory: [
      Category(
        categoryId: '51',
        title: 'Shami House',
        subCategory: [],
      ),
      Category(
        categoryId: '52',
        title: 'Egyptian House',
        subCategory: [],
      ),
      Category(
        categoryId: '53',
        title: 'Saudi House',
        subCategory: [],
      ),
      Category(
        categoryId: '54',
        title: 'Asian House',
        subCategory: [],
      ),
      Category(
        categoryId: '55',
        title: 'Italian House',
        subCategory: [],
      ),
    ],
  ),
  Category(
    categoryId: '6',
    title: 'Beverage',
    subCategory: [],
  ),
  Category(
    categoryId: '7',
    title: 'Desert',
    subCategory: [],
    //Qahwa – Arabic Coffee
  ),
  Category(
    categoryId: '8',
    title: 'Prawns',
    subCategory: [],
  ),
  Category(
    categoryId: '9',
    title: 'Fish',
    subCategory: [],
  ),
  Category(
    categoryId: '10',
    title: 'Veg',
    subCategory: [],
  ),
  Category(
    categoryId: '11',
    title: 'Arabic food',
    subCategory: [
      Category(
        categoryId: '110',
        title: 'Majboos/ Kabsa',
        subCategory: [],
      ),
      Category(
        categoryId: '111',
        title: 'Gursan',
        subCategory: [],
      ),
    ],
  ),
  Category(
    categoryId: '12',
    title: 'Main Course',
    subCategory: [
      Category(
        categoryId: '121',
        title: 'Lunch',
        subCategory: [],
      ),
      Category(
        categoryId: '122',
        title: 'Dinner',
        subCategory: [],
      ),
    ],
  ),
  Category(
    categoryId: '13',
    title: 'Beverage',
    subCategory: [],
  ),
  Category(
    categoryId: '14',
    title: 'Desert',
    subCategory: [],
  ),
  Category(
    categoryId: '15',
    title: 'Indonesian Food',
    subCategory: [],
  ),
  Category(
    categoryId: '16',
    title: 'Korean Food',
    subCategory: [],
  ),
  Category(
    categoryId: '17',
    title: 'Sweets',
    subCategory: [],
  ),
  Category(
    categoryId: '18',
    title: 'Bakery',
    subCategory: [
      Category(
        categoryId: '181',
        title: 'Martabak – Pancakes',
        subCategory: [
          //Martabak – Saudi Arabian Pancakes
        ],
      ),
      //Ka’ak – Bread Rings
    ],
  ),
];
final localTasteType = [
  TasteType(
    tasteTypeId: '0',
    title: 'Sweet',
    tasteLevel: [],
  ),
  TasteType(
    tasteTypeId: '1',
    title: 'Salty',
    tasteLevel: [],
  ),
  TasteType(
    tasteTypeId: '2',
    title: 'Sour',
    tasteLevel: [],
  ),
  TasteType(
    tasteTypeId: '3',
    title: 'Bitter',
    tasteLevel: [],
  ),
  TasteType(
    tasteTypeId: '4',
    title: 'Atringent',
    tasteLevel: [],
  ),
  TasteType(
    tasteTypeId: '5',
    title: 'Spicy',
    tasteLevel: [],
  ),
  TasteType(
    tasteTypeId: '6',
    title: 'Umami',
    tasteLevel: [],
  ),
  TasteType(
    tasteTypeId: '7',
    title: 'Savory',
    tasteLevel: [],
  ),
  TasteType(
    tasteTypeId: '8',
    title: 'Sweet & Sour',
    tasteLevel: [],
  ),
];
final localTasteLevel = [
  TasteLevel(
    tasteLevelId: '0',
    title: 'Out off',
  ),
  TasteLevel(
    tasteLevelId: '1',
    title: 'Mild',
  ),
  TasteLevel(
    tasteLevelId: '2',
    title: 'Medium',
  ),
  TasteLevel(
    tasteLevelId: '3',
    title: 'Hot',
  ),
  TasteLevel(
    tasteLevelId: '4',
    title: 'Spicy',
  ),
  TasteLevel(
    tasteLevelId: '5',
    title: 'Ferry',
  ),
];

List<MenuPortion> localMenuPortions = [
  MenuPortion(
    portionID: '0',
    title: '1 Big',
    unit: 'Big',
    maxServingPerson: 1,
    quantity: 1,
  ),
  MenuPortion(
    portionID: '1',
    title: '1 Medium',
    unit: 'Medium',
    maxServingPerson: 1,
    quantity: 1,
  ),
  MenuPortion(
    portionID: '2',
    title: '1 Small',
    unit: 'Small',
    maxServingPerson: 1,
    quantity: 1,
  ),
  MenuPortion(
    portionID: '3',
    title: '1 Cup',
    unit: 'Cup',
    maxServingPerson: 1,
    quantity: 1,
  ),
  MenuPortion(
    portionID: '4',
    title: '1/2 Cup',
    unit: 'Cup',
    maxServingPerson: 1,
    quantity: 1 / 2,
  ),
  MenuPortion(
    portionID: '5',
    title: '1/4 Cup',
    unit: 'Cup',
    maxServingPerson: 1,
    quantity: 1 / 4,
  ),
  MenuPortion(
    portionID: '6',
    title: '1 Slice',
    unit: 'Slice',
    maxServingPerson: 1,
    quantity: 1,
  ),
  MenuPortion(
    portionID: '7',
    title: '1 Bowl',
    unit: 'Bowl',
    maxServingPerson: 1,
    quantity: 1,
  ),
  MenuPortion(
    portionID: '8',
    title: '1/2 Bowl',
    unit: 'Bowl',
    maxServingPerson: 1,
    quantity: 1 / 2,
  ),
  MenuPortion(
    portionID: '9',
    title: '1/4 Bowl',
    unit: 'Bowl',
    maxServingPerson: 1,
    quantity: 1 / 4,
  ),
  MenuPortion(
    portionID: '10',
    title: '1 Palm',
    unit: 'Palm',
    maxServingPerson: 1,
    quantity: 1,
  ),
  MenuPortion(
    portionID: '11',
    title: '1 Thumb',
    unit: 'Thumb',
    maxServingPerson: 1,
    quantity: 1,
  ),
  MenuPortion(
    portionID: '12',
    title: '1 Fist',
    unit: 'Fist',
    maxServingPerson: 1,
    quantity: 1,
  ),
];

final localMenuAddons = [
  Addons(
    addonsID: 0,
    title: 'Sweet sauce',
    quantity: 1,
    unit: '',
  ),
  Addons(
    addonsID: 1,
    title: 'Spicy sauce',
    quantity: 1,
    unit: '',
  ),
  Addons(
    addonsID: 2,
    title: 'Extra Onions',
    quantity: 1,
    unit: '',
  ),
  Addons(
    addonsID: 3,
    title: 'Extra Olives',
    quantity: 1,
    unit: '',
  ),
  Addons(
    addonsID: 4,
    title: 'Extra Cheese',
    quantity: 1,
    unit: '',
  ),
  Addons(
    addonsID: 5,
    title: 'Extra Salad',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 6,
    title: 'Extra Egg',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 7,
    title: 'Extra Chicken Bites',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 8,
    title: 'Extra Yogurt',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 9,
    title: 'Extra Chocolates',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 10,
    title: 'Extra French Fries',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 11,
    title: 'Extra Ice',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 12,
    title: 'Extra Syrup',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 13,
    title: 'Extra IceCream',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 14,
    title: 'Blue Mojito',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 15,
    title: 'Cafe Latte',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 16,
    title: 'Potato chips',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 17,
    title: 'Extra Sweets',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 18,
    title: 'Extra Bread',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 19,
    title: 'Black Olives',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 20,
    title: 'Jalapeno',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 21,
    title: 'Red Pepper',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 22,
    title: 'Extra Paneer',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 23,
    title: 'Crisp Capsicum',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 24,
    title: 'Fresh Tomato',
    quantity: 1,
    unit: 'gm',
  ),
  Addons(
    addonsID: 25,
    title: 'Extra Garlics',
    quantity: 1,
    unit: 'gm',
  ),
];

final localTimings = [
  '00 min',
  '05 min',
  '10 min',
  '15 min',
  '20 min',
  '25 min',
  '30 min',
  '45 min',
  '01:00 hr',
  '01:15 hr',
  '01:30 hr',
  '01:45 hr',
  '02:00 hr',
  '02:15 hr',
  '02:30 hr',
  '02:45 hr',
  '03:00 hr',
  '03:15 hr',
  '03:30 hr',
  '03:45 hr',
  '04:00 hr'
];

final List<VehicleInfo> localVehicleTypeInfo = [
  VehicleInfo(
    vehicleID: '0',
    vehicleType: '2 Wheeler',
  ),
  VehicleInfo(
    vehicleID: '1',
    vehicleType: '3 Wheeler',
  ),
  VehicleInfo(
    vehicleID: '2',
    vehicleType: '4 Wheeler',
  ),
];
