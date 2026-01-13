import 'package:flutter/material.dart';

class PetPerformanceScreen extends StatefulWidget {
  const PetPerformanceScreen({super.key});

  @override
  State<PetPerformanceScreen> createState() => _PetPerformanceScreenState();
}

class _PetPerformanceScreenState extends State<PetPerformanceScreen> {
  static const Color brandBlue = Color(0xFF5A96F8);
  static const Color brandYellow = Color(0xFFFFD24A);
  static const Color bgGrey = Color(0xFFF8F9FA);

  int bottomIndex = 1;
  String selectedTab = "PawPrints"; // Tracks which top tab is active

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double scale = size.width / 375;
    final double contentWidth = size.width > 600 ? 500 : size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: brandBlue,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _header(scale, contentWidth),
              _tabs(scale, contentWidth),
              _filters(scale, contentWidth),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentWidth),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(20 * scale.clamp(0.8, 1.2)),
                        child: _buildBodyContent(scale),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavBar(scale),
      ),
    );
  }

  // ---------------- BODY CONTENT SWITCHER ----------------
  Widget _buildBodyContent(double scale) {
    if (selectedTab == "PawPrints") {
      return Column(
        children: [
          Text(
            'Your Pet Sitting Performance',
            style: TextStyle(
              fontSize: 16 * scale.clamp(0.8, 1.2),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20 * scale),
          _statsGrid(scale),
          SizedBox(height: 16 * scale),
          _pageDots(),
          SizedBox(height: 30 * scale),
          _ratingSection(scale),
          SizedBox(height: 30 * scale),
          _reviewSection(scale),
          SizedBox(height: 40 * scale),
        ],
      );
    } else if (selectedTab == "Services") {
      return _extraScreenPlaceholder(
        "My Services",
        Icons.room_service_outlined,
      );
    } else {
      return _extraScreenPlaceholder("My Customers", Icons.people_outline);
    }
  }

  Widget _extraScreenPlaceholder(String title, IconData icon) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 50),
        Icon(icon, size: 80, color: Colors.grey.shade300),
        const SizedBox(height: 10),
        const Text(
          "This screen is coming soon!",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  // ---------------- RESPONSIVE HEADER ----------------
  Widget _header(double scale, double maxWidth) {
    return Container(
      width: maxWidth,
      padding: EdgeInsets.symmetric(
        horizontal: 20 * scale,
        vertical: 10 * scale,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 40 * scale),
          Text(
            'Pet Sitter',
            style: TextStyle(
              color: Colors.white,
              fontSize: (20 * scale).clamp(18, 24),
              fontWeight: FontWeight.bold,
            ),
          ),
          CircleAvatar(
            radius: 18 * scale,
            backgroundColor: brandYellow,
            child: Icon(Icons.add, color: Colors.black, size: 22 * scale),
          ),
        ],
      ),
    );
  }

  // ---------------- TOP TABS ----------------
  Widget _tabs(double scale, double maxWidth) {
    return Container(
      width: maxWidth,
      margin: EdgeInsets.symmetric(
        horizontal: 20 * scale,
        vertical: 10 * scale,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _tabItem("PawPrints", scale),
          _tabItem("Services", scale),
          _tabItem("Customers", scale),
        ],
      ),
    );
  }

  Widget _tabItem(String label, double scale) {
    bool active = selectedTab == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = label;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12 * scale),
          decoration: BoxDecoration(
            color: active ? brandYellow : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: (13 * scale).clamp(11, 15),
                fontWeight: FontWeight.bold,
                color: active ? Colors.black : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- TIME FILTERS ----------------
  Widget _filters(double scale, double maxWidth) {
    final filters = ["This Week", "This Month", "This Year", "All Time"];
    return Container(
      width: maxWidth,
      padding: EdgeInsets.fromLTRB(
        20 * scale,
        5 * scale,
        20 * scale,
        20 * scale,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: filters
            .map(
              (f) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12 * scale,
                  vertical: 8 * scale,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  f,
                  style: TextStyle(
                    fontSize: (11 * scale).clamp(10, 14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // ---------------- STATS GRID ----------------
  Widget _statsGrid(double scale) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = (constraints.maxWidth - 15) / 2;
        return Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            _StatImageCard(
              title: 'Views',
              value: '999,000',
              image: 'assets/images/eye.png',
              width: cardWidth,
              scale: scale,
              titleColor: Colors.blue,
            ),
            _StatImageCard(
              title: 'Likes',
              value: '999,000',
              image: 'assets/images/Heart.png',
              width: cardWidth,
              scale: scale,
              titleColor: Colors.red,
            ),
            _StatImageCard(
              title: 'Bookings',
              value: '999,000',
              image: 'assets/images/Bookings.png',
              width: cardWidth,
              scale: scale,
              titleColor: brandBlue,
            ),
            _StatImageCard(
              title: 'Earnings',
              value: '999,000',
              image: 'assets/images/earning.png',
              overlayImage:
                  'assets/images/Ellipse upper.png', // The layered image
              width: cardWidth,
              scale: scale,
              titleColor: Colors.teal,
            ),
          ],
        );
      },
    );
  }

  Widget _pageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(radius: 5, backgroundColor: Colors.grey.shade500),
        const SizedBox(width: 6),
        CircleAvatar(radius: 4, backgroundColor: Colors.grey.shade300),
      ],
    );
  }

  // ---------------- RATINGS & REVIEWS (REUSABLE) ----------------
  Widget _ratingSection(double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overall Ratings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 12 * scale),
        Container(
          decoration: BoxDecoration(
            color: bgGrey,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20 * scale),
                child: Row(
                  children: [
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontSize: 38 * scale,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          Icons.star,
                          color: brandBlue,
                          size: 22 * scale,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              SizedBox(height: 8 * scale),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reviewSection(double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Reviews',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 12 * scale),
        Container(
          padding: EdgeInsets.all(16 * scale),
          decoration: BoxDecoration(
            color: bgGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25 * scale,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Avantika Agarwal',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '2 days ago',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (i) => const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12 * scale),
              Text(
                'Michael is amazing with pets! He took exceptional care of my two cats while I was away...',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13 * scale,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomNavBar(double scale) {
    return BottomNavigationBar(
      currentIndex: bottomIndex,
      onTap: (index) => setState(() => bottomIndex = index),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.shade400,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_rounded),
          label: 'Sitter',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: 'Agenda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Earning',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Chats',
        ),
      ],
    );
  }
}

// ---------------- UPDATED STAT CARD WITH LAYERED IMAGE ----------------
class _StatImageCard extends StatelessWidget {
  final String title, value, image;
  final String? overlayImage; // Optional secondary image
  final double width, scale;
  final Color titleColor;

  const _StatImageCard({
    required this.title,
    required this.value,
    required this.image,
    this.overlayImage,
    required this.width,
    required this.scale,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 100 * scale,
      padding: EdgeInsets.all(15 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13 * scale,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              width: 45 * scale,
              height: 45 * scale,
              child: Stack(
                alignment:
                    Alignment.center, // This centers all children in the Stack
                children: [
                  // Base image (The background icon)
                  Image.asset(
                    image,
                    width: 35 * scale,
                    height: 35 * scale,
                    fit: BoxFit.contain,
                  ),
                  // Overlay image (The small icon in the center)
                  if (overlayImage != null)
                    Image.asset(
                      overlayImage!,
                      width: 20 * scale, // Smaller size so it fits inside
                      height: 20 * scale,
                      fit: BoxFit.contain,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
