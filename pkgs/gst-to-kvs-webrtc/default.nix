{
  amazon-kinesis-video-streams-pic,
  amazon-kinesis-video-streams-producer-c,
  amazon-kinesis-video-streams-webrtc-sdk-c,
  stdenv,
  pkg-config,
  cmake,
}:
stdenv.mkDerivation {
  name = "kvs-webrtc-gst";

  src = builtins.fetchGit {
    url = "ssh://git@gitlab.com/open-ocean-robotics/xplorer-vessel/libs/kvs-webrtc-gst.git";
    rev = "742fbacc44dac6388260642cfaf23ba1bc1bd534";
    ref = "main";
  };

  propagatedBuildInputs = [
    amazon-kinesis-video-streams-pic
    amazon-kinesis-video-streams-producer-c
    amazon-kinesis-video-streams-webrtc-sdk-c
  ];

  nativeBuildInputs = [
    pkg-config
    cmake
  ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
