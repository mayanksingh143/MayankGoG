// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title MetaProofHub
 * @dev A decentralized verification hub for authenticating digital documents using cryptographic hashes.
 */
contract MetaProofHub {
    struct Proof {
        uint256 id;
        string documentHash;
        address owner;
        uint256 timestamp;
    }

    mapping(uint256 => Proof) public proofs;
    uint256 public totalProofs;

    event ProofAdded(uint256 indexed id, string documentHash, address indexed owner);
    event OwnershipTransferred(uint256 indexed id, address indexed from, address indexed to);

    /**
     * @dev Add a proof for a document hash.
     * @param _documentHash The hash of the verified document.
     */
    function addProof(string memory _documentHash) public {
        totalProofs++;
        proofs[totalProofs] = Proof(totalProofs, _documentHash, msg.sender, block.timestamp);
        emit ProofAdded(totalProofs, _documentHash, msg.sender);
    }

    /**
     * @dev Transfer ownership of a proof to another address.
     * @param _id The ID of the proof.
     * @param _newOwner The new owner's address.
     */
    function transferProofOwnership(uint256 _id, address _newOwner) public {
        require(_id > 0 && _id <= totalProofs, "Invalid proof ID");
        Proof storage proof = proofs[_id];
        require(proof.owner == msg.sender, "Only owner can transfer");
        require(_newOwner != address(0), "Invalid new owner");

        address previousOwner = proof.owner;
        proof.owner = _newOwner;
        emit OwnershipTransferred(_id, previousOwner, _newOwner);
    }

    /**
     * @dev Get proof details by ID.
     * @param _id The ID of the proof.
     */
    function getProof(uint256 _id) public view returns (uint256, string memory, address, uint256) {
        require(_id > 0 && _id <= totalProofs, "Proof does not exist");
        Proof memory proof = proofs[_id];
        return (proof.id, proof.documentHash, proof.owner, proof.timestamp);
    }
}
