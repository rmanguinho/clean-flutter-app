import 'package:localstorage/localstorage.dart';

import '../../../infra/cache/cache.dart';

LocalStorageAdapter makeLocalStorageAdapter() =>
    LocalStorageAdapter(localStorage: LocalStorage('fordev'));
