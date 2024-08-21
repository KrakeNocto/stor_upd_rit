#!/bin/bash

# Stop service && backup config-testnet.toml
# sudo systemctl stop zgstorage && systemctl disable zgstorage && 
cp /home/ritual/0g-storage-node/run/config-testnet.toml /home/ritual/0g-storage-node/run/config-testnet.toml.backup

# Get new binary
rm zgs_node*
wget http://95.217.43.226:21123/zgs_node && mv zgs_node /home/ritual/0g-storage-node/target/release/zgs_node

chmod +x /home/ritual/0g-storage-node/target/release/zgs_node

# Remove database
# rm -rf /root/0g-storage-node/run/db/

# Restore config-testnet.toml
mv /home/ritual/0g-storage-node/run/config-testnet.toml.backup /home/ritual/0g-storage-node/run/config-testnet.toml

# Start Storage node
# sudo systemctl enable zgstorage && systemctl start zgstorage && tail -f ~/0g-storage-node/run/log/zgs.log.$(TZ=UTC date +%Y-%m-%d)
