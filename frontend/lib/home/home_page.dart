import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const LearnToCodeApp());
}

class LearnToCodeApp extends StatelessWidget {
  const LearnToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn to Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Language {
  final String name;
  final String desc;
  final String icon;
  final int difficulty;
  final List<String> categories;
  final String type;
  final String url;

  Language({
    required this.name,
    required this.desc,
    required this.icon,
    required this.difficulty,
    required this.categories,
    required this.type,
    required this.url,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isDarkMode = false;
  String activeCategory = 'all';
  String searchQuery = '';
  late AnimationController _animationController;
  final TextEditingController _searchController = TextEditingController();

  // Color scheme
  Color get primaryColor => isDarkMode ? const Color(0xFF5D7BFF) : const Color(0xFF4A6BFF);
  Color get primaryLight => isDarkMode ? const Color(0xFF7D9BFF) : const Color(0xFF6A8BFF);
  Color get backgroundColor => isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F7FA);
  Color get cardColor => isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFFFFFFFF);
  Color get textColor => isDarkMode ? const Color(0xFFF5F7FA) : const Color(0xFF1E1E1E);
  Color get grayColor => isDarkMode ? const Color(0xFFADB5BD) : const Color(0xFF6C757D);
  Color get lightGrayColor => isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F7FA);

  final Map<String, List<Language>> allLanguages = {
    'popular': [
      Language(name: "Python", desc: "Beginner-friendly language for all purposes", icon: "🐍", difficulty: 1, categories: ['ai', 'data', 'web', 'game'], type: "Language", url: ""),
      Language(name: "JavaScript", desc: "The language of the web", icon: "🟨", difficulty: 2, categories: ['web', 'mobile', 'game'], type: "Language", url: ""),
      Language(name: "Java", desc: "Enterprise applications and Android", icon: "☕", difficulty: 3, categories: ['mobile', 'web'], type: "Language", url: ""),
      Language(name: "C++", desc: "High-performance system programming", icon: "⚡", difficulty: 4, categories: ['game'], type: "Language", url: ""),
      Language(name: "C#", desc: "Windows development and games", icon: "🔷", difficulty: 3, categories: ['game'], type: "Language", url: ""),
      Language(name: "Swift", desc: "Build iOS and macOS apps", icon: "🍎", difficulty: 2, categories: ['mobile'], type: "Language", url: ""),
      Language(name: "Kotlin", desc: "Modern Android development", icon: "🤖", difficulty: 2, categories: ['mobile'], type: "Language", url: ""),
      Language(name: "Go", desc: "Efficient cloud services", icon: "🐹", difficulty: 3, categories: ['cloud'], type: "Language", url: ""),
    ],
    'web': [
      Language(name: "HTML", desc: "Structure of web pages", icon: "🌐", difficulty: 1, categories: ['web'], type: "Markup", url: ""),
      Language(name: "CSS", desc: "Styling for the web", icon: "🎨", difficulty: 2, categories: ['web'], type: "Styling", url: ""),
      Language(name: "React", desc: "Popular frontend framework", icon: "⚛️", difficulty: 3, categories: ['web'], type: "Framework", url: ""),
      Language(name: "Angular", desc: "Enterprise frontend framework", icon: "🅰️", difficulty: 4, categories: ['web'], type: "Framework", url: ""),
      Language(name: "Vue", desc: "Progressive JavaScript framework", icon: "💚", difficulty: 2, categories: ['web'], type: "Framework", url: ""),
      Language(name: "Node.js", desc: "JavaScript on the server", icon: "🟢", difficulty: 3, categories: ['web'], type: "Runtime", url: ""),
      Language(name: "Django", desc: "Python web framework", icon: "🐍", difficulty: 3, categories: ['web'], type: "Framework", url: ""),
      Language(name: "Ruby on Rails", desc: "Developer-friendly framework", icon: "💎", difficulty: 3, categories: ['web'], type: "Framework", url: ""),
    ],
    'ai': [
      Language(name: "Python", desc: "Primary language for ML/AI", icon: "🐍", difficulty: 2, categories: ['ai', 'data', 'web', 'game'], type: "Language", url: ""),
      Language(name: "R", desc: "Statistical computing", icon: "📊", difficulty: 3, categories: ['ai', 'data'], type: "Language", url: ""),
      Language(name: "TensorFlow", desc: "Machine learning framework", icon: "🧠", difficulty: 4, categories: ['ai'], type: "Library", url: ""),
      Language(name: "PyTorch", desc: "Deep learning framework", icon: "🔥", difficulty: 4, categories: ['ai'], type: "Library", url: ""),
      Language(name: "Pandas", desc: "Data analysis library", icon: "🐼", difficulty: 2, categories: ['ai', 'data'], type: "Library", url: ""),
      Language(name: "NumPy", desc: "Numerical computing", icon: "🔢", difficulty: 3, categories: ['ai', 'data'], type: "Library", url: ""),
      Language(name: "Julia", desc: "High-performance computing", icon: "🔬", difficulty: 4, categories: ['ai'], type: "Language", url: ""),
      Language(name: "OpenCV", desc: "Computer vision", icon: "👁️", difficulty: 4, categories: ['ai'], type: "Library", url: ""),
    ],
    'mobile': [
      Language(name: "Swift", desc: "iOS and macOS development", icon: "🍎", difficulty: 2, categories: ['mobile'], type: "Language", url: ""),
      Language(name: "Kotlin", desc: "Modern Android development", icon: "🤖", difficulty: 2, categories: ['mobile'], type: "Language", url: ""),
      Language(name: "Flutter", desc: "Cross-platform framework", icon: "🦋", difficulty: 3, categories: ['mobile'], type: "Framework", url: ""),
      Language(name: "React Native", desc: "JavaScript mobile apps", icon: "⚛️", difficulty: 3, categories: ['mobile'], type: "Framework", url: ""),
      Language(name: "Java", desc: "Traditional Android", icon: "☕", difficulty: 3, categories: ['mobile', 'web'], type: "Language", url: ""),
      Language(name: "Dart", desc: "Language for Flutter", icon: "🎯", difficulty: 2, categories: ['mobile'], type: "Language", url: ""),
      Language(name: "Ionic", desc: "Hybrid mobile apps", icon: "⚡", difficulty: 3, categories: ['mobile'], type: "Framework", url: ""),
      Language(name: "Xamarin", desc: ".NET mobile development", icon: "🔷", difficulty: 3, categories: ['mobile'], type: "Framework", url: ""),
    ],
    'game': [
      Language(name: "C++", desc: "Game engines and performance", icon: "⚡", difficulty: 4, categories: ['game'], type: "Language", url: ""),
      Language(name: "C#", desc: "Unity game development", icon: "🔷", difficulty: 3, categories: ['game'], type: "Language", url: ""),
      Language(name: "Unity", desc: "Popular game engine", icon: "🎮", difficulty: 3, categories: ['game'], type: "Engine", url: ""),
      Language(name: "Unreal", desc: "AAA game engine", icon: "🎯", difficulty: 4, categories: ['game'], type: "Engine", url: ""),
      Language(name: "Godot", desc: "Open-source game engine", icon: "🎲", difficulty: 2, categories: ['game'], type: "Engine", url: ""),
      Language(name: "JavaScript", desc: "Browser games", icon: "🟨", difficulty: 2, categories: ['game', 'web'], type: "Language", url: ""),
      Language(name: "Python", desc: "Game scripting", icon: "🐍", difficulty: 2, categories: ['game', 'ai', 'data', 'web'], type: "Language", url: ""),
      Language(name: "Lua", desc: "Game scripting language", icon: "🌙", difficulty: 2, categories: ['game'], type: "Language", url: ""),
    ],
    'data': [
      Language(name: "Python", desc: "Data analysis and visualization", icon: "🐍", difficulty: 2, categories: ['data', 'ai', 'web', 'game'], type: "Language", url: ""),
      Language(name: "R", desc: "Statistical computing", icon: "📊", difficulty: 3, categories: ['data', 'ai'], type: "Language", url: ""),
      Language(name: "SQL", desc: "Database querying", icon: "🗃️", difficulty: 2, categories: ['data'], type: "Language", url: ""),
      Language(name: "Pandas", desc: "Data manipulation", icon: "🐼", difficulty: 2, categories: ['data', 'ai'], type: "Library", url: ""),
      Language(name: "NumPy", desc: "Numerical computing", icon: "🔢", difficulty: 3, categories: ['data', 'ai'], type: "Library", url: ""),
      Language(name: "Spark", desc: "Big data processing", icon: "⚡", difficulty: 4, categories: ['data'], type: "Framework", url: ""),
      Language(name: "Tableau", desc: "Data visualization", icon: "📈", difficulty: 2, categories: ['data'], type: "Tool", url: ""),
      Language(name: "PowerBI", desc: "Business analytics", icon: "📊", difficulty: 2, categories: ['data'], type: "Tool", url: ""),
    ],
    'cloud': [
      Language(name: "AWS", desc: "Amazon Web Services", icon: "☁️", difficulty: 3, categories: ['cloud'], type: "Platform", url: ""),
      Language(name: "Azure", desc: "Microsoft Cloud", icon: "🌩️", difficulty: 3, categories: ['cloud'], type: "Platform", url: ""),
      Language(name: "Google Cloud", desc: "GCP services", icon: "🌤️", difficulty: 3, categories: ['cloud'], type: "Platform", url: ""),
      Language(name: "Docker", desc: "Containerization", icon: "🐳", difficulty: 3, categories: ['cloud'], type: "Tool", url: ""),
      Language(name: "Kubernetes", desc: "Container orchestration", icon: "⚙️", difficulty: 4, categories: ['cloud'], type: "Tool", url: ""),
      Language(name: "Terraform", desc: "Infrastructure as code", icon: "🏗️", difficulty: 4, categories: ['cloud'], type: "Tool", url: ""),
      Language(name: "Go", desc: "Cloud-native language", icon: "🐹", difficulty: 3, categories: ['cloud'], type: "Language", url: ""),
      Language(name: "Serverless", desc: "Event-driven computing", icon: "⚡", difficulty: 3, categories: ['cloud'], type: "Framework", url: ""),
    ],
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    HapticFeedback.lightImpact();
  }

  void setActiveCategory(String category) {
    setState(() {
      activeCategory = category;
    });
    HapticFeedback.selectionClick();
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  void clearSearch() {
    _searchController.clear();
    updateSearchQuery('');
    HapticFeedback.lightImpact();
  }

  List<Language> getFilteredLanguages() {
    List<Language> languages = [];
    
    if (activeCategory == 'all') {
      allLanguages.values.forEach((categoryLangs) {
        languages.addAll(categoryLangs);
      });
    } else {
      languages = allLanguages[activeCategory] ?? [];
    }

    if (searchQuery.isNotEmpty) {
      languages = languages.where((lang) {
        return lang.name.toLowerCase().contains(searchQuery) ||
               lang.desc.toLowerCase().contains(searchQuery) ||
               lang.type.toLowerCase().contains(searchQuery) ||
               lang.categories.any((cat) => cat.toLowerCase().contains(searchQuery));
      }).toList();
    }

    return languages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildWelcomeSection(),
                    const SizedBox(height: 24),
                    _buildSearchBar(),
                    const SizedBox(height: 24),
                    _buildCategoryTabs(),
                    const SizedBox(height: 24),
                    _buildLanguagesGrid(),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "CodeXPlay",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: primaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: toggleTheme,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.1),
              ),
              child: Icon(
                isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: primaryColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return FadeTransition(
      opacity: _animationController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(_animationController),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [primaryColor, primaryLight],
              ).createShader(bounds),
              child: Text(
                "Start Your Coding Journey",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Choose a programming language or technology to begin learning with interactive exercises",
              style: TextStyle(
                color: grayColor,
                fontSize: 18,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: cardColor,
              border: Border.all(
                color: _searchController.text.isNotEmpty 
                    ? primaryColor 
                    : Colors.black.withOpacity(isDarkMode ? 0.1 : 0.1),
                width: 2,
              ),
              boxShadow: _searchController.text.isNotEmpty ? [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ] : [],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: updateSearchQuery,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: "Search languages, frameworks, or types...",
                hintStyle: TextStyle(color: grayColor),
                prefixIcon: Icon(Icons.search, color: grayColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ),
        if (searchQuery.isNotEmpty) ...[
          const SizedBox(width: 8),
          GestureDetector(
            onTap: clearSearch,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B6B),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                "Clear",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCategoryTabs() {
    final categories = [
      {'id': 'all', 'name': 'All'},
      {'id': 'popular', 'name': 'Popular'},
      {'id': 'web', 'name': 'Web Dev'},
      {'id': 'ai', 'name': 'AI/ML'},
      {'id': 'mobile', 'name': 'Mobile'},
      {'id': 'game', 'name': 'Game Dev'},
      {'id': 'data', 'name': 'Data'},
      {'id': 'cloud', 'name': 'Cloud'},
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isActive = activeCategory == category['id'];
          
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => setActiveCategory(category['id']!),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: isActive ? primaryColor : lightGrayColor,
                ),
                child: Text(
                  category['name']!,
                  style: TextStyle(
                    color: isActive ? Colors.white : grayColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLanguagesGrid() {
    final languages = getFilteredLanguages();
    
    if (languages.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: languages.length,
      itemBuilder: (context, index) {
        return _buildLanguageCard(languages[index], index);
      },
    );
  }

  Widget _buildLanguageCard(Language language, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100 + (index * 50)),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          // Handle navigation to language details
        },
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.black.withOpacity(isDarkMode ? 0.05 : 0.05),
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(isDarkMode ? 0.2 : 0.1),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      language.icon,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  language.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  language.desc,
                  style: TextStyle(
                    fontSize: 14,
                    color: grayColor,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                _buildDifficultyDots(language.difficulty),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    language.type,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                if (language.difficulty <= 2) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF28A745),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "Beginner Friendly",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyDots(int difficulty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < difficulty 
                ? primaryColor 
                : grayColor.withOpacity(0.3),
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          Icon(
            searchQuery.isNotEmpty ? Icons.search_off : Icons.folder_open,
            size: 64,
            color: grayColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            searchQuery.isNotEmpty 
                ? 'No languages found for "$searchQuery"'
                : "No languages available to display",
            style: TextStyle(
              color: grayColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final navItems = [
      {'icon': Icons.book_outlined, 'label': 'Learn', 'active': true},
      {'icon': Icons.laptop_mac, 'label': 'Practice', 'active': false},
      {'icon': Icons.emoji_events, 'label': 'Challenges', 'active': false},
      {'icon': Icons.person_outline, 'label': 'Profile', 'active': false},
    ];

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navItems.map((item) {
              final isActive = item['active'] as bool;
              return GestureDetector(
                onTap: () => HapticFeedback.selectionClick(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Icon(
                        item['icon'] as IconData,
                        color: isActive ? primaryColor : grayColor,
                        size: 24,
                      ),
                    ),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        color: isActive ? primaryColor : grayColor,
                        fontSize: 12,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    if (isActive)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 20,
                        height: 3,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: cardColor,
              title: Text(
                "Need Help?",
                style: TextStyle(color: textColor),
              ),
              content: Text(
                "Browse our tutorials or contact support!",
                style: TextStyle(color: grayColor),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(
          Icons.help_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}