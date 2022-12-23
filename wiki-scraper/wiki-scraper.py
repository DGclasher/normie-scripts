import argparse, wikipedia

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-s","--search",dest="search", help="string to search")
    parser.add_argument("-t","--type",dest="type",help="type of search( summary / content / search)")
    parser.add_argument("-u","--url",action='store_true', help="Show the URL")
    options = parser.parse_args()
    if not options.search:
        parser.error("Missing -s/--search")
    if not options.type:
        parser.error("Missing -t/--type")

    return options


def search(options):
    try:
      
        if((options.type).lower() == "summary"):
            print(wikipedia.summary(options.search, redirect=True, auto_suggest=False))

        elif((options.type).lower() == "content"):
            response = wikipedia.page(options.search, auto_suggest=False, redirect=True)
            with open(options.search+'.txt','w') as f:
                f.write(response.content)
            print("Done!")

        elif((options.type).lower()=="search"):
            ls = wikipedia.search(options.search)
            for i in range(0, len(ls)):
                print(ls[i])
                
        if options.url:
            response = wikipedia.page(options.search, auto_suggest=False, redirect=True)
            print(response.url)

    except wikipedia.exceptions.PageError:
        print("Page not found")

search(get_args())