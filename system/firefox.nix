{ pkgs, ... }:

let
  # Check about:support for extension/add-on ID strings.
  extensions = [
    "ATBC@EasonWong" # Adaptive tabbar color
    "addon@darkreader.org"
    "uBlock0@raymondhill.net" # uBlock Origin
    "myallychou@gmail.com" # unhook youtube
  ];
in
{
  environment.etc."firefox/profile-userchrome.sh".text = ''
    for d in $HOME/.mozilla/firefox/*.default*; do
      mkdir -p "$d/chrome"
      ln -sf /etc/firefox/userChrome.css "$d/chrome/userChrome.css"
    done
  '';

  environment.loginShellInit = ''
    [ -f /etc/firefox/profile-userchrome.sh ] && sh /etc/firefox/profile-userchrome.sh
  '';

  environment.etc."firefox/userChrome.css".text = ''

    .titlebar-buttonbox-container .titlebar-close {
      display: none !important;
    }

    #TabsToolbar #firefox-view-button {
      display: none !important;
    }

    #statuspanel {
      display: none;
    }

    #tabbrowser-tabs {
      border-inline-start: none !important;
    }

    .titlebar-spacer[type="pre-tabs"],
    .titlebar-spacer[type="post-tabs"] {
      display: none !important;
      width: 5px !important;
    }
  '';

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    languagePacks = [
      "en-US"
      "ru"
    ];

    # Check about:policies#documentation for options.
    policies = {
      #### DEBLOAT ###
      DisableFirefoxStudies = true;
      DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true;
      UserMessaging = {
        ExtensionRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };

      #### SECURITY ###
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = true;
      HttpsOnlyMode = "force_enabled";
      SSLVersionMin = "tls1.2";
      PostQuantumKeyAgreementEnabled = true;
      HttpAllowlist = [
        "http://localhost"
        "http://127.0.0.1"
      ];

      #### PRIVACY ###
      DisableTelemetry = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      NetworkPrediction = false;

      SearchEngines = {
        Remove = [
          "Amazon.com"
          "DuckDuckGo"
          "eBay"
          "Bing"
          "Ecosia"
          "Wikipedia"
          "Perplexity"
        ];
        Add = [
          {
            "Name" = "Wikipedia";
            "URLTemplate" = "https://en.wikipedia.org/wiki/Special:Search?go=Go&search={searchTerms}";
            "IconURL" = "https://en.wikipedia.org/favicon.ico";
            "Alias" = "wiki";
          }
        ];
        Default = "Google.com";
      };
      SearchSuggestEnabled = true;

      ExtensionSettings = builtins.listToAttrs (
        builtins.map (id: {
          name = id;
          value = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
            installation_mode = "force_installed";
          };
        }) extensions
      );
    };

    preferences = {
      #### TWEAKS ####
      "app.normandy.first_run" = false;
      "browser.ctrlTab.recentlyUsedOrder" = true;
      "devtools.accessibility.enabled" = false;
      "browser.link.open_newwindow" = true;
      "browser.search.widget.inNavBar" = true;
      "browser.bookmarks.addedContextMenuItem" = false;
      "browser.startup.homepage" = "about:newtab";
      "browser.tabs.loadInBackground" = false;
      "browser.tabs.allowTabDetach" = false;
      "general.useragent.locale" = "en-US";
      # Alt-menu disable
      "ui.key.menuAccessKeyFocuses" = false;
      "general.autoScroll" = true;
      "browser.translations.automaticallyPopup" = false;

      #### UI ####
      # for css tweaks
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      # disable overscroll at the top of opened website or bottom
      "apz.overscroll.enabled" = false;

      "extensions.activeThemeID" = "{9631ec37-35f2-4719-815e-2f84ff28b901}";

      # disable all the annoying quick actions
      "browser.urlbar.quickactions.enabled" = false;
      "browser.urlbar.quickactions.showPrefs" = false;
      "browser.urlbar.shortcuts.quickactions" = false;
      "browser.urlbar.suggest.quickactions" = false;

      # enable vetical tabs and navbar items
      "sidebar.verticalTabs" = true;
      "sidebar.visibility" = "hide-sidebar";
      "sidebar.main.tools" = "aichat,history";
      "sidebar.revamp" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.uidensity" = 1; # compact nav bar
      "browser.uiCustomization.horizontalTabstrip" = "[\"tabbrowser-tabs\",\"new-tab-button\"]";
      "browser.uiCustomization.state" = builtins.toJSON {
        placements = {
          widget-overflow-fixed-list = [ ];
          unified-extensions-area = [
            "_f209234a-76f0-4735-9920-eb62507a54cd_-browser-action"
          ];
          nav-bar = [
            "sidebar-button"
            "back-button"
            "stop-reload-button"
            "forward-button"
            "vertical-spacer"
            "urlbar-container"
            "vertical-spacer"
            "history-panelmenu"
            "unified-extensions-button"
            "downloads-button"
            "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
            "new-tab-button"
            "fxa-toolbar-menu-button"
          ];
          toolbar-menubar = [ "menubar-items" ];
          TabsToolbar = [
            "tabbrowser-tabs"
            "new-tab-button"
          ];
          vertical-tabs = [ "tabbrowser-tabs" ];
        };
        seen = [
          "save-to-pocket-button"
          "developer-button"

          # Extensions
          "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
          "ublock0_raymondhill_net-browser-action"
          "myallychou_gmail_com-browser-action"
          "addon_darkreader_org-browser-action"
          "_f209234a-76f0-4735-9920-eb62507a54cd_-browser-action"
        ];
        dirtyAreaCache = [
          "nav-bar"
          "vertical-tabs"
          "PersonalToolbar"
          "unified-extensions-area"
          "toolbar-menubar"
          "TabsToolbar"

        ];
        currentVersion = 21;
        newElementCount = 22;
      };

      "browser.newtabpage.pinned" = builtins.toJSON [
        {
          url = "https://www.youtube.com";
          label = "Youtube";
          baseDomain = "youtube.com";
        }
        {
          url = "https://www.chess.com/";
          label = "Chess";
        }
        {
          url = "https://translate.google.by/";
          label = "Translate";
        }
        {
          url = "https://myfin.by/currency/usd";
          label = "MyFin";
        }
        {
          url = "https://github.com/AlexAntonik";
          label = "GitHub";
        }
        {
          url = "https://coinmarketcap.com/";
          label = "CMC";
        }
        {
          url = "http://localhost:8384/#";
          label = "Syncthing";
        }
        {
          url = "https://login.tailscale.com/admin/machines";
          label = "Tailscale";
        }
      ];

      #### FEATURES ###
      "layout.spellcheckDefault" = 1;
      # Use the systems native filechooser portal
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "media.webrtc.camera.allow-pipewire" = true;
      "browser.download.always_ask_before_handling_new_types" = true;

      #### DEBLOAT ###
      "browser.discovery.enabled" = false;
      "browser.topsites.contile.enabled" = false;
      # disable Firefox Suggest features
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.urlbar.showSearchSuggestionsFirst" = false;
      "browser.urlbar.suggest.searches" = true;
      "browser.urlbar.suggest.pocket" = false;
      "browser.urlbar.sponsoredTopSites" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "browser.urlbar.suggest.sponsored" = false;
      "browser.urlbar.trending.featureGate" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.topSitesRows" = 2;
      "browser.newtabpage.activity-stream.feeds.snippets" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
      "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
      "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.system.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

      #### PRIVACY ###
      # disable preloading websites when hovering over links
      "network.http.speculative-parallel-limit" = 0;
      "network.dns.disablePrefetchFromHTTPS" = true;
      # disable connecting to bookmarks when hovering over them
      "browser.places.speculativeConnect.enabled" = false;
      "privacy.globalprivacycontrol.enabled" = true;
      "privacy.fingerprintingProtection" = true;
      "privacy.bounceTrackingProtection.enabled" = true;

      # State partitoning
      "privacy.partition.network_state" = true;
      "privacy.partition.serviceWorkers" = true;
      "privacy.partition.bloburl" = true;

      "browser.contentblocking.category" = "standard";
      "extensions.pocket.enabled" = false;
      # store media in cache only on private browsing
      "browser.privatebrowsing.forceMediaMemoryCache" = true;
      "network.http.referer.XOriginTrimmingPolicy" = 2;
      # Privacy: Disable CSP reporting
      # https://bugzilla.mozilla.org/show_bug.cgi?id=1964249
      "security.csp.reporting.enabled" = false;

      #### SECURITY ###
      "pdfjs.enableScripting" = false;
      # UNCLEAR
      "signon.formlessCapture.enabled" = false;
      # prevent scripts from moving or resizing windows
      "dom.disable_window_move_resize" = true;
      # Security: Disable remote debugging feature
      # https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16222
      "devtools.debugger.remote-enabled" = false;

      #### SSL ###
      # Security: Disable TLS1.3 0-RTT as key encryption may not be forward secret
      # https://github.com/tlswg/tls13-spec/issues/1001
      "security.tls.enable_0rtt_data" = 2;
      # Security: Enable CRLite to ensure that revoked certificates are detected
      "security.pki.crlite_mode" = 2;
      # Security: Display more information on Insecure Connection warning pages
      # Test: https://badssl.com
      "browser.xul.error_pages.expert_bad_cert" = true;
    };
  };
}
