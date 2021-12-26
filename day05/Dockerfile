FROM openjdk:17
COPY . /solution
WORKDIR /solution
RUN javac ./src/Plane.java ./src/Point.java ./src/Main.java
RUN cp ./src/Main.class Main.class
RUN cp ./src/Plane.class Plane.class
RUN cp ./src/Point.class Point.class
CMD ["java", "Main"]