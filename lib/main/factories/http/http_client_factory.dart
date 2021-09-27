import '../../../data/http/http.dart';
import '../../../infra/http/http.dart';

import 'package:http/http.dart';

HttpClient makeHttpAdapter() => HttpAdapter(Client());