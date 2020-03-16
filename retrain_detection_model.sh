#!/bin/bash

OBJ_DET_DIR="$PWD"
LEARN_DIR="${OBJ_DET_DIR}/learn_pet"
DATASET_DIR="${LEARN_DIR}/pet"
CKPT_DIR="${LEARN_DIR}/ckpt"
TRAIN_DIR="${LEARN_DIR}/train"
OUTPUT_DIR="${LEARN_DIR}/models"

# Exit script on error.
set -e
# Echo each command, easier for debugging.
set -x

usage() {
  cat << END_OF_USAGE
  Starts retraining detection model.

  --num_training_steps Number of training steps to run, 500 by default.
  --num_eval_steps     Number of evaluation steps to run, 100 by default.
  --help               Display this help.
END_OF_USAGE
}

num_training_steps=500
while [[ $# -gt 0 ]]; do
  case "$1" in
    --num_training_steps)
      num_training_steps=$2
      shift 2 ;;
    --num_eval_steps)
      num_eval_steps=$2
      shift 2 ;;    
    --help)
      usage
      exit 0 ;;
    --*)
      echo "Unknown flag $1"
      usage
      exit 1 ;;
  esac
done

source "$PWD/constants.sh"

mkdir -p "${TRAIN_DIR}"

python object_detection/model_main.py \
  --pipeline_config_path="/content/trainingMobilenetV1SsdInColabLib/trainingMobilenetV1SsdInColabLib/configs/pipeline_mobilenet_v1_ssd_retrain_last_few_layers.config" \
  --model_dir="${TRAIN_DIR}" \
  --num_train_steps="${num_training_steps}" \
  --num_eval_steps="${num_eval_steps}"
