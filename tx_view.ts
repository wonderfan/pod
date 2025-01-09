import {
    createWalletClient,
    http,
    parseEther,
    formatEther,
    publicActions,
    defineChain,
} from 'viem';
import { privateKeyToAccount } from 'viem/accounts';

const myCustomChain = defineChain({
    id: 1113, 
    name: 'X Chain', 
    nativeCurrency: {
        decimals: 18,
        name: 'X',
        symbol: 'X',
    },
    rpcUrls: {
        default: {
            http: ['https://x.network'],
        },
    }
});

const RPC_ENDPOINT = 'https://x.network';
const PRIVATE_KEY = '';

const account = privateKeyToAccount(PRIVATE_KEY);
const walletClient = createWalletClient({
    account,
    chain: myCustomChain, 
    transport: http(RPC_ENDPOINT),
}).extend(publicActions);

const toAddress = '0x3e8010d4a49EBD72CA7063A8ad572886B3F34Ba9'; 
const ethAmount = parseEther('1'); 

async function sendEther() {
    const balanceFrom = await walletClient.getBalance({ address: account.address });
    console.log(`Sender's balance: ${formatEther(balanceFrom)} ETH`);

    if (balanceFrom < ethAmount) {
        throw new Error('Insufficient ETH balance.');
    }

    const txHash = await walletClient.sendTransaction({
        to: toAddress,
        value: ethAmount,
    });

    console.log(`Transaction sent! Hash: ${txHash}`);
}

// Execute the function and handle errors
sendEther().catch((error) => {
    console.error('Error sending transaction:', error);
    process.exit(1);
});
