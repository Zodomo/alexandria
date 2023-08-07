// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.20;

import "solady/src/tokens/ERC721.sol";
import "sstore2/SSTORE2.sol";

contract alexandria is ERC721 {

    string private _name;
    string private _symbol;

    constructor(
        string memory __name,
        string memory __symbol
    ) payable {
        _name = __name;
        _symbol = __symbol;
    }

    function name() public view override returns (string memory) { return (_name); }
    function symbol() public view override returns (string memory) { return (_symbol); }
    function tokenURI(uint256 _tokenId) public view override returns (string memory) { }
}