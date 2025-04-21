#!/bin/bash

tools=(
move-analyzer
sui
sui-bridge
sui-bridge-cli
sui-data-ingestion
sui-debug
sui-faucet
sui-graphql-rpc
sui-node
sui-test-validator
sui-tool
)

for tool in "${tools[@]}"; do
  tool_path="$HOME/.sui/$tool"
  rm -fr "$tool_path"
done
