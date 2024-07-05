import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class ChatScreenWidget extends StatefulWidget {
  const ChatScreenWidget({Key? key}) : super(key: key);

  @override
  State<ChatScreenWidget> createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends State<ChatScreenWidget> {
  final TextEditingController _messageController = TextEditingController();

  // Declare _messages as an instance variable
  List<Map<String, dynamic>> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: textBlack),
        ),
        title: Text('Chat with Us', style: h4TextStyle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSupport = message['isSupport'] as bool;
                final color = isSupport ? Color(0xFFd6d6d6) : primaryColor;
                final textColor = isSupport ? textBlack : Colors.white;
                final borderRadius = BorderRadius.circular(15);
                return Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 5.w),
                  child: Align(
                    alignment: isSupport
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 75.w),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: borderRadius,
                        ),
                        child: Text(
                          message['text'] as String,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            height: 8.h,
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Start typing your query...',
                hintStyle: body4TextStyle,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    final text = _messageController.text;
                    if (text.isNotEmpty) {
                      setState(() {
                        _messages.add({'text': text, 'isSupport': false});
                        _messageController.clear();
                        _messages.add({
                          'text':
                              'Hi Apeksha, I am your customer care representative, Vinod. How can I help you today?',
                          'isSupport': true
                        });
                      });
                    }
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor, width: 0.1.h),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor, width: 0.1.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
