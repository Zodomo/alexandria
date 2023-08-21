// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.20;

import "solady/src/utils/LibString.sol";
import "solady/src/utils/SSTORE2.sol";
import "solady/src/utils/LibZip.sol";
import "solady/src/tokens/ERC721.sol";
import "solady/src/auth/Ownable.sol";

contract alexandria is ERC721, Ownable {

    error MaxSupplyExceeded();
    error InsufficientPayment();

    string private _name;
    string private _symbol;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public price;
    address[] public textStorage;

    constructor(
        string memory __name,
        string memory __symbol,
        uint256 _maxSupply,
        uint256 _price
    ) payable {
        _name = __name;
        _symbol = __symbol;
        maxSupply = _maxSupply;
        price = _price;
        _initializeOwner(msg.sender);
    }

    function name() public view override returns (string memory) { return (_name); }
    function symbol() public view override returns (string memory) { return (_symbol); }
    function tokenURI(uint256 _tokenId) public view override returns (string memory text) {
        for (uint256 i; i < textStorage.length;) {
            text = LibString.concat(text, string(LibZip.flzDecompress(SSTORE2.read(textStorage[i]))));
            unchecked { ++i; }
        }
    }

    function mint(address _to, uint256 _amount) public payable returns (uint256[] memory) {
        if (_amount * price < msg.value) { revert InsufficientPayment(); }
        if (totalSupply + _amount > maxSupply) { revert MaxSupplyExceeded(); }
        uint256[] memory tokens = new uint256[](_amount);
        for (uint256 i; i < _amount;) {
            _mint(_to, ++totalSupply);
            tokens[i] = totalSupply;
            unchecked { ++i; }
        }
        return (tokens);
    }

    function write(bytes[] memory _byteData) external onlyOwner {
        for (uint256 i; i < _byteData.length;) {
            textStorage.push(SSTORE2.write(_byteData[i]));
            unchecked { ++i; }
        }
    }

    function overwrite(uint256 _index, bytes memory _data) external onlyOwner {
        textStorage[_index] = SSTORE2.write(_data);
    }
}