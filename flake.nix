{
	description = "RGBDS";
	inputs = {
		nixpkgs.url = github:NixOS/nixpkgs/nixos-23.11;
	};

	outputs = { self, nixpkgs }:
		let
			version = "0.7.0";
			supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
			forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
			nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
		in {
			packages = forAllSystems (system:
				let
					pkgs = nixpkgsFor.${system};
				in {
					default = pkgs.stdenv.mkDerivation {
						pname = "rgbds";
						inherit version;
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
				});
		};
}
