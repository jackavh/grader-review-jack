CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

cleanup() {
    rm -rf student-submission
    rm -rf grading-area
}

cleanup
mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'
submission_dir="$(pwd)/student-submission/ListExamples.java"
score=""

if ! [ -f "${submission_dir}" ]; then
    echo "ListExamples.java not found!" 2>> submission-errors.txt
    score="-1"
    echo "score ${score}"
    cleanup
    exit 1
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# File structure after first run of `grade.sh`
# list-examples-grader/
# ├── GradeServer.java
# ├── Server.java
# ├── TestListExamples.java
# ├── grade.sh
# ├── grading-area/
# ├── lib/
# │   ├── hamcrest-core-1.3.jar
# │   └── junit-4.13.2.jar
# └── student-submission/
#     └── ListExamples.java

# Then, add here code to compile and run, and do any post-processing of the
# tests

echo 'Running tests'
# Set up grading area
cp ./TestListExamples.java ./grading-area
cp "${submission_dir}" ./grading-area
cp -R ./lib ./grading-area
cd ./grading-area

# Compile and run tests
javac -cp "${CPATH}" TestListExamples.java ListExamples.java 2>> submission-errors.txt

if [ $? -ne 0 ]; then
    echo "ListExamples.java failed to compile."
    cat submission-errors.txt
    score="${score}-1"
    echo "score ${score}"
    cleanup
    exit 1
fi

java -cp "${CPATH}" org.junit.runner.JUnitCore TestListExamples > submission-tests.txt
cleanup
