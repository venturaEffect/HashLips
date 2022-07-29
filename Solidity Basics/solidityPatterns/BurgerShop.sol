// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0<=0.9.0;


contract BurgerShop {
    uint256 public normalCost = 0.2 ether;
    uint256 public deluxCost = 0.4 ether;
    uint256 public startDate = block.timestamp + 30 seconds;
    uint256 public burgerCount = 100;

    address public owner;

    mapping(address => uint256) public userRefunds;
    
    bool public paused = false;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner!");
        _;
    }

    modifier shopOpened() {
        require(block.timestamp > startDate, "This is not opened yet!");
        _;
    }

    event BoughtBurger (address indexed _from, uint256 cost);

    enum Stages {
        readyToOrder,
        makeBurger,
        deliverBurger
    }

    Stages public burgerShopStage = Stages.readyToOrder;

    modifier isAtStage(Stages _stage) {
        require(burgerShopStage == _stage, "Not at correct stage!");
        _;
    }

    modifier correctAmount() {
        require(msg.value == normalCost || msg.value == deluxCost, "Not the correct amount!");
        _;
    }

    modifier notPaused() {
        require(paused == false);
        _;
    }

    function buyBurger(uint256 _price) payable public correctAmount() isAtStage(Stages.readyToOrder) shopOpened notPaused{
        updateStage(Stages.makeBurger);
        burgerCount--;
        emit BoughtBurger(msg.sender, _price);
        payable(msg.sender).transfer(_price);

    }

    function refund(address _to, uint256 _cost) payable public onlyOwner correctAmount {
        require(address(this).balance >= _cost, "Not enough funds");
        userRefunds[_to] = _cost;

    }

    function claimRefund() payable public {
        uint256 value = userRefunds[msg.sender];

        userRefunds[msg.sender] = 0;

        (bool success, ) = payable(msg.sender).call{value: value}("");
        require(success);
    }

    function getFunds() public view returns(uint256) {
        return address(this).balance;
    }

    function madeBurger() public isAtStage(Stages.makeBurger) shopOpened{
        updateStage(Stages.deliverBurger);
    }

    function pickUpBurger() public isAtStage(Stages.deliverBurger) shopOpened{
        updateStage(Stages.readyToOrder);
    }

    function updateStage(Stages _stage) public {
        burgerShopStage = _stage;
    }

    function getRandomNum(uint256 _seed) public view returns(uint256) {
        uint256 randNum = uint256(keccak256(abi.encodePacked(block.timestamp, _seed))) % 10 + 1;
        return randNum;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
    }
}