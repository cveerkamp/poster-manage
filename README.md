# poster-manage
Allows for creation of a page on a public website that can be used to remotely update advertising posters

MIT licensed.

## Features

* Shows a slideshow of images based on a simple page on a public website.
* Automatically updates when used in conjunction with a cron job.
* Runs well on low-cost SBCs i.e. Raspberry Pi
* Written as a simple Linux shell script, so very distro independent

## Usage

### Hardware Requirements

Any Linux system should work, but this project was designed with a SBC in mind, specifically a Raspberry Pi 3B+

### Software Requirements

Install dependencies:

```
sudo apt-get update
sudo apt-get install fbi wget
```

Setup cron job i.e. to run every 15 minutes:

```
*/15 * * * * /root/poster-manage.sh >/dev/null 2>&1
```

## Website page

The script requires a publically accessible page to query updates for.  The page should be a plain-text file with an 
unique key on the first line of the file.  This key needs to change each time images are added/removed from the list 
of images to be shown.  There are no strict requirements as to what this identifier should be, however using a md5
hash is recommended, as multiple data points can be used to create a consistent string of alpha-numeric charaters.

Following the identifier, should come the list of images, with the full url to the image, one per line.

### Included examples

* template-poster-api.php - Basic Wordpress page template file that will generate the require format, with an identifier 
based on the page revision ID and the current date.
* simple-example.html - Simple HTML file that shows what the resulting webpage should look like

## Credits
* Originally designed for [The Strand Theatre of Shelbyville](http://strandpac.org)