import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const SmartMirrorDemoApp());
}

class SmartMirrorDemoApp extends StatelessWidget {
  const SmartMirrorDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Mirror Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF05070A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4DD6FF),
          brightness: Brightness.dark,
        ),
      ),
      home: const MirrorDashboardPage(),
    );
  }
}

class MirrorDashboardPage extends StatefulWidget {
  const MirrorDashboardPage({super.key});

  @override
  State<MirrorDashboardPage> createState() => _MirrorDashboardPageState();
}

class _MirrorDashboardPageState extends State<MirrorDashboardPage> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');

  String get _timeText =>
      '${_twoDigits(_now.hour)}:${_twoDigits(_now.minute)}';

  String get _secondsText => _twoDigits(_now.second);

  String get _dateText {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${weekdays[_now.weekday - 1]}, ${months[_now.month - 1]} ${_now.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;
            final padding = wide ? 36.0 : 20.0;

            return Padding(
              padding: EdgeInsets.all(padding),
              child: wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _buildPrimaryColumn(context),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 4,
                          child: _buildSecondaryColumn(context),
                        ),
                      ],
                    )
                  : ListView(
                      children: [
                        _buildPrimaryColumn(context),
                        const SizedBox(height: 20),
                        _buildSecondaryColumn(context),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPrimaryColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _timeText,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 88,
                    height: 0.9,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -3,
                  ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _secondsText,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white54,
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _dateText,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: 32),
        const _GlassCard(
          child: Row(
            children: [
              Icon(Icons.wb_sunny_outlined, size: 54),
              SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '18°',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Clear skies · Demo weather data',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Text(
                '24° / 12°',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(
                icon: Icons.calendar_month_outlined,
                title: 'Today',
              ),
              SizedBox(height: 16),
              _AgendaRow(time: '08:30', title: 'Morning routine'),
              _AgendaRow(time: '13:00', title: 'Lunch'),
              _AgendaRow(time: '18:30', title: 'Personal time'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryColumn(BuildContext context) {
    return Column(
      children: [
        const _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(
                icon: Icons.auto_awesome_outlined,
                title: 'Good afternoon',
              ),
              SizedBox(height: 16),
              Text(
                'Everything you need at a glance, without clutter.',
                style: TextStyle(
                  fontSize: 20,
                  height: 1.35,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(
                icon: Icons.monitor_heart_outlined,
                title: 'System',
              ),
              SizedBox(height: 16),
              _StatusRow(label: 'Display', value: 'Ready'),
              _StatusRow(label: 'Network', value: 'Connected'),
              _StatusRow(label: 'Sync', value: 'Local demo'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(
                icon: Icons.eco_outlined,
                title: 'Lightweight by design',
              ),
              SizedBox(height: 14),
              Text(
                'No external packages are required for the dashboard UI. '
                'The demo prioritizes low CPU, RAM, storage, and network usage.',
                style: TextStyle(
                  height: 1.45,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: const Color(0xFF66D9FF)),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _AgendaRow extends StatelessWidget {
  const _AgendaRow({
    required this.time,
    required this.title,
  });

  final String time;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 66,
            child: Text(
              time,
              style: const TextStyle(
                color: Color(0xFF66D9FF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white78,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white60),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1D6B51),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
