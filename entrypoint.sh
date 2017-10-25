#!/bin/bash
/bin/ethermint --datadir /.ethermint/setup init /.ethermint/setup/genesis.json
/bin/ethermint --datadir /.ethermint/setup --rpc --rpcaddr=0.0.0.0 --ws --wsaddr=0.0.0.0 --rpcapi eth,net,web3,personal,admin
