{
  lib,
  rustPlatform,
  fetchFromGitHub,
  rust-jemalloc-sys,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "oxlint";
  version = "0.15.14";

  src = fetchFromGitHub {
    owner = "web-infra-dev";
    repo = "oxc";
    rev = "oxlint_v${version}";
    hash = "sha256-PCaS60UjD502YI9lZsvbSa3utwrYl8YazZj/CF91euQ=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-/OLcyHTTevqpkrHY3Ueo38xtIjhjE4quqPTEZfPEcaY=";

  buildInputs =
    [
      rust-jemalloc-sys
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      darwin.apple_sdk.frameworks.Security
    ];

  env.OXC_VERSION = version;

  cargoBuildFlags = [
    "--bin=oxlint"
    "--bin=oxc_language_server"
  ];
  cargoTestFlags = cargoBuildFlags;

  meta = with lib; {
    description = "Suite of high-performance tools for JavaScript and TypeScript written in Rust";
    homepage = "https://github.com/web-infra-dev/oxc";
    changelog = "https://github.com/web-infra-dev/oxc/releases/tag/${src.rev}";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
    mainProgram = "oxlint";
  };
}
