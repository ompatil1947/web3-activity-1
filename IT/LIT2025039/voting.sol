// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Voting {
    address public owner;

    struct Candidate {
        string name;
        uint voteCount;
    }

    Candidate[] public candidates;

    mapping(address => bool) public hasVoted;

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory name) public {
        require(msg.sender == owner, "Only owner can add candidates");
        candidates.push(Candidate(name, 0));
    }

    function vote(uint candidateIndex) public {
        require(!hasVoted[msg.sender], "You can vote only once");
        require(candidateIndex < candidates.length, "Invalid candidate index");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount++;
    }

    function getCandidatesCount() public view returns (uint) {
        return candidates.length;
    }

    function getCandidate(uint index) public view returns (string memory, uint) {
        require(index < candidates.length, "Invalid index");
        return (candidates[index].name, candidates[index].voteCount);
    }
}
