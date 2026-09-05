import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
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
        fontFamily: 'Arial',
      ),
      home: const LoginPage(),
    );
  }
}

// ==================== LOGIN ====================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.work,
                    size: 80,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'أرواح تخدم | مشاريع 🇩🇿',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'منصة العمل والمشاريع والاستثمار',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 35),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'رقم الهاتف',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'كلمة المرور',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomePage(),
                          ),
                        );
                      },
                      child: const Text('دخول'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('سيتم إضافة استرجاع كلمة المرور لاحقًا'),
                        ),
                      );
                    },
                    child: const Text('نسيت كلمة المرور؟'),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text('إنشاء حساب جديد'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== REGISTER ====================

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String accountType = 'باحث عن عمل';

  final accountTypes = const [
    'باحث عن عمل',
    'صاحب عمل',
    'شركة تبحث عن عمال',
    'صاحب مشروع',
    'مستثمر',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('إنشاء حساب')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'نوع الحساب',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: accountType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: accountTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      accountType = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerificationPage(
                          accountType: accountType,
                        ),
                      ),
                    );
                  },
                  child: const Text('متابعة والتحقق من الهاتف'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== VERIFICATION ====================

class VerificationPage extends StatelessWidget {
  final String accountType;

  const VerificationPage({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    final codeController = TextEditingController();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('التحقق من الهاتف')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(
                Icons.verified_user,
                size: 70,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              const Text(
                'أدخل رمز التحقق المرسل إلى هاتفك',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: codeController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'رمز التحقق',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text('تأكيد وإنشاء الحساب ($accountType)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== HOME ====================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      _HomeButton(
        title: 'أبحث عن عمل',
        icon: Icons.search,
        page: const JobSearchPage(),
      ),
      _HomeButton(
        title: 'أبحث عن عامل',
        icon: Icons.person_search,
        page: const WorkerSearchPage(),
      ),
      _HomeButton(
        title: 'الشركات تبحث عن عمال',
        icon: Icons.business,
        page: const CompanyJobsPage(),
      ),
      _HomeButton(
        title: 'أبحث عن مشروع',
        icon: Icons.construction,
        page: const ProjectsPage(),
      ),
      _HomeButton(
        title: 'أبحث عن مستثمر',
        icon: Icons.attach_money,
        page: const InvestorsPage(),
      ),
      _HomeButton(
        title: 'الدعوات',
        icon: Icons.mail,
        page: const InvitationsPage(),
      ),
      _HomeButton(
        title: 'المحادثات',
        icon: Icons.chat,
        page: const ChatsPage(),
      ),
      _HomeButton(
        title: 'الإشعارات',
        icon: Icons.notifications,
        page: const NotificationsPage(),
      ),
      _HomeButton(
        title: 'حسابي',
        icon: Icons.account_circle,
        page: const ProfilePage(),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('أرواح تخدم | مشاريع 🇩🇿'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        child: Icon(Icons.person),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مرحباً بك 👋',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('نوع الحساب: باحث عن عمل'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  final item = buttons[index];

                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => openPage(context, item.page),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.icon,
                              size: 38,
                              color: Colors.green,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeButton {
  final String title;
  final IconData icon;
  final Widget page;

  const _HomeButton({
    required this.title,
    required this.icon,
    required this.page,
  });
}

// ==================== JOB SEARCH ====================

class JobSearchPage extends StatefulWidget {
  const JobSearchPage({super.key});

  @override
  State<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final professionController = TextEditingController();

  String wilaya = wilayas.first;
  String experience = '0 - 2 سنوات';
  String age = '18 - 25';
  String gender = 'الكل';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('أبحث عن عمل')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'ابحث عن فرصة عمل',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: professionController,
              decoration: const InputDecoration(
                labelText: 'المهنة / الوظيفة',
                prefixIcon: Icon(Icons.work),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            dropdown(
              'الولاية',
              wilaya,
              wilayas,
              (value) => setState(() => wilaya = value!),
            ),
            dropdown(
              'الخبرة',
              experience,
              const [
                '0 - 2 سنوات',
                '3 - 5 سنوات',
                '6 - 10 سنوات',
                'أكثر من 10 سنوات',
              ],
              (value) => setState(() => experience = value!),
            ),
            dropdown(
              'العمر',
              age,
              const [
                '18 - 25',
                '26 - 35',
                '36 - 45',
                '46 - 55',
                'أكثر من 55',
              ],
              (value) => setState(() => age = value!),
            ),
            dropdown(
              'الجنس',
              gender,
              const ['الكل', 'ذكر', 'أنثى'],
              (value) => setState(() => gender = value!),
            ),
            const SizedBox(height: 15),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const JobResultsPage(),
                  ),
                );
              },
              icon: const Icon(Icons.search),
              label: const Text('بحث عن فرص العمل'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== WORKER SEARCH ====================

class WorkerSearchPage extends StatefulWidget {
  const WorkerSearchPage({super.key});

  @override
  State<WorkerSearchPage> createState() => _WorkerSearchPageState();
}

class _WorkerSearchPageState extends State<WorkerSearchPage> {
  final professionController = TextEditingController();

  String wilaya = wilayas.first;
  String experience = '0 - 2 سنوات';
  String age = '18 - 25';
  String gender = 'الكل';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('أبحث عن عامل')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'ابحث عن عامل حسب المهنة',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: professionController,
              decoration: const InputDecoration(
                labelText: 'المهنة / الوظيفة',
                prefixIcon: Icon(Icons.work),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            dropdown(
              'الولاية',
              wilaya,
              wilayas,
              (value) => setState(() => wilaya = value!),
            ),
            dropdown(
              'الخبرة',
              experience,
              const [
                '0 - 2 سنوات',
                '3 - 5 سنوات',
                '6 - 10 سنوات',
                'أكثر من 10 سنوات',
              ],
              (value) => setState(() => experience = value!),
            ),
            dropdown(
              'العمر',
              age,
              const [
                '18 - 25',
                '26 - 35',
                '36 - 45',
                '46 - 55',
                'أكثر من 55',
              ],
              (value) => setState(() => age = value!),
            ),
            dropdown(
              'الجنس',
              gender,
              const ['الكل', 'ذكر', 'أنثى'],
              (value) => setState(() => gender = value!),
            ),
            const SizedBox(height: 15),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WorkerResultsPage(),
                  ),
                );
              },
              icon: const Icon(Icons.search),
              label: const Text('البحث عن العمال'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== RESULTS ====================

class JobResultsPage extends StatelessWidget {
  const JobResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('فرص العمل')),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            JobCard(
              title: 'عامل بناء',
              company: 'شركة البناء الحديثة',
              location: 'الجزائر',
            ),
            JobCard(
              title: 'كهربائي',
              company: 'مؤسسة خاصة',
              location: 'وهران',
            ),
            JobCard(
              title: 'سائق',
              company: 'شركة نقل',
              location: 'سطيف',
            ),
          ],
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;

  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.work),
        ),
        title: Text(title),
        subtitle: Text('$company\n$location'),
        isThreeLine: true,
        trailing: FilledButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إرسال طلب التقديم'),
              ),
            );
          },
          child: const Text('تقديم'),
        ),
      ),
    );
  }
}

class WorkerResultsPage extends StatelessWidget {
  const WorkerResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('العمال')),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            WorkerCard(
              name: 'عامل محترف',
              profession: 'كهربائي',
              location: 'الجزائر',
            ),
            WorkerCard(
              name: 'عامل محترف',
              profession: 'عامل بناء',
              location: 'وهران',
            ),
            WorkerCard(
              name: 'عامل محترف',
              profession: 'سباك',
              location: 'قسنطينة',
            ),
          ],
        ),
      ),
    );
  }
}

class WorkerCard extends StatelessWidget {
  final String name;
  final String profession;
  final String location;

  const WorkerCard({
    super.key,
    required this.name,
    required this.profession,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(name),
        subtitle: Text('$profession\n$location'),
        isThreeLine: true,
        trailing: FilledButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const InvitationSentPage(),
              ),
            );
          },
          child: const Text('دعوة'),
        ),
      ),
    );
  }
}

class InvitationSentPage extends StatelessWidget {
  const InvitationSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الدعوة')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.mark_email_sent,
                  size: 80,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                const Text(
                  'تم إرسال الدعوة بنجاح',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'ستفتح المحادثة فقط بعد قبول الدعوة.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== COMPANY JOBS ====================

class CompanyJobsPage extends StatelessWidget {
  const CompanyJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الشركات تبحث عن عمال')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddCompanyJobPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            JobCard(
              title: '5 عمال بناء',
              company: 'شركة الجزائر للبناء',
              location: 'البليدة',
            ),
            JobCard(
              title: '2 كهربائي',
              company: 'مؤسسة الكهرباء',
              location: 'وهران',
            ),
          ],
        ),
      ),
    );
  }
}

class AddCompanyJobPage extends StatefulWidget {
  const AddCompanyJobPage({super.key});

  @override
  State<AddCompanyJobPage> createState() => _AddCompanyJobPageState();
}

class _AddCompanyJobPageState extends State<AddCompanyJobPage> {
  final companyController = TextEditingController();
  final professionController = TextEditingController();
  final numberController = TextEditingController();

  String wilaya = wilayas.first;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('إعلان توظيف')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextField(
              controller: companyController,
              decoration: const InputDecoration(
                labelText: 'اسم الشركة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: professionController,
              decoration: const InputDecoration(
                labelText: 'المهنة المطلوبة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            dropdown(
              'الولاية',
              wilaya,
              wilayas,
              (value) => setState(() => wilaya = value!),
            ),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'عدد العمال',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم نشر إعلان التوظيف'),
                  ),
                );
              },
              child: const Text('نشر الإعلان'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== PROJECTS ====================

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المشاريع')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddProjectPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            ProjectCard(
              title: 'مشروع فلاحي',
              type: 'فلاحة',
              location: 'بسكرة',
            ),
            ProjectCard(
              title: 'مشروع تجاري',
              type: 'تجارة',
              location: 'الجزائر',
            ),
            ProjectCard(
              title: 'مشروع سياحي',
              type: 'سياحة',
              location: 'جيجل',
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String type;
  final String location;

  const ProjectCard({
    super.key,
    required this.title,
    required this.type,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.business_center),
        ),
        title: Text(title),
        subtitle: Text('$type\n$location'),
        isThreeLine: true,
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  String type = 'فلاحة';
  String wilaya = wilayas.first;

  final types = const [
    'فلاحة',
    'تجارة',
    'صناعة',
    'سياحة',
    'عقار',
    'خدمات',
    'تكنولوجيا',
    'نقل',
    'مطاعم',
    'مشروع حرفي',
    'مشروع طاقوي',
    'أخرى',
  ];

  final ImagePicker picker = ImagePicker();
  final List<XFile> images = [];

  Future<void> selectImages() async {
    final selected = await picker.pickMultiImage();

    if (selected.isNotEmpty) {
      setState(() {
        images.addAll(selected);
      });
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
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم المشروع',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: type,
              decoration: const InputDecoration(
                labelText: 'نوع المشروع',
                border: OutlineInputBorder(),
              ),
              items: types.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => type = value);
                }
              },
            ),
            const SizedBox(height: 12),
            dropdown(
              'الولاية',
              wilaya,
              wilayas,
              (value) => setState(() => wilaya = value!),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'قيمة المشروع',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'وصف المشروع',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: selectImages,
              icon: const Icon(Icons.photo_library),
              label: const Text('إضافة صور للمشروع'),
            ),
            if (images.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'تم اختيار ${images.length} صورة',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم نشر المشروع'),
                  ),
                );
              },
              child: const Text('نشر المشروع'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== INVESTORS ====================

class InvestorsPage extends StatelessWidget {
  const InvestorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المستثمرون')),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: const [
            ProjectCard(
              title: 'مستثمر في الفلاحة',
              type: 'فلاحة',
              location: 'بسكرة',
            ),
            ProjectCard(
              title: 'مستثمر في التجارة',
              type: 'تجارة',
              location: 'الجزائر',
            ),
            ProjectCard(
              title: 'مستثمر في السياحة',
              type: 'سياحة',
              location: 'وهران',
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== INVITATIONS ====================

class InvitationsPage extends StatelessWidget {
  const InvitationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الدعوات')),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: const Text('دعوة للتواصل'),
                subtitle: const Text('كهربائي - الجزائر'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'قبول',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'تم قبول الدعوة، يمكنك الآن بدء المحادثة',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      tooltip: 'رفض',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم رفض الدعوة'),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== CHATS ====================

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المحادثات')),
        body: ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: const Text('محادثة بعد قبول الدعوة'),
              subtitle: const Text('يمكنك الآن التواصل'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChatPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final messages = <String>[];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المحادثة')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: messages.length,
                itemBuilder: (_, index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(messages[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'اكتب رسالة...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (controller.text.trim().isEmpty) return;

                      setState(() {
                        messages.add(controller.text.trim());
                        controller.clear();
                      });
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== NOTIFICATIONS ====================

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الإشعارات')),
        body: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('إشعار جديد'),
              subtitle: Text('لديك دعوة جديدة'),
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('فرصة عمل جديدة'),
              subtitle: Text('تم نشر فرصة عمل تناسب مهنتك'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== PROFILE ====================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('حسابي')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const CircleAvatar(
              radius: 45,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                'باحث عن عمل',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.work),
              title: Text('المهنة'),
              subtitle: Text('يمكن تعديل المهنة لاحقاً'),
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('الولاية'),
              subtitle: Text('الجزائر'),
            ),
            const ListTile(
              leading: Icon(Icons.timeline),
              title: Text('سنوات الخبرة'),
              subtitle: Text('0 - 2 سنوات'),
            ),
            const ListTile(
              leading: Icon(Icons.cake),
              title: Text('العمر'),
              subtitle: Text('18 - 25'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HELPERS ====================

Widget dropdown(
  String label,
  String value,
  List<String> items,
  ValueChanged<String?> onChanged,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}

// ==================== 69 WILAYAS ====================

const List<String> wilayas = [
  'أدرار',
  'الشلف',
  'الأغواط',
  'أم البواقي',
  'باتنة',
  'بجاية',
  'بسكرة',
  'بشار',
  'البليدة',
  'البويرة',
  'تمنراست',
  'تبسة',
  'تلمسان',
  'تيارت',
  'تيزي وزو',
  'الجزائر',
  'الجلفة',
  'جيجل',
  'سطيف',
  'سعيدة',
  'سكيكدة',
  'سيدي بلعباس',
  'عنابة',
  'قالمة',
  'قسنطينة',
  'المدية',
  'مستغانم',
  'المسيلة',
  'معسكر',
  'ورقلة',
  'وهران',
  'البيض',
  'إليزي',
  'برج بوعريريج',
  'بومرداس',
  'الطارف',
  'تندوف',
  'تيسمسيلت',
  'الوادي',
  'خنشلة',
  'سوق أهراس',
  'تيبازة',
  'ميلة',
  'عين الدفلى',
  'النعامة',
  'عين تموشنت',
  'غليزان',
  'تيميمون',
  'برج باجي مختار',
  'أولاد جلال',
  'بني عباس',
  'عين صالح',
  'عين قزام',
  'تقرت',
  'جانت',
  'المغير',
  'المنيعة',
  'آفلو',
  'بريكة',
  'القنطرة',
  'بئر العاتر',
  'العريشة',
  'قصر الشلالة',
  'عين وسارة',
  'مسعد',
  'قصر البخاري',
  'بوسعادة',
  'الأبيض سيدي الشيخ',
];
