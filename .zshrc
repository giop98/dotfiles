# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/giovanni/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



# ---------------------------------------------------------------------------------------------------------------------------------------------------------- #

# Function used to compress video

compressione_video() {
	ffmpeg -i $1 -c:v libx264 -crf 40 -filter:v fps=fps=20 -c:a libopus -application voip -ab 16k -ac 1 -cutoff 12000 $2
}

# ---------------------------------------------------------------------------------------------------------------------------------------------------------- #

# Export use for Homebrew, because some formulae are installed in the /usr/local/sbin path.
# So we need to export the path in order for the system to recognise the formulae. 
# Uncomment when something goes wrong

# export PATH="/usr/local/sbin:$PATH"

# ---------------------------------------------------------------------------------------------------------------------------------------------------------- #

# Use python3 as default

alias python=python3

# ---------------------------------------------------------------------------------------------------------------------------------------------------------- #

# Use to launch gtkwave. I follow this guide (https://ughe.github.io/2018/11/06/gtkwave-osx)

export PATH=/Applications/gtkwave.app/Contents/Resources/bin/:$PATH

# ---------------------------------------------------------------------------------------------------------------------------------------------------------- #

# Function use to compile VHDL project

compile_VHDL(){
	if [ "$#" -eq 1 ]
	then
    		entity=$1
		ghdl -a $entity	
	fi
	if [ "$#" -ge 2 ] 
	then
                entity=$1
        	tb_ext=$2
        	tb_no_ext=${tb_ext%.*}
        	ghdl -a $entity
        	ghdl -a $tb_ext
        	ghdl -e $tb_no_ext
		if [ "$#" -ge  3 ] 
		then
			stop_time=$3			
			ghdl -r $tb_no_ext --wave=w.ghw --stop-time="$stop_time"ns
			
			if [ $? -eq 0 ]
			then
				gtkwave w.ghw &
			fi	
		else
        		ghdl -r $tb_no_ext --wave=w.ghw
                     	
			if [ $? -eq 0 ]
                        then    
                                gtkwave w.ghw &
                        fi
		fi
        fi
}

# ---------------------------------------------------------------------------------------------------------------------------------------------------------- #

# Function to compile verilog 

compile_verilog(){
	iverilog -o out.vvp $1
	vvp out.vvp
	gtkwave waveform.vcd &
}

# Function to download youtube video or playlist in best quality with mp4 output format
download_youtube(){
	if [ "$#" -eq 2 ]
	then
		youtube-dl -f "bestvideo[height<=$1][ext=mp4]+bestaudio[ext=m4a]" $2
	else
		echo "First parameter height of the video (i.e 1080), second parameter url of the video/playlist"	
	fi
}

# To launch powerlevel 10k
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
