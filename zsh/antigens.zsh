source $DOTS/zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen-lib

# Syntax highlighting bundle.
antigen-bundle zsh-users/zsh-syntax-highlighting

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen-bundle git
antigen-bundle command-not-found
antigen-bundle zsh-users/zsh-history-substring-search

antigen-theme joshashby

# Tell antigen that you're done.
antigen-apply
