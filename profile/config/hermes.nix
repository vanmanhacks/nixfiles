{ pkgs, ... }:

{
  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
    # extraDependencyGroups = [ "messaging" ];

    environmentFiles = [ "/persist/passwords/hermes_env" ];

    documents = {
      "USER.md" = ./hermes-USER.md;
    };

    settings = {
      model = {
        default = "openrouter/nousresearch/hermes-3-llama-3.1-70b";
        # base_url = "https://openrouter.ai/api/v1";
      };
      agent = {
        max_turns = 60;
        verbose = false;
      };
      toolsets = [ "all" ];
      terminal = {
        backend = "local";
      };
    };

    mcpServers = {
      searxng_search = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [ "-y" "@modelcontextprotocol/server-searxng" ];
        env = {
          SEARXNG_API_URL = "http://macnix-tailscale:8080";
        };
      };

      crawl4ai_scraper = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [ "-y" "@modelcontextprotocol/server-crawl4ai" ];
        env = {
          CRAWL4AI_API_URL = "http://macnix-tailscale:11225";
        };
      };

      # local_filesystem = {
      #   command = "${pkgs.nodejs}/bin/npx";
      #   args = [
      #     "-y"
      #     "@modelcontextprotocol/server-filesystem"
      #     "/home/vanmanhacks/Projects/HermesAgent/osint_reports"
      #   ];
      # };
    };
  };
}
