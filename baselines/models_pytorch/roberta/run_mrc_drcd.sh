#!/usr/bin/env bash
CURRENT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
export BERT_LARGE_DIR=$CURRENT_DIR/prev_trained_model/roberta_zh_L-24_H-1024_A-16
export GLUE_DIR=$CURRENT_DIR/../../glue/chineseGLUEdatasets/
TASK_NAME="DRCD"
python run_mrc.py \
  --gpu_ids="0,1,2,3" \
  --train_epochs=2 \
  --n_batch=32 \
  --lr=3e-5 \
  --warmup_rate=0.1 \
  --float16 \
  --max_seq_length=256 \
  --vocab_file=$BERT_LARGE_DIR/vocab.txt \
  --bert_config_file=$BERT_LARGE_DIR/bert_config_large.json \
  --init_checkpoint=$BERT_LARGE_DIR/roberta_zh_large_model.pth \
  --train_dir=$GLUE_DIR/$TASK_NAME/train_features.json \
  --train_file=$GLUE_DIR/$TASK_NAME/DRCD_training.json \
  --dev_dir1=$GLUE_DIR/$TASK_NAME/dev_examples.json \
  --dev_dir2=$GLUE_DIR/$TASK_NAME/dev_features.json \
  --dev_file=$GLUE_DIR/$TASK_NAME/DRCD_dev.json \
  --checkpoint_dir=$GLUE_DIR/$TASK_NAME/roberta_large/

