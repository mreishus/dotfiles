#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use File::Copy;

my $h = $ENV{HOME};

# old files - .screenrc .tmux-powerlinerc .tmux.conf
foreach my $file (qw(.vimrc .ackrc .ctags .ssh/config .eslintrc .tmux.conf.local)) {
    next if -l "$h/$file";
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

# oh-my-tmux 
if (!-d "$h/.tmux") {
    system("git clone https://github.com/gpakosz/.tmux.git $h/.tmux");
    system("ln -s $h/.tmux/.tmux.conf $h/.tmux.conf");
}
