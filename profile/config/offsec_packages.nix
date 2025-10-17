{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    caido-unstable

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

    nmap
    smap
    rustscan
    fingerprintx

    xh
    httpx

    feroxbuster
    katana
    gau
    arjun
    xnlinkfinder
    waymore
    gowitness
    cewler
    ffuf
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
