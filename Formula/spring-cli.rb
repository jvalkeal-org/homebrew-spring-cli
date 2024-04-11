# Generated with JReleaser 1.12.0-SNAPSHOT at 2024-04-11T13:49:28.20632493Z
class SpringCli < Formula
  desc "Spring CLI improves your productivity when creating new Spring projects or adding functionality to existing projects"
  homepage "https://spring.io/projects/spring-cli"
  version "0.9.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-linux.x86_64.zip"
    sha256 "6e5d0a64dea9b060058d5bf14908a7afe3dea008af55564ed6210d92b8fee750"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.aarch64.zip"
    sha256 "6302b9ae6d7db830e33b7fc00f70318d581e1ad7a24b63f1a7027445175c6312"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.9.0/spring-cli-standalone-0.9.0-osx.x86_64.zip"
    sha256 "4cdddd076a4109ba8e4564705ea2c57879101dedeacd8bcc82cae62533d4dc00"
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
