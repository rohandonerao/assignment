import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  int _selectedIndex = 2; // "Customers" is selected

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF5D93E8), // Primary Blue
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSegmentedControl(),
              const SizedBox(height: 20),
              _buildSearchRow(),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    children: [
                      _buildCustomerCard(
                        name: "Carlitta Pusso",
                        petName: "Lara",
                        breed: "Sheltie",
                        gender: "Female",
                        petType: "Guinea Pig",
                        petColor: const Color(0xFFE91E63), // Pink
                        imageAsset: 'assets/images/girl.png',
                      ),
                      _buildCustomerCard(
                        name: "Carlitta Pusso",
                        petName: "Lara",
                        breed: "Sheltie",
                        gender: "Female",
                        petType: "       Dog       ",
                        petColor: const Color(0xFF8D6E63), // Brown
                        imageAsset: 'assets/images/girl.png',
                      ),
                      _buildCustomerCard(
                        name: "Carlitta Pusso",
                        petName: "Lara",
                        breed: "Sheltie",
                        gender: "Female",
                        petType: "   Hamster   ",
                        petColor: const Color(0xFFFFB300), // Orange/Yellow
                        imageAsset: 'assets/images/girl.png',
                      ),
                      _buildCustomerCard(
                        name: "Carlitta Pusso",
                        petName: "Lara",
                        breed: "Sheltie",
                        gender: "Female",
                        petType: "      Cat        ",
                        petColor: const Color(0xFF78909C), // Blue Grey
                        imageAsset: 'assets/images/girl.png',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 32), // Spacer to center title
          const Text(
            "Sitter",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFFFDE05C),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.black, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _segmentTile("PawPrints", 0),
          _segmentTile("Services", 1),
          _segmentTile("Customers", 2),
        ],
      ),
    );
  }

  Widget _segmentTile(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFDE05C) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade400),
                  const SizedBox(width: 10),
                  Text(
                    "Search..",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          _iconButton(Icons.tune, const Color(0xFFFDE05C)),
          const SizedBox(width: 10),
          _iconButton(Icons.favorite_border, Colors.white),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, Color bgColor) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, size: 20, color: Colors.black),
    );
  }

  Widget _buildCustomerCard({
    required String name,
    required String petName,
    required String breed,
    required String gender,
    required String petType,
    required Color petColor,
    required String imageAsset,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 35, backgroundImage: AssetImage(imageAsset)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(petName, style: const TextStyle(fontSize: 14)),
                    _verticalDivider(),
                    Text(breed, style: const TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  gender,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: petColor.withOpacity(0.5)),
            ),
            child: Text(
              petType,
              style: TextStyle(
                color: petColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 14,
      width: 1,
      color: Colors.grey.shade400,
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.blueGrey.shade200,
      currentIndex: 1,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Sitter"),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: "Agenda",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card_outlined),
          label: "Earning",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: "Chats",
        ),
      ],
    );
  }
}
