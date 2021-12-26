public class Board {

    private int[][] board;
    private boolean[][] marks;

    public Board(int [][] board) {
        this.board = board;
        this.marks = new boolean[5][5];
    }

    public void debug() {
        for(int i = 0; i < 5; i++) {
            for(int j = 0; j < 5; j++) {
                System.out.print(this.board[i][j] + " ");
            }
            System.out.print("\n");
        }
        System.out.println("-------------------------");
    }

    public boolean checkAndMarkNumber(int number) {
        for(int i = 0; i < 5; i++) {
            for(int j = 0; j < 5; j++) {
                if(this.board[i][j] == number) {
                    this.marks[i][j] = true;
                    return checkForBingo(i, j);
                }
            }
        }
        return false;
    }

    private boolean checkForBingo(int i, int j) {
        return (this.marks[i][0] && this.marks[i][1] && this.marks[i][2] && this.marks[i][3] && this.marks[i][4]) ||
                (this.marks[0][j] && this.marks[1][j] && this.marks[2][j] && this.marks[3][j] && this.marks[4][j]);
    }

    public int sumOfUnmarkedNumbers() {
        int sum = 0;
        for(int i = 0; i < 5; i++) {
            for(int j = 0; j < 5; j++) {
                if(!this.marks[i][j]) {
                    sum += this.board[i][j];
                }
            }
        }
        return sum;
    }
}
