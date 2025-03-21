// SPDX-License-Identifier:Unlicensed
pragma solidity >=0.7.0;
contract Div{
struct Event{
address organizer;
string name;
uint date;
uint price;
uint ticketCount;
uint ticketRemain;

}
mapping(uint=>Event)public events;
mapping(address=>mapping(uint=>uint))public tickets;
uint public nextId;

function createEvent(string memory name,uint date,uint price,uint ticketCount) external
{
   require(date>block.timestamp,"You can organise it for future");
   require(ticketCount>0,"plzz create event more than 0");
   events[nextId]=Event(msg.sender,name,date,price,ticketCount,ticketCount);
   nextId++;


}

function buyTicket (uint id,uint quantity)external payable {
   require(events[id].date!=0,"this events does not exist");
   require(block.timestamp<events[id].date,"event has passed");
Event storage _event=events[id];
require(msg.value==(_event.price*quantity),"Ethere is not enough");
require(_event.ticketRemain>=quantity,"Not enought tickets");
_event.ticketRemain -=quantity;

tickets[msg.sender][id]+=quantity;


}
function transferTicket(uint id,uint quantity,address to)external {
      require(events[id].date!=0,"this events does not exist");
   require(block.timestamp<events[id].date,"event has passed");
   require(tickets[msg.sender][id]>=quantity,"You do not have enough tickets");
   tickets[msg.sender][id]-=quantity;
   tickets[to][id]+=quantity;
}
}
