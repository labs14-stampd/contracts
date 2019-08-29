pragma solidity 0.4.24;

import "./Ownable.sol";

contract Credential is Ownable {

  //struct for Credential as it will be stored on blockchain: a hash of the credential and associated info, and a boolean for its validity
  struct CredRecord {
    bytes32 contentHash;
    bool valid;
    string timestamp;
  }


  //mapping to store Credentials
  mapping(bytes32 => CredRecord) public credentials;

  //event will be emitted when credential hash is added to mapping
  event CredentialAdded(bytes32 credHash);
  //event will be emitted when credential hash is removed from mapping
  event CredentialRemoved(bytes32 credHash);

  // Define a modifer that checks to see if msg.sender == owner of the contract
  modifier onlyOwner() {
    require(msg.sender == owner(), "You must be the owner of the contract.");
    _;
  }

  function addCredential(bytes32 _credHash, string _credTimestamp) public onlyOwner() {
    credentials[_credHash] = CredRecord({contentHash:_credHash, valid:true, timestamp:_credTimestamp});
    emit CredentialAdded(_credHash);
  }

  function removeCredential(bytes32 _credHash) public onlyOwner() {
    delete credentials[_credHash];
    emit CredentialRemoved(_credHash);
  }

  function verifyCredential(bytes32 _credHash) public view onlyOwner() returns(bool) {
    require((credentials[_credHash].contentHash == _credHash) && (credentials[_credHash].valid == true),
    "No credential with that hash can be validated.");
    return true;
  }

  function invalidateCredential(bytes32 _credHash) public onlyOwner() returns(bool) {
    credentials[_credHash].valid = false;
    require(credentials[_credHash].valid == false, "Credential has not been changed to invalid.");
    return true;
  }

  function validateCredential(bytes32 _credHash) public onlyOwner() returns(bool) {
    credentials[_credHash].valid = true;
    require(credentials[_credHash].valid == true, "Credential has not been changed to valid");
    return true;
  }
}
