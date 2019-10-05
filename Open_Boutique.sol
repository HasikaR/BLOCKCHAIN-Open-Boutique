pragma solidity ^0.5.6;
contract Openboutique{
    

struct productinfo{
    string gender;
    string name;
    string brand;
    string cato;
    int16 size;
    int256 rate;
    string location;
    
    }
  
  
 struct sellerinfo{
    string name;
    int256 contact;
    string company;
    
    } 
    
 
struct buyerinfo{
    string name;
    int256 contact;
    string location;
    }   
    
    
 
  productinfo public p;    
  sellerinfo public s;
  buyerinfo public b;  
    



    
    function setinfo_product(string memory _gender,string memory _name,string memory _brand, string memory _cato, int16 _size, int256 _rate, string memory _location)public {
    p.gender=_gender;
    p.name=_name;
    p.brand=_brand;
    p.cato=_cato;
    p.size=_size;
    p.rate=_rate;
    p.location=_location;
        
    }
    
  
    function getinfo_product(int256 code)public returns (string memory _gender,string memory _name,string memory _brand, string memory _cato, int16 _size, int256 _rate, string memory _location)  {
    
    return (p.gender,p.name,p.brand, p.cato, p.size, p.rate, p.location);
    }
    

    
    
    function setinfo_seller(string memory _name,int256 _contact, string memory _company) public {
    s.name=_name;
    s.contact=_contact;
    s.company=_company;
        
    }
    
    function getinfo_seller(int16 code) public returns (string memory _name,int256 _contact,string memory _company)  {
    return (s.name, s.contact,s.company);
    }
    
    
    function setinfo_buyer(string memory _name,int256 _contact) public {
    b.name=_name;
    b.contact=_contact;
        
    }
    
    function getinfo_buyer(int16 code) public returns (string memory _name,int256 _contact, string memory _location)  {
    return (b.name, b.contact, b.location);
    }
    
    
    


address public boutique;
address payable[] public consumer;
event ordering (address seller, uint amount);
constructor() public {
        boutique = msg.sender;
    }
    modifier onlyBoutique() {
        require(boutique == msg.sender,"Only openbotique can call this fn");
        _;
    }
    function () payable external {
        require(msg.value >= 1 ether);
        require(boutique != msg.sender);
        consumer.push(msg.sender);
    }
    
    function balance() public view onlyBoutique returns (uint) {
        
        return address(this).balance;
    }
    
    
    
    function  transferProduct (address payable buyer)public onlyBoutique{
        require(buyer!=address(0));
        emit ordering(buyer,address(this).balance);
        buyer.transfer(address(this).balance);
    }
}
