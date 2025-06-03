# `DELEGATECALL`

- The contract where the call is being delegated must update the same storage slot that is being intended to be updated on the contract calling the delegate call.


- Separating `storage` from `logic` allows to create __upgradable smart contracts__
  
`contract.Storage delegateall contract.logic`

What if the logic contract reads a value from storage?
