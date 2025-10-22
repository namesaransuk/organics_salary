import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';

class PrivacuPolicyPage extends StatelessWidget {
  const PrivacuPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData.fallback(),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppTheme.ognOrangeGold,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text(
          'นโยบายคุ้มครองส่วนบุคคล',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppTheme.bgSoftGreen,
        child: SafeArea(
          // color: Colors.white,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [
          //       AppTheme.ognSoftGreen,
          //       Color.fromARGB(255, 198, 240, 236),
          //     ],
          //   ),
          // ),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            margin: const EdgeInsets.all(20.0),
            surfaceTintColor: Colors.white,
            color: Colors.white,
            child: RawScrollbar(
              thumbColor: AppTheme.ognOrangeGold,
              radius: const Radius.circular(20),
              thickness: 7,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/img/organics_legendary.png',
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    _buildHeader(
                        'นโยบายการคุ้มครองข้อมูลส่วนบุคคล (Data Privacy Policy)'),
                    const SizedBox(height: 20.0),
                    const Text(
                      'บริษัท ออกานิกส์ เลเจนดารี่ กรุ๊ป จำกัด (มหาชน) และบริษัทในเครือ ซึ่งต่อไปนี้เรียกว่า "บริษัท" ขอแจ้งการปรับปรุงนโยบายการคุ้มครองข้อมูลส่วนบุคคล (Data Privacy Policy) โดยเพิ่มเติมสิทธิหน้าที่ของบริษัทและผู้ใช้บริการ เพื่อให้ผู้ใช้บริการมีความมั่นใจ ปลอดภัย ได้รับประโยชน์จากการได้รับสิทธิคุ้มครองข้อมูลส่วนบุคคลตามพระราชบัญญัติคุ้มครองข้อมูลส่วนบุคคล พ.ศ. 2562',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'บริษัท ออกานิกส์ เลเจนดารี่ กรุ๊ป จำกัด (มหาชน) และบริษัทในเครือ ให้ความสำคัญอย่างยิ่งในการคุ้มครองข้อมูลส่วนบุคคล และให้ความสำคัญด้านการเคารพสิทธิในความเป็นส่วนตัวและการรักษาความปลอดภัยของข้อมูลส่วนบุคคลของผู้ใช้บริการ โดยนโยบายการคุ้มครองข้อมูลส่วนบุคคล (Data Privacy Policy) ได้เพิ่มเติมสิทธิหน้าที่ของบริษัทและผู้ใช้บริการ ด้วยมาตรการที่เข้มงวดในการรักษาความปลอดภัยของข้อมูลส่วนบุคคล เพื่อให้มั่นใจได้ว่า ข้อมูลส่วนบุคคลของผู้ใช้บริการที่บริษัทได้รับจะถูกนำไปใช้ตรงตามความต้องการของผู้ใช้บริการและถูกต้องตามกฎหมาย',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      '1. นโยบายฉบับนี้มีขึ้นเพื่ออะไร',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'นโยบายฉบับนี้ใช้เพื่อแจ้งให้ผู้ใช้บริการในฐานะเจ้าของข้อมูลส่วนบุคคล ทราบถึงวัตถุประสงค์และรายละเอียดของการเก็บรวบรวม ใช้ และเปิดเผยข้อมูลส่วนบุคคล ตลอดจนสิทธิตามกฎหมายของผู้ใช้บริการที่เกี่ยวข้องกับข้อมูลส่วนบุคคล',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      '2. ข้อมูลส่วนบุคคลอะไรบ้างที่บริษัทได้มีการเก็บรวบรวมใช้และเปิดเผย',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '2.1 ข้อมูลส่วนบุคคล คือ ข้อมูลที่ทำให้สามารถระบุตัวตนของผู้ใช้บริการได้ ไม่ว่าทางตรงหรือทางอ้อม ได้แก่',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '1) ข้อมูลส่วนบุคคลที่ผู้ใช้บริการให้ไว้แก่บริษัทโดยตรง หรือให้ผ่านบริษัท หรือมีอยู่กับบริษัททั้งที่เกิดจากการใช้บริการและผลิตภัณฑ์ การติดต่อ การเยี่ยมชม การค้นหา ผ่านช่องทางอิเล็กทรอนิกส์ เว็บไซต์ ศูนย์บริการลูกค้าสัมพันธ์ (Call Center) ผู้ที่ได้รับมอบหมาย หรือช่องทางอื่นใด',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '2) ข้อมูลส่วนบุคคลที่บริษัทได้รับหรือเข้าถึงได้จากแหล่งอื่น ซึ่งไม่ใช่จากผู้ใช้บริการโดยตรง เช่น หน่วยงานของรัฐ บริษัทในกลุ่มธุรกิจทางการเงิน สถาบันการเงิน ผู้ให้บริการทางการเงิน พันธมิตรทางธุรกิจ บริษัทข้อมูลเครดิต และผู้ให้บริการข้อมูล เป็นต้น ซึ่งบริษัทจะเก็บรวบรวมข้อมูลจากแหล่งอื่น ต่อเมื่อได้รับความยินยอมจากผู้ใช้บริการตามที่กฎหมายกำหนด เว้นแต่ บริษัทมีความจำเป็นตามแต่กรณีที่กฎหมายจะอนุญาต',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '3) ข้อมูลส่วนบุคคลของผู้ใช้บริการที่บริษัทได้มีการเก็บรวบรวม ใช้ และเปิดเผย เช่น',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Icon(
                            Icons.fiber_manual_record_rounded,
                            size: 10,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Flexible(
                          child: Text(
                            'ข้อมูลส่วนตัว เช่น ชื่อ-นามสกุล อายุ วันเดือนปีเกิด เลขประจำตัวประชาชน',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Icon(
                            Icons.fiber_manual_record_rounded,
                            size: 10,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Flexible(
                          child: Text(
                            'ข้อมูลการติดต่อ เช่น ที่อยู่อาศัย สถานที่ทำงาน หมายเลขโทรศัพท์ อีเมล',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Icon(
                            Icons.fiber_manual_record_rounded,
                            size: 10,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Flexible(
                          child: Text(
                            'ข้อมูลทางการเงิน เช่น เลขบัญชีเงินฝาก',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Icon(
                            Icons.fiber_manual_record_rounded,
                            size: 10,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Flexible(
                          child: Text(
                            'ข้อมูลการทำธุรกรรม เช่น การชำระเงิน การกู้ยืมเงิน',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Icon(
                            Icons.fiber_manual_record_rounded,
                            size: 10,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Flexible(
                          child: Text(
                            'ข้อมูลอุปกรณ์หรือเครื่องมือ เช่น IP address MAC address Cookie ID',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Icon(
                            Icons.fiber_manual_record_rounded,
                            size: 10,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Flexible(
                          child: Text(
                            'ข้อมูลอื่นๆ เช่น การใช้งานเว็บไซต์ เสียง ภาพนิ่ง ภาพเคลื่อนไหว และข้อมูลอื่นใดที่ถือว่าเป็นข้อมูลส่วนบุคคลภายใต้กฎหมายคุ้มครองข้อมูลส่วนบุคคล',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '2.2 ข้อมูลส่วนบุคคลที่มีความอ่อนไหว (Sensitive Data) คือ ข้อมูลส่วนบุคคลที่กฎหมายกำหนดเป็นการเฉพาะ ซึ่งบริษัทจะเก็บรวบรวม ใช้ และเปิดเผยข้อมูลส่วนบุคคลที่มีความอ่อนไหว ต่อเมื่อบริษัทได้รับความยินยอมโดยชัดแจ้งจากผู้ใช้บริการ หรือในกรณีที่บริษัทมีความจำเป็นตามกรณีที่กฎหมายอนุญาต โดยบริษัทจะสามารถเก็บรวบรวม ใช้และเปิดเผยข้อมูลส่วนบุคคล ข้อมูลชีวภาพ (Biometric) เช่น ข้อมูลภาพจำลองใบหน้า ข้อมูลจำลองลายนิ้วมือ ข้อมูลจำลองม่านตา ข้อมูลอัตลักษณ์เสียง เพื่อวัตถุประสงค์ในการพิสูจน์และยืนยันตัวตนของผู้ใช้บริการที่ขอสมัคร ขอใช้บริการ และทำธุรกรรมทางการเงินผ่านช่องทางอิเล็กทรอนิกส์ เว็บไซต์ ศูนย์บริการลูกค้าสัมพันธ์ (Call Center) หรือช่องทางอื่นใด เป็นต้น',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'ทั้งนี้ ต่อไปในนโยบายฉบับนี้ หากไม่มีการกล่าวโดยเฉพาะเจาะจงจะเรียก "ข้อมูลส่วนบุคคล" และ "ข้อมูลส่วนบุคคลที่มีความอ่อนไหว" ที่เกี่ยวกับผู้ใช้บริการข้างต้นให้รวมกันเรียกว่า "ข้อมูลส่วนบุคคล"',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '3.1 เพื่อให้ผู้ใช้บริการได้ใช้บริการและผลิตภัณฑ์ของบริษัทได้ตรงตามวัตถุประสงค์ของผู้ใช้บริการ และเพื่อการอื่นที่จำเป็นภายใต้กฎหมาย',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '1) เพื่อให้ผู้ใช้บริการสามารถใช้บริการและผลิตภัณฑ์ของบริษัทได้ตามความประสงค์ซึ่งผู้ใช้บริการเป็นคู่สัญญาอยู่กับบริษัท หรือเพื่อใช้ในการดำเนินการตามคำขอของผู้ใช้บริการก่อนใช้บริการและผลิตภัณฑ์ของบริษัท (Contractual Basis)',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '2) เพื่อปฎิบัติหน้าที่ตามกฎหมายที่เกี่ยวข้องหรือใช้บังคับ (Legal Obligation) เช่น',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '1. การปฏิบัติตามคำสั่งของผู้มีอำนาจตามกฎหมาย',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '2. การปฏิบัติตามกฎหมายระบบชำระเงินภายใต้การกำกับ กฎหมายหลักทรัพย์และตลาดหลักทรัพย์ กฎหมายภาษีอากร กฎหมายป้องกันและปราบปรามการฟอกเงินกฎหมายการป้องกันและปราบปรามการสนับสนุนทางการเงินแก่การก่อการร้ายและแพร่ขยายอาวุธที่มีอานุภาพทำลายล้างสูงกฎหมายคอมพิวเตอร์ กฎหมายล้มละลายและกฎหมายอื่นๆ ที่บริษัทจำเป็นต้องปฏิบัติตาม รวมถึงประกาศและระเบียบที่ออกตามกฎหมายดังกล่าวทั้งนี้ หากบริษัทจำเป็นต้องเก็บรวบรวมใช้และเปิดเผยข้อมูลส่วนบุคคลของผู้ใช้บริการ สำหรับการปฏิบัติหน้าที่ตามกฎหมายของบริษัท หรือการเข้าทำสัญญากับผู้ใช้บริการ บริษัทอาจจะไม่สามารถส่งมอบบริการและผลิตภัณฑ์ให้แก่ผู้ใช้บริการ (หรือไม่สามารถจัดหาบริการ และผลิตภัณฑ์ให้แก่ผู้ใช้บริการต่อไป) หากบริษัทไม่สามารถเก็บรวบรวมข้อมูลส่วนบุคคลของผู้ใช้บริการเมื่อมีการร้องขอ',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '3) เพื่อการดำเนินงานที่จำเป็นภายใต้ประโยชน์โดยชอบด้วยกฎหมายของบริษัท หรือของบุคคลหรือนิติบุคคลอื่น โดยไม่เกินขอบเขตที่ผู้ใช้บริการสามารถคาดหมายได้อย่างสมเหตุสมผล (Legitimate Interest) เช่น\n\n'
                      '1. การบันทึกเสียงทางศูนย์บริการลูกค้าสัมพันธ์ (Call Center) การบันทึกภาพ CCTV การแลกบัตรก่อนเข้าอาคาร\n\n'
                      '2. การรักษาความสัมพันธ์กับผู้ใช้บริการ เช่น การจัดการข้อร้องเรียน การประเมินความพึงพอใจ การดูแลผู้ใช้บริการโดยพนักงานของบริษัท การแจ้งเตือนหรือนำเสนอบริการและผลิตภัณฑ์ต่างๆ ประเภทเดียวกันกับที่ผู้ใช้บริการมีอยู่กับบริษัทซึ่งเป็นประโยชน์กับผู้ใช้บริการ\n\n'
                      '3. การบริหารความเสี่ยง การกำกับตรวจสอบ การบริหารจัดการภายในองค์กรรวมถึงการส่งต่อไปยังบริษัทในเครือกิจการเดียวกันเพื่อการดังกล่าวภายใต้นโยบายการคุ้มครองข้อมูลส่วนบุคคลของเครือกิจการ (Binding Corporate Rules)\n\n'
                      '4. การทำให้ข้อมูลส่วนบุคคลเป็นข้อมูลที่ไม่สามารถระบุตัวบุคคลได้ (Anonymous Data)\n\n'
                      '5. การป้องกันรับมือลดความเสี่ยงที่อาจเกิดการกระทำการทุจริต ภัยคุกคามทางไซเบอร์ การผิดนัดชำระหนี้หรือผิดสัญญา (เช่น ข้อมูลล้มละลาย) การทำผิดกฎหมายต่างๆ (เช่น การฟอกเงิน การสนับสนุนทางการเงินแก่การก่อการร้ายและแพร่ขยายอาวุธที่มีอานุภาพทำลายล้างสูง ความผิดเกี่ยวกับทรัพย์ ชีวิต ร่างกาย เสรีภาพหรือชื่อเสียง) ซึ่งรวมถึงการแบ่งปันข้อมูลส่วนบุคคลเพื่อยกระดับมาตรฐานการทำงานของบริษัทในเครือกิจการ/ธุรกิจเดียวกันในการป้องกันรับมือลดความเสี่ยงข้างต้น\n\n'
                      '6. การเก็บรวบรวมใช้และเปิดเผยข้อมูลส่วนบุคคลของกรรมการผู้มีอำนาจกระทำการแทนตัวแทนบริการ ตัวแทนรายย่อย ตัวแทนของผู้ใช้บริการนิติบุคคล\n\n'
                      '7. การติดต่อ การบันทึกภาพ การบันทึกเสียงเกี่ยวกับการจัดประชุม อบรม สันทนาการ กิจกรรม CRM หรือออกบูธ\n\n'
                      '8. การเก็บรวบรวมใช้และเปิดเผยข้อมูลส่วนบุคคลของบุคคลที่ศาลมีคำสั่งพิทักษ์ทรัพย์\n\n'
                      '9. การรับ-ส่งพัสดุ เอกสารต่างๆ',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
