import requests, os, tqdm, time, argparse

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-q","--query",dest="query",help="Query to be searched for")
    parser.add_argument("-c","--count",dest="count",help="Number of images")

    options = parser.parse_args()
    if not options.query:
        parser.error("\nMissing -q/--query")
    if not options.count:
        parser.error("\nMissing -c/--count")

    return options

def make_check_dir(options):
    current_dir = os.getcwd()
    save_dir = options.query

    if not os.path.exists(save_dir):
        os.mkdir(save_dir)
    dirs = os.listdir(save_dir)
    if len(dirs) == 0:
        num=1
    else:
        num=int(dirs[0][0])
    for i in range(0, len(dirs)):
        if dirs[i].startswith(f"{num}"):
            num+=1
    return num,options

def download_image(num, options):

    urls = [("https://unsplash.com/napi/search/photos?query="+options.query+"&per_page=20&page="+str(x)+"&xp") for x in range(1,int(options.count)+1)]

    for url in tqdm.tqdm(urls):
        response = requests.get(url)
        json = response.json()
        image_url = json['results'][0]['urls']['raw']

        with open(options.query+'/'+str(num)+'.jpg', 'wb') as f:
            r=requests.get(image_url, stream=True)
            f.write(r.content)
        num+=1
        time.sleep(1)
    
download_image(*make_check_dir(get_args()))