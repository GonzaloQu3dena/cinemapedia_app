import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ### Search Query Provider
/// This provider will store the search query.
/// 
/// ### Author:
/// Gonzalo Quedena
final searchQueryProvider = StateProvider<String>((ref) => '');