mxptr-resolver
A powerful utility for bulk resolving domains, subdomains, and IPs into their corresponding MX, A/AAAA, and PTR records. Ideal for configuring Postfix/Postgrey whitelists, monitoring infrastructure, and diagnosing email delivery issues.

✨ Features

Input Flexibility: Accepts a list of domains, hosts, and IP addresses (one per line).
Domain Resolution: Resolves MX records, their associated IP addresses, and PTR records.
Host Resolution: Retrieves A/AAAA records and PTR records for individual hosts.
IP Resolution: Determines PTR hostnames for IP addresses.
Output: Saves results in a clean, tabular .txt file with columns: Domain, Role, Target, IP, PTR.


🚀 Installation

Clone the repository:git clone https://github.com/yourusername/mxptr-resolver.git


Navigate to the project directory:cd mxptr-resolver


Make the script executable:chmod +x mxptr-resolver.sh




🛠️ Usage

Prepare Input File: Create a file (e.g., domains.txt) with a list of domains, hosts, or IPs, one per line:
isbank.com.tr
mail.isbank.com.tr
212.174.23.15
akbank.com


Run the Script:
./mxptr-resolver.sh


Default input file: domains.txt
Default output file: resolved_whitelist.txt


Custom Input/Output: Specify your own input and output files:
./mxptr-resolver.sh input.txt output.txt


View Results: Check the output file:
cat resolved_whitelist.txt




📊 Example Output
# Generated: 2025-08-26 12:45:00 +0300
Domain              Role    Target                IP             PTR
isbank.com.tr       MX      mail.isbank.com.tr    212.174.x.x    mail.isbank.com.tr
mail.isbank.com.tr  Host    mail.isbank.com.tr    212.174.x.x    mail.isbank.com.tr
212.174.23.15       IP      212.174.23.15         212.174.23.15  mail.isbank.com.tr


📋 Requirements

bash: Standard shell environment.
dnsutils: Provides dig and host commands.Install on Debian/Ubuntu:sudo apt-get install dnsutils -y




📜 License
MIT License — Feel free to use, modify, and distribute the code as you wish.

🌟 Contributing
Contributions are welcome! Please submit a pull request or open an issue on GitHub.
