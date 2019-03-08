function fish_greeting
	set_color white
	uname -nmsr
	if type -q uptime
		uptime
	end
	echo ""

	if type -q lolcat; and type -q fortune
		fortune -a | lolcat
	else if type -q fortune
		fortune -a
	end
	echo ""
end
