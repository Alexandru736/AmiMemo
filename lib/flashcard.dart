class Flashcard {
  final String id;
  final String title;
  final String description;
  final String content;
  final DateTime date;
  final String correctWord;
  final String wrongWord1;
  final String wrongWord2;

  Flashcard(this.id, this.title, this.description, this.content, this.date,
      this.correctWord, this.wrongWord1, this.wrongWord2);

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
    return Flashcard(
      flashcardMap?['id'],
      flashcardMap?['title'],
      flashcardMap?['description'],
      flashcardMap?['content'],
      DateTime.parse(flashcardMap?['date']),
      flashcardMap?['correctWord'],
      flashcardMap?['wrongWord1'],
      flashcardMap?['wrongWord2'],
    );
  }
}

