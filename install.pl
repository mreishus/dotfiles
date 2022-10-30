#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use File::Copy;

my $h = $ENV{HOME};

system("mkdir -p $h/bin");
system("mkdir -p $h/.ssh/sockets");
system("mkdir -p $h/.config/fish");
system("mkdir -p $h/.config/nvim");
system("mkdir -p $h/.config/nvim/vimrc");
system("mkdir -p $h/.config/i3");
system("mkdir -p $h/.config/dunst");
system("mkdir -p $h/.config/plasma-workspace/env");
system("mkdir -p $h/.tmux/plugins");
system("mkdir -p $h/.backup");
system("mkdir -p $h/.xmonad");

# Doom Emacs
if (!-d "$h/.emacs.d") {
    system("git clone --depth 1 https://github.com/hlissner/doom-emacs $h/.emacs.d");
    system("$h/.emacs.d/bin/doom install");
    say "\nDoes 'doom sync' work from shell?\nConsider running..\nset -Ua fish_user_paths ~/.emacs.d/bin\n";
}

foreach my $file (qw(.vimrc .ssh/config
    .tmux.conf
    .tmux.conf.local
    .config/nvim/init.vim .config/nvim/vimrc/menu.vim .config/fish/config.fish
    bin/up
    bin/fix-zeal
    bin/what-swap
    bin/magit
    .doom.d/config.el
    .doom.d/init.el
    .doom.d/packages.el
    .doom.d/+bindings.el
    .doom.d/+org.el
    .xmonad/startup-applications
    .xmonad/xmonad.hs
    .config/i3/config
    .config/plasma-workspace/env/wm.sh
    .config/dunst/dunstrc
    )) {
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

# yearly sub homedir
# ~/h20/     <- for 2020
# ~/h21/     <- for 2021
# etc
my $year = 1900 + (localtime)[5] - 2000;
my $base = "$h/h$year";
if (!-d "$base") {
    system("mkdir $base")
}

foreach my $thing (qw(dev edu misc txt)) {
    if (!-d "$base/$thing") {
        system("mkdir $base/$thing")
    }
}

# logbook
if (!-d "$base/txt") {
    system("mkdir $base/txt");
}

# logbook
if (!-d "$base/txt/logbook") {
    print "Install logbook? [y/n] \n";
    chomp(my $ok = <>);
    my $yes = 'y';
    if ($ok eq $yes) {
        system("git clone git\@bitbucket.org:mreishus/logbook.git $base/txt/logbook");
        system("$base/txt/logbook/install.pl");
    }
}

# orgbook
if (!-d "$base/txt/orgbook") {
    print "Install orgbook? [y/n] \n";
    chomp(my $ok = <>);
    my $yes = 'y';
    if ($ok eq $yes) {
        system("git clone git\@bitbucket.org:mreishus/orgbook.git $base/txt/orgbook");
        #system("$base/txt/orgbook/install.pl");
    }
}

# link ~/h20/org to ~/h20/txt/orgbook
if (!-d "$base/org" && !-l "$base/org" && -d "$base/txt/orgbook") {
    say "Added link $base/org -> $base/txt/orgbook";
    system("ln -s $base/txt/orgbook $base/org");
}

# pandoc-starter
if (!-d "$base/txt/pandoc-starter") {
    system("git clone git\@github.com:jez/pandoc-starter.git $base/txt/pandoc-starter");
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

say "\nSetting git name+email...\n";
system("git config --global user.name \"Matthew Reishus\"");
system("git config --global user.email \"mreishus\@users.noreply.github.com\"");

say "\nConsider running...\nyarn config set --home enableTelemetry 0\n";

# set -U fish_color_cwd cyan
