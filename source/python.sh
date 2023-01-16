export PATH=$PATH:~/.local/bin

venv-install(){
  [ ! -d venv ] && virtualenv venv
  venv-update
}
venv-update(){
  sed -i "s%/app%$(pwd)%g" requirements/*.txt
  venv/bin/pip install neovim
  venv/bin/pip install $(for file in requirements/*.txt; do echo "-r $file"; done)
  venv/bin/pip install -e deps/*
  [ -f setup.cfg ] && venv/bin/pip install -e .
  sed -i "s%$(pwd)%/app%g" requirements/*.txt
}
venv-activate(){
  [ -d venv ] || venv-install
  source venv/bin/activate
}

