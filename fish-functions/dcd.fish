# DCD using broot: https://dystroy.org/broot/tricks/
# "Deep CD" - "I'm feeling lucky"
# dcd some-directory
function dcd
  br --only-folders --cmd "$argv[1];:cd"
end
