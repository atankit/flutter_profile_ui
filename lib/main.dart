import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isFollowing = false;


  // Sample list of posts
  final List<Map<String, String>> posts = [
    {
      'title': 'First Post',
      'description': 'This is the description for the first post.',
      'image': 'assets/images/profileimg1.png',

    },
    {
      'title': 'Second Post',
      'description': 'Here’s a summary for the second post.',
      'image': 'assets/images/profileimg2.png',
    },
    {
      'title': 'Third Post',
      'description': 'Another post with interesting content.',
      'image': 'assets/images/profileimg3.png',
    },
  ];
  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter UI"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Consistent padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Section------------------------------------------
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile_pic.png'),
                backgroundColor: Colors.transparent,
              ),
              Container(
                  height: 10
              ),
              Text(
                'Username',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold, fontFamily: 'UiFont'
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'This is a sample bio description.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'UiFont',
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: toggleFollow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFollowing ? Colors.grey : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  isFollowing ? 'Following' : 'Follow',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMetric('Posts', '55'),
                  _buildDivider(),
                  _buildMetric('Followers', '202'),
                  _buildDivider(),
                  _buildMetric('Following', '112'),
                ],
              ),
              const SizedBox(height: 20),

              // Posts List Section
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return _buildPostCard(post);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'UiFont'
          ),
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: 'UiFont'
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      child: VerticalDivider(
        color: Colors.grey,
        thickness: 1,
        width: 32,
      ),
    );
  }
  Widget _buildPostCard(Map<String, String> post) {
    bool isLiked = false;

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return GestureDetector(
          onTapDown: (_) => setState(() => isLiked = !isLiked),
          child: AnimatedScale(
            scale: isLiked ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Image
                  Image.asset(
                    post['image']!,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Post Title
                        Text(
                          post['title']!,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'UiFont'
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Post Description
                        Text(
                          post['description']!,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'UiFont',
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action Row
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TweenAnimationBuilder(
                        tween: ColorTween(
                          begin: Colors.grey,
                          end: isLiked ? Colors.blue : Colors.grey,
                        ),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, color, child) => IconButton(
                          icon: Icon(Icons.thumb_up_alt),
                          color: color,
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.comment_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.share_outlined),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
