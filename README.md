# pdfer
This is a CLI tool that streamlines a workflow for generating PDFs from the academic zoom based recordings.
We presently support .mp4 format of video since this is in Beta.

## Install
<pre>
curl -O -L https://raw.githubusercontent.com/Vaigyanik-Jinger/pdfer/main/install.sh && bash install.sh && rm install.sh
</pre>

## Uninstall (Bash)
<pre>
rm -r ~/Pdfer && sed -i '/pdfer/d' ~/.bashrc
</pre>
IF you have some other shell, just chnage the config file name. 
for example, if you have a zsh shell, just replace `.bashrc` with `.zshrc`
