{ pkgs, ... }:

let

  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    darkreader
    privacy-badger
    ublock-origin
    unpaywall
    youtube-recommended-videos
  ];

  disableWebRtcIndicator = ''
    #webrtcIndicator {
      display: none;
    }
  '';

  hideWindowCloseButton = ''
    /* Hide the window close (X) button in the titlebar */
    .titlebar-buttonbox-container .titlebar-close {
      display: none !important;
    }
  '';

  moreTabsCss = ''
    #TabsToolbar #firefox-view-button {
      display: none !important;
      # position: absolute !important; # commented style moves the button to the right on close button place
      # top: 0 !important;
      # right: 4px !important;
      # z-index: 1000 !important;
      # margin: 0 !important;
      # height: 100% !important;
      # display: flex !important;
      # align-items: center !important;
      # border-radius: 0 !important;
      # background: transparent !important;
    }
    #tabbrowser-tabs {
      border-inline-start: none !important;
    }
    /* Убрать спейсеры до и после вкладок */
    .titlebar-spacer[type="pre-tabs"], .titlebar-spacer[type="post-tabs"] {
      display: none !important;
      width: 5px !important; /* Корректировка ширины, если потребуется */
    }
  '';

  userChrome =  disableWebRtcIndicator + hideWindowCloseButton + moreTabsCss ;

  # ~/.mozilla/firefox/PROFILE_NAME/prefs.js | user.js
  settings = {
    "app.normandy.first_run" = false;
    "app.shield.optoutstudies.enabled" = false;

    # disable updates (pretty pointless with nix)
    "app.update.channel" = "default";

    "browser.contentblocking.category" = "standard"; # "strict"
    "browser.ctrlTab.recentlyUsedOrder" = true;

    "devtools.accessibility.enabled" = false;

    "browser.bookmarks.addedContextMenuItem" = false;

    "browser.download.useDownloadDir" = false;
    "browser.download.viewableInternally.typeWasRegistered.svg" = true;
    "browser.download.viewableInternally.typeWasRegistered.webp" = true;
    "browser.download.viewableInternally.typeWasRegistered.xml" = true;

    "browser.link.open_newwindow" = true;

    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "browser.newtabpage.activity-stream.topSitesRows"	=2;    
    "browser.newtabpage.activity-stream.showSponsored" = false;	
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

    "browser.search.region" = "US";
    "browser.search.widget.inNavBar" = true;

    "browser.shell.checkDefaultBrowser" = false;
    "browser.startup.homepage" = "about:newtab";
    "browser.tabs.loadInBackground" = true;
    "browser.urlbar.placeholderName" = "DuckDuckGo";
    
    # disable search suggestions
    "browser.search.suggest.enabled" = false;

    "browser.urlbar.showSearchSuggestionsFirst" = false;

    # disable all the annoying quick actions
    "browser.urlbar.quickactions.enabled" = false;
    "browser.urlbar.quickactions.showPrefs" = false;
    "browser.urlbar.shortcuts.quickactions" = false;
    "browser.urlbar.suggest.quickactions" = false;

    # disable Firefox Suggest features
    "browser.urlbar.suggest.searches" = false;
    "browser.urlbar.suggest.pocket" = false;
    "browser.urlbar.sponsoredTopSites" = false;
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "browser.urlbar.suggest.sponsored" = false;

    "browser.newtabpage.pinned" = "[{\"url\":\"https://www.youtube.com\",\"label\":\"Youtube\",\"baseDomain\":\"youtube.com\"},{\"url\":\"https://www.chess.com/\",\"label\":\"Chess\"},{\"url\":\"https://translate.google.by/\",\"label\":\"Translate\"},{\"url\":\"https://myfin.by/currency/usd\",\"label\":\"Min Fin\"},{\"url\":\"https://github.com/AlexAntonik\",\"label\":\"GitHub\"}]";

    "distribution.searchplugins.defaultLocale" = "en-US";

    "doh-rollout.balrog-migration-done" = true;
    "doh-rollout.doneFirstRun" = true;

    "dom.forms.autocomplete.formautofill" = false;

    "general.autoScroll" = true;
    "general.useragent.locale" = "en-US";

    "extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";
    
    "extensions.pocket.enabled" = false;

    "extensions.extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";
    "extensions.update.enabled" = false;
    "extensions.webcompat.enable_picture_in_picture_overrides" = true;
    "extensions.webcompat.enable_shims" = true;
    "extensions.webcompat.perform_injections" = true;
    "extensions.webcompat.perform_ua_overrides" = true;

    "print.print_footerleft" = "";
    "print.print_footerright" = "";
    "print.print_headerleft" = "";
    "print.print_headerright" = "";

    "privacy.donottrackheader.enabled" = true;

    # Yubikey
    # "security.webauth.u2f" = true;
    # "security.webauth.webauthn" = true;
    # "security.webauth.webauthn_enable_softtoken" = true;
    # "security.webauth.webauthn_enable_usbtoken" = true;

    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };

in
{
  programs.firefox = {
    enable = true;

    package = pkgs.firefox-beta-bin;

    profiles = {
      default = {
        id = 0;
        extensions = extensions;
        inherit settings userChrome;
      };
    };
  };
}
