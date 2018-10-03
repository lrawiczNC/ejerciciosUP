pragma solidity ^0.4.22;
contract Subasta {
	// Parameters of the auction. Times are either
    // absolute unix timestamps (seconds since 1970-01-01)
    // or time periods in seconds.
    address public beneficiary;
    uint public auctionEnd;

	// El estado actual de la subasta
    address public highestBidder;
    uint public highestBid;

     // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;

	// Set to true at the end, disallows any change
    bool ended;

	// Events that will be fired on changes.
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    /// Create a simple auction with `_biddingTime`
    /// seconds bidding time on behalf of the
    /// beneficiary address `_beneficiary`.
    constructor(uint _biddingTime,address _beneficiary) public ;
    /// Bid on the auction with the value sent
    /// together with this transaction.
    /// The value will only be refunded if the
    /// auction is not won.
    function bid() public payable;
    /// Withdraw a bid that was overbid.
    function withdraw() public returns (bool);

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function auctionEnd() public;
        
}