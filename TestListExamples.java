import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
    @Test(timeout = 500)
    public void testFilterEmptyList() {
        List<String> empty = Arrays.asList();
        List<String> filtered = ListExamples.filter(emptyList, new IsMoon());
        assertTrue(filtered.isEmpty());
    }

    @Test(timeout = 500)
    public void testAllMatch() {
        List<String> list = Arrays.asList("moon", "moon");
        List<String> filtered = ListExamples.filter(list, new IsMoon());
        assertEquals(Arrays.asList("moon", "moon"), filtered);
    }

    @Test(timeout = 500)
    public void testNoneMatch() {
        List<String> list = Arrays.asList("sun", "earth");
        List<String> filtered = ListExamples.filter(list, new IsMoon());
        assertTrue(filtered.isEmpty());
    }

    @Test(timeout = 500)
    public void testMergeRightEnd() {
        List<String> left = Arrays.asList("a", "b", "c");
        List<String> right = Arrays.asList("a", "d");
        List<String> merged = ListExamples.merge(left, right);
        List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
        assertEquals(expected, merged);
    }
}
