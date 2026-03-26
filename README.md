# Ableton-renderoor
Automation tools for rendering folders of Ableton projects.

* Only works on Windows (because it uses powershell) but may create a Mac automator script in the future.
* Has zero logic for filtering files, simply renders all als files.
* Has no logic for output folder, the last folder you rendered to will always be used.
* Minimizing Ableton will cause the script to fail, unexpected dialogs and prompts in Ableton will cause the script to fail.
* Has fixed logic for how long it waits to render the projects
* TLDR; lower your expectations for now.

# Usage
Copy the ableton_renderoor.ps1 file to a folder and from PowerShell start the script:

```
copy ableton-renderoor.ps1 C:\Music-Sort\Music\projects
cd C:\Music-Sort\Music\projects
.\ableton-renderoor.ps1
```

# Troubleshooting
If you are having permission isssues with running the PowerShell script, you need to enable PowerShell scripting with the following command:

```
Set-ExecutionPolicy RemoteSigned
```
