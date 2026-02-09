### **NixOS dotfiles**

<!-- HOSTS_START -->
  ## Hosts

  ![asus](https://badgen.net/badge/asus/passing/green) ![default](https://badgen.net/badge/default/passing/green) ![dell](https://badgen.net/badge/dell/passing/green) ![swprod](https://badgen.net/badge/swprod/passing/green) 
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
