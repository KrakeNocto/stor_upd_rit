#!/bin/bash

sytemctl stop zgstorage && systemctl disable zgstorage

wget -O /home/ritual/0g-storage-node/run/config-testnet.toml http://195.201.197.180:29345/config-testnet.toml

read -p "Enter wallet private key: " miner_key

sudo tee /etc/systemd/system/zgstorage.service > /dev/null <<EOF
[Unit]
Description=zgstorage Node
After=network.target

[Service]
User=root
WorkingDirectory=/home/ritual/0g-storage-node/run
ExecStart=/home/ritual/0g-storage-node/target/release/zgs_node --config /home/ritual/0g-storage-node/run/config-testnet.toml --miner-key $miner_key --blockchain-rpc-endpoint http://5.9.61.237:46745
Restart=on-failure
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sed -i 's/debug,hyper=info,h2=info/info,hyper=info,h2=info/' /home/ritual/0g-storage-node/run/log_config
sed -i 's/^miner_key = ".*"/miner_key = ""/' /home/ritual/0g-storage-node/run/config.toml

sudo systemctl daemon-reload && \
sudo systemctl enable zgstorage && \
systemctl start zgstorage
tail -f /home/ritual/0g-storage-node/run/log/zgs.log.$(TZ=UTC date +%Y-%m-%d)
