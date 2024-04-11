# Generated with JReleaser 1.12.0-SNAPSHOT at 2024-04-11T10:47:12.091776673Z
class SpringCli < Formula
  desc "Spring CLI improves your productivity when creating new Spring projects or adding functionality to existing projects"
  homepage "https://spring.io/projects/spring-cli"
  version "0.9.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-linux.x86_64.zip"
    sha256 "d044bed4ccb8dcfbbbe7b43765d2cc85fb50386c82e4d9f6a13f65f3f822baca"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.aarch64.zip"
    sha256 "0f936c48e9111ff3c4d243a0080c92572c206279df3c7046d59ce8cb093d261b"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.x86_64.zip"
    sha256 "5fd49fa0d8013b7890e71fa9e9a3240f73d91cf230c1ea9c9ecb39a76de49a87"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
    bash_completion.install Dir["#{libexec}/completion/bash/spring"]
    zsh_completion.install Dir["#{libexec}/completion/zsh/_spring"]
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib)
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.9.0", output
  end
end
