

# 🚀 CodeCampusOS

**CodeCampusOS** is a custom Linux distribution based on **Ubuntu 24**, designed especially for **CSE/IT students** and **beginner developers**. It provides a fully pre-configured development environment so users can start coding immediately—no manual setup required.

---

## 🎯 Purpose

CodeCampusOS aims to simplify the learning experience for students by offering a clean, lightweight, and productivity-focused Linux environment optimized for:

* Learning programming fundamentals
* Academic lab usage
* Real-world software development projects

---

## ✨ Features

* ✅ Based on **Ubuntu 24**
* ✅ Lightweight **GNOME desktop environment**
* ✅ Ready-to-use development setup out of the box
* ✅ Beginner-friendly tools and configurations
* ✅ Consistent and reproducible environment for college labs

---

## 🛠️ Pre-Installed Tools

### Programming Languages & Compilers

* C / C++
* Java
* Python
* Rust
* Node.js

### Developer Tools

* Git
* Docker
* Visual Studio Code
* Neovim
* Tmux
* Ghostty Terminal

### Additional Tools

* Modern CLI utilities
* Preconfigured dotfiles
* Learning-friendly documentation

---

## 🖥️ Desktop & Customization

* Clean and minimal **GNOME** setup
* Productivity-focused UI
* Optimized workflows for students
* Curated dotfiles for better developer experience

---

## 🧑‍🎓 Who Is This For?

* CSE / IT students
* Beginner software developers
* College and university computer labs
* Anyone looking for a ready-made Linux development environment

---

## 📦 Build CodeCampusOS ISO

Follow these steps to build the CodeCampusOS ISO using **Cubic**:

1. Download the **Ubuntu 24 ISO**
2. Open **Cubic**
3. Select the Ubuntu 24 ISO
4. Open the **Cubic terminal**
5. Install Git:

   ```bash
   sudo apt install git
   ```
6. Clone the repository:

   ```bash
   git clone https://github.com/CodeCompasss/code_campus_os.git
   ```
7. Navigate into the repository and make the setup script executable:

   ```bash
   chmod +x setup.sh
   ```
8. Run the setup script:

   ```bash
   ./setup.sh
   ```
9. Wait for the setup to complete
10. in the boot section remove the --quiet-splash 
11. Build and generate the final ISO using Cubic

---

## 📚 Documentation

Step-by-step guides and learning resources are included to help beginners understand tools, workflows, and best practices.

[cubic_iso_guide](https://shadil-rayyan.github.io/cubic_iso_guide/)

---

## 🤝 Contributing

Contributions are welcome!
Feel free to open issues or submit pull requests to improve CodeCampusOS.

---

## 📄 License

This project is licensed under the **MIT License**.

