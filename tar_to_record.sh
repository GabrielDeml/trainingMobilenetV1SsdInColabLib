#!/bin/bash

rm -rf out
mkdir out
mkdir tmp

tar_file=$(find data/ -name *.tar*)
echo $tar_file
cp "$tar_file" data.tar

tar -xf ./data.tar -C ./out/

python3 json_to_csv.py

python generate_tfrecord.py --input_csv=./tmp/train.csv --output_tfrecord=train.record

python generate_tfrecord.py --input_csv=./tmp/eval.csv --output_tfrecord=eval.record

python3 parse_meta.py -out=map.pbtxt

printf ".\nRecords generated"
