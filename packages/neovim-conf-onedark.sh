#!/bin/bash

# Variables
onedark_theme="https://github.com/joshdick/onedark.vim/archive/refs/heads/main.zip"
onedark_pkg="onedark.zip"
onedark_fdr="onedark.vim-main"
# lightline
lightline_repo="https://github.com/itchyny/lightline.vim/archive/refs/heads/master.zip"
lightline_pkg="lightline.zip"
lightline_fdr="lightline.vim-master"

# Function for create vimrc
# Syntax: create_config <user>
function create_config() {
  vimrc_user="${1}"
  vimrc_home="/root"
  if [ "${vimrc_user}" == "root" ] ; then
    vimrc_home="/root"
  else
    vimrc_home="/home/${1}"
  fi
  mkdir -p ${vimrc_home}/.config/nvim/
  echo 'let $NVIM_TUI_ENABLE_TRUE_COLOR=1' > ${vimrc_home}/.config/nvim/init.vim
  echo 'set termguicolors' >> ${vimrc_home}/.config/nvim/init.vim
  echo ':set formatoptions=tcqrn1' >> ${vimrc_home}/.config/nvim/init.vim
  echo ':set tabstop=2' >> ${vimrc_home}/.config/nvim/init.vim
  echo ':set shiftwidth=2' >> ${vimrc_home}/.config/nvim/init.vim
  echo ':set softtabstop=2' >> ${vimrc_home}/.config/nvim/init.vim
  echo ':set expandtab' >> ${vimrc_home}/.config/nvim/init.vim
  echo ':set noshiftround' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Color scheme' >> ${vimrc_home}/.config/nvim/init.vim
  echo '":hi clear' >> ${vimrc_home}/.config/nvim/init.vim
  echo '":colorscheme default' >> ${vimrc_home}/.config/nvim/init.vim
  echo ':colorscheme onedark' >> ${vimrc_home}/.config/nvim/init.vim
  echo '":set background=dark' >> ${vimrc_home}/.config/nvim/init.vim
  echo "let g:lightline = { 'colorscheme': 'onedark', }" >> ${vimrc_home}/.config/nvim/init.vim
  echo '":hi Normal ctermfg=145 ctermbg=234' >> ${vimrc_home}/.config/nvim/init.vim
  echo '":hi Normal guifg=#ABB2BF guibg=#282C34 gui=NONE cterm=NONE' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo "let &t_ut=''" >> ${vimrc_home}/.config/nvim/init.vim
  echo ':tab all' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Change fonts for Windows' >> ${vimrc_home}/.config/nvim/init.vim
  echo '":set guifont=Consolas:h11:cANSI' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'if has("gui_macvim")' >> ${vimrc_home}/.config/nvim/init.vim
  echo '    set guifont=Menlo\ Regular:h14' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'endif' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Hide menu/toolbar of GVIM' >> ${vimrc_home}/.config/nvim/init.vim
  echo '":set guioptions -=m' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Helps force plug-ins to load correctly when it is turned back on below.' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'filetype off' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Turn on syntax highlighting.' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'syntax on' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" For plug-ins to load correctly.' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'filetype plugin indent on' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Set status line display' >> ${vimrc_home}/.config/nvim/init.vim
  echo "set statusline=%F%m%r%h%w\ [%{&ff}]\ [filetype=%Y]\ [%l,%v][%p%%]\ [%{strftime('%F')}\ %{strftime('%T')}]" >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Encoding' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'set encoding=utf-8' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Fixes common backspace problems' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'set backspace=indent,eol,start' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Status bar' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'set laststatus=2' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" Display options' >> ${vimrc_home}/.config/nvim/init.vim
  echo ':set showmode' >> ${vimrc_home}/.config/nvim/init.vim
  echo ':set showcmd' >> ${vimrc_home}/.config/nvim/init.vim
  echo '' >> ${vimrc_home}/.config/nvim/init.vim
  echo '" File explorer' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'nnoremap <leader>n :Explore<CR>' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'nnoremap <C-n> :Lexplore<CR>' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'nnoremap <C-t> :Vexplore<CR>' >> ${vimrc_home}/.config/nvim/init.vim
  echo 'nnoremap <C-f> :Texplore<CR>' >> ${vimrc_home}/.config/nvim/init.vim
  rm -rf ${vimrc_home}/.config/nvim/colors
  rm -rf ${vimrc_home}/.config/nvim/autoload
  rm -rf ${vimrc_home}/.config/nvim/plugin
  chown ${vimrc_user} ${vimrc_home}/.config/nvim/init.vim 2> /dev/null
  echo "# Created ${vimrc_home}/.config/nvim/init.vim"
  mkdir -p ${vimrc_home}/.config/nvim/colors
  mkdir -p ${vimrc_home}/.config/nvim/autoload
  cp -rf /tmp/${onedark_fdr}/colors/* ${vimrc_home}/.config/nvim/colors/
  echo "# Created ${vimrc_home}/.config/nvim/colors/onedark.vim"
  cp -rf /tmp/${onedark_fdr}/autoload/* ${vimrc_home}/.config/nvim/autoload/
  echo "# Created ${vimrc_home}/.config/nvim/autoload/onedark.vim"
  chown ${vimrc_user} -R ${vimrc_home}/.config/nvim 2> /dev/null
  if [ "${2}" == "lightline" ] ; then
    mkdir -p ${vimrc_home}/.config/nvim/plugin
    mkdir -p ${vimrc_home}/.config/nvim/autoload
    cp -rf /tmp/${lightline_fdr}/plugin/* ${vimrc_home}/.config/nvim/plugin/
    cp -rf /tmp/${lightline_fdr}/autoload/* ${vimrc_home}/.config/nvim/autoload/
    echo "# Created ${vimrc_home}/.vim/plugin/lightline.vim"
    chown ${vimrc_user} -R ${vimrc_home}/.config/nvim 2> /dev/null
  fi
}

# Check root permissions
function rootMessage() {
  mkdir -p /etc/root &> /dev/null
  administrator=$?
  if [ ${administrator} -eq 0 ] ; then
    rm -rf /etc/root
  else
    echo ""
    echo "* Administrator permissions are required"
    echo ""
    exit
  fi
}

function check_dependencies() {
  wget --help > /dev/null
  error=$?
  if [ ${error} -ne 0 ] ; then
    echo ""    
    echo "* Command 'wget' not installed."
    echo ""
    exit
  fi
}

# Generate configuration file
rootMessage
check_dependencies
cd /tmp
wget -c "${onedark_theme}" -O ${onedark_pkg}
unzip ${onedark_pkg}
wget -c "${lightline_repo}" -O ${lightline_pkg}
unzip ${lightline_pkg}
if [ ! -d ${onedark_fdr} ] ; then
  echo "# Failed downloading ${onedark_pkg} package"
  exit
fi
if [ ! -d ${lightline_fdr} ] ; then
  echo "# Failed downloading ${lightline_pkg} package"
  exit
fi
echo ""
#echo -n "# Do you want to install the lightline? (Y/n): " ; read custom_lightline
#if [ "${custom_lightline}" == "n" ] ; then
#  lightline=0
#else
#  lightline=1
#fi
lightline=1
list_users=$(ls -1 /home)
list_users="root ${list_users}"
for current_user in ${list_users} ; do
  if [ -d /home/${current_user} ] ; then
    if [ ${lightline} -eq 0 ] ; then
      create_config "${current_user}" nolightline
    else
      create_config "${current_user}" lightline
    fi
  elif [ -d /${current_user} ] ; then
    if [ ${lightline} -eq 0 ] ; then
      create_config "${current_user}" nolightline
    else
      create_config "${current_user}" lightline
    fi
  fi
done
rm -rf /tmp/${onedark_pkg}
rm -rf /tmp/${onedark_fdr}
rm -rf /tmp/${lightline_pkg}
rm -rf /tmp/${lightline_fdr}
