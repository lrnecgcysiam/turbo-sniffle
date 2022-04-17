#!/bin/bash
# This script converts a base 10 number to binary.
echo "obase=2;$1" | bc
