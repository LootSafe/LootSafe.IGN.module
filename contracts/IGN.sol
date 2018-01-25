pragma solidity ^0.4.17;

contract IGN {
    address public owner;

    mapping(address => bytes32) names;
    mapping(bytes32 => address) addresses;

    function IGN () public {
        owner = msg.sender;
    }

    // Register an in game name to an address
    function register (bytes32 name) external {
        require(addresses[name] == 0x0);
        names[msg.sender] = name;
        addresses[name] = msg.sender;
    }

    // Get an address by in game name
    function getAddress (bytes32 ign) external view returns (address account) {
        return addresses[ign];
    }

    // Change the address assigned to an in game name
    function changeAddress (address newAddress) external {
        // Require that the sender has already registered an IGN
        require(names[msg.sender] != 0x0);
        // Ensure new address is not already assigned to IGN
        require(names[newAddress] == 0x0);
        
        bytes32 ign = names[msg.sender];
        // Change the address associated to this name
        addresses[ign] = newAddress;
        // Change the name associated to the new address
        names[newAddress] = ign;
        // Remove the old address association
        delete names[msg.sender];
    }
}