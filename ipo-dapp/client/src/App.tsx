import { PetraWallet } from "petra-plugin-wallet-adapter";
import { AptosWalletAdapterProvider } from "@aptos-labs/wallet-adapter-react";
// replace with the actual wallet adapter library

import { useState, useEffect } from 'react';
import { WalletSelector } from "@aptos-labs/wallet-adapter-ant-design";
import { Layout, Row, Col, Button, Spin, List, Input, Checkbox } from "antd";
import { CheckboxChangeEvent } from "antd/es/checkbox";

import "@aptos-labs/wallet-adapter-ant-design/dist/index.css";
import { Aptos } from "@aptos-labs/ts-sdk";
import {
  useWallet,
  InputTransactionData,
} from "@aptos-labs/wallet-adapter-react";

export const aptos = new Aptos();
const App: React.FC = () => {
  const wallet = useWallet(); // replace with the actual hook from your wallet adapter library
  const [startDate, setStartDate] = useState<number>(0);
  const [endDate, setEndDate] = useState<number>(0);
  const [pricePerShare, setPricePerShare] = useState<number>(0);
  const [totalShares, setTotalShares] = useState<number>(0);
  const [ipoName, setIPOName] = useState<string>('');

  const createIPO = async () => {
    try {
      // Replace the following lines with actual SDK calls
      const result = await sdk.createIPO({
        start_date: startDate,
        end_date: endDate,
        price_per_share: pricePerShare,
        total_shares: totalShares,
        name: ipoName,
      });

      console.log('IPO created:', result);
    } catch (error) {
      console.error('Error creating IPO:', error);
    }
  };

  return (
    <div>
      {wallet.connected ? (
        <div>
          <h1>Welcome,</h1>
          <div>
            <label>Start Date:</label>
            <input type="number" value={startDate} onChange={(e) => setStartDate(Number(e.target.value))} />
          </div>
          <div>
            <label>End Date:</label>
            <input type="number" value={endDate} onChange={(e) => setEndDate(Number(e.target.value))} />
          </div>
          <div>
            <label>Price per Share:</label>
            <input type="number" value={pricePerShare} onChange={(e) => setPricePerShare(Number(e.target.value))} />
          </div>
          <div>
            <label>Total Shares:</label>
            <input type="number" value={totalShares} onChange={(e) => setTotalShares(Number(e.target.value))} />
          </div>
          <div>
            <label>IPO Name:</label>
            <input type="text" value={ipoName} onChange={(e) => setIPOName(e.target.value)} />
          </div>
          <button onClick={createIPO}>Create IPO</button>
        </div>
      ) : (
        <div>
          <h1>Please connect your wallet</h1>
          {/* Add wallet connection button or component here */}
        </div>
      )}
    </div>
  );
};

export default App;
