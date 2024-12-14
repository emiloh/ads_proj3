.ONESHELL:

update-repo:
        # Ensure latest changes
        git submodule update --recursive
compile:
        # Install package
        cd ./incubator-wayang
        mvn clean install -DskipTests
        mvn clean package -pl :wayang-assembly -Pdistribution

        # Extract binary
        cd wayang-assembly/target/
        tar -xvf apache-wayang-assembly-0.7.1-incubating-dist.tar.gz

run:
        cd ./incubator-wayang/wayang-assembly/target/wayang-0.7.1/bin
        ./wayang-submit org.apache.wayang.$(class) java $(file)
