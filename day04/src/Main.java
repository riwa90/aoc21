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

    public static void main(String[] args) throws IOException {
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
        System.out.println(playBingo(numbers, boards));
    }
}
