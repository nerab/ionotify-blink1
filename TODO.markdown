* Turn off the Blink1 when Control-C was pressed
* --verbose prints startup message and the status that was read
* --brightness from which all colors derive
* Use [rb-blink1](https://github.com/ngs/rb-blink1) and fall back to Tool
* Fail with error message if
  * blink1-tool is not available
  * file is not given
* Document how to have guard write a status file
* Get guard-file-notifier to write pending status (blue)
* Provide a color map so that people can provide their own colors per status
* Provide a content map so that peope can provide their mapping from content-match to color or pattern
* Mention an alternative version of this project using [wendy](http://git.z3bra.org/cgit.cgi/wendy/tree/README)
