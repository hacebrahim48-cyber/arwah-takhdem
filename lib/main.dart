import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://xfftzmxcphvgpyhfbdto.supabase.co';
const supabaseAnonKey = 'sb_publishable_FaFRHnUm6QlmkPUoYyCKQA_-UcDd3g1';

final db = Supabase.instance.client;

const roles = ['باحث عن عمل', 'صاحب عمل', 'شركة تبحث عن عمال', 'صاحب مشروع', 'مستثمر'];
const genders = ['الكل', 'ذكر', 'أنثى'];
const categories = ['فلاحة', 'تجارة', 'صناعة', 'سياحة', 'عقار', 'خدمات', 'تكنولوجيا', 'نقل', 'مطاعم', 'حرفي', 'طاقة', 'صحة', 'تعليم', 'أخرى'];
const requests = ['شراكة', 'بيع', 'استثمار'];
const wilayas = [
  'أدرار','الشلف','الأغواط','أم البواقي','باتنة','بجاية','بسكرة','بشار','البليدة','البويرة',
  'تمنراست','تبسة','تلمسان','تيارت','تيزي وزو','الجزائر','الجلفة','جيجل','سطيف','سعيدة',
  'سكيكدة','سيدي بلعباس','عنابة','قالمة','قسنطينة','المدية','مستغانم','المسيلة','معسكر','ورقلة',
  'وهران','البيض','إليزي','برج بوعريريج','بومرداس','الطارف','تندوف','تيسمسيلت','الوادي','خنشلة',
  'سوق أهراس','تيبازة','ميلة','عين الدفلى','النعامة','عين تموشنت','غليزان','تيميمون','برج باجي مختار',
  'أولاد جلال','بني عباس','عين صالح','عين قزام','تقرت','جانت','المغير','المنيعة','آفلو','بريكة',
  'القنطرة','بئر العاتر','العريشة','قصر الشلالة','عين وسارة','مسعد','قصر البخاري','بوسعادة','الأبيض سيدي الشيخ'
];

String roleDb(String role) {
  if (role == 'باحث عن عمل') return 'job_seeker';
  if (role == 'مستثمر') return 'investor';
  if (role == 'صاحب مشروع') return 'project_owner';
  return 'company';
}

String clean(Object e) => e.toString().replaceFirst('Exception: ', '');
void toast(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
InputDecoration deco(String label) => InputDecoration(labelText: label, border: const OutlineInputBorder());

Widget dd(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
  final selected = items.contains(value) ? value : items.first;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: DropdownButtonFormField<String>(
      value: selected,
      decoration: deco(label),
      items: items.map((x) => DropdownMenuItem<String>(value: x, child: Text(x))).toList(),
      onChanged: onChanged,
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'أرواح تخدم | مشاريع',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const Gate(),
    );
  }
}

class Gate extends StatelessWidget {
  const Gate({super.key});
  @override
  Widget build(BuildContext context) => db.auth.currentSession == null ? const Login() : const Home();
}

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phone = TextEditingController();
  final password = TextEditingController();
  bool busy = false;

  Future<void> login() async {
    if (phone.text.trim().isEmpty || password.text.isEmpty) {
      toast(context, 'أدخل رقم الهاتف وكلمة المرور');
      return;
    }
    setState(() => busy = true);
    try {
      await db.auth.signInWithPassword(phone: phone.text.trim(), password: password.text);
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Home()), (_) => false);
    } catch (e) {
      if (mounted) toast(context, 'فشل الدخول: ${clean(e)}');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.work, size: 80, color: Colors.green),
                const SizedBox(height: 12),
                const Text('أرواح تخدم | مشاريع 🇩🇿', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                const SizedBox(height: 28),
                TextField(controller: phone, keyboardType: TextInputType.phone, decoration: deco('رقم الهاتف')),
                const SizedBox(height: 12),
                TextField(controller: password, obscureText: true, decoration: deco('كلمة المرور')),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity, child: FilledButton(onPressed: busy ? null : login, child: Text(busy ? 'جارٍ الدخول...' : 'دخول'))),
                TextButton(onPressed: () => toast(context, 'استرجاع كلمة المرور عبر SMS يحتاج تفعيل مزود الرسائل في Supabase.'), child: const Text('نسيت كلمة المرور؟')),
                OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Register())), child: const Text('إنشاء حساب جديد')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final phone = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  String role = roles.first;
  bool busy = false;

  Future<void> register() async {
    if (phone.text.trim().isEmpty || password.text.length < 6) {
      toast(context, 'الهاتف مطلوب وكلمة المرور 6 أحرف على الأقل');
      return;
    }
    setState(() => busy = true);
    try {
      await db.auth.signUp(
        phone: phone.text.trim(),
        password: password.text,
        data: {'full_name': name.text.trim(), 'account_type': roleDb(role)},
      );
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) => Verify(phone: phone.text.trim(), name: name.text.trim(), role: role)));
    } catch (e) {
      if (mounted) toast(context, 'فشل التسجيل: ${clean(e)}');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('إنشاء حساب')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(controller: name, decoration: deco('الاسم (اختياري)')),
            const SizedBox(height: 12),
            TextField(controller: phone, keyboardType: TextInputType.phone, decoration: deco('رقم الهاتف')),
            const SizedBox(height: 12),
            TextField(controller: password, obscureText: true, decoration: deco('كلمة المرور')),
            const SizedBox(height: 12),
            dd('نوع الحساب', role, roles, (v) => setState(() => role = v ?? role)),
            const SizedBox(height: 6),
            FilledButton(onPressed: busy ? null : register, child: Text(busy ? 'جارٍ التسجيل...' : 'متابعة والتحقق')),
          ],
        ),
      ),
    );
  }
}

class Verify extends StatefulWidget {
  final String phone;
  final String name;
  final String role;
  const Verify({super.key, required this.phone, required this.name, required this.role});
  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final code = TextEditingController();

  Future<void> verify() async {
    try {
      await db.auth.verifyOTP(phone: widget.phone, token: code.text.trim(), type: OtpType.sms);
      final user = db.auth.currentUser;
      if (user != null) {
        await db.from('profiles').upsert({
          'id': user.id,
          'full_name': widget.name,
          'phone': widget.phone,
          'account_type': roleDb(widget.role),
          'onboarding_completed': true,
          'verified': true,
        });
      }
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Home()), (_) => false);
    } catch (e) {
      if (mounted) toast(context, 'فشل التحقق: ${clean(e)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('رمز التحقق')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('أدخل رمز SMS المرسل إلى هاتفك'),
              const SizedBox(height: 16),
              TextField(controller: code, keyboardType: TextInputType.number, textAlign: TextAlign.center, decoration: deco('رمز التحقق')),
              const SizedBox(height: 16),
              FilledButton(onPressed: verify, child: const Text('تأكيد الحساب')),
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Map<String, dynamic>>[
      {'title': 'أبحث عن عمل', 'icon': Icons.search, 'page': const SearchJobs()},
      {'title': 'أبحث عن عامل', 'icon': Icons.person_search, 'page': const SearchWorkers()},
      {'title': 'الشركات تبحث عن عمال', 'icon': Icons.business, 'page': const CompanyJobs()},
      {'title': 'أبحث عن مشروع', 'icon': Icons.construction, 'page': const Projects()},
      {'title': 'أبحث عن مستثمر', 'icon': Icons.attach_money, 'page': const Investors()},
      {'title': 'الدعوات', 'icon': Icons.mail, 'page': const Invitations()},
      {'title': 'المحادثات', 'icon': Icons.chat, 'page': const Chats()},
      {'title': 'الإشعارات', 'icon': Icons.notifications, 'page': const Notifications()},
      {'title': 'حسابي', 'icon': Icons.account_circle, 'page': const Profile()},
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('أرواح تخدم | مشاريع 🇩🇿'),
          actions: [
            IconButton(
              onPressed: () async {
                await db.auth.signOut();
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Login()), (_) => false);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (_, index) {
            final item = items[index];
            return Card(
              child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item['page'] as Widget)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'] as IconData, size: 42, color: Colors.green),
                    const SizedBox(height: 8),
                    Text(item['title'] as String, textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SearchJobs extends StatelessWidget {
  const SearchJobs({super.key});
  @override
  Widget build(BuildContext context) => const SearchForm(workers: false);
}

class SearchWorkers extends StatelessWidget {
  const SearchWorkers({super.key});
  @override
  Widget build(BuildContext context) => const SearchForm(workers: true);
}

class SearchForm extends StatefulWidget {
  final bool workers;
  const SearchForm({super.key, required this.workers});
  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final profession = TextEditingController();
  String wilaya = 'الكل';
  String gender = 'الكل';
  int minExperience = 0;
  int minAge = 0;
  int maxAge = 100;

  void search() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Results(
          workers: widget.workers,
          profession: profession.text.trim(),
          wilaya: wilaya,
          gender: gender,
          minExperience: minExperience,
          minAge: minAge,
          maxAge: maxAge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.workers ? 'أبحث عن عامل' : 'أبحث عن عمل')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextField(controller: profession, decoration: deco('المهنة / الوظيفة')),
            const SizedBox(height: 10),
            dd('الولاية', wilaya, ['الكل', ...wilayas], (v) => setState(() => wilaya = v ?? wilaya)),
            dd('الجنس', gender, genders, (v) => setState(() => gender = v ?? gender)),
            TextField(
              keyboardType: TextInputType.number,
              decoration: deco('الحد الأدنى لسنوات الخبرة'),
              onChanged: (v) => minExperience = int.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: deco('العمر الأدنى'),
              onChanged: (v) => minAge = int.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: deco('العمر الأقصى'),
              onChanged: (v) => maxAge = int.tryParse(v) ?? 100,
            ),
            const SizedBox(height: 10),
            FilledButton.icon(onPressed: search, icon: const Icon(Icons.search), label: const Text('بحث')),
          ],
        ),
      ),
    );
  }
}

class Results extends StatefulWidget {
  final bool workers;
  final String profession;
  final String wilaya;
  final String gender;
  final int minExperience;
  final int minAge;
  final int maxAge;
  const Results({
    super.key,
    required this.workers,
    required this.profession,
    required this.wilaya,
    required this.gender,
    required this.minExperience,
    required this.minAge,
    required this.maxAge,
  });
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  List<Map<String, dynamic>> rows = [];
  bool loading = true;
  int? wilayaId;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      if (widget.wilaya != 'الكل') {
        final w = await db.from('wilayas').select('id').eq('name_ar', widget.wilaya).maybeSingle();
        wilayaId = w?['id'] as int?;
      }

      if (widget.workers) {
        var query = db.from('job_seeker_profiles').select('id,profession_id,wilaya_id,experience_years,age,gender,skills,professions(name_ar),wilayas(name_ar)');
        if (wilayaId != null) query = query.eq('wilaya_id', wilayaId!);
        if (widget.gender != 'الكل') query = query.eq('gender', widget.gender == 'ذكر' ? 'male' : 'female');
        query = query.gte('experience_years', widget.minExperience).gte('age', widget.minAge).lte('age', widget.maxAge);
        final data = await query;
        rows = List<Map<String, dynamic>>.from(data);
      } else {
        var query = db.from('job_offers').select('id,title,description,vacancies,experience_years,min_age,max_age,gender,profession_id,wilaya_id,professions(name_ar),wilayas(name_ar)').eq('status', 'published');
        if (wilayaId != null) query = query.eq('wilaya_id', wilayaId!);
        if (widget.gender != 'الكل') query = query.eq('gender', widget.gender == 'ذكر' ? 'male' : 'female');
        query = query.gte('experience_years', widget.minExperience);
        final data = await query;
        rows = List<Map<String, dynamic>>.from(data);
      }

      if (widget.profession.isNotEmpty) {
        final term = widget.profession.toLowerCase();
        rows = rows.where((row) {
          final profession = ((row['professions'] as Map?)?['name_ar'] ?? '').toString().toLowerCase();
          final title = (row['title'] ?? '').toString().toLowerCase();
          return profession.contains(term) || title.contains(term);
        }).toList();
      }
    } catch (e) {
      if (mounted) toast(context, 'خطأ: ${clean(e)}');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> apply(String id) async {
    try {
      await db.from('job_applications').insert({'job_offer_id': id, 'applicant_id': db.auth.currentUser!.id});
      if (mounted) toast(context, 'تم إرسال طلب التقديم');
    } catch (e) {
      if (mounted) toast(context, 'تعذر التقديم: ${clean(e)}');
    }
  }

  Future<void> invite(String receiverId, dynamic professionId) async {
    try {
      await db.from('invitations').insert({
        'sender_id': db.auth.currentUser!.id,
        'receiver_id': receiverId,
        'profession_id': professionId,
        'message': 'دعوة للتواصل عبر أرواح تخدم',
      });
      if (mounted) toast(context, 'تم إرسال الدعوة');
    } catch (e) {
      if (mounted) toast(context, 'تعذر إرسال الدعوة: ${clean(e)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.workers ? 'العمال' : 'فرص العمل')),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : rows.isEmpty
                ? const Center(child: Text('لا توجد نتائج'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: rows.length,
                    itemBuilder: (_, index) {
                      final row = rows[index];
                      final profession = ((row['professions'] as Map?)?['name_ar'] ?? 'غير محدد').toString();
                      final wilaya = ((row['wilayas'] as Map?)?['name_ar'] ?? 'غير محدد').toString();
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Icon(widget.workers ? Icons.person : Icons.work)),
                          title: Text(widget.workers ? profession : (row['title'] ?? profession).toString()),
                          subtitle: Text('$wilaya\nالخبرة: ${row['experience_years'] ?? '-'} | العمر: ${row['age'] ?? '-'}'),
                          isThreeLine: true,
                          trailing: FilledButton(
                            onPressed: () => widget.workers ? invite(row['id'].toString(), row['profession_id']) : apply(row['id'].toString()),
                            child: Text(widget.workers ? 'دعوة' : 'تقديم'),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

class CompanyJobs extends StatefulWidget {
  const CompanyJobs({super.key});
  @override
  State<CompanyJobs> createState() => _CompanyJobsState();
}

class _CompanyJobsState extends State<CompanyJobs> {
  Future<List<Map<String, dynamic>>> load() async {
    final data = await db.from('job_offers').select('id,title,vacancies,experience_years,professions(name_ar),wilayas(name_ar)').eq('status', 'published').order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الشركات تبحث عن عمال')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddJob())).then((_) => setState(() {})),
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: load(),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Center(child: Text('خطأ: ${snapshot.error}'));
            final data = snapshot.data ?? [];
            if (data.isEmpty) return const Center(child: Text('لا توجد إعلانات بعد'));
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];
                final p = ((item['professions'] as Map?)?['name_ar'] ?? '-').toString();
                final w = ((item['wilayas'] as Map?)?['name_ar'] ?? '-').toString();
                return Card(child: ListTile(title: Text((item['title'] ?? '-').toString()), subtitle: Text('$p | $w\nعدد العمال: ${item['vacancies'] ?? '-'}')));
              },
            );
          },
        ),
      ),
    );
  }
}

class AddJob extends StatefulWidget {
  const AddJob({super.key});
  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  final title = TextEditingController();
  final company = TextEditingController();
  final profession = TextEditingController();
  final count = TextEditingController(text: '1');
  final experience = TextEditingController(text: '0');
  final minAge = TextEditingController(text: '18');
  final maxAge = TextEditingController(text: '60');
  String wilaya = wilayas.first;
  String gender = 'الكل';
  String workType = 'دوام كامل';

  Future<void> save() async {
    try {
      final me = db.auth.currentUser!.id;
      final existing = await db.from('companies').select('id').eq('owner_id', me).maybeSingle();
      dynamic companyId = existing?['id'];
      if (companyId == null) {
        final created = await db.from('companies').insert({'owner_id': me, 'name': company.text.trim().isEmpty ? 'شركة' : company.text.trim(), 'status': 'published'}).select('id').single();
        companyId = created['id'];
      }
      final w = await db.from('wilayas').select('id').eq('name_ar', wilaya).single();
      final prof = await db.from('professions').select('id').ilike('name_ar', profession.text.trim()).limit(1);
      await db.from('job_offers').insert({
        'company_id': companyId,
        'owner_id': me,
        'profession_id': prof.isEmpty ? null : prof.first['id'],
        'title': title.text.trim(),
        'wilaya_id': w['id'],
        'vacancies': int.tryParse(count.text) ?? 1,
        'experience_years': int.tryParse(experience.text) ?? 0,
        'min_age': int.tryParse(minAge.text) ?? 18,
        'max_age': int.tryParse(maxAge.text) ?? 60,
        'gender': gender == 'ذكر' ? 'male' : gender == 'أنثى' ? 'female' : null,
        'work_type': workType,
        'status': 'published',
      });
      if (!mounted) return;
      toast(context, 'تم نشر الإعلان');
      Navigator.pop(context);
    } catch (e) {
      if (mounted) toast(context, 'تعذر النشر: ${clean(e)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('إعلان توظيف')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextField(controller: company, decoration: deco('اسم الشركة')),
            const SizedBox(height: 10),
            TextField(controller: title, decoration: deco('عنوان الوظيفة')),
            const SizedBox(height: 10),
            TextField(controller: profession, decoration: deco('المهنة')),
            const SizedBox(height: 10),
            dd('الولاية', wilaya, wilayas, (v) => setState(() => wilaya = v ?? wilaya)),
            TextField(controller: count, keyboardType: TextInputType.number, decoration: deco('عدد العمال')),
            const SizedBox(height: 10),
            TextField(controller: experience, keyboardType: TextInputType.number, decoration: deco('سنوات الخبرة')),
            const SizedBox(height: 10),
            TextField(controller: minAge, keyboardType: TextInputType.number, decoration: deco('العمر الأدنى')),
            const SizedBox(height: 10),
            TextField(controller: maxAge, keyboardType: TextInputType.number, decoration: deco('العمر الأقصى')),
            const SizedBox(height: 10),
            dd('الجنس', gender, genders, (v) => setState(() => gender = v ?? gender)),
            dd('نوع العمل', workType, const ['دوام كامل', 'دوام جزئي', 'مؤقت', 'عن بعد'], (v) => setState(() => workType = v ?? workType)),
            FilledButton(onPressed: save, child: const Text('نشر الإعلان')),
          ],
        ),
      ),
    );
  }
}

class Projects extends StatefulWidget {
  const Projects({super.key});
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  Future<List<Map<String, dynamic>>> load() async {
    final data = await db.from('projects').select('*').eq('status', 'published').order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المشاريع')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProject())).then((_) => setState(() {})),
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: load(),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Center(child: Text('خطأ: ${snapshot.error}'));
            final data = snapshot.data ?? [];
            if (data.isEmpty) return const Center(child: Text('لا توجد مشاريع منشورة'));
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];
                return Card(child: ListTile(title: Text((item['title'] ?? '-').toString()), subtitle: Text('${item['category'] ?? '-'} | ${item['city'] ?? '-'}\nرأس المال: ${item['capital_required'] ?? '-'}')));
              },
            );
          },
        ),
      ),
    );
  }
}

class AddProject extends StatefulWidget {
  const AddProject({super.key});
  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final title = TextEditingController();
  final description = TextEditingController();
  final capital = TextEditingController();
  final phone = TextEditingController();
  String category = categories.first;
  String wilaya = wilayas.first;
  String request = requests.first;

  Future<void> save() async {
    try {
      await db.from('projects').insert({
        'owner_id': db.auth.currentUser!.id,
        'title': title.text.trim(),
        'description': description.text.trim(),
        'city': wilaya,
        'category': category,
        'project_type': request,
        'capital_required': double.tryParse(capital.text),
        'phone': phone.text.trim(),
        'status': 'published',
      });
      if (!mounted) return;
      toast(context, 'تم نشر المشروع');
      Navigator.pop(context);
    } catch (e) {
      if (mounted) toast(context, 'تعذر نشر المشروع: ${clean(e)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('إضافة مشروع')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextField(controller: title, decoration: deco('اسم المشروع')),
            const SizedBox(height: 10),
            dd('نوع النشاط', category, categories, (v) => setState(() => category = v ?? category)),
            dd('نوع الطلب', request, requests, (v) => setState(() => request = v ?? request)),
            dd('الولاية', wilaya, wilayas, (v) => setState(() => wilaya = v ?? wilaya)),
            TextField(controller: capital, keyboardType: TextInputType.number, decoration: deco('قيمة المشروع')),
            const SizedBox(height: 10),
            TextField(controller: phone, keyboardType: TextInputType.phone, decoration: deco('رقم التواصل')),
            const SizedBox(height: 10),
            TextField(controller: description, maxLines: 5, decoration: deco('وصف المشروع')),
            const SizedBox(height: 10),
            FilledButton(onPressed: save, child: const Text('نشر المشروع')),
          ],
        ),
      ),
    );
  }
}

class Investors extends StatelessWidget {
  const Investors({super.key});

  Future<List<Map<String, dynamic>>> load() async {
    final data = await db.from('investor_profiles').select('id,display_name,investment_fields,min_amount,max_amount,wilayas(name_ar)');
    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المستثمرون')),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: load(),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Center(child: Text('خطأ: ${snapshot.error}'));
            final data = snapshot.data ?? [];
            if (data.isEmpty) return const Center(child: Text('لا يوجد مستثمرون بعد'));
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];
                final w = ((item['wilayas'] as Map?)?['name_ar'] ?? '-').toString();
                final fields = item['investment_fields'];
                final fieldText = fields is List ? fields.join('، ') : (fields ?? '-').toString();
                return Card(child: ListTile(leading: const Icon(Icons.attach_money), title: Text((item['display_name'] ?? 'مستثمر').toString()), subtitle: Text('$w\n$fieldText')));
              },
            );
          },
        ),
      ),
    );
  }
}

class Invitations extends StatefulWidget {
  const Invitations({super.key});
  @override
  State<Invitations> createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {
  Future<List<Map<String, dynamic>>> load() async {
    final me = db.auth.currentUser!.id;
    final data = await db.from('invitations').select('id,sender_id,receiver_id,status,message,professions(name_ar),created_at').or('sender_id.eq.$me,receiver_id.eq.$me').order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> respond(String id, String status) async {
    try {
      await db.from('invitations').update({'status': status, 'responded_at': DateTime.now().toIso8601String()}).eq('id', id);
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) toast(context, 'تعذر التحديث: ${clean(e)}');
    }
  }

  Future<void> openChat(String other) async {
    try {
      final me = db.auth.currentUser!.id;
      final existing = await db.from('conversation_participants').select('conversation_id').eq('user_id', me);
      String? conversationId;
      for (final item in List<Map<String, dynamic>>.from(existing)) {
        final id = item['conversation_id'].toString();
        final otherRows = await db.from('conversation_participants').select('user_id').eq('conversation_id', id).eq('user_id', other);
        if (otherRows.isNotEmpty) {
          conversationId = id;
          break;
        }
      }
      if (conversationId == null) {
        final created = await db.from('conversations').insert({}).select('id').single();
        conversationId = created['id'].toString();
        await db.from('conversation_participants').insert([
          {'conversation_id': conversationId, 'user_id': me},
          {'conversation_id': conversationId, 'user_id': other},
        ]);
      }
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) => Chat(conversationId!)));
    } catch (e) {
      if (mounted) toast(context, 'تعذر فتح المحادثة: ${clean(e)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الدعوات')),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: load(),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Center(child: Text('خطأ: ${snapshot.error}'));
            final data = snapshot.data ?? [];
            final me = db.auth.currentUser!.id;
            if (data.isEmpty) return const Center(child: Text('لا توجد دعوات'));
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];
                final incoming = item['receiver_id'] == me;
                final status = item['status'].toString();
                final profession = ((item['professions'] as Map?)?['name_ar'] ?? 'تواصل').toString();
                Widget? trailing;
                if (incoming && status == 'pending') {
                  trailing = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () => respond(item['id'].toString(), 'accepted'), icon: const Icon(Icons.check, color: Colors.green)),
                      IconButton(onPressed: () => respond(item['id'].toString(), 'rejected'), icon: const Icon(Icons.close, color: Colors.red)),
                    ],
                  );
                } else if (status == 'accepted') {
                  final other = incoming ? item['sender_id'].toString() : item['receiver_id'].toString();
                  trailing = IconButton(onPressed: () => openChat(other), icon: const Icon(Icons.chat));
                }
                return Card(child: ListTile(title: Text(incoming ? 'دعوة واردة' : 'دعوة مرسلة'), subtitle: Text('$profession\nالحالة: $status'), isThreeLine: true, trailing: trailing));
              },
            );
          },
        ),
      ),
    );
  }
}

class Chats extends StatelessWidget {
  const Chats({super.key});

  Future<List<Map<String, dynamic>>> load() async {
    final data = await db.from('conversation_participants').select('conversation_id').eq('user_id', db.auth.currentUser!.id);
    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المحادثات')),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: load(),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Center(child: Text('خطأ: ${snapshot.error}'));
            final data = snapshot.data ?? [];
            if (data.isEmpty) return const Center(child: Text('لا توجد محادثات'));
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) => ListTile(
                leading: const Icon(Icons.chat),
                title: Text('محادثة ${index + 1}'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Chat(data[index]['conversation_id'].toString()))),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Chat extends StatefulWidget {
  final String id;
  const Chat(this.id, {super.key});
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final text = TextEditingController();

  Future<List<Map<String, dynamic>>> load() async {
    final data = await db.from('messages').select('*').eq('conversation_id', widget.id).order('created_at');
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> send() async {
    if (text.text.trim().isEmpty) return;
    try {
      await db.from('messages').insert({'conversation_id': widget.id, 'sender_id': db.auth.currentUser!.id, 'body': text.text.trim()});
      text.clear();
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) toast(context, 'تعذر الإرسال: ${clean(e)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المحادثة')),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: load(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
                  if (snapshot.hasError) return Center(child: Text('خطأ: ${snapshot.error}'));
                  final data = snapshot.data ?? [];
                  return ListView.builder(itemCount: data.length, itemBuilder: (_, index) => ListTile(title: Text((data[index]['body'] ?? '').toString())));
                },
              ),
            ),
            Row(
              children: [
                Expanded(child: TextField(controller: text, decoration: deco('اكتب رسالة'))),
                IconButton(onPressed: send, icon: const Icon(Icons.send)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  Future<List<Map<String, dynamic>>> load() async {
    final data = await db.from('notifications').select('*').eq('user_id', db.auth.currentUser!.id).order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الإشعارات')),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: load(),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Center(child: Text('خطأ: ${snapshot.error}'));
            final data = snapshot.data ?? [];
            if (data.isEmpty) return const Center(child: Text('لا توجد إشعارات'));
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) => ListTile(
                leading: const Icon(Icons.notifications),
                title: Text((data[index]['title'] ?? '').toString()),
                subtitle: Text((data[index]['body'] ?? '').toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final name = TextEditingController();
  String role = 'job_seeker';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      final row = await db.from('profiles').select('*').eq('id', db.auth.currentUser!.id).maybeSingle();
      if (row != null) {
        name.text = (row['full_name'] ?? '').toString();
        role = (row['account_type'] ?? 'job_seeker').toString();
      }
    } catch (e) {
      if (mounted) toast(context, 'تعذر تحميل الحساب: ${clean(e)}');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  String roleArabic(String value) {
    if (value == 'job_seeker') return 'باحث عن عمل';
    if (value == 'investor') return 'مستثمر';
    if (value == 'project_owner') return 'صاحب مشروع';
    return 'صاحب عمل / شركة';
  }

  Future<void> save() async {
    try {
      await db.from('profiles').update({'full_name': name.text.trim(), 'updated_at': DateTime.now().toIso8601String()}).eq('id', db.auth.currentUser!.id);
      if (mounted) toast(context, 'تم الحفظ');
    } catch (e) {
      if (mounted) toast(context, 'تعذر الحفظ: ${clean(e)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('حسابي')),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),
                  const SizedBox(height: 20),
                  TextField(controller: name, decoration: deco('الاسم')),
                  ListTile(leading: const Icon(Icons.badge), title: const Text('نوع الحساب'), subtitle: Text(roleArabic(role))),
                  FilledButton(onPressed: save, child: const Text('حفظ')),
                ],
              ),
      ),
    );
  }
}
