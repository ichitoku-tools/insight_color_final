import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// 診断で使用する色の情報を管理するクラス
class ColorInfo {
  final String name;
  final Color color;
  final String meaning;
  final String advice;

  const ColorInfo({
    required this.name,
    required this.color,
    required this.meaning,
    required this.advice,
  });
}

// 診断データのリスト
final List<ColorInfo> colorDataList = [
  const ColorInfo(
    name: '優しさの色',
    color: Color(0xFFFADADD), // ソフトピンク
    meaning: '優しさ・思いやり',
    advice: '周りの人だけでなく、自分自身のことも甘やかしてあげましょう。',
  ),
  const ColorInfo(
    name: '情熱の色',
    color: Color(0xFFF2A0A1), // コーラルレッド
    meaning: '情熱・エネルギー',
    advice: 'パワーに満ちている時。時には深呼吸して、クールダウンも忘れずに。',
  ),
  const ColorInfo(
    name: '希望の色',
    color: Color(0xFFFFF3A7), // パステルイエロー
    meaning: '好奇心・希望',
    advice: '新しいアイデアが生まれそう。小さな冒険に出かけてみては？',
  ),
  const ColorInfo(
    name: '癒しの色',
    color: Color(0xFFC1E1C1), // ミントグリーン
    meaning: '安定・癒し',
    advice: '心と体のバランスが取れている証拠。自分のペースを大切に。',
  ),
  const ColorInfo(
    name: '冷静の色',
    color: Color(0xFFB2D8D8), // ライトブルー
    meaning: '冷静・誠実',
    advice: '落ち着いて物事を考えられる時。誰かに連絡してみると良い発見があるかも。',
  ),
  const ColorInfo(
    name: '直感の色',
    color: Color(0xFFD8BFD8), // ラベンダー
    meaning: '直感・インスピレーション',
    advice: '感受性が豊かになっています。一人の静かな時間を持つのもおすすめです。',
  ),
  const ColorInfo(
    name: '転機の色',
    color: Color(0xFFFFFFFF), // ホワイト
    meaning: '転機・リセット',
    advice: '新しい始まりの予感。まっさらな気持ちでチャレンジしてみて。',
  ),
  const ColorInfo(
    name: '内省の色',
    color: Color(0xFF696969), // ダークグレー
    meaning: '内省・集中',
    advice: '自分自身と向き合う時間。今日は無理せず、心と体を休ませてあげて。',
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'インサイトカラー診断',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.zenMaruGothicTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ホーム画面
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedButton(int index, double size) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.1 * index,
          0.6 + 0.1 * index,
          curve: Curves.elasticOut,
        ),
      ),
    );
    return ScaleTransition(
      scale: animation,
      child: SizedBox(
        width: size,
        height: size,
        child: ColorButton(colorInfo: colorDataList[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F6),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Insight Color',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tangerine(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '今、どの色に惹かれますか？',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '直感で惹かれる色を選ぶだけで、今のあなたの心の状態がわかります。\nさあ、深呼吸して、気になる色をタップしてみてください。',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54.withOpacity(0.7),
                        height: 1.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double spacing = 20.0;
                      final double buttonSize = (constraints.maxWidth - (spacing * 3)) / 4;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(4, (index) {
                              return _buildAnimatedButton(index, buttonSize);
                            }),
                          ),
                          SizedBox(height: spacing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(4, (index) {
                              return _buildAnimatedButton(index + 4, buttonSize);
                            }),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// カラーボタン
class ColorButton extends StatefulWidget {
  final ColorInfo colorInfo;
  const ColorButton({super.key, required this.colorInfo});

  @override
  State<ColorButton> createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double scale = _isHovered ? 1.15 : 1.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ResultScreen(colorInfo: widget.colorInfo),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 600),
            ),
          );
        },
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Container(
            decoration: BoxDecoration(
              color: widget.colorInfo.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.colorInfo.color == Colors.white
                    ? Colors.grey.shade300
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isHovered ? 0.25 : 0.1),
                  spreadRadius: _isHovered ? 6 : 2,
                  blurRadius: _isHovered ? 18 : 8,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 結果画面
class ResultScreen extends StatelessWidget {
  final ColorInfo colorInfo;
  const ResultScreen({super.key, required this.colorInfo});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color.lerp(colorInfo.color, Colors.white, 0.85);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // 診断結果カード
                DiagnosisCard(colorInfo: colorInfo),
                const Spacer(),
                // シェアを促すメッセージ
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'このカードをスクリーンショットして、\nSNSでシェアしてね！',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ),
                // 「もう一度診断する」ボタン
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black54,
                      side: const BorderSide(color: Colors.black54),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('もう一度診断する'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 診断結果カードウィジェット
class DiagnosisCard extends StatelessWidget {
  final ColorInfo colorInfo;

  const DiagnosisCard({super.key, required this.colorInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Today\'s Insight Color',
            style: GoogleFonts.tangerine(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: colorInfo.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: colorInfo.color == Colors.white
                    ? Colors.grey.shade300
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            colorInfo.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '「${colorInfo.meaning}」',
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            colorInfo.advice,
            style: const TextStyle(fontSize: 15, height: 1.7, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            '#インサイトカラー診断',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
