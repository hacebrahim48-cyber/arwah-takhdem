
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const ArwahApp());

class ArwahApp extends StatelessWidget {
  const ArwahApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'أرواح تخدم | مشاريع',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
        home: const LoginPage(),
      );
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(Icons.work, size: 80, color: Colors.green),
                  const SizedBox(height: 12),
                  const Text('أرواح تخدم | مشاريع 🇩🇿',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  const Text('منصة العمل والمشاريع والاستثمار'),
                  const SizedBox(height: 30),
                  const TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم الهاتف',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      ),
                      child: const Text('دخول'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('استرجاع كلمة المرور لاحقاً')),
                    ),
                    child: const Text('نسيت كلمة المرور؟'),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    ),
                    child: const Text('إنشاء حساب جديد'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String type = accountTypes.first;
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('إنشاء حساب')),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'رقم الهاتف', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'كلمة المرور', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              dropdown('نوع الحساب', type, accountTypes,
                  (v) => setState(() => type = v!)),
              FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => VerifyPage(accountType: type)),
                ),
                child: const Text('متابعة والتحقق من الهاتف'),
              ),
            ],
          ),
        ),
      );
}

class VerifyPage extends StatelessWidget {
  final String accountType;
  const VerifyPage({super.key, required this.accountType});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('التحقق من الهاتف')),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.verified_user, size: 70, color: Colors.green),
                const SizedBox(height: 20),
                const Text('أدخل رمز التحقق المرسل إلى هاتفك'),
                const SizedBox(height: 15),
                const TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: 'رمز التحقق', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (_) => false,
                  ),
                  child: Text('تأكيد الحساب: $accountType'),
                ),
              ],
            ),
          ),
        ),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final items = <HomeItem>[
      HomeItem('أبحث عن عمل', Icons.search, const SearchPage(workers: false)),
      HomeItem('أبحث عن عامل', Icons.person_search, const SearchPage(workers: true)),
      HomeItem('الشركات تبحث عن عمال', Icons.business, const CompanyJobsPage()),
      HomeItem('أبحث عن مشروع', Icons.construction, const ProjectsPage()),
      HomeItem('أبحث عن مستثمر', Icons.attach_money, const InvestorsPage()),
      HomeItem('الدعوات', Icons.mail, const InvitationsPage()),
      HomeItem('المحادثات', Icons.chat, const ChatsPage()),
      HomeItem('الإشعارات', Icons.notifications, const NotificationsPage()),
      HomeItem('حسابي', Icons.account_circle, const ProfilePage()),
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('أرواح تخدم | مشاريع 🇩🇿'),
            centerTitle: true),
        body: GridView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, i) {
            final item = items[i];
            return Card(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item.page),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, size: 42, color: Colors.green),
                    const SizedBox(height: 10),
                    Text(item.title, textAlign: TextAlign.center),
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

class HomeItem {
  final String title;
  final IconData icon;
  final Widget page;
  const HomeItem(this.title, this.icon, this.page);
}

class SearchPage extends StatefulWidget {
  final bool workers;
  const SearchPage({super.key, required this.workers});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String wilaya = wilayas.first;
  String experience = experienceOptions.first;
  String age = ageOptions.first;
  String gender = genderOptions.first;

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
              title: Text(widget.workers ? 'أبحث عن عامل' : 'أبحث عن عمل')),
          body: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: widget.workers
                      ? 'المهنة / الوظيفة المطلوبة'
                      : 'المهنة / الوظيفة',
                  prefixIcon: const Icon(Icons.work),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              dropdown('الولاية', wilaya, wilayas,
                  (v) => setState(() => wilaya = v!)),
              dropdown('سنوات الخبرة', experience, experienceOptions,
                  (v) => setState(() => experience = v!)),
              dropdown('العمر', age, ageOptions,
                  (v) => setState(() => age = v!)),
              dropdown('الجنس', gender, genderOptions,
                  (v) => setState(() => gender = v!)),
              FilledButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => widget.workers
                        ? const WorkerResultsPage()
                        : const JobResultsPage(),
                  ),
                ),
                icon: const Icon(Icons.search),
                label: const Text('بحث'),
              ),
            ],
          ),
        ),
      );
}

class JobResultsPage extends StatelessWidget {
  const JobResultsPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('فرص العمل')),
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: const [
              JobCard('عامل بناء', 'شركة البناء الحديثة', 'الجزائر'),
              JobCard('كهربائي', 'مؤسسة الكهرباء', 'وهران'),
              JobCard('سائق', 'شركة نقل', 'سطيف'),
              JobCard('سباك', 'مؤسسة الخدمات', 'قسنطينة'),
            ],
          ),
        ),
      );
}

class JobCard extends StatelessWidget {
  final String title, company, location;
  const JobCard(this.title, this.company, this.location, {super.key});
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.work)),
          title: Text(title),
          subtitle: Text('$company\n$location'),
          isThreeLine: true,
          trailing: FilledButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إرسال طلب التقديم')),
            ),
            child: const Text('تقديم'),
          ),
        ),
      );
}

class WorkerResultsPage extends StatelessWidget {
  const WorkerResultsPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('العمال')),
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: const [
              WorkerCard('عامل محترف', 'كهربائي', 'الجزائر'),
              WorkerCard('عامل محترف', 'عامل بناء', 'وهران'),
              WorkerCard('عامل محترف', 'سباك', 'قسنطينة'),
              WorkerCard('عامل محترف', 'سائق', 'سطيف'),
            ],
          ),
        ),
      );
}

class WorkerCard extends StatelessWidget {
  final String name, profession, location;
  const WorkerCard(this.name, this.profession, this.location, {super.key});
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(name),
          subtitle: Text('$profession\n$location'),
          isThreeLine: true,
          trailing: FilledButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InvitationSentPage()),
            ),
            child: const Text('دعوة'),
          ),
        ),
      );
}

class InvitationSentPage extends StatelessWidget {
  const InvitationSentPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('الدعوة')),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mark_email_read, size: 80, color: Colors.green),
                SizedBox(height: 20),
                Text('تم إرسال الدعوة بنجاح',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('ستفتح المحادثة بعد قبول الدعوة.'),
              ],
            ),
          ),
        ),
      );
}

class CompanyJobsPage extends StatelessWidget {
  const CompanyJobsPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('الشركات تبحث عن عمال')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddCompanyJobPage()),
            ),
            child: const Icon(Icons.add),
          ),
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: const [
              JobCard('5 عمال بناء', 'شركة الجزائر للبناء', 'البليدة'),
              JobCard('2 كهربائي', 'مؤسسة الكهرباء', 'وهران'),
            ],
          ),
        ),
      );
}

class AddCompanyJobPage extends StatefulWidget {
  const AddCompanyJobPage({super.key});
  @override
  State<AddCompanyJobPage> createState() => _AddCompanyJobPageState();
}

class _AddCompanyJobPageState extends State<AddCompanyJobPage> {
  String wilaya = wilayas.first;
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('إعلان توظيف')),
          body: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const TextField(
                  decoration: InputDecoration(
                      labelText: 'اسم الشركة',
                      border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const TextField(
                  decoration: InputDecoration(
                      labelText: 'المهنة المطلوبة',
                      border: OutlineInputBorder())),
              const SizedBox(height: 12),
              dropdown('الولاية', wilaya, wilayas,
                  (v) => setState(() => wilaya = v!)),
              const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'عدد العمال',
                      border: OutlineInputBorder())),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم نشر إعلان التوظيف')),
                ),
                child: const Text('نشر الإعلان'),
              ),
            ],
          ),
        ),
      );
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('المشاريع')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddProjectPage()),
            ),
            child: const Icon(Icons.add),
          ),
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: const [
              ProjectCard('مشروع فلاحي', 'فلاحة', 'بسكرة'),
              ProjectCard('مشروع تجاري', 'تجارة', 'الجزائر'),
              ProjectCard('مشروع سياحي', 'سياحة', 'جيجل'),
            ],
          ),
        ),
      );
}

class ProjectCard extends StatelessWidget {
  final String title, type, location;
  const ProjectCard(this.title, this.type, this.location, {super.key});
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.business_center)),
          title: Text(title),
          subtitle: Text('$type\n$location'),
          isThreeLine: true,
        ),
      );
}

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});
  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  String type = projectTypes.first;
  String wilaya = wilayas.first;
  final picker = ImagePicker();
  final images = <XFile>[];

  Future<void> pickImages() async {
    final selected = await picker.pickMultiImage();
    if (selected.isNotEmpty) setState(() => images.addAll(selected));
  }

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('إضافة مشروع')),
          body: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const TextField(
                  decoration: InputDecoration(
                      labelText: 'اسم المشروع',
                      border: OutlineInputBorder())),
              const SizedBox(height: 12),
              dropdown('نوع المشروع', type, projectTypes,
                  (v) => setState(() => type = v!)),
              dropdown('الولاية', wilaya, wilayas,
                  (v) => setState(() => wilaya = v!)),
              const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'قيمة المشروع',
                      border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                      labelText: 'وصف المشروع',
                      border: OutlineInputBorder())),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: pickImages,
                icon: const Icon(Icons.photo_library),
                label: const Text('إضافة صور للمشروع'),
              ),
              if (images.isNotEmpty)
                Text('تم اختيار ${images.length} صورة'),
              const SizedBox(height: 15),
              const Text('هل المشروع يحتاج عمالاً؟',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SwitchListTile(
                value: true,
                onChanged: (_) {},
                title: const Text('نعم، أريد نشر احتياج العمال'),
              ),
              FilledButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم نشر المشروع')),
                ),
                child: const Text('نشر المشروع'),
              ),
            ],
          ),
        ),
      );
}

class InvestorsPage extends StatelessWidget {
  const InvestorsPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('المستثمرون')),
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: const [
              ProjectCard('مستثمر في الفلاحة', 'فلاحة', 'بسكرة'),
              ProjectCard('مستثمر في التجارة', 'تجارة', 'الجزائر'),
              ProjectCard('مستثمر في السياحة', 'سياحة', 'وهران'),
              ProjectCard('مستثمر في التكنولوجيا', 'تكنولوجيا', 'سطيف'),
            ],
          ),
        ),
      );
}

class InvitationsPage extends StatelessWidget {
  const InvitationsPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('الدعوات')),
          body: Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: const Text('دعوة للتواصل'),
              subtitle: const Text('كهربائي - الجزائر'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم قبول الدعوة')),
                    ),
                    icon: const Icon(Icons.check, color: Colors.green),
                  ),
                  IconButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم رفض الدعوة')),
                    ),
                    icon: const Icon(Icons.close, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('المحادثات')),
          body: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text('محادثة بعد قبول الدعوة'),
            subtitle: const Text('يمكنك الآن التواصل'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatPage()),
            ),
          ),
        ),
      );
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('المحادثة')),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (_, i) => ListTile(title: Text(messages[i])),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(hintText: 'اكتب رسالة...'),
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
            ],
          ),
        ),
      );
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('الإشعارات')),
          body: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('إشعار جديد'),
                subtitle: Text('لديك دعوة جديدة'),
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: Text('فرصة عمل جديدة'),
                subtitle: Text('تم نشر فرصة تناسب مهنتك'),
              ),
            ],
          ),
        ),
      );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('حسابي')),
          body: ListView(
            padding: EdgeInsets.all(18),
            children: [
              CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),
              SizedBox(height: 20),
              Center(
                child: Text('باحث عن عمل',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: Text('المهنة'),
                subtitle: Text('يمكن تعديلها لاحقاً'),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('الولاية'),
                subtitle: Text('الجزائر'),
              ),
            ],
          ),
        ),
      );
}

Widget dropdown(
  String label,
  String value,
  List<String> items,
  ValueChanged<String?> onChanged,
) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map((item) =>
                DropdownMenuItem<String>(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );

const accountTypes = [
  'باحث عن عمل',
  'صاحب عمل',
  'شركة تبحث عن عمال',
  'صاحب مشروع',
  'مستثمر',
];

const experienceOptions = [
  '0 - 2 سنوات',
  '3 - 5 سنوات',
  '6 - 10 سنوات',
  'أكثر من 10 سنوات',
];

const ageOptions = [
  '18 - 25',
  '26 - 35',
  '36 - 45',
  '46 - 55',
  'أكثر من 55',
];

const genderOptions = ['الكل', 'ذكر', 'أنثى'];

const projectTypes = [
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

final wilayas = '''
أدرار,الشلف,الأغواط,أم البواقي,باتنة,بجاية,بسكرة,بشار,البليدة,البويرة,
تمنراست,تبسة,تلمسان,تيارت,تيزي وزو,الجزائر,الجلفة,جيجل,سطيف,سعيدة,
سكيكدة,سيدي بلعباس,عنابة,قالمة,قسنطينة,المدية,مستغانم,المسيلة,معسكر,ورقلة,
وهران,البيض,إليزي,برج بوعريريج,بومرداس,الطارف,تندوف,تيسمسيلت,الوادي,خنشلة,
سوق أهراس,تيبازة,ميلة,عين الدفلى,النعامة,عين تموشنت,غليزان,تيميمون,
برج باجي مختار,أولاد جلال,بني عباس,عين صالح,عين قزام,تقرت,جانت,المغير,
المنيعة,آفلو,بريكة,القنطرة,بئر العاتر,العريشة,قصر الشلالة,عين وسارة,مسعد,
قصر البخاري,بوسعادة,الأبيض سيدي الشيخ
'''
    .replaceAll('\n', '')
    .split(',')
    .map((e) => e.trim())
    .where((e) => e.isNotEmpty)
    .toList();
