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
  include chrome
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

  package {
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
      'tmux',
      'tig',
      'zsh',
    ]:
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
