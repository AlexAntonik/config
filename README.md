### **NixOS dotfiles**

<!-- HOSTS_START -->
## Hosts

![Eval Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/AlexAntonik/config/main/.github/badges/summary.json)

| Host | Status |
|------|--------|
| `asus` | ![](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/AlexAntonik/config/main/.github/badges/asus.json) |
| `default` | ![](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/AlexAntonik/config/main/.github/badges/default.json) |
| `dell` | ![](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/AlexAntonik/config/main/.github/badges/dell.json) |
| `swprod` | ![](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/AlexAntonik/config/main/.github/badges/swprod.json) |
<!-- HOSTS_END -->

#### Requirements

- NixOS
- EFI partition ≥ 512MB

#### Installation

Install git,curl:
```bash
nix-shell -p git curl
```

Run install script:
```bash
sh <(curl -L https://raw.githubusercontent.com/AlexAntonik/config/refs/heads/master/install.sh)
```

<div align="center">
Made with ❤️ using NixOS  

Inspired by [EmergentMind](https://github.com/EmergentMind/nix-config) [Mic92](https://github.com/Mic92/dotfiles) [Zaney](https://gitlab.com/Zaney/zaneyos) [vic](https://github.com/vic/vix) [Goxore](https://github.com/Goxore/nixconf)
</div>
