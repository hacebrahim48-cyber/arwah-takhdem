import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}

// ================= SPLASH =================

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '🇩🇿',
                  style: TextStyle(fontSize: 64),
                ),
                const SizedBox(height: 18),
                const Text(
                  'أرواح تخدم | مشاريع',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'فرص العمل والمشاريع والاستثمار في مكان واحد',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AccountTypeScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 34,
                      vertical: 14,
                    ),
                    child: Text(
                      'ابدأ الآن',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= ACCOUNT TYPE =================

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  static const types = [
    ('👷', 'باحث عن عمل'),
    ('🏢', 'شركة تبحث عن عمال'),
    ('🏗️', 'صاحب مشروع'),
    ('💰', 'مستثمر'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر نوع الحساب'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: types.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (_, i) {
            return Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(18),
                leading: Text(
                  types[i].$1,
                  style: const TextStyle(fontSize: 34),
                ),
                title: Text(
                  types[i].$2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_back_ios_new,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(
                        accountType: types[i].$2,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// ================= HOME =================

class HomeScreen extends StatelessWidget {
  final String accountType;

  const HomeScreen({
    super.key,
    required this.accountType,
  });

  void openPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeatureScreen(
          title: title,
          accountType: accountType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ('أبحث عن عمل', Icons.work),
      ('أبحث عن عامل', Icons.person_search),
      ('أبحث عن مشروع', Icons.business),
      ('أبحث عن مستثمر', Icons.account_balance),
      ('طلباتي', Icons.assignment),
      ('المحادثات', Icons.chat),
      ('الإشعارات', Icons.notifications),
      ('الملف الشخصي', Icons.person),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('أرواح تخدم | مشاريع'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 10),

            Text(
              'مرحبًا 👋',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall,
            ),

            const SizedBox(height: 5),

            Text(
              'نوع الحساب: $accountType',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            ...buttons.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Card(
                  elevation: 1,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    leading: Icon(
                      item.$2,
                      size: 30,
                      color: Colors.green,
                    ),
                    title: Text(
                      item.$1,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                    ),
                    onTap: () {
                      openPage(context, item.$1);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= FEATURE PAGES =================

class FeatureScreen extends StatelessWidget {
  final String title;
  final String accountType;

  const FeatureScreen({
    super.key,
    required this.title,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (title == 'أبحث عن عمل') {
      return _searchJobs();
    }

    if (title == 'أبحث عن عامل') {
      return _searchWorkers();
    }

    if (title == 'أبحث عن مشروع') {
      return _searchProjects();
    }

    if (title == 'أبحث عن مستثمر') {
      return _searchInvestors();
    }

    if (title == 'طلباتي') {
      return _requests();
    }

    if (title == 'المحادثات') {
      return _messages();
    }

    if (title == 'الإشعارات') {
      return _notifications();
    }

    return _profile();
  }

  // ---------- JOBS ----------

  Widget _searchJobs() {
    return ListView(
      children: [
        const Text(
          'البحث عن فرص العمل',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'المهنة أو الوظيفة',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        const TextField(
          decoration: InputDecoration(
            labelText: 'الولاية',
            prefixIcon: Icon(Icons.location_on),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.search),
          label: const Text('بحث'),
        ),
      ],
    );
  }

  // ---------- WORKERS ----------

  Widget _searchWorkers() {
    return ListView(
      children: [
        const Text(
          'البحث عن عامل',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'المهنة المطلوبة',
            prefixIcon: Icon(Icons.work),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        const TextField(
          decoration: InputDecoration(
            labelText: 'الولاية',
            prefixIcon: Icon(Icons.location_on),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.search),
          label: const Text('بحث عن العمال'),
        ),
      ],
    );
  }

  // ---------- PROJECTS ----------

  Widget _searchProjects() {
    return ListView(
      children: [
        const Text(
          'المشاريع',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _projectCard(
          '🌱 زراعة الخضروات الذكية',
          'الجزائر',
        ),
        _projectCard(
          '☀️ مشروع الطاقة الشمسية',
          'ورقلة',
        ),
        _projectCard(
          '🚚 النقل المبرد',
          'وهران',
        ),
        _projectCard(
          '🏢 مشروع عقاري',
          'قسنطينة',
        ),
      ],
    );
  }

  Widget _projectCard(String name, String location) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(name),
        subtitle: Text('📍 $location'),
        trailing: const Icon(
          Icons.arrow_back_ios_new,
          size: 16,
        ),
        onTap: () {},
      ),
    );
  }

  // ---------- INVESTORS ----------

  Widget _searchInvestors() {
    return ListView(
      children: [
        const Text(
          'المستثمرون',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _simpleCard(
          '💰 مستثمر في المشاريع الصغيرة',
          'مهتم بالمشاريع القابلة للنمو',
        ),
        _simpleCard(
          '🏢 مستثمر عقاري',
          'استثمارات داخل الجزائر',
        ),
        _simpleCard(
          '☀️ مستثمر في الطاقة',
          'مشاريع الطاقة الشمسية',
        ),
      ],
    );
  }

  // ---------- REQUESTS ----------

  Widget _requests() {
    return ListView(
      children: [
        const Text(
          'طلباتي',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _simpleCard(
          'لا توجد طلبات حاليًا',
          'ستظهر طلباتك هنا',
        ),
      ],
    );
  }

  // ---------- MESSAGES ----------

  Widget _messages() {
    return ListView(
      children: [
        const Text(
          'المحادثات',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _simpleCard(
          'لا توجد محادثات',
          'ستظهر محادثاتك هنا',
        ),
      ],
    );
  }

  // ---------- NOTIFICATIONS ----------

  Widget _notifications() {
    return ListView(
      children: [
        const Text(
          'الإشعارات',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _simpleCard(
          'مرحبًا بك في أرواح تخدم 🎉',
          'يمكنك الآن استكشاف فرص العمل والمشاريع',
        ),
      ],
    );
  }

  // ---------- PROFILE ----------

  Widget _profile() {
    return ListView(
      children: [
        const Center(
          child: CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.person,
              size: 55,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'الملف الشخصي',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            accountType,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 25),
        _simpleCard(
          'المعلومات الشخصية',
          'الاسم، الهاتف، الولاية',
        ),
        _simpleCard(
          'المهارات والخبرات',
          'أضف خبراتك ومهاراتك',
        ),
        _simpleCard(
          'الإعدادات',
          'إعدادات الحساب والخصوصية',
        ),
      ],
    );
  }

  Widget _simpleCard(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_back_ios_new,
          size: 16,
        ),
      ),
    );
  }
}
