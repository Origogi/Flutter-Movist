class HeroID {
    static String make(int id , String postFix) {
      return 'hero_${id}_$postFix';
    }
}