import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

public class Main {

    public static int playBingo(int[] numbers, ArrayList<Board> boards) {
        for(int number : numbers) {
            for(Board board : boards) {
                if(board.checkAndMarkNumber(number)) {
                    return number * board.sumOfUnmarkedNumbers();
                }
            }
        }
        return 0;
    }

    public static int loseBingo(int[] numbers, ArrayList<Board> boards) {
        for(int number : numbers) {
            var boardsToRemove = new HashSet<Board>();
            for(Board board : boards) {
                if(board.checkAndMarkNumber(number)) {
                    boardsToRemove.add(board);
                    if(boards.size() == 1) {
                        return number * boards.get(0).sumOfUnmarkedNumbers();
                    }
                }
            }
            boards.removeAll(boardsToRemove);
        }
        return 0;
    }

    public static void main(String[] args) throws IOException {
        String part = System.getenv("part");
        part = Objects.nonNull(part) ? part : "part1";
        var input = Files.newBufferedReader(Path.of("input.txt"));
        var numbers =  Arrays.stream(input.readLine()
                        .split(","))
                        .mapToInt(Integer::parseInt)
                        .toArray();
        var boards = new ArrayList<Board>();
        while(input.skip(1) != 0) {
            var board = new int[5][];
            for(int i = 0; i < 5; i++) {
                int[] row = Arrays.stream(input.readLine().split(" "))
                        .filter(number -> !number.isEmpty())
                        .mapToInt(Integer::parseInt)
                        .toArray();
                board[i] = row;
            }
            boards.add(new Board(board));
        }
        if(part.equals("part1")) {
            System.out.println(playBingo(numbers, boards));
        } else {
            System.out.println(loseBingo(numbers, boards));
        }
    }
}
