public class StringListTest {
    public static List<String> generateStringList(Integer i) {
        List<String> myList = new List<String>();
        
        for (Integer j = 0; j < i; j++) {
            myList.add('Test ' + j);
        }
        return myList;
    }
}
