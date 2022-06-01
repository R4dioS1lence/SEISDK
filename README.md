# Space Engineers Ingame Scripts Development Kit

This is a development kit that works on both Windows and Linux for creating Ingame Scripts for the [Space Engineers](https://www.spaceengineersgame.com) game.
The script based on reksar's Toolkit (that didn't work for me) and the invaluable help of Insane Monkey Posse.

**Features**
* [IntelliSense](https://code.visualstudio.com/docs/editor/intellisense) for the game API (DLLs are plugged in via `SpaceEngineers.csproj` file)
* Automated configuration of the environment with the game installation path via VS Code Task
* Automated creation of new script files from a single Template via VS Code Task
* Automated deployment of written scripts to the game folder via VS Code Build Task

# Setup

## Programs, Extensions and SDKs Needed to use the Toolkit

* [VS Code](https://code.visualstudio.com/)
  * [C# Extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)
  * [NuGet Package Manager](https://marketplace.visualstudio.com/items?itemName=jmrog.vscode-nuget-package-manager)
* [.NET SDK](https://dotnet.microsoft.com/)

VS Code requires both extensions: `C#` to make it understand C# code and apply IntelliSense; and `NuGet Package Manager` to help it understand and apply the game's DLLs via the .csproj (?).
I'm sure about how the first one works, but the second is black magic (the best kind of magic).

## Configuration of the Toolkit

First, you need to modify the path to the game that is inside the SpaceEngineers.csproj file to the path of your game.
You can get the path where you installed on your system by right-clicking the game on your Steam Library list, then go to "Manage", and then "Browse Local Files...".
This will open a folder window where the files are. From there, click on the path above list of folders, and copy the full path.
After that, run the Task `Update SpaceEngineers.csporj file with game path` and paste the full path you got from the explorer folder given by Steam.

# Usage

## Update Game Installation Path

Run `Update SpaceEngineers.csporj file with game path` task from `Terminal`->`Run Task...` menu by selecting it from the given dropdown menu.

Then paste the path where Space Engineers is installed. You can get this path by right-clicking the game on your Steam Library list, then go to `"Manage"`, and then `"Browse Local Files..."`.

This will open a folder window where you can copy the full path to the installed folder. Then, paste that full path into the Task prompt box.

## Create a new script

Run `Create Space Engineers script` task from `Terminal`->`Run Task...` menu by selecting it from the given dropdown menu.

Then enter a name for your new script. It must be both a valid directory name and a valid C# namespace/region identifier.

## Export to the game

On an open script, run a Build Task on VS Code through either the shortcut `Ctrl + Shift + B` or `Terminal`->`Run Task...`->`Run Build Task`. This will deploy that script to the game files.

# TO-DO List

* Add Linux version of `create`, `deploy` and `update_game_path` scripts

# Final Disclaime

Finding toolkits and even explanations on how to get things going was such a pain, that I was about to give up scripting for this game.
After trying to get information on how to not use Timer Blocks on Steam Discussions, in hope I would end up getting turned into the right direction, I learned that auto-updating was patched in 2017, removing the need for them (I was only finding results THAT old).
Then, from searching the method used for auto-updating, I ran into [this project](https://github.com/gregretkowski/VSC-SE), last updated on 2018 that didn't work for me, and later after that, [this other project](https://github.com/reksar/SpaceEngineers), last updated on 2021 (NEW!) that still didn't work for me (*grumbling noises*).
Then, on the [Space Engineers Discord](https://discord.com/invite/keenswh), I got helped by the insanely helpful Insane Monkey Posse, that helped me correct the .csproj file and understand the basics until I was good enough to bash my head against the keyboard and successfully  generate a Hello World.
Since one of the problems that I ran into was the VS Code trying to run batch scripts into a Powershell, and another was not having downloaded Git for Windows because the configuration scripts needed a steam text editor that was bundled on it, I decided to rewrite the batch scripts into Powershell scripts, which also removed the need for Git's bundled stream text editor (Powershell can do that).
I never did Powershell stuff, so expect it to be ugly if you know your way around it.
I also wanted to make this project a Windows + Linux option, since VS Code is nice enough to make you able to make Tasks that can run differently on either OS, while developing for both at the same time (used this a lot when learning Javascript with VS Code).
There may be enough scripts available around the Steam's Workshop, but I don't care. The whole premise about this game is for players to create, that's what I'll do, and that's what this project intends to make it easier for people to do too (at least on scripting side).
