### Hosts
<!-- HOSTS_START -->
![asus](https://badgen.net/badge/asus/passing/green) ![base](https://badgen.net/badge/base/passing/green) ![dell](https://badgen.net/badge/dell/passing/green) ![swprod](https://badgen.net/badge/swprod/failing/red) 
<!-- HOSTS_END -->

#### Requirements

- NixOS
- EFI partition >= 512MB

#### Installation

Replace `<hostname>` with new machine's hostname throughout.

```bash
nix-shell -p git
git clone https://github.com/AlexAntonik/config.git ~/config
mkdir -p ~/config/hosts/<hostname>
cp ~/config/hosts/base/*.nix ~/config/hosts/<hostname>/
mv ~/config/hosts/<hostname>/base.nix ~/config/hosts/<hostname>/<hostname>.nix
```

Edit `~/config/hosts/<hostname>/<hostname>.nix` , `~/config/hosts/<hostname>/hardware.nix`.

Generate hardware config, then rebuild:

```bash
sudo nixos-generate-config --show-hardware-config | sudo tee ~/config/hosts/<hostname>/hardware-gen.nix
sudo nixos-rebuild switch --flake ~/config/#<hostname>
```

---
Inspired by [EmergentMind](https://github.com/EmergentMind/nix-config), [Mic92](https://github.com/Mic92/dotfiles), [Zaney](https://gitlab.com/Zaney/zaneyos), [vic](https://github.com/vic/vix), [Goxore](https://github.com/Goxore/nixconf)
