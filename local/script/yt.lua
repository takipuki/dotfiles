#! /usr/bin/env lua

HELP = [[

stream youtube video/audio to mpv

Usage:
  yt [options] [query]

Options:
  -h                show this help
  -v                play video
  -n                print videos ids without playing
  -f<FORMAT>        yt-dlp format
  -s<QUERY>         interactively search and select videos (can be multiple)
  -i<VIDEO ID>      manually add id to play
]]

--- TODO directly given ids are played first; should play in the order of arguments
---      make searching a function and use it in getopts


SEARCH_URL  = "https://www.youtube.com/results?search_query="
SHOULD_PLAY = true          -- should play or just print the IDs
DLP_FORMAT  = "bestaudio"    -- play video or just audio
PLAYER_CMD  = "mpv -"        -- media player
COLS        = tonumber(os.getenv("COLUMNS"))
COLS        = COLS > 100 and 100 or COLS


local interactive_searches = {}   -- choose from search results
local non_i_searches = {}         -- auto choose first result
local ids = {}                    -- ids in this table will be played

-- parsing args
for _, argv in ipairs(arg) do
    if string.sub(argv, 1, 1) == '-' then
        local opt, val = argv:match('-(%a)(.*)')
        if     opt == 'v' then DLP_FORMAT = "bv[height<=2160]+ba"
        elseif opt == 'f' then DLP_FORMAT = val
        elseif opt == 'n' then SHOULD_PLAY = false
        elseif opt == 's' then table.insert(interactive_searches, val)
        elseif opt == 'i' then table.insert(ids, val)
        elseif opt == 'h' then print(HELP); os.exit()
        else print("Unknown option "..opt) os.exit()
        end
    else
        table.insert(non_i_searches, argv)
    end
end


-- starting the non_i_search processes
local non_i_query_processes = {}
for _,query in ipairs(non_i_searches) do
    local cmd =
        'curl '..SEARCH_URL..(query:gsub("%s+", "+"))..' -s |'..
        'sed -n "s/^.*ytInitialData = \\({.*}\\);<\\/.*$/\\1/p" |'..
        'jq ".contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents.[0].itemSectionRenderer.contents" |'..
        'jq ".[].videoRenderer | select(. != null)" |'..
        'jq -r ".videoId"'

    table.insert(non_i_query_processes, io.popen(cmd))
end

-- starting the i_search processes
local i_query_processes = {}
for _,query in ipairs(interactive_searches) do
    local cmd =
        'curl '..SEARCH_URL..(query:gsub("%s+", "+"))..' -s |'..
        'sed -n "s/^.*ytInitialData = \\({.*}\\);<\\/.*$/\\1/p" |'..
        'jq ".contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents.[0].itemSectionRenderer.contents" |'..
        'jq ".[].videoRenderer | select(. != null)" |'..
        'jq -r ".videoId, .title.runs.[0].text, .lengthText.simpleText"'

    table.insert(i_query_processes, io.popen(cmd))

    -- e.g. output of above command
    -- 9C7RJx49ZgM
    -- Jonathan Blow criticizes Valve
    -- 4:45
end


-- reading i_search results and taking user choices
for _,process in ipairs(i_query_processes) do
    local search_results = {}
    for i=0,9 do
        search_results[i+1] = process:read()
        print(string.format("%d %-"..(COLS-20)..'.'..(COLS-20).."s%10s",
            i, process:read(), process:read()))
    end
    process:close()

    io.write("Choose: ")
    local choice = io.read("*n")
    io.write("\n")

    table.insert(ids, search_results[choice+1])
end

-- reading non_i_search results and reading first id
for _,process in ipairs(non_i_query_processes) do
    local id = process:read()
    table.insert(ids, id)
    process:close()
end


local dlp_processes = {}
if SHOULD_PLAY then
    -- starting dlp downloads
    for _,id in ipairs(ids) do
        table.insert(dlp_processes, assert(io.popen(
            'yt-dlp -q -o - -f '.."'"..DLP_FORMAT.."'"..' -- '..id
        )))
    end

    -- playing downloads one by one
    for _,dlp_proc in ipairs(dlp_processes) do
        local player_proc = assert(io.popen(PLAYER_CMD, "w"))

        -- keep piping 100 bytes into player
        local media_raw = dlp_proc:read(100)
        while media_raw do
            player_proc:write(media_raw)
            media_raw = dlp_proc:read(100)
        end

        dlp_proc:close()
        player_proc:close()
    end

else
    for _,e in ipairs(ids) do
        print(e)
    end
end
