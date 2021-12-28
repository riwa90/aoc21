import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Objects;

public class Main {

    public static long sol1(ArrayList<CodeSequence> sequences) {
        return sequences.stream()
                .map(sequence -> sequence.getOutput())
                .flatMap(Arrays::stream)
                .filter(nr -> nr.length() == 2 | nr.length() == 3 | nr.length() == 4 | nr.length() == 7)
                .count();
    }

    public static int sol2(ArrayList<CodeSequence> sequences) {
        int outputSum = 0;
        for(CodeSequence sequence : sequences) {
            sequence.decode();
            outputSum += sequence.getOutputNumber();
        }
        return outputSum;
    }

    public static void main(String[] args) throws IOException {
        String part = System.getenv("part");
        part = Objects.nonNull(part) ? part : "part2";
        var input = Files.newBufferedReader(Path.of("input.txt"));
        var sequences = new ArrayList<CodeSequence>();
        while(input.ready()) {
            sequences.add(new CodeSequence(input.readLine()));
        }
        if(part.equals("part1")) {
            System.out.println(sol1(sequences));
        } else {
            System.out.println(sol2(sequences));
        }
    }
}