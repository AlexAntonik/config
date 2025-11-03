### **NixOS Configuration**

#### Requirements

- NixOS with GPT partition table
- UEFI boot
- EFI partition ≥ 512MB

#### Installation

Install dependencies:
```bash
nix-shell -p git curl
```

Run installer:
```bash
sh <(curl -L https://raw.githubusercontent.com/AlexAntonik/config/refs/heads/master/install.sh)
```

The script will guide you through setup and prompt you to configure hardware modules in `~/config/hosts/<hostname>/hardware.nix`

#### Aliases

```bash
fr   # Rebuild system
fu   # Update flake
ncg  # Clean old generations
```

<div align="center">
Made with ❤️ using NixOS  

Inspired by [EmergentMind](https://github.com/EmergentMind/nix-config) [Mic92](https://github.com/Mic92/dotfiles) [ZaneyOS](https://gitlab.com/Zaney/zaneyos)
</div>
