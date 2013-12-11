class people::sugitaku {
  include chrome
  include dropbox
  include iterm2::stable
  include skype
  include transmit

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

  package {
    [
      'emacs',
      'tmux',
      'tig',
      'zsh',
    ]:
  }
}
