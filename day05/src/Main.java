import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Objects;

public class Main {
    public static void main(String[] args) throws IOException {
        String part = System.getenv("part");
        part = Objects.nonNull(part) ? part : "part2";
        var input = Files.newBufferedReader(Path.of("input.txt"));
        Plane plane = new Plane();
        while(input.ready()) {
            String[] parsedInput = input.readLine().split("->");
            String[] point1 = parsedInput[0].split(",");
            String[] point2 = parsedInput[1].split(",");
            if(part.equals("part1")) {
                plane.markStraightLine(new Point(point1[0], point1[1].trim()), new Point(point2[0].trim(), point2[1]));
            } else {
                plane.markLine(new Point(point1[0], point1[1].trim()), new Point(point2[0].trim(), point2[1]));
            }

        }
        System.out.println(plane.coordinatesThatSeveralLinesCrossed());
    }
}