require 'formula'

class Profanity < Formula
  head 'https://github.com/boothj5/profanity.git', :using => :git

  homepage 'https://github.com/boothj5/profanity'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'openssl' => :build
  depends_on 'curl' => :build
  depends_on 'glib' => :build
  depends_on 'pkg-config' => :build
  depends_on 'expat'
  depends_on 'libstrophe'
  depends_on 'libotr'
  depends_on 'terminal-notifier'


  def install
        generate_version
        ENV.append 'LIBS', "-L#{HOMEBREW_PREFIX}/opt/gettext/lib"
        ENV.append 'CFLAGS', "-L#{HOMEBREW_PREFIX}/opt/gettext/include"
        ENV.append 'ncursesw_LIBS', "-L#{HOMEBREW_PREFIX}/opt/ncurses/lib"
        ENV.append 'ncursesw_CFLAGS',"-I#{HOMEBREW_PREFIX}/opt/ncurses/include"
        ENV.append 'ncurses_LIBS', "-L#{HOMEBREW_PREFIX}/opt/ncurses/lib"
        ENV.append 'ncurses_CFLAGS',"-I#{HOMEBREW_PREFIX}/opt/ncurses/include"
        ENV.append 'curl_LIBS', "-L#{HOMEBREW_PREFIX}/opt/curl/lib"
        ENV.append 'curl_CFLAGS',"-I#{HOMEBREW_PREFIX}/opt/curl/include"
        system "cp -r #{git_cache}/.git .git"
        system "./bootstrap.sh"
        system "./configure"
        system "make", "PREFIX=#{prefix}", "install"
    end

  private

  def generate_version
    ohai "Generating VERSION from the Homebrew's git cache"
    File.open('VERSION', 'w') {|f| f.write(git_revision) }
  end

  def git_revision
    `cd #{git_cache} && git describe --match "v[0-9]*" --always`.strip
  end

  def git_cache
    @active_spec.downloader.cached_location
  end

end
