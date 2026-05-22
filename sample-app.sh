#!/bin/bash

echo ">> Removing tempdir"
rm -rf tempdir

echo ""
echo ">> Building and running container"

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python:3.11-slim" > tempdir/Dockerfile

echo "RUN pip install --no-cache-dir --progress-bar off flask" >> tempdir/Dockerfile

echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  sample_app.py /home/myapp/" >> tempdir/Dockerfile

echo "EXPOSE 8050" >> tempdir/Dockerfile

echo "CMD [\"python\", \"/home/myapp/sample_app.py\"]" >> tempdir/Dockerfile

cd tempdir
docker build -t sampleapp .
docker run -t -d -p 8888:8888 --name samplerunning sampleapp
docker ps -a 
