SRC_PATH=%cd%
IMAGE_NAME=thomasweber/pythomatdocker:latest
CONTAINER_PATH=/usr
docker pull $IMAGE_NAME
SOLUTION_PATH=$(find . -type d -name "solution")
docker run -it -v "$SRC_PATH\pythomat.zip":/prod/pythomat.zip -v "$SOLUTION_PATH":/prod/solution/ -w /prod/ --cap-drop ALL $IMAGE_NAME
xdg-open "file:///$SOLUTION_PATH/solution.html"