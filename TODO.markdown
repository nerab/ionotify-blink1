* On startup, fade quickly through all statuses
* Capture Control-C no that no error is printed
* Turn off the Blink1 when shutting down
* `--verbose` prints
  - startup message
  - which files are watched
  - what file was updated
  - the status that was read from the current update
* `--brightness` as global limit from which all colors derive
* Fail with error message if
  * blink1-tool is not available
  * file is not given
* Document how to have guard write a status file
* Get guard-file-notifier to write pending status (blue)
* Provide a color map so that people can provide their own colors per status
* Provide a content map so that peope can provide their mapping from content-match to color or pattern
* Use [rb-blink1](https://github.com/ngs/rb-blink1) and fall back to Tool
* Mention an alternative version of this project using [wendy](http://git.z3bra.org/cgit.cgi/wendy/tree/README)
