# JamSesh [![Build Status](https://travis-ci.org/scalableinternetservices/JamSesh.svg?branch=master)](https://travis-ci.org/scalableinternetservices/JamSesh)
           __               _____           __  
          / /___ _____ ___ / ___/___  _____/ /_
     __  / / __ `/ __ `__ \\__ \/ _ \/ ___/ __ \
    / /_/ / /_/ / / / / / /__/ /  __(__  ) / / /
    \____/\__,_/_/ /_/ /_/____/\___/____/_/ /_/
    ---------------------------------------------

A web application to help musicians meet other musicians!


## Description

The basic idea is that there are a lot of musicians out in the world that only play by themselves or with play-along tracks because they don't have anyone to play with.
"JamSesh" would be a sort of musician's social network to which users would be able to post a profile with information such as:

* Instruments they play & proficiency
* Musical tastes (artists, genres)
* Location
* Typical availability to jam (weekends, nights, etc)

The network would allow musicians to meet each other and find other compatible people to ‘jam’ with. Maybe even down the line, we could add frequent groups or
“verified bands” and have a gig posting board to get them a place to play publicly.

Other ideas could be setting up a way to create jam 'events', where there might be a chat area to talk about that particular session, some file uploads or links
for pdfs of music/chords/tabs of the music they are going to playing, or even music suggestions based on the taste preferences each of the musicians have set.

I believe that there are already existing APIs, such as Spotify's API, that could be used to find similar artists and artists' "top tracks" to suggest more music to
play. Other APIs could be helpful as well.


## Potential Data Size Bottlenecks

The ability to find similar musicians to jam with could be come a bottleneck due to the problem size. The algorithm would probably be an "All Pairs Similarity Search" algorithm, with run time of O(n^2), which would make this part a very expensive operation.


## Potential Traffic Bottlenecks

What feature, or features, of your site might become a bottleneck due only to an increase in traffic (not database constrained)?

High traffic of requests that result in database I/O could become a bottleneck, as a database can only handle so many reads and writes at a time. Some features that may cause this are the event chats, profile edits, and file uploads.


## Team Members

Nick Brown ([@ncbrown1](https://github.com/ncbrown1))

<img src="https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAibAAAAJDk5ZmRhNjQ3LTM4YzktNDNlZC1hOWY3LTkyNzU2MDg0ZGVhOA.jpg)" title="ncbrown" height="250" />

John Mangel ([@jmangel](https://github.com/jmangel))

<img title="jmangel" src="https://avatars3.githubusercontent.com/u/6810760?v=3&s=466" height="250"/>

Jake Corina ([@jcorina](https://github.com/jcorina))

<img title="jcorina" src="https://seclab.cs.ucsb.edu/media/thumbs_cache/people/1422556240627_bw_person_picture.jpg" height="250" />

Shayan Sadigh ([@shayanpersonal](https://github.com/shayanpersonal))

<img title="shayanpersonal" src="https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAR4AAAAJDYzYTU5MTg1LTRlMDQtNGQxMS04YWI4LWMzMzgxY2U1YmM0MA.jpg" height="250" />


## Contributing

Check [this article](https://blog.hartleybrody.com/git-small-teams/) out, read it, and take it to heart. Adherence to his guidelines would be greatly appreciated.

## Support & Documentation

Visit http://docs.c9.io for support, or to learn more about using Cloud9 IDE.
To watch some training videos, visit http://www.youtube.com/user/c9ide
