This script installs the various Box for Business applications on a Windows machine.

**DISCLAIMERS:**

You will need to have a Box for Business account to download the necessary binaries and executables for this script to work.

The binaries will need to be placed in an installers subdirectory in the same directory as the script and named according to the names in the script.

**INFO:**

During the install process it will install the .Net 4.0 and Visual Studio Tools prerequisites.

When the time comes to install the applications it will verify Microsoft Office bit version to install the proper versions of the software.

It will also create a log file in a 'logs' subdirectory located in the same location as the install script and will append the username of the person running the script.