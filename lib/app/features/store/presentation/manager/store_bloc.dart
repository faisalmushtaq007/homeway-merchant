import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:meta/meta.dart';

part 'store_event.dart';

part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<SaveStore>(_saveStore);
    on<GetStore>(_getStore);
    on<DeleteStore>(_deleteStore);
    on<DeleteAllStore>(_deleteAllStore);
    on<GetAllStore>(_getAllStore);
  }

  FutureOr<void> _saveStore(SaveStore event, Emitter<StoreState> emit) async {
    emit(
      SaveStoreState(
        storeEntity: event.storeEntity,
        hasNewStore: event.hasNewStore,
      ),
    );
  }

  FutureOr<void> _getStore(GetStore event, Emitter<StoreState> emit) async {
    emit(
      GetStoreState(
        storeEntity: event.storeEntity,
        index: event.index,
        storeEntities: event.storeEntities.toList(),
        storeID: event.storeID,
      ),
    );
  }

  FutureOr<void> _deleteStore(DeleteStore event, Emitter<StoreState> emit) async {
    emit(
      DeleteStoreState(
        storeEntity: event.storeEntity,
        index: event.index,
        storeEntities: event.storeEntities.toList(),
        storeID: event.storeID,
      ),
    );
  }

  FutureOr<void> _deleteAllStore(DeleteAllStore event, Emitter<StoreState> emit) async {
    emit(
      DeleteAllStoreState(
        storeEntities: [],
      ),
    );
  }

  FutureOr<void> _getAllStore(GetAllStore event, Emitter<StoreState> emit) async {
    emit(
      GetAllStoreState(
        storeEntities: [],
      ),
    );
  }
}
