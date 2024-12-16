# Running the Benchmark

1. Build docker image with the following command

```
docker build -t wayang .
```

2. Run a container with the built image

```
docker run -it wayang
```

3. Run the `bench` command with make

```
make bench
```

