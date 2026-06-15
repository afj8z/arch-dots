# FZF stuff
export FZF_DEFAULT_COMMAND='fd --type file --hidden'
export FZF_DEFAULT_OPTS="--highlight-line --margin 0 --padding 0
	--no-scrollbar --gutter=' ' --border=none 
    --ansi 
    --prompt='> ' 
    --pointer='>' 
	--preview-border='none'
    --color='16,bg:-1,bg+:8,prompt:7,marker:7,pointer:7,info:7,header-border:0,header-label:15' \
	--info=inline-right --no-separator"
export FZF_TMUX=0
export FZF_CTRL_R_OPTS='--scrollbar="" --gutter=" " --reverse'

# use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--info=inline'

export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'
