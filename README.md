# Jonathan Schimpf's Homebrew tap

Shared Homebrew formulas for Jonathan's command-line programs.

## Install AWS Cost Optimizer

```bash
brew install mjfxjas/tap/aws-cost-optimizer
aws-cost-optimizer --help
aws-cost-optimizer analyze
```

Homebrew installs Python and the program's dependencies, including AWS CRT for
`aws login` credentials, in a managed virtual environment. There is no venv
activation step. AWS credentials, a region, and suitable IAM permissions are
still required to analyze your account.

## Install WonderDash

```bash
brew install mjfxjas/tap/wonder-dash
wonder-dash setup
wonder-dash hub
```

WonderDash provides a terminal dashboard for CloudFront and other AWS services.
It includes CRT support for `aws login` credentials and uses a fully isolated
Python environment. AWS credentials and the appropriate permissions are required.

To upgrade:

```bash
brew update
brew upgrade mjfxjas/tap/aws-cost-optimizer
brew upgrade mjfxjas/tap/wonder-dash
```

## Add another program

Keep one formula per command-line program under `Formula/` in this repository.
Use a released source archive with a SHA256 checksum, declare the runtime and
build dependencies, and add a credential-free functional test. GUI applications
can use casks under `Casks/`.

Python programs should use `Language::Python::Virtualenv` and
`virtualenv_install_with_resources`. Generate and refresh all dependency
resources with `brew update-python-resources`; record any extras in
`pypi_packages` so future updates retain them.

Before publishing a formula:

```bash
brew install --build-from-source mjfxjas/tap/PROGRAM_NAME
brew test mjfxjas/tap/PROGRAM_NAME
brew audit --strict --online mjfxjas/tap/PROGRAM_NAME
```

## Update a Python formula

1. Publish a new version of the program to PyPI.
2. Update the formula's source URL and SHA256 using that release's source distribution.
3. Regenerate dependencies:

   ```bash
   brew update-python-resources mjfxjas/tap/aws-cost-optimizer --install-dependencies
   # Or, for WonderDash:
   brew update-python-resources mjfxjas/tap/wonder-dash --install-dependencies
   ```

For a just-published release, resource generation may need
   `--ignore-main-package-cooldown`; dependency cooldowns remain in effect.

4. Run install/test/audit, then commit and push the formula update.

Both AWS formulas record `boto3[crt]` as an additional dependency root so AWS CRT
support remains included when resources are regenerated. The generated GitHub
workflows check tap syntax on pushes and build/test formulas for pull requests.

[Homebrew tap documentation](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
