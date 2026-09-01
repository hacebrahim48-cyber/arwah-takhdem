import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }
  runApp(const ArwahTakhdemApp());
}

class ArwahTakhdemApp extends StatelessWidget {
  const ArwahTakhdemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'أرواح تخدم | مشاريع',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🇩🇿', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 18),
              const Text('أرواح تخدم | مشاريع',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
              const SizedBox(height: 12),
              const Text('فرص العمل والمشاريع والاستثمار في مكان واحد',
                textAlign: TextAlign.center),
              const SizedBox(height: 35),
              FilledButton(
                onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AccountTypeScreen())),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34, vertical: 14),
                  child: Text('ابدأ الآن', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  static const types = [
    ('👷', 'باحث عن عمل'),
    ('🏢', 'شركة تبحث عن عمال'),
    ('🏗️', 'صاحب مشروع'),
    ('💰', 'مستثمر'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('اختر نوع الحساب')),
    body: Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: types.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (_, i) => Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(18),
            leading: Text(types[i].$1, style: const TextStyle(fontSize: 34)),
            title: Text(types[i].$2,
              style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: const Icon(Icons.arrow_back_ios_new),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) =>
                HomeScreen(accountType: types[i].$2))),
          ),
        ),
      ),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  final String accountType;
  const HomeScreen({super.key, required this.accountType});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('أرواح تخدم | مشاريع')),
    body: Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('مرحبًا 👋',
            style: Theme.of(context).textTheme.headlineSmall),
          Text('نوع الحساب: $accountType'),
          const SizedBox(height: 24),
          ...[
            'أبحث عن عمل', 'أبحث عن عامل', 'أبحث عن مشروع',
            'أبحث عن مستثمر', 'طلباتي', 'المحادثات',
            'الإشعارات', 'الملف الشخصي'
          ].map((x) => Card(child: ListTile(
            title: Text(x),
            trailing: const Icon(Icons.arrow_back_ios_new, size: 18),
            onTap: () {},
          ))),
        ],
      ),
    ),
  );
}
