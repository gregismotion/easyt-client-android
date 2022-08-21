{ sources ? import ./nix/sources.nix }:

let
  pkgs = import sources.nixpkgs { config.android_sdk.accept_license = true; config.allowUnfree = true; };
  android = pkgs.callPackage ./nix/android.nix { };
in pkgs.mkShell {
  buildInputs = with pkgs; [
    # from pkgs
    flutter
    unzip
    jdk11
    niv
    #from ./nix/*
    scrcpy
    android-tools
    android.platform-tools 
    glibc ];

  # NOTE: remember, local.properties and app/build.gradle need changes too...
  GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${android.androidsdk}/libexec/android-sdk/build-tools/30.0.3/aapt2"; # TODO: get it programatically via nix/android.nix => buildToolsVersions
  ANDROID_HOME = "${android.androidsdk}/libexec/android-sdk";
  JAVA_HOME = pkgs.jdk11;
  ANDROID_AVD_HOME = (toString ./.) + "/.android/avd";
}
