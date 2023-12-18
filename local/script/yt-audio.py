from youtube_search import YoutubeSearch as ytsearch
import subprocess
import sys
import getopt

PLAYER_CMD = "mpv"
MAX_RESULTS = 10
ARGV = sys.argv[1:]

try:
    opts, args = getopt.getopt(ARGV, "h:s:l:d:")
except getopt.GetoptError:
    print("Error: Unknown Options")

if not opts:
    print(f"""Usage:
  {sys.argv[0]} <query>       Choses the first result
  {sys.argv[0]} -l <url>      Plays the given url
  {sys.argv[0]} -s <query>    Gives search results""")


def search_n_choose(query):
    results = ytsearch(query, max_results=MAX_RESULTS).to_dict()

    for i in range(len(results)):
        v = results[i]
        print("{:>2}  {:<100} {:>10}".format(i,
                                             v["title"],
                                             v["duration"].strip()))

    choice = int(input("Choose: "))
    if (choice < 10):
        print(results[choice]["id"])
        return results[choice]["id"]


url_or_ids = []
downloads = []
for opt, arg in opts:
    if opt in ['-s']:
        url_or_ids.append(search_n_choose(arg))

    elif opt in ['-l']:
        url_or_ids.append(arg)

    elif opt in ['-d']:
        downloads.append(search_n_choose(arg))

for arg in args:
    url_or_ids.append(
        ytsearch(arg, max_results=1).to_dict()[0]["id"]
    )

for video in url_or_ids:
    command = f'yt-dlp -o - -q -f ba {video} | {PLAYER_CMD} -',
    subprocess.run(command, shell=True, text=True)

for video in downloads:
    print(video)
