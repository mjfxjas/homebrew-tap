class WonderDash < Formula
  include Language::Python::Virtualenv

  desc "Terminal dashboard for AWS monitoring"
  homepage "https://github.com/mjfxjas/wonder_dash"
  url "https://files.pythonhosted.org/packages/fb/c2/e1e07807789e16653f38bc0069818596fa3894d77d631295c3e4d76a76fe/wonder_dash-0.1.4.tar.gz"
  sha256 "1caae9c6a2e1a783d724a2bbd8373472f9c0ab444e7e4bafcebecb7495375a96"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "openssl@3"
  depends_on "python@3.14"

  pypi_packages package_name: "wonder-dash", extra_packages: "boto3[crt]"

  resource "awscrt" do
    url "https://files.pythonhosted.org/packages/6a/7d/fd87588cffbef8fbdb8436f14fa673ee3735cf8600a1a2a36ef78718cfd6/awscrt-0.36.0.tar.gz"
    sha256 "ad2198461f3b2a2851f37891d75dcb9173bfe2474d8550ad6260bf9970b4064a"
  end

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/48/59/fb93b6ebd9ad43eb9a58c7a6da51a0fe24ab0c04bc4d534a0bfc5eba7f59/boto3-1.43.108.tar.gz"
    sha256 "03341f089158368acf83e921aca98b706095322ca52bc4c039a616940aa5ad41"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/61/16/6b4477f433da2c11193802f538330ce080076c2f38d817ad437ed3cd1465/botocore-1.43.108.tar.gz"
    sha256 "ee4f75cf3bdbb0da7912e089950e8112f692016539d939312c771499958e6cfd"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/d3/59/322338183ecda247fb5d1763a6cbe46eff7222eaeebafd9fa65d4bf5cb11/jmespath-1.1.0.tar.gz"
    sha256 "472c87d80f36026ae83c6ddd0f1d05d4e510134ed462851fd5f754c8c3cbb88d"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
    sha256 "37dd54208da7e1cd875388217d5e00ebd4179249f90fb72437e91a35459a0ad3"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/76/43/35e4d8aa320bffe8287fe8f65f578fa2d2db0a64212f0e710dce58267854/s3transfer-0.19.2.tar.gz"
    sha256 "ba0309fd86be3c27dbf78cdd813c13c5e1df16e5874b99d2535ebbdfb9892993"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "ff70335d468e7eb6ec65b95b99d3a2836546063f63acc5171de367e834932a81"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e3/05/b17359e1cefb4f909b5e40b1b90a496d987258916dbbf88e842c729f510e/urllib3-2.8.0.tar.gz"
    sha256 "63bf2ead4c879426ebf22ef2a781eeb4aa3b4ae798a0435506f8687fd5bb9b63"
  end

  def install
    ENV["AWS_CRT_BUILD_USE_SYSTEM_LIBCRYPTO"] = "1"
    virtualenv_install_with_resources(system_site_packages: false)
  end

  test do
    ENV["WONDER_DASH_CONFIG"] = (testpath/"config").to_s
    assert_match "CloudFront request dashboard", shell_output("#{bin}/wonder-dash --help")
    assert_match version.to_s, shell_output("#{bin}/wonder-dash --version")
    assert_match "period_seconds", shell_output("#{bin}/wonder-dash show-config")
    system libexec/"bin/python", "-c", "import awscrt; from awscrt import crypto"
  end
end
