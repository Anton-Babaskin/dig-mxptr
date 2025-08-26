# mxptr-resolver

A powerful utility for bulk resolving domains, subdomains, and IPs into their corresponding MX, A/AAAA, and PTR records. Ideal for configuring Postfix/Postgrey whitelists, monitoring infrastructure, and diagnosing email delivery issues.

---

## ✨ Features

- **Input Flexibility**: Accepts a list of domains, hosts, and IP addresses (one per line).
- **Domain Resolution**: Resolves MX records, their associated IP addresses, and PTR records.
- **Host Resolution**: Retrieves A/AAAA records and PTR records for individual hosts.
- **IP Resolution**: Determines PTR hostnames for IP addresses.
- **Output**: Saves results in a clean, tabular `.txt` file with columns: `Domain`, `Role`, `Target`, `IP`, `PTR`.

---

## 🚀 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/mxptr-resolver.git
   ```
2. Navigate to the project directory:
   ```bash
   cd mxptr-resolver
   ```
3. Make the script executable:
   ```bash
   chmod +x mxptr-resolver.sh
   ```

---

## 🛠️ Usage

1. **Prepare Input File**: Create a file (e.g., `domains.txt`) with a list of domains, hosts, or IPs, one per line:
   ```
   isbank.com.tr
   mail.isbank.com.tr
   212.174.23.15
   akbank.com
   ```

2. **Run the Script**:
   ```bash
   ./mxptr-resolver.sh
   ```
   - Default input file: `domains.txt`
   - Default output file: `resolved_whitelist.txt`

3. **Custom Input/Output**: Specify your own input and output files:
   ```bash
   ./mxptr-resolver.sh input.txt output.txt
   ```

4. **View Results**: Check the output file:
   ```bash
   cat resolved_whitelist.txt
   ```

---

## 📊 Example Output

```plaintext
# Generated: 2025-08-26 12:45:00 +0300
Domain              Role    Target                IP             PTR
isbank.com.tr       MX      mail.isbank.com.tr    212.174.x.x    mail.isbank.com.tr
mail.isbank.com.tr  Host    mail.isbank.com.tr    212.174.x.x    mail.isbank.com.tr
212.174.23.15       IP      212.174.23.15         212.174.23.15  mail.isbank.com.tr
```

---

## 📋 Requirements

- **bash**: Standard shell environment.
- **dnsutils**: Provides `dig` and `host` commands.
  Install on Debian/Ubuntu:
  ```bash
  sudo apt-get install dnsutils -y
  ```

---

## 📜 License

[MIT License](LICENSE) — Feel free to use, modify, and distribute the code as you wish.

---

## 🌟 Contributing

Contributions are welcome! Please submit a pull request or open an issue on [GitHub](https://github.com/yourusername/mxptr-resolver).