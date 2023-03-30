pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract ERC721NonCompliant is ERC721, ERC721Enumerable {
    
    uint256 public counter;
    uint256 public maxSupply;
    bool public isMintableOrBurnable;


    constructor() ERC721("OZERC721","OZ") {
        maxSupply = 100;
        isMintableOrBurnable = true;
    }

    function balanceOf(address owner) public view virtual override(ERC721, IERC721) returns (uint256) {
        //require(owner != address(0), "ERC721: address zero is not a valid owner");
        return owner == address(0) ? 0 : super.balanceOf(owner);
    }

    function ownerOf(uint256 tokenId) public view virtual override(ERC721, IERC721) returns (address) {
        address owner = _ownerOf(tokenId);
        //require(owner != address(0), "ERC721: invalid token ID");
        return owner;
    }

    function _customMint(address to, uint256 amount) public virtual {
        maxSupply += amount;

        for (uint256 i; i < amount; i++) {
            _mint(to, counter++);
        }
    }

    function _customMaxSupply() public virtual view returns (uint256) {
        return maxSupply;
    }
    
    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        virtual
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}