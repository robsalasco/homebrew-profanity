require 'formula'

class Libstrophe < Formula
  head 'https://github.com/strophe/libstrophe.git', :using => :git

  homepage 'http://strophe.im/libstrophe'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'expat' => :build
  depends_on 'check' => :build



  def install
    generate_version
        system "./bootstrap.sh"
        system "./configure", "--prefix=#{prefix}"
        system "make install"
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
    cached_download
  end

end
