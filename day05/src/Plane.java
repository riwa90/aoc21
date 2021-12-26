import java.util.Arrays;

public class Plane {
    private int[][] coordinateMagnitude;

    public Plane() {
        this.coordinateMagnitude = new int[1000][1000];
    }

    public void markStraightLine(Point p1, Point p2) {
        if(p1.x() == p2.x()) {
            int x = p1.x();
            int max = p1.y() > p2.y() ? p1.y() : p2.y();
            int min = p1.y() < p2.y() ? p1.y() : p2.y();
            for(int i = min; i <= max; i++) {
                this.coordinateMagnitude[x][i]++;
            }
        } else if(p1.y() == p2.y()){
            int y = p1.y();
            int max = p1.x() > p2.x() ? p1.x() : p2.x();
            int min = p1.x() < p2.x() ? p1.x() : p2.x();
            for(int i = min; i <= max; i++) {
                this.coordinateMagnitude[i][y]++;
            }
        }
    }

    public void markLine(Point p1, Point p2) {
        if(p1.x() == p2.x() || p1.y() == p2.y()) {
            markStraightLine(p1, p2);
            return;
        }

        if(p1.x() > p2.x()) {
            if(p1.y() > p2.y()) {
                markDiagonalNEtoSW(p1, p2);
            } else {
                markDiagonalSEtoNW(p1, p2);
            }
        } else {
            if(p1.y() > p2.y()) {
                markDiagonalNWtoSE(p1, p2);
            } else {
                markDiagonalSWtoNE(p1, p2);
            }
        }
    }

    private void markDiagonalSWtoNE(Point p1, Point p2) {
        int j = p1.y();
        for(int i = p1.x(); i <= p2.x(); i++) {
            this.coordinateMagnitude[i][j++]++;
        }
    }

    private void markDiagonalSEtoNW(Point p1, Point p2) {
        int j = p1.y();
        for(int i = p1.x(); i >= p2.x(); i--) {
            this.coordinateMagnitude[i][j++]++;
        }
    }

    private void markDiagonalNEtoSW(Point p1, Point p2) {
        int j = p1.y();
        for(int i = p1.x(); i >= p2.x(); i--) {
            this.coordinateMagnitude[i][j--]++;
        }
    }

    private void markDiagonalNWtoSE(Point p1, Point p2) {
        int j = p1.y();
        for(int i = p1.x(); i <= p2.x(); i++) {
            this.coordinateMagnitude[i][j--]++;
        }
    }

    public long coordinatesThatSeveralLinesCrossed() {
        return Arrays.stream(coordinateMagnitude)
                .flatMapToInt(Arrays::stream)
                .filter(nr -> nr > 1)
                .count();
    }
}
