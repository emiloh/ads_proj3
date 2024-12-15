.ONESHELL:

DATA_FOLDER="file:///usr/proj/data/"
BENCH_FOLDER="/usr/proj/benchmark/"

update-repo:
        # Ensure latest changes
        git submodule update --recursive
compile:
        # Install package
        cd ./incubator-wayang
        mvn clean install -DskipTests -Drat.skip=true
        mvn clean package -pl :wayang-assembly -Pdistribution

        # Extract binary
        cd wayang-assembly/target/
        tar -xvf apache-wayang-assembly-0.7.1-incubating-dist.tar.gz

run:
        cd ./incubator-wayang/wayang-assembly/target/wayang-0.7.1/bin
        OTHER_FLAGS="-Xmx12g" ./wayang-submit org.apache.wayang.$(class) java $(folder) $(out)

bench:
        update-repo
        cd ./incubator-wayang
        git pull
        git switch feature/operator-parquet-source
        cd ..
        compile
        cd ./incubator-wayang/wayang-assembly/target/wayang-0.7.1/bin
        OTHER_FLAGS="-Xmx12g" ./wayang-submit org.apache.wayang.apps.parquet_csv.TpchPartBench java $DATA_FOLDER "${BENCH_FOLDER}/tpch.txt"
        ./wayang-submit org.apache.wayang.apps.parquet_csv.YelpBench java $DATA_FOLDER "${BENCH_FOLDER}/yelp.txt"
