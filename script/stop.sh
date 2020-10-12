
#!/bin/bash
kill -9 $(lsof -t -i:8000)


# chmod a+x stop.sh