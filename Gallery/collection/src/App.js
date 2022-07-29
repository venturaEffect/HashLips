import './App.css';
import {ethers} from "ethers";
import { useState, useEffect } from 'react';
import {GiBoltSpellCast} from "react-icons/gi";

function App() {

  const [account, setAccount] = useState("");

  const initConnection = async () => {
    if(typeof window.ethereum !== "undefined") {
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      console.log(accounts[0]);
      setAccount(accounts[0]);

    } else {
      console.log("Install metamask");
    }
  }

  useEffect(() => {
    initConnection();
  }, []);
  return (
    <div className='page'>
      <div className="header">
        <img src={require('./assets/images/osco-logo-2.jpg')} className="artIcon"/>
        <p>11/15
          <span>
            <GiBoltSpellCast style={{ marginLeft: "5px" }}/>
          </span>
        </p>
        {account == "" ? (
        <button onClick={initConnection} classNAme="button">Connect</button>
        ) : (
        <p>...{account.substring(account.length - 7)}</p>
        )}
      </div>
    </div>
  );
}

export default App;
