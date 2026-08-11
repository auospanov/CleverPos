Place CleverPos update zip here, e.g. CleverPos-latest.zip
Then bump AppUpdate:LatestVersion in appsettings / env (e.g. 1.4.1).
POS calls GET /api/updates/latest and downloads DownloadUrl.
