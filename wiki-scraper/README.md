# Wiki Scraper

Download the script
```
wget https://github.com/DGclasher/normie-scripts/raw/main/wiki-scraper/wiki-scraper.py
```

Install the required modules
```
pip install argparse wikipedia
```

Run the script
```
python wiki-scraper.py [ARGUMENTS]
```
```
Arguments

-h/--help		Show help message

-s/--search		Search string

-t/--type		Type of content
				summary : Summary of searched string
				content : Full content of searched string
				search  : Search related keywords

-u/--url		Show the URL to wiki page
```
Example
```
python wiki-scraper.py -s "artificial intelligence" -t summary -u
```
