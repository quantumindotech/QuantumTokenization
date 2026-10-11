# EVIDENCE OF VERIFICATION - TRISULA QUANTUM TOKENS

> Dokumen ini disiapkan sebagai bukti resmi untuk verifikasi kontrak di BSCScan.
> Dibuat: 11 Oktober 2026 - Depok, Indonesia
> Owner: 0x512Ae495d7182ce0712dff8D5888CFE0D6da2050 / 0x98d28b9cC86185eE2A4652887efE566C6c88fc81

---

## 1. TRISULA QSDC (Quantum Sovereign Digital Carbon / Tokenization)

- **Contract Address:** `0x679EC5162Bb8D2DCCB6B84D741841DEC721915e1`
- **Network:** BNB Smart Chain Mainnet (BSC)
- **BSCScan Link:** https://bscscan.com/address/0x679EC5162Bb8D2DCCB6B84D741841DEC721915e1
- **Token Name:** Quantum Sovereign Digital Tokenization
- **Symbol:** QSDC
- **Decimals:** 18
- **Genesis Supply:** 1,000,000,000 QSDC

### Deployment Settings
- **Compiler Version:** v0.8.20+commit.a1b79de6
- **Optimization:** Yes, 200 runs
- **EVM Version:** paris (default)
- **License:** MIT
- **Constructor:** No arguments (owner hardcoded)
  ```solidity
  constructor() ERC20("Quantum Sovereign Digital Tokenization", "QSDC") 
  ERC20Permit("Quantum Sovereign Digital Tokenization") {
      _transferOwnership(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050);
      _mint(0x512Ae495d7182ce0712dff8D5888CFE0D6da2050, GENESIS_SUPPLY);
  }
