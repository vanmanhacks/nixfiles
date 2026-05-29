{ pkgs, ... }:

{
  services.hermes-agent = {
    enable = true;

    # ── Declarative config (renders to cli-config.yaml) ──
    config = {
      model = {
        default = "nousresearch/hermes-3-llama-3.1-70b";
        provider = "openrouter";
      };
      terminal = {
        backend = "docker";
        timeout = 180;
        lifetime_seconds = 300;
      };
      # agent = {
      #   max_turns = 60;
      #   reasoning_effort = "medium";
      # };
      memory = {
        memory_enabled = true;
        user_profile_enabled = true;
        memory_char_limit = 2200;
        nudge_interval = 10;
      };
      compression = {
        enabled = true;
        threshold = 0.85;
        summary_model = "google/gemini-flash-latest";
        summary_provider = "openrouter";
      };
      toolsets = [ "all" ];
    };

    # ── Secrets (not in Nix store) ──
    environmentFiles = [
      "/persist/passwords/hermes-env" # ANTHROPIC_API_KEY, TELEGRAM_TOKEN, etc.
    ];

    # ── Non-secret env vars ──
    # environment = {
    #   LLM_MODEL = "nousresearch/hermes-3-llama-3.1-70b";
    # };

    # ── Workspace documents (inline or file paths) ──
    # documents = {
    #   "SOUL.md" = ''
    #     # SOUL.md
    #     You are a sharp, pragmatic AI assistant.
    #   '';
    #   "AGENTS.md" = ''
    #     # AGENTS.md
    #     Read SOUL.md first. Then help the user.
    #   '';
    #   "USER.md" = ''
    #     # USER.md
    #     Name: Your Human
    #   '';
    # Or reference a file:
    # "SOUL.md" = ./documents/SOUL.md;
    # };

    # ── Declarative skills (phase 1) ──
    #   skills = {
    #     bundled.enable = true;
    #     optional = [
    #       "creative/blender-mcp"
    #     ];
    #     custom = {
    #       repo-watch = {
    #         category = "research";
    #         source = ./skills/repo-watch;
    #       };
    #     };
    #   };

    #   # ── MCP servers ──
    mcpServers = {
      context7 = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [ "-y" "@upstash/context7-mcp@latest" ];
      };
      searxng_search = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [ "-y" "@modelcontextprotocol/server-searxng" ];
        env = {
          SEARXNG_API_URL = "http://100.116.141.18:8080";
        };
        tools = { prompts = false; resources = false; };
      };

      # 2. Remote Web Scraper (Scrapes via MacNix Crawl4AI)
      crawl4ai_scraper = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [ "-y" "@modelcontextprotocol/server-crawl4ai" ];
        env = {
          CRAWL4AI_API_URL = "http://100.116.141.18:11225";
        };
        tools = { prompts = false; resources = false; };
      };

      # 3. Local Filesystem Access (To read/write your UEC files)
      local_filesystem = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [ "-y" "@modelcontextprotocol/server-filesystem" "/home/youruser/osint_reports" ];
      };
    };
  };
  # Node.js is required to run the npx MCP wrappers
  extraPackages = with pkgs; [ nodejs ];


}
