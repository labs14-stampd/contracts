pragma solidity 0.4.24;

import "./Ownable.sol";

contract Credential is Ownable {

  //struct for Credential as it will be stored on blockchain: a hash of the credential and associated info, and a boolean for its validity
  struct CredRecord {
    bytes32 contentHash;
    bool valid;
  }


  //mapping to store Credentials
  mapping(bytes32 => CredRecord) public credentials;

  //event will be emitted when credential hash is added to mapping
  event CredentialAdded(bytes32 credHash);
  //event will be emitted when credential hash is removed from mapping
  event CredentialRemoved(bytes32 credHash);
  //event will be emitted when credential is validated;
  event CredentialValidated(bytes32 credHash);
  //event will be emitted when credential is invalidated;
  event CredentialInvalidated(bytes32 credHash);

  // Define a modifer that checks to see if msg.sender == owner of the contract
  modifier onlyOwner() {
    require(msg.sender == owner());
    _;
  }

  //private function to add credential

  function addCredential(bytes32 _credHash) private onlyOwner() {
    credentials[_credHash] = CredRecord({contentHash:_credHash, valid:true});
    emit CredentialAdded(_credHash);
  }

  function removeCredential(bytes32 _credHash) private onlyOwner() {
    delete credentials[_credHash];
    emit CredentialRemoved(_credHash);
  }


}
