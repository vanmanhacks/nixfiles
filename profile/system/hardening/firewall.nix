{ ... }: {
  #networking.nftables = {
  #enable = true;

  #ruleset = ''
  #table inet filter {
  #chain output {
  #type filter hook output priority 0; policy accept;

  # Allow localhost DNS for dnscrypt-proxy2
  #ip daddr 127.0.0.1 udp dport 53 accept
  #ip6 daddr ::1 udp dport 53 accept
  #ip daddr 127.0.0.1 tcp dport 53 accept
  #ip6 daddr ::1 tcp dport 53 accept

  # Allow dnscrypt-proxy2 to talk to upstream servers
  # Replace <DNSCRYPT-UID> with:
  # ps -o uid,user,pid,cmd -C dnscrypt-proxy
  #meta skuid <DNSCRYPT-UID> udp dport { 443, 853 } accept
  #meta skuid <DNSCRYPT-UID> tcp dport { 443, 853 } accept

  # Block all other outbound DNS
  #udp dport { 53, 853 } drop
  #tcp dport { 53, 853 } drop
  #}
  #}
  #'';
  #};
  networking.firewall = {
    enable = true;
    logRefusedPackets = true;
    logRefusedConnections = true;
    interfaces."tun0".allowedTCPPortRanges = [{ from = 0; to = 65535; }];
    interfaces."tun0".allowedUDPPortRanges = [{ from = 0; to = 65535; }];
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };
}

