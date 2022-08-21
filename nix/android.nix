{ androidenv }:

androidenv.composeAndroidPackages {
  #toolsVersion = "25.2.5";
  #platformToolsVersion = "29.0.6";
  #buildToolsVersions = [ "29.0.2" ];
  buildToolsVersions = [ "30.0.3" ];
  includeEmulator = true;
  emulatorVersion = "31.3.9";
  platformVersions = [ "31" ];
  includeSources = false;
  #includeDocs = false;
  includeSystemImages = true;
  systemImageTypes = [ "default" ];
  abiVersions = [ "x86_64" ];
  includeNDK = false;
  useGoogleAPIs = false;
  useGoogleTVAddOns = false;
}
