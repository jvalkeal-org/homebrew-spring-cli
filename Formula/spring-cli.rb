# Generated with JReleaser 1.12.0-SNAPSHOT at 2024-04-10T18:57:56.758019105Z
class SpringCli < Formula
  desc "Spring CLI improves your productivity when creating new Spring projects or adding functionality to existing projects"
  homepage "https://spring.io/projects/spring-cli"
  version "0.9.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-linux.x86_64.zip"
    sha256 "02d143be40b004b042cf7b175e2524e973eea64b3931b7d89fa26df9b57ed0e2"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.aarch64.zip"
    sha256 "fa0189a2c4b30cbdfaef7fc72ca5540c8710b51234a2630aba9f5ae8b2518e11"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.x86_64.zip"
    sha256 "b4d0d9e2e3177be89e30ab92781e14410657e72052405339e997f7d0041d43a2"
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
