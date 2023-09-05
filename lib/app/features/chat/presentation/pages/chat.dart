part of 'package:homemakers_merchant/app/features/chat/index.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
  });

  final Room room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    const XTypeGroup jpgsTypeGroup = XTypeGroup(
      label: 'PDFs',
      extensions: <String>['pdf', 'doc', 'docx', 'xlsx', 'ppt', 'txt', 'xls', 'pptx'],
    );
    const XTypeGroup pngTypeGroup = XTypeGroup(
      label: 'PNGs',
      extensions: <String>['png', 'jpg', 'jpeg'],
    );
    final XFile? xFile = await openFile(acceptedTypeGroups: <XTypeGroup>[
      jpgsTypeGroup,
      pngTypeGroup,
    ]);
    // #enddocregion MultiOpen
    if (xFile.isNull) {
      // Operation was canceled by the user.
      return;
    } else {
      if (xFile.isNotNull && !xFile!.path.isEmptyOrNull) {
        print('File Path ${xFile.path}');
        _setAttachmentUploading(true);
        var fileNameWithoutExtension = path.basenameWithoutExtension(xFile.path);
        final name = fileNameWithoutExtension;
        print('File name ${name}');
        final filePath = xFile.path;
        final file = File(filePath);
        print('File Byte ${await xFile.length()}, ${await file.length()}, ${file.absolute.existsSync()}');
        try {
          final reference = FirebaseStorage.instance.ref(name);
          await reference.putFile(file);
          final uri = await reference.getDownloadURL();
          final bytes = await xFile.readAsBytes();
          final message = PartialFile(
            mimeType: lookupMimeType(filePath),
            name: name,
            size: bytes.lengthInBytes,
            uri: uri,
          );

          FirebaseChatCore.instance.sendMessage(message, widget.room.id);
          _setAttachmentUploading(false);
        } finally {
          _setAttachmentUploading(false);
        }
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  Future<void> _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: const Text('Chat'),
        ),
        body: StreamBuilder<Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) => Chat(
              isAttachmentUploading: _isAttachmentUploading,
              messages: snapshot.data ?? [],
              onAttachmentPressed: _handleAttachmentPressed,
              onMessageTap: _handleMessageTap,
              onPreviewDataFetched: _handlePreviewDataFetched,
              onSendPressed: _handleSendPressed,
              user: ChatUser(
                id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
              ),
            ),
          ),
        ),
      );
}
