{
  lib,
  python313Packages,
  fetchFromGitHub,
  wrapGAppsHook4,
  meson,
  ninja,
  pkg-config,
  blueprint-compiler,
  desktop-file-utils,
  libadwaita,
  gst_all_1,
  libsecret,
  libportal,
}:

python313Packages.buildPythonApplication {
  pname = "high-tide";
  version = "0-unstable-2025-05-10";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "Nokse22";
    repo = "high-tide";
    rev = "85b26df808923feac91f79025d259c196ed18120";
    hash = "sha256-uvjT2NRvI21MzhDzI8yhmh/XjzTIXYIDpe1gdW5jTak=";
  };

  nativeBuildInputs = [
    wrapGAppsHook4
    meson
    ninja
    pkg-config
    blueprint-compiler
    desktop-file-utils
  ];

  buildInputs =
    [ libadwaita ]
    ++ (with gst_all_1; [
      gstreamer
      gst-plugins-base
      gst-plugins-good
      gst-plugins-ugly
      gst-plugins-bad
      libsecret
      libportal
    ]);

  dependencies = with python313Packages; [
    pygobject3
    tidalapi
    requests
    mpd2
  ];

  dontWrapGApps = true;

  makeWrapperArgs = [ "\${gappsWrapperArgs[@]}" ];

  meta = {
    description = "Libadwaita TIDAL client for Linux";
    homepage = "https://github.com/Nokse22/high-tide";
    license = with lib.licenses; [ gpl3Plus ];
    mainProgram = "high-tide";
    maintainers = with lib.maintainers; [
      nyabinary
      griffi-gh
    ];
    platforms = lib.platforms.linux;
  };
}
