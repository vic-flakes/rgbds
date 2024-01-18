{
	description = "RGBDS";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs {
					inherit system;
				};
			in {
				packages.default = pkgs.stdenv.mkDerivation rec {
					pname = "rgbds";
					version = "0.7.0";
					src = pkgs.fetchFromGitHub {
						owner = "gbdev";
						repo = "rgbds";
						rev = "v${version}";
						sha256 = "sha256-aktKJlwXpHpjSFxoz5wZJPGWZIcn4ax5iBP0GQEux78=";
					};
					nativeBuildInputs = with pkgs; [
						bison
						cmake
						pkg-config
					];
					buildInputs = with pkgs; [
						zlib.dev
						libpng.dev
					];
				};
			}
		);
}
