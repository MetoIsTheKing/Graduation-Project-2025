class ContentModel {
  final String image;
  final String title;
  final String subTitle;
  const ContentModel(this.image, this.title, this.subTitle);
}

final List<ContentModel> onboardingContent = [
  ContentModel(
    'assets/images/first-onboarding.png',
    'Book a flight',
    'Found a flight that matches your destination and schedule? Book it instantly.',
  ),
  ContentModel(
    'assets/images/second-onboarding.png',
    'Find a hotel room',
    'Book a hotel room that suits your budget and needs. You can also book a room with free cancellation.',
  ),
  ContentModel(
    'assets/images/third-onboarding.png',
    'Enjoy your trip',
    'Enjoy your trip and have a great time. You can also share your experience with other travelers.',
  ),
];
