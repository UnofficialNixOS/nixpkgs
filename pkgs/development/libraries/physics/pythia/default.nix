{ stdenv, fetchurl, boost, fastjet, hepmc2, lhapdf, rsync, zlib }:

stdenv.mkDerivation rec {
  pname = "pythia";
  version = "8.303";

  src = fetchurl {
    url = "http://home.thep.lu.se/~torbjorn/pythia8/pythia${builtins.replaceStrings ["."] [""] version}.tgz";
    sha256 = "0gli6zf8931i7kyminppisc9d0q69xxnalvhld5fgnkh4q82nz6d";
  };

  buildInputs = [ boost fastjet hepmc2 zlib rsync lhapdf ];

  preConfigure = ''
    patchShebangs ./configure
  '';

  configureFlags = [
    "--enable-shared"
    "--with-hepmc2=${hepmc2}"
    "--with-lhapdf6=${lhapdf}"
  ];

  enableParallelBuilding = true;

  meta = {
    description = "A program for the generation of high-energy physics events";
    license     = stdenv.lib.licenses.gpl2;
    homepage    = "http://home.thep.lu.se/~torbjorn/Pythia.html";
    platforms   = stdenv.lib.platforms.unix;
    maintainers = with stdenv.lib.maintainers; [ veprbl ];
  };
}
