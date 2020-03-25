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