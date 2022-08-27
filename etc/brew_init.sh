#!/usr/bin/env bash

# 应用列表
brew_formula=(
    # 版本管理工具
    git
    # java项目构建与依赖管理工具
    # maven
    # GNU 核心工具 
    coreutils
    # brew安装图形化app工具
    cask
    # AppStore 命令行安装（根据识别码安装）
    mas

  )
app_store=(
  # 优酷
  # 1014945607
  # Amphetamine（控制系统休眠）
  # 937984704
  # The Unarchiver（解压缩）
  425424353
  # Xcode
  497799835
  # Coinverter（汇率查询）
  # 926121450
  # QQ
  451108668
  # 微信
  836500024
  # QQ音乐
  595615424
  # 爱奇艺
  # 1012296988

  # Word
  462054704
  # Excel
  462058435
  # OneNote
  784801555
  # PowerPoint
  462062816
  )

brew_cask=(
    # 替换系统自带vim
    # macvim
    # 终端
    iterm2
    # google浏览器
    google-chrome
    # 系统效率工具
    # alfred
    # 文档工具
    # dash
    # 文本编辑器
    visual-studio-code
    # http请求模拟app
    postman
    # 流程图绘制工具
    drawio
    # 虚拟机
    # 激活码
    # ZF3R0-FHED2-M80TY-8QYGC-NPKYF
    # YF390-0HF8P-M81RQ-2DXQE-M2UT6
    # ZF71R-DMX85-08DQY-8YMNC-PPHV8
    # AZ3E8-DCD8J-0842Z-N6NZE-XPKYF
    # FC11K-00DE0-0800Z-04Z5E-MC8T6
    # vmware-fusion
    # 密码管理
    macpass
    # markdown编辑器
    typora
    # ide编辑器
    intellij-idea-ce
    # 笔记工具
    notion
     #容器工具
    docker
    # 窗口大小控制工具
    rectangle
    # 菜单栏图标隐藏工具
    #dozer
    # 截图工具
    snipaste
    # 剪切板工具
    clipy
    # 翻译工具
    bob
    # mac系统监控优化工具
    # cleanmymac
    # NTFS磁盘兼容工具（提供写入功能）
    mounty
    # 科学上网
    #V2rayu
)


# 检测本机是否已经安装 brew
if command -v brew >/dev/null 2>&1;then
  echo 'brew 已安装'
  else
    read -p "应用安装依赖brew，是否安装brew（y/n）" isInstallBrew
    if [ $isInstallBrew = 'y' ];then
    # 自动替换国内源的脚本
    /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
    # 原版国外源（国内速度较慢）
    # sudo /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
      echo 'exit;'
      exit
    fi
fi

# 确保使用的是最新的 brew
brew update

# 确保 brew 安装的是最新的 formulae.
brew upgrade

# 保存 brew 本身的安装路径
# BREW_PREFIX=$(brew --prefix)

read -p "开始安装app(y/n)？" isStart
if [ $isStart = 'y' ];then
  install
else
  echo 'exit;'
  exit
fi

# 进行安装的方法
install(){
  echo '开始安装 ==> from brew formula'
  (set -x
  brew install ${brew_formula[@]}
  )
  echo '开始安装 ==> from brew cask'
  (set -x
  brew install --cask ${brew_cask[@]}
  )
  echo '开始安装 ==> from appStore'
  (set -x
  mas install ${app_store[@]}
  )

  echo '本次安装的app列表如下'
  echo "[brew_formula]: ${brew_formula[@]}"
  echo "[brew_cask]: ${brew_cask[@]}"
  echo "[appStore]" ${app_store[@]}
}

# GNU的软链接配置
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
#ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# 移除旧版本的软件包
brew cleanup
