enum ChatMode {
  friends('Friends', 'Chat with a friendly companion', 'assets/images/friends.jpg'),
  family('your family', 'Family-oriented conversation', 'assets/images/family.jpg'),
  lonely('lonely', 'Someone to talk to when you need it', 'assets/images/lonely.jpg'),
  justAsking('just asking', 'Quick questions and answers', 'assets/images/just.jpg');

  final String tittle;
  final String description;
  final String imagePath;

  const ChatMode(this.tittle, this.description, this.imagePath);

}
