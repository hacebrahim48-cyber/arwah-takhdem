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
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'أرواح تخدم | مشاريع',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
    home: const SplashScreen(),
  );
}

const wilayas = <String>[
  'أدرار','الشلف','الأغواط','أم البواقي','باتنة','بجاية','بسكرة','بشار','البليدة','البويرة',
  'تمنراست','تبسة','تلمسان','تيارت','تيزي وزو','الجزائر','الجلفة','جيجل','سطيف','سعيدة',
  'سكيكدة','سيدي بلعباس','عنابة','قالمة','قسنطينة','المدية','مستغانم','المسيلة','معسكر','ورقلة',
  'وهران','البيض','إليزي','برج بوعريريج','بومرداس','الطارف','تندوف','تيسمسيلت','الوادي','خنشلة',
  'سوق أهراس','تيبازة','ميلة','عين الدفلى','النعامة','عين تموشنت','غرداية','غليزان','تيميمون',
  'برج باجي مختار','أولاد جلال','بني عباس','عين صالح','عين قزام','تقرت','جانت','المغير','المنيعة',
  'آفلو','بريكة','القنطرة','بئر العاتر','العريشة','قصر الشلالة','عين وسارة','مسعد','قصر البخاري',
  'بوسعادة','الأبيض سيدي الشيخ'
];

const professions = <String>[
  'طبيب عام','طبيب أخصائي','طبيب أسنان','صيدلي','ممرض','قابلة','مساعد طبي','مخبري تحاليل','تقني أشعة','بيطري',
  'أخصائي نفساني','أخصائي تغذية','أستاذ ابتدائي','أستاذ متوسط','أستاذ ثانوي','أستاذ جامعي','معلم','مربي أطفال',
  'مدرب رياضي','محاسب','خبير محاسبي','مراقب مالي','مدير إداري','سكرتير','مساعد إداري','موظف استقبال','موارد بشرية',
  'مسؤول مبيعات','مندوب تجاري','مسوق','مسؤول تسويق رقمي','مصمم جرافيك','مصور','مصور فيديو','صحفي','محرر','مترجم',
  'كاتب محتوى','مبرمج','مطور تطبيقات','مطور مواقع','مهندس برمجيات','مهندس شبكات','تقني إعلام آلي','محلل بيانات',
  'مصمم واجهات','مسؤول أمن معلومات','مهندس مدني','مهندس معماري','مهندس كهرباء','مهندس ميكانيك','مهندس صناعي',
  'مهندس إلكترونيات','مهندس اتصالات','مهندس طاقة','مهندس فلاحي','تقني سامي في البناء','تقني سامي في الكهرباء',
  'تقني سامي في الميكانيك','تقني صيانة','كهربائي بناء','كهربائي صناعي','ميكانيكي سيارات','ميكانيكي شاحنات',
  'كهربائي سيارات','مصلح أجهزة كهرومنزلية','سباك','نجار','حداد','لحام','دهان','جباس','بلاط','عامل بناء','بنّاء',
  'عامل ورشة','عامل مصنع','عامل إنتاج','عامل نظافة','حارس','عامل مخزن','مراقب جودة','عامل تغليف','خياط','طرّاز',
  'حلاق','مصفف شعر','خباز','حلواني','طباخ','مساعد طباخ','نادل','عامل مطعم','بائع','تاجر','مسير محل','أمين مخزن',
  'موزع','سائق سيارة','سائق شاحنة','سائق حافلة','سائق أجرة','سائق توصيل','عامل نقل','ميكانيكي آلات فلاحية',
  'فلاح','مزارع','مربي مواشي','مربي دواجن','مربي نحل','صياد','عامل صيد بحري','عامل تربية أسماك','عامل بستان',
  'عامل سقي وري','عامل غراسة','عامل حصاد','عامل تعليب غذائي','تقني تبريد وتكييف','فني أجهزة تبريد',
  'فني طاقة شمسية','فني كاميرات مراقبة','فني إنذار وحماية','فني مصاعد','فني إلكترونيات','فني هواتف',
  'فني صيانة حواسيب','صائغ','حرفي جلد','حرفي فخار','حرفي نحاس','حرفي ألومنيوم','حرفي زجاج','مساعدة منزلية',
  'مربية أطفال منزلية','مقدم رعاية كبار السن','مساعد شخصي','عامل حديقة','عامل غسيل سيارات','عامل مغسلة','عامل فندقي',
  'موظف فندق','موظف سياحة وأسفار','مرشد سياحي','موظف بنك','موظف تأمين','محامي','مستشار قانوني','مفتش','مراقب',
  'أمن صناعي','مسؤول سلامة','مكلف بالدراسات','باحث','مستقل Freelance','صاحب حرفة','صاحب مؤسسة','مهنة أخرى'
];

const projectCategories = <String>[
  'العقارات والبناء','الفلاحة وتربية المواشي','الصناعة والإنتاج','الصناعات الغذائية','التجارة والمحلات',
  'النقل والخدمات اللوجستية','التكنولوجيا والبرمجيات','التطبيقات والمشاريع الرقمية','الصحة والعيادات',
  'التعليم والتكوين','السياحة والفنادق','المطاعم والمقاهي','الطاقة والطاقة الشمسية','المياه',
  'إعادة التدوير والبيئة','النسيج والملابس','السيارات وقطع الغيار','الورشات والحرف','الصيد وتربية الأسماك',
  'الخدمات','مشاريع منزلية','مشاريع ناشئة','مشاريع صغيرة ومتوسطة','مشاريع صناعية كبرى','مشروع آخر'
];

const investmentCategories = <String>[
  'العقارات','الفلاحة','الصناعة','التجارة','الصناعات الغذائية','التكنولوجيا','الشركات الناشئة',
  'التطبيقات والمنصات الرقمية','السياحة','الفنادق','المطاعم','النقل','الطاقة','الطاقة الشمسية','الصحة',
  'التعليم','الخدمات','إعادة التدوير','السيارات وقطع الغيار','الصيد البحري','مشاريع صغيرة','مشاريع متوسطة',
  'مشاريع كبيرة','شراء حصة في شركة','شراكة في مشروع قائم','تمويل مشروع جديد','استثمار آخر'
];

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Directionality(textDirection: TextDirection.rtl, child: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('🇩🇿', style: TextStyle(fontSize: 64)),
        const SizedBox(height: 18),
        const Text('أرواح تخدم | مشاريع', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const Text('فرص العمل والمشاريع والاستثمار في مكان واحد'),
        const SizedBox(height: 35),
        FilledButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountTypeScreen())), child: const Text('ابدأ الآن')),
      ],
    ))),
  );
}

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});
  static const types = [('👷','باحث عن عمل'),('🏢','شركة تبحث عن عمال'),('🏗️','صاحب مشروع'),('💰','مستثمر')];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('اختر نوع الحساب')),
    body: Directionality(textDirection: TextDirection.rtl, child: ListView.separated(
      padding: const EdgeInsets.all(20), itemCount: types.length, separatorBuilder: (_,__) => const SizedBox(height: 12),
      itemBuilder: (_,i) => Card(child: ListTile(
        leading: Text(types[i].$1, style: const TextStyle(fontSize: 34)), title: Text(types[i].$2, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_back_ios_new), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(accountType: types[i].$2))),
      )),
    )),
  );
}

class HomeScreen extends StatelessWidget {
  final String accountType;
  const HomeScreen({super.key, required this.accountType});
  @override
  Widget build(BuildContext context) {
    final buttons = [('أبحث عن عمل',Icons.work),('أبحث عن عامل',Icons.person_search),('أبحث عن مشروع',Icons.business),('أبحث عن مستثمر',Icons.account_balance),('طلباتي',Icons.assignment),('المحادثات',Icons.chat),('الإشعارات',Icons.notifications),('الملف الشخصي',Icons.person)];
    return Scaffold(appBar: AppBar(title: const Text('أرواح تخدم | مشاريع')), body: Directionality(textDirection: TextDirection.rtl, child: ListView(padding: const EdgeInsets.all(20), children: [
      Text('مرحبًا 👋', style: Theme.of(context).textTheme.headlineSmall), Text('نوع الحساب: $accountType', style: const TextStyle(color: Colors.grey)), const SizedBox(height: 20),
      ...buttons.map((b) => Card(margin: const EdgeInsets.only(bottom: 12), child: ListTile(leading: Icon(b.$2,color: Colors.green),title: Text(b.$1),trailing: const Icon(Icons.arrow_back_ios_new,size:18),onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_) => FeatureScreen(title:b.$1,accountType:accountType))))))
    ])));
  }
}

class FeatureScreen extends StatelessWidget {
  final String title; final String accountType;
  const FeatureScreen({super.key, required this.title, required this.accountType});
  @override
  Widget build(BuildContext context) {
    late Widget page;
    switch(title){
      case 'أبحث عن عمل': page=const SearchJobsPage(); break;
      case 'أبحث عن عامل': page=const SearchWorkersPage(); break;
      case 'أبحث عن مشروع': page=const ProjectsPage(); break;
      case 'أبحث عن مستثمر': page=const InvestorsPage(); break;
      case 'طلباتي': page=const RequestsPage(); break;
      case 'المحادثات': page=const MessagesPage(); break;
      case 'الإشعارات': page=const NotificationsPage(); break;
      default: page=ProfilePage(accountType:accountType);
    }
    return Scaffold(appBar: AppBar(title: Text(title)),body: Directionality(textDirection: TextDirection.rtl,child: page));
  }
}

class SearchJobsPage extends StatefulWidget { const SearchJobsPage({super.key}); @override State<SearchJobsPage> createState()=>_SearchJobsPageState(); }
class _SearchJobsPageState extends State<SearchJobsPage>{ String? job, wilaya; bool searched=false;
  @override Widget build(BuildContext c)=>FilterPage(title:'البحث عن فرص العمل',firstLabel:'المهنة أو الوظيفة',firstValue:job,firstItems:professions,secondLabel:'الولاية',secondValue:wilaya,secondItems:wilayas,button:'بحث عن فرص العمل',onFirst:(v)=>setState(()=>job=v),onSecond:(v)=>setState(()=>wilaya=v),onSearch:()=>setState(()=>searched=true),result:searched?'تم البحث عن «${job??'كل المهن'}» ${wilaya==null?'في جميع الولايات':'في ولاية $wilaya'}\nستظهر النتائج الحقيقية بعد ربط قاعدة البيانات.':null); }
class SearchWorkersPage extends StatefulWidget { const SearchWorkersPage({super.key}); @override State<SearchWorkersPage> createState()=>_SearchWorkersPageState(); }
class _SearchWorkersPageState extends State<SearchWorkersPage>{ String? job,wilaya; bool searched=false;
  @override Widget build(BuildContext c)=>FilterPage(title:'البحث عن عامل',firstLabel:'المهنة المطلوبة',firstValue:job,firstItems:professions,secondLabel:'الولاية',secondValue:wilaya,secondItems:wilayas,button:'بحث عن العمال',onFirst:(v)=>setState(()=>job=v),onSecond:(v)=>setState(()=>wilaya=v),onSearch:()=>setState(()=>searched=true),result:searched?'البحث عن ${job??'كل المهن'} ${wilaya==null?'في جميع الولايات':'في ولاية $wilaya'}\nستظهر النتائج الحقيقية بعد ربط قاعدة البيانات.':null); }

class FilterPage extends StatelessWidget { final String title,firstLabel,button; final String? firstValue,secondValue,result; final List<String> firstItems,secondItems; final ValueChanged<String> onFirst,onSecond; final VoidCallback onSearch;
  const FilterPage({super.key,required this.title,required this.firstLabel,required this.firstValue,required this.firstItems,required this.secondValue,required this.secondItems,required this.secondLabel,required this.button,required this.onFirst,required this.onSecond,required this.onSearch,this.result});
  @override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(20),children:[Text(title,style:const TextStyle(fontSize:25,fontWeight:FontWeight.bold)),const SizedBox(height:20),ChoiceTile(label:firstLabel,value:firstValue??'اختر من القائمة',items:firstItems,onChanged:onFirst),ChoiceTile(label:secondLabel,value:secondValue??'اختر الولاية',items:secondItems,onChanged:onSecond),const SizedBox(height:15),FilledButton.icon(onPressed:onSearch,icon:const Icon(Icons.search),label:Text(button)),if(result!=null)...[const SizedBox(height:20),Card(child:Padding(padding:const EdgeInsets.all(18),child:Text(result!,style:const TextStyle(fontSize:16))))]]);
}

class ChoiceTile extends StatelessWidget { final String label,value; final List<String> items; final ValueChanged<String> onChanged; const ChoiceTile({super.key,required this.label,required this.value,required this.items,required this.onChanged});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:12),child:ListTile(leading:Icon(label.contains('ولاية')?Icons.location_on:Icons.work,color:Colors.green),title:Text(label),subtitle:Text(value),trailing:const Icon(Icons.arrow_back_ios_new,size:17),onTap:()async{final v=await Navigator.push<String>(c,MaterialPageRoute(builder:(_)=>ChoicePicker(title:label,items:items)));if(v!=null)onChanged(v);}));
}
class ChoicePicker extends StatefulWidget { final String title; final List<String> items; const ChoicePicker({super.key,required this.title,required this.items}); @override State<ChoicePicker> createState()=>_ChoicePickerState(); }
class _ChoicePickerState extends State<ChoicePicker>{ final search=TextEditingController(); late List<String> list;
  @override void initState(){super.initState();list=widget.items;search.addListener(filter);}
  void filter(){final q=search.text.trim().toLowerCase();setState(()=>list=widget.items.where((x)=>x.toLowerCase().contains(q)).toList());}
  @override void dispose(){search.dispose();super.dispose();}
  @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text(widget.title)),body:Column(children:[Padding(padding:const EdgeInsets.all(14),child:TextField(controller:search,decoration:const InputDecoration(hintText:'ابحث داخل القائمة',prefixIcon:Icon(Icons.search)))),Expanded(child:ListView.builder(itemCount:list.length,itemBuilder:(_,i){final item=list[i];return ListTile(title:Text(item),trailing:const Icon(Icons.arrow_back_ios_new,size:15),onTap:()=>item.endsWith('أخرى')?_other(c,item):Navigator.pop(c,item));}))]));
  Future<void> _other(BuildContext c,String item)async{final ctrl=TextEditingController();final v=await showDialog<String>(context:c,builder:(_)=>AlertDialog(title:Text('اكتب $item'),content:TextField(controller:ctrl,autofocus:true),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('إلغاء')),FilledButton(onPressed:()=>Navigator.pop(c,ctrl.text.trim()),child:const Text('حفظ'))]));ctrl.dispose();if(v!=null&&v.isNotEmpty&&mounted)Navigator.pop(c,v);}
}

class ProjectsPage extends StatefulWidget { const ProjectsPage({super.key}); @override State<ProjectsPage> createState()=>_ProjectsPageState(); }
class _ProjectsPageState extends State<ProjectsPage>{String? cat,wilaya,budget; final projects=const[
  ['مشروع بناء عمارة سكنية','العقارات والبناء','الجزائر','120,000,000 دج'],['مزرعة دواجن متكاملة','الفلاحة وتربية المواشي','البليدة','25,000,000 دج'],['مصنع مواد تنظيف','الصناعة والإنتاج','وهران','80,000,000 دج'],['تطبيق توصيل الطلبات','التطبيقات والمشاريع الرقمية','قسنطينة','15,000,000 دج'],['مطعم سياحي','المطاعم والمقاهي','عنابة','35,000,000 دج']];
  @override Widget build(BuildContext c){final shown=projects.where((p)=>(cat==null||p[1]==cat)&&(wilaya==null||p[2]==wilaya)).toList();return ListView(padding:const EdgeInsets.all(20),children:[const Text('أبحث عن مشروع',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold)),const SizedBox(height:8),const Text('قائمة موسعة مع البحث في المجالات والولايات والميزانية.'),const SizedBox(height:18),ChoiceTile(label:'مجال المشروع',value:cat??'اختر مجال المشروع',items:projectCategories,onChanged:(v)=>setState(()=>cat=v)),ChoiceTile(label:'الولاية',value:wilaya??'اختر الولاية',items:wilayas,onChanged:(v)=>setState(()=>wilaya=v)),ChoiceTile(label:'الميزانية',value:budget??'اختر نطاق الميزانية',items:const['أقل من 1,000,000 دج','1,000,000 - 5,000,000 دج','5,000,000 - 20,000,000 دج','20,000,000 - 50,000,000 دج','50,000,000 - 100,000,000 دج','أكثر من 100,000,000 دج'],onChanged:(v)=>setState(()=>budget=v)),const SizedBox(height:8),...shown.map((p)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.business)),title:Text(p[0]),subtitle:Text('📌 ${p[1]}\n📍 ${p[2]}\n💰 ${p[3]}'),trailing:const Icon(Icons.arrow_back_ios_new,size:16),onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>ProjectDetails(p:p))))))]);}
}
class ProjectDetails extends StatelessWidget{final List<String> p;const ProjectDetails({super.key,required this.p});@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('تفاصيل المشروع')),body:Directionality(textDirection:TextDirection.rtl,child:ListView(padding:const EdgeInsets.all(20),children:[Container(height:170,decoration:BoxDecoration(color:Colors.green.shade100,borderRadius:BorderRadius.circular(18)),child:const Icon(Icons.business,size:90,color:Colors.green)),const SizedBox(height:18),Text(p[0],style:const TextStyle(fontSize:25,fontWeight:FontWeight.bold)),const SizedBox(height:15),Text('نوع المشروع: ${p[1]}'),Text('الولاية: ${p[2]}'),Text('الميزانية: ${p[3]}'),const SizedBox(height:20),const Text('وصف المشروع',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const Text('تفاصيل المشروع، احتياجات التمويل، مدة الإنجاز ونسبة التمويل المطلوبة ستضاف عند ربط قاعدة البيانات.'),const SizedBox(height:20),FilledButton.icon(onPressed:()=>_snack(c,'تم تسجيل اهتمامك بالمشروع'),icon:const Icon(Icons.favorite_border),label:const Text('أنا مهتم')),OutlinedButton.icon(onPressed:()=>_snack(c,'يمكن فتح المحادثة بعد ربطها بقاعدة البيانات'),icon:const Icon(Icons.chat),label:const Text('تواصل مع صاحب المشروع'))])));}
}

class InvestorsPage extends StatefulWidget{const InvestorsPage({super.key});@override State<InvestorsPage> createState()=>_InvestorsPageState();}
class _InvestorsPageState extends State<InvestorsPage>{String? cat,wilaya,amount;final investors=const[
 ['مستثمر في المشاريع الصغيرة','مشاريع صغيرة','الجزائر','حتى 20,000,000 دج'],['مستثمر عقاري','العقارات','وهران','حتى 100,000,000 دج'],['مستثمر في الطاقة الشمسية','الطاقة الشمسية','ورقلة','حتى 80,000,000 دج'],['مستثمر تكنولوجي','التكنولوجيا','قسنطينة','حتى 30,000,000 دج']];
 @override Widget build(BuildContext c){final shown=investors.where((i)=>(cat==null||i[1]==cat)&&(wilaya==null||i[2]==wilaya)).toList();return ListView(padding:const EdgeInsets.all(20),children:[const Text('أبحث عن مستثمر',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold)),const SizedBox(height:8),const Text('قائمة موسعة لمجالات الاستثمار مع الولاية والمبلغ.'),const SizedBox(height:18),ChoiceTile(label:'مجال الاستثمار',value:cat??'اختر المجال',items:investmentCategories,onChanged:(v)=>setState(()=>cat=v)),ChoiceTile(label:'ولاية المستثمر',value:wilaya??'اختر الولاية',items:wilayas,onChanged:(v)=>setState(()=>wilaya=v)),ChoiceTile(label:'قيمة الاستثمار',value:amount??'اختر قيمة الاستثمار',items:const['أقل من 5,000,000 دج','5,000,000 - 20,000,000 دج','20,000,000 - 50,000,000 دج','50,000,000 - 100,000,000 دج','أكثر من 100,000,000 دج'],onChanged:(v)=>setState(()=>amount=v)),const SizedBox(height:8),...shown.map((i)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.account_balance)),title:Text(i[0]),subtitle:Text('📌 ${i[1]}\n📍 ${i[2]}\n💰 ${i[3]}'),trailing:const Icon(Icons.arrow_back_ios_new,size:16),onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>InvestorDetails(i:i))))))]);}
}
class InvestorDetails extends StatelessWidget{final List<String> i;const InvestorDetails({super.key,required this.i});@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('تفاصيل المستثمر')),body:Directionality(textDirection:TextDirection.rtl,child:ListView(padding:const EdgeInsets.all(20),children:[const CircleAvatar(radius:55,child:Icon(Icons.account_balance,size:55)),const SizedBox(height:18),Center(child:Text(i[0],textAlign:TextAlign.center,style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold))),const SizedBox(height:18),Text('مجال الاستثمار: ${i[1]}'),Text('الولاية: ${i[2]}'),Text('قيمة الاستثمار: ${i[3]}'),const SizedBox(height:20),const Text('نبذة',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const Text('ملف المستثمر وتفضيلاته وشروط التمويل ستظهر هنا عند ربط قاعدة البيانات.'),const SizedBox(height:20),FilledButton.icon(onPressed:()=>_snack(c,'تم إرسال طلب التواصل'),icon:const Icon(Icons.chat),label:const Text('تواصل مع المستثمر'))])));}
}

class RequestsPage extends StatelessWidget{const RequestsPage({super.key});@override Widget build(BuildContext c)=>SimplePage(title:'طلباتي',icon:Icons.assignment,text:'لا توجد طلبات حاليًا. ستظهر هنا طلبات العمل والتواصل والتمويل.');}
class MessagesPage extends StatelessWidget{const MessagesPage({super.key});@override Widget build(BuildContext c)=>SimplePage(title:'المحادثات',icon:Icons.chat,text:'لا توجد محادثات حاليًا. ستظهر هنا محادثاتك مع العمال وأصحاب المشاريع والمستثمرين.');}
class NotificationsPage extends StatelessWidget{const NotificationsPage({super.key});@override Widget build(BuildContext c)=>SimplePage(title:'الإشعارات',icon:Icons.notifications,text:'مرحبًا بك في أرواح تخدم 🎉 ستظهر هنا إشعارات الطلبات والرسائل والمشاريع.');}
class SimplePage extends StatelessWidget{final String title,text;final IconData icon;const SimplePage({super.key,required this.title,required this.icon,required this.text});@override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(20),children:[Text(title,style:const TextStyle(fontSize:25,fontWeight:FontWeight.bold)),const SizedBox(height:20),Card(child:Padding(padding:const EdgeInsets.all(25),child:Column(children:[Icon(icon,size:55,color:Colors.green),const SizedBox(height:15),Text(text,textAlign:TextAlign.center)]))) ]);}

class ProfilePage extends StatelessWidget{final String accountType;const ProfilePage({super.key,required this.accountType});@override Widget build(BuildContext c)=>ListView(padding:const EdgeInsets.all(20),children:[const Center(child:CircleAvatar(radius:50,child:Icon(Icons.person,size:55))),const SizedBox(height:15),const Center(child:Text('الملف الشخصي',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold))),Center(child:Text(accountType)),const SizedBox(height:25),Card(child:ListTile(leading:const Icon(Icons.person,color:Colors.green),title:const Text('المعلومات الشخصية'),subtitle:const Text('الاسم، الهاتف، الولاية'),onTap:()=>_snack(c,'صفحة المعلومات الشخصية'))),Card(child:ListTile(leading:const Icon(Icons.work,color:Colors.green),title:const Text('المهنة والمهارات'),subtitle:const Text('اختر مهنتك أو اكتب مهنة أخرى'),onTap:()async{final v=await Navigator.push<String>(c,MaterialPageRoute(builder:(_)=>const ChoicePicker(title:'المهن والوظائف',items:professions)));if(v!=null&&c.mounted)_snack(c,'تم اختيار: $v');})),Card(child:ListTile(leading:const Icon(Icons.location_on,color:Colors.green),title:const Text('الولاية'),subtitle:const Text('جميع الولايات الـ69'),onTap:()async{final v=await Navigator.push<String>(c,MaterialPageRoute(builder:(_)=>const ChoicePicker(title:'ولايات الجزائر الـ69',items:wilayas)));if(v!=null&&c.mounted)_snack(c,'تم اختيار: $v');})),Card(child:ListTile(leading:const Icon(Icons.settings,color:Colors.green),title:const Text('الإعدادات'),subtitle:const Text('الحساب والخصوصية'),onTap:()=>_snack(c,'الإعدادات')))]);}

void _snack(BuildContext c,String s)=>ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text(s)));
