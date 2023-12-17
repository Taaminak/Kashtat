import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Core/constants/RoutesManager.dart';
import 'package:kashtat/Features/More%20Screen/Widgets/ItemWidget.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key,}) : super(key: key);
  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Image.asset(
                ImageManager.logoHalfGrey,
                height: size.height / 2.5,
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: MediaQuery.of(context).viewPadding.top + 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  ImageManager.backIcon,
                                  width: 10,
                                ),
                              )),
                        ),
                      const SizedBox(height: 20),
                      Image.asset(
                        ImageManager.logoWithTitleHColored,
                        width: 150,
                      ),
                      const SizedBox(height: 20),
                        Text(
                          'الحساب',
                          style: TextStyle(
                            fontSize: FontSize.s34,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorManager.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 0), // changes position of shadow
                            ),

                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                              style: TextStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.medium,
                                height: 2
                              ),
                              'سياسة الخصوصية : جمع المعلومات و استخدامها تقع على عاتقنا مهمة حماية معلوماتك الشخصية،, علماً بأن سياسة الخصوصية هذه لا تنطبق على مواقع شركائنا في العمل، الشركات التابعة، أو أي أطراف أخرى، وحتى إن تم الإشارة إليهم على الموقع. لذا ننصحك بمراجعة سياسة الخصوصية العائدة للأطراف الأخرى التي تود التعامل معها. عند استخدامك للخدمات المتوفرة على الموقع أو تطبيقات الموبايل، سيتم طلب تقديم بعض المعلومات مثل اسمك، عناوين الاتصال، بطاقة الائتمان أو بطاقة الخصم. ويتم تخزين هذه المعلومات والاحتفاظ بها على أجهزة الكمبيوتر أو غيرها. ما هي المعلومات التي سنقوم بجمعها؟ • معلومات شخصية • معلومات الدفع • معلومات الحجز • معلومات أخرى طرق استخدام المعلومات • الوفاء باتفاقنا معك بما في ذلك ، الحجوزات وأي حجز آخر، تجهيز مناسباتك ، أوالتواصل معك في حال وجود أي مشكلة تتعلق بالحجز الخاص بك. • لتسجيل اسمك على موقعنا أو تطبيقات الموبايل وبالتالي يمكنك إدارة حسابك على موقعنا لتلقي جميع خدماتنا. كما يمكنك إلغاء الاشتراك عبر التواصل معنا في حال لم تعد ترغب بالتمتع بهذه الخدمات. • للإجابة على أي استفسار قمت بإرساله إلينا عبر البريد الالكتروني. • لأغراض التسويق المباشر، على النحو المبين بالتفصيل أدناه. من الضروري لدينا معرفة جميع أسماء العملاء الذين حجزوا إذا كنت قد قمت بالحجز بالنيابة عن شخص آخر، فمن المفترض أن تكون قد حصلت على موافقته لاستخدام معلوماته الشخصية. وسوف نكمل الإجراءات بناءً على الموافقة المذكورة أعلاه. • لإجراء الحجوزات، ومعاملات الدفع في الخدمات المتوفرة على الموقع. • لمنحك تجربة خاصة وتقديم أفضل الخدمات ( والعمل على تلبية احتياجاتك الفردية على أفضل وجه عبر تزويدنا بمعلوماتك الشخصية) • لتطوير أداء استخدام الموقع: ( نسعى دوماً لتحسين خدمات الموقع استناداً على المعلومات التي نستلمها منك) • لتحسين خدمة العملاء (هذه المعلومات تساعدنا على الإجابة بشكل أفضل على طلباتك الموجهة لفريق خدمة العملاء ودعم احتياجاتهم)و تحليل حركة البيانات على الموقع. • لإدارة أي مسابقة أو عرض ترويجي، أو استطلاع إحصائي أو إحدى ميزات الموقع الأخرى. • لإرسال رسائل إلى البريد الإلكتروني أو رسائل قصيرة أوغيرها من الوسائل المتاحة لتقديم كافة الخدمات، والإجابة على جميع الاستفسارات والطلبات، وغيرها من الأسئلة. • للاستجابة على استفساراتك فيما يتعلق باستخدامك للموقع والخدمات المتاحة إليك. • التسجيل التلقائي لدخول البيانات. بالتأكيد، أنت المسؤول الوحيد عن سرية كلمة المرور الخاصة بك، ومعلومات حسابك الشخصي. لذا نرجو منك الحرص على الحفاظ على هذه المعلومات لاسيما عندما تكون متصلاً بالإنترنت.   معلوماتك الشخصية سوف نقوم باستخدام جميع المعلومات المقدمة من طرفك أو التي استطعنا الحصول عليها لتطوير وتحسين الخدمات المقدمة إليك ولجميع عملائنا وتزويدكم بأحدث الأخبار عن تطبيقاتنا الجديدة الخدمات و العروض الخاصة والقيمة عبر (البريد أو البريد الإلكتروني أو الهاتف أو غير ذلك). وقد نقوم في بعض الأحيان بإعلامك عن المنتجات الجديدة والخدمات والعروض الخاصة لأطراف أخرى محدّدة، في حال قمت خلال عملية التسجيل بالموافقة على خيار تلقّي نشرةتطبيق و موقع كشتات الإلكترونية وآخر التحديثات. نقوم بمشاركة معلوماتك مع : من الممكن أن نقوم بمشاركة معلوماتك على النحو التالي: • لجميع فروع مكاتب فريق خدمة العملاء. • لأطراف أخرى جديرة بالثقة والتي نقوم بالتعامل معها لتوفير خدمات معينة مثل :الإتاحة لعملائنا بحجز الشاليهات أو الاستراحات أو المخيمات أ, المزارع أو منسقي الحفلات. • لأطراف أخرى مشاركة في سياسة ترخيص بطاقة الائتمان. • إذا كان لدينا مهمة للقيام بذلك أو إذا كان القانون يسمح لنا بذلك. • لموظفينا ووكلائنا للقيام بإحدى المهام التي قمنا بالإشارة إليها أعلاه، الآن أو في المستقبل. • للمؤسسات الشريكة التي هي من ضمن شركتنا وشركتنا الأم وأخرى تابعة لها، حيث تمكننا هذه المشاركة من ان نقدم لك معلومات حول خدمات ومنتجات، ذات صلة بالرحلات وغيرها والتي قد تثير اهتمامك. وستكون لدى هذه الشركات صلاحية محدّدة للاطلاع على معلوماتك الخاصة طبقاّ لما ورد ذكره في سياسة الخصوصية. كما ستقوم هذه الشركات بالامتثال للقوانين المعمول بها التي تنظمها وسائل الاتصالات، والتي تمنحك على أقل تقدير الفرصة لاختيار عدم استلام رسائل مشابهة عبر بريدها الإلكتروني التجاري في المستقبل'),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
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
