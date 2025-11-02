# 🧠 Focus Mode v2.0

> A terminal-based productivity tool that helps you **focus better** by blocking distracting websites like YouTube, Instagram, Reddit, and more — right from your Linux terminal.  
> Add or remove custom websites anytime and toggle Focus Mode with a single command.

---

## 🏷️ Project Overview

FocusMode temporarily modifies your `/etc/hosts` file to block distracting sites by redirecting them to `127.0.0.1`.  
It automatically backs up and restores your original configuration once you disable Focus Mode.

Perfect for:
- 🧑‍💻 Developers
- 🎓 Students
- ✍️ Writers
- ⚡ Anyone who wants to stay focused

---

## ✨ Features

- 🚫 Blocks common distracting websites  
- ➕ Add your own URLs anytime  
- 🗑️ Remove blocked sites easily  
- 💾 Saves list persistently in `~/.focus_blocklist`  
- 🔓 One command to enable or disable focus mode  
- 🔐 Backs up your `/etc/hosts` automatically  

---

## ⚙️ Installation

```bash
git clone https://github.com/thelinuxpoint/focusmode.git
cd focusmode
chmod +x focusmode.sh
sudo cp focusmode.sh /usr/local/bin/focusmode
```

---

## 🚀 Usage

Run Focus Mode with:
```bash
sudo focusmode
```

### 📋 Menu Options

```
╔══════════════════════════════════════╗
║        🧠 Focus Mode Tool v2.0       ║
╚══════════════════════════════════════╝
1) Enable Focus Mode
2) Disable Focus Mode
3) View Block List
4) Add Custom Site
5) Remove Custom Site
6) Exit
```

---

## 🧱 How It Works

FocusMode works by redirecting websites to `127.0.0.1` through your `/etc/hosts` file.

When enabled:
```
127.0.0.1 youtube.com
127.0.0.1 instagram.com
127.0.0.1 reddit.com
```

When disabled:
- The original `/etc/hosts` file is **restored** from:
  ```
  /tmp/hosts_focus_backup
  ```

---

## 🧩 Customization

Your custom blocklist is stored in:
```
~/.focus_blocklist
```

You can edit this file manually or through the menu options.

Example:
```
www.youtube.com
twitter.com
reddit.com
chat.openai.com
```

---

## 🧠 Pro Tips

- Run this tool with `sudo` for full functionality.  
- Keep your `~/.focus_blocklist` short and meaningful.  
- Combine with `timer.sh` or `tunes.sh` for the ultimate productivity setup.  

---

## 🧑‍💻 Author

**Prakash Choudhary** — [@TheLinuxPoint](https://github.com/thelinuxpoint)  
📺 YouTube: [The Linux Point](https://youtube.com/@thelinuxpoint)  
📷 Instagram: [@thelinuxpoint](https://instagram.com/thelinuxpoint)

---

## 🧾 License

This project is licensed under the MIT License — feel free to modify and distribute.

---

## ⭐ Support

If FocusMode helps you stay productive:

- 🌟 Give this project a **star**  
- 🐙 Follow me on [GitHub](https://github.com/thelinuxpoint)  
- 💬 Share it with your friends or on Reddit!

---

> “Discipline is choosing between what you want now and what you want most.”  
> — *Abraham Lincoln*
