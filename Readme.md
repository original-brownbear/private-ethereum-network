## Running the Automated Private Network

```sh
./up.sh
```

## Setting up a Private Ethereum Network Manually

### Step 1: Create a Genesis Block

You will need a custom Genesis block for your private network.
You can work from this example and customize it:

```json
{
    "config": {
        "chainId": 15,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },

    "alloc"      : {
        "0x0000000000000000000000000000000000000001": {"balance": "111111111"},
        "0x0000000000000000000000000000000000000002": {"balance": "222222222"}
    },

    "coinbase"   : "0x0000000000000000000000000000000000000000",
    "difficulty" : "0x0000001",
    "extraData"  : "",
    "gasLimit"   : "0x2fefd8",
    "nonce"      : "0x0000000000000107",
    "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
    "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
    "timestamp"  : "0x00"
}

```

You should at least make sure to use a unique `chainId` for your network here. Other than that you don't need to customize anything unless you know what you're doing.

### Step 2: Start a Boot Node

In order to run a boot node using `geth` you simply need to run the following (assuming you're at the root of your `geth` directory):

```sh
./build/bin/geth --datadir=/ethereum/data init /ethereum/genesis.json
./build/bin/bootnode --genkey=/ethereum/boot.key
./build/bin/bootnode --nodekey=/ethereum/boot.key
```

You can obviously customize the values of `--datadir` and the path for `--genkey` and `--nodekey` to your system's needs.

You should now see output from the boot node that looks similar to:

```sh
INFO [02-13|08:21:30] UDP listener up                          self=enode://5862b24ab57e63b4befb28a9187a5c80dc2748d12f1832039991951057bdbfe3887d2391231b7c010f25b0f959ae930daf2049309acdac7eddc55b02e00c8970@[::]:30301
```

Allowing you to determine the boot node's enode you need in the next step.
You are now finished setting up the boot node.

### Step 3: Start Geth Node

The next step to setting up your network is setting up a `geth` node that you can now bootstrap via you bootnode.
You will need the enode of the bootnode that you determined in step 2 as well as the IP address of the boot node.\
In this example we will assume the boot node's IP address to be `172.20.0.2`.\
Also, you will need the `genesis.json` file from steps 1 and 2 on the `geth` node as well.\
\
First you will have to initialize the node with the genesis block:

```sh
./build/bin/geth --datadir=/ethereum/data init /ethereum/genesis.json
```

Again customizing the paths as necessary.\
Once the `geth` node is initialized you can now connect it to the boot node and establish your private network by running:

```
./build/bin/geth --datadir=/ethereum/data --bootnodes=enode://5862b24ab57e63b4befb28a9187a5c80dc2748d12f1832039991951057bdbfe3887d2391231b7c010f25b0f959ae930daf2049309acdac7eddc55b02e00c8970@172.20.0.2:30301
```

Now that you have a running `geth` node as well as a functional boot node you can create an account on your network that you will need in the next step.\
You can do this by running:

```sh
./build/bin/geth attach /ethereum/data/geth.ipc
```

to attach to the `geth` node and then creating an account from the geth console via:

```sh
>  personal.newAccount("somePassword")
"0x0d63d5bbadd7e49d46f32c85810f3c1e932c45a5"
```

Now that we have an account we can move on to setting up a miner in the next step.

### Step 4: Setting up a Miner

Setting up a miner starts like setting up a normal geth node. We again initialize the Genesis block from the `genesis.json` file used by the bootnode and standard geth node.

```sh
./build/bin/geth --datadir=/ethereum/data init /ethereum/genesis.json
```

```sh
./build/bin/geth --datadir=/ethereum/data --bootnodes=enode://5862b24ab57e63b4befb28a9187a5c80dc2748d12f1832039991951057bdbfe3887d2391231b7c010f25b0f959ae930daf2049309acdac7eddc55b02e00c8970:172.20.0.2:30301 --mine --minerthreads=1 \
    --etherbase=0x0d63d5bbadd7e49d46f32c85810f3c1e932c45a5
```

Note that we pointed the miner at the account we created in step `3` via the `--etherbase` flag.\
After a while you should see ether appear in your account.
