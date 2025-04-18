{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  nix-update-script,
  protobuf,
  pymacaroons,
  pynacl,
  pyrfc3339,
  requests,
  setuptools,
  httmock,
  fixtures,
  pytestCheckHook,
  mock,
}:

buildPythonPackage rec {
  pname = "macaroonbakery";
  version = "1.3.4";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "go-macaroon-bakery";
    repo = "py-macaroon-bakery";
    tag = version;
    hash = "sha256-NEhr8zkrHceeLbAyuUvc7U6dyQxkpkj0m5LlnBMafA0=";
  };

  # fix version string
  postPatch = ''
    substituteInPlace setup.py \
      --replace-fail "VERSION = (1, 3, 3)" "VERSION = (1, 3, 4)"
  '';

  build-system = [ setuptools ];

  dependencies = [
    protobuf
    pymacaroons
    pynacl
    pyrfc3339
    requests
  ];

  pythonRelaxDeps = true;

  pythonImportsCheck = [ "macaroonbakery" ];

  nativeCheckInputs = [
    fixtures
    httmock
    mock
    pytestCheckHook
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Python library for working with macaroons";
    homepage = "https://github.com/go-macaroon-bakery/py-macaroon-bakery";
    changelog = "https://github.com/go-macaroon-bakery/py-macaroon-bakery/releases/tag/${version}";
    license = lib.licenses.lgpl3Only;
    maintainers = with lib.maintainers; [ jnsgruk ];
    platforms = lib.platforms.linux;
  };
}
