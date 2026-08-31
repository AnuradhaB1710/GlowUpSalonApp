import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/icon_mapper.dart';
import '../../../services/domain/entities/service_entity.dart';
import '../../../services/domain/entities/stylist_entity.dart';
import '../../domain/entities/booking_entity.dart';
import '../providers/booking_provider.dart';

class BookingPage extends StatefulWidget {
  final ServiceEntity service;
  final List<StylistEntity> stylists;

  const BookingPage({super.key, required this.service, required this.stylists});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _uuid = const Uuid();

  StylistEntity? _stylist;
  DateTime? _date;
  TimeOfDay? _time;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _confirm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_stylist == null || _date == null || _time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose stylist, date and time')),
      );
      return;
    }

    final dateTime = DateTime(_date!.year, _date!.month, _date!.day, _time!.hour, _time!.minute);
    final booking = BookingEntity(
      id: _uuid.v4(),
      service: widget.service,
      stylist: _stylist!,
      dateTime: dateTime,
      customerName: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
    );

    final provider = context.read<BookingProvider>();
    final success = await provider.submitBooking(booking);

    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.submitError ?? 'Something went wrong')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.primary),
            SizedBox(width: 8),
            Text('Booking confirmed'),
          ],
        ),
        content: Text(
          '${widget.service.name} with ${_stylist!.name}\n'
          '${DateFormat('EEE, MMM d • h:mm a').format(dateTime)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // back to home
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;
    final isSubmitting = context.watch<BookingProvider>().isSubmitting;

    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.12),
                    child: Icon(iconForKey(service.iconKey), color: AppColors.primary),
                  ),
                  title: Text(service.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${service.durationMin} min • \$${service.price.toStringAsFixed(0)}'),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Select stylist', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.stylists.map((s) {
                  final selected = _stylist?.id == s.id;
                  return ChoiceChip(
                    label: Text('${s.name}\n${s.specialty}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                    selected: selected,
                    onSelected: (_) => setState(() => _stylist = s),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: selected ? AppColors.primary : Colors.grey.shade300),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text('Date & time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today, size: 18),
                      label: Text(_date == null ? 'Choose date' : DateFormat('MMM d, yyyy').format(_date!)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickTime,
                      icon: const Icon(Icons.access_time, size: 18),
                      label: Text(_time == null ? 'Choose time' : _time!.format(context)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Your details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameCtrl,
                decoration: _inputDecoration('Full name'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration('Phone number'),
                validator: (v) => (v == null || v.trim().length < 6) ? 'Enter a valid phone number' : null,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : _confirm,
                  child: isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Confirm Booking', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      );
}
