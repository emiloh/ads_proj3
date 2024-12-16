# Running the Benchmark

1. Gather the data (specified in the paper)

The files should be placed in a folder called `data` in this repository. The yelp file should be called `train_yelp.<csv/parquet>` and the TPC-H part files should be called `tpch_part_<sf>.<csv/parquet>` for the scaling factors `1, 10 and 100`

2. Build docker image with the following command

```
docker build -t wayang .
```

3. Run a container with the built image

```
docker run -it wayang
```

4. Run the `bench` command with make

```
make bench
```

