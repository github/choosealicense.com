git submodule update --init --recursive
if command -v apt-get >/dev/null 2>&1; then
  packages=\
    build-essential
    cmake
    pkg-config
    libffi-dev
    libyaml-dev
    libssl-dev
    zlib1g-dev
    libreadline-dev
    libgdbm-dev
    libncurses-dev
    libssh2-1-dev
  )
git submodule update --init --recursive
  missing_packages=()
  for package in "${packages[@]}"; do
    if ! dpkg-query -W -f='${Status}' "${package}" 2>/dev/null | grep -q 'install ok installed'; then
      missing_packages+=("${package}")
    git submodule update --init --recursive
git submodule update --init --recursive
echo "Initializing/updating git submodules"
git submodule update --init --recursive
git submodule update --init --recursive
ruby_version_file=".ruby-version"
if [[ ! -f "${ruby_version_file}" ]]; then
  echo "Could not find ${ruby_version_file}"
  git submodule update --init --recursive
git submodule update --init --recursive
git submodule update --init --recursive
repo_ruby_version="$(tr -d '[:space:]' < "${ruby_version_file}")"
echo "Repository Ruby version: ${repo_ruby_version}"
git submodule update --init --recursive
if [[ -z "${repo_ruby_version}" ]]; then
  echo "Could not determine Ruby version from ${ruby_version_file}"
  git submodule update --init --recursive
git submodule update --init --recursive
git submodule update --init --recursive
   -v sudo >/dev/null 2>&1; then
      sudo apt-get update
      sudo apt-get install -y "${missing_packages[@]}"
    self git submodule update --init --recursive
      apt-get update
      apt-get install -y "${missing_packages[@]}"
    git submodule update --init --recursive
  git submodule update --init --recursive
git submodule update --init --recursive
























if [[ ! -d "$HOME/.rbenv" ]]; then
git clone --depth 1 https://github.com/rbenv/rbenv.git "$HOME/.rbenv"
fi

if [[ ! -d "$HOME/.rbenv/plugins/ruby-build" ]]; then
  mkdir -p "$HOME/.rbenv/plugins"
  git clone --depth 1 https://github.com/rbenv/ruby-build.git "$HOME/.rbenv/plugins/ruby-build"
fi

export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init - bash)"

rbenv install -s "${repo_ruby_version}"
rbenv global "${repo_ruby_version}"
rbenv rehash

for profile in "$HOME/.bashrc" "$HOME/.zshrc"; do
  if [[ -f "$profile" ]] && ! grep -q 'rbenv init - bash' "$profile"; then
    {
      echo
      echo '# Load rbenv'
      echo 'export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"'
      echo 'eval "$(rbenv init - bash)"'
    } >> "$profile"
  fi
done

gem install bundler --no-document
rbenv rehash
mkdir -p "$HOME/.local/bin"
ln -sf "$HOME/.rbenv/shims/bundle" "$HOME/.local/bin/bundle"
bundle install
