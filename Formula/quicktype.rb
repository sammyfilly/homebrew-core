require "language/node"

class Quicktype < Formula
  desc "Generate types and converters from JSON, Schema, and GraphQL"
  homepage "https://github.com/quicktype/quicktype"
  url "https://registry.npmjs.org/quicktype/-/quicktype-23.0.69.tgz"
  sha256 "e0ba9ee0fcb49ec391f9bfe284113457292d02001a69cfc853cf8660adc78bd9"
  license "Apache-2.0"
  head "https://github.com/quicktype/quicktype.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "919013dfe2858685655a17bcdd908f0c7e93435002083977819e08a29e7f94d1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "919013dfe2858685655a17bcdd908f0c7e93435002083977819e08a29e7f94d1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "919013dfe2858685655a17bcdd908f0c7e93435002083977819e08a29e7f94d1"
    sha256 cellar: :any_skip_relocation, ventura:        "5f867122ea73cf84cff2ef6d1c34472e287947378f16efc468b5446c45fed633"
    sha256 cellar: :any_skip_relocation, monterey:       "5f867122ea73cf84cff2ef6d1c34472e287947378f16efc468b5446c45fed633"
    sha256 cellar: :any_skip_relocation, big_sur:        "5f867122ea73cf84cff2ef6d1c34472e287947378f16efc468b5446c45fed633"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "919013dfe2858685655a17bcdd908f0c7e93435002083977819e08a29e7f94d1"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"sample.json").write <<~EOS
      {
        "i": [0, 1],
        "s": "quicktype"
      }
    EOS
    output = shell_output("#{bin}/quicktype --lang typescript --src sample.json")
    assert_match "i: number[];", output
    assert_match "s: string;", output
  end
end
