# Someday I will actually use this
_: {
  services.mpd = {
    enable = true;
    musicDirectory = "~/Música";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };
}
