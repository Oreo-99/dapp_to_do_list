module ipocontract_addr::ipocontract {

use aptos_framework::event;
// use std::string::String;
use std::signer;
use aptos_std::table::{Self, Table};
use aptos_framework::account;
use std::string::String; // already have it, need to modify
use aptos_std::vector;






const E_NOT_INITIALIZED: u64 = 1;
const ETASK_DOESNT_EXIST: u64 = 2;
const ETASK_IS_COMPLETED: u64 = 3;

    struct IPOStorage has key {
    IPOs: Table<u64, IPO>,
    set_ipo_event: event::EventHandle<IPO>,
    ipo_counter: u64}
    
    // Define the IPO struct to hold information about each IPO
    struct IPO has store, drop, copy {
        name: vector<u8>,
        start_date: u64,
        end_date: u64,
        price_per_share: u64,
        total_shares: u64,
        remaining_shares: u64,
        users_allocated: vector<address>,
        address:address,
    } 

    // Define storage to hold IPO details
    

    public entry fun create_list(account: &signer){
     let ipos_holder = IPOStorage {
    IPOs: table::new(),
    set_ipo_event: account::new_event_handle<IPO>(account),
    ipo_counter: 0
  };
  // move the TodoList resource under the signer account
  move_to(account, ipos_holder);
}

    // Add a new IPO to the storage
    /* public fun create_IPO(name: vector<u8>, start_date: u64, end_date: u64, price_per_share: u64, total_shares: u64) {
        let new_IPO = IPO {
            name: name,
            start_date: start_date,
            end_date: end_date,
            price_per_share: price_per_share,
            total_shares: total_shares,
            remaining_shares: total_shares,
            users_allocated: empty(),
        };
        let storage = borrow_global_mut<IPOStorage>();

        vector::push_back(&mut storage, new_IPO);
    } */

    public fun create_IPO(
        account: &signer, start_date: u64, end_date: u64, price_per_share: u64, total_shares: u64, name: vector<u8>

    ) acquires IPOStorage {
        let signer_address = signer::address_of(account);
        let ipo_storage = borrow_global_mut<IPOStorage>(signer_address);
        let counter = ipo_storage.ipo_counter + 1;
        let new_ipo = IPO {
            name: name,
            start_date: start_date,
            end_date: end_date,
            price_per_share: price_per_share,
            total_shares: total_shares,
            remaining_shares: total_shares,
            users_allocated: vector::empty(),
            address: signer_address,
        };
        table::upsert(&mut ipo_storage.IPOs, counter, new_ipo);
        ipo_storage.ipo_counter = counter;
            event::emit_event<IPO>(
        &mut borrow_global_mut<IPOStorage>(signer_address).set_ipo_event,
        new_ipo,);
    }

    /* // Function to allocate IPO shares to users
    public fun allocate_shares(index: u64, user_count: u64) {
        let storage = borrow_global_mut<IPOStorage>();
        let IPO = &mut storage.IPOs[index as usize];
        let remaining_shares = IPO.remaining_shares;

        if user_count > remaining_shares {
            return; // Not enough shares available for allocation
        }

        for _ in 0..user_count {
            let sender = signer::address_of(get_txn_sender());
            vector::push_back(&mut IPO.users_allocated, sender);
        }

        IPO.remaining_shares -= user_count;
    } */

    // Function to check if the IPO is allocated to a user
/*     public fun is_allocated(index: u64, user: address): bool {
        let storage = borrow_global<IPOStorage>();
        let IPO = &storage.IPOs[index as usize];
        IPO.users_allocated.contains(&user)
    } */

    // Getters
/*     public fun get_IPO_count(): u64 {
        let storage = borrow_global<IPOStorage>();
        storage.IPOs.len() as u64
    }

    public fun get_IPO_details(index: u64): (vector<u8>, u64, u64, u64, u64, vector<address>) {
        let storage = borrow_global<IPOStorage>();
        let IPO = &storage.IPOs[index as usize];
        (IPO.name, IPO.start_date, IPO.end_date, IPO.price_per_share, IPO.remaining_shares, IPO.users_allocated)
    } */

    // Test commands
/*     #test
    public fun test_add_IPO() {
        add_IPO("IPO 1".to_bytes(), 1, 100, 10, 1000);
        add_IPO("IPO 2".to_bytes(), 101, 200, 20, 2000);
    }

    #test
    public fun test_allocate_shares() {
        allocate_shares(0, 5);
        allocate_shares(1, 10);
    }

    #test
    public fun test_is_allocated() {
        assert(is_allocated(0, get_txn_sender()) == true, "Error: IPO should be allocated to sender");
        assert(is_allocated(1, get_txn_sender()) == true, "Error: IPO should be allocated to sender");
    } */
}
