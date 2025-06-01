{ stdenv, fetchzip, ... }:

stdenv.mkDerivation rec {
  pname = "bun-baseline";
  version = "1.2.15";

  src = fetchzip {
    url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-x64-baseline.zip";
    sha256 = "sha256-qf4uvIhA5NScAIu4Xy5Qr+l5DwHpa+Y9exKR9oliW9s=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/bin
    cp bun-linux-x64-baseline/bun $out/bin/bun
    ln -s $out/bin/bun $out/bin/bunx
    chmod +x $out/bin/bun
  '';

  meta = {
    description = "Bun baseline binary for older CPUs";
    homepage = "https://bun.sh";
    platforms = [ "x86_64-linux" ];
  };
}
