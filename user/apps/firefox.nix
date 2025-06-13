{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" ];

    profiles."willow" = {
      settings = {
        "general.useragent.locale" = "en-GB";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        "browser.profiles.enabled" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.tabs.inTitlebar" = 0;

        "browser.uiCustomization.navBarWhenVerticalTabs" =
          ''["back-button","forward-button","stop-reload-button","customizableui-special-spring1","urlbar-container","vertical-spacer","customizableui-special-spring2","downloads-button","unified-extensions-button","_testpilot-containers-ctp-browser-action","firefox-view-button","alltabs-button","sidebar-button"]'';
        "browser.uiCustomization.horizontalTabstrip" =
          ''["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"]'';
        "browser.uiCustomization.state" =
          ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["firefox-view-button","_testpilot-containers-ctp-browser-action","back-button","forward-button","stop-reload-button","customizableui-special-spring1","urlbar-container","vertical-spacer","customizableui-special-spring2","alltabs-button","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","_testpilot-containers-ctp-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","toolbar-menubar","TabsToolbar","PersonalToolbar"],"currentVersion":22,"newElementCount":4}'';

        "font.name.monospace.x-western" = "ZedMono Nerd Font";
        "general.autoScroll" = true;

        "sidebar.main.tools" = "history,bookmarks,syncedtabs";
        "sidebar.new-sidebar.has-used" = true;
        "sidebar.position_start" = false;
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;

        "media.eme.enabled" = false;
      };

      bookmarks.force = true;

      bookmarks.settings = [
        {
          name = "_";
          toolbar = true;
          bookmarks = [
            {
              name = "nix sites";
              bookmarks = [
                {
                  name = "manual";
                  url = "https://nixos.org/manual/nixos/stable/";
                }
                {
                  name = "wiki";
                  url = "https://nixos.wiki/";
                }
                {
                  name = "nixpkgs";
                  url = "https://search.nixos.org/packages";
                }
                {
                  name = "home manager options";
                  url = "https://home-manager-options.extranix.com/";
                }
              ];
            }
          ];
        }
      ];

      containersForce = true;
      containers = {
        # icon
        # one of:
        #   "briefcase", "cart", "circle", "dollar", "fence"
        #   "fingerprint", "gift", "vacation", "food", "fruit", "pet", "tree"
        #   "chill"
        # god i hate all of these icons lol.

        # color
        # one of:
        #   "blue", "turquoise", "green", "yellow", "orange", "red", "pink",
        #   "purple", "toolbari5

        "willow" = {
          id = 10;
          name = "willow";
          icon = "fingerprint";
          color = "blue";
        };

        "meow1" = {
          id = 11;
          name = "meow1";
          icon = "pet";
          color = "purple";
        };

        "meow2" = {
          id = 12;
          name = "meow2";
          icon = "pet";
          color = "orange";
        };

        "meow3" = {
          id = 13;
          name = "meow3";
          icon = "pet";
          color = "yellow";
        };
      };

      # extensions.force = true;
    };
  };
}
