
let contract_address="0x1e476C3f6D243b04E14F0E777470DE095712aE05";
let abi=[
	{
		"inputs": [],
		"name": "avilable_faucet",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "deposit",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "total_deposit_value",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "withdraw",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]

let provider =new ethers.providers.Web3Provider(window.ethereum);
let signer = provider.getSigner();
let contract = new ethers.Contract(contract_address,abi,signer);

async function connectWallet(){
    await provider.send("eth_requestAccounts",[]);
}
async function bal(){
    document.getElementById("bal").innerHTML=await contract.avilable_faucet();
}

async function deposit_faucet(){
    let amount=document.getElementById('text1').value;
    await contract.deposit({value : amount});
}


async function claim_faucet(){

    try{
        await contract.withdraw();
    }
    catch(err){
        document.getElementById("e").innerHTML=err.error["message"];
    }
}
bal();