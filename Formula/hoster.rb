require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Hoster < Formula
  homepage "https://github.com/helmedeiros/hoster"
  head "https://github.com/iuriandreazza/hoster.git" 
  url "https://github.com/iuriandreazza/hoster/releases/download/0.1/hoster-0.1-as.tar.gz"
  sha1 "372aa3ac02fa4dc4483f962cf805a629b91a59e8"

  depends_on :python
  depends_on 'tree'

  def install
    ENV.deparallelize
    #Reject py, and copy all tgz folders
    prefix.install Dir['*'].reject{|f|f['*.py'] }
    system "python", (prefix + "setup.py"), prefix, version
    man.mkpath
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test hoster`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    print "-> Testing Hoster Installation"
    print "."
    system "hoster", "--version"
    
    print "-> Testing Creating HOSTER Strucutre"
    print "."
    system "hoster", "init"
    system "hoster", "add", "127.0.0.1", "www.test.com", "--dev"
    system "hoster", "list"
  end
end