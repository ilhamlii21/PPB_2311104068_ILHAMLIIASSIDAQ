import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConnection {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://wapansmfuthimcbcybuq.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndhcGFuc21mdXRoaW1jYmN5YnVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY3NTQzMzAsImV4cCI6MjA4MjMzMDMzMH0.ua2RRJP1OIJr1lgylrZ_QnkT2Bfv-PKYfxrsh1jYT2c',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
