<div align="center">

# NixOS Configuration

**And some dotFiles**

**Inspired by [ZaneyOS](https://gitlab.com/Zaney/zaneyos)** 🙏

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

## ⚡ Quick Commands

| Command | Description | Original Command |
|---------|-------------|------------------|
| `fr` | 🔄 Rebuild system | `rebuild switch --flake` |
| `fu` | 📦 Update flake | `nix flake update` |
| `ncg` | 🧹 Clean old generations | `nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot` |
| `su` | 💾 Run installation script | `sh <(curl -L https://raw.githubusercontent.com/AlexAntonik/config/refs/heads/master/install.sh)` |

---

<div align="center">
Made with ❤️ using NixOS
</div>
