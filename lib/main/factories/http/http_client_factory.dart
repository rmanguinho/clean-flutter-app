import 'package:http/http.dart';

import '../../../data/http/http.dart';
import '../../../infra/http/http.dart';

HttpClient makeHttpAdapter() => HttpAdapter(Client());