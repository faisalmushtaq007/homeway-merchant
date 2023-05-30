abstract class BaseCRUDRepo<Entity> {
  Future<int> add(Entity e);

  Future<List<int>> addAll(List<Entity> es);

  Future<Entity?> getById(int id);

  Future<List<Entity>> getAll();

  Future<void> update(Entity e);

  Future<void> updateAll(List<Entity> es);

  Future<void> delete(Entity e);

  Future<void> deleteAll(List<Entity> es);

  Future<void> clear();

  Future<void> get(Entity e);
}
