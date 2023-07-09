function sudo
	env SHELL=(which fish) sudo -sE $argv
end
