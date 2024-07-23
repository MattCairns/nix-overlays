{
  amazon-kinesis-video-streams-pic,
  amazon-kinesis-video-streams-producer-c,
  cmake,
  elfutils,
  fetchFromGitHub,
  gst_all_1,
  libunwind,
  libwebsockets,
  om4,
  openssl,
  pcre2,
  pkg-config,
  srtp,
  stdenv,
  usrsctp,
  zstd,
}:
stdenv.mkDerivation {
  name = "amazon-kinesis-video-streams-webrtc-sdk-c";

  src = fetchFromGitHub {
    owner = "awslabs";
    repo = "amazon-kinesis-video-streams-webrtc-sdk-c";
    rev = "v1.10.2";
    hash = "sha256-g7RzatzJ+ezHaOqhVQ5jOZJ+lrZWouB6cuWwl3eXHaE=";
  };

  patches = [ ./dont-download-common-lws-if-found-pkg-config.patch ];

  
  propagatedBuildInputs = [
    amazon-kinesis-video-streams-pic
    amazon-kinesis-video-streams-producer-c
    elfutils
    gst_all_1.gst-devtools
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gstreamer
    libunwind
    libwebsockets
    om4
    openssl
    pcre2
    srtp
    usrsctp
    zstd
  ];

  nativeBuildInputs = [
    pkg-config
    cmake
  ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_DEPENDENCIES=False"
  ];

  postInstall = ''
    mkdir -p $out/lib/pkgconfig
    touch $out/lib/pkgconfig/libkvswebrtcsdk.pc
    cat <<EOF > $out/lib/pkgconfig/libkvswebrtcsdk.pc
prefix=$out
exec_prefix=''${prefix}
libdir=''${prefix}/lib
includedir=''${prefix}/include

Name: libkvswebrtcsdk
Version: 1.10.2 
Description: amazon-kinesis-video-streams-webrtc-sdk-c packaged for OOR 
Libs: -L''${prefix}/lib -larenac 
Cflags: -I''${prefix}/include/com/amazonaws/kinesis/video/webrtcclient
EOF
  '';

}
