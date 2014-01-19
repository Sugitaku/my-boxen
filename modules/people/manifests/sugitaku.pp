class people::sugitaku {

  # os x
  include osx::finder::show_all_on_desktop

  include osx::dock::autohide
  class { 'osx::dock::icon_size':
    size => 18
  }

  include osx::no_network_dsstores
  include osx::software_update

  # local application
  include appcleaner
  include chrome
  include chrome::chromium
  include cord
  include dropbox
  include iterm2::stable
  include java
  include skype
  include sublime_text_2
  sublime_text_2::package { 'Emmet':
    source => 'sergeche/emmet-sublime'
  }
  include transmit
  include tunnelblick::beta
  include vagrant
  include virtualbox

  package {
    'GomPlayer':
      source => "http://app.gomtv.com/GOMForMac/gom.pkg",
      provider => pkgdmg;
    'GoogleJapaneseInput':
      source => "http://dl.google.com/japanese-ime/latest/GoogleJapaneseInput.dmg",
      provider => pkgdmg;
    'LimeChatForMac':
      source => "https://downloads.sourceforge.net/project/limechat/limechat/LimeChat_2.39.tbz",
      provider => compressed_app;
    'SophosAntivirusForMac':
      source => "http://downloads.sophos.com/home-edition/savosx_90_he.zip",
      provider => compressed_app;
  }

  # homebrew
  package {
    [
      'emacs',
      'gawk',
      'gnu-sed',
      'gnu-time',
      'tmux',
      'tig',
      'tree',
      'wget',
      'zsh',
    ]:
  }

  # ricty font
  homebrew::tap { 'sanemat/font': }
  package { 'sanemat/font/ricty':
    require => Homebrew::Tap["sanemat/font"]
  }
  exec { 'set ricty':
    command => "cp -f ${homebrew::config::installdir}/share/fonts/Ricty*.ttf ~/Library/Fonts/ && fc-cache -vf",
    require => Package["sanemat/font/ricty"]
  }

  $home = "/Users/${::boxen_user}"

  # dotfile
  $dotfiles = "${home}/dotfiles"
  repository { $dotfiles:
    source => 'Sugitaku/dotfiles',
  } 
  file { "${home}/.zshrc":
    ensure => link,
    target => "${dotfiles}/.zshrc"
  }
  file { "${home}/.tmux.conf":
    ensure => link,
    target => "${dotfiles}/.tmux.conf"
  }
  file { "${dotfiles}/.emacs.d/conf":
    ensure => directory
  }
  file { "${home}/.emacs.d":
    ensure => link,
    target => "${dotfiles}/.emacs.d/"
  }
  osx_chsh { $::luser:
    shell => "${boxen::config::homebrewdir}/bin/zsh";
  }
}
