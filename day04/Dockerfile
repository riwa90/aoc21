FROM openjdk:17
COPY . /solution
WORKDIR /solution
RUN javac ./src/Board.java ./src/Main.java
RUN cp ./src/Main.class Main.class
RUN cp ./src/Board.class Board.class
CMD ["java", "Main"]