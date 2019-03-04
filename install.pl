#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use File::Copy;

my $h = $ENV{HOME};

system("mkdir -p $h/.ssh/sockets");

# old files - .screenrc .tmux.conf
foreach my $file (qw(.vimrc .ssh/config .tmux.conf.local)) {
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

# oh-my-tmux
if (!-d "$h/.tmux") {
    system("git clone https://github.com/gpakosz/.tmux.git $h/.tmux");
    system("ln -s $h/.tmux/.tmux.conf $h/.tmux.conf");
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

say "\nSetting git name+email...\n";
system("git config --global user.name \"Matthew Reishus\"");
system("git config --global user.email \"mreishus\@users.noreply.github.com\"");
