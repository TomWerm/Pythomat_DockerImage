SET SRC_PATH=%cd%
SET IMAGE_NAME=thomasweber/pythomatdocker:latest
SET CONTAINER_PATH=/usr
FOR /F "tokens=*" %%g IN ('dir Solution /ad /s /b') do (SET SOLUTION_PATH=%%g)
docker run -it -v "%SRC_PATH%\pythomat.zip":/prod/pythomat.zip -v "%SOLUTION_PATH%":/prod/solution/ -w /prod/ --cap-drop ALL %IMAGE_NAME%
start firefox -private-window "file:///%SOLUTION_PATH%/solution.html"