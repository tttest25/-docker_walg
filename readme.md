# docker for build mysql go walg

docker build -t wal-g-build .
docker run -it --rm --name wal-g-build   -v /opt/docker/docker_walg/bin:/tmp/bin     wal-g-build  bash
docker cp wal-g-build:/build/wal-g/main/mysql/wal-g .