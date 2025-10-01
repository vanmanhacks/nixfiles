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
    allowedTCPPorts = [
      # Ports open for inbound connections.
      # Limit these to reduce the attack surface.

        #22 # SSH – Keep open only if you need remote access.
         # To change the SSH port in NixOS:
         # services.openssh.ports = [ 2222 ];
         # Update this list to match the new port.

      # 53  # DNS – Only if running a public DNS server.
      # 80  # HTTP – Only if hosting a website.
      # 443 # HTTPS – Only if hosting a secure website.
    ];
    allowedUDPPorts = [
      # Ports open for inbound UDP traffic.
      # Most NixOS workstations won't need any here.

      # 53 # DNS – Only if running a public DNS server.
    ];
  };
}

