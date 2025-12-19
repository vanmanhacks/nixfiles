{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox-bin

    testdisk
    testdisk-qt

    caido-unstable

    wordlists
    payloadsallthethings-unstable

    wafw00f
    tlsx
    sslscan

    whois
    dig
    dnslookup

    mubeng

    asnmap
    findomain
    amass
    subfinder
    gungnir
    assetfinder
    chaos

    dnsx
    alterx

    netcat
    chisel
    netexec

    nmap
    smap
    rustscan
    fingerprintx

    xh
    httpx

    jwt-hack
    jwt-cli

    feroxbuster
    katana
    gau
    arjun
    xnlinkfinder
    waymore
    gowitness
    cewl
    cewler
    ffuf
    wfuzz
    kiterunner

    hakrawler
    gospider

    nuclei
    nuclei-templates
    cent
    sqlmap
    dalfox
    jwt-hack
    apkleaks
    trufflehog
  ];
}
