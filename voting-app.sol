// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Election is Ownable {

    struct Candidate {
        string name;
        uint index;
        uint votecount;
    }

    struct Voter {
        string name;
        uint index;
        bool voted;
    }

    mapping (uint => Candidate) public candidates;
    mapping (uint => Voter) public voters;

    Candidate public candidate1;
    Candidate public candidate2;

    constructor() {
        candidate1 = Candidate("Rahul", 1, 0);
        candidate2 = Candidate("Priya", 2, 0);
    }

    function vote(string memory _name, uint _voterIndex, uint _candidateIndex) public {
        require(!voters[_voterIndex].voted, "This voter has already voted.");

        voters[_voterIndex].name = _name;
        voters[_voterIndex].index = _voterIndex;
        voters[_voterIndex].voted = true;

        if (_candidateIndex == candidate1.index) {
            candidate1.votecount++;
        } else if (_candidateIndex == candidate2.index) {
            candidate2.votecount++;
        } else {
            revert("Invalid candidate index.");
        }
    }

    function getWinner() public view onlyOwner returns (string memory) {
        if (candidate1.votecount > candidate2.votecount) {
            return candidate1.name;
        } else {
            return candidate2.name;
        }
    }

}
