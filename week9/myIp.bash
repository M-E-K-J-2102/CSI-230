#!/bin/bash
# Only display IP address after calling ip addr
ip addr | grep -oP 'inet \K[\d.]+' | sed -n '2p'

