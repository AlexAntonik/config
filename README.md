### Hosts
<!-- HOSTS_START -->
![asus](https://badgen.net/badge/asus/passing/green) ![base](https://badgen.net/badge/base/passing/green) ![dell](https://badgen.net/badge/dell/passing/green) ![swprod](https://badgen.net/badge/swprod/failing/red) 
<!-- HOSTS_END -->

#### Requirements

- NixOS
- EFI partition ≥ 512MB

#### Installation

Install git:

```bash
nix-shell -p git
```

Clone and run the install script:

```bash
git clone https://github.com/AlexAntonik/config.git
cd config
./install.sh
```

---
Inspired by [EmergentMind](https://github.com/EmergentMind/nix-config), [Mic92](https://github.com/Mic92/dotfiles), [Zaney](https://gitlab.com/Zaney/zaneyos), [vic](https://github.com/vic/vix), [Goxore](https://github.com/Goxore/nixconf)
