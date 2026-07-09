#!/bin/bash

# > DEPENDENCIAS

sudo dnf upgrade -y
sudo dnf install golang-go chromium @development-tools ruby-devel snapd gcc gcc-c++ make libcurl-devel git ca-certificates python3 python3-pip lynx -y
sudo systemctl start snapd.service
sudo mkdir -p /opt/wordlists
sudo dnf install -y

# > RECONOCIMIENTO

sudo dnf install -y nmap dnsenum whatweb
#sublist3r assetfinder wappalyzer netdiscover

# theHarvester
sudo git clone https://github.com/laramies/theHarvester.git /opt/theHarvester
sudo chown -R $USER:$USER /opt/theHarvester
uv tool install --reinstall /opt/theHarvester

# recon-ng
sudo git clone https://github.com/lanmaster53/recon-ng.git /opt/recon-ng
sudo chown -R $USER:$USER /opt/recon-ng
uv --directory /opt/recon-ng venv
uv --directory /opt/recon-ng pip install -r REQUIREMENTS
sudo tee /usr/local/bin/recon-ng >/dev/null <<'EOF'
#!/bin/bash
exec uv run --directory /opt/recon-ng ./recon-ng "$@"
EOF
sudo chmod +x /usr/local/bin/recon-ng

sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
sudo GOBIN=/usr/local/bin go install github.com/mmarting/resolvalid@latest
sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest

git clone https://github.com/blechschmidt/massdns.git /tmp/massdns
cd /tmp/massdns && make
sudo mv /tmp/massdns/bin/massdns /usr/bin/massdns
rm -fr /tmp/massdns
cd $HOME

sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt -O /opt/wordlists/domains.txt

git clone https://github.com/vortexau/dnsvalidator.git /tmp/dnsvalidator
cd /tmp/dnsvalidator
sudo python3 /tmp/dnsvalidator/setup.py install
pip install -r /tmp/dnsvalidator/requirements.txt
cd $HOME
sudo rm -fr /tmp/dnsvalidator

git clone https://github.com/Viralmaniar/MurMurHash.git /tmp/murmurhash
pip install -r /tmp/murmurhash/requirements.txt
sudo mv /tmp/murmurhash/MurMurHash.py /usr/bin/murmurhash
sudo sed -i '1s/^/#!\/usr\/bin\/env python\n/' /usr/bin/murmurhash
sudo chmod +x /usr/bin/murmurhash
rm -rf /tmp/murmurhash

git clone https://github.com/Josue87/AnalyticsRelationships.git /tmp/analytics
pip install -r /tmp/analytics/Python/requirements.txt
sudo mv /tmp/analytics/Python/analyticsrelationships.py /usr/bin/analyticsrelationships
sudo chmod +x /usr/bin/analyticsrelationships
sudo sed -i '1s/^/#!\/usr\/bin\/env python\n/' /usr/bin/analyticsrelationships
rm -fr /tmp/analytics

git clone https://github.com/UnaPibaGeek/ctfr.git /tmp/ctfr
pip install -r /tmp/ctfr/requirements.txt
sudo mv /tmp/ctfr/ctfr.py /usr/bin/ctfr
sudo chmod +x /usr/bin/ctfr
rm -fr /tmp/ctfr

sudo GOBIN=/usr/local/bin go install github.com/lc/gau/v2/cmd/gau@latest
sudo GOBIN=/usr/local/bin go install github.com/tomnomnom/unfurl@latest
sudo GOBIN=/usr/local/bin go install -v github.com/owasp-amass/amass/v4/...@master
sudo GOBIN=/usr/local/bin go install github.com/glebarez/cero@latest

# dnsrecon
sudo git clone https://github.com/darkoperator/dnsrecon.git /opt/dnsrecon
sudo chown -R $USER:$USER /opt/dnsrecon
uv tool install --reinstall /opt/dnsrecon

# CAPTURA DE TRÁFICO

sudo dnf install -y wireshark tcpdump ettercap python3-scapy netcat socat
#mitmf

# > SEGURIDAD WEB
#burp commix nosqlmap arjun ghauri

# Escáneres y fuzzing
sudo dnf install -y nikto gobuster ffuf wfuzz

python3 -m venv ~/.venvs/dirsearch
. ~/.venvs/dirsearch/bin/activate
python -m pip install --upgrade pip
python -m pip install "git+https://github.com/maurosoria/dirsearch.git"
dirsearch --version

sudo git clone https://github.com/sqlmapproject/sqlmap.git /opt/sqlmap-dev
sudo chmod +x /opt/sqlmap-dev/sqlmap.py
sudo ln -sf /opt/sqlmap-dev/sqlmap.py /usr/local/bin/sqlmap

gem install wpscan

sudo git clone https://github.com/s0md3v/XSStrike.git /opt/xsstrike
sudo chmod +x /opt/xsstrike/xsstrike.py
sudo ln -sf /opt/xsstrike/xsstrike.py /usr/local/bin/xsstrike

sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/katana/cmd/katana@latest
sudo GOBIN=/usr/local/bin go install github.com/projectdiscovery/httpx/cmd/httpx@latest
sudo GOBIN=/usr/local/bin go install github.com/sensepost/gowitness@latest

# EyeWitness
sudo git clone https://github.com/RedSiege/EyeWitness.git /opt/EyeWitness
sudo chown -R $USER:$USER /opt/EyeWitness
uv --directory /opt/EyeWitness venv --seed
uv --directory /opt/EyeWitness pip install -r setup/requirements.txt
sudo tee /usr/local/bin/eyewitness > /dev/null << 'EOF'
#!/bin/bash
exec uv run --directory /opt/EyeWitness python Python/EyeWitness.py "$@"
EOF
sudo chmod +x /usr/local/bin/eyewitness

sudo GOBIN=/usr/local/bin go install github.com/MyCode83/godirb@latest
sudo GOBIN=/usr/local/bin go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# > EXPLOTACION

sudo dnf install -y python3-impacket

curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >msfinstall &&
  chmod 755 msfinstall &&
  ./msfinstall

sudo snap install searchsploit
#beef crackmapexec netexec ligolo-ng chisel sshuttle

# > CRACKING Y FUERZA BRUTA

sudo dnf install -y john hashcat hydra medusa hashid

git clone https://github.com/crunchsec/crunch.git /tmp/crunch
cd /tmp/crunch && make
sudo mv /tmp/crunch /opt/crunch
sudo chmod +x /opt/crunch/crunch
sudo ln -sf /opt/crunch/crunch /usr/local/bin/crunch
#cewl cupp

# > REDES INALAMBRICAS

sudo dnf install -y aircrack-ng reaver

# > INGENIERIA INVERSA

sudo dnf install -y radare2
#ghidra strings ltrace strace pwndbg

# > FORENSE

sudo dnf install -y foremost binwalk steghide yara
#autopsy volatility exiftool bulk_extractor

# > UTILIDADES

sudo dnf install -y tor torsocks proxychains
