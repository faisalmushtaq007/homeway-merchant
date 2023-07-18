import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:homemakers_merchant/app/features/menu/data/local/data_sources/local_categories_list.dart';
import 'package:meta/meta.dart';
import 'package:homemakers_merchant/app/features/menu/domain/entities/menu_entity.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

part 'menu_event.dart';

part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<GetAllAddons>(_getAllAddons);
    on<SelectAddons>(_selectAddons);
    on<SaveAddons>(_saveAddons);
    on<SelectAddonsMaxPortion>(_selectAddonsMaxPortion);
    on<PopToMenuPage>(_popToMenuPage);
  }

  Future<void> _getAllAddons(GetAllAddons event, Emitter<MenuState> emit) async {
    try {
      emit(
        AddonsLoadingState(
          message: '',
          isLoading: true,
        ),
      );
      List<Addons> _menuAvailableAddons = List<Addons>.from(localMenuAddons.toList());
      await Future.delayed(const Duration(milliseconds: 500));
      if (_menuAvailableAddons.isEmpty) {
        emit(
          GetEmptyAddonsState(
            message: 'Addons is empty',
            addonsEntities: [],
          ),
        );
      } else {
        emit(GetAllAddonsState(
          addonsEntities: _menuAvailableAddons.toList(),
        ));
      }
    } catch (e, s) {
      debugPrint(e.toString());
      emit(AddonsExceptionState(
        message: 'Something went wrong',
        exception: e as Exception,
        stackTrace: s,
      ));
    }
  }

  void _selectAddons(SelectAddons event, Emitter<MenuState> emit) {
    List<Addons> _menuAvailableAddons = List<Addons>.from(event.addonsEntities.toList());
    var selectedAllAddonsEntities = event.selectedAddonsEntities;
    var selectedAddonsEntity = event.addonsEntity;
    if (selectedAddonsEntity != null) {
      if (selectedAllAddonsEntities.contains(selectedAddonsEntity)) {
        selectedAllAddonsEntities.remove(selectedAddonsEntity);
      } else {
        selectedAllAddonsEntities.add(selectedAddonsEntity);
      }
    }

    emit(
      SelectAddonsState(
        addonsEntities: _menuAvailableAddons.toList(),
        addonsEntity: selectedAddonsEntity,
        selectedAddonsEntities: selectedAllAddonsEntities.toList(),
        addonsID: event.addonsID,
        index: event.index,
      ),
    );
  }

  FutureOr<void> _saveAddons(SaveAddons event, Emitter<MenuState> emit) async {
    final newIndex = localMenuAddons.toList().length - 1;
    Addons currentSaveAddons = event.addonsEntity;
    if (event.hasNewAddons) {
      var currentCacheSaveAddons = currentSaveAddons.copyWith(
        addonsID: newIndex.toString(),
      );
      emit(
        SaveAddonsState(addonsEntity: currentCacheSaveAddons, hasNewAddons: event.hasNewAddons),
      );
      await Future.delayed(const Duration(milliseconds: 500), () {});
      emit(NavigateToAddonsMenuState(addonsEntity: currentCacheSaveAddons, hasNewAddons: event.hasNewAddons));
    } else {
      emit(
        SaveAddonsState(addonsEntity: currentSaveAddons, hasNewAddons: event.hasNewAddons),
      );
      await Future.delayed(const Duration(milliseconds: 500), () {});
      emit(NavigateToAddonsMenuState(addonsEntity: currentSaveAddons, hasNewAddons: event.hasNewAddons));
    }
  }

  FutureOr<void> _selectAddonsMaxPortion(SelectAddonsMaxPortion event, Emitter<MenuState> emit) async {
    emit(
      SelectAddonsMaxPortionState(
        addonsEntities: event.addonsEntities.toList(),
        selectedAddonsEntities: event.selectedAddonsEntities.toList(),
        selectedMenuPortions: event.selectedMenuPortions.toList(),
      ),
    );
  }

  FutureOr<void> _popToMenuPage(PopToMenuPage event, Emitter<MenuState> emit) {
    emit(
      PopToMenuPageState(
        hasNewAddons: event.hasNewAddons,
        addonsEntity: event.addonsEntity.toList(),
      ),
    );
  }
}
