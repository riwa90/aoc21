public record Point(int x, int y) {
    public Point(String x, String y) {
        this(Integer.parseInt(x), Integer.parseInt(y));
    }
}
