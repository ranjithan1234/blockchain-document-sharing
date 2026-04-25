// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DocumentStorage {

    struct Document {
        string cid;
        address owner;
    }

    uint public docCount;

    mapping(uint => Document) public documents;

    // 🔥 NEW: access control
    mapping(uint => mapping(address => bool)) public access;

    // Upload document
    function uploadDocument(string memory _cid) public {
        docCount++;
        documents[docCount] = Document(_cid, msg.sender);

        // Owner gets access
        access[docCount][msg.sender] = true;
    }

    // 🔥 NEW: Share document
    function shareDocument(uint _id, address user) public {
        require(msg.sender == documents[_id].owner, "Not owner");
        access[_id][user] = true;
    }

    // Get document (only allowed users)
    function getDocument(uint _id) public view returns (string memory, address) {
        require(access[_id][msg.sender], "Access denied");
        Document memory doc = documents[_id];
        return (doc.cid, doc.owner);
    }
}