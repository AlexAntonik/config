<div align="center">

## NixOS Configuration

</div>

## 📥 Installation

Get the required tools:

```bash
nix-shell -p git curl
```

Run the installation:

```bash
sh <(curl -L https://raw.githubusercontent.com/AlexAntonik/config/refs/heads/master/install.sh)
```

> 🛠️ **After running the script for the first time, you must edit `/home/<your-username>/config/hosts/default/drivers.nix` to up your hardware modules.  
> Only after that, run the installation script again to finish the setup!**

## ⚡ Quick Commands

| Command | Description | Original Command |
|---------|-------------|------------------|
| `fr` | 🔄 Rebuild flake| `rebuild switch --flake` |
| `fu` | 📦 Update flake | `nix flake update` |
| `ncg` | 🧹 Clean old generations | `nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot` |
| `su` | 💾 Run installation script | `sh <(curl -L https://raw.githubusercontent.com/AlexAntonik/config/refs/heads/master/install.sh)` |

---

<div align="center">
Made with ❤️ using NixOS

**Inspired by [ZaneyOS](https://gitlab.com/Zaney/zaneyos)**
</div>


