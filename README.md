# remittance


fund transfer from alice to bob through carol..
1. alice emails one time "unique" password to bob. alice cannot use same password for multiple payments.
2. alice generates a hash from : password sent to bob + address of carol
3. alice calls `deposit()` method with the "hash" as argument. the method adds a new payment with amount = ether sent with call
4. bob goes to carol with his unique "password", carol uses this password as parameter and calls `withdraw()` function.
carol's address and bob's password is used to get the payment alice created, the funds are then transfered. 
