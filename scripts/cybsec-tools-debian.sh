#!/bin/bash

#go
sudo apt-get update
sudo apt-get install -y golang-go chromium

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

