class AppText {
  /// App level messages
  static const successMessage = 'Successfully uploaded';
  static const updateMessage = 'Successfully updated';
  static const deleteMessage = 'Successfully deleted';
  static const List<String> ecommerceLabels = [
    'Fitness',
    'Sports',
    'Accessories',
    'Clothing',
    'All'
  ];
  static const List<String> optionsOfExercise = [
    'Balance',
    'Cardio',
    'Running',
    'Stretching',
    'HIT',
    'Fitness',
    'None'
  ];
  static const List<String> dietOptions = [
    'Vegetarian',
    'Vegan',
    'Keto',
    'Mediterranean',
    'No',
  ];

  /// Firebase References
  static const mainCollectionRef = 'admin';
  static const ecommerceCollectionRef = 'ecommerce';
  static const nutritionCollectionRef = 'nutrition';
  static const subscriptionCollectionRef = 'subscription';
  static const workoutCollectionRef = 'workout';
  static const virtualTrainingCollectionRef = 'virtual_training';
  static const products = 'products';
  static const plansEnrollment = 'plans_enrollment';

  /// live stream const ........................
  static const liveStreamAppID = '2175b97bd3504301b86b3311e38414b7';
  static const liveStreamAdminID = 999999;
}
