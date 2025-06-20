## 📥 Installation

> **Requirements:**  
> - You must have installed NixOS using a GPT partition table and booted with UEFI.  
> - Your EFI/boot partition should be at least **256MB** (ideally **512MB**).

1. **Install required tools:**

   ```bash
   nix-shell -p git curl
   ```

2. **Run the installation script:**

   ```bash
   sh <(curl -L https://raw.githubusercontent.com/AlexAntonik/config/refs/heads/master/install.sh)
   ```

   > Follow the instructions the script provides.

3. **Edit your hardware drivers:**
   - Open `/home/<your-username>/config/hosts/default/drivers.nix`
   - Uncomment and configure the modules for your hardware as described in the file.

4. **Run the installation script again to finish setup:**

   ```bash
   sh <(curl -L https://raw.githubusercontent.com/AlexAntonik/config/refs/heads/master/install.sh)
   ```

---

## ⚡ Quick Commands

| Command | Description |
|---------|-------------|
| `fr`  | Rebuild flake (`rebuild switch --flake`) |
| `fu`  | Update flake (`nix flake update`) |
| `ncg` | Clean old generations (`nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot`) |

---

<div align="center">
Made with ❤️ using NixOS  

Inspired by [ZaneyOS](https://gitlab.com/Zaney/zaneyos)
</div>


