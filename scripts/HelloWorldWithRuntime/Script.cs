// Default C# Libraries
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using System.Text;

// Space Engineers DLLs
using Sandbox.ModAPI.Ingame;
using Sandbox.ModAPI.Interfaces;
using Sandbox.Game.EntityComponents;
using VRage;
using VRageMath;
using VRage.Game;
using VRage.Game.GUI.TextPanel;
using VRage.Game.ModAPI.Ingame.Utilities;
using VRage.Collections;
using VRage.Game.Components;
using VRage.Game.ObjectBuilders.Definitions;
using VRage.Game.ModAPI.Ingame;
using SpaceEngineers.Game.ModAPI.Ingame;

/*
 * Must be unique per each script project.
 * Prevents collisions of multiple `class Program` declarations.
 * Will be used to detect the ingame script region, whose name is the same.
 */
namespace HelloWorldWithRuntime {

/*
 * Do not change this declaration because this is the game requirement.
 */
public class Program : MyGridProgram {

    /*
     * Must be same as the namespace. Will be used for automatic script export.
     * The code inside this region is the ingame script.
     */
    #region HelloWorldWithRuntime

    
    /*
     * The constructor, called only once every session and always before any 
     * other method is called. Use it to initialize your script. 
     *    
     * The constructor is optional and can be removed if not needed.
     
     * It's recommended to set RuntimeInfo.UpdateFrequency here, which will 
     * allow your script to run itself without a timer block.
     */

     class Display {
         public IMyTerminalBlock terminalBlock;
         public IMyTextSurfaceProvider surfaceProvider;
         public Display(IMyTextSurfaceProvider targetBlock){
             terminalBlock = (IMyTerminalBlock)targetBlock;
             surfaceProvider = (IMyTextSurfaceProvider)targetBlock;
         }
     }
    string[] ticker = {"--","/","|","\\"};
    int tickerPos = 0;
    List<Display> displayList = new List<Display>();
     
    public Program() {
        Runtime.UpdateFrequency = UpdateFrequency.Update10;

        displayList.Add(new Display((IMyTextSurfaceProvider)GridTerminalSystem.GetBlockWithName("target")));
        Echo (displayList[0].surfaceProvider.SurfaceCount.ToString());
        for (int i = 0; i < displayList[0].surfaceProvider.SurfaceCount; i++) {
            displayList[0].surfaceProvider.GetSurface(i).Alignment = TextAlignment.CENTER;
            displayList[0].surfaceProvider.GetSurface(i).FontColor = Color.White;
            displayList[0].surfaceProvider.GetSurface(i).BackgroundColor = Color.Black;
        }
    }
    
    /*
     * Called when the program needs to save its state. Use this method to save
     * your state to the Storage field or some other means. 
     * 
     * This method is optional and can be removed if not needed.
     */
    public void Save() {}

    /*
     * The main entry point of the script, invoked every time one of the 
     * programmable block's Run actions are invoked, or the script updates 
     * itself. The updateSource argument describes where the update came from.
     * 
     * The method itself is required, but the arguments above can be removed 
     * if not needed.
     */
    public void Main(string argument, UpdateType updateSource) {
        
        for (int i = 0; i < displayList[0].surfaceProvider.SurfaceCount; i++) {
            displayList[0].surfaceProvider.GetSurface(i).WriteText(ticker[tickerPos], false);
        }
        tickerPos++;
        tickerPos = tickerPos % 4;
    }

    #endregion // HelloWorldWithRuntime
}}
