FROM openjdk:17
COPY . /solution
WORKDIR /solution
RUN javac ./src/CodeSequence.java ./src/Main.java
RUN cp ./src/Main.class Main.class
RUN cp ./src/CodeSequence.class CodeSequence.class
CMD ["java", "Main"]