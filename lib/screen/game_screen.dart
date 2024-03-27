import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int _diverIndex;
  late List<bool> _visited;
  late List<String> _backgroundImages;

  @override
  void initState() {
    super.initState();
    _diverIndex = 0;
    _visited = List.filled(60, false);
    _visited[0] = true;
    _backgroundImages = List.generate(60, (index) => 'assets/bg1.png');
    _backgroundImages[_diverIndex] = 'assets/bg.png';
  }

  void _moveDiver(int dx, int dy) {
    int newIndex = _diverIndex + dx + dy * 6;
    if (_isValidIndex(newIndex)) {
      setState(() {
        _visited[_diverIndex] = false;
        _diverIndex = newIndex;
        _visited[_diverIndex] = true;
        if (_diverIndex > 0) {
          _backgroundImages[_diverIndex] = 'assets/bg2.png';
        }
      });
    }
  }

  bool _isValidIndex(int index) {
    return index >= 0 && index < 60 && !_visited[index];
  }

  Widget _buildArrowButton(String arrowButton, int dx, int dy) {
    int newIndex = _diverIndex + dx + dy * 6;

    if (!_isValidIndex(newIndex)) {
      return Container();
    }

    if (dy != 0 && !_isValidIndex(newIndex)) {
      return Container();
    }

    if (dx == -1 && _diverIndex % 6 == 0) {
      return Container();
    }

    if (dx == 1 && _diverIndex % 6 == 5) {
      return Container();
    }

    return GestureDetector(
      onTap: () {
        _moveDiver(dx, dy);
      },
      child: Image.asset(
        arrowButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff00C4C4),
                Color(0xff0066C5),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Image.asset('assets/coin.png'),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                    ),
                    itemCount: _backgroundImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(_backgroundImages[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (index == _diverIndex)
                            Image.asset(
                              'assets/diver.png',
                            ),
                          if (index == _diverIndex + 1)
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    _buildArrowButton('assets/right.png', 1, 0),
                              ),
                            ),
                          if (index == _diverIndex - 1)
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child:
                                    _buildArrowButton('assets/left.png', -1, 0),
                              ),
                            ),
                          if (index == _diverIndex + 6)
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child:
                                    _buildArrowButton('assets/down.png', 0, 1),
                              ),
                            ),
                          if (index == _diverIndex - 6)
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child:
                                    _buildArrowButton('assets/up.png', 0, -1),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '100',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 5),
                          Image.asset('assets/coins.png'),
                        ],
                      ),
                      const Text(
                        'Total balance',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffBDE9E9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
