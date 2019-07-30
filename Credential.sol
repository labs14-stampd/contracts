pragma solidity 0.4.24;

contract Credential{

  //struct for Credential as it will be stored on blockchain: a hash of the credential and associated info, and a boolean for its validity
  struct Credential {
    bytes32 contentHash;
    bool valid;
  }

  //mapping to store hashes of credentials
  mapping(bytes32 => CredHash) public credHashes;

  //event will be emitted when credential hash is added to mapping
  event CredentialAdded(bytes32 credHash);
  //event will be emitted when credential hash is removed from mapping
  event CredentialRemoved(bytes32 credHash);
  //event will be emitted when credential is validated;
  event CredentialValidated(bytes32 credHash);
  //event will be emitted when credential is invalidated;
  event CredentialInvalidated(bytes32 credHash);

  
}
