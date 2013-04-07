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
  depends_on 'expat' => :build



  def install
    generate_version    
        inreplace 'configure.ac', 'AC_CHECK_LIB([ncursesw], [main], [],', 'AC_CHECK_LIB([ncurses], [main], [],'
        system "./bootstrap.sh"
        system "./configure", "--prefix=#{prefix}"
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
    @downloader.cached_location
  end

end
