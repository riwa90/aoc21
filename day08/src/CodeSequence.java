import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

public class CodeSequence {
    private final String[] sequence;
    private final String[] output;
    private final HashMap<String[], String> numberMap;
    private int outputNumber;

    public CodeSequence(String sequenceAndOutput) {
        String[] tempString = sequenceAndOutput.split(" \\| ");
        this.sequence = tempString[0].split(" ");
        this.output = tempString[1].split(" ");
        numberMap = new HashMap<>();
    }

    public String[] getOutput() {
        return output;
    }

    public void decode() {
        decodeInput();
        decodeOutput();
    }

    private void decodeOutput() {
        StringBuilder stringNumber = new StringBuilder("");
        for(String outputNumber : output) {
            for(String[] numberCode : numberMap.keySet()) {
                if(letterMatches(outputNumber, numberCode)) {
                    stringNumber.append(numberMap.get(numberCode));
                    break;
                }
            }
        }
        outputNumber = Integer.parseInt(stringNumber.toString());
    }

    public int getOutputNumber() {
        return outputNumber;
    }

    private void decodeInput() {
        List<String> fiveLetterNumbers = Arrays.stream(sequence).filter(nr -> nr.length() == 5).collect(Collectors.toList());
        List<String> sixLetterNumbers = Arrays.stream(sequence).filter(nr -> nr.length() == 6).collect(Collectors.toList());
        String[] one = (Arrays.stream(sequence)
                .filter(nr -> nr.length() == 2)
                .findFirst().get())
                .split("");
        numberMap.put(one, "1");
        String[] four = (Arrays.stream(sequence)
                .filter(nr -> nr.length() == 4)
                .findFirst().get())
                .split("");
        numberMap.put(four, "4");
        String[] seven = (Arrays.stream(sequence)
                .filter(nr -> nr.length() == 3)
                .findFirst().get())
                .split("");
        numberMap.put(seven, "7");
        String[] eight = (Arrays.stream(sequence)
                .filter(nr -> nr.length() == 7)
                .findFirst().get())
                .split("");
        numberMap.put(eight, "8");
        String[] three = fiveLetterNumbers.stream()
                .filter(nr -> nrOfLettersMatching(nr, one) == 2)
                .findFirst().get()
                .split("");
        numberMap.put(three, "3");
        String[] nine = sixLetterNumbers.stream()
                .filter(nr -> nrOfLettersMatching(nr, three) == 5)
                .findFirst().get()
                .split("");
        numberMap.put(nine, "9");
        String[] two = fiveLetterNumbers.stream()
                .filter(nr -> nrOfLettersMatching(nr, nine) == 4)
                .findFirst().get()
                .split("");
        numberMap.put(two, "2");
        String[] five = fiveLetterNumbers.stream()
                .filter(nr -> nrOfLettersMatching(nr, two) == 3)
                .findFirst().get()
                .split("");
        numberMap.put(five, "5");
        String[] six = sixLetterNumbers.stream()
                .filter(nr -> nrOfLettersMatching(nr, five) == 5)
                .filter(nr -> nrOfLettersMatching(nr, nine) != 6)
                .findFirst().get()
                .split("");
        numberMap.put(six, "6");
        String[] zero = sixLetterNumbers.stream()
                .filter(nr -> nrOfLettersMatching(nr, four) == 3)
                .filter(nr -> nrOfLettersMatching(nr, one) == 2)
                .findFirst().get()
                .split("");
        numberMap.put(zero, "0");
    }

    private int nrOfLettersMatching(String sequence, String[] letters) {
        int count = 0;
        for(String letter : letters) {
            if(sequence.contains(letter)) {
                count++;
            }
        }
        return count;
    }

    private boolean letterMatches(String sequence, String[] letters) {
        return sequence.length() == letters.length && nrOfLettersMatching(sequence, letters) == letters.length;
    }
}
