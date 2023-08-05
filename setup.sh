#!/bin/sh
docker build -t my-mysql .
docker run --name caseone -p 3306:3306 -d my-mysql
