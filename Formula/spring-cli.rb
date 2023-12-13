# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-12-13T16:04:11.147664752Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.8.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.0/spring-cli-standalone-0.8.0-linux.x86_64.zip"
    sha256 "8c347081a87b0d06ca804ed99bfadd83973cb7b513307d65773e22fe82a7242d"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.0/spring-cli-standalone-0.8.0-osx.aarch64.zip"
    sha256 "ffbe7de6de18349a7919b70a4a69fcdfb7b8da044e7c4110a47101b74feba68b"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.0/spring-cli-standalone-0.8.0-osx.x86_64.zip"
    sha256 "48ef55bd9e7487e0059bb04b6f2195ef44aa3b5ad7510500c63e9b3dcf62003b"
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
    assert_match "0.8.0", output
  end
end
