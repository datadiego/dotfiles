#!/bin/bash

# dnf
# Reconocimiento
sudo dnf install -y nmap dnsenum whatweb
#theharvester recon-ng sublist3r assetfinder wappalyzer netdiscover

# Captura de tráfico
sudo dnf install -y wireshark tcpdump ettercap ettercap python3-scapy netcat socat
#mitmf

# Web
sudo dnf install -y nikto gobuster ffuf wfuzz 

#dirsearch burp sqlmap wpscan xsstrike commix nosqlmap arjun ghauri

# Explotacion
sudo dnf install -y python3-impacket

#metasploit searchsploit beef crackmapexec netexec ligolo-ng chisel sshuttle

# Cracking
sudo dnf install -y john hashcat hydra medusa hashid

# cewl crunch cupp

# Redes inalambricas
sudo dnf install -y aircrack-ng reaver

# Reversing
sudo dnf install -y radare2 
# ghidra strings ltrace strace pwndbg

# Forensico
sudo dnf install -y foremost binwalk steghide yara

# Utils
sudo dnf install -y tor torsocks proxychains 

#autopsy foremost volatility exiftool bulk_extractor

#go
sudo dnf upgrade -y
sudo dnf install golang-go chromium -y

# Configurar GOBIN para evitar $HOME/go
sudo mkdir -p /opt/wordlists

#mapcidr
sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest

#dnsx
sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest

#MurMurHash
git clone https://github.com/Viralmaniar/MurMurHash.git /tmp/murmurhash
pip install -r /tmp/murmurhash/requirements.txt
sudo mv /tmp/murmurhash/MurMurHash.py /usr/bin/murmurhash
sudo sed -i '1s/^/#!\/usr\/bin\/env python\n/' /usr/bin/murmurhash 
sudo chmod +x /usr/bin/murmurhash
rm -rf /tmp/murmurhash

#massdns
git clone https://github.com/blechschmidt/massdns.git /tmp/massdns
cd /tmp/massdns && make
sudo mv /tmp/massdns/bin/massdns /usr/bin/massdns
rm -fr /tmp/massdns
cd $HOME

#shuffledns
sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt -O /opt/wordlists/domains.txt

#dnsvalidator
git clone https://github.com/vortexau/dnsvalidator.git /tmp/dnsvalidator 
cd /tmp/dnsvalidator
sudo python3 /tmp/dnsvalidator/setup.py install
pip install -r /tmp/dnsvalidator/requirements.txt
cd $HOME
sudo rm -fr /tmp/dnsvalidator

#AnalyticsRelationships
git clone https://github.com/Josue87/AnalyticsRelationships.git /tmp/analytics
pip install -r /tmp/analytics/Python/requirements.txt
sudo mv /tmp/analytics/Python/analyticsrelationships.py /usr/bin/analyticsrelationships
sudo chmod +x /usr/bin/analyticsrelationships
sudo sed -i '1s/^/#!\/usr\/bin\/env python\n/' /usr/bin/analyticsrelationships
rm -fr /tmp/analytics

#cero
sudo GOBIN=/usr/local/bin go install github.com/glebarez/cero@latest

#katana
sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/katana/cmd/katana@latest

#unfurl
sudo GOBIN=/usr/local/bin go install github.com/tomnomnom/unfurl@latest

#ctfr
git clone https://github.com/UnaPibaGeek/ctfr.git /tmp/ctfr
pip install -r /tmp/ctfr/requirements.txt
sudo mv /tmp/ctfr/ctfr.py /usr/bin/ctfr
sudo chmod +x /usr/bin/ctfr
rm -fr /tmp/ctfr

#gau
sudo GOBIN=/usr/local/bin go install github.com/lc/gau/v2/cmd/gau@latest

#amass
sudo GOBIN=/usr/local/bin go install -v github.com/owasp-amass/amass/v4/...@master

#httpx
sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/httpx/cmd/httpx@latest

#gowitness
sudo GOBIN=/usr/local/bin go install github.com/sensepost/gowitness@latest


