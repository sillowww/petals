{ lib, ... }:
{
  wayland.windowManager.sway = {
    extraConfig = lib.mkAfter ''
      for_window [class="Civ6"] floating enable, fullscreen enable
      for_window [window_role = "pop-up"] floating enable
      for_window [window_role = "bubble"] floating enable
      for_window [window_role = "dialog"] floating enable
      for_window [window_type = "dialog"] floating enable
      for_window [window_role = "task_dialog"] floating enable
      for_window [window_type = "menu"] floating enable
      for_window [app_id = "floating"] floating enable
      for_window [app_id = "floating_update"] floating enable, resize set width 1000px height 600px
      for_window [class = "(?i)pinentry"] floating enable
      for_window [title = "Administrator privileges required"] floating enable
      for_window [title = "Open files"] floating enable, resize set width 768px height 768px
      for_window [title = "About Mozilla Firefox"] floating enable
      for_window [window_role = "About"] floating enable
      for_window [app_id="firefox" title="Library"] floating enable
      for_window [app_id="librewolf" title="Library"] floating enable
      for_window [title = "Firefox - Sharing Indicator"] kill
      for_window [title = "Firefox — Sharing Indicator"] kill
      for_window [title = "librewolf - Sharing Indicator"] kill
      for_window [title = "librewolf — Sharing Indicator"] kill
    '';
  };
}
