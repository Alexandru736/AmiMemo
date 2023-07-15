class Flashcard {
  final String id;
  final String title;
  final String description;
  final String content;
  final DateTime date;
  final String correctWord;
  final String wrongWord1;
  final String wrongWord2;

  Flashcard({required this.id, required this.title, required this.description, required this.content, required this.date,
      required this.correctWord, required this.wrongWord1, required this.wrongWord2});

  Map<String, String> toMap() {
    Map<String, String> flashcardMap = {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'date': date.toString(),
      'correctWord': correctWord,
      'wrongWord1': wrongWord1,
      'wrongWord2': wrongWord2,
    };

    return flashcardMap;
  }

  static Flashcard fromMap(Map<String, dynamic>? flashcardMap) {
    return Flashcard(id: flashcardMap?['id'],
      title: flashcardMap?['title'],
      description: flashcardMap?['description'],
      content: flashcardMap?['content'],
      date: DateTime.parse(flashcardMap?['date']),
      correctWord: flashcardMap?['correctWord'],
      wrongWord1: flashcardMap?['wrongWord1'],
      wrongWord2: flashcardMap?['wrongWord2'],
    );
  }
}
