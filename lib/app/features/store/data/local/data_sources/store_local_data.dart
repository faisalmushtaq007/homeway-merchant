part of 'package:homemakers_merchant/app/features/store/index.dart';

final localStoreAvailableFoodPreparationType = [
  StoreAvailableFoodPreparationType(id: 0, title: 'Cooking'),
  StoreAvailableFoodPreparationType(id: 1, title: 'Cooked'),
  StoreAvailableFoodPreparationType(id: 2, title: 'Baking'),
  StoreAvailableFoodPreparationType(id: 3, title: 'Baked'),
  StoreAvailableFoodPreparationType(id: 4, title: 'Sauteing'),
  StoreAvailableFoodPreparationType(id: 5, title: 'Poaching'),
  StoreAvailableFoodPreparationType(id: 6, title: 'Broiling'),
  StoreAvailableFoodPreparationType(id: 7, title: 'Grilling'),
  StoreAvailableFoodPreparationType(id: 8, title: 'Roasting'),
  StoreAvailableFoodPreparationType(id: 9, title: 'Deep Frying'),
  StoreAvailableFoodPreparationType(id: 10, title: 'Sallow Frying'),
  StoreAvailableFoodPreparationType(id: 11, title: 'Pan Frying'),
  StoreAvailableFoodPreparationType(id: 12, title: 'Stir Frying'),
  StoreAvailableFoodPreparationType(id: 13, title: 'Searing'),
  StoreAvailableFoodPreparationType(id: 14, title: 'Boiling'),
  StoreAvailableFoodPreparationType(id: 15, title: 'Flambeing'),
];

final localStoreAvailableFoodTypes = [
  StoreAvailableFoodTypes(title: 'Veg', id: 0),
  StoreAvailableFoodTypes(title: 'Chicken', id: 1),
  StoreAvailableFoodTypes(title: 'Vegan', id: 2),
  StoreAvailableFoodTypes(title: 'Egg', id: 3),
  StoreAvailableFoodTypes(title: 'Seeds', id: 3),
  StoreAvailableFoodTypes(title: 'Dairy', id: 4),
  StoreAvailableFoodTypes(title: 'Soups', id: 5),
  StoreAvailableFoodTypes(title: 'Legumes', id: 6),
  StoreAvailableFoodTypes(title: 'Meat', id: 7),
  StoreAvailableFoodTypes(title: 'Fish', id: 8),
  StoreAvailableFoodTypes(title: 'Prawns', id: 9),
  StoreAvailableFoodTypes(title: 'Others', id: 10),
];

final localStoreWorkingDays = [
  StoreWorkingDayAndTime(day: 'Monday', id: 0, shortName: 'Sun'),
  StoreWorkingDayAndTime(day: 'Monday', id: 1, shortName: 'Mon'),
  StoreWorkingDayAndTime(day: 'Tuesday', id: 2, shortName: 'Tue'),
  StoreWorkingDayAndTime(day: 'Wednesday', id: 3, shortName: 'Wed'),
  StoreWorkingDayAndTime(day: 'Thursday', id: 4, shortName: 'Thur'),
  StoreWorkingDayAndTime(day: 'Friday', id: 5, shortName: 'Fri'),
  StoreWorkingDayAndTime(day: 'Saturday', id: 6, shortName: 'Sat'),
];

final localMenuPreparationTimings = [];

final localDriverVehicleType = [
  VehicleInfo(
    vehicleID: '0',
    vehicleType: 'Bike/Scooty',
    vehicleIconPath: 'assets/svg/food_motorbike.svg',
  ),
  //VehicleInfo(vehicleID: '1', vehicleType: '3-Wheeler'),

  VehicleInfo(
    vehicleID: '2',
    vehicleType: 'Commercial',
    vehicleIconPath: 'assets/svg/food_truck.svg',
  ),
  VehicleInfo(
    vehicleID: '3',
    vehicleType: 'Car',
    vehicleIconPath: 'assets/svg/food_car.svg',
  ),
];

final driverDeliveryType = ['General', 'Exclusive'];
