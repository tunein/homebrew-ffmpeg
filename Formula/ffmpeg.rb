class Ffmpeg < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  url "https://ffmpeg.org/releases/ffmpeg-7.1.1.tar.xz"
  version "7.1.1-with-options" # to distinguish from homebrew-core's ffmpeg
  sha256 "733984395e0dbbe5c046abda2dc49a5544e7e0e1e2366bba849222ae9e3a03b1"
  license "GPL-2.0-or-later"
  head "https://github.com/FFmpeg/FFmpeg.git", branch: "master"

  option "with-chromaprint", "Enable the Chromaprint audio fingerprinting library"
  option "with-decklink", "Enable DeckLink support"
  option "with-fdk-aac", "Enable the Fraunhofer FDK AAC library"
  option "with-game-music-emu", "Enable Game Music Emu (GME) support"
  option "with-jack", "Enable Jack support"
  option "with-libaribb24", "Enable decoding ARIB/ISDB captions"
  option "with-libmodplug", "Enable module/tracker files as inputs via libmodplug"
  option "with-libopenmpt", "Enable module/tracker files as inputs via libopenmpt"
  option "with-librist", "Enable Reliable Internet Stream Transport (RIST) support"
  option "with-librsvg", "Enable SVG files as inputs via librsvg"
  option "with-libsoxr", "Enable the soxr resample library"
  option "with-libssh", "Enable SFTP protocol via libssh"
  option "with-tesseract", "Enable the tesseract OCR engine"
  option "with-libvidstab", "Enable vid.stab support for video stabilization"
  option "with-opencore-amr", "Enable Opencore AMR NR/WB audio format"
  option "with-openh264", "Enable OpenH264 library"
  option "with-openjpeg", "Enable JPEG 2000 image format"
  option "with-openssl", "Enable SSL support"
  option "with-rav1e", "Enable AV1 encoding via librav1e"
  option "with-svt-av1", "Enable Scalable Video Technology for AV1"
  option "with-rtmpdump", "Enable RTMP dumping support"
  option "with-rubberband", "Enable rubberband library"
  option "with-webp", "Enable using libwebp to encode WEBP images"
  option "with-zeromq", "Enable using libzeromq to receive cmds sent through a libzeromq client"
  option "with-zimg", "Enable z.lib zimg library"
  option "with-srt", "Enable SRT library"
  option "with-libvmaf", "Enable libvmaf scoring library"
  option "with-libxml2", "Enable libxml2 library"
  option "with-libzvbi", "Enable decoding of DVB teletext pages and DVB teletext subtitles"

  depends_on "pkg-config" => :build

  depends_on "aom"
  depends_on "dav1d"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "frei0r"
  depends_on "lame"
  depends_on "libass"
  depends_on "libvorbis"
  depends_on "libvpx"
  depends_on "opus"
  depends_on "sdl2"
  depends_on "snappy"
  depends_on "theora"
  depends_on "x264"
  depends_on "x265"
  depends_on "xz"

  depends_on "aribb24" => :optional
  depends_on "fdk-aac" => :optional
  depends_on "game-music-emu" => :optional
  depends_on "jack" => :optional
  depends_on "libbluray" => :optional
  depends_on "libbs2b" => :optional
  depends_on "libcaca" => :optional
  depends_on "libgsm" => :optional
  depends_on "libmodplug" => :optional
  depends_on "libopenmpt" => :optional
  depends_on "librist" => :optional
  depends_on "librsvg" => :optional
  depends_on "libsoxr" => :optional
  depends_on "libssh" => :optional
  depends_on "libvidstab" => :optional
  depends_on "libvmaf" => :optional
  depends_on "libxml2" => :optional
  depends_on "opencore-amr" => :optional
  depends_on "openh264" => :optional
  depends_on "openjpeg" => :optional
  depends_on "openssl@3" => :optional
  depends_on "rav1e" => :optional
  depends_on "rtmpdump" => :optional
  depends_on "rubberband" => :optional
  depends_on "speex" => :optional
  depends_on "srt" => :optional
  depends_on "svt-av1" => :optional
  depends_on "tesseract" => :optional
  depends_on "two-lame" => :optional
  depends_on "webp" => :optional
  depends_on "xvid" => :optional
  depends_on "zeromq" => :optional
  depends_on "zimg" => :optional

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  on_linux do
    depends_on "alsa-lib"
    depends_on "libxv"
    depends_on "gcc" => :optional
  end

  on_intel do
    depends_on "nasm" => :build
  end

  fails_with gcc: "5"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --enable-gpl
      --enable-libaom
      --enable-libdav1d
      --enable-libmp3lame
      --enable-libopus
      --enable-libsnappy
      --enable-libtheora
      --enable-libvorbis
      --enable-libvpx
      --enable-libx264
      --enable-libx265
      --enable-libfontconfig
      --enable-libfreetype
      --enable-frei0r
      --enable-libass
      --enable-demuxer=dash
    ]

    if OS.mac?
      args << "--enable-opencl"
      args << "--enable-audiotoolbox"
      args << "--enable-videotoolbox"
      args << "--enable-neon" if Hardware::CPU.arm?
    end

    args << "--disable-htmlpages" # The same info is accessible through the man pages.
    args << "--enable-chromaprint" if build.with? "chromaprint"
    args << "--enable-libaribb24" if build.with? "libaribb24"
    args << "--enable-libbluray" if build.with? "libbluray"
    args << "--enable-libbs2b" if build.with? "libbs2b"
    args << "--enable-libcaca" if build.with? "libcaca"
    args << "--enable-libfdk-aac" if build.with? "fdk-aac"
    args << "--enable-libgme" if build.with? "game-music-emu"
    args << "--enable-libgsm" if build.with? "libgsm"
    args << "--enable-libmodplug" if build.with? "libmodplug"
    args << "--enable-libopenh264" if build.with? "openh264"
    args << "--enable-libopenjpeg" if build.with? "openjpeg"
    args << "--enable-libopenmpt" if build.with? "libopenmpt"
    args << "--enable-librav1e" if build.with? "rav1e"
    args << "--enable-libsvtav1" if build.with? "svt-av1"
    args << "--enable-librist" if build.with? "librist"
    args << "--enable-librsvg" if build.with? "librsvg"
    args << "--enable-librtmp" if build.with? "rtmpdump"
    args << "--enable-librubberband" if build.with? "rubberband"
    args << "--enable-libsoxr" if build.with? "libsoxr"
    args << "--enable-libspeex" if build.with? "speex"
    args << "--enable-libsrt" if build.with? "srt"
    args << "--enable-libssh" if build.with? "libssh"
    args << "--enable-libtesseract" if build.with? "tesseract"
    args << "--enable-libtwolame" if build.with? "two-lame"
    args << "--enable-libvidstab" if build.with? "libvidstab"
    args << "--enable-libvmaf" if build.with? "libvmaf"
    args << "--enable-libwebp" if build.with? "webp"
    args << "--enable-libxml2" if build.with? "libxml2"
    args << "--enable-libxvid" if build.with? "xvid"
    args << "--enable-libzimg" if build.with? "zimg"
    args << "--enable-libzvbi" if build.with? "libzvbi"
    args << "--enable-libzmq" if build.with? "zeromq"
    args << "--enable-openssl" if build.with? "openssl@3"

    # These librares are GPL-incompatible, and require ffmpeg be built with
    # the "--enable-nonfree" flag, which produces unredistributable libraries
    args << "--enable-nonfree" if build.with?("decklink") || build.with?("fdk-aac") || build.with?("openssl@3")

    if build.with? "decklink"
      args << "--enable-decklink"
      args << "--extra-cflags=-I#{HOMEBREW_PREFIX}/include"
      args << "--extra-ldflags=-L#{HOMEBREW_PREFIX}/include"
      mv "VERSION", "VERSION.txt"
    end

    if build.with? "jack"
      ENV.prepend_path "PKG_CONFIG_PATH", Formula["jack"].opt_lib/"pkgconfig"
      args << "--enable-libjack"
      args << "--enable-indev=jack"
    end

    if build.with? "libzvbi"
      ENV.prepend_path "PKG_CONFIG_PATH", Formula["zvbi"].opt_lib/"pkgconfig"
      args << "--enable-libzvbi"
    end

    args << "--enable-version3" if build.with?("opencore-amr") || build.with?("libvmaf")

    if build.with? "opencore-amr"
      args << "--enable-libopencore-amrnb"
      args << "--enable-libopencore-amrwb"
    end

    system "./configure", *args
    system "make", "install"

    # Build and install additional FFmpeg tools
    system "make", "alltools"
    bin.install Dir["tools/*"].select { |f| File.executable? f }
    mv bin/"python", pkgshare/"python", force: true

    if build.with? "tesseract"
      opoo <<~EOS
        The default `tesseract` dependency includes limited language support.
        To add all supported languages, install the `tesseract-lang` formula.
      EOS
    end
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end
