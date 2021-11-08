# Put the dock on the bottom
defaults write com.apple.dock "orientation" -string "bottom"

# Set the icon dimension on the dock to 16 pixels
defaults write com.apple.dock tilesize -int 16

# Set the window animation to scale. The other option is "genie"
defaults write com.apple.dock mineffect -string "scale"

# Don't minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
# defaults write com.apple.dock static-only -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Set to 0.5 the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Reset the dock to enable changes 
killall Dock