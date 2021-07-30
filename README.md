# MysteryPackage
A "mystery" package in SPARK/Ada

Tip: you can try this out on learn.adacore.com by hijacking one of their interactive examples, 
e.g. https://learn.adacore.com/labs/intro-to-ada/chapters/solutions.html#months.
However, you will need to change the name of 'Mystery_Package' to 'Months' to work with interactive example template.

A better solution is to get the necessary SPARK/Ada compilers, IDE, etc. at https://www.adacore.com/download (x86 GNU Linux). 
The download consists of an installer. One of the things it installs is gnatstudio, AdaCore's IDE. 
Once you have added the installation directory to your path (as directed by the automated installer), 
you can launch this IDE at the command line from anywhere with the command `gnatstudio`. 
If you're in the directory corresponding to this repository, you can use the command:
`gnatstudio -P default.gpr` to open this project from the command line.

On a clean installation of Ubuntu, you might get a message like the following:

`<install_location>/bin/gnatstudio_exe: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory`

This means you are missing a dependency. I was able to use `apt` to get it with the following command:
`sudo apt install libncurses5`

