#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use File::Copy;

my $h = $ENV{HOME};

system("mkdir -p $h/.ssh/sockets");
system("mkdir -p $h/.config/nvim");
system("mkdir -p $h/.config/nvim/vimrc");
system("mkdir -p $h/.tmux/plugins");

foreach my $file (qw(.vimrc .ssh/config .tmux.conf .config/nvim/init.vim .config/nvim/vimrc/menu.vim .spacemacs)) {
    next if -l "$h/$file"; # Skip ones that are already linked, assumed that we made them
    if (!-e "$h/dotfiles/$file") {
        say "Can't find [$h/dotfiles/$file], quitting.  This isn't currently configurable, so put the git project here.\n";
        exit;
    }
    if (-e "$h/$file") {
        chomp(my $dt = `date --rfc-3339=seconds`);
        $dt =~ s/ /-/g;
        move("$h/$file", "$h/$file.bak.$dt");
        say "Moved $h/$file to $h/$file.bak.$dt to make way";
    }
    system("ln -s $h/dotfiles/$file $h/$file");
    say "Added link $h/$file -> $h/dotfiles/$file";
}

# logbook
if (!-d "$h/txt") {
    system("mkdir $h/txt");
}
if (!-d "$h/txt/logbook") {
    system("git clone git\@bitbucket.org:mreishus/logbook.git $h/txt/logbook");
    system("$h/txt/logbook/install.pl");
}

# pandoc-starter
if (!-d "$h/txt/pandoc-starter") {
    system("git clone git\@github.com:mreishus/pandoc-starter.git $h/txt/pandoc-starter");
}

# fish functions
system("mkdir -p $h/.config/fish");
my $fun = ".config/fish/functions";
if (!-l "$h/$fun") { # Do nothing if it's already linked
    if (-e "$h/$fun") {
        chomp(my $dt = `date --rfc-3339=seconds`);
        $dt =~ s/ /-/g;
        move("$h/$fun", "$h/$fun.bak.$dt");
        say "Moved $h/$fun to $h/$fun.bak.$dt to make way";
    }
    system("ln -s $h/dotfiles/fish-functions $h/$fun");
    say "Added link $h/$fun -> $h/dotfiles/fish-functions";
}

# tmux plugin manager
if (!-d "$h/.tmux/plugins/tpm") {
    system("git clone https://github.com/tmux-plugins/tpm $h/.tmux/plugins/tpm");
}

# spacemacs
if (!-d "$h/.emacs.d") {
    system("git clone -b develop https://github.com/syl20bnr/spacemacs $h/.emacs.d");
}
# spacemacs-fzf
if (!-d "$h/.emacs.d/private/fzf") {
    system("git clone git\@github.com:ashyisme/fzf-spacemacs-layer.git $h/.emacs.d/private/fzf");
}

say "\nSetting git name+email...\n";
system("git config --global user.name \"Matthew Reishus\"");
system("git config --global user.email \"mreishus\@users.noreply.github.com\"");

# set -U fish_color_cwd cyan
#
# reminder to pull in the spacemacs directory and to regenerate the .spacemacs file sometimes (don't remember command that shows diff)
