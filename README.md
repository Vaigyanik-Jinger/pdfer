# pdfer
This is a CLI tool that streamlines a workflow for generating PDFs from the academic zoom based recordings.
We presently support .mp4 format of video since this is in Beta.

## Install (debian or WSL(debian))
~~~
curl -O -L https://raw.githubusercontent.com/Vaigyanik-Jinger/pdfer/main/install.sh && bash install.sh && rm install.sh
~~~

## Install (Other linux distributions)
Clone the Git repo. Change the name of the package manager to your package manager in the `install.sh` and just run the install commands. 

## Uninstall (Bash)
~~~
rm -r ~/Pdfer && sed -i '/pdfer/d' ~/.bashrc
~~~
IF you have some other shell, just chnage the config file name. 
for example, if you have a zsh shell, just replace `.bashrc` with `.zshrc`

## Troubleshooting
It is known issue that while running the install command, the script tends to get stuck. 
Don't be scared to hit `Ctrl-C` every time the script is stuck. Re-Run multiple times. 

The script cleans any leftover codes abnd files so re-running the script won't mess up your machine. 
