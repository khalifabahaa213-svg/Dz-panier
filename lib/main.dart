import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // التقاط الأخطاء غير المعالجة لمنع إغلاق التطبيق المفاجئ
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  runApp(const DzPanierApp());
}

class DzPanierApp extends StatelessWidget {
  const DzPanierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DzPanier - جزباني',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DzPanierHomeScreen(),
    const ExploreMapScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
                  BottomNavigationBarItem(
          icon: Icon(Icons.home), // أضف الأيقونة المناسبة هنا (مثلاً Icons.home أو غيرها)
          label: 'الرئيسية',     // أو العنوان الخاص بك
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'السلات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'الخريطة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'طلباتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// الشاشة الرئيسية - استعراض سلات الفائض (Surplus Baskets)
// -----------------------------------------------------------------------------
class DzPanierHomeScreen extends StatelessWidget {
  const DzPanierHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.eco, color: Colors.white),
            const SizedBox(width: 8),
            const Text(
              'DzPanier | جزباني',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الهيدر والرسالة البيئية
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF2E7D32),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Colors.white70, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'الموقع: مستغانم - سلاموندر / صلاماندر',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'أنقذ الطعام اليوم بثلث السعر الأصلي! 🌿',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // الفئات السريعة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip('الكل 🧺', true),
                    _buildCategoryChip('مخابز وحلويات 🥐', false),
                    _buildCategoryChip('مطاعم وجبات 🍕', false),
                    _buildCategoryChip('سوبرماركت ومواد غذائية 🛒', false),
                    _buildCategoryChip('فواكه وخضر 🍎', false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // عنوان القائمة
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'سلات المفاجآت المتاحة بالقرب منك',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            // قائمة السلات
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                BasketCard(
                  storeName: 'مخبزة وحلويات السلام',
                  basketType: 'سلة حلويات ومعجنات مشكلة 🥐',
                  pickupTime: 'اليوم: 18:00 - 20:00',
                  originalPrice: '1500 DA',
                  discountPrice: '500 DA',
                  itemsLeft: 3,
                  rating: '4.9',
                  distance: '1.2 كلم',
                  imageIcon: Icons.bakery_dining,
                ),
                BasketCard(
                  storeName: 'بيتزا بيت الشام',
                  basketType: 'سلة وجبات سريعة ومقبلات 🍕',
                  pickupTime: 'اليوم: 21:30 - 23:00',
                  originalPrice: '1800 DA',
                  discountPrice: '600 DA',
                  itemsLeft: 1,
                  rating: '4.8',
                  distance: '0.8 كلم',
                  imageIcon: Icons.local_pizza,
                ),
                BasketCard(
                  storeName: 'سوبرماركت الأمل',
                  basketType: 'سلة ألبان وأجبان ومشروبات 🧀',
                  pickupTime: 'غداً: 10:00 - 12:00',
                  originalPrice: '2500 DA',
                  discountPrice: '800 DA',
                  itemsLeft: 5,
                  rating: '4.7',
                  distance: '2.5 كلم',
                  imageIcon: Icons.shopping_basket,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// عنصر كارت السلة
// -----------------------------------------------------------------------------
class BasketCard extends StatelessWidget {
  final String storeName;
  final String basketType;
  final String pickupTime;
  final String originalPrice;
  final String discountPrice;
  final int itemsLeft;
  final String rating;
  final String distance;
  final IconData imageIcon;

  const BasketCard({
    super.key,
    required this.storeName,
    required this.basketType,
    required this.pickupTime,
    required this.originalPrice,
    required this.discountPrice,
    required this.itemsLeft,
    required this.rating,
    required this.distance,
    required this.imageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        onTap: () {
          _showBasketDetails(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(imageIcon, size: 40, color: const Color(0xFF2E7D32)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              storeName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'متبقي $itemsLeft فقط',
                                style: TextStyle(
                                  color: Colors.orange.shade900,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          basketType,
                          style: const TextStyle(color: Colors.black87, fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              pickupTime,
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 2),
                      Text(rating, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Text('• $distance', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        originalPrice,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        discountPrice,
                        style: const TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBasketDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                storeName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                basketType,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              const Text(
                'محتويات السلة: سلة مفاجآت تحتوي على منتجات طازجة وفائضة من اليوم جودة ممتازة بخصم يزيد عن 60%.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'السعر: $discountPrice',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم حجز السلة بنجاح! الرجاء التوجه للمحل في وقت الاستلام.'),
                          backgroundColor: Color(0xFF2E7D32),
                        ),
                      );
                    },
                    child: const Text('حجز السلة الآن 🛍️', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// الشاشات الثانوية (الخريطة، الطلبات، الملف الشخصي)
// -----------------------------------------------------------------------------
class ExploreMapScreen extends StatelessWidget {
  const ExploreMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خريطة المحلات القريبة'),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 80, color: Color(0xFF2E7D32)),
            SizedBox(height: 16),
            Text('استعراض المحلات الشريكة على الخريطة التفاعلية'),
          ],
        ),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجوزاتي وسلاتي'),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: const Center(
        child: Text('لا توجد حجوزات سابقة حتى الآن.'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحساب الشخصي'),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF2E7D32),
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            SizedBox(height: 12),
            Text('المستخدم الجزائري 🇩🇿', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.eco, color: Colors.green),
              title: Text('تأثيرك البيئي'),
              subtitle: Text('تم إنقاذ 0 كجم من الطعام هدر حتى الآن'),
            ),
          ],
        ),
      ),
    );
  }
}
