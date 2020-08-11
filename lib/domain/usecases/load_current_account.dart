import '../entities/entities.dart';

abstract class LoadCurrentAccount {
  Future<AccountEntity> load();
}