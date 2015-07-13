#!/bin/bash

service docker stop
rm -f /etc/docker/key.json
service docker start

service consul stop
rm -rf /var/cache/octohost/*
service consul start
