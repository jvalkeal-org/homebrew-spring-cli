# Generated with JReleaser 1.12.0-SNAPSHOT at 2024-04-10T10:55:35.512321307Z
class SpringCli < Formula
  desc "Spring CLI improves your productivity when creating new Spring projects or adding functionality to existing projects"
  homepage "https://spring.io/projects/spring-cli"
  version "0.9.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-linux.x86_64.zip"
    sha256 "0386decc63b8bc6d365da2d80bc2bfc12972336996037f182b76d357c7be1da2"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.aarch64.zip"
    sha256 "01748e989a8753122dd7df3b424fb3dd9538d55e9ab102ea95539eacc493b30a"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.x86_64.zip"
    sha256 "b5d5de8e08db9f25c6c78e490a2854cb870dd0d25561e03e7ee7b2f5f75d5c52"
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
