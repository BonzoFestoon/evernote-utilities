# Evernote Back Up Automation

The evernote-backup.cmd script will automatically export each Evernote notebook into an individual archive file.  This script can be run manually or scheduled in the Windows Task Scheduler.

## Prerequisites

* Evernote
* [7-Zip][] or similar (if you want to compress the exported notebooks)

## Task Scheduler 

Below are the settings I used to create a scheduled task that will do a full backup of my Evernote notebooks every day at 1800.

<details>
	<summary>General Tab Screen Shot</summary>

![Task Scheduler - General Tab][img-task-general]

</details>

<details>
	<summary>Triggers Tab Screen Shot</summary>

![Task Scheduler - Triggers Tab][img-task-triggers]

</details>

<details>
	<summary>Action Tab Screen Shot</summary>

![Task Scheduler - Action Tab][img-task-action]

</details>

<details>
	<summary>Settings Tab Screen Shot</summary>

![Task Scheduler - Settings Tab][img-task-settings]

</details>




[7-Zip]:	http://7-zip.org/download.html 	"7-Zip Download"


[img-task-general]: 	img/task-scheduler-general.png  	"Task Scheduler - General Tab"
[img-task-triggers]: 	img/task-scheduler-triggers.png  	"Task Scheduler - Triggers Tab"
[img-task-action]: 		img/task-scheduler-action.png  		"Task Scheduler - Action Tab"
[img-task-settings]: 	img/task-scheduler-settings.png  	"Task Scheduler - Settings Tab"