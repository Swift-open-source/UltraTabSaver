<h1>
      <div class="row">
         <div class="column" align = "right" >
           <img src = "UltraTabSaver.png" alt="Logo UTN" width="90"></a></div>
        </div>
        <div class="column" align= "center"> 
           Ultra TabSaver
          <h6>
            The open source Tab Manager for Safari.
          </h6>
        </div>
      </div>
</h1>

![](Ultra-TabSaver.gif)

## Table of Contents
- [Features](#features)
- [How to use it](#how-to-use-it)
- [How does it work](#how-does-it-work)
- [Building and running](#building-and-running)
- [To do list](#to-do-list)
- [Contributing](#contributing)
- [License](#license)
- [Thanks to](#thanks-to)
- **[README en español](README-spanish.md)**

## Update
- **[Promotional Video](https://www.youtube.com/watch?v=PNPAnn-jOCE)**
- **Thank you for all the feedback, now that I know that many people find it useful I'll publish it to the App Store soon.**

## Features
This extension adds 3 main Features to Safari:
* Save the current tab
* Save all the tabs in a window (a Tab Group)
* Get a Tab or a Tab Group. In the Tab Group you got this functionalities:
   * Open all the Tabs with only 1 click
   * Rename Tab Group.
   * Copy all the tabs to the clipboard
   * Add url to  the Tab Group
   * Delete a Tab Group
   * Delete a Tab inside a Tab Group
   
   
## How to use it?
Pressing the extension icon or right click at any website this menu will open
* Save the current tab
* Save all the tabs in a window (a Tab Group)
* Get All Tabs. By pressing left click all the Tab Groups will show. If you press left click in a Tab Group all the tabs will open in the current window, and if you press right click in a Tab Group a new menu will be shown with this options:
   * Copy all the tabs to the clipboard
   * Add url to  the Tab Group
   * Delete a Tab Group
   * Delete a Tab inside a Tab Group
   * Rename the Tab group (*This option is accessible only by clicking the extension Icon*).
* **By pressing right click in a URL (Tab Group -> URL) you can copy to the clipboard or delete it**
 
 
## How does it work?
When you select in Save Tab/Save All tab the extension get all the URL's of the Tabs in the current window and save them in the NSUserDefaults. 
All the Tabs are saved with a key, that key is the Tab Group name, that's why can't be two Tab Groups with the same name.

## Building and running
To run  you'll need to change the Xcode project settings for code signing to use your own certificate, or to not sign. To use an unsigned extension in Safari, you must check "Allow Unsigned Extensions" from Safari's "Develop" menu. If you don't have the "Develop" menu, you can enable it in the Advanced tab of Safari's prefs.
For more info look [here](https://blog.yimingliu.com/2018/11/14/notes-on-porting-a-safari-extension-to-a-safari-app-extension/) in **How to debug**. If you need help just open an issue and I'll give a step by step guide. 

## To do list
- Boost performance (clicking the icon delays 3 seconds to show the pop up)
- Compile and upload this extension to the App Store.(I'll do it if someone find this extension usefull)
- Enable drag and drop URL through the Tab Groups.
- Enable key shortcuts.

## Contributing

#### Step 1

- **Option 1**
    - 🍴 Fork this repo!

- **Option 2**
    - 🐑 🐑 Clone this repo to your local machine using `git clone https://github.com/morsamatias/UltraTabSaver.git`

#### Step 2

- **HACK AWAY!** 🔨🔨🔨

#### Step 3

- 🔃 Create a new pull request using <a href="https://github.com/morsamatias/UltraTabSaver/compare/develop...yourbranch" target="_blank">`https://github.com/morsamatias/UltraTabSaver/compare/`</a>.

## License

- **[GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)**
- Copyright 2020 © <a href="https://www.linkedin.com/in/morsamatias" target="_blank">Matias Morsa</a>.
- This proyect is and always is going to be open source.
---
## Thanks to
- [panicsteve/my-first-safari-extension](https://github.com/panicsteve/my-first-safari-extension)
- [fvcproductions/sampleREADME.md](https://gist.github.com/fvcproductions/1bfc2d4aecb01a834b46)
- [How to Create a Safari Extension from Scratch](https://blog.yimingliu.com/2018/11/14/notes-on-porting-a-safari-extension-to-a-safari-app-extension/)
