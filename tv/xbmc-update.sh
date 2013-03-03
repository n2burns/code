#!/bin/bash
curl --get "http://xbmc:xbmc@10.0.0.10:8080/xbmcCmds/xbmcHttp?command=ExecBuiltIn&parameter=XBMC.updatelibrary(video)" &
curl --get "http://xbmc:xbmc@10.0.0.10:8080/xbmcCmds/xbmcHttp?command=ExecBuiltIn&parameter=XBMC.updatelibrary(music)" &
