# Eclipse with installed palladiosimulator

## Description
Project contains a Dockerfile to execute the pythomat locally with an adapted solution.

## Usage
Copy the pythomat for the exercise and unzip the solution in the folder of this project. Adapt the solution and execute the run_tests script. After the tests are finished and if you have firefox installed, solution.html should be displayed in a new private window.

## Docker hub
The image can be found at [docker hub](https://hub.docker.com/repository/docker/thomasweber/pythomatdocker). Auto-Build is currently enabled.

## Dockerfile
- add python, pip, bash, openjdk8 and simplejson
- add the execution script and use it as entrypoint

``` bash
FROM alpine
# add python2.7 pip for simplejson and bash for the script
RUN apk add python2 py-pip bash
# add java jdk 8 as stated [here](https://stackoverflow.com/questions/54286175/alpine-linux-javac-not-found)
RUN apk update
RUN apk fetch openjdk8
RUN apk add openjdk8
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"
# update pip cause the delivered version is old
RUN pip install --upgrade pip
RUN pip install simplejson
COPY run_test.sh /prod/run_test.sh
RUN chmod a+rx /prod/run_test.sh
ENTRYPOINT [ "/prod/run_test.sh" ]
```

## Scripts

### run_test.sh
- executing the pythomat with python2.7
- script executed inside the docker container

``` bash
#!/bin/bash
cd /prod/
python2.7 pythomat.zip -o solution.html solution
```

### run_tests.cmd
- sets the path to the current directory
- searches the "solution" folder
- mounts the pythomat and the solution folder into the container
- displays the results in a new firefox window

``` bash
SET SRC_PATH=%cd%
SET IMAGE_NAME=thomasweber/pythomatdocker:latest
SET CONTAINER_PATH=/usr
FOR /F "tokens=*" %%g IN ('dir Solution /ad /s /b') do (SET SOLUTION_PATH=%%g)
docker run -it -v "%SRC_PATH%\pythomat.zip":/prod/pythomat.zip -v "%SOLUTION_PATH%":/prod/solution/ -w /prod/ --cap-drop ALL %IMAGE_NAME%
start firefox -private-window "file:///%SOLUTION_PATH%/solution.html"
```

## Authors
[Thomas Weber](https://github.com/TomWerm)

## License
[GPL-3.0](https://opensource.org/licenses/GPL-3.0)

## Project status
Feature requests are welcome.
