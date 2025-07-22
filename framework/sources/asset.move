module algomove::asset {

	use algomove::opcode as op;
	use algomove::transaction as txn;
	use algomove::utils;
	use std::string::{String};


	struct Asset<phantom AssetType> has store {
		id: u64,
		amount: u64,
		owner: address
	}
	
	public fun create<AssetType>(acc: &signer, total: u64, decimals: u64, default_frozen: bool, short_name: String): Asset<AssetType> {
		let sender = utils::address_of_signer(acc);
		let name = utils::name_of<AssetType>();
		txn::asset_config(sender, total, decimals, default_frozen, name, short_name);
		Asset<AssetType> { id: op::txn_CreatedAssetID(), amount: total, owner: sender }
	}

	public fun deposit<AssetType>(receiver: address, assets: Asset<AssetType>) {
		let Asset { id, amount, owner } = assets;
		let sender = op::txn_Sender();
		assert!(owner == sender, 1);
		txn::asset_transfer(sender, id, amount, receiver)
	}

	public fun withdraw<AssetType>(acc: &signer, amount: u64): Asset<AssetType> {
		let id = utils::retrieve_asset_id<AssetType>();
		let sender = utils::address_of_signer(acc);
		assert!(amount <= op::asset_holding_get_AssetBalance(sender, id), 1);
		let escrow = op::global_CurrentApplicationAddress();
		txn::asset_transfer(sender, id, amount, escrow);
		Asset<AssetType> { id, amount, owner: escrow }
	}

	public fun transfer<AssetType>(from: &signer, to: address, amount: u64) {
        let assets = withdraw<AssetType>(from, amount);
        deposit(to, assets);
    }

	public fun split<AssetType>(assets: Asset<AssetType>, amt: u64): (Asset<AssetType>, Asset<AssetType>) {
		let Asset { id, amount: old_amount, owner } = assets;
		let new = Asset<AssetType> { id, amount: old_amount - amt, owner };
		let old = Asset<AssetType> { id, amount: old_amount, owner };
		(new, old)
	}

	public fun value<AssetType>(asset: &Asset<AssetType>): u64 {
		asset.amount
	}

}
